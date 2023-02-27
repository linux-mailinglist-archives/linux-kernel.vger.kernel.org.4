Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BA36A3E07
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjB0JOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjB0JOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:14:09 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68912057B;
        Mon, 27 Feb 2023 01:07:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjfQxa5uKYWLZgInbZAqmkjd8IIXFlFrUGo5bHcS3/KIYYD+uX7H27uYYQ/reYamoWhk71wmqAVqliDu72A2kYIbvugvwGHSjPYup4PlmQ/LXlYeF/680zx7wTHZPqmpybmvOM/t6ET0ZssOYNAi7GRQiWc/OC9630PisMux2slKNxWh6/kQUiJQfGpzudyHR9dWs4zQ7DeUXuynSiagksofKo7+LuM5dXaOVsaopHHpxES+FuGQFN2zSNA0tD/kzhCzG8koigEu+RnnbgIJV4omZhYMSXsKTudNL3racxip5YsfrsjhC+4iFtOX/C/OGUajWoEOCcPbrUhJkGEPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tV6RLAEgFHRhRHUALgyApiE7JXCOgz8PigEcRrUCGK0=;
 b=kaoNk8O93IVOg0LqigvEkza78ZQ9GrPFq+BQfmywOB2CGDBL99DASg2f+6ZW0/iqlFZ4SueDOv3vPYZuxDuGzSQtWROQiC2S+Z/fhj+BZKyxmKX+hidVniIRDi7Em5VKxdHCRO834Qg3r09ChC8Cn+9PDodlJmeiw7qTwtb3u5e+7ifMZ1H9Ok2wtNfImGOTEx/vZ1F3PMoI2t0mGzLK6GhMkR3hDjTEtBD8bZgrZDU1qVfFmE/cKQ3JTo89q9OX/MOtw0Ap6rMzrmEjVfni+tGqLKbZZU+QKcfYGj050uUjCKyfbpsop07OSM43cXW+e6nFFOi0iTOrYPhUaNXv6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV6RLAEgFHRhRHUALgyApiE7JXCOgz8PigEcRrUCGK0=;
 b=dDqqxFzwxn7HejGthx3vtbvcDP/U8AkIkwyK1KG9q9noUL2Kh2jrvxUlFnbLLwRFp/eVbuJnC6RxCc/xd3sdvLgtPE9dVNYdd0h3Xt/6IkhZ+KyedGjIMgvq210adZDPiMzypOy6pX7hqRuxfCZ3xslU32/WYg+yyF3XemDU+0Q=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (2603:10a6:803:46::19)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 09:07:07 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8562:affc:e0c:c610]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8562:affc:e0c:c610%7]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 09:07:06 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: Re: Re: [PATCH 4/4] ASoC: wm8524: Delay some time to follow power
 up sequency
Thread-Topic: Re: Re: [PATCH 4/4] ASoC: wm8524: Delay some time to follow
 power up sequency
Thread-Index: AQHZSordjuLGiYckhUerI4bp5asa7Q==
Date:   Mon, 27 Feb 2023 09:07:06 +0000
Message-ID: <VI1PR04MB42226A647AA5A6C2DE8D51D8E3AF9@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <20230222113945.3390672-1-chancel.liu@nxp.com>
 <20230222113945.3390672-4-chancel.liu@nxp.com>
 <Y/YPNMGMZcVZs3xy@sirena.org.uk>
 <VI1PR04MB42220617033D1DE404AF445DE3A89@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <Y/it8z/w2c+gS/85@sirena.org.uk>
