Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285715FE687
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJNBUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJNBUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:20:36 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EE81781CE;
        Thu, 13 Oct 2022 18:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4owCq6WLHyAbxknjsxxFWuuCnuxnL0hUDKNaGKswrtD5zBx5xoDgFnWKoiy3vtpxt39LyxeC3OMSDOML0d2hntWpsaheh+Mep/69BSvjvc61vQIh/OaTAnRaosVnOn3mnhADw6vGJpF0xMmCB5y0A/qieO1vQbqLUNdmJUQiu5R84VsfzSp/pMqROghy5n+rmVXRjzfCaJObHCKNZNn8xQbrEV+j6ueFdDtHHbZX3jNBmtUu0hdJEuwHdk9fDVZphMVh1mWy9GDtp8dqQG0BvjcQ1t43qFZ1Fk7ucx+NfwPGEZ4eXDeJFfQttmIH3FR8rSKKq2aOMNQKaa55MPi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbckjNr3yfZSsTMbZdkNcGTBSIl1BJHv+854ybZLLyo=;
 b=WsPOoOikLbXoTGhKVUt5Hx0KIK7TtB0WuXJFLXXOgg9yS+ibBdCW8QIVP9vYqSAINFWh/b8CcViyxCwzzRDoQCGgUe9xsUnL9zORjZStQas8Dgao6/oMkXWMAaASQhV5C8IIpO8wdj7TwEuaICCrtlquOfd9hACDGc97R6qoaPKUHzXrBn9xfk6piz1OKWFRyQCTAj4CJwLhw3/9ajbQqkc8XI9xoiiZSyP56I81NGFz/Zh1NsBF641mGhFwgemFzhhdw9QMthSdYw1yDgv8MUPez8QpqY1idoHbRkEUXgdEEH8m7EFI1AuhpXbr9YTLV+bJOuDnanuL6xOXfiszwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbckjNr3yfZSsTMbZdkNcGTBSIl1BJHv+854ybZLLyo=;
 b=aI+0fwp8skK+kkgTom+kKzL7Ex48cRDhynkeGz/uMMpRGIAnATmNh9kv01ojZ16I5fUH2683RVufSpvwOkpMoNnraOXZqkozO+v3GbuPDRbCq+orNoZW/Ek0X5Or1drc0Va5zalL6S9I0Cj93PRkseHkB3Hs8lLMjMTrHWb+mH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9580.eurprd04.prod.outlook.com (2603:10a6:10:307::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 01:20:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 01:20:29 +0000
Message-ID: <1b247906-665f-8d14-82b3-c55467659644@oss.nxp.com>
Date:   Fri, 14 Oct 2022 09:20:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v2] thermal: imx8mm_thermal: wait for a valid measurement
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
References: <20221007073057.41803-1-marcus.folkesson@gmail.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20221007073057.41803-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB9580:EE_
X-MS-Office365-Filtering-Correlation-Id: 91846e4a-489b-4010-4236-08daad8247d1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0MhD9HcVcenDKPZZX1JhI20abBdHkPp6q5ljGtpAO1CW7K+ST+HXAMoj1o5KCHVDMnL4C8zr6UVdHgh57jSJFavF/VygrNc9j/EFiDGFiKhK2aL04A9PMslgoIA/Ivk8riwBD86njie+k2QcPduMHjlyXk3jw4MJt9LnHaYH1od6bepvzCAH+hB8pKeVsPwO6dfn3B/luLiABAlT3Q8AwpgvAkBRDH2k4T2LHDkntM4yNXdNShzlvB+KG2RDqO4zqpVzHezqDipBsZaYRpzuI3qczn+ygGLJYoBmqoaEnVt9SjA7bR58cTrPg8Hn5c2Gd5xZ0L/fU8XGXHczy7Rajb0W0u3H06gC3ZttcwxXF25qPYNXK07ckK/h0MmOOsd/i2Bc3Hs/+tYY1+JH6UBmnHu01IOOFjxczPchgvDJ5fK7Gj76Hq7cAdMG/1EZ5J0BNRRAz5ipsrjyxUrH5Izu1JLoTvD/qOYk8lJaOllW9WgTS3zjB0gMH+InpkLzMLT6Iiyr9BjSypENznbDjUHDECJEXGloy3UyBVsHG57faFj59kjlRTTLQtEtriOEma5ZS4+0pEV4ZDCk8BpB7JpxKcx0mgUk9rUCiLpkCWpQVU0RwqdGn/9wXmtQCpXCyz96nNOLo70IhNlWK9rjeeuJs2Ax5hx3vjwfccUq1Ojsj8YznK5BbSJaFon7DiEMkLELMoZHSMf8ZE33agcHsoNihcRJhH86L541b5n3X+immuoxgiku5x9+hgRplM6sW4+iy29WahZBqIeL58JFbk3HIdOgGKoU7orVkJB6XvAPNqu3wuD4mAF3AqyO35XgFkGcDySlsk18mlXRQtSLPibzUZ6Xt5a6W3TC/pIkusQOXoFtVRufjxRV1XB24fs8EhQD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199015)(6486002)(966005)(2906002)(83380400001)(110136005)(316002)(921005)(38100700002)(186003)(6506007)(41300700001)(6666004)(52116002)(53546011)(8936002)(31696002)(38350700002)(86362001)(7416002)(44832011)(478600001)(2616005)(5660300002)(26005)(4326008)(6512007)(66476007)(66556008)(66946007)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHhUMFBZOCtoVUVQWDRsQW5XWTdnQS96QmZCNGNzY0Q4SW5BZ3FXVWNwRWtt?=
 =?utf-8?B?VUttRzY0K1lHTnArUlRveWxObXZBNzVpMXd2OU1MUEZHRVpxMGN3K0VBd1JG?=
 =?utf-8?B?ZUZqaW5xVitZcm9LcG9Mc2FCQUEzVU41QXB0OHNicjJxRkF0SStIb3hkcFQ5?=
 =?utf-8?B?OTNDdW1DZkhrRnY5Q1BYeDBOS2FoelB5Um9LQXVuTjR1c2dadnBDMDI5Nmo3?=
 =?utf-8?B?aVZ2YjRFenhGdzdRTUtWMWhIMmlzR01SeFNKUjVmVXdmV1hhNUk1ejQrSTNH?=
 =?utf-8?B?S3pnUHc4dEo3NTJqa1Q3SENFWDVtMW5iL3VPUXlnNTZCOVc2Rjg4M0ZJMW5z?=
 =?utf-8?B?eWV0YzVKNUZNRWovZXF1TWh0eFRUeFR1M2svZkRZS3MrNWw2OG8wcUJvRGM4?=
 =?utf-8?B?TzFTL05rc2Y4MDRIVE9NbUxlU0w0NUxRRzFBcTVmdnRsbGV3U2s0akFJRm95?=
 =?utf-8?B?enZ5elRkSWlJQ3hNcDVRV1hyN3FEWFZLTmtHWjBKSW15UWttd3g5MUpYblEx?=
 =?utf-8?B?NjUxRFVkQVIvUjJPK3pKMGo2cmRXNVRYM1FqcVprVUErRWN4RTh1dFI4djdT?=
 =?utf-8?B?Zk9sNUxWVElqN2FKOVR0dVA0ekw1eVJickRJT1NqTDR4UjVwZTlaS013V3NB?=
 =?utf-8?B?L2h5RGpveHhJZTFtWjNWNFBURGI2TGIwelByL05xWGNqWTY3aWttYk5PRlQr?=
 =?utf-8?B?VnhpU2lQVU4yazdNQllKT0F5Y2Q1Vm96UU5XSk5UazZXK05DSldNcWlYcjdU?=
 =?utf-8?B?NmsxR1A3Q2ppUEl0ZDMyUmRPWU9nSlN4ak9lZ1hBcFpEWUljQisxekhZNDd4?=
 =?utf-8?B?eUpMekVjYzJhNVlBMGluMzZyZG44YTk1SkttTldmdWZpTm55U2xhWjkwVGVY?=
 =?utf-8?B?RDRxcDdHWks5K0J5M0dUVHRhSFRpTGVKRi84aExWUXgrd2NIc2lPdWF1Qlh5?=
 =?utf-8?B?TUFzNjgzR2plK09WUGtEWTFZTXVvRWF6MlNCMEJsT3FTOC8yNVlLd3dhZ0d0?=
 =?utf-8?B?STk0UnNiYlZVNDlaczhBblYwY3ZlamErVEhXSTBwbThFWVdzM3VLSHVyTm56?=
 =?utf-8?B?bEdjMnBCbTlFalozL292MGg4NWFPT3B0RjRGOVJrWnlWMlg2ZTl2K2NJUzFC?=
 =?utf-8?B?NS9tamZIekkxMnFFOEFaNVVBOTM5MnpQT2ZUZXFMNUdYZEtOaXF1c2JMZ1Jr?=
 =?utf-8?B?cWtTeTVuRkRkWkFqM2VEUTJYY0YyOWpTbHQydEtNMXhXYXRxK2V4SGxFYlh4?=
 =?utf-8?B?L3VrSmVTdy8wWnB4T3loTk1Zam5aNkxHbEhPc0t4Zyt0ditKMjM2dWNpK3da?=
 =?utf-8?B?LzIvM3NKbnhkYmV3WkFOYjB2SW1TZUZDU3FsU05INy9zRFlpWnZMa25DZmJH?=
 =?utf-8?B?SFpXalZ4c0E3MW1JSWZpeEV3aEhWUjFPbENpVmYrSEdCM3dQYktRc09meUVp?=
 =?utf-8?B?TmlBQnJPdlJ3aGo1dzNZbkxqQ3o3M0Z2VFQ1SS93V0o2STVoL2tzQVBocmpT?=
 =?utf-8?B?V29OSTZaQk5oUFRHMHhrNllySXdkRmVqa0NDblZBV1VwQ1FwUHBHK1hxUkp1?=
 =?utf-8?B?NHlLd2hodUpQT1E3alQ1aE9VOXhtSFpwcnZvZG1Lc3RKQVBvKzVPZFM3ZWU4?=
 =?utf-8?B?ZTRQQkRObU5ZMTljaFRPSHQvczkraXdlTWJDRWFBclFiM2RtdWVIK0NUMWND?=
 =?utf-8?B?YlhrQWxVdExhRDdXYjBIR2h1UW92RHN0WWN3QlNJN3l2eGVScENvQlVyZzdw?=
 =?utf-8?B?dUJoQWh2eHczbjcrVkVWT0QwRFlQOHJHNzVCb2d3V3d2M2dOQmQ0dVZBK01O?=
 =?utf-8?B?NVFteWtvV1NjWHNyS25Ka2VWZDhEaEQ0SG1SdC9KRFkrQ2phTzJ5RFd3MHJK?=
 =?utf-8?B?U0o2VGtOL1RNL0RMaXpycHh6Y25sNXZNaWFrWGRmRW9CTnhrbURJbWMxQjN4?=
 =?utf-8?B?NE11cTZRUFg2WTRNVjdNVFh1M3luVW14L0ZTSkdIWUt3OS9CaUNwLzZTRlFL?=
 =?utf-8?B?a1JFS3d0Slppa1ZELzJvT2I3MmI4RHRwdndSWmFSNjFJZGtaSENvTnd3aGUv?=
 =?utf-8?B?ZmFzUllqd09XNGZEeDNzWVZ3dlY0WnBHWjErNlAybGxkNy9CWlBTWHVCVnN5?=
 =?utf-8?Q?w6/arPjjGK4sxnqUC+nZx53aM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91846e4a-489b-4010-4236-08daad8247d1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 01:20:29.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gl9yxQuk/OyBR9DlEPzPwyELHOyc2Mhxa6auOvd4fXo9vEltdUnjPxv1HgBIJyOcK01um4BDyodwxuC5gHMrxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9580
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/2022 3:30 PM, Marcus Folkesson wrote:
> Check if first measurement is still pending or if temperature is out of
> range.
> Return and try again later if that is the case.
> 
> Fixes: 5eed800a6811 ("thermal: imx8mm: Add support for i.MX8MM thermal monitoring unit")
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

