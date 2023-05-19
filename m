Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86976709604
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjESLOh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 May 2023 07:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjESLOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:14:35 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BB019F
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:14:29 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id F0AC97FFB;
        Fri, 19 May 2023 19:14:27 +0800 (CST)
Received: from EXMBX065.cuchost.com (172.16.6.65) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 19 May
 2023 19:14:27 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX065.cuchost.com
 (172.16.6.65) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 19 May
 2023 19:14:27 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Fri, 19 May 2023 19:14:27 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Song Shuai <suagrfillet@gmail.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        "ajones@ventanamicro.com" <ajones@ventanamicro.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Song Shuai <songshuaishuai@tinylab.org>
Subject: RE: [PATCH] riscv: hibernation: Remove duplicate call of
 suspend_restore_csrs
Thread-Topic: [PATCH] riscv: hibernation: Remove duplicate call of
 suspend_restore_csrs
Thread-Index: AQHZij0JnSRR82RN7UivChxgOm4HvK9hcVtQ
Date:   Fri, 19 May 2023 11:14:27 +0000
Message-ID: <9a274a44b61345e8aba747a44250c4d8@EXMBX066.cuchost.com>
References: <20230519102908.253458-1-suagrfillet@gmail.com>
In-Reply-To: <20230519102908.253458-1-suagrfillet@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.16.6.8]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

looks good to me.

Thanks
Regards
Jee Heng

> -----Original Message-----
> From: Song Shuai <suagrfillet@gmail.com>
> Sent: Friday, May 19, 2023 6:29 PM
> To: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; suagrfillet@gmail.com; Mason Huo
> <mason.huo@starfivetech.com>; Leyfoon Tan <leyfoon.tan@starfivetech.com>; ajones@ventanamicro.com; JeeHeng Sia
> <jeeheng.sia@starfivetech.com>
> Cc: linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Song Shuai <songshuaishuai@tinylab.org>
> Subject: [PATCH] riscv: hibernation: Remove duplicate call of suspend_restore_csrs
> 
> The suspend_restore_csrs is called in both __hibernate_cpu_resume
> and the `else` of subsequent swsusp_arch_suspend.
> 
> Removing the first call makes both suspend_{save,restore}_csrs
> left in swsusp_arch_suspend for clean code.
> 
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
>  arch/riscv/kernel/hibernate-asm.S | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/hibernate-asm.S b/arch/riscv/kernel/hibernate-asm.S
> index 5c76671c7e15..d698dd7df637 100644
> --- a/arch/riscv/kernel/hibernate-asm.S
> +++ b/arch/riscv/kernel/hibernate-asm.S
> @@ -28,7 +28,6 @@ ENTRY(__hibernate_cpu_resume)
> 
>  	REG_L	a0, hibernate_cpu_context
> 
> -	suspend_restore_csrs
>  	suspend_restore_regs
Good catch. This function is invoked twice to restore the CSRs. I am good with removing this function from here.
> 
>  	/* Return zero value. */
> --
> 2.20.1

