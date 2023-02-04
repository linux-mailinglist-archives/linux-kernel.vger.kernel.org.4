Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA4068AA53
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 14:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjBDNpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 08:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjBDNpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 08:45:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E21206B4;
        Sat,  4 Feb 2023 05:45:03 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A4DD71EC06C0;
        Sat,  4 Feb 2023 14:45:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675518301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EpYaQjX7l2yY8w86H3eHS5+rQ43naFp29YMcKhsM2ds=;
        b=RdvOxbM9Dt12QRKP1fyud4ytknv9qeAqjlacryu0vlZHg+RjUu3v8ut+DFrAA8LTFUHkdb
        gITDCdzkdmhfRrepGEhJDAWoqe/j1Hu+hwmzpgd4uJtaXYDvUOgLvdbvy4eH1KcU7kb8Tq
        1JZ1hZ7IR8BoGGu+GGEPSFnpvZlUl5I=
Date:   Sat, 4 Feb 2023 14:44:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     silviazhao-oc <silviazhao-oc@zhaoxin.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        cobechen@zhaoxin.com, louisqi@zhaoxin.com, silviazhao@zhaoxin.com,
        tonywwang@zhaoxin.com, kevinbrace@gmx.com,
        8vvbbqzo567a@nospam.xutrox.com
Subject: Re: [PATCH] x86/perf/zhaoxin: Add stepping check for ZX-C
Message-ID: <Y95hWVFyw7TM1WSB@zn.tnic>
References: <20230202091738.5947-1-silviazhao-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230202091738.5947-1-silviazhao-oc@zhaoxin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 05:17:38PM +0800, silviazhao-oc wrote:
> Nano processor may not fully support rdpmc instruction, it works well
> for reading general pmc counter, but will lead GP(general protection)
> when accessing fixed pmc counter. Furthermore, family/mode information
> is same between Nano processor and ZX-C processor, it leads to zhaoxin
> pmu driver is wrongly loaded for Nano processor, which resulting boot
> kernal fail.
> 
> To solve this problem, stepping information will be checked to distinguish
> between Nano processor and ZX-C processor.
> 
> Fixes: 3a4ac121c2ca (“x86/perf: Add hardware performance events support for Zhaoxin CPU”)
> Reported-by: Arjan <8vvbbqzo567a@nospam.xutrox.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=212389
> Reported-by: Kevin Brace <kevinbrace@gmx.com>
> 
> Signed-off-by: silviazhao-oc <silviazhao-oc@zhaoxin.com>

Please use your proper name in the Signed-off-by.

> ---
>  arch/x86/events/zhaoxin/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
> index 949d845c922b..cef1de251613 100644
> --- a/arch/x86/events/zhaoxin/core.c
> +++ b/arch/x86/events/zhaoxin/core.c
> @@ -541,7 +541,8 @@ __init int zhaoxin_pmu_init(void)
>  
>  	switch (boot_cpu_data.x86) {
>  	case 0x06:
> -		if (boot_cpu_data.x86_model == 0x0f || boot_cpu_data.x86_model == 0x19) {
> +		if ((boot_cpu_data.x86_model == 0x0f && boot_cpu_data.x86_stepping >= 0x0e) ||
> +			boot_cpu_data.x86_model == 0x19) {
>  
>  			x86_pmu.max_period = x86_pmu.cntval_mask >> 1;

Last time we talked:

https://lore.kernel.org/r/3c7da7fd-402f-c74f-c96c-0e88828eab58@zhaoxin.com

you said that Nano #GPs when trying to RDPMC the fixed counters. Which
sounds like an erratum.

We do those by adding a X86_BUG flag, set that flag for Nano and then
test it where needed. Grep the source tree for examples.

Please do that above too unstead of testing steppings.

Also, I'd like to know why do steppings < 0xe mean Nano and why isn't
there a more reliable way to detect it?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
