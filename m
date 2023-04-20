Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A669D6E88CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 05:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjDTDf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 23:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDTDfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 23:35:55 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2085.outbound.protection.outlook.com [40.107.14.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CC740F4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 20:35:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/qVU45jQzgqpCP5c0fGjBDglLRkFVTZAulRd9t4X5RyLSdtXAuttzf2S7TvL1L2RXnyqV1OyylLLUUQ75yRr4u++2gitnHl87/M7xfhHaYIwTRCTNo8gbtGPJfofMl2GUxPUNMzzzuXn9LG8OOrHK1QPdjdBq+b3YR0ZvSZzhTsXv1+ChHGZJSHGPnBxMyDHWRJpxSWQY2S2LkawPvY3Bmdsg7HZBmqbIb7KSL6Xf/LMRH9GT7xelNEftNZA6ujlDdQlkVagWt154F+z+2jslSw+eN36I6bHXlnp5Y2VUT5sq1IgU2CYQVVTvgW8DBCPjkmIU5eeu4xKv5/pvfQWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuLumjlGPWOdiHXIjBG+lgAmVcr/OFszMeFi1ELR1tw=;
 b=iEG8dLDpJTaBisCUrl9Zu0mbf9y26hlm/LtG4nvSYlDXKNIh+v8HTghGmn1dY6waMX/FhGtTdZfVQdB8o1zMSePrcZTYcQiF2Za6Un6Ryaf4+QsiLgIB/jywU8pce87GD5CUVTkrJ3D974B59kJZ2S+rMUAhJf3AI9pb0r08wl33xmAZoUhu1WJ4+tc09vQjOtwllPymFr3M/jK38AcSl2lJpOAbQed+kM7SLRIMP1Uq34m8feA8oNiW5QSxUG/FlQh5OzGl6XejLW0rsJGhoj5HgfURdGKoBjlyh3Hxjq2h1F8Ds4X/B2UrFrUe6NBRsmv5wwwXJcyLq+XnAd2M0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuLumjlGPWOdiHXIjBG+lgAmVcr/OFszMeFi1ELR1tw=;
 b=NzeGgB2Kq5fg/bXuxvn03PLGRxhw+GC+44yDzvWwYwO7jhfHBeo3fPaUcC7awJmNn2fpuDDjyIBiqzMaXpaKGpR3KeuBCxgjh/BC5j5j97CK64RaJ8xJ+wcEEf0oPAjNVyTUwhSh+epCPB5KvuacM5m1uQFyxtQtCKWzj4/Jyko=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Thu, 20 Apr
 2023 03:35:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6298.045; Thu, 20 Apr 2023
 03:35:50 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "mie@igel.co.jp" <mie@igel.co.jp>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH V2] tools/virtio: fix build break for aarch64
