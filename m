Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDD06DF097
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjDLJir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjDLJil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:38:41 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131E42D77
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpP2Ot3py3jT6fEX/fasDsNPny/v561SHPoJ1TEKubLfwhXNLFwTggAU4dHLY+iRX2C25tUqzcbQ1wbyOx/9KiayCLo7QfFTNHq2kS8QUbEnI0PbJvPqoL/dXV/mk2o2KE1CDcZII6F/eB1/N+zqD0XF8wamnlRXnPZlZxI0Ha1UdGcNR61tpPHkPUz+oxHlfnfMwrqUwKKekZVIxVPyJr9kwzIIH3vBQTNfeT9rQoBTrhkE0nYGEFEKL3dg/PwJQu27d2GWjO2tmHwq0E2w4zcwsvJBD1xL1F0B0tbT57fZfyhyRdiNqnGk4ZDOuGJD+h4Jr2gA9Haprkg4xCxEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfqNWVSGsRBEOU+wqQ7Y5SyI+gwOzm1geZKlrD5ECc8=;
 b=UYXeC2SsUCgurW93uqtpRTmKWSa4XEkz4g5936qY8YnoMSKsdjLij+oBMFuBe0OJz29ohojmknHVm717AB53zxVvA6ybMfVYI283Dh7U1Qs3bSYhEOS2vzOfbuUcw4JqqpZOsDcrrolEI51ZmFnNNzHVJZ8j+AV7FrUeB9wrBjvJNZKs/VnH3H5fUlfQ3koUTIFD38ukEZCxh0P9rc1Vy35GfPqmAt6YAHrctnxqJQIkrkPxR9HHbt87DtnZnMpE4if+QpShehiZF3v5Z381CQvwsC46HOPP916dWtK6CDuLZfU/MwqBVJwZt5tkg6S8sJh3amPFI9z4nvJYLiaeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com (2603:1096:300:7b::17)
 by SEZPR03MB7076.apcprd03.prod.outlook.com (2603:1096:101:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 09:37:51 +0000
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909]) by PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909%5]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 09:37:50 +0000
Message-ID: <889cf54e-584c-9bee-2106-633155897324@amlogic.com>
Date:   Wed, 12 Apr 2023 17:37:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 1/5] mtd: rawnand: meson: fix NAND access for
 read/write
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
 <20230412061700.1492474-2-AVKrasnov@sberdevices.ru>
