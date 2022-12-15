Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908B864DE31
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLOQI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiLOQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:08:38 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF64431DD6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:08:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlA3M+9IDOoSsU8xqVdOFKraBlmtHY5f7aDFh5gBqrQlEXc+Qh8+nLqKhm9PTOmhXTE563C23qmqGYegFIpAJyI7CKBwOqAaOszDK9MFAMDaNEavdYuDFq71pKXjimJvg/t1K+cWVKdNCwb6P3ql9Qaxipl5F7e+NOyQTkgPCbnNvrpSMpcA9+rPe67xtuP8kIWCFJBvs4ECc1J5kx4xKNyeockzRq7n2WVRH6it5DmCHnjjbGfkufFSsgOlywY8D5SCIkwhC5McDtfxtzqGkbrrD6o3IeVqLkHqL9h3Fk/KRapYw4XhfkRkx9uh+qVWqfDtNeT3PxLnK8+N21nGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9RMwUkW3d6whBW2iOEWFiWCXJrSQiCrBD/vFF20DxI=;
 b=T+let/Gh6/duj0nEnVeOC78MeAZimyFpjq0U5lzndoBY7s15xsOkby52yJH9jki9+iDxbQqs91FG5SbDK7Qf/RWjwQ5lTh21c2ZyINHbznkaW/7gde7h1jorRHJIyE4DqT3/AF9b6J7DS2VhVUgVR7tetwlidljfxirH3h6O0PnB91+DtJKdc9uD48DRp3LEAhZdtvSDw1OlOz8N8ujIZa/pfbOu8X64Ys0g0opOb075qVCTaiySLgmhHiWsZFzevchIgxmbikJuvz9fJlYAbGr1W8LRAp+KrBqRNUhyKmuT+6Oa8y6cP1ieTZICGfa5u9SG8rJRDudQvaT9tJf6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9RMwUkW3d6whBW2iOEWFiWCXJrSQiCrBD/vFF20DxI=;
 b=DpnZADL2XcW6VDTS7mbyFhmEYaiqcrTvXfpn8AeXReosv7o9sMCvivmG/AiaH0PhD/LleltmGS7sSbvfu3NyTXuvuffhZ8SeH+PEGN4izh/BwaWo4Y0XesEW7HtwhA0LTT8elHNWQ82lTiDxRStKIqJ8Uy+TxYNGSjSVTGKi3ARXYta3dsaET2JdWvnWhGsX4xHhA0FZUaKv+iyBX0Wm2qIJU3j69V03guwmqhkPV1QGkCy2VmLbMCpl3Cr9lyHdBFM65bQEekW/cZ757Af8UrcFL18DvBWY8sRYyy0yJgY14FkcuHupRG7Vil1KNblDWx7HCRnMqSi1InXi4KpXHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AM9PR03MB7790.eurprd03.prod.outlook.com (2603:10a6:20b:3df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 16:08:32 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb%6]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 16:08:32 +0000
Message-ID: <423e3575-e8d2-f100-1f9c-43c195139f6b@seco.com>
Date:   Thu, 15 Dec 2022 11:08:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [v2] pwm: xilinx: Fix u32 overflow issue in 32-bit width PWM
 mode.
