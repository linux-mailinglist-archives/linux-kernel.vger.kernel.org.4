Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CF97050F8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjEPOio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjEPOik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:38:40 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ACCBC;
        Tue, 16 May 2023 07:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBHD1ccrofFkKVngwb1hrMuC4M/39TIr31qsUlyriMSRf5YtEDWSrO/holTl1qLl/stQxC1oSx8HacOpB86ZxUlEmCKvml3r9Z4OQdaPUw57PWud3L9CAuliEcbhb/zLnAKwVK/gWUDL0petgAWUZEmIgVmey+Rf1u9KD/Xt3L8d3Uz+G1ZYRSF43C0/ezon8oHcIy8fFkUBjNmFf09TpmTUjxz2CATuJb4nl8GJTEUBzStyjM9V08lbmFEt9WVA17wxuoa5DUbD/KVgnq5S2Ew9hBTIy7gzWGZBmeaTrDqwwx52Yoj+cLQayuZFkQEn7fcGpZW8c4lnzXTbSwnCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=516FWndNAWE3za7gtlzGUthghYeqkwutFtOikKSEkcI=;
 b=hHhh9GqLS0JlpbP1jsg7kWGBsoai2ZnAqSoePs9s9SmzE2LFgq2iPJP+f9IWDuWZ0HhNNy+Xg+M37hEdWelYnciOD5YOBfEK+e0znK2inYD3ztN3ZXpgN5DiHkcrPA7OlBHot8xkTS5LlNaPu7XWDBWJ9XgHoMjKsiKABmLw8VmTsScTuEvgFikLga8EP/F2Vi7wcbgf4YlXAR8bfOMdM0uQrFFdy/S+ktdzuNKjXiIt9T+K0XuMznuq9MheacMFmtc9RhnIHdxBd59n52d94Ho+fVQ6OuTvqUc1IbYl/I5AcHhaJ/JKopVSgpK9QKVp8QuxvxAs08kqNAlq5mAM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=516FWndNAWE3za7gtlzGUthghYeqkwutFtOikKSEkcI=;
 b=dscojq2ZSZNeSkreGB7t0H/MT453lTBWK6+8siAXpaRpRJlmYaSJ8rIotr3sokPwONk+3MdMkJM9Yv9pPxr5WSCWKaHlo6Abnb3t3atXldiMjQxL67gRKQoRyGgnWc19wwuwDSqkLhR+twDq+5sjeNsXqXt/P6pfJUebF8n6iR8=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9675.eurprd04.prod.outlook.com (2603:10a6:10:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 14:38:37 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 14:38:37 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "kishon@kernel.org" <kishon@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "F.S. Peng" <fushi.peng@nxp.com>
Subject: RE: [EXT] Re: [PATCH v3 1/2] phy: cadence: salvo: Add
 cdns,usb2-disconnect-threshold-microvolt property
Thread-Topic: [EXT] Re: [PATCH v3 1/2] phy: cadence: salvo: Add
 cdns,usb2-disconnect-threshold-microvolt property
Thread-Index: AQHZg0h2gsxnX4rz1UCs/VVu0rrlkq9c6teAgAAWjuA=
Date:   Tue, 16 May 2023 14:38:37 +0000
Message-ID: <AM6PR04MB4838DE5280012693D0F98CB388799@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230510140504.2164565-1-Frank.Li@nxp.com>
 <ZGOCT0Mdg3Jtar6c@matsya>
In-Reply-To: <ZGOCT0Mdg3Jtar6c@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|DB9PR04MB9675:EE_
x-ms-office365-filtering-correlation-id: 339d834b-835a-4234-61b6-08db561b3be1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y3coINSZcZzisRhwU9La3p1BFIULfciN2Q+28xvsBswtfP3bRWvXDafhczh5pbLxwlrsseZdfoyRt9686p2XczeYYIGPpYKgkZLP+k/s5u9ibcxzc6awv9LhqCD6kqZhpaCj0VOZ2JIPdNJGY+dGZ/IZHaOAF9lJ9cp2QOQUSt5GyvJ7JBMP23Ml2K5SYQls0Myc3OjtD6M9bV7AjXnG8M389Dsqy70tttIEJkm0Bi+cYx4IVe/pyg8TYrgKy0wEJmX6o311nl1OtUAe6wonbI5aoMN5yNZQ9w1wwFd4UhKCyRK8o62XGyDxEDzC5ElNKJiIb1ApT9OUvMpJpHFw7cMeeaH0vCpd8cDXhmDKehWi7hQSx3ZeYAk5FsxN47kNUdp0GeGPxdFN0VjE807fy6rO8LDrcRHBxFX4JSssfrZLdlXDhgZUzcA7fNQOp0w60IAq7h+EXm4jxkP2pvJoIPJ1Jl8E4KVAlUy58GOCMT3P1yZ5fnsRIDBGV7FL/ifT7t9kVnVte6T87GZROnelNKVF/9zkv7mfVvN3wO1RFnOX1YLs23OTMvotkLpX/uvQHDmRNaxl+OIcoZL0BEVFu0BgqrJghhrTEN1nHFZCzGv4csmvXasRc0+FtG3txTR5G3nIr0TueRMzlvARC0WVk4xCU1T1NI51pNlyiWiIMFU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199021)(86362001)(41300700001)(38100700002)(54906003)(316002)(52536014)(5660300002)(44832011)(38070700005)(33656002)(7416002)(8936002)(122000001)(66476007)(4744005)(2906002)(478600001)(76116006)(4326008)(66446008)(66556008)(66946007)(64756008)(6916009)(8676002)(7696005)(71200400001)(6506007)(83380400001)(26005)(53546011)(9686003)(55236004)(186003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bL09/dFqV9wOpCXaw76tRqOVz5761E3TLDJ/pLKKASdNDjITPj3nL3nnJIFg?=
 =?us-ascii?Q?LsjszpsqHsRvLAOVKnyiSx58jiH880NmW33d5huWrKBkipuB1di434NOKdeu?=
 =?us-ascii?Q?AKvtyHXoDSJ1A8tCaTnIF7UR1fkTtCZOaTDLQW/o9CTUqohv84IiDA2oT8DY?=
 =?us-ascii?Q?+5VsxybOKUljmVGMHXdkd2k4JpT+skfx+m+z7WpWeo7alYVQ894rq68eOUGI?=
 =?us-ascii?Q?wa0BHiI9jywdnB/oW784t3EA1fagUMM/GSpiuCMYgXBaoOmZd2WTOdgRlSo6?=
 =?us-ascii?Q?X9n6STI+nHlAI07d+X9sUorQgkTPBTsG3YqR1wRoFgxKXmTKtsO5tZzOM7H/?=
 =?us-ascii?Q?JHBc6chLnQ9un42tvX52FSOQcMi6zsCK+qtd4b8TA0cld5PZzQ30xqRqKeY1?=
 =?us-ascii?Q?6wyZeEkTGRMvLj9U0Abk9Zbc4/Iuz90f0pQhHYEI5kjdFg1zTPys1qPZ6ir4?=
 =?us-ascii?Q?HJUN5rBHZ/DqSV/jnZrwaTnvgsY5bhklHTroKB5qyC8XeGTNhl/FbAehzAvV?=
 =?us-ascii?Q?/SJsXlAH9Eix5WdBBAiW3xxYMo4CNp9i6cjC5LM4CH/xBOCgXAlJuufX4mLh?=
 =?us-ascii?Q?uPYd39mMJSehzs8TzgIiqIOZecJZ5TVUK1cHhiwQlqof2n/vzAKenIfAIfZx?=
 =?us-ascii?Q?7AmDUc5lKyIQdz3gNPwilDTRTNhv1tI2fdGBlp1ojnWrToEG/bTC3ACtOhKm?=
 =?us-ascii?Q?Nfa4QEpBX0XKIQzp/E9KxC1JTEyWyqR4d+CCUcV4llxUB1MmKejT0zzSNLGT?=
 =?us-ascii?Q?t9H9iVruLBfOPB511UHk1TthaZbHPIunMmCE9279+Vr9krLNHyDp7HQHYjAF?=
 =?us-ascii?Q?l6m8TAMQcGNuKzL8Bo/lyUAIxloH4YVahl6HXCUC4MKel3X4dD0Xs+eK3XqX?=
 =?us-ascii?Q?ml5Jz0z0an3xoPNoVeGTL0qecu7BzPMm77CW5ZOUGc7ZN75Hi9z3i9U09rqL?=
 =?us-ascii?Q?ZPBMbOL9JO2z5M16c9e7qW9XlrdRSBCkPcrnFNJKXkv21ABLViMaDTpUKCMi?=
 =?us-ascii?Q?0r0sB3dFverF2bgPL9NXnLNWqDprPd9/q8U83U9Wfd4OQWNxzFXvKGhxJ4vZ?=
 =?us-ascii?Q?cGa1jJ3d3tuF/kelPgWhBaIf/V1rFC7rCKJkuDVTMCgtKEzWCZ1dI+dABRvC?=
 =?us-ascii?Q?4cW7C/jqgNgR9VMEmWwJuXgLXgCIQ+l9cUDfAMWfcwBpfYDLB/RpdSESJadz?=
 =?us-ascii?Q?qbBjyLpAgrE6D6/I4HwckyYl5x0ovhBIN6HHX6NqkCPGpTw4eeIAdjEEeJKn?=
 =?us-ascii?Q?3YLLpgMvv2+CBZgpqjAKkqhMRq5l2iWoM4F2KEeQt4H8s+xsnBeEgKAgDnYA?=
 =?us-ascii?Q?u2E3hn1QgNv/r38r+HEf4stSRBL0oekq5VnZY8Tgw4Q6DjZTuTko+4AVynyh?=
 =?us-ascii?Q?zzV51rq2A6is5x5PgKsVvVYHKBGFOTPYVRpc0kwohC3XfejoVAi7+gLw7lmq?=
 =?us-ascii?Q?LqSAKxraOvPChvEtVt8CPGrPoAhqnqQOKlXv/wd42bghy4aTZvoX/9lUrRDL?=
 =?us-ascii?Q?i3Ut546Pvzqt9eviM07/YmZqlhe634A7hEmSGWp2Vbmdc4FT8cxie4WHnaHj?=
 =?us-ascii?Q?ncM076siUsZkbUljSsU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339d834b-835a-4234-61b6-08db561b3be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 14:38:37.1453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZORZLq+trqZhnXqw5zC8U0EplMVYB7RixeF0Wilp+l1BN9fU88Iwv266t7AZW8I9opHSGczMD+Jgw3y/tHGlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9675
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 10-05-23, 10:05, Frank Li wrote:
> > Add cdns,usb2-disconnect-threshold-microvolt property to address fake
> USB
> > disconnection issue during enumeration or suspend state for difference
> > platform.
>=20
> This fails to apply for me on phy/next. What tree was this based on?
>=20

Sorry, let me rebase it to latest phy/next.
