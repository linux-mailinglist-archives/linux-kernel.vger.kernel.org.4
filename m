Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DBB676610
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjAULdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAULdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:33:37 -0500
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F72C32536
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 03:33:34 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id JC7npf6vrobXwJC7np5qZQ; Sat, 21 Jan 2023 12:33:32 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Jan 2023 12:33:32 +0100
X-ME-IP: 86.243.2.178
Message-ID: <9956151e-d678-646f-b82e-fcf98ad25a1f@wanadoo.fr>
Date:   Sat, 21 Jan 2023 12:33:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/4] soc: qcom: socinfo: move SMEM item struct and defines
 to a header
Content-Language: fr
To:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230121112947.53433-1-robimarko@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230121112947.53433-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/01/2023 à 12:29, Robert Marko a écrit :
> Move SMEM item struct and related defines to a header in order to be able
> to reuse them in the Qualcomm NVMEM CPUFreq driver instead of duplicating
> them.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>   drivers/soc/qcom/socinfo.c       | 65 +-----------------------------
>   include/linux/soc/qcom/socinfo.h | 68 ++++++++++++++++++++++++++++++++
>   2 files changed, 69 insertions(+), 64 deletions(-)
>   create mode 100644 include/linux/soc/qcom/socinfo.h
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 3b970a80f3aa..5919f863f369 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -11,6 +11,7 @@
>   #include <linux/random.h>
>   #include <linux/slab.h>
>   #include <linux/soc/qcom/smem.h>
> +#include <linux/soc/qcom/socinfo.h>
>   #include <linux/string.h>
>   #include <linux/stringify.h>
>   #include <linux/sys_soc.h>
> @@ -32,15 +33,6 @@
>   #define qcom_board_id(id) QCOM_ID_ ## id, __stringify(id)
>   #define qcom_board_id_named(id, name) QCOM_ID_ ## id, (name)
>   
> -#define SMEM_SOCINFO_BUILD_ID_LENGTH           32
> -#define SMEM_SOCINFO_CHIP_ID_LENGTH            32
> -
> -/*
> - * SMEM item id, used to acquire handles to respective
> - * SMEM region.
> - */
> -#define SMEM_HW_SW_BUILD_ID            137
> -
>   #ifdef CONFIG_DEBUG_FS
>   #define SMEM_IMAGE_VERSION_BLOCKS_COUNT        32
>   #define SMEM_IMAGE_VERSION_SIZE                4096
> @@ -121,62 +113,7 @@ static const char *const pmic_models[] = {
>   	[58] = "PM8450",
>   	[65] = "PM8010",
>   };
> -#endif /* CONFIG_DEBUG_FS */

This removal is spurious.

CJ


> -
> -/* Socinfo SMEM item structure */
> -struct socinfo {
> -	__le32 fmt;
> -	__le32 id;
> -	__le32 ver;
> -	char build_id[SMEM_SOCINFO_BUILD_ID_LENGTH];
> -	/* Version 2 */
> -	__le32 raw_id;
> -	__le32 raw_ver;
> -	/* Version 3 */
> -	__le32 hw_plat;
> -	/* Version 4 */
> -	__le32 plat_ver;
> -	/* Version 5 */
> -	__le32 accessory_chip;
> -	/* Version 6 */
> -	__le32 hw_plat_subtype;
> -	/* Version 7 */
> -	__le32 pmic_model;
> -	__le32 pmic_die_rev;
> -	/* Version 8 */
> -	__le32 pmic_model_1;
> -	__le32 pmic_die_rev_1;
> -	__le32 pmic_model_2;
> -	__le32 pmic_die_rev_2;
> -	/* Version 9 */
> -	__le32 foundry_id;
> -	/* Version 10 */
> -	__le32 serial_num;
> -	/* Version 11 */
> -	__le32 num_pmics;
> -	__le32 pmic_array_offset;
> -	/* Version 12 */
> -	__le32 chip_family;
> -	__le32 raw_device_family;
> -	__le32 raw_device_num;
> -	/* Version 13 */
> -	__le32 nproduct_id;
> -	char chip_id[SMEM_SOCINFO_CHIP_ID_LENGTH];
> -	/* Version 14 */
> -	__le32 num_clusters;
> -	__le32 ncluster_array_offset;
> -	__le32 num_defective_parts;
> -	__le32 ndefective_parts_array_offset;
> -	/* Version 15 */
> -	__le32 nmodem_supported;
> -	/* Version 16 */
> -	__le32  feature_code;
> -	__le32  pcode;
> -	__le32  npartnamemap_offset;
> -	__le32  nnum_partname_mapping;
> -};
>   
> -#ifdef CONFIG_DEBUG_FS
>   struct socinfo_params {
>   	u32 raw_device_family;
>   	u32 hw_plat_subtype;
> diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/socinfo.h
> new file mode 100644
> index 000000000000..6a175d635617
> --- /dev/null
> +++ b/include/linux/soc/qcom/socinfo.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __QCOM_SOCINFO_H__
> +#define __QCOM_SOCINFO_H__
> +
> +/*
> + * SMEM item id, used to acquire handles to respective
> + * SMEM region.
> + */
> +#define SMEM_HW_SW_BUILD_ID		137
> +
> +#define SMEM_SOCINFO_BUILD_ID_LENGTH	32
> +#define SMEM_SOCINFO_CHIP_ID_LENGTH	32
> +
> +/* Socinfo SMEM item structure */
> +struct socinfo {
> +	__le32 fmt;
> +	__le32 id;
> +	__le32 ver;
> +	char build_id[SMEM_SOCINFO_BUILD_ID_LENGTH];
> +	/* Version 2 */
> +	__le32 raw_id;
> +	__le32 raw_ver;
> +	/* Version 3 */
> +	__le32 hw_plat;
> +	/* Version 4 */
> +	__le32 plat_ver;
> +	/* Version 5 */
> +	__le32 accessory_chip;
> +	/* Version 6 */
> +	__le32 hw_plat_subtype;
> +	/* Version 7 */
> +	__le32 pmic_model;
> +	__le32 pmic_die_rev;
> +	/* Version 8 */
> +	__le32 pmic_model_1;
> +	__le32 pmic_die_rev_1;
> +	__le32 pmic_model_2;
> +	__le32 pmic_die_rev_2;
> +	/* Version 9 */
> +	__le32 foundry_id;
> +	/* Version 10 */
> +	__le32 serial_num;
> +	/* Version 11 */
> +	__le32 num_pmics;
> +	__le32 pmic_array_offset;
> +	/* Version 12 */
> +	__le32 chip_family;
> +	__le32 raw_device_family;
> +	__le32 raw_device_num;
> +	/* Version 13 */
> +	__le32 nproduct_id;
> +	char chip_id[SMEM_SOCINFO_CHIP_ID_LENGTH];
> +	/* Version 14 */
> +	__le32 num_clusters;
> +	__le32 ncluster_array_offset;
> +	__le32 num_defective_parts;
> +	__le32 ndefective_parts_array_offset;
> +	/* Version 15 */
> +	__le32 nmodem_supported;
> +	/* Version 16 */
> +	__le32  feature_code;
> +	__le32  pcode;
> +	__le32  npartnamemap_offset;
> +	__le32  nnum_partname_mapping;
> +};
> +
> +#endif

