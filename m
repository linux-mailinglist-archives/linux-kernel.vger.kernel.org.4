Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE066EC3F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 05:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjDXDii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 23:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDXDig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 23:38:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E45212D;
        Sun, 23 Apr 2023 20:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHWhbxdW3X916/Dkmyk1HFyvA72SpMNOk9BvP1LHjLRks76cuhD+18Cl2ZKc5cKcgW+RNI6qdaBJD/JB7LQoKKp5x2cd5b263XAxq89a/2r+qQtk4QU/gpVJ2PMJ1Ldxqom7jorHbbQHZjpRNjhQGtgXJzwZZEoR/NwWL1b2u91k5Cc3RimUhe6u3u6EoQdsVErma/K7J8Qw8slnESql9viVDyhukHsLjSvRb82iXgphfW36cheopgWJJVtyP2F5KhzvwbdQMmX7ZzQ43Cx+HEeikpiV4CvTJx4w7AbHhVtVNRj2WipR+VaTqmcieCOb6ihvYNy50J+u6FoZBAUcnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEOedDruPju3e2YdplmfsoDKiqfGFidu4VM+NH6+kpI=;
 b=XgsZcOmzYms8fA3c63fPMBaRx62Wr8x7b8NoSkZ6Cft4K44dOhxKsw/YhqF2nntfmgazB1sYoeT6vWev6rCnSHl5afnEgJk7pRGxVUNpMEzPXeuoiqWHcCDbJ5Rnwd+4QiHBdiUF2YIBa1gxELFr3qR9X1Cb/yImeNxAWqimmXYfyKM2w7HyHBbId/PaJITHJFZiEnS9eyx2aWTmzBKB3WB3ZtCI+7+GuNjGKJhLCP4CkLnYpUAJtLK5NzBPoOtZL3RZIApFrTA+Lip2sMqRjHzo/kCt4/ncUkIQcySHXS3IWK1sM7yjTGiz5aF83D5k4BVT8aMzQTaBrDkVeEXcuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEOedDruPju3e2YdplmfsoDKiqfGFidu4VM+NH6+kpI=;
 b=fLgIZHpJnNPA3x2fXvDlweDsy/d7VaRw5QxeM5MdaxILTz1uiIjBV/u+LGRS/AX/8K67rzB9ZrEbn7lOO7IbQuyCQVHtWj8CcS0HmmoKfe+PfOYrQRiZeWcuHGYpizA5RC6ujAnzuUxC/g+JX2JUj0EyVFzdXtIStS2kmtUBf9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by MN6PR08MB8617.namprd08.prod.outlook.com
 (2603:10b6:208:46e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Mon, 24 Apr
 2023 03:38:32 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6319.029; Mon, 24 Apr 2023
 03:38:32 +0000
Date:   Sun, 23 Apr 2023 22:38:29 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Fei Shao <fshao@chromium.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Kitt <steve@sk2.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] HID: i2c-hid: goodix: Add support for
 powered-in-suspend property
Message-ID: <ZEX5tc2LSZoVswc2@nixie71>
References: <20230418124953.3170028-1-fshao@chromium.org>
 <20230418124953.3170028-3-fshao@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418124953.3170028-3-fshao@chromium.org>
