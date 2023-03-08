Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737396AFE12
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 06:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCHFDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 00:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCHFD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 00:03:28 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963D839CC9;
        Tue,  7 Mar 2023 21:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEPg2s3mDSpwg5TUh1NvII75CrvptG8dwr20K6xmYfS6k2Prgq0OGo49nwLQjsKUvbWVRZPMGYfQeKbo7t5EISI5gT76l/RKIxijwcuAOk+Gc9YaHqKum94/0YCMz7UI2ncj/iLdCb0ui3m1Qy5lbBCMneg+jWadI5kEPQS2QP+Se0VBDKzKtOWJTt23lE67LeRCtgE1lGPqNfNTQjGvvsVrjcTGItZH4M4OHssavyDKnJyfaNqIH0gVnv19qpyWX8oCBZdykcDoHjv8JbSkvN9/iAkG0nmmg5hSva5kYnwr5vkOtJi+O7Lvt9AfQSRMtE0hY8A3mZLfbotU4jET2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYe9oPopXR+sgg8T9GY4tthGLnnzd9U/5BLmg/yT380=;
 b=PX2b5MXhIRnZjBnC7NK5A/jxd5WxvjPfxhXO/1eMTHcYd2/VoRrQ9Y+zjAmeoQ4mNbEB4ZocaC3Got0BXE+leO5m0ErhOPwN4Xq0alOpMKGjcYY1pKVuvZz6c00OiTRx4CsYL1C8MQUYXx6k8I0IvrjspiJbv/y0ztyhXPuyOrxCLf4ol3M6Kpx3tqDtL/DUcrabI6LrrYTx8/cktNjFPyPTgpidICmCYrlBQh2oq1fD9hXiss/IZfH4CQqP9d3L/lFb931z9R6lNhbYUWRvymwl4UFGbGsElr4QaKw17ieQFyIl86XoBu2gND4M40puJRVl+tmvFFw6TBNp4bhhTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYe9oPopXR+sgg8T9GY4tthGLnnzd9U/5BLmg/yT380=;
 b=r2YObsMyJPjJ1/cubBKuzB5IpRtcd0KBw8naFiwmMW+dGh3sUn+9h7yddHzCQ9R9k62aQexjF/9eTnqWA36GDJU+wzT7nc+7E9U0kPRvwOrACEekhiZgJo+IIpacoE0pX1bapadnBDlRFf2p9tm50RuMusmSBCZGG5ipEn8mxcUE/roD1JawZFtUmoNuUY/PaWWLjDkK1qHOl0otXBcorLACZGoviL+HxZZdjrGSNm5WlUtjrsOHkUQ/PVsI2WwKU6b4iPUr/EeqllMj2vHGtSK4DIeV8DszU4glZjjau1yclP9lu2jrHpu2q7kfRil5j9iQz1W1CILBgdh/j0DEPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 05:03:20 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 05:03:20 +0000
Date:   Wed, 8 Mar 2023 13:03:06 +0800
From:   Chester Lin <clin@suse.com>
To:     andy.shevchenko@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [PATCH v5 2/3] pinctrl: add NXP S32 SoC family support
Message-ID: <ZAgXCi/BzyEQul9B@linux-8mug>
References: <20230220023320.3499-1-clin@suse.com>
 <20230220023320.3499-3-clin@suse.com>
 <ZAZ3CeYiZxR5zlRu@surfacebook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAZ3CeYiZxR5zlRu@surfacebook>
