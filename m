Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B49696760
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjBNOwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjBNOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:52:04 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2125.outbound.protection.outlook.com [40.107.237.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FB22A141;
        Tue, 14 Feb 2023 06:52:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRlqaKzt9kA4XRJl4snSzGK5e9MQ0N6lhkbdjdpKvuofLMQboADcZOKqpSQDIKld0ErgUdPAw6IssnxSKx6PF83vfyXd13ipFVzEaWxlfkHPjHKiPbT4wzPXkswLzf6SNLqXK1BdkUV1mf1ip1PFhg0fOnx7wrgJCjeAMBEtUD5IT2rDj5DhFKa8hPQ4otRIwyhYWHxmWUEBJPF4mXUFfKd7cDNGV5enlf3cXqDSNYKYLjh28kK6utC5ezbLcS3qnZ2GQ44mHInoPF2JGmqp0Vr4qinYXbex9vi8d8Wuo4Iilv+v5wV5rkMRZmv/34yIrvEt8lhl+lrpEeMfTRd09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCp6qTQMGE/o+fvRqXhNvtp4hxMet2rgnOgvfOp/6kg=;
 b=bwQm3ezvLlCYJN6XEzQH2I6ZfWjIToekhqq9qNB3cLQHQbmqjspSq8TGLcOrs01tzSHGRY4czvXecxPMTNPdFKH1L6TZnUa3Vgrw/ieGJDhmKPj+6BHKSCAJt6RyWicbbuIAvZUBNj+MhB0nBLT3CV9F69uoRfYrjw8L/UUrZ8mwHxxsjgvKK5Q2SJVoZtOzAOX91+CucZzRz6+aTfG9CF6k3611cMTYGGVo5ovA2G0F1TKXC5nHDdKOEy7VhL8UnHRvT1DuyE0qTeWZiRFeRTcqqWlNBRyaB4z0Xqwgl4+peDodYahXf+h0jBdcYPbnMrbvccfcIQbzfeymwlyaBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenbrook.com; dmarc=pass action=none header.from=lenbrook.com;
 dkim=pass header.d=lenbrook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenbrook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCp6qTQMGE/o+fvRqXhNvtp4hxMet2rgnOgvfOp/6kg=;
 b=UBJRDP9vWqB5caiwFN4CCBmyEwvyFXUuaJR/31uId0Od949Rgb/qF5yR9n2PBbZ/YGZZwWOT1I9sW0SE+1+wb3uR56FbYn7J1VlaAFjVy1C2lju8xznezIkfaqrRcrKGPkxfeFIHeaDV9tkFQJ/S01bks2QUlyU2fkwaja8jDf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenbrook.com;
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::12)
 by YT1PR01MB9209.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 14:51:59 +0000
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2d78:f682:1d5a:863e]) by YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2d78:f682:1d5a:863e%7]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 14:51:59 +0000
Message-ID: <3693d66b-801e-dc31-15ee-e010f2577655@lenbrook.com>
Date:   Tue, 14 Feb 2023 09:51:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clk: imx: pll14xx: fix recalc_rate for negative kdiv
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221210203835.9714-1-kgroeneveld@lenbrook.com>
 <21e4cb835f678faa911ef97d28931246.sboyd@kernel.org>
