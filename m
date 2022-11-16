Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD962BFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiKPNsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiKPNr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:47:29 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AFD4874B;
        Wed, 16 Nov 2022 05:47:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzB2ybGQBGmX0lvUd1fzCtzN7qrzia9JqovDfvJwGH0F47FEGPJy8bwSGaV4QdNFOUqgzAwnEljdK5PAaino3glDyG5ea75PzEohr2JRxCsj3JYtSeVSgE52WTPrFKtdRoTiACMTAsvsa60pI6edVFLgJrRJrn4AuvsFYZQ0J0Ea1nRfO+y+AvMzrFCeR8VxJsIDr9y/20alHK65VbKUSHvdvHbRakRT4KSkPPbgoVVWQjyZFwdncYM/Grjb0tN4TrRg/h+dI/DCiEMf6VX1Y+KgOvJQFRaxYeAukDxFORyHoehmhfPmLNZcc+rMtS7cWXHsGDzHPjwVtyHjkd+rqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcshkEUNQq63BWdAcOsocrTd3ZgTonZ71bNsZTrIxig=;
 b=F8rpplxY+J0VGXK2McvdfQlhDU5rny5Nqk6pB3fQdn3FKFiS2ediU9s5DpRRngiDaOvnZ9QD7BGDfldozWyJlFYkQrF4n8C0B+E7mCijVMuotIsKBOtTsb3hGY0Td3/Zys1D4kRcMyO0lCIY1++KUT54TggmlzHdSEe3skRElAS6MdXEdx03t02e0KYqmwpRarqdo8yO6/IGCH9gVZEeao1bWZ92dai2dbfhvJOeGOP5B1y4zGmXAzWKzUwDb15JnpiDwsk6lZOzEKSxdBeeB1I+wlF1H5zhzKKJOvM+vw2c0jMlQiBDggSS5FHhjHFxCkiYvAnl6pS/bsoXwY3Ibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcshkEUNQq63BWdAcOsocrTd3ZgTonZ71bNsZTrIxig=;
 b=rjjhADd4TCf/ZdIJ0GnQfSaq7Xc17vBooUAIKJNJu6SWxeq27Nv/7Y1bE1Z5TCE69+9Z2wHSzTKOLGtnqIX4lpF5X3cy7dqeRGIkZgXMqRzsT1gARjGL9gwJ4N44F96Sm3Um+dg+wezQ1HsSdhasgYbbFS+G7o4nQnbE8Vj797hiZRFLjApx1arAxP34hXknqA7hlaBV1UcE5Uv+BBKXCHCFJrdSYDXrQp6XHEOiOo+8pov4ZmtO9/Sg+Eq45gNAThrJniVWaWeEGqQMCfsO1yqgHAD5+daDansiqWn1Xu0eC6Aqx8xlR8IBfw+FEl0bL0fIQvTP9+Yi02pV8wHxaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Wed, 16 Nov 2022 13:47:15 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::f76a:b86b:c6a:b4c0]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::f76a:b86b:c6a:b4c0%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 13:47:15 +0000
