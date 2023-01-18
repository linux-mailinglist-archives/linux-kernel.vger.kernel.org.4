Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60174671E83
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjARNws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjARNv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:51:57 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A300979281;
        Wed, 18 Jan 2023 05:23:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2UwUoE05SxmWURc0Sn7j8vlwBvBzHMWdl0he0ueHqu5Ba1XSAtgvUlKdzU8FybbYam5o1zigZuOgaGYoVvZP9UlApqGLt77lFYmjzuLERcmlupqIcl8nOLxZwOjmIWjwciml0Nayc2BrAuuP8C625PRWui3QKYnc0J9PAqVkmqH1Fto1vfhu2Ux7DCb+dx8NoZvBlbtGkOawrLJruyomUDBWpcgNvvrIWJNGiXI0zMVYbukV69dFxCHhrJpFJLWEAt8a1dXzTk+fQfoIeiESdZrvCiC2ne20z9HEXmFe3DGPCFn5sOzskcdn43bmL3NkvgT4/IdePjBnVWSAHHfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kluzBRc+6MD1EE5ewuEZS2rnmzyeiYc/a9BKmjw3NSA=;
 b=ktZ7RlZjtw2vSOPiAQcV71OCGoswKP+MzLqALnmC+6eUwgO671JHCUTKkkfN8GEYX1TtBbHpngoLCX+7fAYwCOuvl1B6XBg8Yae5rLTIxKGfsHvtNtyczOQUISl80A72qoUNQlr4Bzpe1dryOj0x1t0qD1vb278gnq4AKjT//fwv10V/kIUkv33fbNVrumZCDRNtYtlWiSEdlT2eHzuMCzwfKItJXx6bgoRwFR3imfJh6OVajCzE2PppejNmCsBwTNmyV7/RYY3syapIKY0kpdPB63ColN1dCgotTZy/+NvfJSbFLg3LYND5frbs152sQbscs3RgVerrq3MA6wDplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kluzBRc+6MD1EE5ewuEZS2rnmzyeiYc/a9BKmjw3NSA=;
 b=EQIrsNf5M841eEoERad/v57UBcwSQrfzXLMfPm37cezHVnHMSX+Ss2JDpWypMdLstL2NSyLvRQCFQB0Qp1ChYQ/bVJmHpZSphU4GnLmACJUgYg8bD7qYRv/MTzTHBn9kT3bRHWbcKjOj5/M2IWP4D0YwlvjtnsqZgHwfdK+AU1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from AM0P193MB0738.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:160::8)
 by GV1P193MB2312.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:2d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 13:23:15 +0000
Received: from AM0P193MB0738.EURP193.PROD.OUTLOOK.COM
 ([fe80::9506:ff7b:ae6e:e51a]) by AM0P193MB0738.EURP193.PROD.OUTLOOK.COM
 ([fe80::9506:ff7b:ae6e:e51a%3]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 13:23:15 +0000
Message-ID: <72514fec-12e2-5b51-261d-9e171b46f5bb@kunbus.com>
Date:   Wed, 18 Jan 2023 14:23:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 12/14] rtc: pcf2127: support generic watchdog timing
 configuration
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20221215150214.1109074-1-hugo@hugovil.com>
 <20221215150214.1109074-13-hugo@hugovil.com>
