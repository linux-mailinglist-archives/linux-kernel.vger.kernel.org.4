Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C549263F3CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiLAP2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLAP2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:28:34 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F588A7A97
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 07:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669908513; x=1701444513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8eDwBDESw/gPbMuGOrqIjfdT/B1sRstTWnlMgk4CnK0=;
  b=jb529CWrtHFhbPD5Y1L7rek9tL8DqqSV0nGltlyByosB0nqWoHyHucJV
   Dt2gHrKTTQ5h04+KbrWNadqEbqd2d+I1EUrLEPbSITRbr0ni/nJZosXJ3
   Ozp2n0Y4doPvS+sp9W/NP8WibXpXzN8bYnjeCsYHbkXTNhIOzYoChKTBn
   MGokukmZloLSl02qFo/IW1ZTMuCVaG00nnSPKrW95L7ySCen/Z8A/NbQ8
   xbfhASUJDLEY9LxIDpt8Cwe0S21G7Vmkl6qEBL+16UCsBj0nEucBP51Rd
   QUoNAkoy/fMzQmpVU1hiIhXuSxPUhU9rhM0fMh61kQioDq6yT+2RldAva
   g==;
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="186083997"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Dec 2022 08:28:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Dec 2022 08:28:31 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 1 Dec 2022 08:28:29 -0700
Date:   Thu, 1 Dec 2022 15:28:10 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Song Shuai <suagrfillet@gmail.com>
CC:     <guoren@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <apatel@ventanamicro.com>, <atishp@atishpatra.org>,
        <heiko@sntech.de>, <anshuman.khandual@arm.com>,
        <liaochang1@huawei.com>, <juerg.haefliger@canonical.com>,
        <wangkefeng.wang@huawei.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] riscv : select
 FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Message-ID: <Y4jICn5oxLozsv6m@wendy>
References: <20221201151336.8044-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221201151336.8044-1-suagrfillet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 11:13:36PM +0800, Song Shuai wrote:
> In RISC-V, -fpatchable-function-entry option is used to support
> dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
> PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
> don't have to be called to create the __mcount_loc section before
> the vmlinux linking.
> 
> Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
> Makefile not to run recordmcount.
> 
> Link_v1: https://lore.kernel.org/linux-riscv/CAAYs2=j3Eak9vU6xbAw0zPuoh00rh8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
> Link_v2: https://lore.kernel.org/linux-riscv/CAAYs2=iYn8sLQB8oh+RzTKd2VKs8MXOLX6Mwpamx5gdVVN6mkA@mail.gmail.com/T/#m62138d7a76664798d00051818a438a601eff4cf1

Hey Song Shuai,

For future patches, please use normal "Link:" tags. If you're just
linking to prior versions of the patch, just put them below the ---
line so they don't end up in the git history.

Please don't resend for this alone :)

Thanks,
Conor.

> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> Tested-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 572973103d73..c19cddb8feb9 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -277,6 +277,7 @@ config ARCH_RV64I
>  	select 64BIT
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>  	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
> +	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	select HAVE_SAMPLE_FTRACE_DIRECT
> -- 
> 2.20.1
> 
