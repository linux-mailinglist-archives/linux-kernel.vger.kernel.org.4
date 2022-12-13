Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A4A64C0DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbiLMXrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbiLMXqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:46:43 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE15718B35;
        Tue, 13 Dec 2022 15:46:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CW3HB3jd9QiP9j+C2VsOlozt2LwzUCMRoqFiMIoAmYja+SyRgJypK4YoXq2hC28lDkZ9V/lguajZI9IGP8qfPTAPROO/VEeCnRB3i0wlGXDHBlLgrk0sVT3uDklyl94KrF54qy3boJPwQrJQockanvGf2X2I/VKHiw5cEqet4kDV1hBEBbftsA5ObEG/UjZhOp0fnfmx3hfiZeB7l7Ov4zKTiDsJ6/oOf7VEu9GxHtoEE/Paflx9LUUXQB/PRdzPp3qIyr+js/GT5RzLAz3AiqD2gTbizqjMncUR8gXsDvPSNoOgXSMh6GneKLHlx5HyaY+C+J5owqHHgQDr16HFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4Kz90u9ABTU0UHoewoWC5ecuEFEPYuuwrj84Vtbnxk=;
 b=Lm+T9IvWt+s5ccYoApFqWVD3keLH30PWpVpvNGS73N6uBy2jAljoImvW4fek5thef7hbidaEXN5GeMfARDbw5A63BlNXGuxkRzLcpphQ0xdxMjesLEyOwbsGtEiEUxEabhX9fDoeAay5+W1+eMWDM4h82Ibd8eLtNlYxkhXJuCUOyBw8LG5tLBSe4NNT1+MrHf1ejJcyZk0RPZVJ7ju9Ov/bCww3q4W6QmskujCMHMk4GgFdIvDX2BTsVQrUU3QZE5L42sqdgMr0STqcqX81icIEsKVxvhtm4sYilQK+eeNmQLRI9T9EX0gYPBy93DGizuTZPGjSOglHiXX/eQGGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4Kz90u9ABTU0UHoewoWC5ecuEFEPYuuwrj84Vtbnxk=;
 b=DHctuGucjrr38y9cIfm7Uqp1choVGKhWavw8G8yf+DuIgiVU6w3tu0y4MPv3WiK25D+w6/VQfFOj9XIE2B8+RYpOKQnUMUMJeZ4DWIlMou85mnBCDEwxSGqTwoAAfloIJFFArwjCFcygzSArWR92b2LBsBeS9vz0tXzhCwdi0dE=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DB8PR04MB7099.eurprd04.prod.outlook.com (2603:10a6:10:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Tue, 13 Dec
 2022 23:46:39 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663%12]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 23:46:38 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "linhaoguo86@gmail.com" <linhaoguo86@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        Chanh Nguyen <chanh@os.amperecomputing.com>
Subject: RE: [EXT] Re: [PATCH v2 1/1] usb: gadget: Assign an unique name for
 each configfs driver
Thread-Topic: [EXT] Re: [PATCH v2 1/1] usb: gadget: Assign an unique name for
 each configfs driver
Thread-Index: AQHZDz7Xq5KKpC+MIEabnI9j9xs4gK5sY74AgAAWKxA=
Date:   Tue, 13 Dec 2022 23:46:38 +0000
Message-ID: <HE1PR0401MB23311A1B78E2D210079FE4A088E39@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221213220354.628013-1-Frank.Li@nxp.com>
 <67878b69-89af-6a0c-24c6-ff111dae6ce6@wanadoo.fr>
