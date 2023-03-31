Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B3A6D1883
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCaHWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjCaHWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:22:43 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED681A464;
        Fri, 31 Mar 2023 00:22:39 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32V6OcCp016236;
        Fri, 31 Mar 2023 09:22:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=bP/5RW3i6naWflHN3PftdHEk430wto9gy+Tuw6UIrio=;
 b=qaGyz4XNS/l5Qe6GoGQbFAE0R5bGZi0+Eyn9C9/O1Ftq2VqkQwlTEcytiBQnpbRIedkf
 CELUpP45dcYZQ4WHmQLw5V01yYZ1kPVzNkLJd9uz9H8GSuxs5vpdbs2ZAN3Y1qgjyl+o
 85sZNXOfCYmqgnCwX/FywuHGwvRar8ytGjYTjCreJsa2iv5zuEWyvlN+Nq2kZ2ZRTlVy
 2fobL1uwzw+yjqvhOs43ySNDqvKdWHGOgwHXsTr++Z+oXvh1G7OykLgaYtHbFVZtokty
 NUAm17MMhnJzcTnL+YZltcqbpSRJhFRvC2Da8IQF8o1HwjkqMsjhP+nw1ZBAZeZu7sDD /Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pkwvsw30k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 09:22:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0DD5510002A;
        Fri, 31 Mar 2023 09:22:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 074162115F8;
        Fri, 31 Mar 2023 09:22:29 +0200 (CEST)
Received: from [10.201.21.26] (10.201.21.26) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 31 Mar
 2023 09:22:28 +0200
Message-ID: <7b9864d9-dc36-f719-29ea-21036763c375@foss.st.com>
Date:   Fri, 31 Mar 2023 09:22:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] reset: sti: simplify driver's config and build
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230330112347.31137-1-lukas.bulwahn@gmail.com>
 <20230330112347.31137-2-lukas.bulwahn@gmail.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230330112347.31137-2-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.26]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_02,2023-03-30_04,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/23 13:23, Lukas Bulwahn wrote:
> With commit 64933513e461 ("reset: sti: Remove STiH415/6 reset support"),
> there is only one sti reset driver left and there no need to define a
> dedicated config STI_RESET_SYSCFG, which is selected by the config for the
> STiH407 reset driver.
> 
> Simply add reset-syscfg.c to the build for the STiH407 reset driver.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/reset/sti/Kconfig  | 4 ----
>  drivers/reset/sti/Makefile | 4 +---
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/reset/sti/Kconfig b/drivers/reset/sti/Kconfig
> index 9455e1c7a5aa..a2622e146b8b 100644
> --- a/drivers/reset/sti/Kconfig
> +++ b/drivers/reset/sti/Kconfig
> @@ -1,11 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  if ARCH_STI
>  
> -config STI_RESET_SYSCFG
> -	bool
> -
>  config STIH407_RESET
>  	bool
> -	select STI_RESET_SYSCFG
>  
>  endif
> diff --git a/drivers/reset/sti/Makefile b/drivers/reset/sti/Makefile
> index 3eb30f7e8e3d..5e833496cee3 100644
> --- a/drivers/reset/sti/Makefile
> +++ b/drivers/reset/sti/Makefile
> @@ -1,4 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_STI_RESET_SYSCFG) += reset-syscfg.o
> -
> -obj-$(CONFIG_STIH407_RESET) += reset-stih407.o
> +obj-$(CONFIG_STIH407_RESET) += reset-stih407.o reset-syscfg.o

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
