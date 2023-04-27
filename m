Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D969E6EFEC8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 03:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbjD0BIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 21:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240955AbjD0BIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 21:08:06 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7A9C0;
        Wed, 26 Apr 2023 18:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JR7j42Z5mNNhZUJS/HsgT7MEsNIxGS88NZe2bbmgmTjDSW5V7B9FDBPNARFm5KnDFEzkX1KszqhN0h5q2ubGny1JzzTZSdTLQRwq8we1Fza1tTjljuT2xuhq3ipeYGQM11leSuPGJfe6gBUxeo/DGvT1+rpw1QKNClQqCqJiaZtJXicisbY0jprrEyXE3+7OXDag4lPkkwvXoUiPfK0Hz6Z0YkMTCxcPSF63i6afOWDnP9nKW4aYqXCqAHCTAYcNux+raX8GlfGyB5tEU6asvDKsxqwVtmfa39NCrtjbZhrApoNpQcMPSSLAXR+26U3WXmrQeQaM0p5GFiEY47AENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAUq711HcYSqYuPgIlxU/avkF3pSpFk4gqq8i8Eh2zE=;
 b=D18yE27YufomwbNkVsUGjGlxailkvn7ysxAe0HM87+khgezIXdXy/UK5xfhziMzoiH6907qegaYP7fQLAcKKyv+Q8Ze5CE34++FJUnmTx2ZEAMzoOVk6SL723YBw2umOaXfTj5k2Oj67GrlY4mcY8WiusKVfbNQS6OxictTabDUhvuqJ5UByggTeusjKkMsoOOCrTg2PlAT3Pkfk7w6gCKM1d1ecuYp4oLfe6iOBhf5d46hF3Be1O3r39lM3o1mGHEYvfXE9plTTeEJ5h0N8OllI2qep/VHDPhHDaCYGIrmQdG+akLcnuHehDN+i8/NNI1IA/mDOMFme9rxaObM6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAUq711HcYSqYuPgIlxU/avkF3pSpFk4gqq8i8Eh2zE=;
 b=VI+tBHEZGQgyAew5hqtcwlprAkSvILqqtm/OnFsBG5n/Onu/n8bpczm4iNLSzc8dpOkZvAINetrHQDWrMhFrvUfY73Vza0ONxhsJHAnlqb29cfROyNwjYXKYHbRi9F7SCPnLxI1/gBLVGt7GcvwlxgTocVuYAEZZvCQ5EbIU1lI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com (2603:10b6:4:7c::37)
 by CH0PR08MB8684.namprd08.prod.outlook.com (2603:10b6:610:18c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Thu, 27 Apr
 2023 01:07:59 +0000
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::20b4:97da:18df:16dc]) by DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::20b4:97da:18df:16dc%3]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 01:07:59 +0000
Date:   Wed, 26 Apr 2023 20:07:57 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Fei Shao <fshao@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Kitt <steve@sk2.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] HID: i2c-hid: goodix: Add support for
 "goodix,no-reset-during-suspend" property
Message-ID: <ZEnK7bQkl+fkcHkb@nixie71>
References: <20230426144423.2820826-1-fshao@chromium.org>
 <20230426144423.2820826-3-fshao@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426144423.2820826-3-fshao@chromium.org>