X-ClientProxiedBy: FR0P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::20) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 7043e220-79f2-4486-b494-08db1f926f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJyLM1wig5XjeY6ZQXZuj66d6YX8YgqHkLhNEE4FB1iYFngPe9Us9Y6GT+0eku8L0LVmbLyc4V10pYOejKv83LfZUPq08zvqOMvylp9MLyO7A4U9yjx6+szu37spnuZMjASA6h7wH10abgCR7NzQOgculK7nctaEXYmpvvDvudxxw1+yvpJ5ldb89XwB0LqbeWiQ5hrX9grvTyWNUjlRzsCd5Hxh5F9FRU2njGWbQvP9bLaeqPcX1YK8o4B60AT6vmvjRjZ1y/ghN07a88Ct7Wfnpm2Bdf4K7wH3E3g5pOx92ZKj85KQSm3YBXnH9Y7qE5jVy+S8Xb5Nc8OCEGlCDNhpOpgqFm2Y296/XBQOEb1ttTwGnPdBapwICoMZghIioasRaQyhJeLqdXT4Y1d0gMkAUUIuQrTMuAtUoXAZ5AZdTP7zChAHi6YTZG7tq1f6uo5iBa/6W/BpSKihSKgkBGaOVPMZsgpDLukNpkyW2SZ2bAOdLyNc8fyDLC+loiTTWGvxEMj8oDToVYJuNC9sazuj72z+pJp3huY3WwcyhH9UDlh4WMSwOeY1G9AzAXpihIleUAxfnpceM6KDH3GlhkwXy1n5ABxu9Lq8yaetHZvid4qcRo67Xwmvxzqqe60+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199018)(6916009)(4326008)(8936002)(66476007)(41300700001)(66946007)(66556008)(8676002)(30864003)(2906002)(5660300002)(7416002)(86362001)(38100700002)(966005)(6512007)(6506007)(6486002)(6666004)(26005)(316002)(478600001)(54906003)(33716001)(83380400001)(186003)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uYZANWn4PxBGEi+tmZ8+MGe3LgugBrfCbZbFES6qZWoZDGqaRi+QSXe84zXR?=
 =?us-ascii?Q?MedrBjJidXiNngRmoQRjM84UnVUdrg+1pWG/tpa7+VnHBj/3fckOODdbQQbR?=
 =?us-ascii?Q?b3DTH4BUZnB0M+yGRn9DyWvSvPGZpZhTsBgNFNxabeDnN55ZpoQE+WbGgOz+?=
 =?us-ascii?Q?747Za8PUaKLCW3Ov6VSTXvqdO6mgK5ocYN2OGKDftVexez/SCifGK59cXSj4?=
 =?us-ascii?Q?BdnHODY2tA+LpMdeS/1WGblBQ+XrhcVNtfelLAY/ff7wY2xsj9/C9CeSorOJ?=
 =?us-ascii?Q?vaSQgJ0spITbHGIg7X/R0vCRqjMbAa2AKyKml/qRuoN1BXutJW2Wgtr0UY1K?=
 =?us-ascii?Q?8CLv7zD7vHtjsgaI7I+8Gu0D6y9WUKamUnPC6cANV9iDPpA3xwFxSu32okOj?=
 =?us-ascii?Q?uixzEuoEHM5O9mhRZcUmlkL9JLIZ4ZND3A9fj+CZRJTsmGNnA4+VqZ7JIFiK?=
 =?us-ascii?Q?60K0jwEziGq7FW6/lTe9+uYvVpnxmDVLk9klFKqBfXyGvxmx7Bbdvz1uF2kL?=
 =?us-ascii?Q?gkHR1xgNmo1wjf/uPiJBJSz0Gi2B8bIejLdn23mFgaEQqaj3BHkjo/nA6KCe?=
 =?us-ascii?Q?6UccIET8TclMddZ7FhmrdvV9fJpJQC1pn+AHniXzisBDSRhYYzhFrtfmXqQs?=
 =?us-ascii?Q?lgwH1kbzi6ac6YdPO48+viqgyxQI6Tci1gj2mSoVM89f+jkTMtiA5ZVKtARS?=
 =?us-ascii?Q?kQMQXh5no6IbWO0dlfc+rr4ipN/FSLFwWMdEYCwgwsNmpDdfxBblL6nBD1s+?=
 =?us-ascii?Q?XKgRKJqK9QTnythiKMvhvCxKWg6wfb/ZsNSACtLL5LQwtztwgl54+E6IXJAC?=
 =?us-ascii?Q?E6fw/Fb7JUZUZ5FFHPDVzqIKvslGZSIgpcR8IXbmZ2HyGwbo/JGN5RVBSXOo?=
 =?us-ascii?Q?ed5quct5sdoxASB70MJLr8T3CKGiz3LWO1vkfUYEA1sXTxsu61PqCkmwsZav?=
 =?us-ascii?Q?wSId3uCaneGQvxzQNkcbkLIopkgpqVnhiSGmPPJoFacj5I7QkNUY9wP1O6qN?=
 =?us-ascii?Q?642pdTwtKyLjw//3rnibUHBYTXjaD50hG8U1VMiO5hVRiuKuKeEL9NCR0leI?=
 =?us-ascii?Q?P+Eo4FljHgGP/vh9XKAkexH9b5Bg6+L7IMPMmdSnwvWzgq5J9IrOA1bDqToX?=
 =?us-ascii?Q?0XPwnwHqBYhF0yaiSK43KV17ujwrWo2oVaKACot+1bYpz+hFveZnPDrfLDxA?=
 =?us-ascii?Q?dok/WKP9x/N5uSTg00EEO12LA6tPBWO3v7vGXPX3z/aym1xOXihZRCYu+CeS?=
 =?us-ascii?Q?8PwLQqRKkULbS3hEH1/xKrbBkcAbK1FR3vAINA6QuknM2IJD4e1GSXkOpi34?=
 =?us-ascii?Q?tocc/aO4zXrhSRHW2vfl4wnIQ+w8mI7KGcEZJT9m+xnJ1uncnsH6AlGZgnpm?=
 =?us-ascii?Q?mh2rotEgb1/4RLxsw2Fs6qlgUmS6G2X7pV0JKtjXDPi/5+5goZ+1O/NctNcu?=
 =?us-ascii?Q?ObQdVeo4JqGA9yNLPERWF7hWhu8R98NTb5Fi0n3Pm5hoNepLlQTIP0cp/aGw?=
 =?us-ascii?Q?OrVzWigBEL4+5hJNh7lg2hXPfPvtJ60wWyYNa1lVRXuaWXEbOsfkGE5+PmHe?=
 =?us-ascii?Q?tweadxXag5SBj7I5DoE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7043e220-79f2-4486-b494-08db1f926f28
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 05:03:20.3368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Box0ZKbM5bC346a4Lv8lCdezS1aKDmvr+9mzW1EZz2D2aTMmy70KZ6RFhRtyF/uQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for reviewing this patch!

