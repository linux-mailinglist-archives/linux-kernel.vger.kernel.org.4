Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577405BDAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiITDZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiITDZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:25:14 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963F31704C;
        Mon, 19 Sep 2022 20:25:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiE/N4MUXfLAWiB9thYgib4+E3I0K8ntm96oHBgfD5azh6blup58fBDbDhI27NKKGc0G1P58rqulkAqxaXpMgoA495IvwoFxKx6tQCwKcES18p+mrkr7uz6wK0fcR3loAAu6XnH2xcVgPb9pxHs1bD5h62NM+vCtcssBFqrJ3Nx54C8cr0bsDElXj4R2n7NFuY+bAR3N3O0j7x/R5c72T2TWFPAvB95CtpYu/+ToVMx570PBj6DOn6dhvaBL6GjRI7LBN2SAY1QbnuC51P0FeRwbXFDpZZ8UWRrvuqKk7zQ7G1+8jnDpAre3A7Kj7iG7HlBj9PIJJ9lDpVR32J/FBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jk+f1YLcNDUxyVWzGEftVkOZIgNbxNbndAXl35dQwhM=;
 b=ke/ZbPAMZgsGoUfpJmMMHnJzSzgbyQ1bNF+yYJCK2Fso7lmGCWA7TQLaGlSoBmm58dpsUDFTTVDZNHqyKz03bIHMSdXXl6Iw0MltzHaHoze/lk8gJkf8UKrzPqBrb0uE0fs5qH0AFVFzcFKi2oegADwq6EA0gEJ5s1oG5DNPKS4RyfhOEY7QLr8OrX9N+PLmb37mnoEczDDf+0+305SxUzrbHqcKEsAltJ8aL4DBFJn1ovPicj3yJtsjAvkDbLR8bFqyYLJcPRy2pJcMb4QZyEUMaf5dCy6yNZ+I9bI6U6pGDaBKQ4deaDKzIJjHTe8T6WbwANmowUmhO5VL1H88KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jk+f1YLcNDUxyVWzGEftVkOZIgNbxNbndAXl35dQwhM=;
 b=jJ0TBGFgOb1JZPL20tuqg3/3jmLRXTcoE7JVGtJyXi/k7zmcBh0cfSmw78EZZEm1Whu5KEPDWLln96PTNSPrnVz/8wEkMhqa/ZVgbDpRkT0zblAFwEYFerh5Fe6v1KllvfKDC59P33Vr/i90eViepWxsTvTj1D5F7wPp/RL0pZc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7828.eurprd04.prod.outlook.com (2603:10a6:20b:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 03:25:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5632.018; Tue, 20 Sep 2022
 03:25:11 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V7 0/2] remoteproc: support self recovery