Thread-Topic: [PATCH V2] tools/virtio: fix build break for aarch64
Thread-Index: AQHZXTtKjPR0p7ioEEmzVaM1Bmb9la8zt9mQ
Date:   Thu, 20 Apr 2023 03:35:50 +0000
Message-ID: <DU0PR04MB94179AD15D133E2D8736A7D988639@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230323040024.3809108-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230323040024.3809108-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM7PR04MB7046:EE_
x-ms-office365-filtering-correlation-id: c297ce1b-38e5-4c1c-38c3-08db41505682
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d0Yr+Gsn60P8RlhVsTKSOGbUfoCHqe1HrhJdjSFMpH25Lt6yRLGonZIivB/xAEj2yR0khW2ByE8IpbcQqEA8ijcGv0/b92wrEjXkqDp0zp+vDoRcsp7XSzOQ4K82cUXGz1wv5ys69cb9Y08E3R6rF33qNM766cRI65uFWnFg0LD9debxd1VIVW/nISPe6RY2P1Xi9q52kR5+skXNiQmxcCl6RgkExcRSCsyLeAYJO9xaLD5/T5LmFENT4Loi2tR5tA1gu929nIFerX+kcB0tNZPpqOjLMubEPrXHn5QQB7FNfRuyVGSbRnwIzukLATk1v7CUMfYi/jIkDJs8LhjJo7nNWAdgWzqojTdnrLOrd7lUaqtqtHbJDkHCy4tfcgPtei/HOe208MTMp8cVXaqUslPEE9rEa+B/wmHMewQoeMh1G5gZvxB5I+3d9KZu+Bqo4jB+dUZXFoydtSBwhu8KQCyBj2A+EVIEPUM8XEZ+W/lyJKejAtw1Bg0P2snhFncejidsesbdvT1gPNjMd7bRFY7dsfc+YQTkiRTT6HHDYslS0LIoG52PeNdEwMviNUfOXWUyPZ25UVNhfuQmPacZBeR0Bkew6aEtC0HqXIIrzRuyxF535hjRzC0CWHgJyHzU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(26005)(38100700002)(38070700005)(110136005)(86362001)(55016003)(9686003)(6506007)(186003)(83380400001)(71200400001)(122000001)(7696005)(33656002)(478600001)(64756008)(316002)(76116006)(66476007)(66556008)(66446008)(66946007)(2906002)(44832011)(5660300002)(8676002)(8936002)(52536014)(4326008)(41300700001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eV+xicFE6hTmxOS3G+tGrzf7GL8d1HO7nkPoyFTv+aiZ44ntpzpUEmrJ8EkR?=
 =?us-ascii?Q?j3XyranW7aMVhdQF1dCPLYfOS2G53OVgETP29hNKZ3OtC8vjdDH2xndcrLWe?=
 =?us-ascii?Q?lMPGRTtCuz/venu8PvVza5INNQopwhpvFgl1lHMlOIZza6CI8GW9U5JHJXDq?=
 =?us-ascii?Q?fnhnoOGwJThEKlXvquhjH8/g349PfKCI/KDwBPKC+FK4m1GpsqmrXefslCqx?=
 =?us-ascii?Q?ujf8BUVD7un2fM8N6xjr4XoS/ss6rlRcPPD1qHAXbl1O1A/1/7jQd6gOI+81?=
 =?us-ascii?Q?PJZ44P3YoKW5erhaHZuZcQTkh4G0SR+OvpH/8xnt6FTK5iNZPKVYe6LFq2Zj?=
 =?us-ascii?Q?QbRwnVznlFs+OBoR+Y+9LtIcbc4iQWEqLkg9ld9JEv3YBltYQrRudOelD/Hr?=
 =?us-ascii?Q?Xg/recnqSQhAnzmgTW4q/Yci+oCaT5ODDNsJsB6for/9ekRwVsi56Hgs41JY?=
 =?us-ascii?Q?NNqO5MkFfJUHFxzyhTsymmtGgguP5tWc80kzpW/HOhBaB7/tM0B/8e3MvUUt?=
 =?us-ascii?Q?cDRCqtrgRmX/NbSnN+qNfgnN0WX1jtRrao9arq4uf8GqnYJeJkr3Vm88exTD?=
 =?us-ascii?Q?oxi8CurmG/DUkIf7Cgm7JcEiIR7yOLjZDlV/KrcgVmIS9DJC+6sw6DYiAQ1a?=
 =?us-ascii?Q?XKm4l3W8IC3z/h0WkLnauVMuRXJzpwzX8Nzd8bvMvIGeMO6XKsW9SJ7gNMoC?=
 =?us-ascii?Q?xgJvkfManskhF/RYX29XJNjcHtYhKFuh/U7Ge2AowqcnC9UPQM0583IH3TRJ?=
 =?us-ascii?Q?rik+c97G1HAeUtCv5u40u6rEWuUatDFxaahyHVxmW/Gbn541pWpvz9+rRmCT?=
 =?us-ascii?Q?DpqyxGfvg0Xw/D0O6KPd8hFTkoSO7lm6srkjqoNoEd20q+kQe9BZZ6pCZ2Qn?=
 =?us-ascii?Q?imFxYuKPDXCVUwucmhdcM4ThOmq8hXatvt2iMVNzRNYMyJNLb3M3Kj2wchho?=
 =?us-ascii?Q?9Yh7lZOmGjdQF82DHdad35U+NwrnYDHhXMbBx9B9qDUYkMkI76eySWyt5o7w?=
 =?us-ascii?Q?6QWDNi49w/VtsYMotgdM4Ph53ZPx79F+LnZHxSAUHUkeTZyy6mmOTyfOCmlS?=
 =?us-ascii?Q?H/tPEwCfo4L4CDrHJ/qY8Rz5RXd+AMUFE4uH+bxsbdlqPA/U6vdRm8sSFgbM?=
 =?us-ascii?Q?qGwEw1OVZCwH/s2Hz+j0iIcEu/s1xLbDiTN+CiauobzIawGM5Ep5f+jeG4NO?=
 =?us-ascii?Q?YT9A1q7fmK04dh+fsAjT839wth+MXX+KPciVbgRl1Jc7HRiaFlB82cBAPeQ2?=
 =?us-ascii?Q?HIG2+3Qu1KYoV+APufYf0swjNfrIYFxrew1QRM1ptymgMWq9vyPtz8ETI73x?=
 =?us-ascii?Q?AJdYtvrVpD2PUJ9laYWjnLti1UxUSjh1mlcl+OuvN4uJE8Fua++wrJ0897gd?=
 =?us-ascii?Q?e9A85xV8neRvHRnAHq29gh92ZSg5YXy5+63ti/G1hLSbAgUQNRF3bGy4IeMq?=
 =?us-ascii?Q?5AGku9RZzIWrqRggAkzT9RLD10ZW+9KKJXxJrE9HLSthmBrSz1QgamBCkdEY?=
 =?us-ascii?Q?6gDlnqIf17djDRm551w7QQBGzI9dx8jV9MD4wFGm3cEMuVuKrvm5HbEZekHL?=
 =?us-ascii?Q?reK+rL5ip5QJoiEW4n8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c297ce1b-38e5-4c1c-38c3-08db41505682
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 03:35:50.7495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: moW0k9jw2fnwsWy+uluGGu+Z0NntVfV259RQkTDMdnmisRWvdH+h3ucTGoOpeEUdyUdJpiALO9CxPaxavLf6Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH V2] tools/virtio: fix build break for aarch64