In-Reply-To: <67878b69-89af-6a0c-24c6-ff111dae6ce6@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|DB8PR04MB7099:EE_
x-ms-office365-filtering-correlation-id: 5c1e4f2b-bb1f-4845-ea5f-08dadd64474d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8kYoLXqyNtomtBtXfnaszFZ9DesukYl+XL0CLJANlaLzSKc4r8cDK0RX4dpdgI5pZlrn/WHbrCXI/w0CK8BpxuCAdCIryPk3iSlFq7bNtFiDjAnaeJ5KmYaJvI9myQGuyxuTdBF5ecqdzWCZpPEr3NIm6tR5Ti6G5BEKstFYvMr7jJEAjRdywtMf76CCxdgPiMy+t5bSWQSCR1jVixjfA7dxIM3Z1EF296i2VbCefoHgoZ7LDvWGxzm8vvwyahr4CRjGpCvthefYrT03/k9ZHfrCj3DcD2GZ5QrEZOsAj1FsTlSh4b/gRD+cLPVbGXJhwZkbYS+J8BbY1SDkUcCwI0l2I1892xiwKPTrjmiVMDf5ZOppW8yVck4W0WnpXdPpm0Eai1e3QAs1hf0ChJ7h154L7XZ+n0T5hj/TRiyA4lH6d9WGujeCmV1zd58q09dgX4WIjEdCOWD6DXysKGTyufYpbrYSk1T+CiAa0PhJMd2C+jSXnICKCILm3gsq7shCR2bCIyZl96JNHLrDwsLBe118/CwxdsQFutGtVAqaOdTrHg6o3KeBdcpJQT0AMIHDXdwu8sZ9Kd2f9LFTfxo7stXHI5c3BWayaxtLM5t7TNGJktshrrTF5QpXb0KUXwvipuQnPUGRzpRLiezEdy8w9AxST7CarBAQdH6w25NAuZcAloJgheXZmmelaRbOgxw91Of8ROFaTROWctgJ4J04G9zxElPIxvXJReW/spi79gU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199015)(122000001)(52536014)(8936002)(2906002)(38070700005)(5660300002)(4744005)(83380400001)(478600001)(44832011)(966005)(41300700001)(6916009)(316002)(7696005)(54906003)(86362001)(8676002)(66446008)(64756008)(76116006)(55016003)(33656002)(26005)(55236004)(4326008)(38100700002)(66946007)(66556008)(66476007)(71200400001)(9686003)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fkrWtID+nTL/QGhy4jOpxQltDU4BMCEelGnrGHhzR8MKxUXbULtNqWrBH1HF?=
 =?us-ascii?Q?fhRM941PEHCA0Gkj/Znl8s3Od7V7DpY+JtytzU3viraxdOWgOek7w6YCrFgx?=
 =?us-ascii?Q?J7Qp+142f+thJA79nuVQSziXiBC34hHxUlPpeeGfNmtCYY9oMHJOCRDh0FG8?=
 =?us-ascii?Q?83FFK1XQdQ4g1aZjrqNIz0CZzwS4kYVffnFNeKqw6az01v1Qne8xeaha+hPG?=
 =?us-ascii?Q?XVvWvf1dmun2quOQeuLaKwxEGcjfd6DKZU6DnoURG1X01PZCc1J67aINjO/C?=
 =?us-ascii?Q?ixf55qyf0lBPLsWXUwb0lIQfvfucNor2ZsmvA1+bGnvzd9AiuTgrNfL+bjc/?=
 =?us-ascii?Q?IQfcff1h/xspki/e103/lvD/lqKZbPIR9OUF15XC8llUq2Fw0Xtg62IjrCH1?=
 =?us-ascii?Q?WQN2V5zimSPp1t3QQrxp3IdCuM9yeml6FotGEEoAUBS3ZdNydo0ClxYw+6j9?=
 =?us-ascii?Q?ajus2Rtij770lPwulgt4WeUwvHGwwHrHCc1FiTjdKSXR/eSinbQtvvya7wMS?=
 =?us-ascii?Q?EtspzBHTu679YiwnHVs04fmDt3bU1vg3WbvxlaEbR8fI52XDVlcOLma7aCHd?=
 =?us-ascii?Q?E9727e5wcspxrEUR3YVgWoh0TbVz4zHtKVVzs7OeIfP7g7a2K98C1saqH5DL?=
 =?us-ascii?Q?xc97o2naLSbsqN/sEVjSGTzRmUDkFfMCkR6h1XnXKJFkNjSpBad6ESy3qfTM?=
 =?us-ascii?Q?CJQ3V6l3vmr705SXQUODVxTWH4j0tR6lw1n+fMpO0d5rEiGhIISzNhxFB9/c?=
 =?us-ascii?Q?763r4XPKBSEBUilEBntk9ybqKaa3ZloFqbOqv0B8yfQZxunoru2fsbDIQst3?=
 =?us-ascii?Q?4LyUr/7ZJzAIH6hRL/eKVFiX1lbZ30bYd2xMmZOHMY0DeEx1n5IDVxY6AiZK?=
 =?us-ascii?Q?ZUU6dGxq9/nIwsM6wlKAK5psD23Zhi9MEVVVomBCf6ZuQp5tjdcBQSDAGrZq?=
 =?us-ascii?Q?Vk1O3ZSU3tLu8yhJElidC3qoJhkJ9EUX8pyr5fMtoR7Kgo/QXpxewzVc4HUK?=
 =?us-ascii?Q?4NT+JZJVbr8xHcpBlW7PCCQLnaRrIQCwlRkLkGrYIcOU4lmLWBaMJkY4maiR?=
 =?us-ascii?Q?+WMRzSzT1xpqaBZYZrNhqkV/KKDRUfSp+DuOxXQVLnrJqSg7hyPmvgKEW0nP?=
 =?us-ascii?Q?kLD9ws6jS39ZznOUvdHgQ0p0C+aff7I5bGd/dxzT+nzImlIpsxASw1n7cOqR?=
 =?us-ascii?Q?dtai8WlCl+Iv1BoRMDJXwL59UQjpwvLjQiRviO6gmo5MWp/cHN82sRCYSlYq?=
 =?us-ascii?Q?bI8ir0CKDzs+IzAbtHIxbmeKzDWtq+d5OtsZOXRpkVczZ22Wdr/tZRc/Y/v9?=
 =?us-ascii?Q?SYjFfOpEmgs2sxVFLzOpeOnExNRyyJRfRsjbEVk9zbMzdU9gZUnBGj94oGPP?=
 =?us-ascii?Q?qZY4gMYA/pO6a1Qmxay43NDgBDw8yDjn9kOM57kG2gW/AUzYLS3BExJmvYA1?=
 =?us-ascii?Q?yg/ZJWD1whu1lDSNj/IWin/61ZAOrpI3EOan4lrwKo9mF4ptl9uu7H3UBMl+?=
 =?us-ascii?Q?tw8fbUDuAXhpqGM/jGGU3j9jNZs0UPBZOQ0hPj+xeHfHk7c54Bj5YjjDmQaf?=
 =?us-ascii?Q?xnhatm/14RJJy5CxEuo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1e4f2b-bb1f-4845-ea5f-08dadd64474d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 23:46:38.8478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Czq0m6fbdrGsOrz/RPJhHZAxT1Ucr82tCh/e2AFX3mqouwbX6Y9u6s4nIYdxCxx57TofriQ5LuixMSMMPSC4xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7099
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
> Hi,
>=20
> Also, out of curiosity, any link with this patch:
> =09
> https://lore.kernel.org/all/20221213041203.21080-1-chanh@os.amperecomputi=
ng.com/
>=20
> Not exactly the same, but not very different.
>=20
> (adding Chanh Nguyen in cc)

Yes, it is almost the same.=20

I think it is not good place to free driver.name at gadget_drop function(),=
 it should be close to kfree(gi).

>=20
> CJ
>=20