On Tue, Mar 07, 2023 at 01:28:09AM +0200, andy.shevchenko@gmail.com wrote:
> Mon, Feb 20, 2023 at 10:33:19AM +0800, Chester Lin kirjoitti:
> > Add the pinctrl driver for NXP S32 SoC family. This driver is mainly based
> > on NXP's downstream implementation on nxp-auto-linux repo[1].
> 
> Seems Linus already applied this, but still some comments for the future, some
> for the followups. However, personally I prefer this to be dropped and redone
> because too many things here and there.
> 
> > [1] https://github.com/nxp-auto-linux/linux/tree/bsp35.0-5.15.73-rt/drivers/pinctrl/freescale
> 
> This can be transformed to Link: tag.
> 
> > Signed-off-by: Matthew Nunez <matthew.nunez@nxp.com>
> > Signed-off-by: Phu Luu An <phu.luuan@nxp.com>
> > Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
> > Signed-off-by: Andrei Stefanescu <andrei.stefanescu@nxp.com>
> > Signed-off-by: Radu Pirea <radu-nicolae.pirea@nxp.com>
> > Signed-off-by: Chester Lin <clin@suse.com>
> 
> Is it for real?!
> Quite a long chain and none of Co-developed-by.
> 

They are developers who contribute codes and have Signed-off-bys in NXP's downstream
version. Since their implementations can still be seen in this upstream one, I
prefer to list them all. Indeed a part of them who also actively work with me on
upstreaming this driver can be listed as Co-developed-by, but the driver patch
has been merged into the maintainer's for-next so I would not change this part
unless the driver patch needs to be reverted and re-submitted in the end.

Sorry for the patch header that I mess up anyway.

> ...
> 
> > +	depends on ARCH_S32 && OF
> 
> Is OF necessary? Can it be

I think it's required since the driver file refers to of_* APIs.