Content-Language: en-US
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20230412061700.1492474-2-AVKrasnov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0195.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::13) To PS1PR03MB5034.apcprd03.prod.outlook.com
 (2603:1096:300:7b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR03MB5034:EE_|SEZPR03MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 8594eda7-65b7-43d1-8fb2-08db3b39944b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkhxArGm1hXd5N9I+zXlo+coitbHTE+s4cfVhUJxv1uEzHnR6tSbFuo+F0xCgyNVrHXDzdyG010bnEswB/+v8TAkssqq1QhrsWa1qbnEjvKrS+cOQha7EMD7CUHv5Df3DcSnwAcn5+SZCDlubcpZpCP55L64CGBY45Q5k5GwYrioVvlhZqDG3sF3qUR3dW713EY77xh3Rbs/tOKzksZGAq4dqxJlX+BI+3Ur8DiMRd8DKGWkVkBKQX3zER6SphkYmka6nkZAfxhV2F9fC3QMvE865NBJ8FWunm1YuShHxoRLGSujydHSW6lwH7jl4C9n8KPyU4FemE8kPF1ZTZAtMdDpiqZXRs+m5ACeqpM3fy3/5TuEBaKL8VK49HRjVOWaSZ3ZkgootfO7MIbPRZkWwAtbkaWy8mAT0DKTge8RTsm4bPJnIeIoxzfUcsBonHAl12FxtIXC450XeLfg6tBmYAheXC2d8RLwXx2qAQUpjMOpzu7Fo3vnacHzmxXCePKPY2zzOIefJi35J7h0poob1nK4KhbNAAbQck3cwTDAzecrz6JbsWgRaTDpKkIyW9mB0NhefS0JQGQuBR2a0Nqqk/8iRGMKjOyK6WV5eKMCCBXlEV0MHDhY7i79LMg0S/7K29icxeJfGx/NOEZ5GlNw/ykAs3DE9hUC/8S+UO7iC2w7W0xi8zgjI4XYf4NbZcT4A1sua8LiA5+yx0gLnetLTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB5034.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39850400004)(451199021)(478600001)(52116002)(6512007)(26005)(5660300002)(6506007)(186003)(66556008)(6486002)(6636002)(53546011)(110136005)(316002)(2906002)(44832011)(66946007)(4326008)(41300700001)(7416002)(6666004)(8936002)(8676002)(66476007)(38100700002)(921005)(38350700002)(31696002)(83380400001)(36756003)(2616005)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEtsb2FKZjljM05sYlNtbjI1WHZKZmh4b2VhcDFHSU1rYVc5NzVGdnpkU2Vq?=
 =?utf-8?B?QzlMMjcrU3NrTnBzQnhXcEJlVmNxQVNVRXhNdkZ2WWJiWHhVd1lGOTdEZVdI?=
 =?utf-8?B?UDh1RllmVFFlWDRQRHVtOHVjS1IzNGZ3eHJTU08wUVFWeDFhM1NhOC9LTndt?=
 =?utf-8?B?ZXdsa1dKUFlzd0YvU1hOZEpESEYrZUJOdUdEZ200TmVYZnhKeFBmeFBKSE5Q?=
 =?utf-8?B?eXdCUGFlMlUyZS9PbGZVVkJkT0hrSnJKNithQjJnMjYvb0VKZGJDS0tBb1BG?=
 =?utf-8?B?UUtYNi9IVmljdXFqQmZ3Q2hqek1uQnRYVUJVcnFWMjN5TVVFME1SR2lRNlJW?=
 =?utf-8?B?NlFDQmJMa21UTmhmV3JBU0ZkKzBRaXE2azU3Y25iVW0vaDFvQ2w3a0E4RzNN?=
 =?utf-8?B?L1YwaXgwckRtcEhyZ1JIMUZnL1FDK1Fvays1Ny9UYTdXa2RFbGljbThJcklB?=
 =?utf-8?B?WUhBbU1tQjRQdlU4dWF1c0cweHY0c0JveitsZnVsa3dpWmw0aGtoUXJKV04z?=
 =?utf-8?B?bjZUa0hYWk1aRyszZ2JBTndJcmpyaWZHbXAwbUhwNlI3V0Y3L21YT0pCZGFi?=
 =?utf-8?B?YkorUDh1SSs1R1p5cnBQbjVlMWlmb2xmenJPaWx3bE8xaWZ6dG53eDZIT1c5?=
 =?utf-8?B?bnpPWnlEY3NqWXF2b0QranVaRVVSbEFPUjlNb01waEViSDFXZlU5czAvTFNh?=
 =?utf-8?B?ZURsaEJnMW9CbWhMc0xVNzczWFM0bG1sQnFnY2dPRll3Umc4TGc0SXNjWTN2?=
 =?utf-8?B?blVVbG9wWEx1UUoxRkNaL2orbVZHS25YNFRDbFlmdVh3anVXZyt5VDI4dUFV?=
 =?utf-8?B?ZjhBNk5TS0lNSG9PeVl4Zmxha3ZnNytPUWd3Y2ZjOHVhenZlbStvS0FhTTNa?=
 =?utf-8?B?SEt4aU5DWnFUWjdyQzZYQmRJNldsb3ZzK3ZNRzhyNFlPc0RLMGkxcy9OL0d0?=
 =?utf-8?B?UUswZnlFcUROdGs1Sy9TdFNaeUJuQ3A0NVBObVJ4N2pUekFOZ3VPRjlKWDNK?=
 =?utf-8?B?UVZRaDJ6WU1pUkYxQTI3ZGM5NW4vYTFXVHNmeDhIcllZWlREanQvY0lHM2Uy?=
 =?utf-8?B?a0JIV0J1Z2ovVVdaeW8wTzNWd1hhTjdPU1dMTTJjR2tzamR5VXNoR3ZCb3ZY?=
 =?utf-8?B?UWV0UnFzZzF2bkFDN0NlbnN4ZlZlcFdlZVRJeDgxTUFEcDVwV0dWZkVFSWlQ?=
 =?utf-8?B?QkRrSnVSamd1bVBvUmo1dFcrckhSSUtVTnZWR3NOWkQ5eFJWd0dOamhjVjNX?=
 =?utf-8?B?MVUvcHhtM0gzSy9uTm85MTh6YWoySGdBbTJlMVFiRTE4NzVGQ1RCZUdSenZx?=
 =?utf-8?B?ZlFGT1FrUG9HdzhaOGxMdGRrZStnMjA5SDNEbkZjcktSSVpGd0RSWVV6eEtn?=
 =?utf-8?B?aTVkdmFmbytrOTRhcnNyQ002YmxLTElnVlBNb0dWenZIeUYzdVZsamNNends?=
 =?utf-8?B?M3JiclNGZEV5ZmpOcU5Va1ZsRm5laThMcUlLek51WGhPbTNjTmpDTjlDM1dh?=
 =?utf-8?B?R09jalVXeFZQcStoUVVMWHdpM255TjVteHBybW40Y2R2eFpyKzVpWmlDMFdw?=
 =?utf-8?B?RVJSWEs2L0pYV1JldkNINWx4YXE3VitScmFMTzBvRzdhMEgrYkdPZXFRYUhY?=
 =?utf-8?B?U2l5bmVDejVHZ2VSTUJEYkhFWmxFNlR2TnkxbDJlUUtJeDAwaGcrekMzbnYy?=
 =?utf-8?B?bENDN3B1OENlZ1pQYm5iWjBoU1JGNjNOR1Noc1hTdk1ZM3RXcStlWk8vbmlO?=
 =?utf-8?B?Skp4bEkwQ2tjN2s4amI0OFRCZmx0TlFiMkpVVWY2T055NnpEYi9GRU03ODA5?=
 =?utf-8?B?d2ExTEZRVUZuQW8wVkVWbG5RWmFGM01kUHdlblhhK3ZPUGhiS1ArY3kxNjFB?=
 =?utf-8?B?RXhvNWtlMUplNEUxMWM2elNJbUNYd0VBWEcyWmY4OWZUWVVXbXM0OE1XbGdB?=
 =?utf-8?B?a0lBZElwTWw5WWJTNXBMOUZBNzV3WWlRNzNidGpTMjBJd2NvV294eGFTeVJD?=
 =?utf-8?B?UEJ1bjV0L1RON3N6QS9zUG1NSDgwWVhhY25QYkdIQnpheW56dFR5NHdaYWtM?=
 =?utf-8?B?RmZ6ZmVJN3NBR3diYzFhRllKWjhqNHZYc3dVeFMrUW15RzZPdmkzMS85aWQ3?=
 =?utf-8?Q?1UIXeLe6gibagM/+9OlGtCQ67?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8594eda7-65b7-43d1-8fb2-08db3b39944b
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB5034.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 09:37:50.3106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4d4L3JcyJaMkdTi8GmPtHIOFESXCubIlAxU/8Qg+R+se2Ljhbr5LJ2j+x75BlKd9Znvdez60xgIkEKhYJN0Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7076
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

