Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BAB5FD96B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJMMoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJMMod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:44:33 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE3EFF8D8;
        Thu, 13 Oct 2022 05:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2r2cbru4wHr4NXGGOQPvoTm8dil+EXMMaERn+hb/ud4MwN2/YAsOqzLlwsFYxBJu1TyNHFRFP6+uCbu7cWHR/H8gbipcL6dJFHUDC8dCBRa6Obitvzxh+lURwK8LArI4vWrthvFDwcXaS2GxcXjTGNPFdk+KkXhDQ/wT+7tHh3CbEarZypdyGdBH+Y1yTsxF3R1FmHaOuZ+yqgz8wkIgKSAvjb7x0a8vMI3Mgr9RBPqrsTfx8KlJgpE3TLxF15nXnyNMsVynSZqnVI8qQ4G/gdDQxiyp7DQBKo4ELtWCbKppoeHdTEEZJ8/K5iJjDwzrZlH6K+ZGSQ6gWqcPNsgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3QisCS6qZ8nxpD6Fs5kM6OlcRylzt1DckciUoWXNmE=;
 b=c2JfWFJGuHM7OO3wAQuxmaffNmWtqaGZdB+6hR2+PGHVuDEz5Is3JGB0DdraKldrZ4Ip2xXHAIz3JBSKbpHBBIAq2EwE1wa2kT3hoWxYzZ4gmZAgKikVnd5GfTdtXPJ2MGuJ9nbWN3ulkIlHE/LWMbyHraFvjrTsMRW+iNPIpFDojuB+6XQ6uhAFz9SKVBfYP5iyWYn99C09fgA+BsBx0YxkYRWcjYz8a5r1SVpDBrFUr87tpJfbyNp5adEu9k67WiRxYjFrU1DO7/tPulgfCxCeDj3z4b4dvDGFiaBzIuSnU/r5pSQKBYqFYvW92qy4lE5fswmGAtagg8X88HPbHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3QisCS6qZ8nxpD6Fs5kM6OlcRylzt1DckciUoWXNmE=;
 b=IbZMmcugS1hZkthTdtsV8OUba32CPMEiPjElX+LJ0QPAggpETl28sl/iffrg1XBwv9mG6SVq1vkeFB44PUa5w8m4ukIeg1mR8xdY+XI4PvV6ZDsbX89dL9Spy5nhOvQ/wtNNqE/7Ai4rYzz0PX6azNyUVDEPRynYDGmde5vK0cA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 12:44:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Thu, 13 Oct 2022
 12:44:28 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] remoteproc: core: avoid duplicated rproc-virtio.[x]
 device
Thread-Topic: [PATCH] remoteproc: core: avoid duplicated rproc-virtio.[x]
 device
Thread-Index: AQHY3v+dFOn8qSfXn0WnZQ84dnwr864MRGoAgAAAPRA=
Date:   Thu, 13 Oct 2022 12:44:28 +0000
Message-ID: <DU0PR04MB941741503263A70DA7606DED88259@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221013123214.750320-1-peng.fan@oss.nxp.com>
 <994c01b3-253c-9cc1-1a15-4f17226c2f7d@quicinc.com>
