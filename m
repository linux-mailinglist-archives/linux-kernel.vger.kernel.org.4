Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEC36AD1C1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjCFWje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCFWjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:39:33 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CA525B85;
        Mon,  6 Mar 2023 14:39:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkz7DLCQkLS9q0AmHkZEllO6237Fls/8RiLZv46vhOTH2eWSuumEqnTidtig1hvmLFRA6Lh1OadFdIfwQPazaspggR8Vl/I4EU6l/ps2Yd5OwWHxjIT/yKww4aauwVw9qJ102zGXFC//kbGYJqMrSri57YMR3+hgmYU3HwoJJpJ8B6vmWVqzAIoDBLONWnK0wuBsbaBX6jMVAuudSOaTE+shqiGAjxWf1yVphlgh22aKexsESa/BhDrcwbsJrjTS/FCBAlxanBO3Fi4lYrHX/BxYIfdRHJ4FOfOMXoq2HdHyDHJ/pbBC/JH81fjbf9RZzdwIZIVzHcLzurR/66YkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQUe9mF76snVOZfQXXPhMAxPzYdcys+jhISDCkFrCNE=;
 b=GbyZNu+6jOJcZZ9LujpK9MQvu9cfRqSUH5Deqx+txVAzOa+EgD8HWSUQCIeqyxlIJrW3om1i7qqH8Lo6tgsaSYKwQnPYhUeF3EHDS6Eqbnh2MCuqs6CBxgc0ZlOg4rAvI4Uekz6GTHgSSx6lsEbYdZiRn6YqDgoXs4MMUVWvvKOFxv8jx2fP002imbGFMgm16Zo9cRnHDYWmN/oz9BDPMYcRk7FBLSKhageUk/+WvW78YemKf4uVhTAcHy/4Ed/70J82yjEPN8w/M0kqTCd8mDbplh05/J2XMXYJ+oFQAT9iHgnmdas5GqklDkVcwvJ30wyaGR8nKbJUtycSQPnnQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQUe9mF76snVOZfQXXPhMAxPzYdcys+jhISDCkFrCNE=;
 b=UvP7ReUr9f7YzbVV2umOXKBLr1lSLzMToRMlErl09fpIN2xAup7Pfp76KPHg9MJy8WVAiWn41DVLh26ySOpfzWhxuUTbvKaqUaq3JkTS0jtfR5BAPiLgwPbeIupduECuW4VLV2HYPcI3rqM6NMZEHSg59W2h7LwgCHFzg61sDt/GMddYelUVrCF1Kw2oOgKD1wnaLRFWwPJUGZyj4NAlwtzVQ0jysxomt434YQkal7HNMTRzbamoMQT03qQIzDcFIgsne02vx7cp5hSUA4HGeDW9AwJLYnNR8VP1yas7a9sQ3Xo7L4lYJr3UheVTfRKKKIlO/lBed4Xtzi8Lkhf0xw==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 22:39:27 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::b22f:ead7:357e:803a]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::b22f:ead7:357e:803a%4]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 22:39:27 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] gpio: mmio: handle "ngpios" properly in bgpio_init()
Thread-Topic: [PATCH v4] gpio: mmio: handle "ngpios" properly in bgpio_init()
Thread-Index: AQHZUHBpmwUyJW1DpkeY8R87iuQYWq7uV5UAgAAAPsA=
Date:   Mon, 6 Mar 2023 22:39:26 +0000
Message-ID: <CH2PR12MB38959136005B21C93159C5A8D7B69@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230306211237.14876-1-asmaa@nvidia.com>
 <ZAZrKPw38ERSbzXg@surfacebook>
