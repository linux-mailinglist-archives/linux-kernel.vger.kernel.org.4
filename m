Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC2C6949FA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjBMPDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjBMPD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:03:28 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B091D40D2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:03:13 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B7CA01EC084F;
        Mon, 13 Feb 2023 16:03:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676300591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=G2XLsILWuLy0mObeCRY84pwqfNezNiWo75dnx0uGFOY=;
        b=mKnxelfkHZ13ppOB3Qg1an0qR+KAky4w2Y9c46raajPa/jRtN1PgeRSIbwi8Qha1mO/Ncz
        rLKbnvsX+IKkq8fxe2tPX4r8288Oou/2h0Tthm+I6wLC6qNZTjwjbDujwVwiBQCzDVbi3H
        mIHI2fkjAseXiXGrfHSx+2xB/r8EiQ4=
Date:   Mon, 13 Feb 2023 16:03:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Message-ID: <Y+pRK6a419jenR9R@zn.tnic>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com>
 <Y+ohfE/wICFKO/93@zn.tnic>
 <6257114d-a957-f586-145c-d2a885417360@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6257114d-a957-f586-145c-d2a885417360@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 03:07:07PM +0100, Juergen Gross wrote:
> Fixed in the sense of static.

Well, you can't use "fixed" to say "static" when former means something
very specific already in MTRR land.

> Wouldn't !cpu_feature_enabled(X86_FEATURE_HYPERVISOR) be enough?
> 
> I'm not sure we won't need that for TDX guests, too.

See, that's the problem. I wanna have it simple too. Lemme check with
dhansen.

> Yes, it is only relevant for PV dom0.

Right, I was asking whether "PV dom0" == X86_FEATURE_XENPV?

:)

> The number of fixed MTRRs is not dynamic AFAIK.

But nothing guarantees that the caller would pass an array "mtrr_type
*fixed" of size MTRR_NUM_FIXED_RANGES, right?

> A single interface makes it easier to avoid multiple calls.
> 
> In the end I'm fine with either way.

Yeah, I know. Question is, how much of this functionality will be
needed/used so that we can go all out on the interface design or we can
do a single one and forget about it...

> > Can Xen use x86_hyper_type() too?
> 
> It does.

Then pls add a x86_hyper_type check too to make sure a potential move of
this call is caught in the future.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