Ping...

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> "-mfunction-return=3Dthunk -mindirect-branch-register" are only valid for=
 x86.
> So introduce compiler operation check to avoid such issues
>=20
> Fixes: 0d0ed4006127 ("tools/virtio: enable to build with retpoline")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V2:
>  Use /dev/null as output dest
>  Move call cc-option to the original CFLAGS
>=20
>  tools/virtio/Makefile | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile index
> 7b7139d97d74..d128925980e0 100644
> --- a/tools/virtio/Makefile
> +++ b/tools/virtio/Makefile
> @@ -4,7 +4,18 @@ test: virtio_test vringh_test
>  virtio_test: virtio_ring.o virtio_test.o
>  vringh_test: vringh_test.o vringh.o virtio_ring.o
>=20
> -CFLAGS +=3D -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../inclu=
de/ -
> I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-a=
liasing
> -fno-common -MMD -U_FORTIFY_SOURCE -
> include ../../include/linux/kconfig.h -mfunction-return=3Dthunk -fcf-
> protection=3Dnone -mindirect-branch-register
> +try-run =3D $(shell set -e;		\
> +	if ($(1)) >/dev/null 2>&1;	\
> +	then echo "$(2)";		\
> +	else echo "$(3)";		\
> +	fi)
> +
> +__cc-option =3D $(call try-run,\
> +	$(1) -Werror $(2) -c -x c /dev/null -o /dev/null,$(2),) cc-option =3D
> +$(call __cc-option, $(CC),$(1))
> +
> +CFLAGS +=3D -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I.
> +-I../include/ -I ../../usr/include/ -Wno-pointer-sign
> +-fno-strict-overflow -fno-strict-aliasing -fno-common -MMD
> +-U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h $(call
> +cc-option,-mfunction-return=3Dthunk) $(call
> +cc-option,-fcf-protection=3Dnone) $(call
> +cc-option,-mindirect-branch-register)
> +
>  CFLAGS +=3D -pthread
>  LDFLAGS +=3D -pthread
>  vpath %.c ../../drivers/virtio ../../drivers/vhost
> --
> 2.37.1

