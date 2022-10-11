Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FB35FB9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJKRxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJKRxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:53:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E762750732
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:53:04 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e717329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e717:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90C1A1EC058B;
        Tue, 11 Oct 2022 19:52:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665510777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lVDxe058kpxlrzykwvqrfZwiu60slAKOvao+6Jtrv3w=;
        b=Cg31XfBP7KgZQjI/zLOwmgr61/9zIOeP4fqTlOz/Z2Rre2n7qcq3MTaj7aNtYavh+CcBn4
        e8F7b3ob5U+6bEmS4Mh4ldYCHbte7FQRSxqwgqWt3ZL+XlIGxic/wgMnR4QlDhSZv6XBv8
        g5QwYIOZ4ic9nRRVjtwCI99FhayA/VY=
Date:   Tue, 11 Oct 2022 19:52:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Daniel Verkamp <dverkamp@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH] x86: also disable FSRM if ERMS is disabled
Message-ID: <Y0WtdarNtdIXCuhC@zn.tnic>
References: <20220923005827.1533380-1-dverkamp@chromium.org>
 <Yy2U2BW6Tx0imGpK@zn.tnic>
 <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
 <Yy3yJfz213Lqo4KC@zn.tnic>
 <CABVzXAkO4pU+gpUcWOEWDw+W4id=1WEOgeP5+3tBG_LR6=oa=g@mail.gmail.com>
 <Y0VTS9qTF/GaMihP@zn.tnic>
 <SJ1PR11MB6083203F6D6EFF8E562A2593FC239@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083203F6D6EFF8E562A2593FC239@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 05:09:19PM +0000, Luck, Tony wrote:
> >> The Intel SDM says: "Software can disable fast-string operation by
> >> clearing the fast-string-enable bit (bit 0) of IA32_MISC_ENABLE MSR",
> >> so it's not an invalid configuration for this bit to be unset.
> >
> > Dunno, did Intel folks think about clearing the respective CPUID bits
> > when exposing IA32_MISC_ENABLE[0] to software? Tony?
> 
> I don't know if it was thought about. Experimentally clearing bit
> 0 of IA32_MISC_ENABLE does not affect the CPUID bit settings
> for either ERMS or FSRM (on the one system I tried that supports
> both of these bits).

Confirms my observation on a Coffeelake here too.

Oh well, probably not that important. I mean, I bet luserspace is
looking at those CPUID bits - glibc probably - and then probably selects
the proper memcpy or so routine, based on what's there.

If something clears MSR_IA32_MISC_ENABLE_FAST_STRING_BIT and we go and
clear our feature flags and luserspace still queries CPUID then oh well,
it'll be fun. It all depends on why something has cleared them tho. It
could be some performance thing or something a lot more funky. I guess
if stuff starts exploding left and right, there will soon be a microcode
patch after that. :-)

Might be prudent to check with hw folks just in case...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
