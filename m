Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8B55FBC87
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJKU4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJKU4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:56:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93E158DEB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:56:47 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e717329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e717:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 30ACE1EC0622;
        Tue, 11 Oct 2022 22:56:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665521802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8I3JB5GZnhoZdp+LTW+Z0phiPDvz7bvBCW4sFoywZeQ=;
        b=jf9d4VRUZtL4qIkgQU5isa7Onc+EerT1jFatqI0DsL453pymgvgPQ+MyXA2GNKzPN9UH19
        dS7zxVkTGCsNyiVff88rEUV05Z0aTZH8e6dN5GPQ+W2NH8t0E8sFcbJW4Kg/6WnkPeM5Tr
        CguDX3b+sE9vQ0fjmNydSphEg2UC6p8=
Date:   Tue, 11 Oct 2022 22:56:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Daniel Verkamp <dverkamp@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH] x86: also disable FSRM if ERMS is disabled
Message-ID: <Y0XYhftUTqd2BDHn@zn.tnic>
References: <20220923005827.1533380-1-dverkamp@chromium.org>
 <Yy2U2BW6Tx0imGpK@zn.tnic>
 <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
 <Yy3yJfz213Lqo4KC@zn.tnic>
 <CABVzXAkO4pU+gpUcWOEWDw+W4id=1WEOgeP5+3tBG_LR6=oa=g@mail.gmail.com>
 <Y0VTS9qTF/GaMihP@zn.tnic>
 <SJ1PR11MB6083203F6D6EFF8E562A2593FC239@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y0WtdarNtdIXCuhC@zn.tnic>
 <SJ1PR11MB608345C36F1D52B8185E46E1FC239@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608345C36F1D52B8185E46E1FC239@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 07:08:51PM +0000, Luck, Tony wrote:
> I don't think Intel will deliberately release a CPU that has FSRM=1, ERMS=0.

Sure, but I don't mean that. Rather: if for some reason the kernel or
BIOS is supposed to fix an erratum related to those enhanced REP moving
routines and goes and clears the MSR bit.

That won't help because userspace will still use them since the CPUID
flags remain set.

I guess such a case is probably not going to happen in real life but if
it happened, that bit clearing is kinda useless.

I'd say.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
