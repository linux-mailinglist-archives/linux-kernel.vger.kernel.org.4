Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E06D5BDAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiITDJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiITDJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:09:19 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92E739C;
        Mon, 19 Sep 2022 20:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InRym7k4y0A3tIW166xg1oJBoW0eEuCOF0KncADmVbspjMXsMi4r8t2cffMdSilBh2aYPo8IFwjVnSkFZlLpE4/KvetN7RA/+KNm0cIbFNntPvpg1YQnoFh8F8DVuY6AQzDi5nNVrkiKZIS7yYkXKfloUpEL3rB2ic6KDVdeLyJAYTUPimnTEi2rJPbQI1JqTb7RIs+grnj9d7gXuP/Wcw0v37fy2mZNcichTn2/q2uV6Uek8lvJ5EmbJtkyxkTimb59ljnf0AYhYMN0sXPnKr9Xxc3W7KJupmz1AnmsZYdT8P87WGTphqxDMHYLch66M/1NzcU7xkMDCm54y3Kk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byHqjx2ltALp9LVoa3XJH2MtMQc6mwtsiYROkv7GUd4=;
 b=VOD1HOioFyyq0azY2jsxTfVvvhubjkFYVsU1EM7nsgeMsRwywjAPGuruR560dzi15dV3BzKK7P0y77+bwAEp/ydfD6jxJtByKEXqc1I5f28/BsACh4+TqnPGGuJuPbMtwcXmV9smzTwWE0EDg+0aHrMUHWHbhsA1WabflpFHqLThz37DjyIEhO47Icr852k8/NWNOftPUZtAmBe2R9R1ggpzRI/w1pliA110axGkwm0tjDTC3yQAfYDUxlysCiNSb9mfTPR+PfLLuLKcqGLi0RXiE94UPyPgjWd++Q1VpG9NpuJ2pFS/+ifR9rx9lcHLBC7tUu/N8Dwy7ybNRnsRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byHqjx2ltALp9LVoa3XJH2MtMQc6mwtsiYROkv7GUd4=;
 b=eHlNnGjbpEUUuqEw149HBm5mjudO79PaDkVLh8EljLEaSWILNS/v3RTw/TqeXOEzIBg76BllflCQjk0/1xjUrqO1fdwAbkZDmRI+On7YXvz512VYqAKcAh5Pbx6oo2Bz21eiC4CK0yLBsrCq8pPdoV/wODUONXM+Eobiye5SwTg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9253.eurprd04.prod.outlook.com (2603:10a6:102:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Tue, 20 Sep
 2022 03:09:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5632.018; Tue, 20 Sep 2022
 03:09:15 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bjorn.andersson@kernel.org" <bjorn.andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V5 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
Thread-Topic: [PATCH V5 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
Thread-Index: AQHYt1YQLw/DlLV00Eatr29REha5pa3nzPRA
Date:   Tue, 20 Sep 2022 03:09:15 +0000
Message-ID: <DU0PR04MB94179E5E1563DD72849BEDCC884C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB9253:EE_
x-ms-office365-filtering-correlation-id: 6c72a05d-dc7a-4591-2d3a-08da9ab58018
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y4nyOVup/oAFNyDoniJCFmXYdFgYRgf03s65kGFtvq12BrTM+PuR9er2SYLNlgRfRiX81bhH5CiIvGCQBPdPNvq9Rt0EKT3pk2FOuxvKlBtJtzF5SNj5SeMlaWDfVtjmswCXzsWB2VfmZHLzbK1qCHP7GjPI+z8QVzs3X6HuRW09Nj5N1Vlal9TSlRQ6Irsk+l7pjxbRYogHn0w2dhEJ3M3ZbGyjPuV91ODNyhZ99tMjE5NW9byR2i9rJUGuZaSHKMO6yi7eMeduKCIdobORRm4eOXoeuJKfVCQb2TC888v6cYwtc0tdkyrvhvfIi9XkU50RMr4thGurb6j5yni9vDWEuULIr1MDBrDWLchRnM3dYt4Hcr2ijSi9Hw4cCCFanjn3qjizQxcqMb7mR6ISOyLD3C+1eMJ8dgf0v8JDzv2ZP8BCBJ03LyE2Qa58hup06yDawrG7ERjw96sBrdiO80vu0LoouUiO/P/fXlyl76q5w7ca77Q1WjWpHhlcW53mWhllO4s4OrXu9Tj/MgYEpAmzpP6Ef/mQ2DbXhSVX9w1SEs0zlkKlVS2Au0byFo2TEZlzXY5EmTNqrFLodBYm++jYrVn10xmq86sHqt6H8LOj/h3i2qsZl7vgPyQTLYwQP9/HsIZks6BrWUyne1c3v0HDwHA1aZsYSLHk9hTV3F75BS9sRytx9mzGURHxjvdDdeyihOX629bflHkCwIhxmHYeSHYyHp9ip43MeMypBGBXgnZ5ouDiHT/xNfVSTCPRjzNscBOqRkDxdh2ox5N9GqycbPw1vnh6EYRWkx8PgSq4tSaYIBEjwpDDIefSIrAp8tM1izvFd6IJGk/5Sn8nOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(41300700001)(966005)(71200400001)(6506007)(83380400001)(7696005)(26005)(186003)(9686003)(7416002)(2906002)(44832011)(5660300002)(55016003)(8676002)(110136005)(64756008)(8936002)(54906003)(66446008)(66476007)(66946007)(52536014)(66556008)(76116006)(4326008)(478600001)(316002)(38100700002)(122000001)(38070700005)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fzYDxRVRd+fVFbcx9QNWZXa7WqNZbwcQoJyT6TkOjcw+cH+iMezwgSX/UL78?=
 =?us-ascii?Q?25QJieVQV+6fdze2b18/uCrba/G9M+V8asQzz/Z5Vw/ndHk/LWfnCWDhKKs1?=
 =?us-ascii?Q?AzPewNfJGPBhC7dmsGVQ1vK41TWHGflA8Q5/3fP0N63jl2B920pGOSPblllh?=
 =?us-ascii?Q?dSghMpv9rBpYRrPvD8KeRTfDSBcBYxpOYX9uQsvIShOYZtBIACDa3N+bn6X0?=
 =?us-ascii?Q?REFEGDpci5uk1BUi3AHbOSP+2XqdlBMht77mlX/r+1hLptuys3VupvQsZpg9?=
 =?us-ascii?Q?fDLAeaYBCf1Oj6W3hpjqgLx4V40cSZ2b1U95aTolRjE1j8ZXSbtWihoBeVlf?=
 =?us-ascii?Q?5nAHx/BBxT6DPsZ9yLIKE2a1imS8XBeaZlcnoTfRqiNHci5uiX/sHJe7GxNM?=
 =?us-ascii?Q?8KLUvWj2Rb38ij1t+60DI2kiuBsdSqdaV2VFiCOGChhHmdr+9u4cx2ahta3e?=
 =?us-ascii?Q?3wwiPKST/IT4yTXRijitf8FruHEKb7P4DqB3CY9mps1nAQxGEdt6h6Z9Jijv?=
 =?us-ascii?Q?eigYKe5n7wnRj0XI6vIWcwD6dNXY02eFjv/aviFAs8JOFb+RWfW9qU3+ioZ5?=
 =?us-ascii?Q?zhzdbahFyJGwFDPIyuzwEk2z0Jw00mXBRyr2IOUG5ZMHtwFJXgStTUagBpWx?=
 =?us-ascii?Q?+SMdR4Hsza2FCkHiOM28ni1dO1o+ocysQTLVku59gSqXarCqjgnINMjJ409p?=
 =?us-ascii?Q?txLv9/K8x9YjgwpIcBFP5zQK1cKRpk4oPZDtoTYkf5OrSaEfzRoMFqDD+nQ2?=
 =?us-ascii?Q?pxW1L+U9nsrWhBNMdwDeZW9n7L7AN8VsIgiWQbta1oWdb10ErBvP7S0Fwx2G?=
 =?us-ascii?Q?uX5m2FldaEUj6KMyRJrLGp98a7m1LgMNz4QqxpI0zbzNUqrCX4pVS9mWfZQQ?=
 =?us-ascii?Q?R9PTCpYX0Qe5J60xD2S4hjygYJVs6pJD1pPwArr3EEJa3tECPAvr9pJWrsNw?=
 =?us-ascii?Q?h1eI8cJVrgDOFVJvRzphXEdtxH+WM12MJDbl4LwLgz31Se7ycNV99usH0pLM?=
 =?us-ascii?Q?0X0azFKGGV6dNAo+SrF+dg6l2MLTzQuaOFCAXAVUIKi5e7KZjH//mxDvaCE6?=
 =?us-ascii?Q?Faoby61BhenY1hTOGLhZLYCKZ/TYIcBN6ju4RpWawG1fbuL/glrIWmpmokDI?=
 =?us-ascii?Q?uiDu+aT3/0cNRnvu+K72a91iYKHOAJibzBXCTEorU/S5Gx7pMm5i7IgzTT0g?=
 =?us-ascii?Q?Tx0FCw4uODPXFMtf7ALNfBdmqK657AApH2dZWFnMgVqeLSt6VmzEvfxGePvu?=
 =?us-ascii?Q?yquBmDIdfpX0ZTEdNFAjw3zML4dGR4rHSM03afh9pzlk2YqHv/wajQ+NkioP?=
 =?us-ascii?Q?+ucTmUlq3dyffay572vFe1xsVDpy3CdClVTg4kwQH2B8MQfOj7x4iNb/lMgT?=
 =?us-ascii?Q?2NfaBzNC00VyqNig6mMv3UnZwbpfVRO1FievUc7weAl4rFc5XS/1gwIfisCw?=
 =?us-ascii?Q?3AgcGa6ZNFGx3Xi+XivBSIvPxWzgnJ+AwqbEMTeTuSBsbrLuBjTqrWrcFZpa?=
 =?us-ascii?Q?84+AkFEWoU1g3EjoeC5LTOyLGZrgoRDyvHKNalMNahXTGrtLBzdvycPGSXux?=
 =?us-ascii?Q?6/zaHprYrQBWu3K97cRUp9PLM7WIilxuO6BzLjpJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c72a05d-dc7a-4591-2d3a-08da9ab58018
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 03:09:15.4547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cl7e36AgzvuSAcExObj0uCMyuWcJvsEibGRWTb7+Y2ROj3cGTNvJUfImSar9z9pF9rhG5UTEJde64dSJTVRnHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9253
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn, Mathieu

Is this patchset fine for you?=20
V4 was sent out 2 months ago and no comments,
V5 was sent out near 1 month with only a minor rebase conflict.

Thanks,
Peng.

> Subject: [PATCH V5 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> V5:
>  The patchset could not apply on latest remoteproc for-next branch,  so
> rebased. Only patch 6 has a minor conflict, other patches are not  change=
d.
>=20
> V4:
>  https://lore.kernel.org/all/20220701104725.557314-1-
> peng.fan@oss.nxp.com/
>  Add R-b from DT maintainer
>  Fix probe failure and driver remove path in patch 3, 4  Add comments
> about i.MX8QM entries filter in patch 5
>=20
> V3:
>  Drop the dependency in V2.
>  Tested on i.MX8QM/8MM
>  Use 'fsl,resource-id' and 'fsl,entry-address' Per dt maintainer  Drop 'r=
eg'
> property Per remoteproc maintainer  Drop mcore self recovery, until we
> land in common framework support.
>  https://patchwork.kernel.org/project/linux-
> remoteproc/cover/20220517064937.4033441-1-peng.fan@oss.nxp.com/
>=20
> V2:
>  https://patchwork.kernel.org/project/linux-
> remoteproc/cover/20220309102118.8131-1-peng.fan@oss.nxp.com/
>  Depends on https://patchwork.kernel.org/project/linux-
> remoteproc/list/?series=3D621311
>  Tested on i.MX8QXP/QM/8MP
>  Addressed Mathieu's comments
>  Drop V1 patch 5/9, patch 3/9 is replaced with upper dependency patchset
> Move V1 patch 4/9 out to https://patchwork.kernel.org/project/linux-
> remoteproc/patch/20220308065754.3355-1-peng.fan@oss.nxp.com/
>  Update commit log
>  Drop magic number to get entry address from device tree in patch 4/6
>=20
> The V1 patchset:
> https://patchwork.kernel.org/project/linux-
> remoteproc/patch/20220111033333.403448-4-peng.fan@oss.nxp.com/
>=20
> Peng Fan (6):
>   dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
>   dt-bindings: remoteproc: imx_rproc: support i.MX8QM
>   remoteproc: imx_rproc: support attaching to i.MX8QXP M4
>   remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
>   remoteproc: imx_rproc: support i.MX8QM
>   remoteproc: imx_rproc: request mbox channel later
>=20
>  .../bindings/remoteproc/fsl,imx-rproc.yaml    |  16 ++
>  drivers/remoteproc/imx_rproc.c                | 261 +++++++++++++++++-
>  2 files changed, 270 insertions(+), 7 deletions(-)
>=20
> --
> 2.37.1

