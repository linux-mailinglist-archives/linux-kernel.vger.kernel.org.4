Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA24639E44
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 00:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiK0Xo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 18:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiK0Xo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 18:44:26 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2091.outbound.protection.outlook.com [40.107.92.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B09D136;
        Sun, 27 Nov 2022 15:44:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZ0XtZTl4Y7lBTCB5ok0Wb6zjNANlJS+JxF9HpAl6z+vzj14Kkbdo9Oj41hbNOYvDEhAAAdpLA1H4J0U1a7ZWKesGGNHH4cB8uYwxsVOiDZDmeXWoMSlYNBgMcTeAltPiKb5uKFEaeARzFALJwcFRPREdlOdnpCDKUt+KTWF/gvrxSOzXOa1IMjQF/us+nPYt4A7SxNpjvs4ILe5tNl8B/oFW9rgDauWFN2Ky/a2hD3hghKRPGi/FZGLmz2Sp+kxr1xRPmCAEJYwpdpqcR0xEzY3wShcYxGvO0WrJjgCU7PgR1BYnaFAH9OScxLL136JPyDPDQzmV8e1qrs6hHARrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6j/7TY2K2Y578k3TUiK7vKf/72YBq16UH7MOAtORg1g=;
 b=T4ymLUfgKLJAQa3UP35hfuOqDzM1DbBoWiBMQxwzl+2zU5siri5WHDSGvZBlYex4hGwyLJtY2Jc15n2ltUwrIj14wNrZb8Z54F/9+ZW6iWG94sUAA+7VA5EuqwToNLGY1EhqsDqFY0JNlEp2TMXDjcZyJLP2LtvD1qs5XphwsQjXe6XAOMKNf5/vXH5RHwulHcd/s41Jb1zkIeCPxzi3mUQbnkbSnCIYec0WvQKZdwwR9msEiHya1hkYqfVkE0b7VMzrPxepiCZVTAWFhEZGItfd7E8jv/Nyb999G7FfTQbIIz8RI+02b0cw5KVudCwAjVT4SrS5GNNGml0vvVdTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j/7TY2K2Y578k3TUiK7vKf/72YBq16UH7MOAtORg1g=;
 b=fqlPDXpBtkF7NxKWBHNplDG80EdS5lezuZ3TALwyV8NHKAxMCg2GjeoXrt/eTVlfLT7DF0j3xVcvqj5CjTYOexqsPISEx3E0J1ShBsnuEU7fagfl10C+9kHHpP4cPRm+n3suQWIzjedh36pyji8nb9MpTCeJOpEBQ9T0iKXcCYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BL3PR10MB6212.namprd10.prod.outlook.com
 (2603:10b6:208:38c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Sun, 27 Nov
 2022 23:44:19 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::45b5:a860:9cea:a74c]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::45b5:a860:9cea:a74c%4]) with mapi id 15.20.5857.022; Sun, 27 Nov 2022
 23:44:19 +0000
Date:   Sun, 27 Nov 2022 15:44:16 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] arm: dts: omap4: pcm959: add initial support for
 phytec pcm959
Message-ID: <Y4P2UIBX8oYcmaZr@euler>
References: <20221123233209.1854806-1-colin.foster@in-advantage.com>
 <20221123233209.1854806-3-colin.foster@in-advantage.com>
 <9cbc6894-4d08-5edd-3b29-e15611700dfe@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cbc6894-4d08-5edd-3b29-e15611700dfe@linaro.org>
