Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619F35EB04D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiIZSmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiIZSlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:41:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74270F4B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:40:46 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e74d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e74d:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B1511EC059D;
        Mon, 26 Sep 2022 20:40:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664217640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UV5G03i0J4ZmYbbzPbEHCNnZgOVKlnCjwA4cScXyt1s=;
        b=CBzVjLPvs9Eewc7z3KLHoPORsEoDeJAqHqS/Kz75vg3KYyXNHMSTOMzaMeXc8RciECdqhh
        m7Ew6CupPbe/0o5sFSxIJUobbHC2pcffJ9X6idC0Md8NPm1QQ+VncGgDjYll43QHZBJ6DU
        doPafGRxQGkmnWuTGfFYcedmwt0iBQ0=
Date:   Mon, 26 Sep 2022 20:40:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 07/10] x86/mtrr: simplify mtrr_bp_init()
Message-ID: <YzHyIrUoLWwKrpxo@zn.tnic>
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-8-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220908084914.21703-8-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 10:49:11AM +0200, Juergen Gross wrote:
> diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
> index 9609a0d235f8..956838bb4481 100644
> --- a/arch/x86/kernel/cpu/mtrr/mtrr.c
> +++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
> @@ -761,13 +761,10 @@ void __init mtrr_bp_init(void)
>  			mtrr_enabled = get_mtrr_state();
>  
>  			if (mtrr_enabled) {
> -				mtrr_bp_pat_init();
>  				cache_generic |= CACHE_GENERIC_MTRR |
>  						 CACHE_GENERIC_PAT;
> -			}
> -
> -			if (mtrr_cleanup(phys_addr)) {
> -				changed_by_mtrr_cleanup = 1;
> +				changed_by_mtrr_cleanup =
> +					mtrr_cleanup(phys_addr);

Just let those lines stick out.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