> 
> 	depends OF || COMPILE_TEST
> 
> ?
> 
> ...
> 
> > +	depends on ARCH_S32 && OF
> 
> Ditto.
> 
> ...
> 
> > +/**
> > + * struct s32_pin_group - describes an S32 pin group
> > + * @name: the name of this specific pin group
> > + * @npins: the number of pins in this group array, i.e. the number of
> > + *         elements in pin_ids and pin_sss so we can iterate over that array
> > + * @pin_ids: an array of pin IDs in this group
> > + * @pin_sss: an array of source signal select configs paired with pin_ids
> > + */
> > +struct s32_pin_group {
> > +	const char *name;
> > +	unsigned int npins;
> > +	unsigned int *pin_ids;
> > +	unsigned int *pin_sss;
> 
> Why didn't you embed struct pingroup?
> 

I did think about that but there's an additional 'pin_sss' which could make code
a bit messy. For example:

	s32_regmap_update(pctldev, grp->grp.pins[i],
			  S32_MSCR_SSS_MASK, grp->pin_sss[i]);

> > +};
> > +
> > +/**
> > + * struct s32_pmx_func - describes S32 pinmux functions
> > + * @name: the name of this specific function
> > + * @groups: corresponding pin groups
> > + * @num_groups: the number of groups
> > + */
> > +struct s32_pmx_func {
> > +	const char *name;
> > +	const char **groups;
> > +	unsigned int num_groups;
> > +};
> 
> struct pinfunction.
> 

Thanks for your information. I was not aware of this new struct since it just got
merged recently.

> ...
> 
> > +#ifdef CONFIG_PM_SLEEP
> > +int __maybe_unused s32_pinctrl_resume(struct device *dev);
> > +int __maybe_unused s32_pinctrl_suspend(struct device *dev);
> > +#endif
> 
> Please, consider using new PM macros, like pm_ptr().
> 

Maybe pm_sleep_ptr() is more accurate?

> ...
> 
> > +static u32 get_pin_no(u32 pinmux)
> > +{
> > +	return (pinmux & S32_PIN_ID_MASK) >> __ffs(S32_PIN_ID_MASK);
> 
> Oh, don't you have MASK to be 2^x - 1? Why to drag this with __ffs()?
> Just define a complement _SHIFT.
> 

Will fix it.

> > +}
> 
> ...
> 
> > +	n_pins = of_property_count_elems_of_size(np, "pinmux", sizeof(u32));
> > +	if (n_pins < 0) {
> > +		dev_warn(dev, "Unable to find 'pinmux' property in node %s.\n",
> > +			np->name);
> 
> Use %pOFn instead of %s.
> 

Will change it.

> > +	} else if (!n_pins) {
> > +		return -EINVAL;
> > +	}
> 
> ...
> 
> > +	for (i = 0; i < grp->npins; ++i) {
> 
> Why pre-increment?

Will change that to keep code style consistency.

> 
> > +		if (s32_check_pin(pctldev, grp->pin_ids[i]) != 0) {
> > +			dev_err(info->dev, "invalid pin: %d in group: %d\n",
> > +				grp->pin_ids[i], group);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	for (i = 0, ret = 0; i < grp->npins && !ret; ++i) {
> 
> Ditto.
> 
> > +		ret = s32_regmap_update(pctldev, grp->pin_ids[i],
> > +					S32_MSCR_SSS_MASK, grp->pin_sss[i]);
> 
> Traditional pattern is
> 
> 		if (ret)
> 			return ret;
> 
> This avoids first assignment of the ret.
> 
> > +	}
> > +
> > +	return ret;
> 
> 	return 0;
> 
> > +}
> 
> ...
> 
> > +	ret = s32_regmap_read(pctldev, offset, &config);
> > +	if (ret != 0)
> > +		return -EINVAL;
> 
> Why not
> 
> 	if (ret)
> 		return ret;
> 

Will fix this and the following error code shadowings, return handlings and blanks.

Thanks for your reminder.

> ...
> 
> > +	list_add(&(gpio_pin->list), &(ipctl->gpio_configs));
> 
> Too many parentheses.
> 
> ...
> 
> > +	list_for_each_safe(pos, tmp, &ipctl->gpio_configs) {
> > +		gpio_pin = list_entry(pos, struct gpio_pin_config, list);
> 
> Why not list_for_each_entry_safe() ?

Will change it.

> 
> 
> > +		if (gpio_pin->pin_id == offset) {
> > +			ret = s32_regmap_write(pctldev, gpio_pin->pin_id,
> > +						 gpio_pin->config);
> > +			if (ret != 0)
> > +				goto unlock;
> > +
> > +			list_del(pos);
> > +			kfree(gpio_pin);
> > +			break;
> > +		}
> > +	}
> 
> ...
> 
> > +static int s32_get_slew_regval(int arg)
> > +{
> > +	int i;
> 
> 	unsigned int i;
> 
> + Blank line.
> 
> > +	/* Translate a real slew rate (MHz) to a register value */
> > +	for (i = 0; i < ARRAY_SIZE(support_slew); i++) {
> > +		if (arg == support_slew[i])
> > +			return i;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> 
> ...
> 
> > +	case PIN_CONFIG_BIAS_PULL_UP:
> > +		if (arg)
> > +			*config |= S32_MSCR_PUS;
> > +		else
> > +			*config &= ~S32_MSCR_PUS;
> 
> > +		fallthrough;
> 
> It's quite easy to miss this and tell us about how is it supposed to work with PU + PD?
> 
I admit that it's ambiguous and should be improved in order to have better readability.

In a S32G2 MSCR register, there are two register bits related to pull up/down functions:

PUE (Pull Enable, MSCR[13]): 0'b: Disabled,  1'b: Enabled
PUS (Pull Select, MSCR[12]): 0'b: Pull Down, 1'b: Pull Up

The dt properties could be like these:

1) 'bias-pull-up' or 'bias-pull-up: true'  --> arg = 1
   In this case both PUE and PUS are set.

2) 'bias-pull-up: false'  --> arg = 0
   In this case both PUE and PUS are cleared since the pull-up function must be disabled.

> > +	case PIN_CONFIG_BIAS_PULL_DOWN:
> > +		if (arg)
> > +			*config |= S32_MSCR_PUE;
> > +		else
> > +			*config &= ~S32_MSCR_PUE;
> > +		*mask |= S32_MSCR_PUE | S32_MSCR_PUS;
> > +		break;
> > +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> > +		*config &= ~(S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE);
> > +		*mask |= S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE;
> > +		fallthrough;
> 
> Ditto.
> 

It's similar to the case 'PIN_CONFIG_BIAS_PULL_UP' although the PUS bit is assumed
as 0 via the config variable so only the PUE bit needs to be configured, for example:

1) 'bias-pull-down' or 'bias-pull-down: true'  --> arg = 1
   PUE is set and PUS is cleared.