In-Reply-To: <Y/it8z/w2c+gS/85@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB4222:EE_|PA4PR04MB8013:EE_
x-ms-office365-filtering-correlation-id: 8734c0b1-72c2-4ed9-652a-08db18a2001a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4EwvAEvP+I/6H1kP5RYDWScBn8n9NdqU9ADPhrA/LDEqAeUm1g8zrafeWcAOVu04epxwkJoM5bxVbieeKjMmQRNf0j3UPHHOHKwR2hM5nyirDgAtVq91/zKO9bv5es6kTHuIYGeMeDWXM0e1RNZzvxW7mWRcRROeZ0RJSOYUKKj/FAKuOC+6enM+rEqPtFYWCHLMqSPt1o5mzyVEP+VnmgodCLfTOHtTXsDL/ru5O3xbk0+AaygXawRsAfJfOmyHVi12P5T/KVHD7ySfBb+nq62/eY/q3KMMP5v0fQdqqqaPS/7yC5PosKqh7rzvfwqtDquHXordbL+HTxMtGAk7kTRMSdARr1/TyGmcSrC2ThFcwoqdyC/ZUhIdMFyaSpOlTnFOQH/zwyTIrpbZWwBolTWh5TPSdcoFb7ZeiuEXL+KkbXg7x/rLU5eLMbFF0tb9SPHAwVNPv0aBNYocXdKJQs516JydLbZFDNsZFAZJ3V0oB8LQ1yNYISsx0S30YPA0xV2E8LwQq8OZrbJO5rDp0zmGvYEZJru4LR8IR7pv4EI6ckGzupqm2Z2AM8BFUP8bUI1Wfc0L5J/r7e4I5BAi4WHqCUgVZFhx9+m2fXLoUG+fCCor3M9+Qfu7nZ+BjYtV3vmiQBZVS8sX6kWlCrvYLsSgblOSyZs3IqKMR5OmtBhCrjJjnFv1Jm4PpNNyRYVum++68iPod2GsVAK9WCFDnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199018)(33656002)(44832011)(5660300002)(7416002)(8936002)(86362001)(55016003)(52536014)(478600001)(7696005)(9686003)(26005)(186003)(6506007)(66946007)(76116006)(71200400001)(66476007)(38100700002)(54906003)(41300700001)(38070700005)(64756008)(6916009)(4326008)(66446008)(66556008)(8676002)(122000001)(316002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qLzuDJbYzHFVZ1AFnGGbYfS9JLffAd7erEFVwi8/pmBUNUzGv7lebJi+eCGp?=
 =?us-ascii?Q?vnnnbBE9ofSKb8VMWKCYmu1PT+VVN3q9c0iZ0JQCl7A9yRKD1TZrqErY2I57?=
 =?us-ascii?Q?tz/6VWnEjrflwdawaUhOAbkrSZ3WuYRMsKvhnpcWt27RbKZwpy9ej4y3dzgv?=
 =?us-ascii?Q?bYK1Zdf1c78JFn438uSJklGI7ISkMF1PaytCc4LokAmQEd9mvrGIuZ4CvK5t?=
 =?us-ascii?Q?Lm2kV8aLYfz97q3ooOh3md2pIbJhe54XOUQJ9ThFGLWGVm1lxWJQbjvCxzzZ?=
 =?us-ascii?Q?tAFoxDO2F0sXMquwVgRK1vhqQeRU63Mzw7c4NN8A6TgGB8Ftu7nhat1uMElJ?=
 =?us-ascii?Q?j9OVEM2smf5pCG8eNaupOk0bTpu+wL4Ba97m/n5/8Iqlz0nlKhwjSBHWAa5B?=
 =?us-ascii?Q?3R6ubbAJR8U2aOh4z8mZEL8mgw7VisLXXDjpsoqBHv+Xa5JRmBwDnn7ukcHe?=
 =?us-ascii?Q?zFcjA/ihNp+lyjIhcMKs7rtiCjs0myndiUXkLLV0v2vPnFfdN+bGzG68aFLT?=
 =?us-ascii?Q?hsFlkCBqM7JEdjOCLJ9ODsZ9rcQuYwdpMAE8c1tk3gQww4pmzxmlasHBC454?=
 =?us-ascii?Q?hcWtdopSvSrpWyx+SQ7bDC5dnKdG0C5HsXSxhQwlZbGhMw1RjGqtd0VoBTs9?=
 =?us-ascii?Q?iOVeeMwbY6D/itGPJE36RBSgd3YJkzL8ferXGAfjF7NcIvO7ZQ8qlehxIlcj?=
 =?us-ascii?Q?kyjqPokp9r80VHMRctcWTrsR3YwfWTAtQuy3gJfj/9j6CaLR4pJR2m6uUwyQ?=
 =?us-ascii?Q?kG5hvKdMcx/P8HdRmAI5GGM+QjQ1LHfF985Wiwsm6uJz/flB5Lb6Tq9BHpDW?=
 =?us-ascii?Q?+c+eOwL3npY/iQ6qUpyIrYAnO4XEMQm2Pmypv2rLhCw6yrsYD+qSMBEqYzIJ?=
 =?us-ascii?Q?R9q8sCwmlN5VUTPGuDj5vxLZKkgVzdS1prSDRN0pyHBf+SCMCTBbYXPPpnNK?=
 =?us-ascii?Q?7a7QZzdq0Z+TOpmJFl3IaNgyvqMzjB9KcV/aIm4i2RkWI5TajetzFh3VijBD?=
 =?us-ascii?Q?YOKmN1CbSkYuD+xrZx0/FAZkFVPHHGs8b1KwwqPcVLqEHXtzLesZjDB9U9r9?=
 =?us-ascii?Q?mh0RiIs7KefVmFejT2EQA4SpRodkUQEWyFv6gk044+I/tNOuMFEDp7MaXA+z?=
 =?us-ascii?Q?Z9Q6RXf0/9roTiJu/U3ayLGPKYy9VXty6aQaB71L0M8cmQqh4z37rTL5hmKw?=
 =?us-ascii?Q?vjJiY0ayo+KCuqDUAJ6AXXfKDJdR7tbK1xovA1u+DR4foRFE2IUFjFC5Aprs?=
 =?us-ascii?Q?EdIfxzi76B9tZWG90UpPuI4lWRk4eFlYA25oqYmWyDpoEDJSwFBa0tp9sLcl?=
 =?us-ascii?Q?pAVaiaS/h/kBdePk7OUoPgAIv16FuYke2NgQGibdU13q8O+0DqJqlij13KKg?=
 =?us-ascii?Q?URCtmOmRdyyaOoj88uAE/j1Bs46DNruyzp2W5VrUZsCcqcRaXZ49Dbzkq1YZ?=
 =?us-ascii?Q?8+oyOYAvHtIDdiDdv+cHYTS3FNze5Wq3lFIkh3q7xgybSGAslIwdZg9RaaTI?=
 =?us-ascii?Q?r6TqIRyX0iPynxwq3XZx/sBzR9rFhBv44P86p1+E8QLj5ZcN+PjHiuD+jpmS?=
 =?us-ascii?Q?5GYYQYQlrNpuxilEVkTrV/TbjmF3ztbGaF/0VIfl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8734c0b1-72c2-4ed9-652a-08db18a2001a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 09:07:06.8086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G30FvFZERkJ33qJw2udSzRubRr6lMvfzOtz/Kjx0yzFWl5lOoUci2uj8ma72SEoe9+u7XNl6aUjqLVZ4zXNecQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > On Wed, Feb 22, 2023 at 07:39:45PM +0800, Chancel Liu wrote:
> > > Doing a 100ms busy wait in atomic context does not seem like a great
> > > idea, never mind a 1.5s one.  This shouldn't be done in trigger, it
> > > needs to be done later - digital_mute() might be a better time to hoo=
k
> > > in, though longer delays like this are really quite bad.
>
> > Yes, such long time delay in driver is very bad. But this device requir=
es
> > waiting some time before able to output audio. We have to wait otherwis=
e
> > the beginning data may be lost.
>
> It's not just that it's doing this in the driver, it's doing it in the
> trigger() function which runs in atomic context.  That's unreasonable.
>
> > The power up to audio out timing occurs after MCLK, BCLK and MUTE=3D1 a=
re
> > ready. I added the delay in trigger() because some CPU DAI drivers enab=
le BCLK in
> > trigger(). You suggested moving the delay to digital_mute(). It seems
> > digital_mute() is called before cpu_dai->trigger. Please correct me if =
I'm
> > wrong.
>=20
> Hrm, right - in any case, it needs to be somewhere that isn't atomic
> context.

OK. I will keep PATCH 1 and PATCH 3.=20

For PATCH 2 and PATCH 4, I have to find a better way in which long time del=
ay
can be avoided in atomic context.

Thank you very much for your comments.

Regards,=20
Chancel Liu