X-ClientProxiedBy: DS7PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::27) To DM5PR0801MB3767.namprd08.prod.outlook.com
 (2603:10b6:4:7c::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0801MB3767:EE_|CH0PR08MB8684:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f53591-8648-4172-e0fb-08db46bbd798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JK0rpSzMjyeruR/+o9YJidC0GYYxEnOl9Q9G40SLB7pixUh/pOMG0yirBDpqKwW6pQckaCkoqcdnouX5sy9T0npsUNjZtRmnxYKaPVZkZhpvYAv057xC0F8MRiZFfUoKHt+ROpy7Cjt2+KoGwKkcArKg1b3Y0pfXKoBTYLTGZiLTcLoNmwWRrLvIUFMVYMkYL1G90/MAvQo6THc7WVLK63MqA6d6THJtlnkFAWShr2T4DgbyCTrxEzaVidBVNSW2t3gejxp9x0kVCs6tic2Xgm9yWlD5r08AABf153bY2SJLoHj8gFXszIsuUnDp2eU8AvtxGSAxHu40o25Kt/091f7Qqn5hFB9pooS6eNw6WcWRb4MrKnMlq6xfmxPD2H4JN2KbupSAC0o303RNPyEmzcR45919Cuu+hJe7ji9r1OOWBf4N8BVKNQlXMnIQGmbWa07aUNvnvlGY1cMOrwSbU9yK83wM5Sk8hFmUZud9PeVdtniISe1kNJ1NtKXm6PTf/QPm+FiGLZkqy97KBavsvNwpYyIxIATOn+FxpwY8Ag7PFoUAH7megIqsI/UVWxzDMgbGkCWbmmJ1OMqQzzi9A5INvhhNZr7Dikwl8G/lQng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0801MB3767.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(39830400003)(136003)(346002)(396003)(451199021)(54906003)(478600001)(86362001)(38100700002)(33716001)(8676002)(2906002)(8936002)(7416002)(6916009)(15650500001)(4326008)(66476007)(66556008)(316002)(66946007)(5660300002)(41300700001)(6512007)(186003)(26005)(6506007)(9686003)(83380400001)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LdkbYZElJX/FFeSAhufRIJoQ2XebNUSVIIBIKrjbWGug6DUnepLFwgISMaAN?=
 =?us-ascii?Q?yoQtE3AoRN0IaNzktXV0hnTu1IaLSOxGcP58zJ0aSZvPoRSu6bIyrTfWhY2w?=
 =?us-ascii?Q?S2XGGFjAWRGiT9pas1rcMYGcJSsXDOKPhJY9y/D2DeeCtYjoLZ5n2vHNduIE?=
 =?us-ascii?Q?bKZjQ6GwP7KRomx1VNHNjaFnTe6WZbWrn9JlfALpS12mMoo+A9BHWQ39GL/w?=
 =?us-ascii?Q?L37OJuLYSotucFjcqwqV9u6kIl+paXfKNrYd4rkCUOF19eKtT27TwJZT0smp?=
 =?us-ascii?Q?YsayV2sb3EjtIob98D5vyWgg6Aun8Uo2OL7UbeNuFssqkGeudR7/mGCXfTig?=
 =?us-ascii?Q?yeJ4fvQIT/3p6tADjpXgLdHj5yihsYthHslTiHF3yCUFAkCsHOdkX51jah9G?=
 =?us-ascii?Q?SEb/7TVaXLGLXCttOvfMhi+UbeJU4LIiOs6QfCpX8NGDOj3+2EWxizT0C8Ac?=
 =?us-ascii?Q?G9swvhaN1C2vid1pAo3C2X8Ph43fS3e7dJDEeGUoSKFeUmKCWuHihJJ4EKPi?=
 =?us-ascii?Q?MI6i6hAlieLIEmpJN52uLiKmPpmzCR8To16Wlryk/abPq5EVE25Z3e3/i+Vk?=
 =?us-ascii?Q?BMnWC/kEPL3f8nRT0gpExl7toabZgsOfPeGXQqFWcDIO21UxA1m92XIjZ7wa?=
 =?us-ascii?Q?nGp/1STpFaYOMb2YNbI/JcENewKux0S6goQMsb4HrKkA13X7dWfwmKeKpuK9?=
 =?us-ascii?Q?wz6hjIE/fMDaH8nPAeOpSWlzUkQW7zCJHYrWvKZMKqu+Yp2I2u/3fEYjV2SJ?=
 =?us-ascii?Q?lv44izAZ9QktLuqDrO7KYnFxWy3TgAf4F7eivxJ8gkehuGKEsjkVg+MFfS2b?=
 =?us-ascii?Q?c5nxU1aOnbqd7DaxLcSgPlWOjKlPpOsREgVIeZLjzOvIJN77UJCE7ybQK1W+?=
 =?us-ascii?Q?y1vmpUCTqA4KrMRpj84L+6r8H6bRuDXbeaznn+qno1DqSYD2lB+//zSRzrkF?=
 =?us-ascii?Q?fcnLor+BVbo5yy+fLN1fRe4PV5Wh4Tka/s78QYaEKRMcWd21Gtr8hLdLoZ9J?=
 =?us-ascii?Q?qNeZII6bFZ4wAXzkNJgLQwx1zGKpNS1nSjy0/OkoSxxnhJIzeg3RrtHSPAgO?=
 =?us-ascii?Q?JsS9YAve9mNOKssv7w0cxrIRmJWjb3CkQsq11yzuQlx2sKmyP1RLkB4Zy1dZ?=
 =?us-ascii?Q?1qBXNYxadznUCanTkayYd+HdPQPaZPy2MiBbaSxj/5sc8Df5ZGs2+CBd5iYc?=
 =?us-ascii?Q?EyfCk23rEpmlLCZuFaU2AilC35zb1WIDmlcr9KM4kCJV8lZhQDUfskJp4inm?=
 =?us-ascii?Q?FBT+4q3ujh4dopqSbZYejLERdpTYnns7aBIHqilGNGjapm+dPLG5RjVvwC9G?=
 =?us-ascii?Q?1LXEuBL1xFgduQ9sTckEYVCECe8Wco/xNnOetxcMOkwOdiQ9Y3e/gV8VEP6N?=
 =?us-ascii?Q?Tl3pcZT9h4eWPoILPi02z207zPNJHqF4uoB65LQampZtiU+E1kxtGa8K1DlH?=
 =?us-ascii?Q?oFnQsaZundZPE0TqdEK6PYCzxX9vyE6p4HYBptUH5Ip4au0bGnzeJL2jhYkH?=
 =?us-ascii?Q?euJHGIKWaPX+dmjvlawosHW2BIPvbuFMWZHS13MnYV5/nPy+p/JNZWSLGNCh?=
 =?us-ascii?Q?0FecsGSCmrgl/1y6INF3KVoTYlkHxId9Rb+B2PiP?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f53591-8648-4172-e0fb-08db46bbd798
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0801MB3767.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 01:07:59.4596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZIgLvIU/wEN4JgKivm9ygwiJagtNF01RAGEifQ5s48xWLRpPwlkFT+LayijiIeJcMFs5v8tqkKvw/aWZjoxjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR08MB8684
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fei,

On Wed, Apr 26, 2023 at 10:44:22PM +0800, Fei Shao wrote:
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
> To address both cases, this patch adds the support for the new
> "goodix,no-reset-during-suspend" property in the driver:
> - When set to true, the driver does not assert the reset GPIO during
>   power-down.
>   Instead, the GPIO will be asserted during power-up to ensure the
>   touchscreen always has a clean start and consistent behavior after
>   resuming.
>   This is for designs with a dedicated always-on regulator.
> - When set to false or unset, the driver uses the original control flow
>   and asserts GPIO and disables regulators normally.
>   This is for the two-regulator and shared-regulator designs.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Great work; one tiny nit below. If you do not agree with it or have found
precedent that suggests it is OK, feel free to ignore it. Either way:

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

> 
> ---
> 
> Changes in v3:
> - In power-down, only skip the GPIO but not the regulator calls if the
>   flag is set
> 
> Changes in v2:
> - Do not change the regulator_enable logic during power-up.
> 
>  drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> index 0060e3dcd775..3ed365b50432 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> @@ -28,6 +28,7 @@ struct i2c_hid_of_goodix {
>  	struct regulator *vdd;
>  	struct regulator *vddio;
>  	struct gpio_desc *reset_gpio;
> +	bool no_reset_during_suspend;
>  	const struct goodix_i2c_hid_timing_data *timings;
>  };
>  
> @@ -37,6 +38,14 @@ static int goodix_i2c_hid_power_up(struct i2chid_ops *ops)
>  		container_of(ops, struct i2c_hid_of_goodix, ops);
>  	int ret;
>  
> +	if (ihid_goodix->no_reset_during_suspend) {
> +		/*
> +		 * We assert reset GPIO here (instead of during power-down) to
> +		 * ensure the device will have a clean state after powering up,
> +		 * just like the normal scenarios will have.
> +		 */
> +		gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
> +	}

I don't think curly braces are technically required here, as there is only
one statement within the conditional despite the comments making it appear
otherwise. Maybe this would work too:

	/* ... */
	if (...)
		gpiod_set_value_cansleep(...);

Again however, I do not feel strongly about this.

>  	ret = regulator_enable(ihid_goodix->vdd);
>  	if (ret)
>  		return ret;
> @@ -60,7 +69,9 @@ static void goodix_i2c_hid_power_down(struct i2chid_ops *ops)
>  	struct i2c_hid_of_goodix *ihid_goodix =
>  		container_of(ops, struct i2c_hid_of_goodix, ops);
>  
> -	gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
> +	if (!ihid_goodix->no_reset_during_suspend)
> +		gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
> +
>  	regulator_disable(ihid_goodix->vddio);
>  	regulator_disable(ihid_goodix->vdd);
>  }
> @@ -91,6 +102,9 @@ static int i2c_hid_of_goodix_probe(struct i2c_client *client)
>  	if (IS_ERR(ihid_goodix->vddio))
>  		return PTR_ERR(ihid_goodix->vddio);
>  
> +	ihid_goodix->no_reset_during_suspend =
> +		of_property_read_bool(client->dev.of_node, "goodix,no-reset-during-suspend");
> +
>  	ihid_goodix->timings = device_get_match_data(&client->dev);
>  
>  	return i2c_hid_core_probe(client, &ihid_goodix->ops, 0x0001, 0);
> -- 
> 2.40.1.495.gc816e09b53d-goog
> 

Kind regards,
Jeff LaBundy
