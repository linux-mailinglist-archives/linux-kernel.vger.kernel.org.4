Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D4A6C2F07
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCUKcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCUKca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:32:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E308D274B7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:31:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679394678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hv1HqQxsWac7KSmwPukBsbS8Rr7ur6VoezJ6IcOtMtU=;
        b=Yrf+FTaSswbkl17hEKoLtoIuiQvFVEub1dw18V7t9ylegaHDm457FMKKvhvHPHeuev0X5U
        SyAyBXS/MK5jqC4rgimhZCtfXBZPu0eIJpKhziGyIjL0BI+Uzy75LZSd2t/ur6OZza1NR5
        iP7suXsgwe2aeqiRTbm6cK8u/NhkXPYIWFXZHTsAk2N+NwwOIx4CN+kSdmyl29DcTOKKOM
        DrRAUa0hrcpOY+6HCrJ6J/xxk2x0FEF/3WjguAh6QwFvulDTo2VdC3+J75aSJzhDFZUMpA
        IvKH14XmwTaBpMXqAv/afORi5uCc1CqZG5ju6LSuEORC7EEmOtPXvdbHRCiFEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679394678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hv1HqQxsWac7KSmwPukBsbS8Rr7ur6VoezJ6IcOtMtU=;
        b=UrTV7y5LROn1MI1UeQdC6MNlcakGa5yjbXsEh7shgouCOYCCfsDS4HVgbF3Xs3UaikkIJ2
        zRdE4ayAA2nqrQBA==
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v3 4/8] x86/psp: Add IRQ support
In-Reply-To: <20230320191956.1354602-5-jpiotrowski@linux.microsoft.com>
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230320191956.1354602-5-jpiotrowski@linux.microsoft.com>
Date:   Tue, 21 Mar 2023 11:31:18 +0100
Message-ID: <87h6ue9z0p.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20 2023 at 19:19, Jeremi Piotrowski wrote:
> The ACPI PSP device provides a mailbox irq that needs to be configured
> through the ACPI mailbox register first. This requires passing a CPU
> vector and physical CPU id and then enabling interrupt delivery.
> Allocate the irq directly from the default irq domain
> (x86_vector_domain) to get access to the required information. By
> passing a cpumask through irq_alloc_info the vector is immediately
> allocated (and not later during activation) and can be retrieved.

Sorry, but this is a horrible hack which violates _all_ design rules
for interrupts in one go.

 1) What's so special about this PSP device that it requires a vector
    directly from the vector domain and evades interrupt remapping?

 2) Why is this interrupt enabled _before_ it is actually requested?

 3) Why is this interrupt required to be bound to CPU0 and still exposes
    a disfunctional and broken affinity setter interface in /proc?

There is absolutely zero reason and justification to fiddle in the guts
of the x86 vector configuration data just because it's possible.

This is clearly a custom MSI implementation and the obvious solution is
a per device MSI interrupt domain.

Thanks,

        tglx


