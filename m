Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68EC6C4D6F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjCVOWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCVOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:22:11 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2771552928;
        Wed, 22 Mar 2023 07:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RseKRsgHX2u/FvNpzJ/KmB6UDs9AsnJB5oE4i8xpVFJcAaO8p6Dgd0GHCdem73dfxiyJXsoC2mpZFwCsaTBBQM3qF79Ul/CojFtiSmNGTASt4LWmkH6AVpzNprvzN3hbQN0uQxjeb4fKBmGHnKVj1dcYG+6MYyY5WP2Mo8imEqldWKnpLysVBEYAhI0jdhrpecoxLfH5coJ97g5Gw4QZUzJTgXahQmmGRTj2Z70S7bP8q7a8jDO2XVeE4oThj5mc/Hk7ZoYrrId+eFy0NK7SzJgX9JlZ3LHKXv4Vkg2ksY0AUNg78ON3eYDwaOQAePSDaW+Zm+jlKauI5SWtdjeDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yj1gTM+1DFZkAS/+neHFbmm/GyyryM65bOxIjJ2oUxw=;
 b=K1tI9inpG+GclYtAYWa07rYRDVBYYxux7rYDSPfzzAVEJwnek28supLqp7SbMS9Mnamv32lViMmkA5hdgJ1JjOW8gbUb9flFEnYCh2wjlBGBP0uV8li4PTGT9lwWGrVvmlp746Wqcy67XV2r/npjAzdn826169MaPq5ReZfpEGAT/c2BVY5f+qnQLahqMBCaAGPiwsTIM6S0lQRQtZ/64Ad19ycSjA1U7VyYNhYyPT3C3jelYpO+AzEktP1agfx17Eor5h6EglJqHcWR2nr37uxo2ySR8FtqhaE+w9Gikk5UtMCEl+AC2EnNp74LQp9VRaQxcCt4XHpR8FEh2EGYBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yj1gTM+1DFZkAS/+neHFbmm/GyyryM65bOxIjJ2oUxw=;
 b=VDnm8bC7dkz66rwO9ICY0vAuUh/p9i8/iBTNhteWvBE+YzVODZcxAk7K2xn6Xs1Sb+P9mp0X7qK15RonzZGMkQ7DIHOitD4nGQW2qbpudD+uEyLBCMz2fKCGZmAOY/WzNaK6OXKePqn17TOCTrHFT9ybnxDb83m092oE3Ewt4SU=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 14:21:31 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 14:21:31 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:CADENCE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] RE: [PATCH 1/1] usb: cdns3: fix super speed mass storage
 gadget device failure at imx8qm
Thread-Topic: [EXT] RE: [PATCH 1/1] usb: cdns3: fix super speed mass storage
 gadget device failure at imx8qm
Thread-Index: AQHZXDjldDJOVpnVokGJ6I0Y4MvgKK8GZxoAgAA6OYCAADddsA==
Date:   Wed, 22 Mar 2023 14:21:31 +0000
Message-ID: <AM6PR04MB48381649089FA348D8AB967588869@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230321210521.2806486-1-Frank.Li@nxp.com>
 <BYAPR07MB538127FB75FE24832DC1BBD6DD869@BYAPR07MB5381.namprd07.prod.outlook.com>
 <BYAPR07MB53812A0F803FB8185D63F077DD869@BYAPR07MB5381.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB53812A0F803FB8185D63F077DD869@BYAPR07MB5381.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|DU2PR04MB9180:EE_