X-ClientProxiedBy: MW4PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:303:8e::29) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|BL3PR10MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: a148d501-e401-476b-adad-08dad0d14d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndXKZDQKw8fdVsXJ4LH8DmYNNj8lW3zIuthrohcaX84kdhzG+Ok1QoA/6XCjXQ3qEJntqAJcfF3CM+dGNfb2ViqNGSImIZCXzA7cjg99gL0gP+8bPdebslphJUYCedf5gzE5FFqX2WdFMJ2gNhBEryc8ZTV6P9suquOhERshAl/sAPnQR1kfUYmgVtV+NdvvU1qglcLJGrWGBKA9TY0ODOhTPc+cy9oKVydtgrlg9vyIN0zIAJfITgQOkh4AY8m5YsCVBIueOjbngJ2ndvhVZORtLVVl3qclaJ89QXmDtn8TQBwBk+XxmE9x4OBVuPgLJPa542SvYc7C+JnD6I9EZfZTmKgzSIjQ3zTNnIcQkJYED8uMoPFkti1lr1uBcfVbu82wadgDdDW7icMmjRjjDmYPBk/0zNmWcgZjC3nT1WyQhSUNWFxnwUy6R4XBeZSZ8Qoszriy//gjMs4UHAKsqXijDjj3LmhsCsu4VlNjY2zIs6aiDRb66MXdow+WTtB8hPuEBOt1sTEdl2249bIqplkv/Lf7RxjJZdThNML+u3msRcfUjRrkd4FPOuULkGPj3LdFfc7TZxdo2KdXy+Bqmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(396003)(376002)(39840400004)(136003)(451199015)(8936002)(33716001)(5660300002)(4326008)(66476007)(66556008)(66946007)(8676002)(6916009)(54906003)(41300700001)(316002)(83380400001)(38100700002)(6666004)(478600001)(966005)(6486002)(86362001)(26005)(6512007)(9686003)(186003)(53546011)(6506007)(7416002)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8g20s+kcMcaEn6GWf07/+/dq/cL5k0p1mVVyyi9NLSETvCQV2ZGDVvCIM57s?=
 =?us-ascii?Q?QWJr4+0co5867M9WcsXDnwRauuo98ggBpkDVCng3YsfglkJz1Ebbwf7mKW7D?=
 =?us-ascii?Q?VmfIgtKKS6M0GqXjne+ej4CvsiPKyMAONNCt+dLXg/yOVUqGY+CsOR1zYzfM?=
 =?us-ascii?Q?X/b2JecK8W2l/fg0qxrWm/4ROwApkaGlBQ7LJ1nVxfjjIEHgqCg5Gq7Mgj/a?=
 =?us-ascii?Q?rKM31zSfXB134wUkav9R16zcmREZJuxXdVZ4fKojQ574Q/D522TqKBNsZ/SU?=
 =?us-ascii?Q?wOoENSpR7mAUQEHqtGO4aFUPWxo/PFZqxfQltEs0S8ydA1/+PPqwBYmCu90T?=
 =?us-ascii?Q?XNe3K9bNkFvKHrDbngsi3JtFjBdlAG97xKPC1+kQF7pklWBmaIwx2T7pS4uu?=
 =?us-ascii?Q?kBpP+pz6wZbh+H134sWzocdrsCXaLy6GmahGeABdUDzOzkHCifAELUmkj7Sc?=
 =?us-ascii?Q?BOQsZdHLB1re5rztSzeX0B0iHfkjw6Aq2a2UTIV35Vc1igmR3iphcCwsYYFB?=
 =?us-ascii?Q?SejsggpJw0dg+Je3n8SDr7ryUbF0xRCpoC3ZXv4pVxSPSmXkMGeqrFnaNhSX?=
 =?us-ascii?Q?jyFaRuxlDS5tmsA3uaDH+2a3/uIFcHBdwG33VuSiSDs0ZQ4XsMa1p8GBbvtQ?=
 =?us-ascii?Q?kaqrKbxAkNW+yQhE23IbWKDQTCxSRX/+I71VucX+qfb5GNo1F7DhOlQg6YVT?=
 =?us-ascii?Q?PLPh2XhKJbZAI3QL7oCWJ98FNaJ/O6JvXAUgQCRAzLorSIwq48ytOnT+WghJ?=
 =?us-ascii?Q?e44iIl5qLbOs8JZoyx0QMVukrjxB4h0m1ciJGEK3SOktTb9qlvvrFJ+YTszG?=
 =?us-ascii?Q?R7+23hqyFWqd1Lsju9/k8LD3AGvG6xgHcEn/7XDi50uXdCgW1bYJ39MDcWUi?=
 =?us-ascii?Q?ZmXwQIKEBwftRkh+8HmkwgILzYH6pDavPFMswO05E85/hg4HpfzE9V+0ZVz4?=
 =?us-ascii?Q?5TFX+5qsMUxGAATQ2lHRF8tnAbGcEDyAlb3LCX26Wwo2MT4ElBdj+O1lA3hK?=
 =?us-ascii?Q?nYca3QfBqBZlLaCDKwoa+yayIJgng/HoBZo1h6B89FqmmbJWKEf+C91nPg30?=
 =?us-ascii?Q?wpOA6JnfKBsGnbCCVXBDwLI3nPuOhe8tQyQAMbApgXrdJJHzxl2Zk2GaDZXr?=
 =?us-ascii?Q?EXVnuz8sN4pMRzw+a3AN5jYk8lgGowqlPet5mlyrSwy5akjTxk1FRTLOJKcg?=
 =?us-ascii?Q?R3NV2lVnMzF7m2WWk6J14USH0o46R9fTr1SSaqjPfc9oKrZZLLHTw0YRs+8s?=
 =?us-ascii?Q?VnCVPDWqcq+0SPLbQQSkX/I6eoxDVS8DI+Lqx1CpBzMqCNn4q36qjodDQZmx?=
 =?us-ascii?Q?Fgvs4m3Kl+o20+SJVXZi/aolHNnh0/rtVtcvQrftJGZqqgy4FnCxQWSAZ8/e?=
 =?us-ascii?Q?NmysBQ7L3b6/o8JdsBnzxcOGqO3rucsI/zvSoIwRjdQjimwlswwwnyzXbOFs?=
 =?us-ascii?Q?yGwnQmpx54xzgQNatU5msnqZEm4fHTb05cnXw1pzC3kZa2w+hkDHyYBGheKW?=
 =?us-ascii?Q?+NUXSSkUf88BsaLmwWCcD0dgACggnE3G/QK34V3mrtWtoS19Nvzrz2rFZtJk?=
 =?us-ascii?Q?gKtbZ0rk15t5/Ch6Dl52AMez9iPmEbAp/V0jQr+Paa1/06m1yZqs9V7eY00G?=
 =?us-ascii?Q?v3VyEluEL4f6F2OWgRgZwGI=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a148d501-e401-476b-adad-08dad0d14d30
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2022 23:44:19.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVZlGWARy7GI0Wtx15u5wA4OAZ0LBz2NIsSCK3AGQF7pRrbOX/bZfyh7R0X1MUMGwU7oiRVjOjq6fOeRHOvnquXbn8jEhbjoDhlAO9iDVcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6212
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