2) 'bias-pull-down: false'  --> arg = 0
   In this case both PUE and PUS are cleared since the pull-down function must be disabled.

> > +	case PIN_CONFIG_BIAS_DISABLE:
> > +		*config &= ~(S32_MSCR_PUS | S32_MSCR_PUE);
> > +		*mask |= S32_MSCR_PUS | S32_MSCR_PUE;
> > +		break;
> 
> ...
> 
> > +	if (s32_check_pin(pctldev, pin_id) != 0)
> 
> Shadowing an error?
> 
> > +		return -EINVAL;
> 
> ...
> 
> > +	ret = s32_regmap_update(pctldev, pin_id, mask, config);
> > +
> > +	dev_dbg(ipctl->dev, "update: pin %d cfg 0x%x\n", pin_id, config);
> > +
> > +	return ret;
> 
> You are not using ret in between, hence
> 
> 	return _regmap_update(...);
> 
> ...
> 
> > +static void s32_pinconf_dbg_show(struct pinctrl_dev *pctldev,
> > +				 struct seq_file *s, unsigned int pin_id)
> > +{
> > +	unsigned int config;
> > +	int ret = s32_regmap_read(pctldev, pin_id, &config);
> > +
> > +	if (!ret)
> > +		seq_printf(s, "0x%x", config);
> 
> 
> 	int ret;
> 
> 	ret = s32_regmap_read(pctldev, pin_id, &config);
> 	if (ret)
> 		return;
> 
> 	seq_printf(s, "0x%x", config);
> 
> > +}
> 
> ...
> 
> > +	npins = of_property_count_elems_of_size(np, "pinmux", sizeof(u32));
> 
> > +
> 
> Unneccessary blank line.
> 
> > +	if (npins < 0) {
> > +		dev_err(dev, "Failed to read 'pinmux' property in node %s.\n",
> > +			np->name);
> > +		return;
> > +	}
> > +	if (!npins) {
> > +		dev_err(dev, "The group %s has no pins.\n", np->name);
> > +		return;
> > +	}
> 
> ...
> 
> > +	grp->pin_ids = devm_kcalloc(info->dev, grp->npins,
> > +				    sizeof(unsigned int), GFP_KERNEL);
> > +	grp->pin_sss = devm_kcalloc(info->dev, grp->npins,
> > +				    sizeof(unsigned int), GFP_KERNEL);
> 
> > +
> 
> Ditto.
> 
> > +	if (!grp->pin_ids || !grp->pin_sss) {
> 
> > +		dev_err(dev, "Failed to allocate memory for the group %s.\n",
> > +			np->name);
> 
> We do not print ENOMEM error messages.
> 

Will drop it.

> > +		return;
> > +	}
> 
> ...
> 
> > +	func->groups = devm_kzalloc(info->dev,
> > +			func->num_groups * sizeof(char *), GFP_KERNEL);
> 
> First of all, this is devm_kcalloc().
> Second, where is the error check?
> 