X-ClientProxiedBy: SA0PR11CA0057.namprd11.prod.outlook.com
 (2603:10b6:806:d0::32) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|MN6PR08MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: b76ed4ca-1a8b-456e-24d0-08db44756027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3UMJPnSCDynvbeGth4jGM49pZYgyW2rwnpbbvAWf3QlG0hNmpcfWB4tYtCooBYAs0JvDun9ncTNEmFrbS6Ch3udfm0s71kA8r6zxyuvkrq1UL0W9fmurCxU81BG3lybo2Po514QGMZicLih0XkBjYsPFgBrWApvz0qO1FI/wg07+IBt166yonpXb8w+XTq6t9VhIIz5RpqsWpffoEe54R6IleCycYbCmP51pql7f+CElRrV80k5fOz5Nf3uzelM1MLysTUZiB84MPvfi+1C2SlJ5LxU00YyI7xxsMQAkRFdZPRt8O/b1/YaGiTWJDdDhU6cfmtIcfVGqBoyu6WW8x3SJw69Z2EJ7tQtzgi5s1o8zpIyzU49Lz+y1RfgSFPGplSkACT02HMifKAhj9lQAlX2HLkh3zkiCtjvRSmfpG8DMAZITrvwL7P1TUISfIiydMmmB2zg/xbFJty24Y0XtisHlcfFZlmltwCWHwvRwCm3npSbl01lETv9aMXpbAfJn2fvdLCLFQvroNUY/44pjxNgOn/5EdIvGVnezavLTsjKc64olz/Bwerlm0AoWCK3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39830400003)(376002)(346002)(136003)(366004)(451199021)(2906002)(15650500001)(6486002)(6666004)(9686003)(6512007)(6506007)(26005)(186003)(66946007)(66556008)(66476007)(8676002)(8936002)(316002)(41300700001)(6916009)(4326008)(478600001)(5660300002)(7416002)(54906003)(38100700002)(33716001)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Khl6n0Kb7v9FHjDtPd348qamZIudDHS2g8gwdx+RoSaeX+xgCPIY9wU0piL+?=
 =?us-ascii?Q?07vJkQ2LcepIWzY0MNa5e0m2bvFOptr0BV/p3IF+zrVkHFXN8r+6iD2WsATd?=
 =?us-ascii?Q?cgSo91wYBWb5xJJ0RMb3upzk0utxwBrk5lD3yBfjqlXdm3YPDEsTqZOg7oVb?=
 =?us-ascii?Q?dvmxpXl5h7rgmsWScQ8vEkNcsVGQj3u585nisUjA+j7z2V6tflYVP7mQgejW?=
 =?us-ascii?Q?srSGaCBZbwX5V6aWEgDNu9lot1xPWhagupeE/VZpeiG4eAUkdvo/P2Ecskrp?=
 =?us-ascii?Q?bTEfUxhwc4XThptKy7dCWiAcbYTrNvuW7KWqTVnq1d44Jtw6VQsWtL861hFc?=
 =?us-ascii?Q?5EJZR43DMN5R7ckyywlsnyIoKMV6c4aRYnZTHHMN7yBos/6NNXSml2Q+io2W?=
 =?us-ascii?Q?CYwo8Z1vKt0xYjWQ2ainR8bxuv2AQ0pUj7wc/MNjVOWDfVWjSEC42LmYBu66?=
 =?us-ascii?Q?nVMHvDqwdcAp2PuPFUqAcQBfHReg/y/YtP0KajY04HS5RgqC3i+7h9DslpGq?=
 =?us-ascii?Q?8/mYkdxKd0Nsc3c7um1bpNwXe+fIr2JgUgmuBlMbYlDjBIpOrOPTWohyeBSK?=
 =?us-ascii?Q?r/ENr5s5BjwnRO8EwR0A46PzfAC4JqRg1XyDMwPUAEzsLehI5yd058zTv3hn?=
 =?us-ascii?Q?+vh7Uuo4+HiCxIMjK/659ZI0WI5mFxatWqMD0NSUoHSF0ODRaamIMafZk9Nf?=
 =?us-ascii?Q?FkZAXbrc8jA52fc7OA53/wQM3bdPo5UVxZ0+tj/NtDb/7k4MGUZ1mJIdUTx0?=
 =?us-ascii?Q?8oFA4Febjvx87dO3N4DeQLdw0V4EXCgPDrRCdXoj9eytIedpKRDMmVtuVASZ?=
 =?us-ascii?Q?aBOD2GC2/enweUSC40rFxk2Kmc3HPNJWeH52Dfu2q7mrzI463swwldts3bbz?=
 =?us-ascii?Q?ltjo6hfnE50Bz5u/8RRJnS+xiuVEDBcs7vhC3vB69ON3Ox55uOehxPt3OHmd?=
 =?us-ascii?Q?GF/EGLgy3IoVD10vYgJASWJ/dIWqXCy8okmPRs/qqur3YPxp7jOxfvCU31wM?=
 =?us-ascii?Q?fE0YwaRlmGlw98d8Y5KnX8H/1bPVKyOojIlzGB3hQOu779ZQf/PSJmKlkPRB?=
 =?us-ascii?Q?8VT6roGNY8N7a2PJF3/tjuSto9AcQiCLdy5QV7DWQWqL/HyoWiiy8vKrpymh?=
 =?us-ascii?Q?jZnRQrEhIWYgEYpjdoPQUODdISoeEv4EkO4s7cKgV318kyaGPqYWBq9/XdbQ?=
 =?us-ascii?Q?bjKs3bXwPd+tqsUwgVMUxX58ClVVikfsCq81M0AVveNZTcyRl7aI/tkDjwMI?=
 =?us-ascii?Q?M3sa8slGTaP1NcQzLlF3fD8oJhP8tZEN/HVzDTx2/z+adO9X/J5uDfvlkZj0?=
 =?us-ascii?Q?0ctYQ90iuiFvNteI/Z8zDxQJyox9L4lsMflxDYO+jIkpcqWl7QvQ4/GDbM+B?=
 =?us-ascii?Q?v6Wh7pRj4uUoepbf13+VCbFakYqv68SExf/cJ80M3H1M8NDfe7L5U0M+EjWW?=
 =?us-ascii?Q?gf3fy8NTDk7UtCn1TQ3XiuuLvahKr4x9SvykHmu6dGlitNfigtiIc/e+p8Wu?=
 =?us-ascii?Q?PXSsDh5IMuQj2YfVrxVjhEZZ118EkV7HwqwDSqfuOpog+XBCJMHq7MDvypP+?=
 =?us-ascii?Q?YyBbSxE5WcIXEP24CpnO1rJ1mDDqGvHdf+V9Z2Rz?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76ed4ca-1a8b-456e-24d0-08db44756027
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 03:38:31.9635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JQ4hlcvwmy1ZCUIZLJ7hg4tFRhfFJTjuYG0LKEpqw9eHWRcWj/0BzeGfUDxzjwct5Wv+S7ylDa1nEG8bSa+/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR08MB8617
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fei,

