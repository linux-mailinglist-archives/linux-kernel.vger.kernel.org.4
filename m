Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1246A6612
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCADAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjCADAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:00:18 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46778A6F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:00:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwUJ1GjAQY2Z/W+azsHiXs9QEe9wCMBV6oRz+hrUqUFi73fdqiv4zAzhiO0AnYKuQbJT7014K5SVuQzCS/lZlq+/cZdUM0AQQMfgcQCK31ywJQRi/YKW63HszEBLVSE6pZHyD/q0pVAWASuFh6NXbgURhdmaMVQcqBWP9lvg/Bfm5+sfAP4XdrryRr4QVV/pYRwn/L73XjNBJOOxm/HRRj6JD4G0LtHboBftGWfKB2r13863DU3afq7m84D63Wf2/BrRu9n4UxncJN0XCHy1FqL1Og0EMjWxyIVEZx3V4118uLngQJFKaz+xFZaam3Ft0m0ytOf4UW67PX8Ly8nMVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K+9rYMzeZXFLrfbBuk12CQ4q9hEtpJq0ezmmi9Zz8E=;
 b=M9cWcXKzpk4XJL6yt3f/Bs1we8HinzzHLHMeef7X9+rF09cV/NMQrQk4AyUJBIHhwTPx7cT/3c5LLcUpKuGJqe1W76t97BBhjITNqBzghZJm8JPdj0uKs+HjKGH6YFmfIEtnkGcNBJ74aCGW136w2QfHU1Nu0UdnPkcn2t+jN1h6NAao2ZqJ/JaI5Qsk5/n6gEuf7KYKBkRAIlxxywNxnles7DFQbiJcC1dqdrzLjSrYXRSzpNoY/5iE5Zp3JbQYHzsw/s1WKsBPLAg6oQkCbJcnUEkzz3IVERdLjC2YWPwmwE7CAWJ3r6dNwcaB7r0pswSxSVbXessadq3y5hMQvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K+9rYMzeZXFLrfbBuk12CQ4q9hEtpJq0ezmmi9Zz8E=;
 b=BO9q2Ux9MnCok/awn51jiECgYI0MPQQF3Rtbql4/dk6IQyt4PIoATPWo0aqzYHG6guYFhIkqgVoNZW/VeHN4Bt4xvtpPMIUlu6B0QdlK7X7RsiMoM9F8x8KfxJdnkwvnPf4QevjepC64FaE3F5X550gtgT6zv3fT6ZaUn/AKoLQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7527.eurprd04.prod.outlook.com (2603:10a6:20b:23c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 03:00:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 03:00:12 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "J.D. Yue" <jindong.yue@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v2 4/7] soc: imx: imx8m-blk-ctrl: Use
 dev_pm_domain_attach_by_name
Thread-Topic: [PATCH v2 4/7] soc: imx: imx8m-blk-ctrl: Use
 dev_pm_domain_attach_by_name
Thread-Index: AQHZS+kiGw62cqmZFUC4K1ovC1PuRq7lO/zg
Date:   Wed, 1 Mar 2023 03:00:12 +0000
Message-ID: <DU0PR04MB9417F02F9B3B9B90BC8C9AAC88AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230301030042.2357706-1-jindong.yue@nxp.com>
 <20230301030042.2357706-5-jindong.yue@nxp.com>
