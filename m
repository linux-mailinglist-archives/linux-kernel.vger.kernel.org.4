Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0B36C2217
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjCTT7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCTT7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:59:42 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2048.outbound.protection.outlook.com [40.107.7.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1555421963;
        Mon, 20 Mar 2023 12:59:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmOQRSkbqBzCrBvvhUfisp70H0bTeNkHtteB/+WMCMWmPLdamzo+CgzEaO5GA4QZu04+NAmo99fm/uov+ZUy5fdk7ZwP5N2swrdWJI2Tvj7pJUN/ck9KCdCAEpa/sl2efMQhy4bM3+UbJVP3c/r7TRIxcfCnKgwGGDdNhaVNvOT//XTazRoqBmBUwK28v8DHugTCLrGlSajUjZNeZj/uXbDYVZd8EAouhZZK0u/2Kc/wbVNrHRWY9bAW2/YH81EIKhlwhkDmbXgf65zLzhAuyqlIvKIZ90aAFC9qOlSMEDXuSTEUorutDjHoGaB4oPv0+t9pYCnJg4LwC6DZkfXbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkV7+hENhIHZDMAey/lMxmE/pyK8ljzBbU6JSNA3xS4=;
 b=LAbRvA3R++a0jAXhinPOLsanbm48rEKJuAk2q5OV0oMa0yqs8K6wIw+OuJob1VZ2h/cFPPbHQ+veryHUrqWrwRfazdhrg8v9ItqTGAgYWxpAWAjGihZtSRmtJ4s1hF/IUBhAGVLLCsW+L4TFYX127L7qLRXcdl5cqQEBRkk2ghPYxxr1G0tJsjVhbYSdix1h+THSmWFBpjcu+47ejAzkalXHSiVD9YTZCgqwlpDQIgEBoYgE77hZJa8EnQ/vhcl76ctETP8C9DVAqhtT6atFelgs9hpUJLIoRoBrSKJSV0D2+q8s/pkIPKK8MNMQkKSPzbcAf5LTNhvHbkR9jWIDiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkV7+hENhIHZDMAey/lMxmE/pyK8ljzBbU6JSNA3xS4=;
 b=DPVIeQ1lsLLzwzWBzOaL5S8awoBs++y5X4QStGyHZJp7hCmH+P5R5cyzX+YqofUaTBk87BRQvwr6a6vL5CMTG8wdt4QPJd/1R/uvkOMZcva30BEKq23ybX8rIBeEqYhoBtqHD3WK5PvxQwaYUSyEPssIKnfCps0QOqVKMX2G8ik=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7578.eurprd04.prod.outlook.com (2603:10a6:10:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 19:59:36 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 19:59:36 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Topic: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Index: AQHZWE4ev2xmRcSa20iFYFwtFRu1OK7+r7IAgABftWCAAueGAIABzLvggAALc4CAAAzzgIAABQcAgAACqiCAAA5hAIAAJ81w
Date:   Mon, 20 Mar 2023 19:59:36 +0000
Message-ID: <AM6PR04MB4838FC9492065F4DBCABE60D88809@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230316212712.2426542-1-Frank.Li@nxp.com>
 <20230316212712.2426542-2-Frank.Li@nxp.com>
 <e6935c0c-375e-b763-ea91-3b8bbc906ebc@linaro.org>
 <AM6PR04MB4838D1958A029701E1601BA588BD9@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <1fd1fe42-3da6-1598-a04d-cb99a9b4b145@linaro.org>
 <AM6PR04MB483800D7CDCC7AF48F88BF9688809@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <b8801c83-f2dc-f144-de58-03e5c24436fd@linaro.org>
 <AM6PR04MB4838F5C9EF13A588E799D5C488809@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <fc5c76d1-51cd-5992-9bfa-06f57874fc03@linaro.org>
 <AM6PR04MB4838C6B05F46AD94153DDC8388809@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <614fa099-e666-03da-1b11-29cc804bf847@linaro.org>
In-Reply-To: <614fa099-e666-03da-1b11-29cc804bf847@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|DBBPR04MB7578:EE_
x-ms-office365-filtering-correlation-id: bbd1611a-3a6c-46c5-5117-08db297da1ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RIDhtFujVlTPwtBe2GC0H5uhmG9SMWwom+kwdHH0R/5tmiX9wE7SB915gkJmD22S+/wMLELgRZBCpw+Yd9xxMm7K61ep8mjzh2RG0UKZmuszc3qIgkd/rQBiE+kDYpQxNsEmnszzbrE4Yh9AWdMYIO5+YauKeX3d5HlCiv9oqCSTkAzJRFSrz2W3QQk7cjsHygDkWcWmDhL39cwv5ac6t621ZgeZxLQGw0yQoS+gSKHoO2lwl/tQzp6Lpx2MZAEATYQPF471O3W7RPmWiPnlqPy4ZlyfGjRqDLf52e9sHEh/aabHPXuevzdV4smapWbB4JWz6gnGpSWBuu1pnMgWBKGXhaBhoB7uPEdTtLMBjtZ6O3MQwH3fo4BTO9OJwPdy0Tcb8vJze9+EQeCNzcs4R6lOAxlJSXTxU1rQSNWUoG0WJwKHPmcVE/s5Q7Ypv+H/mmEb2Z/+KlkqE4biXrkt4tZkFJRkcQnlsk14w1oyo0gAzByNiXpxnS0lp0EmcIO4VISAKYScqrlJSSKHYzDOCcFWfxIYla8F2deYRAeks2pkRx0E4Dfzu29DcDv7UifTS7yiG7jqqkfuxO7p9GigthCPPVOLyv7oTdN54+D+KToCYIPgtqUTvGgQW35Z27rBiffqaIMozotqJdtT3mtgLeBpb0QWcX92rLhms7fIYI/nHiCW7iNipO5H7cIY0H6jKSLKDjgz9O5Ir3ssauHmmRFtjSf/GklHqWLY79U+6HA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199018)(86362001)(55016003)(33656002)(71200400001)(83380400001)(64756008)(4326008)(8676002)(316002)(110136005)(66946007)(186003)(54906003)(66446008)(66476007)(478600001)(6506007)(55236004)(9686003)(26005)(76116006)(38100700002)(66556008)(38070700005)(7696005)(8936002)(4744005)(52536014)(5660300002)(7416002)(41300700001)(122000001)(2906002)(44832011)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h567bv1H/vJ5GdAgqk51vnSEWWsPIvdrV22j2LRYZkqihC+Z171n7yh48wRI?=
 =?us-ascii?Q?uNncPqJmOlV+QWBo6J+AjrwvHfssZ8j5idMRWJsJEA2a/DtJISOEwvqQyqII?=
 =?us-ascii?Q?7Zse6cHK11uBBJFxeRAV2gizTBr5cYdrfewXdpS6TNge9pucZm2KBh8v6hqo?=
 =?us-ascii?Q?tMGkXX64qan2AflE6hgg8J+pWy5RRykSdy1fRYQsQ0MHxe+20mUnRRDBYmiK?=
 =?us-ascii?Q?155zuwFoZJVwZpYySr53iW5wpGMILWwhyWiw5nom4XEtA/C/XNmQsjGi5Ekx?=
 =?us-ascii?Q?a3usXXXwyVbTaCobu1IrOctg3W+uAz6kALHcBaLiAXV0MU6A7G1iPWhsN2cs?=
 =?us-ascii?Q?5k8lKJW1cn8Nv33TiRz/VW+AlEXiMTNSkk3gyB05dTholfUSE1Na+OmG9aE7?=
 =?us-ascii?Q?VO+hXMyCgAZwV9uSuFiNeIwUTrAIPjMYf/pDtUt2ZWkhDPRB45b+Z+GDHszC?=
 =?us-ascii?Q?eb9nejzrv8p9mbrfhdJvES92v+e4VqmJoiFFEY7yAFwrSjJysgrjYC5bJvDV?=
 =?us-ascii?Q?uuU0GQIxzt7DWCh5pdwOq5eWVqd6JuJsJwRmYKTBbSNbubjADCU/0flCCphd?=
 =?us-ascii?Q?MCSxuS5DB/UkDa8K61bXI8OkrwfVo7YMEMAH3QLPXlmHVVgLm0r0+jSD574h?=
 =?us-ascii?Q?8jdnsvEgGA9u9JJ+kqTnttPJP5Cm4uJR2y9HFZxUC+qWUY9NmJ8TNr/4HY6/?=
 =?us-ascii?Q?16F1ruUeqvZ5WKsjRHQzB/j/aJDLa+UNB4gUyNt/ywQ4WPzJORDhdEtkPSoo?=
 =?us-ascii?Q?j86+5PS+UOIyB27eExzhPtIbZhPiz+4ZgO2DQpl9lZbtOw34VLtMukSkfweB?=
 =?us-ascii?Q?b89Av/gJkMalMxqjkt96Yc1VN+Zqw1vrpmJjGsZKy5WMbl5HWG5WQ47V5ogW?=
 =?us-ascii?Q?GgrWhXVOt55Oydh7/cIUirisY8ty8bWnggnlaYhpbN2Zb0LkKjpkDhcKu3Ne?=
 =?us-ascii?Q?2+rnNTJiD1HiHsaE23K1VRvijBgc7BYAm96v4/WTNl+2rRiJ3lWr9qafd26+?=
 =?us-ascii?Q?rhz3ke1rtDbqZAw2qzBSIlq9UuU9I7sDNufk6tgC3zXBGDpz+nOO9nP8ezxl?=
 =?us-ascii?Q?in4MMZxB0srwkpGTw2kWZxEHsB9wQd4rD3oLLgFOZUbWoj165le4E9HLoPcx?=
 =?us-ascii?Q?gYHTN//baFikf1HjUbChIIQeDTf0ehaPPv5L85GjXB18P/T4BDeTGhMKAR4p?=
 =?us-ascii?Q?k+FBGNZHJMKzcjgVMSvh+ijwvP7TALXyXt+BquNAWidKF6lnqFCruKDG/QBE?=
 =?us-ascii?Q?gVQswFseM4mhTOkweeTeNZQnW7kPSoS/NpTRrRDQdC/m20yhvWb8cI/wiopg?=
 =?us-ascii?Q?LUYzulPw05dvtw8MxXokZI2XnMUkW/2V+7nquHzMydKezjwTysE034k+6Ttr?=
 =?us-ascii?Q?tTzaPp16sroIX/WdxRSjNfs4mXnp4tyu4OnDxc5JGrfpUcCpM5yPvhr4M7Tw?=
 =?us-ascii?Q?UxBJRX9snpmiXkF+/vRgKwXip/KScpIPx0sGaYY+J8UQsSHGb7mBCxhln26M?=
 =?us-ascii?Q?+nA6CHQ8UjGcETdrs3+xNat4h1pgxklyLvQzUdF3XA5BRHnAesiEDmgyKK1+?=
 =?us-ascii?Q?7MCftRW6+s63d1CGSOk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd1611a-3a6c-46c5-5117-08db297da1ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 19:59:36.2638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: na3wqmwqr6FbmX6mMquqyjPYh1jTwPwniKCXjQazzr5dfMlykDsf58f8lHoeTCCN7ikRj9Akgx1g4ZFZSjzW+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7578
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> The second is a good example - as you can see, there is a choice of
> values, so they are not exactly fixed.
>=20
> >
> > Such frequency information is necessary.  We can put to dts or clock dr=
ivers.
> The clock driver
>=20
> If this is the argument, then the answer is NAK. Sorry, but DTS is not
> for offloading fixed stuff just because you do not want to work on
> drivers. The same for discoverable stuff.
>=20
> > Become bigger, or dts become bigger.  I think the key point is if prope=
rty to
> descript hardware information.
>=20
> You have to understand that with your binding you are not allowing to
> any changes of these frequencies.

Do you means it should be okay if one of  clocks is not fixed?

Previous owner already left nxp.  I double checked our documents and scfw s=
ource code.=20
I miss understood a clock SC_PM_CLK_MST_BUS, which actually mapped to IP's =
aclk, which
ware 100Mhz to 600Mhz.=20

>=20
> Best regards,
> Krzysztof