From:   Kevin Groeneveld <kgroeneveld@lenbrook.com>
In-Reply-To: <21e4cb835f678faa911ef97d28931246.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::22) To YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB9670:EE_|YT1PR01MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: d321b4fd-2263-401a-549a-08db0e9b0624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zf/xMFZF9BOUryVhLGKOLK+1qwAGDlZO62wjmlIjiLsY4YhG5NyrR/9QuN5c50ooW/82z9PEB0Y0bS+W/wxTO1nxdCSFrnMHiuhsGGaTm+VzQHXB+MRLFNqaTHv5UpDagdVZ0h/emqArySRr8s1bDM0it8HBUhUVMhcppBst/VYvsbTTOadq8HEtEVZh38fiBYJeTzYgL1W4ayLXBBJGvbPmWUlIu4Lt/GPq7Iw0+0TTdsD8YyYxn8GS9iRsU8Do7MRvLxCtbXdV7BJoSYFI0cjWRvU6gh/6WxGtAySDy+uRtV09ysi4hV7QHaK8pPbBn+L5GY+8H0giNunX5SZXjQbJVymPa+6wH/2kqekNOiaWZYO7ktAo5FbQntFSHpvC06s5SLNGzbDc3qzqxlEEYzxu6Q0sK7YMXAJzWOWtIsR8Dk1eqfwJPwXS4zY/lvYq5XgR0TqJSkhWiyxQItBBCW5J2T6k0GbANdyEFWR+3SuS75620V6LmtaXyNGKMdrYGgPFzoGKihx4EoQR30h+jBZ+SRJrkqBXMrWKcdp3Wqt6jzC1DvmJ274Mx+X6uelU/+xCXqQdbUYI8651FD8byp3/b54UsZlOUFapvDam4Et1/eepU6Jh+nN2ThMiZAx+kfNd5Tlz6xQGaPX2TbyreO6mN29zN/qgi/EUMFs1fJKDcTXm06EEF4elfPjBv58Yd90oGffc/B9XmXB8m9Fth17/3rMSpmf3kGifB76490YC9+uUd+XF7Q1q9W1ek17X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(39850400004)(376002)(366004)(396003)(451199018)(110136005)(2616005)(6486002)(36756003)(38100700002)(53546011)(6512007)(6666004)(6506007)(186003)(26005)(478600001)(921005)(31696002)(8676002)(66556008)(66476007)(66946007)(41300700001)(2906002)(4001150100001)(86362001)(316002)(31686004)(5660300002)(8936002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVhHaGdoYkxDbjJ5VnNaOGdCZzAzdkZpYi9Qb1VhMUZ6b2szRFFyU1A0a3BC?=
 =?utf-8?B?UHdwK3ZzTit2YXBtdVVDUExGOUlabGRIWDJXSXVGWFFtcG85dWlWMVAvT0d4?=
 =?utf-8?B?aFV0WTJsckloVU9OWi9KSVlnRWcvYUx0UUxPVVNBN0RYK1NZUW4rcDRaUWtx?=
 =?utf-8?B?eU5Od0dYVFhvNkJ0VU16YWdiNWZEK1VlYlBqMFdIT0RxZWI3ZCtuZ3pqOW5u?=
 =?utf-8?B?aFJXTDZQQm9Jc1RrRmVXZUlTd2dtYkJudUFwcmpmemtrd2ZCU0NVeTRpdVNB?=
 =?utf-8?B?dk13LzU1QkZYWUh5TDkrWENZcGtxVllOSXc5Uzl0RHYremJkckVBV3UwcnhC?=
 =?utf-8?B?aVFFUUY1Qi9uTWRLZUcxTEJEQUxKby9lNXB0M1FZejQ0RGIwSTRzdDFKckxL?=
 =?utf-8?B?VmVZMjUvNkprU0xXT0tLWW02TlJMeXNiVU5GREY0NnNickluQjQ3bFYweVNL?=
 =?utf-8?B?d1o0YnoyUHE3OWFnUGZ2WUwrN1cxcXFQVDFIZXhadDNpRlRycCttN3k0NUdL?=
 =?utf-8?B?MHF2U243dU1OYU01aW56TmphMEJhako3YXNOOHRmeCtybkFuSG44RWpMazBS?=
 =?utf-8?B?TTZFYjJWT3pjWE8zaVBXOC84VmZEa3JqRUN6Rk1YZ0JJTWhTOGVyVXpDMGhW?=
 =?utf-8?B?THh2VjM5bGY3c0dVU3djbms2MGYzWnhOTEVWMlViUWNjWkVKbVpVdzRsTnJH?=
 =?utf-8?B?UnBZc09mak52dFJ3WnhCY1hXVnJtcENqYU5KMHFnN2dvMFFEdzhLaFp4SFl3?=
 =?utf-8?B?ZHdvVEJrRGM4Vi9Yb0MvNXRtL2xBZ1UyZzlJVVlVUjNyVitiZHd4NHg2bTJt?=
 =?utf-8?B?SDB5bGN3WjVKamF0RGpQeW5tSDhMZWwvekVQYVU5MXRqZW1aajExTFVNK2tY?=
 =?utf-8?B?ckpjWnlheTRSQjJmZzROZ1BzbTJWT3dBQ0tQUUdSTW93a1NHbkdlL3g0TExJ?=
 =?utf-8?B?ZnNLVHdYaXVPMTBmSDluQk5xaFZlSm1POGRTOTQrbmU5aGhucjlmWnRnYXZN?=
 =?utf-8?B?dXJ3QWJXWWNtY3MwOUgwckhscFUvaUxzbHdHUTlwekppNlhWL3dxcGVEWkY3?=
 =?utf-8?B?Uy9WMjg0VUtNTTRBTmw3emdGU3Izazc4dlAvMVVNZFJZRDBib0NsNXV0TUtX?=
 =?utf-8?B?TWtxQ3VvbTVWb09XTjdDTnhGWmFZdFZ4ZytndXRGMnY3Y2dwUlE1QkZKUkIw?=
 =?utf-8?B?T3JIbm40azRNVGZuUjFacm5DWmxQK3lQdytyOFJMMEVHQjFaWVRkSzFxTTky?=
 =?utf-8?B?RUVRRnlHUjZ6U0F4YnpXV1ZMQm9YL2tybUx1VzArRWMrZlZXMnJGRTU1aHFF?=
 =?utf-8?B?SGxuRVcvYmxkR2xkRDZJYUhEOUZ3eGJtT0k1QXhEKzUram5JS1BQRnhBVkli?=
 =?utf-8?B?QTNXVkllM21Cb2pwSkkvTFRya2hBeWRZdEVuNzFYV0FwVnc1YmRocUM4SlZD?=
 =?utf-8?B?QVRXMmU5M0gwUHJxYnZMOGNHTTh6Mk5xc0NGWUtDcEZqd0ZhQWJYRmNSWFZh?=
 =?utf-8?B?ckk0RkwyMTBBbWd3NXRtMFFMUVY3M2FxZEl3R2FYUUJwYzZ5RHpIcXpYV1R6?=
 =?utf-8?B?VEJ0RHNadmU2aXlMbFNqTzlzdlpFbEVmTGJhZ0xjWmZSMEZhczZvYzV3ZFZm?=
 =?utf-8?B?L2xaMWtFeFpPQThLL2JWV1lXZ3VEcFVsUkhWeVpYTm9rOExTVXlOc3hVL3Ny?=
 =?utf-8?B?anBmL2ZCVXBNTy91UVg1QTkxc2o2MU1zOGtEbWk0QUpOZmt1RGJzOEJLanJ3?=
 =?utf-8?B?TzByZ2pnVVFJelBtbEdrRlptc0ZkakdEQWl5OHlhMGliclpQNGdaQmJSem1O?=
 =?utf-8?B?T3BlVHBNY2thVGdleWZId2k4eVIrSVQ2M1NyT1dHMVNRNDNBem1McGFHQWRR?=
 =?utf-8?B?SjdYVGhtZVl2eW5zSU9FVzlNcCtvTmZRKy92MEdXcWtyYStzcW1rREVucTlM?=
 =?utf-8?B?cEpjanllNis4SHRRcXN1c0lqQlRERHlGam5Sd0FxdnRONmtrUExMTTJuTVJN?=
 =?utf-8?B?NDBHQUJqZ1ZvbUI5K3dKaXdTb2Y4MlJNUGRpUkh2ODdiNzNDVjJYamFBQi9B?=
 =?utf-8?B?b1E5VDF6S1FqWFV6R2ZOYk11Z0RsM0s1WXNHbzd0eHYydWorUWhWUEYrb3hi?=
 =?utf-8?B?Q2owVnJNZkpHYTM5WFlvWVJBcW1EenBBZ3hST28zMmZ6ZFFDM0ZhcnNNN0R4?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: lenbrook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d321b4fd-2263-401a-549a-08db0e9b0624
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 14:51:58.9914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3089fb55-f9f3-4ac8-ba44-52ac0e467cb6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Az81y49N+Uah/lfUpDOEhyeS4suyVUraXEejuTsodzbOHYLjLemkaV+l7BuLPnZsJY5ixHAHJScUVObPV9xJPuzS+0k86bTxcOWzXeH7Ehk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9209
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-10 18:24, Stephen Boyd wrote:
> Quoting Kevin Groeneveld (2022-12-10 12:38:35)
>> kdiv is a signed 16 bit value in the DEV_CTL1 register. Commit
>> 53990cf9d5b4 ("clk: imx: pll14xx: consolidate rate calculation") changed
>> the kdiv variable from a short int to just int. When the value read from
>> the DIV_CTL1 register is assigned directly to an int the sign of the value
>> is lost resulting in incorrect results when the value is negative. Adding
> 
> Can the field be negative?

Yes it can be. That is how I found the issue as I had a negative value 
in imx_pll14xx_rate_table which used to work but broke with the above 
mentioned commit.

The i.MX8MM reference manual states:
 >Formula for Fraction PLLOUT:
 >* FOUT=((m+k/65536) x FIN) /(p x 2s)
 >* Where, 1 ≤ p ≤ 63, 64 ≤ m ≤ 1023, 0 ≤ s ≤ 6, -32768 ≤ k ≤ 32767
 >* p, m, and s are unsigned integers. k is a two's complement integer.

The comments in the imx_pll14xx_calc_settings function also mention the 
same range for kdiv. And this function also uses negative values. For 
example:

 >/* Then see if we can get the desired rate by only adjusting kdiv 
(glitch free) */
 >rate_min = pll14xx_calc_rate(pll, mdiv, pdiv, sdiv, KDIV_MIN, prate);
 >rate_max = pll14xx_calc_rate(pll, mdiv, pdiv, sdiv, KDIV_MAX, prate);

Where KDIV_MIN is defined as SHRT_MIN which is negative.


Kevin