x-ms-office365-filtering-correlation-id: 6cf494f7-bb1c-4f6a-6349-08db2ae0bbd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tWQT3395i8OgNdmbhJ+sTuX1eiiHoRaubGzKKmuJw4MjR2m5OfHfT/XMgItESPiE0IaZX8O6rKK5c3lz4ZXgfBx23OP1NdKwQXwjN2al+i7XjTFqigpGd9z8X58lW2tzpjOF8JH0IS7W7McZy7EQMs5rkz7JsRkRfGzSqLWmRZ5vbxNAPbn9uhhkPNrbFC2LhTt40EdEcd2P9EmuvRWoyoycZ9MP2o2xO7X2iRWQjw2lPQ7c1AiIVYAzsJemSHvea9FcYEed7IQfbLHCFzQLM9oYiEDzzYRsKHpkLkGeL9zUvGSkByNz8zhh7sg8L1K/kF0NauqKDMXqQqty5UjmqeGsArTAzIHrAxJf23VD00lnxVrvDf4Tqd7bArdRg8pcxBttNwmygNxnC+qw6wWIYiLtCoArjRffOihkG9hd/e+z8bs1tm+c+/lCjKt2+PPXFrc5E4c4oHgUKhHGS+8BF1Z1aSJ13kab2xPepF3s5iGeiXA1uLfePGx5CCg3vP8ldRccuNchTZ3wAvmOtmNWYjkduq0f23Hxw/bZ//265LVV2nRUOCmY8jyaQ/YAANXMnHiHGcHvUBL/tCIfoDrbDUk9ZETPtTD8vwAjwAnBmQpL4pqyCX1xes5SLSExM9Ai5at3dxV0zcGC9eoqZvVrQa+K8+ph1gzP+D/hfhk/oo87RbtaCcGCS4Ct7PuiBqbzpxtxReOtwjASsm1FPG66zkFBPcD8GBzUQbzYeFUwrV4glUy/p8eSMMXUlgEnkfCgr4VUTSBtBTl0qDaTixAEmbvZty830j+9BFa2zzmT9+o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199018)(86362001)(55016003)(33656002)(316002)(4326008)(8676002)(66946007)(66446008)(83380400001)(186003)(110136005)(53546011)(66476007)(478600001)(55236004)(64756008)(26005)(9686003)(6506007)(76116006)(38070700005)(66556008)(38100700002)(71200400001)(7696005)(5660300002)(52536014)(44832011)(8936002)(41300700001)(122000001)(2906002)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D0aExSY0GWj5eEMXj3RMlYly0sSDVsmB3146V1WSkCl+QthPWOFGiezYv1QJ?=
 =?us-ascii?Q?k+MGtm3qy8Omsi8I9sL3FMjJgllylZ8HUaz/zwLy4BhG4ycURbVbeBIUwsy6?=
 =?us-ascii?Q?Eg6X8b2JL5zZOi9oecQbZU/hAyiHV05xgTenf6f9iuRb4voqrvxqCosvUviq?=
 =?us-ascii?Q?0zct9UmGwvv5mHjQLnX9zYvzXVpsBrF8i0JyO8hWzDzD8T/MzbZGy1yOUKDP?=
 =?us-ascii?Q?fbfilqGFsZPdhqRhfrA/4jG1YJoXpAcq57xHsw1hQdf6eGxjwi5iGf4Z4J7g?=
 =?us-ascii?Q?OR1tDCEJ+lD0c/CtzsI600W+ATwOx319Pvl3GiQwMDNsFoWAi4PsYxlyegq6?=
 =?us-ascii?Q?SPrXnhDULIjVXJSQLAfGL757BPxTHtOkiC5W5eJvbM0oVPefxqOq/wiqlz+4?=
 =?us-ascii?Q?mKOmhXm7yQlxE8SuDuO8u+6q+/r5fE5j45Ly5Ih8R8CHP4rhF/KpTbOrlZFP?=
 =?us-ascii?Q?Lz8X/65mWIJfuybTpjX+d5FIXxWah9zjxGUdzs3UvHiNnn1lMaHz86jOoZbN?=
 =?us-ascii?Q?TBr+KWnFgbh+6Zw7vveSQJCgVs9eEhIsMbXoOUM+XYCHPKBjZUNS0cZJtFEX?=
 =?us-ascii?Q?g76k3fTcC28HUjIHqCzn8tZM0trHx3XwNiHlvrlwbxbj+cKnrER+a/sw18YJ?=
 =?us-ascii?Q?AyKgMgSVj3E6Zw6IjNXsvjcwBQARgKXJcnAfclhmG0lO+EfDBMWfY2Q4zBhB?=
 =?us-ascii?Q?TDk6DNmqk2Yw4jgc5wK6ZWyt5JjIUq4Wu2Z9NWxwr0vMwY2hlsOJ9Jl1gPMO?=
 =?us-ascii?Q?ZCzkr36aNTrX5KEjSp5XR4J7RM6QtrZkf+LnHv08mRxsxFtSq4iCEcWy5QkI?=
 =?us-ascii?Q?fgNx0RRzpP5K1NJuKEj2yLFejP6JFZMhNBXS8wZfpKPdfPNHV0FCcrJMbn+B?=
 =?us-ascii?Q?uZ6mlXoRdZclghM1rpZj2aahT9t/6Yr/A+duFrNxNDcayfMbqYnJLAzYD7OW?=
 =?us-ascii?Q?ySqJuPwcTvI8ZrWkDQxPXbCBfKBoqFpW+xtshbm8FG3sbvSRvagwiqiGQoz5?=
 =?us-ascii?Q?cuXXyV/5sRjTHX0E7kf15J3fY6zN7C6RJjFN23BSkFY+KgakUjw5C8IFP4Bt?=
 =?us-ascii?Q?NATkL1DvVfR4jWqUspan+gCAtwLqEGPtkJ1xfw9BEUxurHkDJf8X6oZcEC/p?=
 =?us-ascii?Q?H8ScP7YWM7n0w+qhVzrovB08TCKIOOrjIcX7vmufH301Tu5MnilXE3jLu/vI?=
 =?us-ascii?Q?dYgl1MW2GTPH8aKGwm+Fb+RozRdV+CWUygb6IAU41OJAPLqSBJzKts0q/DEs?=
 =?us-ascii?Q?3lXmNjWKrMn1/5SKwiu6dWBeZ0N2aoHkKMXZI5hA9InILpb/gqL+/e5oKPjV?=
 =?us-ascii?Q?mGKrXyZymkfnfc0FibfWV9OmqIPfjz21woi6LYhLuvMWuZDVACLzcjZp6AGT?=
 =?us-ascii?Q?G99bfg/RrcrEBRTxJGWhBSbv+fM+R6ReDzWRnT6O03qxzT0l89j8agKZU4Ga?=
 =?us-ascii?Q?iDlIT6Nqonut9Sz9oxTnPReT3Pcod6LCZNrB5a8Z8R0/z2uLHVBAFWFm/vMj?=
 =?us-ascii?Q?cCVTZcjrsfRw1CgHRayFvVRZIDVCvUIZ4dGaxkvor7wfY4NZpN1MntQuQZLR?=
 =?us-ascii?Q?d1IjQv8xEaS/n4XLEAO1RoA9lQ58RzMi1cz6L7wh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf494f7-bb1c-4f6a-6349-08db2ae0bbd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 14:21:31.5044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xrJVmEA5WAdRlAq7a48jHmQuD189gItLEyfrIwOE9bfx3W/9TyAfXoflv4HCii8+6FAaRxyTzELrcM5MXMADg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9180
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Pawel Laszczak <pawell@cadence.com>
> Sent: Wednesday, March 22, 2023 5:56 AM
> To: Frank Li <frank.li@nxp.com>; Peter Chen <peter.chen@kernel.org>;
> Roger Quadros <rogerq@kernel.org>; Aswath Govindraju <a-
> govindraju@ti.com>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> open list:CADENCE USB3 DRD IP DRIVER <linux-usb@vger.kernel.org>; open
> list <linux-kernel@vger.kernel.org>
> Cc: imx@lists.linux.dev
> Subject: [EXT] RE: [PATCH 1/1] usb: cdns3: fix super speed mass storage
> gadget device failure at imx8qm
>=20
> Caution: EXT Email
>=20
> >>The mass storage gadget has one IN and one OUT endpoint. The below
> >>(Fixes) commit aimed to utilize all hardware FIFO to support composited
> >>gadget devices. This resulted in an ep_buf_size of 15 when a single
> >>gadget was enabled, such as the mass storage gadget.
> >>
> >>However, it was found that there are unknown limitations on the imx8qm
> >>and imx8qxp B0 platforms. The device would fail to work if ep_buf_size
> >>exceeded 9.
> >>
> >>To resolve this issue, this patch reverts to the old settings used
> >>before the below commit for the imx8qm and imx8qxp B0 platforms.
> >>
> >>Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to
> >>composite EP number")
> >>
> >>Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >>---
> >>
> >>I hope cdns engineer, such as pawell@cadence.com help identfy the root
> >>cause.
> >>Look like old version ip use more memory then what ep_cfg show.
> >>
> >> drivers/usb/cdns3/cdns3-gadget.c | 11 +++++++++++
> >> 1 file changed, 11 insertions(+)
> >>
> >>diff --git a/drivers/usb/cdns3/cdns3-gadget.c
> >>b/drivers/usb/cdns3/cdns3- gadget.c index 5adcb349718c..497c8e87dabf
> >>100644
> >>--- a/drivers/usb/cdns3/cdns3-gadget.c
> >>+++ b/drivers/usb/cdns3/cdns3-gadget.c
> >>@@ -3005,6 +3005,17 @@ static int cdns3_gadget_check_config(struct
> >>usb_gadget *gadget)
> >>      priv_dev->ep_buf_size =3D priv_dev->ep_iso_burst =3D
> >>                      (priv_dev->onchip_buffers - 2) / (n_in + 1);
> >>
> >>+     /*
> >>+      * There are unknown hardware limition: when work at super speed
> >>mode,
> >>+      * ep_buffer_size can't bigger than 9 for one IN and OUT case at
> >>i.MX8QM
> >>+      * and i.MX8QXP B0, which report there are 32k memory.
> >>+      * Rollback to original settings for the these chipes.
> >>+      */
> >>+     if (priv_dev->dev_ver < DEV_VER_V2) {
> >>+             priv_dev->ep_buf_size =3D min_t(u8, priv_dev->ep_buf_size=
, 4);
> >>+             priv_dev->ep_iso_burst =3D min_t(u8, priv_dev->ep_iso_bur=
st,
> >>3);
> >>+     }
> >>+
> >>      return 0;
> >> }
> >
> >I'm not sure whether you have 32KB. I remember that you had a Soc which
> >have only 18KB on-chip memory and value in usb_cap2 was incorrect.
> >It was the reason why the on-chip-buff-size property has been added to
> >driver.
> >
> >Please confirm that you have 32KB, then I will recreate such test on my
> testing
> >board.
> >
>=20
> I've made the MSC test with the following endpoint configuration;
> [ 6732.999537] cdns-usb3 cdns-usb3.1: Configure ep1in: with val 74000e05
> [ 6732.999565] cdns-usb3 cdns-usb3.1: Configure ep1out: with val 74000e15
>=20
> So, I used the 14 buffers per endpoint and run bonnie++ as tester.
> I didn't find any issue.

Problem only happen at QM and QXP B0 and need work at *super speed* mode.
Enumerate will be fail and continues reset. =20

Highspeed mode work.=20

I suspect 32KB problem because QXP C0 report is 18K.  It doesn't make sense=
 to
reduce to 18K from 32k at QXP C0.

But it work when IN/OUT is 9K.  9+9+2k(EP0) should bigger than 18K.  Let me=
 try
Check IC design what's exact number in QM and QXPB0.

>=20
> Regards,
> Pawel
> >>
> >>--
> >>2.34.1

