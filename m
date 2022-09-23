Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5C85E749F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiIWHNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiIWHNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:13:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60064.outbound.protection.outlook.com [40.107.6.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4221296B5;
        Fri, 23 Sep 2022 00:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uvc9X26qBZPkOdl3qOj4YCY7bOFIqAECcgai7gcTF6s5rgGFPj/KnGCA/Dfzni0zFvERwz3iraE+tU8qAHn9S1sNlOziK/RkP70XAX3O6Qc8MWJqbi+hiIpyKaxnMEPpwfkKzNV2BK7lK0XkvGcONysspGhetaZbvUW7Hg55vUNCHAi+EF8SFmALxUObdkShRRGfkFPjToBmKc/CzatuTS8vfjKduqApoWcgsT3WhazZDNRmTYcNZWuPi/KqElNmYi+IRGdrfs9ouri6f00aIPYScZTZIomNhrdDXmFImoIqCOla6doGJA4TaQqwBUAnIymyuLKuUWrldd7NR+3tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2MkzQLO6uSKTyQ3y/+gY0hnDI4pyjgG2tkegNyVIGM=;
 b=XJLxNxSwRZ1sohcrsDsP7c9UV7VTcOqjTs4tp4H3TkpSO4EDO/aUnfvdzVjCEJ5MlfpOcRxFJk7um6vfYPtIEHLcZNBzuXm/zEqgUPsNvhf0xV5OERl34b8UyRWxfsECvm0O9bN5qQNz3xLrrjVbFz8/DX/9frS++Ir+ksN/XyLFhcIrRMP2mPWuZK5hck2Gx3FEHIIR/SdPMy0ox5avpkJbK1pVxJJq2gq1DG+Rq+eWesCLKGAuUnnd61qBSvUi43gkq5vhoOOmFhkZEEVL5aDo9T+Zw9wy+ubBBUNokUIezHRIolSPPd4S3cUD9bZvxBuNuMzcRiL2Jw5OfaWShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2MkzQLO6uSKTyQ3y/+gY0hnDI4pyjgG2tkegNyVIGM=;
 b=AxJtEZHrCX8+B6jHxSJDtUeiDe3/85ERk7z0l1JzDEDhHoc++5VuiFLwxtFs/Zl5LWAAZAPBstt4LlRwyIWAzMzIr0X+thLGWRZNyVIkDnsMQmkVXjSLX/Tf3GxzozYl4cwfDMM3dajVYYWQdWsiPK4MtSpKAoFFycccTWZwCUM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7179.eurprd04.prod.outlook.com (2603:10a6:10:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Fri, 23 Sep
 2022 07:12:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.018; Fri, 23 Sep 2022
 07:12:57 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     TingHan Shen <tinghan.shen@mediatek.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "Project_Global_Chrome_Upstream_Group@mediatek.com" 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dnojiri@chromium.org" <dnojiri@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>,
        "weishunc@google.com" <weishunc@google.com>
Subject: RE: [PATCH v2 4/9] remoteproc: mediatek: Support probing for the 2nd
 core of dual-core SCP
Thread-Topic: [PATCH v2 4/9] remoteproc: mediatek: Support probing for the 2nd
 core of dual-core SCP
Thread-Index: AQHYu9+KPWXRQoq9AE6UEWxurIDkea3VcYyAgAyedWWAAFgEAIAEObIAgAYdNdA=
Date:   Fri, 23 Sep 2022 07:12:57 +0000
Message-ID: <DU0PR04MB941754CF68489CBC14E777D588519@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220829194247.GC2264818@p14s>
         <20220908111757.14633-1-tinghan.shen@mediatek.com>
         <CANLsYkx6kXk8u_ajFbnhdWTkZBLtrq_z02jryLBSVH0x--_ZFw@mail.gmail.com>
         <a5ecd1dd567ca58807b289f2488d933f27e087dd.camel@mediatek.com>
         <CANLsYkxPdWErZErgGukvsMWcaGSRDpoKEkMeukvFi=BVTdpm8A@mail.gmail.com>
 <185edd1443dc85ea817027f15b7f90b1651c550f.camel@mediatek.com>
In-Reply-To: <185edd1443dc85ea817027f15b7f90b1651c550f.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB8PR04MB7179:EE_
x-ms-office365-filtering-correlation-id: 2b4e5efe-4aa0-40a9-fb41-08da9d330a96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fQpQh2ik/dJDJqNADmR/k4c+359dnnU7RB8zz31yHPcEwIb7pUYsqY2KQ/xLydgx3wO2DBqjpF1TgwnCOb16s3EN1m42ApFldc1htDHVHv7jHtOh4Oy1pjnXlMtpIaxtQll5URZUXaL2YtseHOcKdoA1Hg5M8f9ko+dzSBeG8HhamDlaoHkPwc6ZVH1pidgrRlFx6DqA3dub4it9hg5Z9jCIegJ2fR8ysqSJlIyUwXUG8/oqLYHrt9KZUf3QFSvZCggor9P7sGdZ0uzy4iO54Dg60FFLKNd8wPlnBkkhUtcRAy/6sQQTHLz/HvmG1P03kydv8obnlJvS4z85FO1mJ9XX/0dY7DYRhEXmkEyCp1LZjUlyZ1FeTCBD0/aZ4w0yRr/UFDqjezY5aRrlUGxng6+m+Tr1hq3vV8e1OcCsnrHgg+AwxYtAaMrI4g8708VDvACUX7N4JjihENq27sRCOy6HpK0Th7EOBq0mHow9H51ewVQ4LvmrY+jyqW7uIhaeJEVR0/iuCOeH0fzBaooKKp0+WtWlpkRrjlkc8ad0Jv00XCwDyDF/fVmltIjd4Mqv/DHcMF4UB3i4Yjwo0qKDxz64cjGRHndSxJ92Cv36u4i/N+9jEfpW0pl7tX1cIF0+FS9drFQ90k//gx78d/pzL+h/9sKgpYTv/4caZQOtzDJMCKzuiPVKej8nxrWYokmGlfGrltyA87Al6ZsV9VONfn6yKPGCUc4QcJktr6iWcBAdUm0BdHNv3JV/JHrMaqsRM+FLoabBvuQ4O1RDWrR5lnI6Rp52GbAahyMqzrpcJ0M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(110136005)(4326008)(26005)(54906003)(76116006)(52536014)(66446008)(186003)(2906002)(66946007)(316002)(7696005)(966005)(9686003)(71200400001)(8676002)(478600001)(66556008)(66476007)(45080400002)(55016003)(38070700005)(86362001)(6506007)(64756008)(33656002)(41300700001)(38100700002)(44832011)(5660300002)(7416002)(8936002)(122000001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8lMiR/PAqUyiCFqZeVC9oDcOXAjlMRaPjHKU57VN6kdnVxQQuK2OOnBSYWtf?=
 =?us-ascii?Q?vQdDb0V8qLZlJQOTuR4K2ARrD7wDdnLWWQN3gMOU3tbdd3ZuK3wREmzwzU+0?=
 =?us-ascii?Q?r3AyWz4ZvoyPsYhE4jdVyi5csofeYvgAwS4MxGl1qkuT6D70dSTt7KE6ZIam?=
 =?us-ascii?Q?QL+CCcFvMnRTszD9a//EO6g7gHxOLvYJy6Z+FbT/LxbJTKk5Nz2++LycOvl+?=
 =?us-ascii?Q?lGTXmzjHEMWWBatUdCCN22Yd1SLisjRsNYKT68lr7MTbuPXOsbTGiqMlHGwU?=
 =?us-ascii?Q?Vx8QB1T9TA04HhpVWOk9rOdo8OKD8QZTHgb4HRpeZd9SRG3Jb/RtzSL3lnt+?=
 =?us-ascii?Q?tMEpscv+RuBPDneUlu3c3GQlOJ9GPMHirx+6Js+CgmITB8K/JIXUP/WV1Eld?=
 =?us-ascii?Q?WGPmR8SA/DcLkZSxht3Bn8GkO69qrhKpBUOZzxawYgIqjvjQXOj5zJV0ymoi?=
 =?us-ascii?Q?Ijo/Hpds9bTY9k7H2URkcJKwbNEhr5IPSgKs97f7wUNg58kamIgtfn2LltiZ?=
 =?us-ascii?Q?/BeZ4ct4Q3xuCULY1/Tuj0bV9CAXDCX6cX+Kcjho/RU7IOeU9a10Aam/B11P?=
 =?us-ascii?Q?RglQPxe6mQ8TxlFBNCcxXLUSSxb7fpvwEGep487/PgVzc94FdxH8REggiTll?=
 =?us-ascii?Q?F4gEUr1wyW3EbE7RwbLLm0wV9H8q3er5nPL0bSCmWOeGp41bwcnbuzJl/c5K?=
 =?us-ascii?Q?JT5FPhJn2CXCMX8DAHOuwh4az8auXiTLr5KgKNp34uFXdnOxqBCFu4rZzXXn?=
 =?us-ascii?Q?9GxaOvAIj7YSwlmcK1jJHuo0s2QirWpUfwlcB61noRVNDL8G9pj0rt4MbP+Q?=
 =?us-ascii?Q?LpHTC2RPMYyY2kOLJXly88aP7V28m1MOMGps9PWApkgaG1x6FHPzJZwh5Ucm?=
 =?us-ascii?Q?LvZcz1110upsT63eY4vKEA7kIHdqNoMZQc28NQ8bwkFPYsFwNt6AX/qu0UxF?=
 =?us-ascii?Q?56MKo1iE42HJJ+CpoJO7n66dn2Gek2NScbL9vk0lsX4M2bf54FPH1Tw7q4+1?=
 =?us-ascii?Q?+pKcP+xbcxAffgyzvQlnBVKmH9/Wor/XHFzELZiFVYKO401hNwkU4EHFTvBb?=
 =?us-ascii?Q?yPbyM2WNYvjnoFeX2xqHLI5laKy2I2VIzfkj2y+BhZF8K/rAVL85mcxdA9Gm?=
 =?us-ascii?Q?pusFjgY0bozIKmSrvK+k9/UY5qBc/+3xpEWEhuzlYY/PyUgiuZsxKbmhzR2H?=
 =?us-ascii?Q?7U2Oaf1ZHyeSYjohtj7Wz9j7qggWP+jhXL6GZS7dfEJRWk2dVAv7/nZdXd9Y?=
 =?us-ascii?Q?jTbi8qUfmOBSbhtEG/tCv/+faFILX+pI0FqKBNRfhWX3zP8/R0goFFDTe//N?=
 =?us-ascii?Q?FK7jRScF/NGTz2Q/NajJWPDqcMpR4cDj0lzrI17DjEmSr8N1XuiRD6fGhfKz?=
 =?us-ascii?Q?V713VsSJ3mHblM/wI3C4mC/10YLIkGWGmGhWG/0xrGIvsFlbkNMAxz3naRGH?=
 =?us-ascii?Q?cXgIXyleHpvkeD2nA0qfKllQHGhQByQP5nvFKDCNk2oU3ar1bh+5uEPQUWy0?=
 =?us-ascii?Q?CzsCpXMa3B2xJKpebTZ0bLmyRyFR0JaHvnd+r3sLrfMUcQvp12r7LofO7Zdz?=
 =?us-ascii?Q?d60c12I4DHAcY81DGe+imHzD77Rv9nXxKPBTQ3Na?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4e5efe-4aa0-40a9-fb41-08da9d330a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 07:12:57.2750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7QEXag4eqNAhf67QYJM8gpH+IPi0N38+W5ZBL1CrKXHxMLOvyclkY96LRuGT90JcTaTDBEmiPd43RQ6JZsfWSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7179
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v2 4/9] remoteproc: mediatek: Support probing for the
> 2nd core of dual-core SCP
>=20
> On Fri, 2022-09-16 at 11:15 -0600, Mathieu Poirier wrote:
> > On Fri, 16 Sept 2022 at 06:00, TingHan Shen
> <tinghan.shen@mediatek.com> wrote:
> > >
> > > On Thu, 2022-09-08 at 14:58 -0600, Mathieu Poirier wrote:
> > > > On Thu, 8 Sept 2022 at 05:21, Tinghan Shen
> > > > <tinghan.shen@mediatek.com>
> > > > wrote:
> > > >
> > > > > Hi Mathieu,
> > > > >
> > > > > > > The mtk_scp.c driver only supports the single core SCP and
> > > > > > > the 1st core of a dual-core SCP. This patch extends it for th=
e 2nd
> core.
> > > > > > >
> > > > > > > MT8195 SCP is a dual-core MCU. Both cores are housed in the
> > > > > > > same
> > > > >
> > > > > subsys.
> > > > > >
> > > > > > s/subsys/subsystem
> > > > > >
> > > > > > > They have the same viewpoint of registers and memory.
> > > > > > >
> > > > > > > Core 1 of the SCP features its own set of core configuration
> > > > > > > registers, interrupt controller, timers, and DMAs. The rest
> > > > > > > of the peripherals in this subsystem are shared by core 0 and
> core 1.
> > > > > > >
> > > > > > > As for memory, core 1 has its own cache memory. the SCP SRAM
> > > > > > > is shared
> > > > > >
> > > > > > /the/The
> > > > > >
> > > > > > > by core 0 and core 1.
> > > > > > >
> > > > > > > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > > > > > > ---
> > > > > > >  drivers/remoteproc/mtk_scp.c | 22 ++++++++++++++++++++--
> > > > > > >  1 file changed, 20 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/remoteproc/mtk_scp.c
> > > > >
> > > > > b/drivers/remoteproc/mtk_scp.c
> > > > > > > index 3510c6d0bbc8..91b4aefde4ac 100644
> > > > > > > --- a/drivers/remoteproc/mtk_scp.c
> > > > > > > +++ b/drivers/remoteproc/mtk_scp.c
> > > > > > > @@ -23,6 +23,10 @@
> > > > > > >  #define MAX_CODE_SIZE 0x500000  #define
> > > > > > > SECTION_NAME_IPI_BUFFER ".ipi_buffer"
> > > > > > >
> > > > > > > +#define SCP_CORE_0 0
> > > > > > > +#define SCP_CORE_1 1
> > > > > > > +#define SCP_CORE_SINGLE 0xF
> > > > > > > +
> > > > > > >  /**
> > > > > > >   * scp_get() - get a reference to SCP.
> > > > > > >   *
> > > > > > > @@ -836,6 +840,7 @@ static int scp_probe(struct
> platform_device *pdev)
> > > > > > >     struct resource *res;
> > > > > > >     const char *fw_name =3D "scp.img";
> > > > > > >     int ret, i;
> > > > > > > +   u32 core_id =3D SCP_CORE_SINGLE;
> > > > > > >
> > > > > > >     ret =3D rproc_of_parse_firmware(dev, 0, &fw_name);
> > > > > > >     if (ret < 0 && ret !=3D -EINVAL) @@ -851,8 +856,16 @@
> > > > > > > static int scp_probe(struct platform_device *pdev)
> > > > > > >     scp->data =3D of_device_get_match_data(dev);
> > > > > > >     platform_set_drvdata(pdev, scp);
> > > > > > >
> > > > > > > +   ret =3D of_property_read_u32_index(dev->of_node,
> > > > >
> > > > > "mediatek,scp-core", 1, &core_id);
> > > > > > > +   if (ret =3D=3D 0)
> > > > > > > +           dev_info(dev, "Boot SCP dual core %u\n",
> > > > > > > + core_id);
> > > > > >
> > > > > > Why is the DT property "mediatek,scp-core" needed at all?
> > > > > > Since the
> > > > >
> > > > > compatible
> > > > > > "mediatek,mt8195-scp-dual" has already been defined previously
> > > > > > in this
> > > > >
> > > > > patchset,
> > > > > > initialising the second core, if present, is a matter of
> > > > > > looking at the compatile string.
> > > > >
> > > > > This idea of identify cores by the compatible looks workable.
> > > > > I'll update this series at next version.
> > > > > Thanks!
> > > > >
> > > > > >
> > > > > > > +
> > > > > > >     res =3D platform_get_resource_byname(pdev,
> IORESOURCE_MEM, "sram");
> > > > > > > -   scp->sram_base =3D devm_ioremap_resource(dev, res);
> > > > > > > +   if (core_id =3D=3D SCP_CORE_1)
> > > > > > > +           scp->sram_base =3D devm_ioremap(dev, res->start,
> > > > >
> > > > > resource_size(res));
> > > > > > > +   else
> > > > > > > +           scp->sram_base =3D devm_ioremap_resource(dev,
> > > > > > > + res);
> > > > > > > +
> > > > > >
> > > > > > This looks very broken...  For this to work you would need to
> > > > > > have two DT entries with the "mediatek,mt8195-scp-dual"
> > > > > > compatible properly, one with "mediatek,scp-core =3D <&scp_dual=
1
> > > > > > 0>;" and another one with
> > > > >
> > > > > "mediatek,scp-core =3D <&scp_dual0 1>;".
> > > > > >
> > > > > > Which is also very broken...  Here you have a binding whose
> > > > > > first
> > > > >
> > > > > argument is a
> > > > > > reference to the core sibling while the second argument is a
> > > > >
> > > > > characteristic of
> > > > > > the current core, which is highly confusing.
> > > > > >
> > > > > > I suggest what when you see the compatible binding
> > > > >
> > > > > "mediatek,mt8195-scp", a
> > > > > > single core is initialized.  If you see
> > > > > > "mediatek,mt8195-scp-dual", both
> > > > >
> > > > > cores
> > > > > > are initialized as part of the _same_ probe.
> > > > > >
> > > > > > If the above analysis is not correct it means I misinterpreted
> > > > > > your work and if so, a serious amount of comments is needed
> > > > > > _and_ a very
> > > > >
> > > > > detailed
> > > > > > example in "mtk,scp.yaml" that leaves no room for interpretatio=
n.
> > > > > >
> > > > > > I will stop reviewing this patchset until you have clarified
> > > > > > how this
> > > > >
> > > > > works.
> > > > > >
> > > > > > Thanks,
> > > > > > Mathieu
> > > > >
> > > > > There's one problem of initializng the CORE1 using the same probe
> flow.
> > > > > The register space of CORE0 and CORE1 are overlapped in the devic=
e
> node.
> > > > > Both cores need to use the 'cfg' registers defined in scp yaml.
> > > > > The devm_ioremap_resource catches address overlapping and
> > > > > returns error when probing CORE1 driver.
> > > > >
> > > >
> > > > That is exactly why I suggest to initialise both cores within the s=
ame
> > > > probe() function.
> > > >
> > >
> > > Hi Mathieu,
> > >
> > > I'm thinking about how to initialise in the same probe() function.
> > > I'm wondering if this implies that using one scp driver to initialize=
 2 cores?
> > > If it is, I assume the dts descriptions for both cores should be cont=
ained
> in one node.
> > >
> > > When there's one node for both cores, it looks like that there is a
> problem of
> > > using dma_allocate_coherent(). Each core has its own reserved memory
> region.
> > > When there's only one device for both cores, it's not able to identif=
y the
> memory region
> > > by the device parameter of dma_allocate_coherent().
> > >
> > > Is it acceptable to consider manually allocating core 1 device in the
> probe() when probing core 0?
> >
> > Look at what Suman did for TI's K3 R5[1] and DSP[2] platforms.
> > Reviewing the bindings for both platforms will also give you a good
> > idea of how things work.
> >
> > [1].
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furlde
> fense.com%2Fv3%2F__https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv6.0-
> rc5%2Fsource%2Fdrivers%2Fremoteproc%2Fti_k3_r5_remoteproc.c*L1683_
> _%3BIw!!CTRNKA9wMg0ARbw!zVcjdLSfKYGO5YQMNGqq339mle8u0VdULX3
> 0z0XV4vo3vCb9Wy-
> w5ixOTmzbv1akubM%24&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7
> C2cf76b2f15544cf3d06308da9a23f00a%7C686ea1d3bc2b4c6fa92cd99c5c301
> 635%7C0%7C0%7C637991776400238974%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C3000%7C%7C%7C&amp;sdata=3Ddz0FlQQmKI4C67XCX%2BZ6%2Bin%2Btq
> 2DEWLb5YA%2FxGLOxHc%3D&amp;reserved=3D0
> > [2].
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furlde
> fense.com%2Fv3%2F__https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv6.0-
> rc5%2Fsource%2Fdrivers%2Fremoteproc%2Fti_k3_dsp_remoteproc.c*L673_
> _%3BIw!!CTRNKA9wMg0ARbw!zVcjdLSfKYGO5YQMNGqq339mle8u0VdULX3
> 0z0XV4vo3vCb9Wy-
> w5ixOTmzbfE2dtBg%24&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7C
> 2cf76b2f15544cf3d06308da9a23f00a%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C637991776400238974%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C3000%7C%7C%7C&amp;sdata=3DYn7MOo2uoDOVRW47O1yq8W3c%2BYg
> G5URr7RdLKsmpLrk%3D&amp;reserved=3D0
> >
>=20
> Hi Mathieu,
>=20
> My plan is changing the dts as following,
>=20
> scp core 0 {
> 	// Keep current properties untouched.
> 	compatible =3D "mediatek,mt8195-scp";
>=20
> 	// core 0 properties...
>=20
> 	// Add a new property for multi-core scp.
> 	// if not present, it's single core.
> 	// if present and core id =3D 0, it's the main core, otherwise the sub
> cores.
> 	mediatek,scp-core =3D <0>;
>=20
> 	// add sub cores as sub node.
> 	// sub nodes can find parent by OF API.
> 	scp core 1 {
> 		// use the same compatile name as core 0.
> 		compatible =3D "mediatek,mt8195-scp";
>=20
> 		// assign id > 0 to sub cores.
> 		mediatek,scp-core =3D <1>;
>=20
> 		// core 1 properties...
> 	};
> };

Not know the HW arch, but this looks a bit weird, scp core 1 is
a sub node of scp core 0.

>=20
>=20
> The driver probe/remove behavior will be modified as below,
>=20
> scp probe() {
> 	// common init...
>=20
> 	// check core id to have different memory mapping flow
> 	if (core id =3D=3D 0)
> 		// mapping cfg, sram and others
> 	else
> 		// mapping sram
> 		// reuse the cfg paddr/vaddr from core 0

Oh, I understand why you need ioremap_resource, so core0/1 share
same register address space?

Regards,
Peng.
>=20
> 	// common init...
>=20
> 	if (core id =3D=3D 0) {
> 		ret =3D of_platform_populate(...)
>=20
> 		// boot core 0 and sub cores
> 		rproc_add();
> 	} else {
> 		// add sub core as sub device to main core
> 		rproc_add_subdev()
>=20
> 		rproc->auto_boot =3D false;
> 		rpoc_add();
> 	}
> }
>=20
> scp_remove() {
>=20
> 	if (core id =3D=3D 0)
> 		of_platform_depopulate()
> 	else
> 		rproc_remove_subdev()
>=20
> 	// remove core
> }
>=20
>=20
>=20
> Best regards,
> TingHan
>=20
>=20
>=20

