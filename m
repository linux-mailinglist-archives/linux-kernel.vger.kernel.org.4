Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EC3703F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245236AbjEOVOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242603AbjEOVOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:14:15 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2124.outbound.protection.outlook.com [40.107.14.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9574A271;
        Mon, 15 May 2023 14:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGyGU577ZfuckFeyll9AU25BPJ7ro+itXBc3z/bVO+BJ1l2c077MEPc1e6vpDn74gtsU1R2B4IpoPNg6bSWfpYpg+nodtnnRKCqoZnS1SoyobQWjE6yNZ/zRmcm7DBvAlRd8vMTPWvUiiFUQSgm9yiymoO5OskpEAhcyTAagUA20zjFZIcacS757cXBxJjUVvFZMSHh21DAp37B//wh4d1Mu2iPMwuPoz9zhuKJ6Eiw4bxR22NeTDlxFbFmu5p9ReQvA5mH7D0hmkiVrgpqxwnn4UBtnyOMY4jynYiXm+cgiLedPhLn+3v5kv8kD2qV9ZfJ07hnlNfPGlHDteVwiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUc+RLNlFbpZthquqkhLSd4fhx8myazm1WV7gNrmhpo=;
 b=h4C53B1BbC48y41oXQ1hlS3uATT845r4igaAQZK+sjWgNaDj7ieOzV9UTzF+jbE2+bK89hk0C3PNibNkDj72f4t99LdzhWPwFQDJXzxufW4gF9MS/Dst2WU69Kq3Jz5Ks7TvgP/XmZy/a8uJazqyAj3xIuKyQ02E98WeV/VOVor+eo8T3BPhXJYTgES7HoRJLZuhP2i3+RYbEWtm7nklfz68A/DfsqKq3hUeLLjzkrFSGN8vcPa/8NP60KnCPEWTPXgrnuDZ/KUzWKftBpJeL5/gTz+K/f68ZPpY5oqhv8vuD5UezbiiASDJYauGrADt+9m24TSQlYSXFVEIL88aDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUc+RLNlFbpZthquqkhLSd4fhx8myazm1WV7gNrmhpo=;
 b=HcxV/TxDPs0UsSF1Nko2E+nyQZ+Y2Z0oa+LT5dFUakxZG3pLT2/nDCbFKBa621H6XP5q7ot1j7HVpBpO4rUgo9/7IiUhwCafm8BPPzvgb3aDiHEIBrakLTnUZX5URAjEPyYQbxff/Yms8/Id2NXIGmE/2u6XbT0ZFk26Y660B+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com (2603:10a6:803:ab::28)
 by DB9PR02MB9971.eurprd02.prod.outlook.com (2603:10a6:10:45d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 21:14:10 +0000
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::b703:24c6:975a:bf84]) by VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::b703:24c6:975a:bf84%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 21:14:09 +0000
Message-ID: <13c1f6ea-63b5-9667-18a2-705829c46437@axentia.se>
Date:   Mon, 15 May 2023 23:14:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mux: mmio: use reg property when parent device is not a
 syscon
