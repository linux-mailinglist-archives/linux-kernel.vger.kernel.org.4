Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1205EEC98
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiI2DxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiI2DxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:53:00 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E3F72B50;
        Wed, 28 Sep 2022 20:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeCElU2GhhYPSo9GBXd97W9TWUcmxxd1eRaUgQ+siCpmcU2zQ1J4lqUxp1MblSBUAZKw1faMujYCvChsJAAPYb2zELJfxzzFoFiKTQxaJRafVp3uc3hDInJTmRMiXoANtmcqpAEEMIUfX/YLKY+FmYgYgQ3vq3RSOhmGFaqYSWJnHZNFSWbm67wEcByiQpCOeP/Nm1wtrCpwpDWcAYQqTGazmuELStfh4SHTDzWVhDHAGjAqdHBaaDFwvz7M+GiIa4LjpJdF1TIASY/EnbnGtvHrFUwYFvjTmR3n7BHvBmyun/wSbZq7YzRXf9VY5syllR2b87yfmW+V10FlbxazgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGPVk3C6TIH40/ayjQp9JRBpqzO/vsurAMAtB+K2zrw=;
 b=leY4Cl7WEKcp2KEpnnaPt52f4GmFab1vd+0EvDyOWtBsi7IRrK6YE54ceovGnnFAVj7ZPR0H0R6WuQ8RodyTnnPq9Eo2lmfxJUomUjYVqqQkKL3Cgj6vqOybJibKBULQqirg4nYByK8NO7Qj3xrHQdYk/VIB/BLE88bSVbH7flKlib7D1Dnoy831e/4DZwFprb27Cc7THBQFCs1fp9L5dH554qn30pA/7j77HLdK+3QuZfW1kGGkq+kJasFqPzHqUPoT6LyuYW83pkbH+WgDVQwm7hSlUbfxh0xylM/pLhus2UW6oh9wnn4+IUOpVo6t9v9RqXd85443/GyJfedZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGPVk3C6TIH40/ayjQp9JRBpqzO/vsurAMAtB+K2zrw=;
 b=kYZ9tqxJvRg49INJpPaCKvjrELtwcsDxlcAaPCSytYas1QMNW/NcXdUV94Jd2QwgVD7tYZDHSQDGXCcE9oSZuIp1B4wLmmk58S2geelEs7ICWQ7G9e+UJJ59XRt9ZXjJEp0zbYlOt0tKnSTzrSavO3WmNkSNIh6dd+P7cBk10Pg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7918.eurprd04.prod.outlook.com (2603:10a6:102:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 03:52:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 03:52:54 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: RE: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
 i.MX8QXP M4
Thread-Topic: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
 i.MX8QXP M4
Thread-Index: AQHYt1YYYWV783i6iEKFTZ1KuPZo+K3yjrqAgAA2iDCAAQEZgIAA5feAgAAno4CAAH1+AIAArT9A
Date:   Thu, 29 Sep 2022 03:52:54 +0000
Message-ID: <DU0PR04MB9417F8BE0B50230F689102CD88579@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
 <20220824011023.1493050-4-peng.fan@oss.nxp.com>
 <20220926232127.GB2817947@p14s>
 <DU0PR04MB9417EABB1B0A9B550E94236288559@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20220927175649.GB2883698@p14s>
 <64c6bdc2-583d-a2d0-f8b8-c4487f8a4d97@oss.nxp.com>
 <65b7224d-d3eb-4513-d733-ec781864fb7b@oss.nxp.com>
 <20220928173054.GC2990524@p14s>
In-Reply-To: <20220928173054.GC2990524@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7918:EE_
x-ms-office365-filtering-correlation-id: 2ee3c678-fd43-47f5-4cb6-08daa1ce1706
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yt+XT19cMLjxjxiM6hnT2MC7nZLztCUt5qCW+51jkIcwxgSsorgsOcOEc1YH5BEKAYWNau6yIeU4N8pIvDh1IIG1KkfO+JRyUiWUJ37/T8416G+mEiO7l6zlnC8pXt3OwJlZA2SPicazIq3xHBFh0ylk8mhUsi6gIiHnGGGlWASxUnKriBGcOpNpe97fvBR/J+9RUS8N6XGlK9Y21W2V/Y3zwWIgp4JoNAXyYYd9tBCzlVzM8uwz6EWTb66HKh0ul1Ebse0RJPwb2UswbGCSqXURuo3/g6QrjWObKWyvRcGHcHBYYeTNGQh8aqk9ylbCqj1KqyPsCDADhXht8nSYkNxel5A9ckCADoSY/x7F2PXoqBMcM2qvYJmHA1n1xDf8VBnbTW7Jl7kR3jZnj7UVt4EqS7GV0elxAcoJox90umwFeGaFuShLX8jFwPu3f4xIOUcEeBK9yVw7rXJANfdA4JClqmmhzDjqNiZmkDIEtDWNjF1IHuGPrWA1X0qSGkFm5fHJCZ2yWKAmy1McnDH7bmUxlX9GKS9vIfS9N9W57B4hweDcNwWWz+j0ClKPBCx6lotFS2NQozcyNPg51YoUaQ95ss3BDTcDicnG3/73jG95Cx8Eo+nZHKkrXSqpTeR2ifIBF6xlRRzqvTGFX9Hsxz7A8WMzZoLxGIovs8KbP82XBraNAiS+jF+eFE4qEEzaQKY20EUmJRSEP2KXF5q9VMf83ACtlolcztv482xGNgpb6I0AsGbjqncYq03QZR1zfevX5Qs9lfeHI38VRj33Bt+IaU3TQ6l+2z1wFZ90QMI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199015)(44832011)(33656002)(5660300002)(7416002)(8676002)(64756008)(6506007)(7696005)(41300700001)(4326008)(122000001)(26005)(38070700005)(55016003)(86362001)(38100700002)(9686003)(83380400001)(2906002)(186003)(30864003)(966005)(110136005)(71200400001)(54906003)(478600001)(53546011)(66446008)(66556008)(8936002)(52536014)(66476007)(316002)(45080400002)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d34XYyigpRqdn/yvp0KfFrHH9Kb4eda7Z7f+sgAzrnAxDpllUpQBiX+phD?=
 =?iso-8859-1?Q?438mN+lIvz03fuB2wTthvc8zkdfeG5MX+mKed6V1AGMa/PXwW6z4wBAMgi?=
 =?iso-8859-1?Q?2pCszYsAtXoXnKd0N6KaKJ+CxkE128C59y12B5TlJVIs+QGL8lMBX9KH+I?=
 =?iso-8859-1?Q?/2eGC15Yeidunzr0W76inhocQw7p3fWxJerxwM8PtFeD5mugAJLbL7niIs?=
 =?iso-8859-1?Q?pRMK8eGkF9g4EsMKhb51yUmVrirdg8PQOU9DOQxhEXaE1acNN7pjKaJ+if?=
 =?iso-8859-1?Q?VbBHHMK/7ill5/lXjtugRE6Un/Wl1zyBKKXrKthNVZOYOpZC5F5RZnmyRS?=
 =?iso-8859-1?Q?EDrwVRgEODOuf8HguvmK2wMRXpbbOirQGW5JG4QX9RRPBgODTN+tj+bOtT?=
 =?iso-8859-1?Q?6yC0X6ij0pCuxeJgQ7HJS1c2JzwwdtNVAj+F45EWbjmmsMgjFZj0aiH5y0?=
 =?iso-8859-1?Q?ROlG03MPw4ttC+O9Fd+yUltl3+bIzu4SczG7JPSrZ2Kt4cyW1hkRm8fn6u?=
 =?iso-8859-1?Q?R/Yc+a9xAw/fWHO3/ztBsNrZKjOi2AkvBzey2xpXkn7/pOb2Jz6v/kPOtm?=
 =?iso-8859-1?Q?SJrhz1Nj+oajtPbI699Cr7+pvn8Fy6Yx6q134zotybvDKy6q6pySTb/zAZ?=
 =?iso-8859-1?Q?sVJrmWOMgUnQJySaCnDl4dfC1gFCeKdbLBOo0TaMtj2pSgRvfA15yCAYPA?=
 =?iso-8859-1?Q?83HpbcljWck9d+32VTxlE/KDm/iALAxf9gA6poK8jmtoYB/LVFNjcGooX4?=
 =?iso-8859-1?Q?rojN40HyypXadg6Dxj5y3KWka/V97pqrDJb2bdUNgMrSXaZVcfKl8VNIMX?=
 =?iso-8859-1?Q?hBc6IJRaLFG8eq7Xgot29mV3p6t4OkyPyCeyXrIl6RA8NkUl3jMKBB9O+l?=
 =?iso-8859-1?Q?HRDYmSI/8HCzYoNAqE5dOTTsxRB4RC9NKKvyQ7AW9g87rycvCpwWppXMPr?=
 =?iso-8859-1?Q?1Tz84xj2OXCsOz+UTOhjJm/cu4At91GPqh1BaNEQavcEej3rGPPOumuaqW?=
 =?iso-8859-1?Q?1oXR3gicT8+x65ZDuX2VGXw21s4SOaZCIzQorVpqP/81ifYteBan7jn1se?=
 =?iso-8859-1?Q?UnTtm8ms88mR6vGEIDm3pZtIcrrcUFJjgEpQLnwXxiBQAqWvP89Xm9ag0P?=
 =?iso-8859-1?Q?RSE7zQSIsxBhArIkIPAuVMpmHjbXim5ITfWv82yxuhvB4aZJMj/WThoWg2?=
 =?iso-8859-1?Q?V40B2R0SlCKl91cfPWOF48cOggR76i9BUueRFPUYXhr7S5wHcBFJ3Vn8k4?=
 =?iso-8859-1?Q?84w95BBWSoAtRx0QXQeXfng4FRqGydAiU57sb8hL265Gaqz4QtmuoV069G?=
 =?iso-8859-1?Q?rOBUV7MzdPM5iKTQt9yS+98gCfyDcf2Psb+NDpB0z8eadM1utt9JMGFScn?=
 =?iso-8859-1?Q?Vs1tguqNm6CaHTJ4BmG2N1hUSv2wF3adv3PN/jT4w5N5n3fP/MDldM80wy?=
 =?iso-8859-1?Q?3dJBjX7Vnv1PDc0oK2BLOXUJN9gmk6It2A5hS30PtUDqgvLN6BijVcEzXZ?=
 =?iso-8859-1?Q?sajNgKFbB9FxObOzvfb1J3phl+zBY9mi7anqW6qxPNL8ql5xSqDrwH7bQG?=
 =?iso-8859-1?Q?6wCOURaQshcCb0YkJ1tRv4C/UDehKLZGAqSas2s6TEofQ6ckkZRV0042sy?=
 =?iso-8859-1?Q?dl86Jdq8/8el8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee3c678-fd43-47f5-4cb6-08daa1ce1706
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 03:52:54.7345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9alzoiQOCP7+mw7YjTrJGHbnMlR7ukHdBETlQ/LDGrCFgEAv1AUrLswbF4tbGnKO1NzAlQ0Nlo9F7lCjg0eREA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7918
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
> i.MX8QXP M4
>=20
> On Wed, Sep 28, 2022 at 06:01:45PM +0800, Peng Fan wrote:
> > Hi Mathieu,
> >
> > On 9/28/2022 3:39 PM, Peng Fan wrote:
> > >
> > >
> > > On 9/28/2022 1:56 AM, Mathieu Poirier wrote:
> > > > On Tue, Sep 27, 2022 at 02:48:02AM +0000, Peng Fan wrote:
> > > > > Hi Mathieu,
> > > > >
> > > > > Thanks for reviewing this patchset.
> > > > > > Subject: Re: [PATCH V5 3/6] remoteproc: imx_rproc: support
> > > > > > attaching to i.MX8QXP M4
> > > > > >
> > > > > > On Wed, Aug 24, 2022 at 09:10:20AM +0800, Peng Fan (OSS) wrote:
> > > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > >
> > > > > > > When M4 is kicked by SCFW, M4 runs in its own hardware
> > > > > > > partition, Linux could only do IPC with M4, it could not
> > > > > > > start, stop, update image.
> > > > > > >
> > > > > > > We disable recovery reboot when M4 is managed by SCFW,
> > > > > > > because remoteproc core still not support M4 auto-recovery
> > > > > > > without loading image.
> > > > > > >
> > > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > > ---
> > > > > > > =A0 drivers/remoteproc/imx_rproc.c | 108
> > > > > > > ++++++++++++++++++++++++++++++++-
> > > > > > > =A0 1 file changed, 107 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > > > > > b/drivers/remoteproc/imx_rproc.c index
> > > > > > > 7cc4fd207e2d..bcba74e90020
> > > > > > > 100644
> > > > > > > --- a/drivers/remoteproc/imx_rproc.c
> > > > > > > +++ b/drivers/remoteproc/imx_rproc.c
> > > > > > > @@ -6,6 +6,7 @@
> > > > > > > =A0 #include <linux/arm-smccc.h>
> > > > > > > =A0 #include <linux/clk.h>
> > > > > > > =A0 #include <linux/err.h>
> > > > > > > +#include <linux/firmware/imx/sci.h>
> > > > > > > =A0 #include <linux/interrupt.h>
> > > > > > > =A0 #include <linux/kernel.h>
> > > > > > > =A0 #include <linux/mailbox_client.h> @@ -59,6 +60,8 @@
> > > > > > > =A0 #define IMX_SIP_RPROC_STARTED=A0=A0=A0=A0=A0=A0=A0 0x01
> > > > > > > =A0 #define IMX_SIP_RPROC_STOP=A0=A0=A0=A0=A0=A0=A0 0x02
> > > > > > >
> > > > > > > +#define IMX_SC_IRQ_GROUP_REBOOTED=A0=A0=A0 5
> > > > > > > +
> > > > > > > =A0 /**
> > > > > > > =A0=A0 * struct imx_rproc_mem - slim internal memory structur=
e
> > > > > > > =A0=A0 * @cpu_addr: MPU virtual address of the memory region =
@@
> > > > > > > -89,6
> > > > > > > +92,10 @@ struct imx_rproc {
> > > > > > > =A0=A0=A0=A0=A0 struct work_struct=A0=A0=A0=A0=A0=A0=A0 rproc=
_work;
> > > > > > > =A0=A0=A0=A0=A0 struct workqueue_struct=A0=A0=A0=A0=A0=A0=A0 =
*workqueue;
> > > > > > > =A0=A0=A0=A0=A0 void __iomem=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 *rsc_table;
> > > > > > > +=A0=A0=A0 struct imx_sc_ipc=A0=A0=A0=A0=A0=A0=A0 *ipc_handle=
;
> > > > > > > +=A0=A0=A0 struct notifier_block=A0=A0=A0=A0=A0=A0=A0 rproc_n=
b;
> > > > > > > +=A0=A0=A0 u32=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
proc_pt;=A0=A0=A0 /* partition id */
> > > > > > > +=A0=A0=A0 u32=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
src_id;=A0=A0=A0 /* resource id */
> > > > > > > =A0 };
> > > > > > >
> > > > > > > =A0 static const struct imx_rproc_att imx_rproc_att_imx93[] =
=3D
> > > > > > > { @@ -117,6
> > > > > > > +124,18 @@ static const struct imx_rproc_att
> > > > > > > +imx_rproc_att_imx93[] =3D {
> > > > > > > =A0=A0=A0=A0=A0 { 0xD0000000, 0xa0000000, 0x10000000, 0 },=A0=
 };
> > > > > > >
> > > > > > > +static const struct imx_rproc_att imx_rproc_att_imx8qxp[] =
=3D
> > > > > > > +{
> > > > > > > +=A0=A0=A0 { 0x08000000, 0x08000000, 0x10000000, 0 },
> > > > > > > +=A0=A0=A0 /* TCML/U */
> > > > > > > +=A0=A0=A0 { 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN |
> > > > > > > +ATT_IOMEM },
> > > > > > > +=A0=A0=A0 /* OCRAM(Low 96KB) */
> > > > > > > +=A0=A0=A0 { 0x21000000, 0x00100000, 0x00018000, 0 },
> > > > > > > +=A0=A0=A0 /* OCRAM */
> > > > > > > +=A0=A0=A0 { 0x21100000, 0x00100000, 0x00040000, 0 },
> > > > > > > +=A0=A0=A0 /* DDR (Data) */
> > > > > > > +=A0=A0=A0 { 0x80000000, 0x80000000, 0x60000000, 0 }, };
> > > > > > > +
> > > > > > > =A0 static const struct imx_rproc_att imx_rproc_att_imx8mn[] =
=3D
> > > > > > > {
> > > > > > > =A0=A0=A0=A0=A0 /* dev addr , sys addr=A0 , size=A0=A0=A0=A0=
=A0=A0=A0 , flags */
> > > > > > > =A0=A0=A0=A0=A0 /* ITCM=A0=A0 */
> > > > > > > @@ -255,6 +274,12 @@ static const struct imx_rproc_dcfg
> > > > > > imx_rproc_cfg_imx8mq =3D {
> > > > > > > =A0=A0=A0=A0=A0 .method=A0=A0=A0=A0=A0=A0=A0 =3D IMX_RPROC_MM=
IO,
> > > > > > > =A0 };
> > > > > > >
> > > > > > > +static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp =3D
> > > > > > > +{
> > > > > > > +=A0=A0=A0 .att=A0=A0=A0=A0=A0=A0=A0 =3D imx_rproc_att_imx8qx=
p,
> > > > > > > +=A0=A0=A0 .att_size=A0=A0=A0 =3D ARRAY_SIZE(imx_rproc_att_im=
x8qxp),
> > > > > > > +=A0=A0=A0 .method=A0=A0=A0=A0=A0=A0=A0 =3D IMX_RPROC_SCU_API=
, };
> > > > > > > +
> > > > > > > =A0 static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp =
=3D
> > > > > > > {
> > > > > > > =A0=A0=A0=A0=A0 .att=A0=A0=A0=A0=A0=A0=A0 =3D imx_rproc_att_i=
mx8ulp,
> > > > > > > =A0=A0=A0=A0=A0 .att_size=A0=A0=A0 =3D ARRAY_SIZE(imx_rproc_a=
tt_imx8ulp),
> > > > > > > @@ -680,6 +705,37 @@ static void imx_rproc_free_mbox(struct
> > > > > > > rproc
> > > > > > *rproc)
> > > > > > > =A0=A0=A0=A0=A0 mbox_free_channel(priv->rx_ch);
> > > > > > > =A0 }
> > > > > > >
> > > > > > > +static void imx_rproc_put_scu(struct rproc *rproc) {
> > > > > > > +=A0=A0=A0 struct imx_rproc *priv =3D rproc->priv;
> > > > > > > +=A0=A0=A0 const struct imx_rproc_dcfg *dcfg =3D priv->dcfg;
> > > > > > > +
> > > > > > > +=A0=A0=A0 if (dcfg->method !=3D IMX_RPROC_SCU_API)
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 return;
> > > > > > > +
> > > > > > > +=A0=A0=A0 if (!imx_sc_rm_is_resource_owned(priv->ipc_handle,
> > > > > > > priv->rsrc_id))
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 return;
> > > > > > > +
> > > > > > > +=A0=A0=A0 imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED=
,
> > > > > > BIT(priv->rproc_pt), false);
> > > > > > > +=A0=A0=A0 imx_scu_irq_unregister_notifier(&priv->rproc_nb);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int imx_rproc_partition_notify(struct notifier_block
> > > > > > > +*nb,
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 unsigned long event, void *group) {
> > > > > > > +=A0=A0=A0 struct imx_rproc *priv =3D container_of(nb, struct
> > > > > > > +imx_rproc, rproc_nb);
> > > > > > > +
> > > > > > > +=A0=A0=A0 /* Ignore other irqs */
> > > > > > > +=A0=A0=A0 if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)gro=
up =3D=3D
> > > > > > IMX_SC_IRQ_GROUP_REBOOTED)))
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > > > > +
> > > > > > > +=A0=A0=A0 rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
> > > > > > > +
> > > > > > > +=A0=A0=A0 pr_info("Partition%d reset!\n", priv->rproc_pt);
> > > > > > > +
> > > > > > > +=A0=A0=A0 return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > =A0 static int imx_rproc_detect_mode(struct imx_rproc *priv)
> > > > > > > {
> > > > > > > =A0=A0=A0=A0=A0 struct regmap_config config =3D { .name =3D "=
imx-rproc" };
> > > > > > > @@ -689,6
> > > > > > > +745,7 @@ static int imx_rproc_detect_mode(struct imx_rproc
> > > > > > > +*priv)
> > > > > > > =A0=A0=A0=A0=A0 struct arm_smccc_res res;
> > > > > > > =A0=A0=A0=A0=A0 int ret;
> > > > > > > =A0=A0=A0=A0=A0 u32 val;
> > > > > > > +=A0=A0=A0 u8 pt;
> > > > > > >
> > > > > > > =A0=A0=A0=A0=A0 switch (dcfg->method) {
> > > > > > > =A0=A0=A0=A0=A0 case IMX_RPROC_NONE:
> > > > > > > @@ -699,6 +756,51 @@ static int imx_rproc_detect_mode(struct
> > > > > > imx_rproc *priv)
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (res.a0)
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 priv->rproc->state =
=3D RPROC_DETACHED;
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > > > > +=A0=A0=A0 case IMX_RPROC_SCU_API:
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D imx_scu_get_handle(&priv->ipc_=
handle);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 if (ret)
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D of_property_read_u32(dev->of_n=
ode,
> > > > > > > +"fsl,resource-id",
> > > > > > &priv->rsrc_id);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 if (ret) {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "No fsl,resou=
rce-id property\n");
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > +
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 /*
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0 * If Mcore resource is not owned by=
 Acore
> > > > > > > +partition, It is
> > > > > > kicked by ROM,
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0 * and Linux could only do IPC with =
Mcore and nothing else.
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0 */
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 if (imx_sc_rm_is_resource_owned(priv->=
ipc_handle,
> > > > > > > +priv-
> > > > > > > rsrc_id))
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > > >
> > > > > > If imx_sc_rm_is_resource_owned() return '1' than the remote
> > > > > > processor is under Linux's control and what follows below is
> > > > > > not needed.
> > > > > > That is also
> > > > > > coherent with the comment in [1].
> > > > >
> > > > > Case 1: If M4 is owned by Linux, here directly return 0.
> > > > > Case 2: If M4 is not owned by Linux, the following code after
> > > > > this line will set state as RPROC_DETACHED.
> > > >
> > > > I understand that part.
> > > >
> > > > >
> > > > > Patch 3/6(this patch) is only to support case 2.
> > > > > Patch 4/6 is to support case 1.
> > > > >
> > > >
> > > > Let's leave the subsequent patches alone for now.
> > > >
> > > > > >
> > > > > > That is in contrast with what is happening in
> > > > > > imx_rproc_put_scu().  There, if the remote processor is _not_
> > > > > > owned by Linux than the condition returns without calling
> > > > > > imx_scu_irq_group_enable() and
> > > > > > imx_scu_irq_unregister_notifier().=A0 That seems to be a bug.
> > > > >
> > > > > No. The two functions only needed when M4 is in a separate
> > > > > hardware partition.
> > > > >
> > > > > The scu irq is only needed when M4 is out of linux control and
> > > > > need some notification such as M4 is reset by SCU(System Control
> Unit).
> > > > > That linux got
> > > > > notification that M4 is reset by SCU.
> > > >
> > > > I also understand that part.
> > > >
> > > > What I am underlining here is that when the M4 is independent,
> > > > function
> > > > imx_scu_irq_register_notifier() and imx_scu_irq_group_enable() are
> > > > called but their cleanup equivalent are not called in
> > > > imx_rproc_put_scu() because of the '!'
> > > > in the if() statement.
> > >
> > > you are right, this is bug in my side. It should be as below based
> > > on patch 3/6.
> > >
> > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > b/drivers/remoteproc/imx_rproc.c index bcba74e90020..a56aecae00c6
> > > 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -713,7 +713,7 @@ static void imx_rproc_put_scu(struct rproc
> > > *rproc)
> > >  =A0=A0=A0=A0=A0=A0=A0 if (dcfg->method !=3D IMX_RPROC_SCU_API)
> > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> > >
> > > -=A0=A0=A0=A0=A0=A0 if (!imx_sc_rm_is_resource_owned(priv->ipc_handle=
,
> > > priv->rsrc_id))
> > > +=A0=A0=A0=A0=A0=A0 if (imx_sc_rm_is_resource_owned(priv->ipc_handle,
> > > +priv->rsrc_id))
>=20
> Indeed, which raises questions about how this patchset was tested.  And i=
t
> is not the first time we touch base on that.

Patch 4/6 has this change, anyway I should not mix patch 3,4 here.

>=20
> > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> > >
> > > Thanks for detailed reviewing.
> >
> > If you are fine with this change, I could send out V6. Anyway, I'll
> > wait to see if you have other comments in this patchset.
> >
>=20
> I am out of time for this patchset and as such will not provide more
> comments on this revision.

Sure. Thanks for your time. Since you have applied the attach recovery
part, next version will enable this feature in imx rproc.

Thanks,
Peng.

>=20
> > Thanks,
> > Peng.
> >
> > >
> > > Thanks,
> > > Peng.
> > >
> > > >
> > > > >
> > > > > >
> > > > > > There is also a problem in patch 4/6 associated to that.
> > > > >
> > > > > If the upper explanation eliminate your concern, "a problem in
> > > > > patch 4/6" should not be a problem.
> > > > >
> > > > > When M4 is owned by Linux, Linux need handle the power domain.
> > > > > If M4 is not owned
> > > > > by Linux, SCU firmware will handle the power domain, and Linux
> > > > > has no permission to touch that.
> > > > >
> > > > > Thanks
> > > > > Peng
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Mathieu
> > > > > >
> > > > > >
> > > > > > [1].
> > > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2
> > > > > > F%2Felixir
> > > > > > .bootlin.com%2Flinux%2Fv6.0-
> > > > > >
> rc7%2Fsource%2Fdrivers%2Ffirmware%2Fimx%2Frm.c%23L24&amp;data=3D
> > > > > > 0
> > > > > >
> 5%7C01%7Cpeng.fan%40nxp.com%7Cbe679e9a409a48b834b908daa015d92
> > > > > >
> c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637998312946913
> > > > > >
> 710%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> > > > > >
> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D
> > > > > >
> JDRvoDGGgEiSmbhj3410V2DNxamZbDmMS0U2GvBnI74%3D&amp;reserved
> > > > > > =3D0
> > > > > >
> > > > > > > +
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 priv->rproc->state =3D RPROC_DETACHED;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 priv->rproc->recovery_disabled =3D tru=
e;
> > > > > > > +
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 /* Get partition id and enable irq in =
SCFW */
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D
> > > > > > > +imx_sc_rm_get_resource_owner(priv->ipc_handle,
> > > > > > priv->rsrc_id, &pt);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 if (ret) {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "not able to =
get resource
> > > > > > > +owner\n");
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > +
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 priv->rproc_pt =3D pt;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 priv->rproc_nb.notifier_call =3D
> > > > > > > +imx_rproc_partition_notify;
> > > > > > > +
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D
> > > > > > > +imx_scu_irq_register_notifier(&priv->rproc_nb);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 if (ret) {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(dev, "register sc=
u notifier
> > > > > > > +failed.\n");
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > +
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D
> > > > > > imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED,
> BIT(priv-
> > > > > > > rproc_pt),
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 true);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 if (ret) {
> > > > > > > +
> > > > > > > +imx_scu_irq_unregister_notifier(&priv->rproc_nb);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(dev, "Enable irq =
failed.\n");
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > +
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > > > > =A0=A0=A0=A0=A0 default:
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > > > > =A0=A0=A0=A0=A0 }
> > > > > > > @@ -803,7 +905,7 @@ static int imx_rproc_probe(struct
> > > > > > > platform_device
> > > > > > > *pdev)
> > > > > > >
> > > > > > > =A0=A0=A0=A0=A0 ret =3D imx_rproc_clk_enable(priv);
> > > > > > > =A0=A0=A0=A0=A0 if (ret)
> > > > > > > -=A0=A0=A0=A0=A0=A0=A0 goto err_put_mbox;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 goto err_put_scu;
> > > > > > >
> > > > > > > =A0=A0=A0=A0=A0 INIT_WORK(&priv->rproc_work, imx_rproc_vq_wor=
k);
> > > > > > >
> > > > > > > @@ -820,6 +922,8 @@ static int imx_rproc_probe(struct
> > > > > > > platform_device
> > > > > > > *pdev)
> > > > > > >
> > > > > > > =A0 err_put_clk:
> > > > > > > =A0=A0=A0=A0=A0 clk_disable_unprepare(priv->clk);
> > > > > > > +err_put_scu:
> > > > > > > +=A0=A0=A0 imx_rproc_put_scu(rproc);
> > > > > > > =A0 err_put_mbox:
> > > > > > > =A0=A0=A0=A0=A0 imx_rproc_free_mbox(rproc);
> > > > > > > =A0 err_put_wkq:
> > > > > > > @@ -837,6 +941,7 @@ static int imx_rproc_remove(struct
> > > > > > platform_device
> > > > > > > *pdev)
> > > > > > >
> > > > > > > =A0=A0=A0=A0=A0 clk_disable_unprepare(priv->clk);
> > > > > > > =A0=A0=A0=A0=A0 rproc_del(rproc);
> > > > > > > +=A0=A0=A0 imx_rproc_put_scu(rproc);
> > > > > > > =A0=A0=A0=A0=A0 imx_rproc_free_mbox(rproc);
> > > > > > > =A0=A0=A0=A0=A0 destroy_workqueue(priv->workqueue);
> > > > > > > =A0=A0=A0=A0=A0 rproc_free(rproc);
> > > > > > > @@ -852,6 +957,7 @@ static const struct of_device_id
> > > > > > imx_rproc_of_match[] =3D {
> > > > > > > =A0=A0=A0=A0=A0 { .compatible =3D "fsl,imx8mm-cm4", .data =3D
> > > > > > &imx_rproc_cfg_imx8mq },
> > > > > > > =A0=A0=A0=A0=A0 { .compatible =3D "fsl,imx8mn-cm7", .data =3D
> > > > > > &imx_rproc_cfg_imx8mn },
> > > > > > > =A0=A0=A0=A0=A0 { .compatible =3D "fsl,imx8mp-cm7", .data =3D
> > > > > > &imx_rproc_cfg_imx8mn },
> > > > > > > +=A0=A0=A0 { .compatible =3D "fsl,imx8qxp-cm4", .data =3D
> > > > > > &imx_rproc_cfg_imx8qxp },
> > > > > > > =A0=A0=A0=A0=A0 { .compatible =3D "fsl,imx8ulp-cm33", .data =
=3D
> > > > > > &imx_rproc_cfg_imx8ulp },
> > > > > > > =A0=A0=A0=A0=A0 { .compatible =3D "fsl,imx93-cm33", .data =3D
> > > > > > > &imx_rproc_cfg_imx93 },
> > > > > > > =A0=A0=A0=A0=A0 {},
> > > > > > > --
> > > > > > > 2.37.1
> > > > > > >