On Tue, Apr 18, 2023 at 08:49:52PM +0800, Fei Shao wrote:
> In the beginning, commit 18eeef46d359 ("HID: i2c-hid: goodix: Tie the
> reset line to true state of the regulator") introduced a change to tie
> the reset line of the Goodix touchscreen to the state of the regulator
> to fix a power leakage issue in suspend.
> 
> After some time, the change was deemed unnecessary and was reverted in
> commit 557e05fa9fdd ("HID: i2c-hid: goodix: Stop tying the reset line to
> the regulator") due to difficulties in managing regulator notifiers for
> designs like Evoker, which provides a second power rail to touchscreen.
> 
> However, the revert caused a power regression on another Chromebook
> device Steelix in the field, which has a dedicated always-on regulator
> for touchscreen and was covered by the workaround in the first commit.
> 
> To address both cases, this patch adds the support for the
> `powered-in-suspend` property in the driver that allows the driver to
> determine whether the touchscreen is still powered in suspend, and
> handle the reset GPIO accordingly as below:
> - When set to true, the driver does not assert the reset GPIO in power
>   down. To ensure a clean start and the consistent behavior, it does the
>   assertion in power up instead.
>   This is for designs with a dedicated always-on regulator.
> - When set to false, the driver uses the original control flow and
>   asserts GPIO and disable regulators normally.
>   This is for the two-regulator and shared-regulator designs.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> 
> ---
> 
>  drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 46 +++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> index 0060e3dcd775..b438db8ca6f4 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> @@ -28,6 +28,7 @@ struct i2c_hid_of_goodix {
>  	struct regulator *vdd;
>  	struct regulator *vddio;
>  	struct gpio_desc *reset_gpio;
> +	bool powered_in_suspend;
>  	const struct goodix_i2c_hid_timing_data *timings;
>  };
>  
> @@ -37,13 +38,34 @@ static int goodix_i2c_hid_power_up(struct i2chid_ops *ops)
>  		container_of(ops, struct i2c_hid_of_goodix, ops);
>  	int ret;
>  
> -	ret = regulator_enable(ihid_goodix->vdd);
> -	if (ret)
> -		return ret;
> -
> -	ret = regulator_enable(ihid_goodix->vddio);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * This is to ensure that the reset GPIO will be asserted and the
> +	 * regulators will be enabled for all cases.
> +	 */
> +	if (ihid_goodix->powered_in_suspend) {
> +		/*
> +		 * This is not mandatory, but we assert reset here (instead of
> +		 * in power-down) to ensure that the device will have a clean
> +		 * state later on just like the normal scenarios would have.
> +		 *
> +		 * Also, since the regulators were not disabled in power-down,
> +		 * we don't need to enable them here.
> +		 */
> +		gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
> +	} else {
> +		/*
> +		 * In this case, the reset is already asserted (either in
> +		 * probe or power-down).
> +		 * All we need is to enable the regulators.
> +		 */
> +		ret = regulator_enable(ihid_goodix->vdd);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_enable(ihid_goodix->vddio);
> +		if (ret)
> +			return ret;
> +	}

Please let me know in case I have misunderstood, but I don't see a need
to change the regulator_enable/disable() logic if this property is set.
If the regulators are truly always-on, the regulator core already knows
what to do and we should not duplicate that logic here.

Based on the alleged silicon erratum discussed in patch [1/2], it seems
we only want to control the behavior of the reset GPIO. Therefore, only
the calls to gpiod_set_value_cansleep() should be affected and the name
of the property updated to reflect what it's actually doing.

>  
>  	if (ihid_goodix->timings->post_power_delay_ms)
>  		msleep(ihid_goodix->timings->post_power_delay_ms);
> @@ -60,6 +82,13 @@ static void goodix_i2c_hid_power_down(struct i2chid_ops *ops)
>  	struct i2c_hid_of_goodix *ihid_goodix =
>  		container_of(ops, struct i2c_hid_of_goodix, ops);
>  
> +	/*
> +	 * Don't assert reset GPIO or disable regulators if we're keeping the
> +	 * device powered in suspend.
> +	 */
> +	if (ihid_goodix->powered_in_suspend)
> +		return;
> +
>  	gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
>  	regulator_disable(ihid_goodix->vddio);
>  	regulator_disable(ihid_goodix->vdd);
> @@ -91,6 +120,9 @@ static int i2c_hid_of_goodix_probe(struct i2c_client *client)
>  	if (IS_ERR(ihid_goodix->vddio))
>  		return PTR_ERR(ihid_goodix->vddio);
>  
> +	ihid_goodix->powered_in_suspend =
> +		of_property_read_bool(client->dev.of_node, "powered-in-suspend");
> +
>  	ihid_goodix->timings = device_get_match_data(&client->dev);
>  
>  	return i2c_hid_core_probe(client, &ihid_goodix->ops, 0x0001, 0);
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 

Kind regards,
Jeff LaBundy
