Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050256F1A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346140AbjD1NyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjD1NyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:54:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40F5171E;
        Fri, 28 Apr 2023 06:54:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2npiSEyYhE3qU6v4YSrPs8OwdyPq1Th8AXBNDwOKuXZdIP5Xs9VBdy8YSM1GWWDV7R2kF47CRv1WyICMWVGNPWq0FlY9OmEhJQm1ntqGvNUHRzM+QOKDjnrP7Lui5D0jhUzMoQyznTN+MKnX7Gf/l8DdTT7h2HrbauIYvjpTGQ+6ECii3QoxVZzUhq3vbqG5UpXSWmtsz4nRuMxWsIB78MeJswLt1wMc++lg4JOSygWNQlI1KWPLiP/8gFXHgESsDJ62N9v4JqBXr13OyJr2njbTGt6+mpZ+9mUbbuLEWI/G66U7vldFakbT4uDj6yFbIZkmb4plonKG2aZYM5+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zt0tx64esQJON2xWu7O1HwHf30/YGOuSQtuYXiAGOB4=;
 b=HugCiLMfKjaHQIWiY9MdS9KC0wjnE/lN0rPinmlSQwsCvLCm3HKVa8Q3VvGAuOJmJMkhLjqr8YScC6ftNtH19dBOVmA6SO1HwBm3atOBmb/CVfspNI96F3pqoAhspGxf5XMVBnjadaZgkW9HFPtJPLaInhBJluxchlqg9xrAv0Aohr6iwPC0FqUghAQJWLpiSZ9MfOJUTaMlHaJyYkrZWM3Hz14cGFAqFMqfCTxhpDzo8UQGJfGOnGjZN/DpaMbAWtr21HqgAcAFIKvDWPNsr85xAxP7sYXIac6XtSoMwtUiG3hsJ1Uyudhsvbq+1JBx/KTlN0N4FLVi94QhfOt4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt0tx64esQJON2xWu7O1HwHf30/YGOuSQtuYXiAGOB4=;
 b=BMLHdZ2ikBQ92ioaXud7MOK60ZswXe52b38LxxNLycTFnPWtndeK6ecMkXlsurWellJg/H2XMD1R3ZfGlP49EX77qpY2tgl1lqfsQL8g0z5HR5vTDf7T2BmesJSyyStqWBKeSuZX/yIpXU452hV7HH8DZx00mAz/cZWnwEAqdU8=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 13:54:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 13:54:19 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "nakato@nakato.io" <nakato@nakato.io>
CC:     "korneld@chromium.org" <korneld@chromium.org>,
        "Gong, Richard" <Richard.Gong@amd.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: RE: [PATCH 4/4] pinctrl: amd: Revert "pinctrl: amd: disable and mask
 interrupts on probe"
Thread-Topic: [PATCH 4/4] pinctrl: amd: Revert "pinctrl: amd: disable and mask
 interrupts on probe"
Thread-Index: AQHZdEm+2fFlWDLS3UiVlgiJ5Orvaq9AyN4g
Date:   Fri, 28 Apr 2023 13:54:18 +0000
Message-ID: <MN0PR12MB61017C1D19E64CE24BD81E8AE26B9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230421120625.3366-1-mario.limonciello@amd.com>
 <20230421120625.3366-5-mario.limonciello@amd.com>