Thanks for pointing out this problem. also comment inline.

On 2023/4/12 14:16, Arseniy Krasnov wrote:
> [ EXTERNAL EMAIL ]
> 
> This fixes read/write functionality. New command sequences were ported
> from old vendor's driver. Without this patch driver works unstable. This
> change is tested with 'nanddump'/'nandwrite' utilities and mounting
> JFFS2 filesystem on AXG family (A113X SoC).
> 
> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>   drivers/mtd/nand/raw/meson_nand.c | 116 ++++++++++++++++++++++++++----
>   1 file changed, 101 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index 074e14225c06..256c37c76526 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -26,6 +26,7 @@
>   #define NFC_CMD_IDLE		(0xc << 14)
>   #define NFC_CMD_CLE		(0x5 << 14)
>   #define NFC_CMD_ALE		(0x6 << 14)
> +#define NFC_CMD_DRD		(0x8 << 14)
>   #define NFC_CMD_ADL		((0 << 16) | (3 << 20))
>   #define NFC_CMD_ADH		((1 << 16) | (3 << 20))
>   #define NFC_CMD_AIL		((2 << 16) | (3 << 20))
> @@ -84,6 +85,7 @@
>   
>   #define DMA_BUSY_TIMEOUT	0x100000
>   #define CMD_FIFO_EMPTY_TIMEOUT	1000
> +#define DEVICE_READY_TIMEOUT	1000
>   
>   #define MAX_CE_NUM		2
>   
> @@ -255,8 +257,26 @@ static void meson_nfc_select_chip(struct nand_chip *nand, int chip)
>   	}
>   }
>   
> +static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
> +				     unsigned int timeout_ms)
> +{
> +	u32 cmd_size = 0;
> +	int ret;
> +
> +	/* wait cmd fifo is empty */
> +	ret = readl_relaxed_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
> +					 !NFC_CMD_GET_SIZE(cmd_size),
> +					 10, timeout_ms * 1000);
> +	if (ret)
> +		dev_err(nfc->dev, "wait for empty CMD FIFO timed out\n");
> +
> +	return ret;
> +}
> +
>   static void meson_nfc_cmd_idle(struct meson_nfc *nfc, u32 time)
>   {
> +	meson_nfc_wait_cmd_finish(nfc, 0);
> +
>   	writel(nfc->param.chip_select | NFC_CMD_IDLE | (time & 0x3ff),
>   	       nfc->reg_base + NFC_REG_CMD);
>   }
> @@ -308,23 +328,9 @@ static void meson_nfc_drain_cmd(struct meson_nfc *nfc)
>   	 */
>   	meson_nfc_cmd_idle(nfc, 0);
>   	meson_nfc_cmd_idle(nfc, 0);
> +	meson_nfc_wait_cmd_finish(nfc, 1000);
>   }
>   
> -static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
> -				     unsigned int timeout_ms)
> -{
> -	u32 cmd_size = 0;
> -	int ret;
> -
> -	/* wait cmd fifo is empty */
> -	ret = readl_relaxed_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
> -					 !NFC_CMD_GET_SIZE(cmd_size),
> -					 10, timeout_ms * 1000);
> -	if (ret)
> -		dev_err(nfc->dev, "wait for empty CMD FIFO time out\n");
> -
> -	return ret;
> -}
>   
>   static int meson_nfc_wait_dma_finish(struct meson_nfc *nfc)
>   {
> @@ -631,6 +637,48 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>   	return 0;
>   }
>   
> +static uint8_t meson_nfc_read_byte(struct nand_chip *nand)
> +{
> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> +
> +	writel(NFC_CMD_DRD, nfc->reg_base + NFC_REG_CMD);
> +	meson_nfc_cmd_idle(nfc, nfc->timing.twb);
> +	meson_nfc_drain_cmd(nfc);
> +
> +	return readl(nfc->reg_base + NFC_REG_BUF);
> +}
> +
> +static int meson_nfc_wait_dev_ready(struct nand_chip *nand)
> +{
> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> +	u32 cs = nfc->param.chip_select;
> +	unsigned long cnt = 0;
> +
> +	meson_nfc_drain_cmd(nfc);
> +
> +	writel(cs | NFC_CMD_CLE | NAND_CMD_STATUS, nfc->reg_base + NFC_REG_CMD);
> +
> +	/* 10 ms. */
> +	while (cnt < DEVICE_READY_TIMEOUT) {
> +		uint8_t status;
> +
> +		status = meson_nfc_read_byte(nand);
> +
> +		if (status & NAND_STATUS_READY)
> +			break;
> +
> +		usleep_range(10, 11);
> +		cnt++;
> +	}
> +
> +	if (cnt == DEVICE_READY_TIMEOUT) {
> +		dev_err(nfc->dev, "device ready timeout\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
>   static int meson_nfc_write_page_sub(struct nand_chip *nand,
>   				    int page, int raw)
>   {
> @@ -643,6 +691,10 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>   	u32 cmd;
>   	int ret;
>   
> +	ret = meson_nfc_wait_dev_ready(nand);
> +	if (ret)
> +		return ret;
> +
>   	meson_nfc_select_chip(nand, nand->cur_cs);
>   
>   	data_len =  mtd->writesize + mtd->oobsize;
> @@ -667,12 +719,20 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>   				     NFC_CMD_SCRAMBLER_DISABLE);
>   	}
>   
> +	ret = meson_nfc_wait_dma_finish(nfc);
> +	if (ret)
> +		return ret;
> +
>   	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>   	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>   	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
>   
>   	meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
>   
> +	ret = meson_nfc_wait_dev_ready(nand);
> +	if (ret)
> +		return ret;
> +
>   	return ret;
>   }
>   
> @@ -720,6 +780,21 @@ static void meson_nfc_check_ecc_pages_valid(struct meson_nfc *nfc,
>   	} while (!ret);
>   }
>   
> +static inline int meson_nfc_send_read(struct nand_chip *nand)
> +{
> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> +	u32 cs = nfc->param.chip_select;
> +	int ret;
> +
> +	ret = meson_nfc_wait_dev_ready(nand);
> +	if (ret)
> +		return ret;
> +
> +	writel(cs | NFC_CMD_CLE | NAND_CMD_READ0, nfc->reg_base + NFC_REG_CMD);
> +
> +	return 0;
> +}
> +