NAK:
Please refer: https://www.nxp.com/docs/en/errata/IMX8MM_0N87W.pdf
ERR051272: TMU: Bit 31 of registers TMU_TSCR/TMU_TRITSR/TMU_TRATSR invalid

Thanks,
Peng.

> ---
> 
> Notes:
>      v2: Also invalidate if temperature > max (125 degrees C)
> 
>   drivers/thermal/imx8mm_thermal.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
> index af666bd9e8d4..e42bf373cebc 100644
> --- a/drivers/thermal/imx8mm_thermal.c
> +++ b/drivers/thermal/imx8mm_thermal.c
> @@ -62,11 +62,17 @@ static int imx8mm_tmu_get_temp(void *data, int *temp)
>   {
>   	struct tmu_sensor *sensor = data;
>   	struct imx8mm_tmu *tmu = sensor->priv;
> -	u32 val;
> +	bool ready;
> +	unsigned long val;
> +
> +	val = readl_relaxed(tmu->base + TRITSR);
> +	ready = test_bit(probe_status_offset(1), &val);
> +	if (!ready)
> +		return -EAGAIN;
>   
> -	val = readl_relaxed(tmu->base + TRITSR) & TRITSR_TEMP0_VAL_MASK;
> +	val = val & TRITSR_TEMP0_VAL_MASK;
>   	*temp = val * 1000;
> -	if (*temp < VER1_TEMP_LOW_LIMIT)
> +	if (*temp < VER1_TEMP_LOW_LIMIT || *temp > VER2_TEMP_HIGH_LIMIT)
>   		return -EAGAIN;
>   
>   	return 0;