In-Reply-To: <ZAZrKPw38ERSbzXg@surfacebook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|SN7PR12MB7021:EE_
x-ms-office365-filtering-correlation-id: 07cdbc42-dc21-407f-fdea-08db1e93a467
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UI6a+5vKuD5SzTiIeHrNWvEf6FxBlovfnz8S5GfyOUmGyAOO6YS7mjNMr8VeT5fc8hKpc1POS5QH7SmAFttCgv3yz70OztTaWGPdhxN/vvUQN/H+LxsiaZuIUgw3ZiGwV9mGw6Kh7kWd7LTim+DN1ne3de8ZoOG/0p3JYWN0cbTPGr8ubhh0TXv+k2j3nQQmf2FNKfVPcXPCgrp/zoUMx5x1qkm+VO7GLEaj+Ko96qvtLU8kfgu+B7GzPKtz/+wkwvn2Sw9/hvuccxyD+8LTX6pC6pzvF5bh+GLk+K26DyPs5pQ7rQXV5BcSn+jFr/Dh8Ii8oAnAvr4723k3ToBpAd33/hFLpbycGEebuskgY7hM8Ypm4wQgRNhZzJxIRYJ0fB/EZZtZ6BGR9tq8PxKBAecLgSppuA/mJxwVwzIY63grQllIx7TiuIEe3cPCaujcPEl7n9DrnrHbOuatWnsLP4FW70cXHkkqdSYx8jhEGgdibIXHX81UCioK91GF2+sv+/UvamUstacBe2jcqv3RyMNfLKrV04Vbrpm1qX5PamI6D+vy+n5zFBlVANXq4pXtUEhXybOFR8F3SfiUUIVxtnaeEJMg+jKU9WDrQFazUotSrG8nacircM6lZzRrNCKXIH6KrahpXzE4E4bm1dRgn36C5bML+29Pn/uZEFFEEEYTIG0SBSrOrlRhu3eeAEUQXxRfzsKtytSX8r6oo3OxTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199018)(33656002)(478600001)(71200400001)(6506007)(186003)(26005)(9686003)(52536014)(7696005)(86362001)(64756008)(66946007)(2906002)(6916009)(8676002)(4326008)(66446008)(76116006)(66556008)(66476007)(41300700001)(5660300002)(8936002)(4744005)(38100700002)(54906003)(55016003)(38070700005)(316002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o05OCGwRlSwIEdQ+q50PH6g42q4dd4rbw0DaJBizKZTl6RL4yZrUZUMkCFH1?=
 =?us-ascii?Q?ZbgE0ojR0ycnnhf496MJ4w26NyZ15SpyWAWpvXLsdn8pFrQbBnkMsLkBFiy5?=
 =?us-ascii?Q?iWwbPDRJ9bJ0RsyO+mgVXDFJfLydOhod5jVkv1SIeHMmWe7PInZi+XnMu8sm?=
 =?us-ascii?Q?quUxLIY0t0MQPVyX1uJpPNmNW06IJqQRjyQMvLG4xQDBFZCJx8Z+0OPLBC9V?=
 =?us-ascii?Q?LXi+FCeVAzu9BJK9kjQP/WffAx3TnvNafbNU5RU2MbKZsMxe36PrJC5wjBDU?=
 =?us-ascii?Q?vPg64g/nlhUDW8ppuDsPzWxVLlQjxCNJ20vJxL8Gifi/ZCc3f325pMJMgiBM?=
 =?us-ascii?Q?9xnoglyrVg4vkpC6XRA+lqx1oYmZg21UV0pkABdg49H9cDYdmfXrdEpc1gov?=
 =?us-ascii?Q?BrfhIjFVcu0yop5SkCVZBbNllRTok1ROaZ1gZ3Oxy/sqlJwwjo/UWKmXAptQ?=
 =?us-ascii?Q?dA+tSC2C8VVNOqMeHNj6+A5oz+zZZ1iTZNpuyhw4NfWfUvDEDFGQrdiumgWd?=
 =?us-ascii?Q?AJnnEbXrAKTDkcuo/X/Gr8w4XMDfCcvSExnXGIDYmjCXfsBb5WkDKWQ76MO8?=
 =?us-ascii?Q?6mZo7C2QADPyQWOigZWyOONug7bJiYIFji1DVkWflF4rGHI2zkQYZBAFJHzB?=
 =?us-ascii?Q?JsGX303t0xLLWMUzjrS8A1m4Fx0Y4q5qc40BR4uQDuY+OCk+5GPHLdN1XhJo?=
 =?us-ascii?Q?+B3mpWavPi/4bA7zdNzpFUo0TR4UgKv4pVRbLzCcDP9y9UxPAd7K8uS3Hd3n?=
 =?us-ascii?Q?k1amrZE+/h6VlClQj/1f8ZfJ597RoQBQiGVlo5UatUWZQQcCyahSS9/BW18i?=
 =?us-ascii?Q?i0v/Oz8Lvsu4hhcRere0czTpzbhE0dRCSZLLZhhG43aH16EGJBpqK0/ipnvU?=
 =?us-ascii?Q?iWrNqPKYSIgrfES9uLXQ4XKUjmkjDo6A4WKzljOd+Zj0PSuO+McM8v4JmRIL?=
 =?us-ascii?Q?POXRhlgWdL+J+F0CkG+hyomsCFMOC8HSLp65aEvRPTfZcePKkBqcXN8MP4EV?=
 =?us-ascii?Q?aNqstCW2SNB8CtipnZVWx6NJNtvf3fpw0BheOwat91vfmc0qjB0joNStGSEx?=
 =?us-ascii?Q?L9QqxPA5rH6UHNP5W38UOc6e8/2acO18q5qMG1TXAEd39F1diN4FQvSTuemR?=
 =?us-ascii?Q?l1iWmcV780vCqpozP/mKJ4H67R5G6vBGTw2qiZXA7PtbWrNG/wKLAQ6xqIJL?=
 =?us-ascii?Q?JO81M9u/tm45frbtOZ69K2eP+OlylUYc79z4QlAdcmmI1Wu7Qm1g7UKDKOjS?=
 =?us-ascii?Q?sbZQEEpkrMryMrD5WqmklztCD3zM/jtYOeMAdtbkObALWrAynC/foyvK0ZSX?=
 =?us-ascii?Q?/MPUPa0VSSrJpVTl/aZGAKX3cBndr2op0yuYzQ7EWW/tOXWITGMWJQh/ZWcj?=
 =?us-ascii?Q?qSxNgLs9m6R/sE5i6t/IThZ8xE/KPRChDX+ACyYbnPby9pcoekCWFMsCDNJd?=
 =?us-ascii?Q?uzFvEsX97me4cKONDOAfmudowNBFqe9TDimmDFj69ibuoUxSV1AZ/iJqp972?=
 =?us-ascii?Q?vmp1PabFxLjlAbM9Dm6YQJcn865Ty/3wECURpbaxeBur6J+Pk2YiG4h9z+Ia?=
 =?us-ascii?Q?t1GgD69sfV/98n0YL8o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cdbc42-dc21-407f-fdea-08db1e93a467
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 22:39:27.0205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kbxftUN0X4PXFKJSyiJdv/mXy4jZBc3veWZLXCr6moK7lRAwXMvs7z0x2/uSRwRuoE3b6bqCjcgTLJjBoBMDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > Mon, Mar 06, 2023 at 04:12:37PM -0500, Asmaa Mnebhi kirjoitti:
> > bgpio_init() uses "sz" argument to populate ngpio, which is not
> > accurate. Instead, read the "ngpios" property from the DT and if it
> > doesn't exist, use the "sz" argument. With this change, drivers no
> > longer need to overwrite the ngpio variable after calling bgpio_init().
>=20
> Thank you!
>=20
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20
> Sorry it took a bit longer for us to settle on this.

Thank you Andy!