I appreciate your feedback!

On Thu, Nov 24, 2022 at 12:57:48PM +0100, Krzysztof Kozlowski wrote:
> On 24/11/2022 00:32, Colin Foster wrote:
> > The Phytec PCM-959 is a development platform for the Phytec PCM-049 SOM.
> > Add initial functionality for the board. The verified interfaces and
> > peripherals are listed below for the SOM (PCM-049) and the dev board
> > (PCM-959)
> > 
> > The omap2plus_defconfig was used for testing. Only the On-board LEDs
> > required CONFIG_LEDS_PCA9532 addition.
> > 
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > +
> > +	reserved-memory {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges;
> > +
> > +		dsp_memory_region: dsp-memory@98000000 {
> > +			compatible = "shared-dma-pool";
> > +			reg = <0x98000000 0x800000>;
> > +			reusable;
> > +			status = "okay";
> 
> Okay is by default, why adding it? Was it disabled in DTSI file?

No. This (and a lot of your points) are based on the fact that I mostly
started from omap4-panda-common.dtsi. I'll remove this and the one below
(and any others I come across, armed with this information).

> 
> > +		};
> > +
> > +		ipu_memory_region: ipu-memory@98800000 {
> > +			compatible = "shared-dma-pool";
> > +			reg = <0x98800000 0x7000000>;
> > +			reusable;
> > +			status = "okay";
> > +		};
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = &uart3;
> > +	};
> > +
> > +	leds: leds {
> > +		compatible = "gpio-leds";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <
> > +			&led_gpio_pins
> > +		>;
> 
> That's unusual syntax.
> 
> pinctrl-0 = <&led_gpio_pins>;

Noted. I'll fix it up. In the unlikely scenario that someone else tries
to support something similar to the OMAP4 pandaboard, it might be worth
sweeping through those .dts[,i] files and applying these suggestions.

> 
> 
> > +
> > +		led-0 {
> > +			label = "modul:red:status1";
> 
> You should rather use function and color. label is slowly getting
> deprecated.

Thanks for this info. I didn't know this.

For background, the naming was intended to remain consistent with the
vendor BSP, but there isn't _really_ a need for me to do that.

...

>+
> > +&omap4_pmx_wkup {
> > +	pinctrl-names = "default";
> > +	pinctrl-0= <
> > +		&smartreflex_i2c_pins
> > +		&fref_xtal_in_pins
> > +		&fref_clk3_out_pins
> > +		&sys_pins
> 
> Squash the lines.
> 
> > +	>;
...
> > +
> > +&i2c1 {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c1_pins>;
> > +
> > +	clock-frequency = <400000>;
> > +
> > +	twl: twl@48 {
> 
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

My apologies that you had to send this to me again. I'll make this
change here as well, noting it is another divergence from pandaboard
(which I understand is a good thing)

> 
> > +		compatible = "ti,twl6030";
> > +		reg = <0x48>;
> > +		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
> > +	};
> > +
> > +	core_vdd_reg: regulator@60 {
> > +		compatible = "ti,tps62361";
> > +		reg = <0x60>;
> > +
> > +		regulator-name = "tps62361-vout";
> > +		regulator-min-microvolt = <500000>;
> > +		regulator-max-microvolt = <1500000>;
> > +		regulator-coupled-max-spread = <300000>;
> > +		regulator-max-step-microvolt = <100000>;
> > +		regulator-boot-on;
> > +		regulator-always-on;
> > +		ti,vsel0-gpio = <&gpio5 22 GPIO_ACTIVE_HIGH>;
> > +		ti,vsel0-state-high;
> > +	};
> > +
> > +	temperature-sensor@4b {
> > +		compatible = "ti,tmp102";
> > +		reg = <0x4b>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_tempsense>;
> > +		interrupt-parent = <&gpio5>;
> > +		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
> > +		#thermal-sensor-cells = <1>;
> > +	};
> > +
> > +	eeprom@50 {
> > +		compatible = "atmel,24c32";
> > +		reg = <0x50>;
> > +	};
> > +};
> > +
> > +#include "twl6030.dtsi"
> > +#include "twl6030_omap4.dtsi"
> 
> Includes are usually at beginning. Is it a convention for all OMAP DTSes
> to add it in the middle?

I thought it was curious as well. My hunch was these includes needed to
be after the twl node in order to resolve a reference earlier in the
file. I understand that to be incorrect... but thinking out loud maybe
that was the case for early implementations of DTC...?

I'll move it to the top and make sure it works. But yes, every .dts[i]
of the OMAP4 that use twl6030.dtsi all have these include near the end
of the file (omap4-sdp.dts, opam4-kc1.dts, omap4-var-som-om44.dtsi,
omap4-panda-common.dtsi, omap4-duovero.dtsi). "twl" node names... etc.

...

>> +
> > +&gpmc {
> > +	ranges = <5 0 0x2c000000 0x01000000>,
> > +		 <0 0 0x08000000 0x01000000>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <
> > +		&gpmc_pins
> > +		>;
> 
> Merge/squash lines.

Ack

...
> > diff --git a/arch/arm/boot/dts/omap4-phytec-pcm-959.dts b/arch/arm/boot/dts/omap4-phytec-pcm-959.dts
> > new file mode 100644
> > index 000000000000..f323d64660d7
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/omap4-phytec-pcm-959.dts
> > @@ -0,0 +1,48 @@
...
> > +
> > +		led-4 {
> > +			label = "board:green:free_use4";
> > +			linux,default-trigger = "none";
> > +			type = <PCA9532_TYPE_LED>;
> > +		};
> > +	};
> > +};
> > +
> 
> Drop trailing new line.

Ack

> 
> 
> Best regards,
> Krzysztof
> 
