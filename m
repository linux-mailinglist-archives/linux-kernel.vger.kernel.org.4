Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9205EBF52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiI0KLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiI0KLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:11:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0951BA4071
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:11:00 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e757329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e757:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D02F1EC058A;
        Tue, 27 Sep 2022 12:10:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664273455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/v55aZP64ds0qEf5pSfgJzfEvm/TVqPTvdeXcoCxATk=;
        b=qu2RiuVPERrby2mkgKedt4K0HJeWBVi/JHFjJNAc5f+jUrlxgvuAiF6WYpcagYOuPbVCMF
        yiIBLQZBX+B6DyPwmygD2M5WJVllVwddXLfF7Dz96FohO12c8NyLokHpoJ/UfW5B2+DrC+
        +4LvUK6UoVRNkuc1YZU1iTArutJgUa8=
Date:   Tue, 27 Sep 2022 12:10:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
Message-ID: <YzLMKk4OK9FtjjKQ@zn.tnic>
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-9-jgross@suse.com>
 <YzIVfj/lvzQrK15Y@zn.tnic>
 <ce8cb1d3-a7d2-7484-26eb-60d3e29fa369@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce8cb1d3-a7d2-7484-26eb-60d3e29fa369@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:57:37AM +0200, Juergen Gross wrote:
> TBH I don't see the point of having an accessor which is just setting a
> variable to "true". But if you like it better, I can keep it.

Accessors are always better, no matter how silly. :)

But, in trying to grok your next patch - you really should split those
more complex ones because they're a pain to review - I'm starting to
wonder whether we could even remove mtrr_aps_delayed_init and make the
delayed init the default.

Because, AFAICT, set_mtrr_aps_delayed_init() is called by default
by native_smp_prepare_cpus(). Which is called by hyperv and
arch/x86/xen/smp_hvm.c.

The only one that's not calling it is arch/x86/xen/smp_pv.c but that
thing doesn't support MTRRs in the first place, right?

Which means, it doesn't need delayed MTRR init anyway.

Which would then mean that this would simplify this ugly logic even more.

Or am I missing an angle?

It is possible in this nuts code.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