Content-Language: en-US
To:     Kenneth Sloat <ksloat@designlinxhs.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SJ0P222MB0107490C5371B848EF04351CA1E19@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <SJ0P222MB0107490C5371B848EF04351CA1E19@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AM9PR03MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c1e0ce-98d3-4f2b-33dc-08dadeb69cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BuUqfogyLxxiwGhNdEoSn8ldT7KOJSKJFZgn7wh7Lcytb0U6NWkFAkKHOo2D5YDhvpsqc/o3UCGy3SqpT1JVaxm4cNjZLWFN4AZcHFE88Dhg5bxLEPuFfJ6xevAaNQC6glY11cIupvobPVoHRNsJBgfjHD1QOYyEPqT4KC8p8GWwYR9wuxTzvT+B2bAnLduOTNL339pEEP7WqMDJ3Joal1Q6B+Hr+/K1Ik4Fh5edN9dIut/TLCH/bXM2mCCvfzm/tc2KKU57wdcjsjlfA+ZStSAS6rDq4nYwzmIayh0p8ccLTUpqAnlUoet+TreAIPw3RBgr7J7Iwf5fhu4JMozfHxbCjyVomEi0j0o1UstvcChRGr40qGlLPFQre+h6yPgtqaU18K3pQ61gbJljQ7dsquD/QxVMIr7xFrp5GmHMjaYaeCzfLnKNQJ2UwzntJ6eQeYHy7nbNdSYicmluc6IeORm6yB9bU3avfroQF9CuoMbwtIIq2Mwy8FlMmvpTAX8A9fkVubP/APF6OnpODAbOaBZKrr/0LyARxGOUbag+lHW96Cs0Zi4HEmLLCYtGIOZc/7YA53AbtHebDMf3jMv7LeZkByG+5V3z+mENf+h/kBhyIXbwEehNCiJxZIUDpN8fV5TwbhegF//Fp9wK1xEY1LxahBLxYMIxmVYbP38Nn/oCrdGA+cX/usNT5Q4sEOaQyhux1DJsn0Km5k5yfdG5ml5zs/ubgYlRbJFiUtibqozvSwNcphd7dwx4TR0/NYtRJjX387qGpTiR14GI8s/0Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(366004)(39850400004)(136003)(451199015)(6512007)(6486002)(478600001)(26005)(52116002)(186003)(6666004)(53546011)(6506007)(316002)(110136005)(86362001)(31696002)(36756003)(2616005)(38100700002)(38350700002)(83380400001)(44832011)(8936002)(41300700001)(2906002)(31686004)(5660300002)(66476007)(66556008)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TC9YMkZjbDNSZTdEdS9yc05tako2djBqd3lHRmhtL0JaYVpDdzZaU0V6ZUJJ?=
 =?utf-8?B?Rm5YNnplNTkxUUFsR1o5K1p6Qk1aNFB0RGdMbm1xUFdqTUNHaTM1Z3hsZnVm?=
 =?utf-8?B?Y0RqQUprNkF0ZE91MEdXTUh3UnZwSEcrd0hCdGxtY3ZEeFBIdjh5VVpEN3RB?=
 =?utf-8?B?RXFTQnFHbklud2w3SXhDcEFDVDlrUUtENnRjRG8rZXVCYkFvYW54NGF1Y0pt?=
 =?utf-8?B?U3JkdVZwL0o0SHhwMHl1ZzJzTXA5SVhYd0ZZampPdllvaVJtQTBnRktrZ1dH?=
 =?utf-8?B?TE84b1dlM0M2bWpoMmR3MUdBbHNDWit6UUxVckNBMk92SmtWVGZTQ3VPTHZa?=
 =?utf-8?B?RUZkeERyaGJOQUZwZktBMWc5VW9QaEwwd2l3bnlaU0FHZlh0QlUwYmJKdDVz?=
 =?utf-8?B?N2FBVUJzeHJySHVvUW9ZQ0hEcUZ5WGVJTm56ODR6RXd1YzZwK0kzVkJTaTJ0?=
 =?utf-8?B?S0NkWkMvTXBvNUtzdDJLRzZQd0VhSlFYUkExYUltM1VJY3dNUndPSUIyajJM?=
 =?utf-8?B?bzk2Z3FIWVZaZDFLOHU1SnFNS0d6eUlBNVRNdjVqb05wdmlJcE1XSHdPenEy?=
 =?utf-8?B?NzJSRWRvQWt4aUJwSFYrU2tESjg3V0JOWU5nS29lR0pkNVNlcU1QTzdYU0dw?=
 =?utf-8?B?QjcwRW1zbVBtN2hIZVpLNVVjUFYzdkU1aHF2d0wwempicWdzdXRiMXpvdmNO?=
 =?utf-8?B?SjUydXVRSzRURUdlZTBKQksvVWtoaVphS2U5SjIzTmVpOFlaOWt3NGkyVEMr?=
 =?utf-8?B?S1IzMklrR3o3amlZMSs2TlhwSk9GVmNjeTNwYXhiWHFHUUJ0VHNGMVpESnZt?=
 =?utf-8?B?STNwTkYxclgzRytFeEFWZnZJd1VXK3cxajRzdm5UTHZqTXRmV1ZOQTZvSTJq?=
 =?utf-8?B?M2tDQmFwcVprTitUWXpudmFjRUlsOE93SjZwUUlSQkwyWXRFQ08wRUsxNlNl?=
 =?utf-8?B?U0dNOFByNFVOczJvbzUrb09kUEgwOE11cm9temxlcUtsS1RaWW8xTXVnNTVm?=
 =?utf-8?B?NStRaE1wU0tYVXdjaFFQcGlBSmUxUTcrZlYwdkc5eGplalBYd0l6bC9yUmkx?=
 =?utf-8?B?blU0ak9EZzhGRUdjVWFRcWxBUXMrNGIwRXVNOVN4Z0ZQbDFLNW5CRk0wMmhE?=
 =?utf-8?B?ay9iOHpMNUwrbUhVYlZ2NEswN3M5VUloT252RlE3VW8xWWlyQUNLQWd0emF1?=
 =?utf-8?B?RjkwRXRtSi9SV1JjeFBNcUozYjk3c2lxb1NmTWQyU0RxcjhpQy8yTjRESW5G?=
 =?utf-8?B?QVI3VlB4bkNTNXFKTTNmS3RQeDdMclB1QnFXTTZTRVZwMDBoZGtmRGFXWXRy?=
 =?utf-8?B?cnRkSHVzUWFzUVc5Z1M2OERLTFVZQWRscW9Yb0l5TGtIc1BNSGFCWm94NkdZ?=
 =?utf-8?B?WHhtMEIydzQxbGp3bW5MdG5PNmYvemU4T3dJbnR2L3RRUzhvYW90blFwbXh6?=
 =?utf-8?B?TkZrVHpMSzV3NjI0V2t6M1BVaVlSdlNOa0NlUnFuUzdaN2tvVnBPNVcrUjc1?=
 =?utf-8?B?Z1BKaTd3VVd1Qk8vMmJVODFOYlU1K1FYT3kyZUNaN2xpcEd6SGtIUS9Faldq?=
 =?utf-8?B?dzJTVWhGZ3FtTC81b25HSEdLN0oyWjZGbnpYNWVVbUxDcVp4V0Rxd0JTRXdr?=
 =?utf-8?B?NnZodExOT3JZSE83ZjFwTVZoYVNqTzhGdlpUUllBb29NVzlMSHVpTEZhSllt?=
 =?utf-8?B?a1hIN29ncm5RbzAzbWxHKzhuUHpoM1BTci9leVl2NjhmRkpiL29lUHpPNFNq?=
 =?utf-8?B?OW9zWnRQZ1JvZ2NVTDhwblF2RWl2N1hqNmUrUjFmaW56WWd6Q0t1cmZDVXNM?=
 =?utf-8?B?MnZ2Rkp1TE9hUm55amx0SWtBSWFZOTZONzRKYmFXaCtMRktzbnNGcTFaNjFW?=
 =?utf-8?B?QXMrYmNDY3Y5T1E5YmRpZkYxS2ZtRnpXTGFaVU9WNXoxaVZyQUR4TGsvWkNn?=
 =?utf-8?B?aVVISVdBVFdWRk0vYzA1TDRDR0hjZnEwMEdCL3YxOURxakFwU0xDSFMySzBh?=
 =?utf-8?B?eFJvT0pMa042Vmk2MG9qYXE4aFQzNkVlMU9VbTVvcm9BZ1E2WTFrQyt1cGZu?=
 =?utf-8?B?cmd5TkVqSjE5WVB3UDgxZ0FWa04xclc3Ty9KUlNPY1FhMHh3aXJPN2NWaXh3?=
 =?utf-8?B?RWNqOW1qOERGUmo0V0gxQlBOOWY5cWFyRThqU3VHTm1ZQ3BPR0diM1hJY1JQ?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c1e0ce-98d3-4f2b-33dc-08dadeb69cdc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB8847.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 16:08:32.4999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMpHfQUcgkVnrwnOJAR0xunr4bwsJ1c33xu4HjTh5qKlxWU5r83pSDui5DtJIOQZXnfpHIUytoNAuHPXsmkmTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7790
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 11:07, Kenneth Sloat wrote:
> From: Ken Sloat <ksloat@designlinxhs.com>
> 
> This timer HW supports 8, 16 and 32-bit timer widths. This
> driver currently uses a u32 to store the max possible value
> of the timer. However, statements perform addition of 2 in
> xilinx_pwm_apply() when calculating the period_cycles and
> duty_cycles values. Since priv->max is a u32, this will
> result in an overflow to 1 which will not only be incorrect
> but fail on range comparison. This results in making it
> impossible to set the PWM in this timer mode.
> 
> There are two obvious solutions to the current problem:
> 1. Cast each instance where overflow occurs to u64.
> 2. Change priv->max from a u32 to a u64.
> 
> Solution #1 requires more code modifications, and leaves
> opportunity to introduce similar overflows if other math
> statements are added in the future. These may also go
> undetected if running in non 32-bit timer modes.
> 
> Solution #2 is the much smaller and cleaner approach and
> thus the chosen method in this patch.
> 
> This was tested on a Zynq UltraScale+ with multiple
> instances of the PWM IP.
> 
> Signed-off-by: Ken Sloat <ksloat@designlinxhs.com>
> ---
> Changes in v2:
> 	-Update commit comments to explain specifically where this
>  	problem occurs as well as compare solutions.
> 
> ---
>  include/clocksource/timer-xilinx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/timer-xilinx.h
> index c0f56fe6d22a..d116f18de899 100644
> --- a/include/clocksource/timer-xilinx.h
> +++ b/include/clocksource/timer-xilinx.h
> @@ -41,7 +41,7 @@ struct regmap;
>  struct xilinx_timer_priv {
>  	struct regmap *map;
>  	struct clk *clk;
> -	u32 max;
> +	u64 max;
>  };
>  
>  /**

Reviewed-by: Sean Anderson <sean.anderson@seco.com>