In-Reply-To: <20230301030042.2357706-5-jindong.yue@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7527:EE_
x-ms-office365-filtering-correlation-id: 727d914c-7878-4c20-cdc5-08db1a011338
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yUvI0G/9my5zAqYt1L+gTDHHLlG4d7d3qvb6CZP5mT3Tnp5iTLf0fDbLazW7QI9ceQAEeBATFtPCO3gjSSN71hoZnenc5+8+uMmppweYp0A21ryzfzvr8CtBiAjwOeq1LV/wQxERgqjmD85/uFnuhDnh9UxqYic6OU2JEiuQQLP9qwXgQa/yDaL9YxPm6+fAMrWmBqVswyF73X0/3vDkwB1NS/0kMHncf9FW14mO1zjcXEH69MWp8Wycw5XxF2ZxBDG0H7XH17/nyzMytR2hasjgQMAOKUPHZ22LzifBc8WWEvP2o5YN+xMe5k1fCUyI/ZaLnpUVg9xhfmBatkyTwgKEkCET1Rmbgpo5of4FeoMuGjdEpfWHmRhKy01ReD6HKb4ORPy5S476Sc4mV6iyq9pHSqfOiSGfSIObdko4Ro29/KHN6+RFpaTOL9AZTcjG7rd7fN8RoKI67Xw74d42BLdXC7UOgP5vrWHjq73rDLAosEjK2g3EGw1o1usZLhJ0dJqYjuFbYmR6jVLSeyp3yZXV3SMmepBJ8uLgjTfPCK9ngLCVwlmq+ZS0fffViZ+rYc77ZAu/SdgzQ9nqiaAyK1T9wM7kSQ+EewWh6SxtGmF7qPDd1XaaOV263el71jb/dKPf93AnO3HE6N0TCyj09qM1atjldE5rjxHE5cJRi6ITZTDcUYFoGD4N7ogMwdf/FEExK6F9Wsqj/eCaH0O1xsR4RX4cZ9HBDfXlJwrLkvo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199018)(33656002)(83380400001)(110136005)(4744005)(9686003)(7696005)(41300700001)(26005)(186003)(71200400001)(86362001)(5660300002)(55016003)(66946007)(66446008)(76116006)(4326008)(64756008)(8676002)(2906002)(66556008)(52536014)(44832011)(8936002)(66476007)(38100700002)(38070700005)(122000001)(478600001)(6506007)(316002)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JA0cixwDM/R7On+XOWPVGMyUDVN8oiMv2HGtorzwgOw2vicFKfW5pzeJ9rqm?=
 =?us-ascii?Q?lubWmHgHPjAlfFBBTJBnpD19qiciR2OH8aNW7L7AYKn/tMZi2PDfztD+wOzq?=
 =?us-ascii?Q?BkBYzOWAaFq4G5RnNEykFUoJ8ROE+2lLnfx2lLCo0sZYKftmxkhuQkpTUYYo?=
 =?us-ascii?Q?SzKSR2PEJdnonMkhyoWZbkKB/Sgu0aVCjsRoOarfw+8aA6Ktz2szNM/67Vsm?=
 =?us-ascii?Q?nKDV7IJNd6Pk/4uiFEmXfOFpyajtjvf8kY4HePrJclg4eK1SuGRdvPGGKdVO?=
 =?us-ascii?Q?G13LpS7IQ746FTFSEFrTvyEoREmVN5JTzXKjZJhY2PWSgXSm24SpXwPN4Acd?=
 =?us-ascii?Q?pMUqfmDTGdJetTCLSIiUAYCLrpf1wN6fg4xjQOTjWoToWzlcJAUc5MvcpQa/?=
 =?us-ascii?Q?S52HQvPvm7xewKwJlCx1PAvFDaWy2uyicq7p9/HbU3maaJqDllGZa9i2QtXd?=
 =?us-ascii?Q?YQVBmDc3LxOAxyHeDDwN35TV2k/gUag3IPeaK1QG88qF/8BmMVghJBl2h3G+?=
 =?us-ascii?Q?WCzfAn9gcHo/mDgJ8ijzHVjtQSvzKgEMCe1MkguWQ9V2WXoO2QrYLXoSMDM3?=
 =?us-ascii?Q?nkgCftAor8XANzVxobyrksKqHHlNSH2lncp0/TJszwmgSnpkYP5VMzpowWha?=
 =?us-ascii?Q?OCAdcX2o3ueBJoLHMAK+LvfyyaGTADMQ5uV0Ywo0JCnU3/pyqnK41X/eNv+W?=
 =?us-ascii?Q?rz8K62Tg0ECwpQIPylWGAiKAI7jL76E4PznYkMGnlWppMo891DPugjjbqqHV?=
 =?us-ascii?Q?3BrMDqeoBta67ErkCtIBQrtjl2k9TsntkAlgcGgTmMFkiXFEVwfHxrVPRfrg?=
 =?us-ascii?Q?FCjUNC/a3+nZh/0kJJwf3w/Wl2Z+Lzkpc5sRsFhNMLC+uSTokgYKeCPjAyUz?=
 =?us-ascii?Q?UnasAJ9YTxPbSbgY2qpkSD4QBTMPdchUXoj4j9DQBoPQ417H9/DL8E05QT8x?=
 =?us-ascii?Q?rPhCcN2Yjf0eTvJ3RZUlB9LMtSCIxDMXDidDjtNRnxyN4bvD8zpVeIHtOLks?=
 =?us-ascii?Q?bdHrHYzB/b6xl6EA5mxAfwaL/9K28PJriM9e4FYzigoZYXQYxQmae3gYBiLL?=
 =?us-ascii?Q?FHMI2m/RSjA1UbcWTzyoCbDYfMStSguWkCj5r+JtK64nurJ1a1CCgIGKZ1+F?=
 =?us-ascii?Q?2XqIWgDlGIM+6jMQDs/V6c7zv/6Ws9xpYPAm0/0KURjA5JsdcEJ9ZNFFxwjn?=
 =?us-ascii?Q?IDmiIhQjFu4xYj75MXPeMzWxw/22BeXRUoVsUD6lJhjv70NuLxQ+VnRHqPRg?=
 =?us-ascii?Q?59cjuPXKVp67Au/6xAF0mMF0fDhHtYZITPfxILvf5M/U7Lqrf5CUl7RWX7s4?=
 =?us-ascii?Q?5ECKxOSe5B3vTVLaUv706BLTbr63B/B4NAvTyjsaTYWyRw0/+vMZ/7+ObWNM?=
 =?us-ascii?Q?uravytHp5teiZWQanvY6uot9eY2Vww6/jZxyQcKCNhfd3eKskY1e5GO4Us7E?=
 =?us-ascii?Q?RlURVnQwa7ni8feHZED4tFIWK+wjYDts3eVvTXtl+wMcoFTYdJyZNoYawF5H?=
 =?us-ascii?Q?AljI9h67OTB5S6+jHb1/B9J/DTPZne0xS3+ipDVeANzI5HIMSi1S/v6BP5Xi?=
 =?us-ascii?Q?o0mmMuvi6NFhDsYmVDs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727d914c-7878-4c20-cdc5-08db1a011338
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 03:00:12.2523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPH2OZRCK4o6eeli6AIXcGIj787i6YdKehkUF/f/BBpcyJMMqFBkqDEhJIeEpG0EV5jZRNcBGPUgfEj1yui3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7527
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v2 4/7] soc: imx: imx8m-blk-ctrl: Use
> dev_pm_domain_attach_by_name
>=20
> The genpd_dev_pm_attach_by_name() is not exported, it should not be
> used by consumer driver.
> Use dev_pm_domain_attach_by_name() instead.
>=20
> Signed-off-by: Jindong Yue <jindong.yue@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/imx8m-blk-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk=
-
> ctrl.c
> index 399cb85105a1..af67f2c3f7a1 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -210,7 +210,7 @@ static int imx8m_blk_ctrl_probe(struct
> platform_device *pdev)
>  	if (!bc->onecell_data.domains)
>  		return -ENOMEM;
>=20
> -	bc->bus_power_dev =3D genpd_dev_pm_attach_by_name(dev, "bus");
> +	bc->bus_power_dev =3D dev_pm_domain_attach_by_name(dev,
> "bus");
>  	if (IS_ERR(bc->bus_power_dev)) {
>  		if (PTR_ERR(bc->bus_power_dev) =3D=3D -ENODEV)
>  			return dev_err_probe(dev, -EPROBE_DEFER,
> --
> 2.36.0

