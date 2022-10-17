Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E235B60084D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJQIFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJQIFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:05:14 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2052.outbound.protection.outlook.com [40.107.103.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC42E57893;
        Mon, 17 Oct 2022 01:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAXEGzrfqnx8xZdUDHdya0xN+gomtpGL4epkWU7LBOTw7tf6yCMmMoXxc6di5XDqbbasIQyjqJadyF9gKBtnmH50DnOYBch4RjbqkD6F7v/EicJua+gxzuzEka90klST85dR4lklf3TPruJnBn48mx1NNmYF+QAIJ0UMXafQMng6uBWZIKpAy9N1s5lorxPsOGnvr2ur7yUseyz/p+h6kRCPj0p6E/CKQCA/793djCcOJzPyCzFuBCWomptYSiW5jEKcS5t1hPGTUmEXR6O2C8j44eOgEHEz8Nfbfy+RGfQG6XNWA+KaRhK0AX2IaFdgmydjnaDs9BqL1tShQ1wfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/dCa0DHIAQf7wBm1UB7OXdXIEpylM+0wSydOkX647Y=;
 b=Puf0MesF5ygXeDPcx5+q2uMI90g2mi4R/Fg3kyKZ//hhbxXqLQcdE8luC9dhdLTLoYqeB8sBzEQfNALylEU4kPwbiNnz2vrP3VN5FVan+mqU/BF7eD4BHnHkIHuo1oWhYf0ZqvMA4OnJhkWAoxcZBsI+CfdrvnMVVij+sdfvXOwxycX71GvqO0sARbCK6RMBBX7+G1H3WTlNlsyPlRNr9ZTupYMXRpY1EHto+vrKC9Fx/w5SJupxW8sd4SZMLeF3k2nByq3lUu8qiUllt+Q6m+EnHaMNocEdV3y39ldN8IpkUfn3gYkSm2VQsZI7RB1kEL1pNnWZmw+e/s7b3Se8OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/dCa0DHIAQf7wBm1UB7OXdXIEpylM+0wSydOkX647Y=;
 b=L14SvQ63H5zvf6sTxE16Ciimrtkd/R58EqnbJODS3jEazcdRYO2Mb7dEDE/2aKLMvw3qVHVToyTJ8R7bY0dqGPeVAWK+1qtqBolIn4qEGq2El2kyh1pmMpt666h3zHMoqs8462OygIGPyLCO9sPlL0S2kdg/jhvsBE0Ecyugsu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8826.eurprd04.prod.outlook.com (2603:10a6:20b:409::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 08:05:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 08:05:09 +0000
Message-ID: <f9f56c91-83b0-116d-5e5f-7a2df1e939c7@oss.nxp.com>
Date:   Mon, 17 Oct 2022 16:04:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] thermal: imx8mm_thermal: use GENMASK() when appropriate
Content-Language: en-US
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221014081620.1599511-1-marcus.folkesson@gmail.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20221014081620.1599511-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: 5727dcf6-61cc-4f98-2aca-08dab0164f04
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRQaHO8CQUOdGdTOmwEDw5oqSl+kuOXy/2ST2YtiVQ+IL2vnZLc56C5ra0e480Mbayi9b2yzYPSkjH/dVNEoWQf7pWIhUVB6yy3Ais1bKazM84yU15tU+iHVuaB7Yt9/YLi7d6iaQJsGo+QEKPlNCuY5J9i3ivkCeLPzlO7Za16WwPuTJTWuv3kJcv60ADUxTkCG5+lDoN/1I2vJtMG4CWPuZmhLt+jCBu8TTc9wEIvLc3BRw1zPs4zYbe+KbSxxFJRx9a3HNYblvpn7If+ioIqXiXFk/pmV1i56sGFRdstsQRuNOLZTei4qix5snCIFQyuwFhL++hndvPm5EWkVrdKDGbL0HD4GRKtnxrUb9DA0iqL67AkreHQc19tR5Wk9zVdiZmiIWhwkygCYf99y0fEo3VxnRTXsP9/uYoKXUoJ9D8OpEuo2741qzt2YQT3pFXxOTHuCk/1EjtgCVaUAKY30Snj6BJptw5nADh8pO3Rnfa+UW1aIddssyyUMEmWvmh8Lrw4m5Zs7SXjE+A0l9oCnXtNZosttATrMlbGmUMMDBsnYoTYFd5QxAVU5T+KHmAEIEup5arRC5w0zsP7aMFJl6lrVsTFf/sxqIA4Y+0tLgX6rgTwRbVxt7uY8XYorNIp6cFGjZT5cGDDlj1MxRh3v9bLpq++vHb+dZtjHyhpbRJtV7QS3jDWRw8mY4XE48THGcIvb9Vj2J0ABzcUZD48cfsV3BhhnmoonA/N8jimighz27P3OQ0OWcJzBqOrU07BoVziippQVNCyeSPPoF8WIZo8P+0YyZzklHRtRH+Jvt1XIyNPd+Lg3rHbbUEq/FQdKe94XMMf0QZrAFbTcj4+9Ph4DmuE+PtglpIVuzSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199015)(921005)(86362001)(31696002)(38350700002)(38100700002)(83380400001)(6666004)(66556008)(66476007)(8676002)(316002)(31686004)(110136005)(66946007)(7416002)(4744005)(44832011)(5660300002)(4326008)(186003)(6486002)(2906002)(8936002)(2616005)(6506007)(478600001)(6512007)(26005)(41300700001)(52116002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlhqL2s2R2dxV2F3dFQ1aVRNTjhoalhNSGZNRG9jd3ZqanRVa1lnZDJEdkhD?=
 =?utf-8?B?aWIyUzhEK0orbDlzWXgzMzU5VFlIU2w5SmQzUVc4Q2wvTzdaa0lPR2VGV1pI?=
 =?utf-8?B?OWhTUTZreEhKdDZrbi9vVUU0QjBzYjNLNzJEOU0yOEdldk5JdjhwU05DT0Z4?=
 =?utf-8?B?NFdWaGRFZXM1RkUwb3g2UmxhaS9Sd01qQUtjcGMvZ2dMNW1UUXRuTXg4Z1Y1?=
 =?utf-8?B?b1BSS0h6dWJsWnpaeTE2bEU2UlJFQjhIS0Y1WE0yU0QzbFk1Vjl0bWFzS3JM?=
 =?utf-8?B?SUtaNkJOQWpXTWxNdmR5V1ZuMUoxcURLbml1WVp4Q0hRdXljbW16aGdaY1hl?=
 =?utf-8?B?QTlLVW51VlpSaTJUc2FZcGZPREZFN0ZVOGF6NnRmWnZPSGVhM1M3dk90eEhG?=
 =?utf-8?B?Y2UvWExvRWc0ckVNRUg3TzA1bXBTcHFMclJsMHNFTGdyUUwyVUFXdkxzYnFN?=
 =?utf-8?B?TEEzN0svcnlybU1hM1hXSE1uY0lyditlelNOZEw3dUtTNzlpR0lDZ1ZFNGxw?=
 =?utf-8?B?d3hIeWZPZWNlWldOQm5MRGFMZkNSa0w4eG9uUGtXMEg5REF3cFFaZG9IcjUz?=
 =?utf-8?B?ckVWak5GK0xpUnRFWnc4a1NQZG11eEU1dmlvbGZhdTUyOWRYTi9VS3JlV2ht?=
 =?utf-8?B?QklKbDZFMkRVOXRZV1Q3MUtjMmxWanZyU0xrRm5GaXZvaVFMTGZpbDdRSnRR?=
 =?utf-8?B?QTdwRUxjY2R0a1VHY0dLVm9iN01MVUlvT1E3LzhJMThhTkZPeWN5azVwK1VX?=
 =?utf-8?B?VFlaNXlmZ092bWVsdGJWR2t1UnFVdURZM1Z5QWZJWmJxNWQ1NStpN0R3alVs?=
 =?utf-8?B?TjgxTjVFYmlnUXF5QmZKZkF6ZzNQYWFtN0NLYnhKdll1Ukw0RUJHWTBoTU5r?=
 =?utf-8?B?VGdUNmFGUFZuSW9MR1lvbUJMRjFzR2VOTHVBNzVEcjV1K0FyekN1UXVFdVJ0?=
 =?utf-8?B?blFybkdRME9ObGpyTmh3N0p2NWFzZ3grYk9SQ3N6Z2RhT01vSzVITnlJcmNX?=
 =?utf-8?B?VUpMNVNVcWxxZlpnR2tCR091UEpVc1REMWpjNlVPWHVSK1FBUTVoQU1ua1la?=
 =?utf-8?B?c25wVWdVWTM1eW50bzcrWUVKVmtHRHFIZDJ2VkduTnduMlZBVk5CQnFrWHFI?=
 =?utf-8?B?bEYvZXcyZjllMGVxNFZOeXRkSUdENXRKUmRpVTIrR1NwbVVONjlwMnpJRlBW?=
 =?utf-8?B?U1pkWlg0UnJMN2hUQWhPaDdOTW44ZDErWVN6SlFZdGF3NFZBVUg3OHVtQUZQ?=
 =?utf-8?B?MW8yc0pDVTBjLy9EeGNXSmJYSXZTMTQzTFUyTGg0dXdwc0JHMUhZQmpqamkw?=
 =?utf-8?B?V2hUTUdabzVWaEVxMnp2Y0tvaVc0SUlvK1QvQThxNkZSVFJ6bkNXNENoTmsv?=
 =?utf-8?B?Mm1ZbFE0QjRQMjFnK25seDZsbHR5dFJGb3NMVnJ3VVRLNTNsOHhNc2RKQUNK?=
 =?utf-8?B?dFNEa0hHSzVUNm8xSXltYjdyTWRaYUxtakQrYy9obU0wWEtSWmtBeUFzVG5j?=
 =?utf-8?B?KzVaa0JRM1UyVXAyckFJWXVFSDdPZm00d09ZaGh6MGFRb2dvOFhSaytZRUFh?=
 =?utf-8?B?NmFxVDNiak1mcko0bTBHVzQ1QThyQlEzNHVDSGRHYTJMenZZQ2tndTRScHBR?=
 =?utf-8?B?OG5kRXlWVndtdnFDUzF6Qmk1djBiMU92eUF6ZHRPUXByOVRkVjVWOVFSSFhG?=
 =?utf-8?B?YkNsWUpXb0hwMHpVNWlIV2c1QjNiSGZ1OEJqZ3R2RUJneDVBdktNeWRjZVI2?=
 =?utf-8?B?Y3d3QnVlU2xyZTBacFhDaVVTQ0tDWjd2cko3VVp3Q2JFYTF3c0JURno4b2ZD?=
 =?utf-8?B?T0F4OTJUUVozdmZBYXB3Q05EbFVBbGErdTJPaHJVSTVWREd5QVdDSXljb00r?=
 =?utf-8?B?bVEvM0dLaW1zOXZSeTNOL2VOeE9yZmFNYmk5L3pXSUV4b3BqNlZZYURNdkta?=
 =?utf-8?B?UGd0SDRyT1JYeTMzZlhmc25RZlBwVFEwTkhLVE1NMjZ3Q1dZNzFybGgrRno4?=
 =?utf-8?B?MEtXa1RGQnBQQS9leG1WK0pCclJKOWl1dkc2TDVUdWoyU2taaUVlTUVCc0Nx?=
 =?utf-8?B?U3Vic2NlMFhvOVA3ZnVHYk1JYWlDTWZNektHajVuZHNOZVhEcDJuNE9xVHRn?=
 =?utf-8?Q?V9beALBmQf8me+RTr5406urFr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5727dcf6-61cc-4f98-2aca-08dab0164f04
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 08:05:09.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2IcUuXrhnTrytSKK60LUg0j69Esq27iro5MvPuZRr10TSSR24cEScTEx+r94WLdjtKhg4t8hq3kM1/1JZ2sdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8826
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/2022 4:16 PM, Marcus Folkesson wrote:
> GENMASK() is preferred to use for bitmasks.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>   drivers/thermal/imx8mm_thermal.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
> index c5cd873c6e01..74fc34b88bb0 100644
> --- a/drivers/thermal/imx8mm_thermal.c
> +++ b/drivers/thermal/imx8mm_thermal.c
> @@ -23,8 +23,8 @@
>   
>   #define TER_ADC_PD		BIT(30)
>   #define TER_EN			BIT(31)
> -#define TRITSR_TEMP0_VAL_MASK	0xff
> -#define TRITSR_TEMP1_VAL_MASK	0xff0000
> +#define TRITSR_TEMP0_VAL_MASK	GENMASK(7, 0)
> +#define TRITSR_TEMP1_VAL_MASK	GENMASK(23, 16)
>   
>   #define PROBE_SEL_ALL		GENMASK(31, 30)
>   
Reviewed-by: Peng Fan <peng.fan@nxp.com>