Will fix it.

> > +	for_each_child_of_node(np, child) {
> > +		func->groups[i] = child->name;
> > +		grp = &info->groups[info->grp_index++];
> > +		s32_pinctrl_parse_groups(child, grp, info);
> > +		i++;
> > +	}
> 
> ...
> 
> > +	ipctl->regions = devm_kzalloc(&pdev->dev,
> > +				      mem_regions * sizeof(*(ipctl->regions)),
> > +				      GFP_KERNEL);
> 
> devm_kcalloc()
> 
> > +	if (!ipctl->regions)
> > +		return -ENOMEM;
> 
> ...
> 
> > +	info->functions = devm_kzalloc(&pdev->dev,
> > +				       nfuncs * sizeof(struct s32_pmx_func),
> > +				       GFP_KERNEL);
> 
> Ditto.
> 
> > +	if (!info->functions)
> > +		return -ENOMEM;
> 
> ...
> 
> > +	info->groups = devm_kzalloc(&pdev->dev,
> > +				    info->ngroups * sizeof(struct s32_pin_group),
> > +				    GFP_KERNEL);
> 
> Ditto.
> 
> > +	if (!info->groups)
> > +		return -ENOMEM;
> 
> ...
> 
> > +	ipctl->pctl = devm_pinctrl_register(&pdev->dev, s32_pinctrl_desc,
> > +					    ipctl);
> 
> > +
> 
> Unneeded blank line.
> 
> > +	if (IS_ERR(ipctl->pctl)) {
> 
> > +		dev_err(&pdev->dev, "could not register s32 pinctrl driver\n");
> > +		return PTR_ERR(ipctl->pctl);
> 
> 	return dev_err_probe(...);
> 

Will change it, thanks!

> > +	}
> 
> ...
> 
> > diff --git a/drivers/pinctrl/nxp/pinctrl-s32g2.c b/drivers/pinctrl/nxp/pinctrl-s32g2.c
> 
> Similar issues has to be addressed, if any.
> 
> ...
> 
> > +	return s32_pinctrl_probe
> > +			(pdev, (struct s32_pinctrl_soc_info *) of_id->data);
> 
> Broken indentation.
> 
> ...
> 

The checkpatch.pl seems not to warn this but I will definitely improve it.

> > +static const struct dev_pm_ops s32g_pinctrl_pm_ops = {
> > +	SET_LATE_SYSTEM_SLEEP_PM_OPS(s32_pinctrl_suspend,
> > +				     s32_pinctrl_resume)
> > +};
> 
> Consider using DEFINE_* PM macros.
> 

You probably mean DEFINE_SIMPLE_DEV_PM_OPS. Will change it.

> ...
> 
> > +static struct platform_driver s32g_pinctrl_driver = {
> > +	.driver = {
> > +		.name = "s32g-siul2-pinctrl",
> 
> > +		.owner = THIS_MODULE,
> 
> Duplicate assignment.

Will drop it.

> 
> > +		.of_match_table = s32_pinctrl_of_match,
> > +		.pm = &s32g_pinctrl_pm_ops,
> > +		.suppress_bind_attrs = true,
> > +	},
> > +	.probe = s32g_pinctrl_probe,
> > +};
> 
> > +
> 
> Unnecessary blank line.
> 
> > +builtin_platform_driver(s32g_pinctrl_driver);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