In-Reply-To: <20230421120625.3366-5-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-28T13:54:20Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=111de72a-0506-4570-b154-6fede051d203;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-28T13:54:20Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: af4fbce2-974d-41fb-a9b2-9a2d34b79878
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|IA1PR12MB7520:EE_
x-ms-office365-filtering-correlation-id: dee02a49-fb6c-4206-c885-08db47f0100a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eaIdbAczxyVH6HcsOY8HdsIhbbhebQ1HaLP8C8gMoupc0kNT4eYGV8bqjjDVhWiLJm8r8f1Kb4IXCioiOhhpWm5INXzzMWYEKUqYEq6sBPfy9uPMfjpdq1SoeAExCW3PVcuk/SVKSpBoUQ57NK5Zqvg9nbmloNbe2ot6lZIwaqOtGwJ6u4Two14VCZjM61d1Q+BzPi88+cOG4fL9uR/aK7E5I1/r65S+UpOp/2B8fC5xjzubare0qNMklpe5ezqpQ3kFO10KX5HxyVG9VNqkLTzeNIoUGSwTM+Dm/PzRli1RAdUYk/Uxpk/7lKlh3vupTipzyEbUzwb7sG5Cbau9N37JSfr1/MgKlHuOX1b4iXxw0S1Pg+oz+Lbzabh5cEF9BwnfQ0VRm1t5qk64FB8wMhJweC+jq+Cy7VATd0DmYM5U4MgF4Juz+O9pSR5r2Uk+fwlWoPS6ACVv5nNquMhBfohAe0OyJiyfhOdwSDEWA9W7UadHVns+Z4ahawqlpK5eQMudwDhAQfcsDmwMNw2BrBBLZDnq1z87FXvMLsV20+F0wcgR+Zu3wXcb2nwUPW99hNi3FkSIvJm/qvIyCknV9w4vQXER3HjJuO+08qd8T06PUfsqPXUT5D4KUz9OEO7F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(55016003)(316002)(4326008)(76116006)(64756008)(478600001)(66946007)(66446008)(66476007)(66556008)(8676002)(54906003)(8936002)(5660300002)(38100700002)(6916009)(52536014)(83380400001)(71200400001)(186003)(7696005)(26005)(9686003)(6506007)(33656002)(2906002)(38070700005)(86362001)(41300700001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KJFoQ4uW4UYWaDh0e6GJ/QjXcVxtkfKzQMvftx9tEcauiB/j7EoqJnsEYLlX?=
 =?us-ascii?Q?PbYp626v+pftTs+S8fXq+gUf45xCtC41o6tvF1wJ0KR9pho5AQdptuL5ikWW?=
 =?us-ascii?Q?6/qxW4exu7r6JwWZOzn6428Djvm1/GlrECD7l4NQh+zukemoWg7il2ZYyWGZ?=
 =?us-ascii?Q?44CxhFKWEdJYZatIBYrq/EMc23uzNsTsqBSQKx08LYRAhQFeVBjSrIzCEb7e?=
 =?us-ascii?Q?GL3QR33UlIpJjNN6qhzLEg3TXu4LLr2ZAotLzPpMScfAiruNm/Ow5CuAPjWR?=
 =?us-ascii?Q?qIVPjVvRNw7tUP98YHhpkiwliq+DD8WYPN6cZ94bMf/yeJcbl1ZcH4HVOJop?=
 =?us-ascii?Q?4kKUJQZQCjJxBgoEENJLdz2pkLJhjrXanepRoVmY0/v/RUqSvmw077paz7AV?=
 =?us-ascii?Q?m8HXj5EvMf1yHmOmXo3ja+s08TI50u0nxljhc6BzsBoh6n1278en3jXGpFhu?=
 =?us-ascii?Q?7cfoPhxd8QN0pinuyaZq1Ev7Hp79Y+0NAwb2Ec55cX9GdLEj+LtulALFpSu/?=
 =?us-ascii?Q?8yC1XdkWG90veBWu4mW0/1pmo6f3LEigKYj7uBrCTF8MgAHBPAYExC9NxM31?=
 =?us-ascii?Q?l3tsl64v2PRPL1KIhU1oGdUO/ePbsxop1ZYNkgiIr5/ER0pEfF/WNHGLEAQs?=
 =?us-ascii?Q?M8NBkwvagS7Y1p9xzYWkIw00y+zhCMH4ncfLrmu+/HoMgmBOsJCsqrEyf3zp?=
 =?us-ascii?Q?/8+vBHQAQLhZjP3zORlwBK0+IF1hvDCNFc9AOYiNHrWylWoJDtAVDFp+B1Ih?=
 =?us-ascii?Q?kKrXqp6jFkgmZIYzP7eTIjSy3QjNOar+RxYJ+BSFCZHGj8SDXxCeIVa1cvX2?=
 =?us-ascii?Q?9BfjmaWymJceSOxDMOZk1/roo+fgF7nZlA2N3IyLhGXtSCrwSWMfEyjBK2+J?=
 =?us-ascii?Q?8RIuMnUuQBSlzWeWocir0/D07jrzGzEL1qPr4fYoDCSZ3u604+xymL8y+NjL?=
 =?us-ascii?Q?bjjy1q5nUacsji8Ze8Bd+trdINFyZZ+3GjlHbeeawlXbloghQrEuJEj8Jiai?=
 =?us-ascii?Q?PGtNr4berTr0XvvqD0IW56Yn0M40PuDz9BwZueJLIx7hNW4oxzHn1I2vJPfA?=
 =?us-ascii?Q?N0/ANunuS0Ptwa2muNm6kB+L2+Fi22GoyjPhX1jgqIgUgGFh/LrYn09ZTcbx?=
 =?us-ascii?Q?l9bJMfRojKspETUCiQboMeAWfZvKr2oCvvdeNZSkm8y3HmS5j/nE4PGX/Znh?=
 =?us-ascii?Q?Tts/KKcR4ZKTcP8UJMry2/7hbP7fEgFkxv73xUseaetFnEJt7OUHvCWxIFj7?=
 =?us-ascii?Q?LK7RFAW5ZNbD4SWSeMF/kTXSy771bJEE1MAmV79n4AOE1my4HUv4z6s4Q/HZ?=
 =?us-ascii?Q?yqSCvHkDPkre1AxVaFho5mC7ybs5PPKWSKSI7cga5GCH3ZEW0JNTx9rTeRQ5?=
 =?us-ascii?Q?1wDfz7MtaZas9aYbF1fre+mF2fgzWeuxHRO7ALjmmtQ/4A3zhkk7lNqmD4QO?=
 =?us-ascii?Q?IiBwNuqPqbFL9JakxHrTTOlnUd/hI4Vz72EWPhSdn0DaaEcM48FtHBgYTcZN?=
 =?us-ascii?Q?Y80IU6EJ5XxRms+gtsxUhADNgHfMls6hr7cREKnqnJeVZG6mhXHH13Q1oePN?=
 =?us-ascii?Q?MEXzvbgTE5kHCzFWo1E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee02a49-fb6c-4206-c885-08db47f0100a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 13:54:18.9718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: exVHsoVGbVrIZIp1gF6KXKRmApo1zb92/72y4VqUTy3qlhdJaOMg7LBEYk7IoDw3uoG0p7iowwWZy7U05i28JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> commit 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe"=
)
> was well intentioned to mask a firmware issue on a surface laptop, but it
> has a few problems:
> 1. It had a bug in the loop handling for iteration 63 that lead to other
>    problems with GPIO0 handling.
> 2. It disables interrupts that are used internally by the SOC but masked
>    by default.
> 3. It masked a real firmware problem in some chromebooks that should have
>    been caught during development but wasn't.
>=20
> There has been a lot of other development around s2idle; particularly
> around handling of the spurious wakeups.  If there is still a problem on
> the original reported surface laptop it should be avoided by adding a qui=
rk
> to gpiolib-acpi for that system instead.
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sachi,