it already calls meson_nfc_queue_rb() in 
meson_nfc_rw_cmd_prepare_and_execute(). Could you implements this in 
meson_nfc_queue_rb()? and we can use the irq method.
also without Ready/Busy pin, the meson_nfc_queue_rb() should change like 
below:
	......
	#define NFC_CMD_RB_INT	((0xb << 10) | BIT(18))

	meson_nfc_cmd_idle(nfc, 0);
	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
	writel(cmd, nfc->reg_base + NFC_REG_CMD);
	meson_nfc_cmd_idle(nfc, 5);
	cmd = NFC_CMD_RB | NFC_CMD_RB_INT | nfc->timing.tbers_max;
	writel(cmd, nfc->reg_base + NFC_REG_CMD);

	ret = wait_for_completion_timeout(&nfc->completion,
					  msecs_to_jiffies(timeout_ms));
	if (ret == 0)
		ret = -1;

	writel(cs | NFC_CMD_CLE | NAND_CMD_READ0, nfc->reg_base + NFC_REG_CMD);
	......
	
>   static int meson_nfc_read_page_sub(struct nand_chip *nand,
>   				   int page, int raw)
>   {
> @@ -734,10 +809,18 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>   	data_len =  mtd->writesize + mtd->oobsize;
>   	info_len = nand->ecc.steps * PER_INFO_BYTE;
>   
> +	ret = meson_nfc_wait_dev_ready(nand);
> +	if (ret)
> +		return ret;
> +
>   	ret = meson_nfc_rw_cmd_prepare_and_execute(nand, page, DIRREAD);
>   	if (ret)
>   		return ret;
>   
> +	ret = meson_nfc_send_read(nand);
> +	if (ret)
> +		return ret;
> +
>   	ret = meson_nfc_dma_buffer_setup(nand, meson_chip->data_buf,
>   					 data_len, meson_chip->info_buf,
>   					 info_len, DMA_FROM_DEVICE);
> @@ -754,6 +837,9 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>   	}
>   
>   	ret = meson_nfc_wait_dma_finish(nfc);
> +	if (ret)
> +		return ret;
> +
>   	meson_nfc_check_ecc_pages_valid(nfc, nand, raw);
>   
>   	meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_FROM_DEVICE);

-- 
Thanks,
Liang
