Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640346C6429
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCWJ4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjCWJz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:55:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E10D36080
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:54:05 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D87591EC0716;
        Thu, 23 Mar 2023 10:54:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679565242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nHvjhzemG6XYPr52d6/om67Svr/zToy+fgDpNSjq//Q=;
        b=HyBg9zOEjyRPNIX4IDYkkz8U9Uqm3OkEnh1HbvKml0hH7xS2+Fs8VJrc194iJTs0pDrNVN
        hLhJPhPdz+5GAmwVWyUESftcmOg3ae5pxGEJ/JtbMytCdGoZI5ocblJ61mc+nGOJVTfoZr
        z9SAOmmGiYqafFynAgHYW7oXkop0TuI=
Date:   Thu, 23 Mar 2023 10:53:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/sev: Get rid of special sev_es_enable_key
Message-ID: <20230323095358.GBZBwhthMrWyqP4yXH@fat_crate.local>
References: <20230318115634.9392-1-bp@alien8.de>
 <20230318115634.9392-3-bp@alien8.de>
 <87edpf9690.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87edpf9690.ffs@tglx>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 10:17:15AM +0100, Thomas Gleixner wrote:
> That's not sufficient. This function invokes static functions which the
> compiler can rightfully put out of line resulting in a noinstr violation.

Right, as mentioned on IRC, if we're going to use the cc_platform_has()
thing to do simple arch-agnostic confidential guests checks, perhaps we
should make it and the underlying functions it calls simply
__always_inline so that the compiler can optimize stuff even more and
not have function calls for such simple tests...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