Any feedback on this series, particularly on this patch?  I'd like to under=
stand
what GPIO pins prompted the original patch and if 3/4 of this series helps =
the
original behavior so that we can have confirmation the revert is not going =
to
cause a regression for you.

Thanks,

> ---
>  drivers/pinctrl/pinctrl-amd.c | 31 -------------------------------
>  1 file changed, 31 deletions(-)
>=20
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.=
c
> index 675c9826b78a..e9fef2391b38 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -877,34 +877,6 @@ static const struct pinconf_ops amd_pinconf_ops =3D =
{
>  	.pin_config_group_set =3D amd_pinconf_group_set,
>  };
>=20
> -static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
> -{
> -	struct pinctrl_desc *desc =3D gpio_dev->pctrl->desc;
> -	unsigned long flags;
> -	u32 pin_reg, mask;
> -	int i;
> -
> -	mask =3D BIT(WAKE_CNTRL_OFF_S0I3) | BIT(WAKE_CNTRL_OFF_S3) |
> -		BIT(INTERRUPT_MASK_OFF) | BIT(INTERRUPT_ENABLE_OFF)
> |
> -		BIT(WAKE_CNTRL_OFF_S4);
> -
> -	for (i =3D 0; i < desc->npins; i++) {
> -		int pin =3D desc->pins[i].number;
> -		const struct pin_desc *pd =3D pin_desc_get(gpio_dev->pctrl,
> pin);
> -
> -		if (!pd)
> -			continue;
> -
> -		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
> -
> -		pin_reg =3D readl(gpio_dev->base + pin * 4);
> -		pin_reg &=3D ~mask;
> -		writel(pin_reg, gpio_dev->base + pin * 4);
> -
> -		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
> -	}
> -}
> -
>  #ifdef CONFIG_PM_SLEEP
>  static bool amd_gpio_should_save(struct amd_gpio *gpio_dev, unsigned int
> pin)
>  {
> @@ -1142,9 +1114,6 @@ static int amd_gpio_probe(struct platform_device
> *pdev)
>  		return PTR_ERR(gpio_dev->pctrl);
>  	}
>=20
> -	/* Disable and mask interrupts */
> -	amd_gpio_irq_init(gpio_dev);
> -
>  	girq =3D &gpio_dev->gc.irq;
>  	gpio_irq_chip_set_chip(girq, &amd_gpio_irqchip);
>  	/* This will let us handle the parent IRQ in the driver */
> --
> 2.34.1