Date:   Wed, 16 Nov 2022 14:47:07 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [rft, PATCH v3 1/1] gpiolib: Get rid of not used of_node member
Message-ID: <Y3Tp2y9U8PcDh1r/@orome>
References: <20221116091859.64725-1-andriy.shevchenko@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HGaPac9GqzTm2rOz"
Content-Disposition: inline
In-Reply-To: <20221116091859.64725-1-andriy.shevchenko@linux.intel.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.8 (2022-11-05)
X-ClientProxiedBy: FR0P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::14) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b026cb-2f84-4337-4e41-08dac7d911d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5BJl8tMBcCnkz6PPHP0ZeqS9ol8elw/bAOw46wSNhOgKhQaiZlyTVQ8Aq2JTYD9j9HdlcRE9e8jXTTRgiEt07wFFcs1KtYrWu89ODyQtLyzeLOKlP5ScdeSUlFrvgilGOF0k8D4CrRNfdZViiBX3xRiw7mvwaXwaB92JxDxjHGVf2y61Z9N/praH+Hc+mtoDsMFBupZTVcg4j52+G8MWEloWeTyyoyT9EIXRYhKslbnIS8UbOLxqqx3wDeAiD9So3yc2UyU9RriDeEdv4c/9TV93kvLzDJLRpHwZkJP+I6o8oRH+1NMtsyEwj76WpoOO+hK3IB+RnMe7F4N+eFwNzocqToavvSPRzMMvpYFUWKGRwLAykMeklA0d9FEM4wSSkAM94GcKI0TC/pynPg9WiXewOqqtGqLph1v0BP+I09Nn6rdGHpr9giBvZcPxi/kiZ96sTXIAKOrTbMSK7+wltSLee+3EqoYk6tvcHeJilFsUs59XyEzhPQS4gbirHW+fJG1TfwUBdthjwkxac5duXu1FEamAzNOAiU35BnUc0l0ERaVIenqx5xY/mY1lsFMWSV0BY6MlzRTGmKyYO7zGmflaoHp9ckS7QRmgX9TaY2acapmhlVcuRUwBduSRGVg2eHyXHFYOB0cu4wT+25vnTvAMEbZqkw5rIUVc5hG/u8SOKPYoRt02YUpUwOkESPNksTiK4EsyVgasQv1g9IsrwAkO9nQEHY2U3tUrHPJaweLToJE9ou9FFmk9uLnL1XVivPz1vV3YHurdwBY7OTn+iUsLRJ7PGXgGRnI1qMixn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(8676002)(66556008)(4326008)(9686003)(186003)(6512007)(5660300002)(41300700001)(8936002)(66476007)(38100700002)(86362001)(66946007)(21480400003)(83380400001)(2906002)(33716001)(6486002)(316002)(6506007)(6916009)(54906003)(6666004)(44144004)(478600001)(26583001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zyEdWOoZBLjQiWehtlMJVt5mp+zfELi2Ie3KQBrNK4PXaZBVBMip9/nHPqKU?=
 =?us-ascii?Q?1O/tB/l0hcpHXSNCYSzbZeulxp+GBYDy6+axb7MFKhOpe17Ggcf+Q+61U1Jn?=
 =?us-ascii?Q?fG0aICEDLhml+gJCNNBcIdvx7XNcUVsnDb8nb5CD6E0+V26sMg50Iq+J4IOA?=
 =?us-ascii?Q?qp/DAFFV3Iw/XaaMkvMAPDcwny/BL0wwCF2z7DaqKleD7JULO68o5hxs7hqR?=
 =?us-ascii?Q?Q9z1F0OjCxskhjRuW7lanPn2AUpK6BCKEUtfjJvRByxj0KLMTErVFJgaZgU8?=
 =?us-ascii?Q?ER8JCvm6XUF1WfAN4joSv2+D+Gkkh2aTE8mRmWVPsvnIxQQ09Mj9jW6t2hR3?=
 =?us-ascii?Q?bHnmCEnFUMezuJz7WK+2ZsemyLIoG/U8N+ktPG6KJkC4XmS71cGWmEPUmPo5?=
 =?us-ascii?Q?EA/lW0Sekb6LufBQRanOcqp5XN+PyDX27nXbtel1oKQo+slnPMmulm+jdcW8?=
 =?us-ascii?Q?zZG8Cp/GlHGG5RvEoQ6ZyHZoTo5uUmv1yh2Wqyy/xk3RrILuUVXJ9/tFoJiX?=
 =?us-ascii?Q?mDtjPAQ4nsCbL4uP6V4qrpDsBuL5/Jx4qNYya2hcKqMJ6rXOBAq6+wyFAnRu?=
 =?us-ascii?Q?ak4WDqi5UAj7Bkeh631BCpaAbiYfgDe7j9NE1s4ifTO8+Y1lQvBpaJOhrw91?=
 =?us-ascii?Q?q7Y7UKloDy/d9oHzP1TGvCSqqv0gbbnT4ab7ER+Erk61Tgz3PnGkv9QARAe7?=
 =?us-ascii?Q?EhZypofPcLx1pq0sFDVIVlgNPeg5veoX7Wlcwby3lGqXBrtpy4v2bouFSzO3?=
 =?us-ascii?Q?u8xW5TMdcgMGexQENAVTXqWxIfquNegNU7YMJD7UZTYgJ7Yi95lteFh71y1e?=
 =?us-ascii?Q?cPGqNNyklxPrBV7bmiKuZpdLM16mV4KVCGv6eVc+kKxbta83arWKo7ZbwOhy?=
 =?us-ascii?Q?b5vPPYkdiSJi5OmF4Pq6SrRfy8yCIpgh98x0suK0l+jaAh/EIZH3cQf4jj3n?=
 =?us-ascii?Q?TLhUjaAKe8XnJ5ax3NqZH2cXeKe6baAJlWmlPHsxTMR7O6+fW6UhXf2k/sb9?=
 =?us-ascii?Q?lkEIeNfE/CZLyWH/jI60AtSibM4DPqMBdKdMVCj0YC6K4PzzyKh53cextSF7?=
 =?us-ascii?Q?BBHoAn8dJKEIBLBcgTvDMaIPelkwfvVNRiZp/DaqjIMDTcI522yvBnzTtnf9?=
 =?us-ascii?Q?6nBxJNzPYdFC0Vv5b+9yT/X1czlvJYPL0txmf49SzGrqCMfzpPDfHuYOULgp?=
 =?us-ascii?Q?I/lccMnDAYGTbkizI7PYPml2RoGB3Kjg8m7jPtDXAls1jHSAOKHHIUZOCO9Q?=
 =?us-ascii?Q?V6VYcVfN4f9KQJu4+hQwJJOvjrsFlNiRi1YDMJo1PmWxp4BUYOlOfH+QWAuH?=
 =?us-ascii?Q?7H+2g3g2wDrDLhUb10fgVx8WH7jCyqBGUgtfT9Rp3tTgLYQQZWoQ72vWQnUv?=
 =?us-ascii?Q?WHDMOBEDXrCQO6PiE1F7ENtFvekYpK+zTj+B6M0NjvlZc31HuGpyMH91A1sJ?=
 =?us-ascii?Q?DvEHiskHDMixOPYMI9IdpXK3tjktO4Nm99wxMiYiDHSqABScOsI//4WIoO+t?=
 =?us-ascii?Q?vhQIHVHTpTtIw4DYgl7fDWhnjehYscve3bc2TDqzW4bJ77uBc30/e0LZelcY?=
 =?us-ascii?Q?T8NnnDIokxZt5AVFmHFquwaE4ndzZkSHBl+mhg+X3HF+KX80pZucM/vVb+ho?=
 =?us-ascii?Q?SeEtKiWsZf/D968GBxTzOuveL3ovm1e7xQMHx7aRl8GB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b026cb-2f84-4337-4e41-08dac7d911d0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 13:47:15.2352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ER54GB5mPD+4vSZCDpEbLYDX2TJOkcwPqk52rsSOlIJd1VnUI5Le2RGwAVhNEwOa8lpEoQUsm0+yeghYtPQoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--HGaPac9GqzTm2rOz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2022 at 11:18:59AM +0200, Andy Shevchenko wrote:
> All new drivers should use fwnode and / or parent to provide the
> necessary information to the GPIO library.
>=20
> Cc: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>=20
> v3: rebased against latest Linux Next: expected not to fail now
>     (Also keeping in mind Thierry's report, so reworked a bit)
> v2: resent against latest Linux Next: expected not to fail now
>     (Linux Next has no more users of of_node member of gpio_chip)
> v1: to test for now (using CIs and build bots) what is left unconverted
>     (Expected to fail in some configurations!)
>=20
> The idea is to send this after v6.2-rc1, so we will have a full cycle
> to test. Currently one patch is in pin control tree prevents us doing
> this during v6.1 cycle.
>=20
>  drivers/gpio/gpiolib-acpi.c | 10 ----------
>  drivers/gpio/gpiolib-acpi.h |  4 ----
>  drivers/gpio/gpiolib-of.c   | 24 ++++--------------------
>  drivers/gpio/gpiolib-of.h   |  5 -----
>  drivers/gpio/gpiolib.c      | 11 +++--------
>  include/linux/gpio/driver.h |  7 -------
>  6 files changed, 7 insertions(+), 54 deletions(-)

Seems to work fine on Tegra210 (gpio-tegra) and Tegra194
(gpio-tegra186). One thing I noticed, though, see below.

>=20
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index bed0380c5136..466622a8fb36 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1387,16 +1387,6 @@ void acpi_gpiochip_remove(struct gpio_chip *chip)
>  	kfree(acpi_gpio);
>  }
> =20
> -void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev)
> -{
> -	/* Set default fwnode to parent's one if present */
> -	if (gc->parent)
> -		ACPI_COMPANION_SET(&gdev->dev, ACPI_COMPANION(gc->parent));
> -
> -	if (gc->fwnode)
> -		device_set_node(&gdev->dev, gc->fwnode);
> -}
> -
>  static int acpi_gpio_package_count(const union acpi_object *obj)
>  {
>  	const union acpi_object *element =3D obj->package.elements;
> diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
> index 9475f99a9694..5fa315b3c912 100644
> --- a/drivers/gpio/gpiolib-acpi.h
> +++ b/drivers/gpio/gpiolib-acpi.h
> @@ -26,8 +26,6 @@ struct gpio_device;
>  void acpi_gpiochip_add(struct gpio_chip *chip);
>  void acpi_gpiochip_remove(struct gpio_chip *chip);
> =20
> -void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
> -
>  void acpi_gpiochip_request_interrupts(struct gpio_chip *chip);
>  void acpi_gpiochip_free_interrupts(struct gpio_chip *chip);
> =20
> @@ -42,8 +40,6 @@ int acpi_gpio_count(struct device *dev, const char *con=
_id);
>  static inline void acpi_gpiochip_add(struct gpio_chip *chip) { }
>  static inline void acpi_gpiochip_remove(struct gpio_chip *chip) { }
> =20
> -static inline void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_=
device *gdev) { }
> -
>  static inline void
>  acpi_gpiochip_request_interrupts(struct gpio_chip *chip) { }
> =20
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 4fff7258ee41..00b55dbe0323 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -668,7 +668,7 @@ static struct gpio_desc *of_parse_own_gpio(struct dev=
ice_node *np,
>  	u32 tmp;
>  	int ret;
> =20
> -	chip_np =3D chip->of_node;
> +	chip_np =3D to_of_node(chip->fwnode);
>  	if (!chip_np)
>  		return ERR_PTR(-EINVAL);
> =20
> @@ -760,7 +760,7 @@ static int of_gpiochip_scan_gpios(struct gpio_chip *c=
hip)
>  	struct device_node *np;
>  	int ret;
> =20
> -	for_each_available_child_of_node(chip->of_node, np) {
> +	for_each_available_child_of_node(to_of_node(chip->fwnode), np) {
>  		if (!of_property_read_bool(np, "gpio-hog"))
>  			continue;
> =20
> @@ -970,7 +970,7 @@ EXPORT_SYMBOL_GPL(of_mm_gpiochip_remove);
>  #ifdef CONFIG_PINCTRL
>  static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
>  {
> -	struct device_node *np =3D chip->of_node;
> +	struct device_node *np =3D to_of_node(chip->fwnode);
>  	struct of_phandle_args pinspec;
>  	struct pinctrl_dev *pctldev;
>  	int index =3D 0, ret;
> @@ -1063,7 +1063,7 @@ int of_gpiochip_add(struct gpio_chip *chip)
>  	struct device_node *np;
>  	int ret;
> =20
> -	np =3D to_of_node(dev_fwnode(&chip->gpiodev->dev));
> +	np =3D to_of_node(chip->fwnode);
>  	if (!np)
>  		return 0;
> =20
> @@ -1092,19 +1092,3 @@ void of_gpiochip_remove(struct gpio_chip *chip)
>  {
>  	fwnode_handle_put(chip->fwnode);
>  }
> -
> -void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev)
> -{
> -	/* Set default OF node to parent's one if present */
> -	if (gc->parent)
> -		gdev->dev.of_node =3D gc->parent->of_node;
> -
> -	if (gc->fwnode)
> -		gc->of_node =3D to_of_node(gc->fwnode);
> -
> -	/* If the gpiochip has an assigned OF node this takes precedence */
> -	if (gc->of_node)
> -		gdev->dev.of_node =3D gc->of_node;
> -	else
> -		gc->of_node =3D gdev->dev.of_node;
> -}
> diff --git a/drivers/gpio/gpiolib-of.h b/drivers/gpio/gpiolib-of.h
> index a6c593e6766c..e5bb065d82ef 100644
> --- a/drivers/gpio/gpiolib-of.h
> +++ b/drivers/gpio/gpiolib-of.h
> @@ -23,7 +23,6 @@ struct gpio_desc *of_find_gpio(struct device_node *np,
>  int of_gpiochip_add(struct gpio_chip *gc);
>  void of_gpiochip_remove(struct gpio_chip *gc);
>  int of_gpio_get_count(struct device *dev, const char *con_id);
> -void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
>  #else
>  static inline struct gpio_desc *of_find_gpio(struct device_node *np,
>  					     const char *con_id,
> @@ -38,10 +37,6 @@ static inline int of_gpio_get_count(struct device *dev=
, const char *con_id)
>  {
>  	return 0;
>  }
> -static inline void of_gpio_dev_init(struct gpio_chip *gc,
> -				    struct gpio_device *gdev)
> -{
> -}
>  #endif /* CONFIG_OF_GPIO */
> =20
>  extern struct notifier_block gpio_of_notifier;
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 7936d54a2e30..3df482d36366 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -655,10 +655,12 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc=
, void *data,
>  	int ret =3D 0;
>  	u32 ngpios;
> =20
> +	/* If the calling driver did not initialize firmware node, do it here */
>  	if (gc->fwnode)
>  		fwnode =3D gc->fwnode;
>  	else if (gc->parent)
>  		fwnode =3D dev_fwnode(gc->parent);
> +	gc->fwnode =3D fwnode;

I'm not sure we want to set this one. We recently discussed this in
another thread and my reading is that gc->fwnode is supposed to be used
only to explicitly override which fwnode to use if the default isn't
appropriate. Right now the standard way to access the device's fwnode
seems to be dev_fwnode(&gdev->dev), with only very few exceptions, so
it'd be great if we could settle on that, rather than introduce a second
field that contains the same value and use them interchangeably.

One way we could enforce this is by setting gc->fwnode to NULL here
instead of fwnode. That should cause a crash anywhere it's used after
this, so we should be able to easily weed out any abuses.

Of course if people prefer to use gc->fwnode instead, then we may want
to remove all uses of gdev->dev.fwnode. There's simply no point in
keeping the same value in two different place, it's just going to lead
to a big mess.

Thierry

--HGaPac9GqzTm2rOz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmN06dkACgkQ3SOs138+
s6F75hAAr1ex0eND+niilyW8IEFdciLe8k0H/aXNWRab7wxEVZ1wLX5KdmHP8lc6
Wr4VEeAZQCRSc0iPQKBueuVC//UZBasxHPmURs7y5ly/O30jlg2Jl9InmpmXwqMk
4hQanKB7whqXxALyqEnMt89LDVnHH73oS3qEAbHncLyP1XZOTxz5WMYZqI9TkZDy
ms1Tkx2H5WiATHPIyuEBCPw0smyYWk/izWzcBwlFqS6pKpM4GUnBBBtuNcC5Hbh5
Rny5oqiyWXO/X4iB6g9yXOpQRV8X4quarEIoOC9lzn2tXKwr+LE9PdRLx8nqlVQk
FacWbBaa7OKDwRdi852dS5Id0WVeb7oeO0QNNy9h+UZKZfAbJFGeS7SY8CUqklCu
cx0HJ4h5ZHFEBwsA7osoNncRkarTFAQaCQZl7Mk5CyJerJJz5DchazZTp+KgpAdK
RPTG85n6Smk385gb1N8VUxLGzkoMIZKqnO8wH1W6alZWEcAS3ab1Oak6VZmo2HQA
PiayAgaxYZqRk3MvCgP+dAGCCfKQ9EXoh0EY+iPa0/ndFy/GbyDdfU7dDnGHF4lY
CcyfNTfHhKlcRi3vDLouvNXlzT0lZAtCUZD+qSmnUVeiw7IyRqKUjrm4KhHj5nFh
jkesrxVnds2X/5tlmmPMTx+Rto93ik9fyHjCc927CDPQabCJ3wQ=
=KkTX
-----END PGP SIGNATURE-----

--HGaPac9GqzTm2rOz--