Thread-Topic: [PATCH V7 0/2] remoteproc: support self recovery
Thread-Index: AQHYkAx5W4uJ0cTEEUqsuvaJeDSHw63oHMyA
Date:   Tue, 20 Sep 2022 03:25:11 +0000
Message-ID: <DU0PR04MB94177A3658A8B5E57D0C5DAC884C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220705011527.2849057-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220705011527.2849057-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM8PR04MB7828:EE_
x-ms-office365-filtering-correlation-id: 62f046af-a9b7-49a1-bc40-08da9ab7b9e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rB/J5vdTzPzG9uO8j5ICy6ieHnXncAOSjSfkqx2BQ+YdAahk9PSzz7tFTZMNXk93BSkHBQ7oOcsdEGF/O8Ubv4A3zjYXS+t5WkGey+RXzOSXqvBWAeTLsbmh53K/zH4ivDBi+W/+5B1dhMUFTW1SZtm5YTMcThVFts2qRxHGqVYVJs9NZo9OCDYBbWkZyeHrTz+EL4R1C36OXBF4SyX29hUyB5Mf7ewtb5xRvA3l7ZX7ydXWElUDnSNniGZEauVQe8wGiJOwb9chgf3W5kDbPERigMqGrIO+BH85lDKvqeX/B6t+f8oNzyDkKnICC97WdDKWMYoZJV/nZApNYBkKwpYO1JkyaASViepf9te0NG6DG9c4FV90lrh0ck+SSmL9ZLtlt7CS82mozq2qxhObFut3K+3CZ6L8NRarhqvnZTohn0G92XiPVRv3wZKSATYAWLzf1hdcwB45S+nrF9LmgA73BqIgCNmVSzKEXsrRQQ+sXSL5dWfVFHAkH8kZE1YbDQXs8iRVL7RnVVLf2DL3l9P19lo9ytxLgKwfgWWMtMbD53toc7rAz/QLN+kM/NTdR7WWw1WEQcOweOH01dx0xySl8W0w21hym+OhGG0DlKRFXSgn01hJSpvCWKHBUamrXCyOlS6UuXxZhfWl6fTJTLMQ8PCBC1hLllWjlarlEAiJk05vrX5XMmYx7aJoBrUfPtJkh3nbR7dGBAQ8DTc+dLF0XlEkybCXcrf5JRnX6x5a+J4oLrhkh8tU3+CINN/Td78j5bggnyhf+kdDeO9X6AjxDIygpVIDMxp/eG8FaXs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(33656002)(44832011)(55016003)(2906002)(122000001)(316002)(38100700002)(4326008)(8676002)(66556008)(64756008)(5660300002)(76116006)(66946007)(66446008)(66476007)(110136005)(54906003)(86362001)(186003)(478600001)(38070700005)(9686003)(26005)(8936002)(83380400001)(966005)(6506007)(52536014)(71200400001)(7696005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bxs2usLqxCoh7GGd67vzUYJul/qhlGyeyGHM209zRVr1ImXLc5UDSm3NLmVM?=
 =?us-ascii?Q?ngKCaJF5nXmnxhjz0zFWdDp2slKSm3pFUUeImXf68HUdmVNHNN8W/smnyO9F?=
 =?us-ascii?Q?u5/+zrxvYgeVybE6h6eKW5Go82pwR/MnBySwV7bsyqIMC9EXcFtazmPPM0Yw?=
 =?us-ascii?Q?TNxSTzJ1uWnxL3umTYyrPaUcSm81bOkd6KUyR3STd1G4BWYi1tDr6fI+yarI?=
 =?us-ascii?Q?B5vNC5PDT1GyJmGKwKVH8YoYCSlMuQ7JryTvmIJrrVlEzbzE85QXY1yO6qm/?=
 =?us-ascii?Q?FY34FCgMyBIyo8I05+xRgAR9/RMYjh1/f+c3sLGCBojSVzpgqsFoQSl3FlBu?=
 =?us-ascii?Q?bqsMvIj98eecOPYcDAAlCv6f8X18+Vf4h+5/oeQ3HfQikYETPYIPzhBI2UMw?=
 =?us-ascii?Q?/SuX2crouUF1N9Un7jixQ5hcLh3d1nqny0cTsUUqH6n8Ihw4DTnbF7nNf3gu?=
 =?us-ascii?Q?dS9qzCPqydulzvflMnCxCXZiFPfQduwMXYLVB9v1fGulzFS2vSnzuIKA2PbQ?=
 =?us-ascii?Q?QqOzSoDqq0+cjcgapH3t9AXnEncz9J4zZM8EZ4c7YQCMKbOfuNXn+v3kakqf?=
 =?us-ascii?Q?HmaL+pqU29uBm1Q1sgSxWMJGAfY6mdKG5khLaQglL+Yw4DqBc/uXtAIe6mMo?=
 =?us-ascii?Q?33IhNf7eJSRLudHfI8UhgIhW0jF01OZGHubrhQS5QcoLerDSMi2snw6KUN0F?=
 =?us-ascii?Q?0JmJJjnne/PgoFPbUWquhtyOVlR+LG8dbAsj9Hi6VBw3kqyDEcruGnpxB0XP?=
 =?us-ascii?Q?w42Kv1IuDepI2S+YnNbuQMrpfDZhDQDL3hbzZXnRE9P1/fPD+cJCjYYFmDrm?=
 =?us-ascii?Q?ceefi/dbAem4DF+rOs1Xu/CuLqrFWs4B6/MVWZ6KPWUYJsLGVaOU19PKFPWg?=
 =?us-ascii?Q?UjjhNi9b/TQ7gbA/PePYlfwvGvw1hyqDAeFoIibzdv8x0rp1+8DYowfDDdcN?=
 =?us-ascii?Q?YQ/66NUi+3Ifg4ONK0VNkMukGFWXb0u7gpPfsMpqJqbxgAhwYRn1brmP/YHU?=
 =?us-ascii?Q?LjrSRqhK7VmpU8fiXrTMj6d1SploNulNQF3qpzV7LJvDSDduXnIfnHS98/NL?=
 =?us-ascii?Q?beVPJ+FBS/DmcRePpB2scruDg515OOnWginiFAg4QUkUQiw8rp4x+t+e80el?=
 =?us-ascii?Q?1YTitHxtIQmuwEL4CRc3Jayy/JSEsIGf8IXT4RNVFaxRbrhrc5g8wMZA4U7W?=
 =?us-ascii?Q?Krz7vY40u4QShDaWiw7upzUlU9ANdg/d9Bsx46HPK9wEAmmDHN3iiThlSxzv?=
 =?us-ascii?Q?reP9QT2xGKAObzHqlYijfU3DkFI2SS5ARKEpy5lBFxDYHqHO1r0sUEvZw/SB?=
 =?us-ascii?Q?LJqgf9WhcO7PGvmZioN8ln0VGrwEamgYM17PQHnhryS+zoikrpZq0ks3qKdr?=
 =?us-ascii?Q?4BcySVKHNRAsjsqVpDSCHbi+LVThfusqyshGiQEqt5cBOtdzGrF6yb2FyE/R?=
 =?us-ascii?Q?ziaBvwCNs3X1Kia2IjZWxgDgAAMIaYh/64mJeqMgyyQa052CxEdqy7KjoDF3?=
 =?us-ascii?Q?DJTHchSaVZ3hhOLkA6KEYKj/xH/r4dN0oZYOFbRIxU51ikTnk2XaJF+l7MGg?=
 =?us-ascii?Q?AS9V2RMGtrXIxEzCsPrkKxc3+HE3NPmwtJz7lyw/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f046af-a9b7-49a1-bc40-08da9ab7b9e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 03:25:11.4608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnRtjzksIQea1rUp8MDjO4rIp+0Y45qdGIHCrQ4mwUf/1XZlNg2vSBpZjUzQCEEz94fFpCW3Pmtp6ecyj0b6yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7828
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

It almost two and a half month until now, I not got any response.
You accept or not accept or suggestion?=20

In V6, I got a typo  comment from Arnaud, then Mathieu replied
dropped.

In V7, I add A-b from Arnaud and no more response.

I not understand why ignoring me.

Regards,
Peng.

> Subject: [PATCH V7 0/2] remoteproc: support self recovery
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> V7:
>  Per comments from Arnaud Pouliquen:
>    Typo fixes
>    Added A-b tag
>=20
> V6:
>  Rename rproc_firmware_recovery to rproc_boot_recovery  Drop the
> unlock/lock when do reproc_attach_recovery
>=20
> V5:
>  Rename RPROC_FEAT_ATTACH_RECOVERY to
> RPROC_FEAT_ATTACH_ON_RECOVERY  Add kerneldoc for rproc features
> Change rproc_set_feature to return int type and add a max feature check
> Use __rproc_detach and __rproc_attach when do attach recovery
> https://patchwork.kernel.org/project/linux-
> remoteproc/cover/20220615032048.465486-1-peng.fan@oss.nxp.com/
>=20
> V4:
>   Based on Bjorn's comments on V2-2
>   Move the rproc_has_feature/rproc_set_feature to remoteproc_internal.h
> and  Keep rproc_features still in remoteproc.h, because we use
> RPROC_MAX_FEATURES to declare bitmap.
>   Update commit log for patch 2/2, and add comments
>=20
>   https://patchwork.kernel.org/project/linux-
> remoteproc/cover/20220323034405.976643-1-peng.fan@oss.nxp.com/
>=20
> V3:
>  Resend the wrong labeled patchset
>  https://patchwork.kernel.org/project/linux-
> remoteproc/list/?series=3D621311
>=20
>  Write a cover-letter
>  To i.MX8QM/QXP, they have a M4 core self-recovery capability without
> Linux loading firmware. The self recovery is done by  SCU(System Control
> Unit). Current remoteproc framework only support Linux  help recovery
> remote processor(stop, loading firmware, start). This  patchset is suppor=
t
> remote processor self recovery(attach recovery).
>=20
>  In order to avoid introducing a new variable(bool support_self_recovery)=
,
> patch 1 introduce a new function, rproc_has_feature to make code easy to
> extend, cleaner, such as we could move "bool has_iommu" to
> rproc_has_feature(rproc, RPROC_FEAT_IOMMU).
>=20
>  Patch 2 is introduce a new function rproc_attach_recovery for  self reco=
very,
> the original logic move to rproc_firmware_recovery meaning  needs linux t=
o
> help recovery.
>=20
>  V2-version 2:
>  https://patchwork.kernel.org/project/linux-
> remoteproc/list/?series=3D621311
>  Introduce rproc_has_feature
>=20
>  V2-version 1:
>  https://patchwork.kernel.org/project/linux-
> remoteproc/patch/20220126085120.3397450-1-peng.fan@oss.nxp.com/
>  Nothing change in V2.
>  Only move this patch out from
>  https://patchwork.kernel.org/project/linux-
> remoteproc/list/?series=3D604364
>=20
>=20
> Peng Fan (2):
>   remoteproc: introduce rproc features
>   remoteproc: support attach recovery after rproc crash
>=20
>  drivers/remoteproc/remoteproc_core.c     | 62 ++++++++++++++++--------
>  drivers/remoteproc/remoteproc_internal.h | 15 ++++++
>  include/linux/remoteproc.h               | 16 ++++++
>  3 files changed, 74 insertions(+), 19 deletions(-)
>=20
> --
> 2.25.1

