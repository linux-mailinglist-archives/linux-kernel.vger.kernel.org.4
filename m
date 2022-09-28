Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6080F5EDBA9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiI1LXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiI1LXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:23:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A9CDDD8D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:23:00 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ee329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ee:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 163261EC059D;
        Wed, 28 Sep 2022 13:22:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664364175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=H37L9qeZmmgh4Ob+dcO4c+wKevaFARZE41KleCoIqh0=;
        b=Upn/lR31WevfgW+y3+vXEVtSERdEAVv/TI3lRbXaQBdP4yBNc507x/E5NXBTUD1mwJTAbQ
        6zfe5r3uYXbWUJqZJiPVDGL5Dvj5kw89TVpkzyfSUWsk/fehuAYYHghSVpYZf/aLwUyx4E
        9zruyDj1Sf7rvxpqHONY003jfJTdkpM=
Date:   Wed, 28 Sep 2022 13:22:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
Message-ID: <YzQui+rOGrM6otzp@zn.tnic>
References: <c0872933-e046-0c5e-b63f-861d2d343794@suse.com>
 <YzLcSOS6ZLIoPwBl@zn.tnic>
 <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com>
 <YzLo9IFDYW1T8BVZ@zn.tnic>
 <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com>
 <YzOEYsqM0UEsiFuS@zn.tnic>
 <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
 <24088a15-50a1-f818-8c3e-6010925bffbf@suse.com>
 <YzQmeh50ne8dyR2P@zn.tnic>
 <f8da6988-afa3-1e85-b47d-d91fc4113803@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8da6988-afa3-1e85-b47d-d91fc4113803@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 01:14:11PM +0200, Juergen Gross wrote:
> No, we don't.
> 
> Using basically your patch, but with
> 
> +	mtrr_online = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +						"x86/mtrr:online",
> +						mtrr_ap_init, NULL);
> 
> moved to the end of mtrr_aps_init(), and:
> 
> +void mtrr_aps_thaw(void)
> +{
> +	cpuhp_remove_state_nocalls(mtrr_online);
> +}

Yes, so you said. I'm not sure I like this toggling of notifier
registration like that.

Optimally, I'd like to be able to query the suspend code whether it is
in the process of resuming.

This here:


static int resume_target_kernel(bool platform_mode)
{

...

 Enable_irqs:
        system_state = SYSTEM_RUNNING;
        local_irq_enable();
 
 Enable_cpus:
        pm_sleep_enable_secondary_cpus();


but being able to do:

        pm_sleep_enable_secondary_cpus();
	system_state = SYSTEM_RUNNING | SYSTEM_RUNNING_APS_UP;

which can't work, obviously. But something like that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