From:   Philipp Rosenberger <p.rosenberger@kunbus.com>
In-Reply-To: <20221215150214.1109074-13-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::15) To AM0P193MB0738.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:160::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0P193MB0738:EE_|GV1P193MB2312:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d94d981-8f0b-44f2-8903-08daf957280c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Bq/1XgSfMhbnc8UbgcYOKNuFU8xNPNA/rHYosrdjgSjsoLTWXyukwIqZQUsUv9JcwdXPZsN6dHIxPbpS4BqSPBhEzCeumcqDebb8C7Mya6hzc7t1s+XdRQq0U3o380BcF8zjZNnGTfQH6lq6VSM26UB9KZ+P2XM8oPxdZIM6fjd3PSiSFKyezdkIqRI7lJyajOVEzMa++gEXiYYLw6WiQzh6/m6At9ufYZ0wxve1m84Ex4TL06tKxT4od3u9CMQCfkbCGB0FfMCcUrVUA4NHJHVZVx4mR4U63rSHW5yhC5oAkh4l9gvcai3mmpqGEqaipVIcbaeNmHYGnSDe31/NdNoCoUhP0puQU0g54k3E1LrJ31mGOSKrRqTkT7Q4HbsBCxAdLnIctjvl7yPjSaVNXHjeGMUVgJV6TTdf4MT3bNYEnb1e634H5Ou4dR3jC2RJCK4PFrcfFcVF+zM4rIYJ61hRQiN2Nmiw64aEzSr2+c9lhhXkZSge+8e173g3V//9pPtAY/f+4jTLVU2PYDJPOM+2Tr6r9i3nLkRDxdUz/9/CAOTWx2VrJMCz1Fxuu+sdukfpSgBSTcq+8UD75oYh0biD1VyddgAQI2Kg8QMdMH0Rydrzz+g5ZFbfm9ZVdnPBJyMwSYMvWabf9bQdTFAvHfIhybhR+TkR2S5uvaqzL6f0UC1xPOTcfbX5OSbKB3WbXb/5ai7WVfRPNK/jPnv8j81j+SxKuWJoLfzTlZCKZdxUlTWT2lbfwnSXTosTjAL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P193MB0738.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(39840400004)(396003)(451199015)(31686004)(86362001)(2906002)(66946007)(66556008)(8936002)(5660300002)(31696002)(38100700002)(66476007)(316002)(53546011)(6486002)(6506007)(478600001)(36756003)(8676002)(4326008)(41300700001)(6916009)(186003)(6512007)(26005)(83380400001)(2616005)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGpqcWUzTU8wcXpWa2N5c3FTekZjU25kS3YzQlREa3dLRzRPTUF1bjBkbloy?=
 =?utf-8?B?SStxUndBNjI4Qng5cGRkZjlxUXF4MkRDUjBLMHdtMCtocjljMktFMEU0MCsr?=
 =?utf-8?B?VjU0YUEyY1lnWC85dFl1SXcyN2JZeDJmQ3JBRlMzTkVDYTVIU01CbEI5SFha?=
 =?utf-8?B?ZFIxNk12Z2J6dWdHUkpNenVKRzFydHpNM1Z3YlUzNTdod0hqOGlIdUR2RXpw?=
 =?utf-8?B?aWhZeTNoeHJiMkRVeG9mMXNyWHNpQWhwZlhNTC8xbDBCbXlENUdRbjg5MnNX?=
 =?utf-8?B?WVpQNlVNNzQvZmVJNENLQXZKb1dsR0RFQ09FaHRsMG01VGZjS1FCWm8wdW90?=
 =?utf-8?B?cnFPSVVHdnI0K3MxbE44S08rTFl0a3BLNHFVbUQ5Sk50dHlBQWRzRnAzUG1S?=
 =?utf-8?B?VmJ5VmFuSnVDRW5DTlJVOG5ESHByOXFlVExhbW55Z3AzTC91dmNCVmtoNEFN?=
 =?utf-8?B?RzhPdldsZnFyc1FQSktMM0RXcm45eURoS2hVNzJkUjc2WTBNbEFWWTR6dGhS?=
 =?utf-8?B?Ymh6ZjFkQjBJanE4aitLbzZIYXRESEgwQnQ2V1RMZmJBeENKTDNPZ0o0c1hJ?=
 =?utf-8?B?R3l0dFZyaXY3TXo4b05SVVphVC8yYU9lUk5jWktWT2Q3QXJyWFppbHpaMEQ0?=
 =?utf-8?B?cFhmMk5ib2pieXQ2VUFLR1Z2blZvK0RlTWJYOUFPSVlPUmRpUStZdnMyQm02?=
 =?utf-8?B?QXloWDdyOHY5ZFBPT09qbmJ3VE5GSWZjdGhPUFlpOEdEZUdYcndpZVpPbFNV?=
 =?utf-8?B?eVpUUXg4ZUlRKzI5R2JLNU81M1VJV3IzSU1DVFlJVVZsZ2VTdmVtMi93U0E2?=
 =?utf-8?B?Ri9nUWFtM2JHOGZ5Zlp6RHlEaVliaTU1eUZhSjBWRFJXSnRMbSs2RlpocXJr?=
 =?utf-8?B?RkdoblE5SDVjdTlkcTBmRFp6eko1WVlsYkZPMmVLZ0NKK29keXhUaElIbmxl?=
 =?utf-8?B?a3NxeHc5dXg4SlFGbHRKSmR3Z1JVZFlBTVoyYVppMDd2RFgyWTUvUW9sZjNs?=
 =?utf-8?B?cjVkWjBoUWV2Y0Ixc252WC9DYUZsQnowOU1xR2N1QjFMQ0RyV1Q2ejJLMnp6?=
 =?utf-8?B?dUw5dUNXZ3VTejdjODh5OUw5bm9tdjVURXBSZ0tnVlJrKzM4SXJPU1lCbHZT?=
 =?utf-8?B?SW5pSDZWVzRHN2tKaHNnUi9ST1c2NDhBdXExVkd6RVVjdHl6NlVXYllEdEFx?=
 =?utf-8?B?MlZQSWc5V0xTTEJtdEQwVnlSa003TVEwYWV2ZXZ3djJVQlN1Sjl6ZEpaeWln?=
 =?utf-8?B?ZXlBOGJWWStKMmpiUEQ2U2R6bHhtVklEVTRJaU83QjhyekxrY0ZWM0hidWhR?=
 =?utf-8?B?QjVadlNoZnE3UW5tYkcxdmFJU1orTjF4dUd6bEJXNjB0RWRnb29qN0JpT055?=
 =?utf-8?B?VW1OYzUwblJDVVlQcnpLWUtKUTJxSlA2eGdldDNnT3dXQ1lnQ3hYb083d3k0?=
 =?utf-8?B?RlhLUE8wMUg1a3phQUpWZEQ4YzNFeENpOHdUcUdYakFvN0RGNFBhbSswTzRm?=
 =?utf-8?B?KzJUUXdoaXY5Tk1qSzIvNExpeCtCNlN3VHBMUGxXYXRQeTR1U1dDa3BZMTBK?=
 =?utf-8?B?MUs3WHdveGpSblhMYVd6QytuQ3hqR1ZUeHdBdnROblJFZzhQT04xemM2THlR?=
 =?utf-8?B?RWh0UnIxRHFUWEovVnBRNGVTeTd2elVLZkx5V056NS91WGxGQVVldW9EOVRj?=
 =?utf-8?B?Yk1TY25FNnRCaGtKSUdoNjVCaUE1WkNaZ3FYTkhtRmRJK1g3WDloODFheUZ6?=
 =?utf-8?B?dGgvWHlVVWg2dENnWUtUNFBOREswclJXbCtiZzlGQjhPR2ExWi9WazYvcGdz?=
 =?utf-8?B?cFptQ01lMGI5L2RxSVVJSHEwaWVKaThWWGdGT3lKeXU4Y3NOTStoVkZWRGNN?=
 =?utf-8?B?UnVjRjFrQVdBMklYLzZHUGtpN0tWZitWQ1pKclpJa1BoY2NLcFNqYWNaRWtz?=
 =?utf-8?B?STNyZUplUG1FRjlSRnF4R3VpZURHb3pheGc5a251NStCWnNjQzI5N3o5QUdB?=
 =?utf-8?B?My9VWHZNVHgzRzdXTFNpRzFWdkJvbTBzaEd1RVVPMU9GMzkvMVU1TmZBb2hH?=
 =?utf-8?B?c1BUeXc1ZmpXTHVqWXhYUmo2VUJWZGNTSTI4eVNpS0xOOWNVNW5oNS9lcCtD?=
 =?utf-8?B?VmNwdVpaWHM1Q2pUWmYwbmwzdVNDclE0bTJXWUtkREk3VFl4Nkh1eG9FRVJY?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d94d981-8f0b-44f2-8903-08daf957280c
