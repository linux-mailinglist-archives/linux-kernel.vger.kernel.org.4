Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE5B6C2356
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCTVDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCTVDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:03:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C7213F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:03:08 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB82B1EC0531;
        Mon, 20 Mar 2023 22:03:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679346186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HuqmGg6pacOsGpnfdNt+sazlRFphD6d4Ro3u+1HzFT4=;
        b=rBb1YlghZ8TPUwG7JQGgOjxjnixx2gNYwSQHUyrcDDsqkHrPeJUc7Oj6/aYuYAOkUHo6pb
        fwWwRIuzttZqz3OYE977Ng3pd7/d0PWmjON/6S/5kbI4SgnWAdagFNsEmc282He9YJz/W1
        7ZrNZzoPmhDrTldoTeBcuwW89xMXiHc=
Date:   Mon, 20 Mar 2023 22:03:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v3 3/8] x86/psp: Register PSP platform device when ASP
 table is present
Message-ID: <20230320210302.GEZBjKBj+5CLCm1+Tl@fat_crate.local>
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230320191956.1354602-4-jpiotrowski@linux.microsoft.com>
 <20230320192504.GCZBizEGDjVtGWpNP3@fat_crate.local>
 <6d3d512b-55e9-8205-461c-02f1e71f2b63@linux.microsoft.com>
 <20230320200321.GDZBi8CXCyE6kD7qSN@fat_crate.local>
 <9b86ac2a-4ef9-1e98-ae5d-94b2655fbe6f@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b86ac2a-4ef9-1e98-ae5d-94b2655fbe6f@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 09:18:19PM +0100, Jeremi Piotrowski wrote:
> I agree with you here. The irq config of this thing requires specifying
> passing a CPU vector, this follows the hardware spec which I linked in the
> first 2 commits, pages 13-15 here:

You mean the interrupt vector in table 19?

> https://www.amd.com/system/files/TechDocs/58028_1.00-PUB.pdf
> 
> The only way I found to get this to work was going through x86_vector_domain
> or statically defining a system vector (the latter felt worse).

Hmm. Why is that thing special and can't use devm_request_irq() like the
rest of the drivers out there?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