Content-Language: sv-SE, en-US
To:     Andrew Davis <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230515191909.611241-1-afd@ti.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20230515191909.611241-1-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0072.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::30) To VI1PR02MB4445.eurprd02.prod.outlook.com
 (2603:10a6:803:ab::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR02MB4445:EE_|DB9PR02MB9971:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6d470d-3e44-4de1-e0b7-08db558952d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sI0/I7ck6Njc1R/KAKTTpie0ZThIVe3qZqTOKTqlu4GqRxrXYgptCdW/pjViOfLg8BK0n1qnS+zVP8JZ7Dc8pcOPMDopM7A8mrfJHHZbcbrVEQ9rVAR4mwn9lxyKdXQAa3qBV/Bz1oHEUDdokbf/PKBAOlOgxIRA+CNZTTOVbWJJyv3QjIA6ReqkHn5aqD/f1LtNVm04KI0R9GJDBqqsJJb7yuDp4k+7vH5Z/2enm6ofmtbdJBSOfTWA25QNDqqXxwBlmZKSjk9fwrloFvNt8mOxrzYxPW3YZ2ugmk+P/XAvNf3gU8dOyO6jKhOajxmJVh3OH3WeO3Y2W5xzkPGxkdFaEsXm4pPEPV1bIVzXhRHl4iGAqkhWv0KNPKbXZHveOjbW7LiRyQVlTHys8z1AMpYy+LTuuVXGfIrnFxW/2Sh2LFX5SPwmbd7V7NVKBIIK1IEoAPDGDM8zSFJU55YSmc8huna3QfsiPTj5cmTlf5qSzI4LpKdF9V4K7BDfqPNeZDkzLEc3PqUSGBg2gSguvQEh21ekOriq/GEsx1WkpDo9kZotgclt6roqNm9uiqTBAwBMw679zH+dJSGkJTtoTsPlTheHZPY4Bm8sBCQgSbJcV0oeXHIUdnPw+g1/QJpoceEXOS2Mt/Oo4kaUcLmxDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB4445.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39840400004)(376002)(136003)(366004)(451199021)(83380400001)(31686004)(5660300002)(8936002)(8676002)(31696002)(316002)(86362001)(2906002)(2616005)(186003)(110136005)(6506007)(6512007)(478600001)(26005)(66476007)(66556008)(66946007)(41300700001)(38100700002)(6666004)(36756003)(4326008)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0tsZHZsbGNDd213Y3MrZkxITXpHTUlIOVNVVnRSZmFLeEwzeU50aVlTdlJE?=
 =?utf-8?B?K212cFFWWTRsVjFWbW41UWZYNlVLZEtuZW04MHdlVXJieVRrUzE5WVlQRktB?=
 =?utf-8?B?RUs5enU4Y3ZINHRIM1BGOWNLYitOMGFuNVBQMktmZ2NCSUlNdnA3cjA0d0Rz?=
 =?utf-8?B?WGFpRWw5WDI3WTVWMWVLSnRORDJwTmlOejdFRzdQOVpaaW1SL3Z5TVhySFNa?=
 =?utf-8?B?R3VvbjZLMnRwbnlrTUJMaFV3SFhsQThSUlY5Z3U5UEprWkRTS3U2RmNhd0Jt?=
 =?utf-8?B?Y0I3NElYL0hnN1FjZHgxNzd4VFZvMFB0MTRjN245SnFRbTM3K3lpR1JaV3Fx?=
 =?utf-8?B?Q01VMm5iZVcxMlN5VzFpYmtrMFJoS2M3c1lJUnlXM1VhVTMvb2dDVXZqeStU?=
 =?utf-8?B?NVkxZXQyeStHd3Jmc1VFOElpSzJJb3FzMDVHSTM3VHdBbi9zL040NjQzUGtM?=
 =?utf-8?B?a3ZHSjJnZnZRa21DSFhDUWtvNFMxUDY5R3BCQmpYU0ZsWXhtUXBXOHg5SDJC?=
 =?utf-8?B?ZVUrdTUwTTdrdVFBamdXdVROOHMxWTd4MWUzQVZKaWN4NncwTEM0K29QK3Nz?=
 =?utf-8?B?RXF5SGxyU1R0c3dIY2ttM1dvK1NIaVBXOTFOTWJNNkpKbkcwRS9HZnJ3SFgr?=
 =?utf-8?B?aG9vUWJIRmxRUElvRktBRk9wdTk4aldNWTA2VUNnUzdUMDlJcm9MWkVXbWlE?=
 =?utf-8?B?dUJZV2pKTE9OTVc4SFRHL3FDMW5YMjV0RjI1Y1NJYjhXbVNCUjdRMGphTmt0?=
 =?utf-8?B?RTg3NkJycDdxSS9sTTkyc2twVFZRekdNL21jTmI5SDFMRWhGNHo4c3hhY0Nk?=
 =?utf-8?B?cE1vM3pFOHRucUo0aHV5ZW52NE1wYUhUZVFQQzUxOTFHd3ZYMnY5b1FEUGoy?=
 =?utf-8?B?aFhTS2gybVZ3ZTcrYnNuUW1HWHRSYW9IQ3dVYXhMTk5lNHd6OXhNNjI0QmVp?=
 =?utf-8?B?WVpJYllCQmZlSU1WcEx4eHFUTXBwRUR3UkluT0dtUE1hOTJWT1JiMXBxRVJS?=
 =?utf-8?B?WU9qbUN0aDhFekFZK1JpV0FZYjNkWEFuc0wzdGY5dnQyZUFuYzd0dkdrdGtk?=
 =?utf-8?B?VGpVaTRLVDgwYVhSd3hybUlzL3lDNi9LYTlGVDFRcGFkVHBrSUJzQ1R5eDZn?=
 =?utf-8?B?ak1aZjVxVmNnTjJFR1lJVlNjaEk2SEJaMW81QlQzTUROYmg3M2tyUXBkWlNZ?=
 =?utf-8?B?MXNtNHV2aXpFeEo4VWp1cWtXdy9mYTFVUnZ1b1NQMDdLd3BIc3JWb1Riekxy?=
 =?utf-8?B?UUI2dVpNTncvZDJZS1N2bXVuTzFzTmpJdDJwcGJLUUNuKzV0MjVuWTlyYkFI?=
 =?utf-8?B?YURMc0FTb0VyNHFlcS9DOVk3SjcxVGZCTWtPd3ppSXJrem9KR1VkSngzeTJq?=
 =?utf-8?B?emxLdmdkSUZiUElMS0kxT2dWMlQxSWltYWhJUlltVVhHNVZ2Tk5SZG8wbFZs?=
 =?utf-8?B?SEcrY004L0hlVi9Xc1B1eTArUkh5ZGROcWhMRUZMQ2xLL0REMVdQSURKWnhX?=
 =?utf-8?B?c1Z3Z1dYZ1JpRUs3dithMWdaRWFERWhIYnpsWDIzZlE0S0NCa20vM09oR0lp?=
 =?utf-8?B?UFY0UGhRTXprdUFsS3ZMMGNaeGRoMUdMdTZWa2NFalp0SWZEMG96bGdiMXQ0?=
 =?utf-8?B?Sll6N0hpeDY5eUZXcUR5VmZuV0dDSWZjaW1zZzhKdzI0YTdTaU9RNkZiUGZD?=
 =?utf-8?B?dGJYR3NjSjdRY1M4cGVhNzl2c3RIQjJoemVkNTM0WkozeTc1NW1ISnFxUlRW?=
 =?utf-8?B?Mk5TVnhpTHZLSmtod0hkSUlTSmJmT2NVSnhCZkhWV0M3OThCRlR2bUlPUDJK?=
 =?utf-8?B?L2J6OG5oOHh2TGh5dzlwRG1xZitYeXIvT01yNkxOYjFzUkowcGh4MzZZRHJa?=
 =?utf-8?B?VXRKckYzZndUVXIyamtjaXkvNFNmNHFxU3dvREZFczAza0kvMWV2bXk0UWlT?=
 =?utf-8?B?eHlpc3lNaHBTZkNNTVZ4Y3BNV0p0WXBpdC9PaWtXK1ErQzFFV1lmWTlhWnR5?=
 =?utf-8?B?YkNiZ3ZEeEJ4Ulpwdk9URUZEdTdaMzl1MFdLMG40Z1cvMUI0SGt2T2piaGRm?=
 =?utf-8?B?UEVIY2Z6MUZqUnpNZ2ZDcGhudXpIOUtQeHFTeWFDOVMvdTVWeEdJbnNaZUpq?=
 =?utf-8?Q?N+fkMh9V5zjbelVhZtqXkrB8M?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6d470d-3e44-4de1-e0b7-08db558952d1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4445.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 21:14:09.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opnU5sR52TWO7ckrvxhvFrceCxBLAV6sGhBe10Lhi+NuIPFdsz810RCESZ1ULPac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9971
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-05-15 at 21:19, Andrew Davis wrote:
> The DT binding for the reg-mux compatible states it can be used when the
> "parent device of mux controller is not syscon device". It also allows
> for a reg property. When the parent device is indeed not a syscon device,
> nor is it a regmap provider, we should fallback to using that reg
> property to identify the address space to use for this mux.

We should? Says who?

Don't get me wrong, I'm not saying the change is bad or wrong, I would just
like to see an example where it matters. Or, at least some rationale for why
the code needs to change other than covering some case that looks like it
could/should be possible based on the binding. I.e., why is it not better to
"close the hole" in the binding instead?

Cheers,
Peter

> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/mux/mmio.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
> index 44a7a0e885b8..42e00b9fd0a9 100644
> --- a/drivers/mux/mmio.c
> +++ b/drivers/mux/mmio.c
> @@ -44,10 +44,13 @@ static int mux_mmio_probe(struct platform_device *pdev)
>  	int ret;
>  	int i;
>  
> -	if (of_device_is_compatible(np, "mmio-mux"))
> +	if (of_device_is_compatible(np, "mmio-mux")) {
>  		regmap = syscon_node_to_regmap(np->parent);
> -	else
> -		regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
> +	} else {
> +		regmap = dev_get_regmap(dev->parent, NULL);
> +		if (!regmap)
> +			regmap = device_node_to_regmap(np) ?: ERR_PTR(-ENODEV);
> +	}
>  	if (IS_ERR(regmap)) {
>  		ret = PTR_ERR(regmap);
>  		dev_err(dev, "failed to get regmap: %d\n", ret);
