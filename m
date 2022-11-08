Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161C162177D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiKHOys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbiKHOyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:54:45 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1E31929B;
        Tue,  8 Nov 2022 06:54:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4SPe4vypvsjLliitFcvLrXC9hSdHSLolWPSk3e+wtGkTQD4vSM70Ey7NiImkSPR4Y0AZGyNLq7k7ic/BQBFxll2JvTJDP08doDbpDWg1W/t4wirRhY7FABmTgL00oW9pll3p8mf/Nvf1ZHw6OxkvaXwuDnfpAWVlhRTg3mlMlkiAclWSuXNnnbhgf0970q4UWg24Eiwf1FlFgOD6OR/VvXZtHvEC/5c7mPzdQuKO2yf9DYyksDBdQq+5j1QdbNITyHoN9CbbJ3+Ae00EbN0FrY36CVs9IU/Gnurcv6jdoBWj7LKkqOnikcvb3esP87TyadLdpA2Ls3bToT3VagWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9nx74s+kM7cCrlegZ2mqqAIB9iFI/e2JKWmGIM/cSo=;
 b=gAW2tGGHuNbBIKwLAY5XiL6berCHOSGtZOVKGwNGUFWuJw9h3DzT8f+cU+A4Izc344dPjSEqcOw+VmJX5+OkGUihdDvC/iDIfGhJ3MDglA7jW2GsIs2XMxdsUqrq/GZcZnB5ntIAdwy7FHBAfEUvd27VResxhLKFvLKFj9urz1X0cwmCPGbRwvc/w9wN8VFHLgRbF2BnPbCrgo4hE842r3amzgQ8iC1lkQfAfRHG2OOiw9GpIxPZrhTjO09MKZFvfyhtiD1Lss4ZzNM/PTAiGOjIheU9B/4KchQi2tGjIr61oiixsFnQEKc4/14SXsshrQZdlkv8W7zIhAsPdtl3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9nx74s+kM7cCrlegZ2mqqAIB9iFI/e2JKWmGIM/cSo=;
 b=iOmXPW8Mug8JshN8UkjEmjq401S3gj0EwMz8RESqIXOJGGo6uCMCUAVyNykBFYEESTyB/MICPFWxrdRAKGnJDhdvwkVt8pAS6pnn+t/fVezquNC6uzCWt/x551+xAxeNVoDFM4Burq+yg/VLHbzc5ZXcgMQSGsC9pFmjlo3pbEs=
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 14:54:41 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::2a4f:4339:4af0:f901]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::2a4f:4339:4af0:f901%7]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 14:54:41 +0000
From:   Andrei Stefanescu <andrei.stefanescu@nxp.com>
To:     Chester Lin <clin@suse.com>, Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
CC:     dl-S32 <S32@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: RE: [PATCH 2/2] pinctrl: add NXP S32 SoC family support
Thread-Topic: [PATCH 2/2] pinctrl: add NXP S32 SoC family support
Thread-Index: AQHY84IHiT+ot7c1S0u7AsvisW4TMw==
Date:   Tue, 8 Nov 2022 14:54:40 +0000
Message-ID: <AM9PR04MB8487C664E75EBA4D3678DD03E33F9@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20221031100843.14579-1-clin@suse.com>
 <20221031100843.14579-3-clin@suse.com>
