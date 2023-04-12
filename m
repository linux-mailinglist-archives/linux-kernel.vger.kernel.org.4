Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709226DF008
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjDLJHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDLJHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:07:43 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2080.outbound.protection.outlook.com [40.107.249.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1DB4206;
        Wed, 12 Apr 2023 02:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTIgbJvJuf7wTLaTnGm9t+e2Piyd+z0OBLkK5FnJNTzbdvJyeG+T6Xrxbv8U40sylJhsnHYwO+V7WUc3Bdg6aX4vkughdJtrGpoH0E/q6j5X2vXGz8f8eiOFeZkf3tLvwceUHEWxIRppQZafaEjEmE8V0/QZQIwQWYESp/KboyYX6pE6Uh7hynRKg/vU4ifMXcMLpD8junyoWAzwyPZQdq/9XPFSXwz7mlXycSawa/a+/fuo/9mWvsMNbRuQzJfoffHM+F38tcjtNJrphxmvPuVb+LPelG3HVoO87H8nlDADxAiDCMTRHvB1bb9rIOKhI9WhJf+3/b2wiLc6ejQX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/3useI7o6I77KcGoyyXBIwEhKqfR4s8kSPTqzgNejg=;
 b=C5i8z1/JR2Fb005+ZrEjIQZ18hByAS5DkxaucI2H56QosaXrMosCy9GdKz4HRGzvdeJK/MT/RUpSFFGzKFYRJqhcckZTl6nvwnzuqzDHsGmdBGJRgmS0VqDJsN/QFc/OXT36uZajorCCMgYV+iziC0IwJwy5+kYWh7UAdsnfX4MLNnjyi4fMtQoeXPzMXEyOMmgwlNaijy+OXQfFEToeNx00T4s5u5rZ6+PpKx/gVdATWJ95IFxbXNlvtQIXJ01PVqKv5ZqPVkPoRXQ5GY6crFxt0aAjzNdttUgEpW0jUDVzWuXkZlc7qHihtBYhBxeglnwxtgG9GBbgoytm3C4nbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/3useI7o6I77KcGoyyXBIwEhKqfR4s8kSPTqzgNejg=;
 b=jUHxq295ztQ+rdCyNfDTrKyQLGR1vG87vkw8EklFBX9Znd9/crrKNR835OAjdTsjxRpqIYRLhnnb5CcA3F5yC5+o5vkH2ms21Fva5erkJDxGNi7DxhBOD6biWMhYdk1ATwMSdcF14HTn7EGxCzzG8hp0ZhNTmnAXYwKN0nZ8/bM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6932.eurprd04.prod.outlook.com (2603:10a6:208:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 09:07:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 09:07:34 +0000
Message-ID: <5704f388-3982-4706-9d38-5110b1cc2bbf@oss.nxp.com>
Date:   Wed, 12 Apr 2023 17:07:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] clk: imx: clk-imx8mn: fix memory leak in
 imx8mn_clocks_probe
To:     Hao Luo <m202171776@hust.edu.cn>, Abel Vesa <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230411015107.2645-1-m202171776@hust.edu.cn>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230411015107.2645-1-m202171776@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 581d0106-c6eb-40e9-7fd5-08db3b355a9a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yx4PrQaxz9B2UTIOcOvELaI0i8KJPxu++QXmgtI8Ix9Ylo9AvdszX296dZMBGS/zg7dkinrrB40qUy0LV6R23G66WnOxos9oUxjYC48n8Jwe/csK2IsIIzGCslKCWUI3h3aoo0z9yXWDnXP6udhIlkJvLYQnaR0gU4uhZKZ2IcaLHebsNXWtZP4/lD/XEVzUPd/6jwKkcWA1sRH9dH4j3oFT6iG7fCtd9t5Acho/G2QEolTRXbip56zlEFSLoJUifDZPbZfejn7EH7TKKx/yJ0yV/rjwC+BCa9uA/iEELbO3TKUAqTyh9TwN7R6Zy4mBZhJEaoAm3bDcaSTFVvkJMix1PZyLPGro0W6v+xcz/CcM0e7tRYyjdojx/5sx7445cePFfPV1TwAY9sptAaCD7T2fJOtpsEbEVyyW6b+1m8+VoJD1wN0PwsrN3dSohqEPamoC+US7lHuLbILLWgm56YzwUYMQZwQF7YDzhla1v6wdrIcPQc/wjUT75oSLVW53wdTYcikTqdAohmCzrFoqYnLI2h+/wBPDxdjNQHe2WsbcqtKO05ETBnFnsfiKVGe9+6lJojwLeYWX/C4yCcXNxZy7CDBwU7VXzUteJ55bS83J0ZGRGyk8+GbFgLukEV7SBX/5Iu8AupVzKmUlojmV/pCKrHIsaYxH22NWvIGGlWx1wu0UDdNsvPKZUvzjn7+vQPDm+OnotU6wk0TrR/pylg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(31686004)(38100700002)(5660300002)(7416002)(2906002)(44832011)(31696002)(316002)(8936002)(86362001)(8676002)(66556008)(4326008)(921005)(66476007)(66946007)(41300700001)(2616005)(83380400001)(6512007)(6506007)(26005)(186003)(53546011)(110136005)(6486002)(478600001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym5kMTdGSUg4QUZJajJGUnZwcHJ5RHF2OTQvZU1MZFV0Ris5b0NVMGZNdWd5?=
 =?utf-8?B?WEtYWXMvcHZ3SGNHTENWUlg1enNxZU84ZUVqbTQ3RTdzL2ZDYm45bmF0dTdo?=
 =?utf-8?B?TU5uMzhUK0pRMklEdngrcmYvanZXa2h4aDJ2aGozb0VvSE9ZY3UrUVBEWitk?=
 =?utf-8?B?TmxONWkzZ2J2TnphcmNoeG1WK2JrRFFURFQ2bDkvWnlJSEkvUVc4U3E3Nzhs?=
 =?utf-8?B?R0NvRGo0T3owL0lheC9iMGZkMCt5V2o2dFlmNUUrSUdaWWpudmRJUTBkeVNs?=
 =?utf-8?B?MmNLckJwRU90MDR2SFNlQlhxbDZlNExiaHdYUk5rTzFPNEVmcGtZS1hNbTZh?=
 =?utf-8?B?cit3dnFLaVBRbkNRcFUyOTN2b0xGMkJadzVXYzF4Uk9LdG9Lb1ZKQmY5dDV0?=
 =?utf-8?B?OFJVNWVSaFhyRlZPRVg0dEdyMzZvS0RaVDd0Z25ObVkydVVXd0xWZ0NIN3Az?=
 =?utf-8?B?UVc5cjgrZXdsREc2c1V1QWxtb2tTS3hBVmpocHVtbmVnblNrOXc0YS9qUG9D?=
 =?utf-8?B?M1ZPc1cxdHJRMTF1eEpISnI2SktxUmFzL1JVeGNJS0pxL1BxU3ZWcXdmTXFI?=
 =?utf-8?B?ekg5dHhralRyYVU3UTFPSUhLZXNqN1BwdHlrSmNKVlUzSTZjMkowTTVXSlU4?=
 =?utf-8?B?c3FySWFybU9QTWJFZUZWT09oOEo4WWhkcW5leHZQampzYWk2NHc2Mlh1WFNr?=
 =?utf-8?B?N2pJdXlxZHdWNVRXUXVrc3BaazhGUGpvNTZCTEhVNk1yVVppb3hLb2g1TEhY?=
 =?utf-8?B?VklKZ01sZ3NOYnNKNlBhZjdDdkNLbEF3RTNiY01GUmQ1TGZMV0oxTDY3UVUr?=
 =?utf-8?B?bEt1RG0xcUJ0UDd4TVR5Nkc1bjNOYVJkbVNGc3dWdktnY3BpTUtHNUFYbkxI?=
 =?utf-8?B?S1BEeHRZTkFXUTJPV0pwSXFBcnA0cktNZ2gyais4MjFicG5RSzkzUTZScHpC?=
 =?utf-8?B?NUJmQmxXczdGODYyakE0ZVJENVMyc05mZEc2V0xGNHV4dkVlMGFud1QzbVht?=
 =?utf-8?B?TnZPT0hjT0x1SEp4TkZCazBna3cySFpJV1FzK3BmeDVUbWI3eFFXZ2hDN2p0?=
 =?utf-8?B?SG9NcDFMVjJCK3RQbGxURUlHR0xyTEpKY0w2M2g2UjUyYUJlL2Q5V25XK3Fv?=
 =?utf-8?B?M2NRU05uUDZNM01rbVZLbnNMUUR0cldscno3SE9NbnppSlhTdVpjQTNDNkph?=
 =?utf-8?B?NlNNUUh5bGQ2bW1GNkE2ME9naU1lTERYZGF3ZGFwaTFvUlJXTkZqLzhENHg3?=
 =?utf-8?B?dGhtenluNUlnajQ2NFgwK3JJVG1Idk5wTmRoS1Qvb2YrWnRxMVRPUUcwenJw?=
 =?utf-8?B?V05mMHBsMmhoc1puR0U2NHU0elk2S1JQaUY5M01VbFRINEtOaml5OFh5MnVO?=
 =?utf-8?B?aitaS2xxZWM3ZS95L2YzSlUzTktrQTg4dGQ2OGM5OWFwd3VwREZsL3k2anRt?=
 =?utf-8?B?QnNnNlc5aE9ibzIzbi9wTWk2NHpXNVhya285dmcxeFRoTmxOYTcySHNuaVJS?=
 =?utf-8?B?VDdqb3E1RVY4WW9PSE5VZXBjck82UG1oTFkzdWM5b29GMUpRQjVQOGk5UzNN?=
 =?utf-8?B?RDlCblBYNG1aOHI4bndWcnZOUmFIVnAya1JncGJqdTdkZmtXdTZIVWQ3V2xF?=
 =?utf-8?B?QnNQVXZSWDBObSs3cVlXd2dtQUFrRkhnTmJGNFV5K1VGY3AyODZrbm9EL1Zt?=
 =?utf-8?B?SWVJU2hrUUIxYnpxbnpJY0orem9ibmQ0dXpzYUxTZmVWRnNURndwNTZHcnlX?=
 =?utf-8?B?ejhjdFBSRmFqQkMzYUVnTnB6R1N4U3l1MGdISVEwa2ZhNjAvSERVbGEzclZ6?=
 =?utf-8?B?WjZDL3VJaXRZNlBPdUFrbGZVN3hmckEya3FpQ0thOE9sWXlEM1U0RDBpK2Jt?=
 =?utf-8?B?ZG9USFo0bGdFQ3I1WVdvRlVDOUlRUEVzNVZ4UU9pcndYU0dzU1d6Slc0OVZ2?=
 =?utf-8?B?NHRuNm50RDhER1p6YkZUa2VaNXp6TkJ5L09ZRnovU0h1WS9pMklTRDZNem9m?=
 =?utf-8?B?WXpOUzl3ZTRkQ1ZBRzhMa0IraWZ6eTdxcU1nL0RpK2Fxbmk2VTRJTGRNZDJR?=
 =?utf-8?B?Q3Nyb3FvM0orZmhudHlRb1JJZHpBdkVjYk5YVGtHc1poYnl0UkhHODIzNWh1?=
 =?utf-8?Q?Q2P8dTCTY/DAFhGWB+41NXZ7y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581d0106-c6eb-40e9-7fd5-08db3b355a9a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 09:07:34.5686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvPWWKFWTcez24XhLE4bXoCE8MgRvkMTa0G1oF5Fk7lFvH0mWWX+ycUrXFfZXonPTsS0bzjJJ9cKvxQcYeFK7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6932
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/2023 9:51 AM, Hao Luo wrote:
> Use devm_of_iomap() instead of of_iomap() to automatically handle
> the unused ioremap region.
> 
> If any error occurs, regions allocated by kzalloc() will leak,
> but using devm_kzalloc() instead will automatically free the memory
> using devm_kfree().
> 
> Fixes: daeb14545514 ("clk: imx: imx8mn: Switch to clk_hw based API")
> Fixes: 96d6392b54db ("clk: imx: Add support for i.MX8MN clock driver")
> Signed-off-by: Hao Luo <m202171776@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

LGTM: Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
> The issue is discovered by static analysis, and the patch is not tested yet.

Please add Version change log in future patches.

Regards,
Peng.

> ---
>   drivers/clk/imx/clk-imx8mn.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index a042ed3a9d6c..569b2abf4052 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -323,7 +323,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>   	void __iomem *base;
>   	int ret;
>   
> -	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
> +	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
>   					  IMX8MN_CLK_END), GFP_KERNEL);
>   	if (WARN_ON(!clk_hw_data))
>   		return -ENOMEM;
> @@ -340,10 +340,10 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>   	hws[IMX8MN_CLK_EXT4] = imx_get_clk_hw_by_name(np, "clk_ext4");
>   
>   	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mn-anatop");
> -	base = of_iomap(np, 0);
> +	base = devm_of_iomap(dev, np, 0, NULL);
>   	of_node_put(np);
> -	if (WARN_ON(!base)) {
> -		ret = -ENOMEM;
> +	if (WARN_ON(IS_ERR(base))) {
> +		ret = PTR_ERR(base);
>   		goto unregister_hws;
>   	}
>   
