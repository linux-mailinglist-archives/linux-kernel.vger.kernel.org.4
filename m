Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF0560F6FD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiJ0MSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiJ0MSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:18:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0212DE071A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:18:10 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7cb329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7cb:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B66F1EC0426;
        Thu, 27 Oct 2022 14:18:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666873088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WquI/8NSd14rVXUzGFlNJMA6t1lxckM7GaSPLgAhaPs=;
        b=CPsGQc/egPKz0SwpUVtl3T2rU39ipDsV8KcRCN4n05gL1W57J0pao4V9vBin4T4cKvNWGB
        hS7Ldfmop1kJ8aWPS0cuX95CzAYY7nF6pugsLax5wdbcVtCa+rTntZHV9OZTeAlqLPJ95y
        i56xrrrAjBYE8QYGkg+Oxn20mc/Q8+k=
Date:   Thu, 27 Oct 2022 14:18:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 11/16] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
Message-ID: <Y1p2+4W+tydH4peD@zn.tnic>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-12-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221004081023.32402-12-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:10:18AM +0200, Juergen Gross wrote:
> diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
> index 49b60a427fc9..330aa412be63 100644
> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> @@ -1137,3 +1137,10 @@ void cache_cpu_init(void)
>  	cache_enable();
>  	local_irq_restore(flags);
>  }
> +
> +bool cache_aps_delayed_init;

Why isn't that static and only the accessors set it or clear it?

> +void set_cache_aps_delayed_init(void)
> +{
> +	cache_aps_delayed_init = true;
> +}

Otherwise, there's no point for this thing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