In-Reply-To: <20221031100843.14579-3-clin@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|DB8PR04MB6828:EE_
x-ms-office365-filtering-correlation-id: 05c43eb5-8399-4ef0-ee94-08dac1992a39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W0enyGkTlUsRNFXWBMARdt3nvlewIZxjr1zQ+RfWN6mfVxCIeRaUt6ZSdLKg13d/foyzlDFQsYdX/RIf1l9bFTAf1rdUQRgtxWXqaViE2R3/vJsG7wkI/XdB+Um7PmXuqh2PveWyH9chURet6WNDGhkLxh7903/iVJtbRMUgmS2sqxRpI4XmBk+1WsmT3DJ4AOgP9mvdCHFTy5YTzfjAkjcywedmQBB4ZPzyhBHjagjEtX4fqnVzkqL/dn0uHU4WCwv/thCrrplg11VqsXZtdInZMpbMhcuf6hxTNSBCLU30R3GwXGrRqdkEzfyLKqjOmey389tS/fleWYEX8nq1Hwi/VaKK64AKxTgQimJk0OavPXnx7uH3bixmRWriEixfsQ8aknUvl9skYE7RnbN2E2UeDmzwreB4tLhRADB8q0nR2QWWnFvhsoV5KCPudHp6Wk/uVIt+t+VeFIvqb2iorEc6cRvERfRssYL4CwNoGQhowJY2lsKU7SFN0OlUi7eHLugkBjidMTgRuATefRwW4d4ABC/qlEpgiOWM52z41XBFlYZGX+A0vvbZQgcQZVWlW2dh2tTlDCu5z9+sJOyqyXX0vgxGgxLtc/snASljqGh4H28gTf8RmyiAne2Mpy218Eyx3Ai85aFxVGvz9vJ1Sr0jZXl+E84z+WlTd7RqktZ0yVPOrm9sNGYAJGxambrqS3Gc8nyhGC6lM51VKhv9s5ddcj5tk+0OoZeB+nSQqX9FGtGgd9LmWwT+mMdt41k/x3MXLsYjhl0Jq9vFAZVFiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8487.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(54906003)(4744005)(55016003)(86362001)(71200400001)(6506007)(2906002)(478600001)(44832011)(4326008)(38070700005)(38100700002)(33656002)(66946007)(122000001)(316002)(26005)(186003)(9686003)(52536014)(110136005)(8676002)(66446008)(64756008)(66556008)(76116006)(41300700001)(66476007)(8936002)(5660300002)(7416002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DpTu7ypQzFHqlePzRs3+SpWdYc64dZikoUc9bgTrUSW6RCSysBI/MRdd2l?=
 =?iso-8859-1?Q?OFBGlxvMW8zhRjDsdo0cI5I8aoP8xNox9/ZJeHSTxHI6rpgzcnVhrgEUdi?=
 =?iso-8859-1?Q?PdYsvqQigOGRIvnTxXWXSWDcac8SkLWkyLXRvA2EtHyJ20VT8XHIQkEiRl?=
 =?iso-8859-1?Q?Iq4AUXHz675OxbbTJ5hMi8gwuXPNk9W+8YmMUHkwuAiMPqC5GEFNMkG2rG?=
 =?iso-8859-1?Q?vgIsyaq3bUJL9jSKIpyFGl9gdvwtDyN2Ih0/2cl/ppartVGCf8r1EfPrOW?=
 =?iso-8859-1?Q?6e/bh/YF66GyuMwj5UrBn5f5hsmLiIq75VL9mmxLHYoSvq5W0mbeztVEFF?=
 =?iso-8859-1?Q?7jviDeC501RfgSFrmd82vKPFPR+q89lzAUqRqIYGc8tuSA0H45HrYXfPyT?=
 =?iso-8859-1?Q?Zg4/99jsI4h+kEFmKLkw0aJz97kBhdVe0rZaPK5/dr/A9DDu9WY8Mq/H3/?=
 =?iso-8859-1?Q?nzY6ByOdLWFYVhSe+x7UwG+FLF5XKE+Zen8bMXfbailtW1ikSVkiG2ezJo?=
 =?iso-8859-1?Q?+9fzJLquRgT1c7t19W4oSMEKypsMofkdffGs44kWs1zAv6rxyAkZH+B8fP?=
 =?iso-8859-1?Q?6e3y3xNfeu6MRvQsIfpbRe1QazWqmAQBDdMMasYZ7abeFgKMPfqSxbxBP4?=
 =?iso-8859-1?Q?ddpgGKjrvGDv5PSlX53G3ov5MhBtL+qRNY4bkvRTpQ14De0VOC0vvH3kjJ?=
 =?iso-8859-1?Q?sLGWjZzUTHREJP2ZB4vF847csO7nzpaBHE6eWzwGtozLV6YCJr8X90dyOk?=
 =?iso-8859-1?Q?ATkLNknh31zy3PrV5teywiZ+gUyLOM7ztk/R4z4rPoQ2ruYPQqsc/IxXmg?=
 =?iso-8859-1?Q?xnIHuPxG1sLkXrFHPoDpkEXL8uzbLV42hj3DuMooFnywuXn1/prTfhl9PK?=
 =?iso-8859-1?Q?uMn8sXC6ldqbiNtogV1Yc0FlOj/3KyJHb2ShW9+U4lNgJWs/MfPj6nJAFl?=
 =?iso-8859-1?Q?9+AkY8g2h4KWn7kn7ifm4wPmrIYiqNNEf7O8mcKxGOY9tnDmwO7PNXDERB?=
 =?iso-8859-1?Q?K7Aj89jvYKVAVWjBubRDHj8C3I0YjsC3NL+PoXHO2HmyEbmJLNLk77Ljsl?=
 =?iso-8859-1?Q?dk0pKSmJ//dyLzY8/sL4X3EPDGC0iS2DiiduTNrhUbOS7pNdLvizw4u1wC?=
 =?iso-8859-1?Q?6ubeiDIpklzGZc7zZSFZpzyik6s4tfWgx8Q7uZQT6iQr7r/njEM/DgE4om?=
 =?iso-8859-1?Q?AGGx+hpx2dy9zahtPJVu7lLL5MjC62HsViqOC/Ej+K+RqOD/fedm7HxAUG?=
 =?iso-8859-1?Q?DIDWV8C8EHBTFDYT9yszUFmoVGG/t+PKUcroPOaX6FroVVOz7ywyb0tpWO?=
 =?iso-8859-1?Q?AQkHdFKLPrWEPuxofxlJlgQ7EVbWy7C9pzb9Qh9DI1EGWhtGMEiAqgOoW8?=
 =?iso-8859-1?Q?FPkPlR+JFMOzD70cucAnEpnixC45/uHYbIrbgiTiZk0cLJkSt86ODePihR?=
 =?iso-8859-1?Q?4mQusjlSzrPg3AAJavHzi6xTpwgaL4MHamriSJxBigb1BKNJt1lVODz+Ul?=
 =?iso-8859-1?Q?eQaY5Mz5gy6n3NfkOeu4OMMQ4NTs8fQi09hRLklggtfi5cdq2djge8D18C?=
 =?iso-8859-1?Q?cwzvbPpKiPmgZOljOsNXI6kB7FHZRNgpvdVGisb+ulsoLT6HaKywXFI5NX?=
 =?iso-8859-1?Q?7othTgZAqn/PK/33Z6jMEZ4brAONWkNYWKHmW16RIfx5xTxg77I2DaNw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c43eb5-8399-4ef0-ee94-08dac1992a39
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 14:54:40.8318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dRtLXkKlthqlN2Q2772HBedBLa7A67ngxlABlI+e1e9lGYNYMekxEkyB1NIE0w/usMCTvNw2TUpjTYSLPU4h+kzb5R9NgxG8aUZMgF79Uhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chester,

Thank you for sending the patches.

> diff --git a/drivers/pinctrl/freescale/pinctrl-s32.h b/drivers/pinctrl/fr=
eescale/pinctrl-s32.h
> new file mode 100644
> index 000000000000..7b48fe3d73c9
> --- /dev/null
> +++ b/drivers/pinctrl/freescale/pinctrl-s32.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * S32 pinmux core definitions
> + *
> + * Copyright (C) 2016-2020,2022 NXP

Could we also add: " * Copyright 2015-2016 Freescale Semiconductor, Inc."?

Best regards,
Andrei