X-MS-Exchange-CrossTenant-AuthSource: AM0P193MB0738.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 13:23:15.7757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnqkyOfjk+2zNbqHOW6Ln7vNQGT/kggqFPe2C4vP6HwS4DkMZJdy0/YY2jcRAIyTHQEAXA4In9q+11338921dY9yQeaRsTYRw0v/FqUbNAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2312
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugo,

shouldn't the timeout set with pcf2127_wdt_set_timeout() be in seconds? 
With your changes this value is dependent on the configuration of the 
timer source clock for watchdog timer. So with a default of 1/4Hz this 
will be almost seconds * 4.

I think we need to do the same calculations as in the 
pcf2127_watchdog_init() when calculating the timeout from the 
PCF2127_WD_VAL_DEFAULT.

Best regards,
Philipp


On 15.12.22 16:02, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Introduce in the configuration structure two new values to hold the
> watchdog clock source and the min_hw_heartbeat_ms value.
> 
> The minimum and maximum timeout values are automatically computed from
> the watchdog clock source value for each variant.
> 
> The PCF2131 has no 1Hz watchdog clock source, as is the case for
> PCF2127/29.
> 
> The next best choice is using a 1/4Hz clock, giving a watchdog timeout
> range between 4 and 1016s. By using the same register configuration as
> for the PCF2127/29, the 1/4Hz clock source is selected.
> 
> Note: the PCF2127 datasheet gives a min/max range between 1 and 255s,
> but it should be between 2 and 254s, because the watchdog is triggered
> when the timer value reaches 1, not 0.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>   drivers/rtc/rtc-pcf2127.c | 56 +++++++++++++++++++++++++++++++++------
>   1 file changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 11fbdab6bf01..3fd2fee4978b 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -157,9 +157,29 @@
>   
>   /* Watchdog timer value constants */
>   #define PCF2127_WD_VAL_STOP		0
> -#define PCF2127_WD_VAL_MIN		2
> -#define PCF2127_WD_VAL_MAX		255
> -#define PCF2127_WD_VAL_DEFAULT		60
> +#define PCF2127_WD_VAL_DEFAULT		60 /* In seconds. */
> +/* PCF2127/29 watchdog timer value constants */
> +#define PCF2127_WD_CLOCK_HZ_X1000	1000 /* 1Hz */
> +#define PCF2127_WD_MIN_HW_HEARTBEAT_MS	500
> +/* PCF2131 watchdog timer value constants */
> +#define PCF2131_WD_CLOCK_HZ_X1000	250  /* 1/4Hz */
> +#define PCF2131_WD_MIN_HW_HEARTBEAT_MS	4000
> +/*
> + * Compute watchdog period, t, in seconds, from the WATCHDG_TIM_VAL register
> + * value, n, and the clock frequency, f, in Hz.
> + *
> + * The PCF2127/29 datasheet gives t as:
> + *   t = n / f
> + * The PCF2131 datasheet gives t as:
> + *   t = (n - 1) / f
> + * For both variants, the watchdog is triggered when the WATCHDG_TIM_VAL reaches
> + * the value 1, and not zero. Consequently, the equation from the PCF2131
> + * datasheet seems to be the correct one for both variants.
> + */
> +#define WD_PERIOD_S(_n_, _f1000_) ((1000 * ((_n_) - 1)) / (_f1000_))
> +
> +/* Compute value of WATCHDG_TIM_VAL to obtain period t, in seconds. */
> +#define WD_COUNTER(_t_, _f1000_) ((((_t_) * (_f1000_)) / 1000) + 1)
>   
>   /* Mask for currently enabled interrupts */
>   #define PCF2127_CTRL1_IRQ_MASK (PCF2127_BIT_CTRL1_TSF1)
> @@ -202,6 +222,11 @@ struct pcf21xx_config {
>   	u8 reg_wd_val; /* Watchdog value register. */
>   	u8 reg_clkout; /* Clkout register. */
>   	u8 reg_reset;  /* Reset register if available. */
> +
> +	/* Watchdog configuration. */
> +	int wdd_clock_hz_x1000; /* Value in Hz multiplicated by 1000 */
> +	int wdd_min_hw_heartbeat_ms;
> +
>   	unsigned int ts_count;
>   	struct pcf21xx_ts_config ts[4];
>   	struct attribute_group attribute_group;
> @@ -496,10 +521,19 @@ static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
>   	pcf2127->wdd.parent = dev;
>   	pcf2127->wdd.info = &pcf2127_wdt_info;
>   	pcf2127->wdd.ops = &pcf2127_watchdog_ops;
> -	pcf2127->wdd.min_timeout = PCF2127_WD_VAL_MIN;
> -	pcf2127->wdd.max_timeout = PCF2127_WD_VAL_MAX;
> -	pcf2127->wdd.timeout = PCF2127_WD_VAL_DEFAULT;
> -	pcf2127->wdd.min_hw_heartbeat_ms = 500;
> +
> +	pcf2127->wdd.min_timeout =
> +		WD_PERIOD_S(2, pcf2127->cfg->wdd_clock_hz_x1000);
> +	pcf2127->wdd.max_timeout =
> +		WD_PERIOD_S(255, pcf2127->cfg->wdd_clock_hz_x1000);
> +	pcf2127->wdd.timeout = WD_COUNTER(PCF2127_WD_VAL_DEFAULT,
> +					  pcf2127->cfg->wdd_clock_hz_x1000);
> +
> +	dev_dbg(dev, "%s min = %ds\n", __func__, pcf2127->wdd.min_timeout);
> +	dev_dbg(dev, "%s max = %ds\n", __func__, pcf2127->wdd.max_timeout);
> +	dev_dbg(dev, "%s def = %d\n", __func__, pcf2127->wdd.timeout);
> +
> +	pcf2127->wdd.min_hw_heartbeat_ms = pcf2127->cfg->wdd_min_hw_heartbeat_ms;
>   	pcf2127->wdd.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
>   
>   	watchdog_set_drvdata(&pcf2127->wdd, pcf2127);
> @@ -926,6 +960,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>   		.reg_wd_ctl = PCF2127_REG_WD_CTL,
>   		.reg_wd_val = PCF2127_REG_WD_VAL,
>   		.reg_clkout = PCF2127_REG_CLKOUT,
> +		.wdd_clock_hz_x1000 = PCF2127_WD_CLOCK_HZ_X1000,
> +		.wdd_min_hw_heartbeat_ms = PCF2127_WD_MIN_HW_HEARTBEAT_MS,
>   		.ts_count = 1,
>   		.ts[0] = {
>   			.regs_base = PCF2127_REG_TS1_BASE,
> @@ -951,6 +987,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>   		.reg_wd_ctl = PCF2127_REG_WD_CTL,
>   		.reg_wd_val = PCF2127_REG_WD_VAL,
>   		.reg_clkout = PCF2127_REG_CLKOUT,
> +		.wdd_clock_hz_x1000 = PCF2127_WD_CLOCK_HZ_X1000,
> +		.wdd_min_hw_heartbeat_ms = PCF2127_WD_MIN_HW_HEARTBEAT_MS,
>   		.ts_count = 1,
>   		.ts[0] = {
>   			.regs_base = PCF2127_REG_TS1_BASE,
> @@ -977,6 +1015,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>   		.reg_wd_val = PCF2131_REG_WD_VAL,
>   		.reg_clkout = PCF2131_REG_CLKOUT,
>   		.reg_reset  = PCF2131_REG_SR_RESET,
> +		.wdd_clock_hz_x1000 = PCF2131_WD_CLOCK_HZ_X1000,
> +		.wdd_min_hw_heartbeat_ms = PCF2131_WD_MIN_HW_HEARTBEAT_MS,
>   		.ts_count = 4,
>   		.ts[0] = {
>   			.regs_base = PCF2131_REG_TS1_BASE,
> @@ -1215,7 +1255,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>   
>   	/*
>   	 * Watchdog timer enabled and reset pin /RST activated when timed out.
> -	 * Select 1Hz clock source for watchdog timer.
> +	 * Select 1Hz clock source for watchdog timer (1/4Hz for PCF2131).
>   	 * Note: Countdown timer disabled and not available.
>   	 * For pca2129, pcf2129 and pcf2131, only bit[7] is for Symbol WD_CD
>   	 * of register watchdg_tim_ctl. The bit[6] is labeled