In-Reply-To: <994c01b3-253c-9cc1-1a15-4f17226c2f7d@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM7PR04MB7157:EE_
x-ms-office365-filtering-correlation-id: cbe23fb5-9866-4d54-f518-08daad18aab9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DBrHvl2OqmoYtrL5WYy8cPFCWkDuYs2LlZCRPqVCuI/tKISRprXq/WR4vOvFlIA/ZVeJzoXQ2XyllRBTE9JL/ytMsgUE3tE+X9+ARITrNpfcAD1pOd5YKzWnULRurgJIUlXa3yCCbpMIE39iFs90FbimkODZe85mldI6uBXIiTA4k/k8pmrAlox4+HOePdsgqi1k9fTWo/b0bHRVQz1lwM9zZWvrC+CluZUNhVoXGxzCsXq/OpluQXUPHXMuilFqSvhkfrfIQKCf0RVdLnI1wcUI/U9CW0X5ue1E/Jq7X5Ei/sqTN5YMtHoLI5mAgqGKkghEwbSA0TmMgoB1eXM4FEGokNl+a9D1IEXy7hQyOsBg0PR9cG4X6S0H299ftlvEgKAq0db8eBSyNhysyoAMwB/dWnm2V4c62X5L31ytKZCQ8OW7mXI+hzqBMP2l0e5Bt1AmhffC9+Iotys1tACp6GIA01CDcn5xoNp5HEBBYBpgOA9ywU3egNrTc8R17LkdNzDoYmLWI+VcSPjlVlAkexiM6Ux4ZQc+QpVc/AONjdlNfwZr73QCxSo3YXtg3JHClh4A5syEpaM+9yUJbLIAHaIlgSGKynQlCG3Ksf05vTeWm3XY23VRj3r69yJjjR5JRkxL29vy3PUYV/k58R7bkg6YMHuLDj8QbvZDYjrTpcmQq+b7UoTFtjP/900YbpeA8ZuFYTxvm7njuw3BQBM2M44SAmlkGX1VEAVboxLyA9TX5ZaxW0ZGjd+fPVk+38Nv8G2tg7ikKsGHa+V5JsOPmnIzyV5w5WEy3rVYLQzWfas=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(55016003)(966005)(33656002)(6506007)(44832011)(7696005)(186003)(8936002)(5660300002)(9686003)(86362001)(52536014)(41300700001)(26005)(2906002)(71200400001)(478600001)(64756008)(83380400001)(76116006)(122000001)(38100700002)(110136005)(8676002)(66476007)(66446008)(53546011)(66946007)(66556008)(316002)(38070700005)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c+BfbJ9+txQvo8fekNuzz1j87Q+Ag5sY1FsMZGICHz6g2XOD6aPtqNt/LCxC?=
 =?us-ascii?Q?O+oPKTStODukXoYFvNWjN0ab2Ya9gqmu6Q9cnGkOlUhftvgXYShJRNZbgAaD?=
 =?us-ascii?Q?tAGlbCFWn8LwJ3/+ftCltseP7P/IBWTtu0MzTVUYWCfY86a4toKHDY67/km+?=
 =?us-ascii?Q?dENBb9oNPvIH08VZMJqiju4T1AYnmj/Wkz2iUz6co3kvetgADbpm4EvHPeGG?=
 =?us-ascii?Q?pYp1XIrD923Bj59S6eUOVjJXn6otYkdQ28x/xjw+pKGsuMybN93NRVsyztLr?=
 =?us-ascii?Q?EtNjKWz1zqWbRRZMqleatLF19QLyaoaKEHOwGjvavQs41P0KwdLV86LAySNj?=
 =?us-ascii?Q?D0os8s6jIXdWK8fJ6M5XZHfxyNZAVxJ7A0I8NHOLRocG0ub5Yzr8lmFgcMSi?=
 =?us-ascii?Q?QuQOAYsIOOeqyiS9cYdiIZ3U9LRMxARcRZgEAICFS98Xu0SoC672WVz6qdOC?=
 =?us-ascii?Q?xeLonBBBXW29dIqtLCcQEv8x3FoDWyNSe8SmHU/6Moyey35Zyy1HUcyGkWM1?=
 =?us-ascii?Q?TZEwJkqbBtqPef8uo7VOXXuUYXYMUZ4UbeLxBq+YhGjc8ilAGsLGc+1spT76?=
 =?us-ascii?Q?74S4DsdskNAjQBY4mkD1tC7hEPXzcqDC062E0dv4MUGL8uWaxG9bsihM8dBv?=
 =?us-ascii?Q?e5bBJXlyHk1QWfnTyzio7AQ4R5pJhDyYzSwQZKYXIW0tIRJYb9x3djzsYLqu?=
 =?us-ascii?Q?AVZZ3/zh77hjoVTl+lyOq5C/IOHK/WN6diEW8ACmPCFukrXpcxF6tMSIJ6ED?=
 =?us-ascii?Q?rTd0Lk4tKAK950UUqe45RaRhiZc4X4EAsr3gFIbMKLfMn63EM2HVYai3M9T4?=
 =?us-ascii?Q?UVZQUDCKZCqtPkQQs8xZ+azLsqdfaBNpdlKejAePHr+9iWP7cdhC+haNxM5E?=
 =?us-ascii?Q?R8p5yqtLmrcjJAvWWH2lQ8qAe+90tQNtzod6b4IAzLWky6SYcgXVVYr55FMh?=
 =?us-ascii?Q?LzAEXqOl33sMhh/ianuLOVVqtiEtgiB7cz5UoeLvtu8zzOHnTYsQvPaRmAkF?=
 =?us-ascii?Q?844Im4rImTLO4t1jHh8W01bjm/umd+XpNu80N/1z7mhVCqJlbmOmcIA1qY3I?=
 =?us-ascii?Q?jgI/YEcTiMl9dcunT3ITQProvoV9p8HaRZIE98GqG0kAC3jk3jySS7tOfVS7?=
 =?us-ascii?Q?mbjUGYLk/F1ZMXCwrM6qr0GNYrLKpKPo+moYD4J1Qo0/fUtv7YM1sDRhyn0g?=
 =?us-ascii?Q?UHwQWhCyVR1ASM8GEVBAR0cFDa+QglxjceoxspFjkIb9wW0EsbV4FjG1rykI?=
 =?us-ascii?Q?yXlPv2nOxjgnGIokA5/QiDrWp2JHzj/OKzognCW25QDdHsJ8FxxhSE3J/IbH?=
 =?us-ascii?Q?q9q8mGToBjlFgB9NE4KwRRoBQhQaLCfoGr4s9ywrUXejNP31eLo30G0RNNuY?=
 =?us-ascii?Q?ATNIHSONZQNuoakZI/LPYi0gpdhcwg3vy34r5NXywsRG+LGKTeVymH611i0S?=
 =?us-ascii?Q?17cnIdnUut8rQEEs4B/ns7Mxr6LiAirDknmbbMs6thLMe3m0Eao4QaUiWrRC?=
 =?us-ascii?Q?3AKf8yyYG1vMcsobnEic8DJNrKEzQDclDJUoFsSVtN8F7YX1Y5qfijuaZPve?=
 =?us-ascii?Q?paubvAlEJ6Q6Po7G00E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe23fb5-9866-4d54-f518-08daad18aab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 12:44:28.1324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rr9JdtsLOOaD3iAsCLfxxDWY/k9kCNKE2thiqjUNMs8elJKptxU60bebliKcWKq/F95bpByFk+Jis92F8b0RyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7157
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] remoteproc: core: avoid duplicated rproc-virtio.[x]
> device
>=20
> Hi,
>=20
> On 10/13/2022 6:02 PM, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > When there are multiple remoteproc cores(i.MX8QM has dual CM4), there
> > will be duplicated platform device created. When 1st CM4 rproc got
> > probed, rproc-virtio.0 was registered. Then 2nd CM4 rproc continue
> > register rproc-virtio.o will report failure.
> >
> > So use PLATFORM_DEVID_AUTO here. Then the kernel log will has such:
> > rproc-virtio rproc-virtio.1.auto: registered virtio0 (type 7)
> >
> > Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for
> > the remoteproc_virtio")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V1:
> >    I think this issue will happen when more than one rproc, saying CM4
> > + DSP, or CM4 + CM4.
> >    I thought to add a index to rproc, then use
> >    'rproc->index * rvdev_data.index' as the id, but seems a bit complic=
ated
> >    compared with use PLATFORM_DEVID_AUTO.
> >
> >
> >   drivers/remoteproc/remoteproc_core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> > b/drivers/remoteproc/remoteproc_core.c
> > index 8768cb64f560..03a26498e879 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -509,7 +509,7 @@ static int rproc_handle_vdev(struct rproc *rproc,
> void *ptr,
> >   	rvdev_data.rsc_offset =3D offset;
> >   	rvdev_data.rsc =3D rsc;
> >
> > -	pdev =3D platform_device_register_data(dev, "rproc-virtio",
> rvdev_data.index, &rvdev_data,
> > +	pdev =3D platform_device_register_data(dev, "rproc-virtio",
> > +PLATFORM_DEVID_AUTO, &rvdev_data,
> >   					     sizeof(rvdev_data));
> >   	if (IS_ERR(pdev)) {
> >   		dev_err(dev, "failed to create rproc-virtio device\n");
>=20
>=20
> Looks to be same as
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Flkml%2F1665628087-20829-1-git-send-email-
> shengjiu.wang%40nxp.com%2F&amp;data=3D05%7C01%7Cpeng.fan%40nxp.c
> om%7C668b13ed67d24714d51008daad185d69%7C686ea1d3bc2b4c6fa92cd
> 99c5c301635%7C0%7C0%7C638012617398936051%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DBlv30z3AYk6v3GTS4aEizM62v2
> zrTmK1rDFAdlxagB8%3D&amp;reserved=3D0

Ohh! Duplicated effort, I should check list before working on this (:

Thanks,
Peng.
>=20
> -Mukesh
