Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42AF74A06C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjGFPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjGFPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:06:49 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B9F10F5;
        Thu,  6 Jul 2023 08:06:47 -0700 (PDT)
Received: from pps.filterd (m0174676.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366CiEvq008270;
        Thu, 6 Jul 2023 15:06:38 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3rnum71awp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 15:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi8xDnS/BvPb8PyQjuNmrJPD70v98vBrYynX14lQqMHmaWGMpzlTwCgfl4B67YjOlKIEt0RMcVkOgPsjzL4frv+V6+p+kZovYA/I9hb6c36jTVhrFs/AsVYcx10Dlt8Hntweqh9OQctUBcHuG60rPuAdxy8OBzUCws+ao5RQBZ1ERvGMRdmvXtI7Dsx22zHKts4A29vOMj+afZ8aHS6yfNkCeiHShXP3I5TNotYLXkgYkeG8D9hwrzww/P29q+Tl8nEHMDJS7m+Cx+wVZ+BZvvADJaRUL2lP/lOM52ZhQfando36CA9W1cna0oOWGsWGJr5Z4Em++FtTYV85te4CVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AISgru6cTKmxVnw+OLToNl0Njtu3G9VbT7olLhz0zew=;
 b=M+AYDSOArIsWi4yLfvBGd/Kr3pjMkyezYjNQhx+gOvG8mBpgY7rFms9oJGBdY4FcU+9Sm4zzgLmfQILpd22VClximA9HZEnuvzoUT24m6ktf7OZnxX173qNrbuc2qA+SBHM3LLOwz08gTkOa0/XjDntE8nP1VywpYcK2Y2XaRsHXZjMVLueN0shHhojdGpzpbFrFMlUnDgRwz0RfZaUkynaGnlT7ozojMDLqHQUwh4DHIennhmld5SysPo3ZGg1QMpyouw36H73LXYwZFYv54jcefNhUEOp4oQF0E34uWN3VAWRps+xndkJwppEdpOPGne1xvLaSp6rf832o3oDmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AISgru6cTKmxVnw+OLToNl0Njtu3G9VbT7olLhz0zew=;
 b=nG4hG3P6yg6fvLTwVzv2J7SzljzzxQsbRs9Z8MS5krmRQC7NQhlNJkEbQsLDIEZ+Mup8n05y7xhANlQs76mWiNnxCewbie2oVl6DHm2TpGYZesQ2kAAip3fxbMiTdJYXFjaUSM0ii/uiBt82rlXrsv2qWEuHyYeiecs8wM8NsFmDYwa0Sy5s0dx0B6QgM4HyuylfgVsZvVuRo7ffYFSqQOTKZrg+jBKPmalJwS9GVF42AWpS4L+K0nrcOvsu0LLaP80ErfKLUsmGiYK+mERV8ZOyUU0gXdyfGf/QC7y4e58Qc/VYsnZWaPXsBL/ekR3wnNsvdYR8LE80YvE2xl7YCA==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AS2PR03MB10193.eurprd03.prod.outlook.com (2603:10a6:20b:5fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 15:06:32 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 15:06:32 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v3 2/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHZmJMVZdZ9jTlnl0a4bbb/rGp54K+n/cyAgAT4DICAAAk1AIAABrGA
Date:   Thu, 6 Jul 2023 15:06:32 +0000
Message-ID: <20230706150631.GA850348@EPUAKYIW0A6A>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <d388c7af3f72fd47baffe0de8c6fec8074cb483c.1686063941.git.oleksii_moisieiev@epam.com>
 <ZKKgD1QxF085kE+c@e120937-lin> <20230706140937.GA821831@EPUAKYIW0A6A>
 <ZKbS2jkl0R0Ul1a4@e120937-lin>
In-Reply-To: <ZKbS2jkl0R0Ul1a4@e120937-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AS2PR03MB10193:EE_
x-ms-office365-filtering-correlation-id: 6874ce85-b8fd-4765-9022-08db7e32956a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rNd/a1YPyZEI5LgBDFGDIgF+Kl2J7LAtETLNozfIDN4V7w31C5NKzXlpoW4b0JxoLjV2zFzFp0cRmLX8omv+ULFUoXZ+40q4QCh4YNkwBzj6OmBfrVKLr+4cHEORn9QAUxBj7mUTgPE41pXw/9Ask5ZNHOQ2dqBOiqWeeY+5wGELBSQ18uA2oRkiIUGyYJjB8c62AJ+AI2ujSMfPB4LC9Bq+hyhVOGyE1aT4uS8bH7UDJEnQtitR04X65nDUN31HO5tE94hko4Ad6XHb6//zlu75L0sdoSZc8gcM+9Z4WiI65BkbEtlZu0xh7uPyirYBFjr7Q/ntCnstSdCpsOTCS6sbPsqgAeZVzyYK4Pt1Q69tZZFgy+e8E0GnvgOA32mYHbRk556wdEuwpxXySk9H6/tKC2ng6iNXUFBd0Zr3WEu3w4QN8Fzx+F9yeg7kj4tJXAHL1Do5O7SGF+Tmy0WQSDXATkBG6ABusWiz6MrJzqPFIOzCMrTFoUigKhkDqqxxC3h6yE+OechJIzSQht6yu1CUVhhX1Xnygwwrvz6KgOEBfaywfvRHowip3N7MCEqo0uvFDo16dKhwyYslhyqmyZBnKwVGdQ1T43pSpmVFrQA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199021)(38070700005)(33656002)(7416002)(83380400001)(2906002)(26005)(9686003)(71200400001)(6486002)(186003)(54906003)(6506007)(1076003)(6512007)(478600001)(966005)(8676002)(6916009)(91956017)(4326008)(76116006)(316002)(64756008)(66446008)(66946007)(5660300002)(66476007)(33716001)(122000001)(66556008)(38100700002)(41300700001)(8936002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jZqFDnt3KIJPjhF8iOdwFHVscAvoqGVh6kZ5gMLUeq0jzvq4KiW3ofLnC5pz?=
 =?us-ascii?Q?eIr9bEBdMiSLEOaeFSFy9phCLAVig9BxKbM/OHH0pVPkfDPN4O0BvcOUfkNl?=
 =?us-ascii?Q?wkjkJDc5+SO9RSjVnzkgXGHs777Cw/yGjH3UrdnKw2lY0ErbUXJblFwActam?=
 =?us-ascii?Q?7jMVYOrJzzfrUlc3MUhU752NEJ9YUjY6ki1jsmzQP0+0DNyumOHYdyjuw/K4?=
 =?us-ascii?Q?P8NDoYVNnl3RyHGMgqn4FmBOHO4+z6NmtjzAukATJiKbCOcmcnCRJX7L7MQV?=
 =?us-ascii?Q?Ad9rY+1cedVmMqyr5769FPI0OaWmzAKwhIY1zWgLcz3XNFZIPSTvs/Ct7+l/?=
 =?us-ascii?Q?Rj7TLEO6gymhsox/O30UkajhIL38liuR51KS5vYRMZHx8Qr6fhQWqHNtsmAn?=
 =?us-ascii?Q?TcTvYF6PpDl0G6roSUIRdqsHZD7ct34OqX4xR9H6iTXeZK09h4KwoCmAoF0N?=
 =?us-ascii?Q?loF1JLLyr1Y45t2Uh5JSTAbyj7I7WvtGvfna3AT1cIudnt+UHyToWtqm7p/s?=
 =?us-ascii?Q?Hnab6hAI4IzxeH2aRYyA9L6dlKbGH0+yj2U23773ZqCPymQfIFBlcKvGucCj?=
 =?us-ascii?Q?3q9iOLvNakxumOUFbQhWDLzEKpsv2jpMDZuoiab1w5DFvu5/CAH7sWDZxBgG?=
 =?us-ascii?Q?3C+LPdZ0AEtR+gXM5tDEAIDUZJzS1qMDLnkjZOf4zdsh9QOlebDB/uhs2sAZ?=
 =?us-ascii?Q?w+imOwc91/nKLuFcPVdafMfpL95gm32A8PMdDuRdh7PG35UgLDIbotKpK/Ku?=
 =?us-ascii?Q?cKYxKmF3k6upM+BoZAcM/Rg8zVpRlTkJaL0K5WpyM9qpLCaYF+vc54Jrj6MO?=
 =?us-ascii?Q?0BDXk2D4Tu9O7Ah5PljbGDRbQS8yD6M6XXSL6MA1pQrI/qsGYeJM85VTYXfx?=
 =?us-ascii?Q?B+iGvz8G3KZ+K7ot+Z8A+9FGB90TBfpGkyKq2iZICE0+3CUMdHelTswVwv9e?=
 =?us-ascii?Q?HNpY3tJYmu49kQwjrceZg0IUlbFo5UUjkiYRJOaRh2JJK1CSTTAITpX816zQ?=
 =?us-ascii?Q?Fei0uQGC5gVTJJyYt/xJJcBoohraiIQ1HM7p50/XAcnhBMZ/O9jLnK+2nUD5?=
 =?us-ascii?Q?uirl0k8/eKujaeuKNQxKGpltkXjvqIZS9+UJx4/SAJ3NfX9fUp9t2Zf53xl3?=
 =?us-ascii?Q?GItzyzjJIMkizGqKoYMBm7snXY54ucS/8ZF9aiFj9mEhoVkAOTNOY7jZ5d9N?=
 =?us-ascii?Q?i7GlJml6dB29bTtwH+7i5fymZXCldEF6jBOPKbgVDoOpAG6qhTgo8tPG/e/7?=
 =?us-ascii?Q?cVIL1wuutuBSeYH3ZJsi8lPZPh6LOZ1cA6Lrl2IkQOHUm39v4t15efXfMXm1?=
 =?us-ascii?Q?IjhNB80SAa+S5vu78ljz36YcDg+mzlPFsiY99WFRHmjyKuEv+WRk/DvqTpK8?=
 =?us-ascii?Q?lz8wSamhcb6zBvE48ASpOLmIHY7MjrOAnNd7u7a/U2KVUYo/zZDwv+qfVxaA?=
 =?us-ascii?Q?uuGdPAbNVfGjCzl8r2DpNBUK78kggQouuTMv8QZFG9jXOlEhs1cQ7hw6IyDI?=
 =?us-ascii?Q?bYgSaDxERj/CuZaU8ri7zRgj16XsRBxQzgxwTReTU9Kl2MjTrioG/orCLtQl?=
 =?us-ascii?Q?hkj7QWtFWPfKp8TapVH9FF8DQDQ6W9ltCF3PXBzbVsb6mm5gcDUdMEoo9Z7Q?=
 =?us-ascii?Q?oQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D0A7CEA54A00844A583D67C50FD9995@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6874ce85-b8fd-4765-9022-08db7e32956a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 15:06:32.2758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UMTLTRB1ezjsrVpFhs3WfQu5WAVX3zKbGnO/frydlJtTL6MnMPi+csb0jH2J1d7WJpEn1v5Om4/ux3Eev8YhB8fNrVa0srMLUhzEqCoYpIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB10193
X-Proofpoint-GUID: bx2DXdBn_il2snY5cY6kFmqy3r0BBJIf
X-Proofpoint-ORIG-GUID: bx2DXdBn_il2snY5cY6kFmqy3r0BBJIf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_11,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

On Thu, Jul 06, 2023 at 03:42:34PM +0100, Cristian Marussi wrote:
> On Thu, Jul 06, 2023 at 02:09:38PM +0000, Oleksii Moisieiev wrote:
> > Hi Cristian,
> >=20
>=20
> Hi Oleksii,
>=20
> > Sorry for late answer.
> > Please see below.
> >=20
>=20
> No worries, not late at all.
>=20
> > On Mon, Jul 03, 2023 at 11:16:47AM +0100, Cristian Marussi wrote:
> > > On Tue, Jun 06, 2023 at 04:22:27PM +0000, Oleksii Moisieiev wrote:
> > > > scmi: Introduce pinctrl SCMI protocol driver
> > > >
> > >=20
> > > Hi Oleksii,
> > >=20
> > > spurios line above.
> >=20
> > Yep thanks, I will remove.
> >=20
> > >=20
> > > > Add basic implementation of the SCMI v3.2 pincontrol protocol
> > > > excluding GPIO support. All pinctrl related callbacks and operation=
s
> > > > are exposed in the include/linux/scmi_protocol.h
> > > >=20
> > >=20
> > > As Andy said already, you can drop the second sentence here, but I wo=
uld
> > > ALSO drop the GPIO part in the first sentence, since there is nothing
> > > specific to GPIO in the SCMI spec and this patch is about the SCMI pr=
otocol
> > > not the pinctrl driver.
> > >
> >=20
> > I've added few words about GPIO because in v2 series Michal Simek asked
> > about it: https://urldefense.com/v3/__https://lore.kernel.org/linux-arm=
-kernel/5bf0e975-d314-171f-b6a8-c1c1c7198cd3@amd.com/__;!!GF_29dbcQIUBPA!1e=
it_iJDFpGMDrWcBk1hej0zgnDQilbjCvnU-4h-t8eL2GbpNrvXpdWEo7pttPI8rMae2gJAfCgRr=
keiq5Qrr7OeqxXTiQ$ [lore[.]kernel[.]org]
> > So I've decided to mention that there is still no GPIO support in the
> > commit message to avoid this type of questions in future. But I agree
> > that the commit message looks weird and will try to rephrase it.
> >
>=20
> Yes I remember that and I understand why you want to mention this, what
> I am saying is that anyway is NOT something related to the SCMI Pinctrl
> spec AFAIU (I may be wrong): I mean GPIO support is something you can
> build on top of Pinctrl SCMI spec and driver NOT something that has
> still to be added to the spec right ? and this patch is about supporting
> the new SCMI protocol, so I certainly agree that can be fine to point
> out that GPIO support is missing, just maybe this is a comment more
> appropriate to be added to the Pinctrl SCMI driver than to the Pinctrl
> SCMI protocol layer...(but maybe the Pinctrl subsys maintainer will
> disagree on this :P)

Yeah, you're right. Just looked into the spec to ensure. I will rework this=
 part.
Pinctrl maintainer will definitely disagree because GPIO is a separate
subsystem.

>=20
> > > > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > > > ---
> > > >  MAINTAINERS                           |   6 +
> > > >  drivers/firmware/arm_scmi/Makefile    |   2 +-
> > > >  drivers/firmware/arm_scmi/driver.c    |   2 +
> > > >  drivers/firmware/arm_scmi/pinctrl.c   | 836 ++++++++++++++++++++++=
++++
> > > >  drivers/firmware/arm_scmi/protocols.h |   1 +
> > > >  include/linux/scmi_protocol.h         |  47 ++
> > > >  6 files changed, 893 insertions(+), 1 deletion(-)
> > > >  create mode 100644 drivers/firmware/arm_scmi/pinctrl.c
> > > >=20
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 0dab9737ec16..297b2512963d 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -20522,6 +20522,12 @@ F:	include/linux/sc[mp]i_protocol.h
> > > >  F:	include/trace/events/scmi.h
> > > >  F:	include/uapi/linux/virtio_scmi.h
> > > > =20
> > > > +PINCTRL DRIVER FOR SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SC=
PI/SCMI)
> > >=20
> > > SCPI is a leftover here I suppose...
> > >=20
> >=20
> > Thanks. I'll fix it.

[snip]

> > > > +
> > >=20
> > > A small note related to Andy remarks about directly embedding here pi=
nctrl
> > > subsystem structures (like pingroup / pinfucntion) that I forgot to s=
ay
> > > in my reply to him.
> > >=20
> > > These structs above indeed are very similar to the Pinctrl ones but t=
his is
> > > the protocol layer inside SCMI, I would not mix here stuff from the P=
inctrl
> > > subsystem which is, at the end the, one of the possible users of this=
 layer
> > > (via the SCMI pinctrl driver) but not necessarily the only one in the
> > > future; moreover Pinctrl subsystem is not even needed at all if you t=
hink
> > > about a testing scenario, so I would not build up a dependency here b=
etween
> > > SCMI and Pinctrl by using Pinctrl structures...what if these latter c=
hange
> > > in the future ?
> > >=20
> > > All of this to just say this is fine for me as it is now :D
> > >=20
> > I agree with you.
> > What we currently have is that scmi pinctrl protocol is not bound to
> > pinctrl-subsystem so in case of some changes in the pinctrl - no need t=
o
> > change the protocol implementation.
> > Also, as I mentioned in v2: I can't use pincfunction it has the followi=
ng groups
> > definition:
> > const char * const *groups;
> >=20
> > Which is meant to be constantly allocated.
> > So I when I try to gather list of groups in
> > pinctrl_scmi_get_function_groups I will receive compilation error.
> >=20
> > Pinctrl subsystem was designed to use statically defined
> > pins/groups/functions so we can't use those structures on lazy
> > allocations.
> >=20
>=20
> Indeed, I forgot that additional reason.
>=20
> >=20
> > > > +struct scmi_pin_info {
> > > > +	bool present;
> > > > +	char name[SCMI_MAX_STR_SIZE];
> > > > +};
> > > > +
> > > > +struct scmi_pinctrl_info {
> > > > +	u32 version;
> > > > +	int nr_groups;
> > > > +	int nr_functions;
> > > > +	int nr_pins;
> > > > +	struct scmi_group_info *groups;
> > > > +	struct scmi_function_info *functions;
> > > > +	struct scmi_pin_info *pins;
> > > > +};
> > > > +
> > > > +static int scmi_pinctrl_attributes_get(const struct scmi_protocol_=
handle *ph,
> > > > +				       struct scmi_pinctrl_info *pi)
> > > > +{
> > > > +	int ret;
> > > > +	struct scmi_xfer *t;
> > > > +	struct scmi_msg_pinctrl_protocol_attributes *attr;
> > > > +
> > > > +	if (!pi)
> > > > +		return -EINVAL;
> > >=20
> > > You can drop this, cannot happen given the code paths.
> > >
> >=20
> > Ok. thanks.
> >=20
> > > > +
> > > > +	ret =3D ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
> > > > +				      0, sizeof(*attr), &t);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	attr =3D t->rx.buf;
> > > > +
> > > > +	ret =3D ph->xops->do_xfer(ph, t);
> > > > +	if (!ret) {
> > > > +		pi->nr_functions =3D GET_FUNCTIONS_NR(attr->attributes_high);
> > > > +		pi->nr_groups =3D GET_GROUPS_NR(attr->attributes_low);
> > > > +		pi->nr_pins =3D GET_PINS_NR(attr->attributes_low);
> > > > +	}
> > > > +
> > > > +	ph->xops->xfer_put(ph, t);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int scmi_pinctrl_get_count(const struct scmi_protocol_handl=
e *ph,
> > > > +				  enum scmi_pinctrl_selector_type type)
> > > > +{
> > > > +	struct scmi_pinctrl_info *pi;
> > > > +
> > > > +	pi =3D ph->get_priv(ph);
> > > > +	if (!pi)
> > > > +		return -ENODEV;
> > >=20
> > > You dont need to check for NULL here and nowhere else.
> > > You set protocol private data with set_priv at the end of protocol in=
it
> > > which is called as soon as a user tries to use this protocol operatio=
ns,
> > > so it cannot ever be NULL in any of these following ops.
> > >=20
> >=20
> > And what if I call set_priv(ph, NULL) on init stage?
> > As I can see there is no check for NULL in scmi_set_protocol_priv. So
> > theoretically I'm able to set ph->priv =3D NULL. Or did I missed some c=
heck in
> > SCMI driver? Or maybe priv =3D NULL is expected scenario and I shouldn'=
t
> > return error here?
>=20
> Well, you are right that you could set periv to NULL, but the whole
> point of set_priv/get_priv helpers are to help you protocol-writer to
> store your private data at init for future usage while processing the
> protocol operations that you, protocol-writer, are implementing; the
> idea of all of this 'dancing' around protocol_handle was to ease the
> developement of protocols by exposing a limited, common and well
> controlled interface to use to build/send messages (ph->xops) while
> hiding some internals related to protocol stack init that are handled
> by the core for you.
>=20
> The priv data are only set and get optionally by You depending on the
> need of the protocol, so unless you can dynamically set, at runtime, priv
> to NULL or not-NULL depending on the outcome of the init, you should very
> well know at coding time if your priv could possibly be ever NULL or it
> cannot be NULL at all (like in this case it seems to me): so the check
> seemed to me redundant...
>=20
> ...clearly, beside trying to help the protocol devel, the SCMI core
> protocol 'framework' cannot prevent you from shooting yourself in the
> foot if you want :P
>=20
> Thanks,
> Cristian
>


That's why I was puzzled. Trying to shoot myself in the knee is what I've m=
ostly
tried while written unit tests. Probably just need to write less tests
:).
I'll remove checks.

Best regards,
Oleksii.=
