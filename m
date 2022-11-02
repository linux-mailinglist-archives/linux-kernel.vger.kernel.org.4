Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2F3615D18
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKBHqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKBHqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:46:15 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6E42529B;
        Wed,  2 Nov 2022 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667375173; x=1698911173;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W8BX1FrLtcTLdN2MwxUJ9Kl8YF06xkBQEuVYwUQJSPw=;
  b=IY6dclSw/ey3uY6pAnNsgunj6UVOuUW6FTnlT/IHBetB4YAR4UVnH/6s
   QmTNkGqLO1P5l6d6vTAf76jgrzfZAt6Rds3aatiFpOZgJLQ9gX/ICLPNy
   BmKXTawdShRp4NLs164CZyixXnt6iddfcF/ih5gw1MAcJoeT0785H6xp8
   JnwSQ0eCVKQ/NN2ID1xB2kGjExHJb+I+xNlZv0VIS8iLAEWJPRLiRsiJd
   DN8lQBa9/se0PdpLRwYayrQVGNboQoq3Bj3S0RObPy07UCUw0nhKFH8ih
   N4hzKpj6RGrg21rvPeQ9kmFJ5xthYKkV0MRIToApqpNQ7y3UGBx6KjyuI
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661788800"; 
   d="scan'208";a="213581350"
Received: from mail-bn1nam07lp2045.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.45])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 15:46:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZYgQw3Qh9OVYWJyB5zkgE6LuajIc6ulBf4uL9gJ65ruTR7669C120nmCMrDn8VSejl0gsSBwuoLZBCv0fWHv9JpYJZb5RnnsHv/pJqyG3lZ2T6rUqNHkkWVlY43UY9xZjrq52k/6if4IDDf6tcgzb6Q2LbHt+jaVmg+N6R2HejLOMCOEYSY1ZlVHOz7umMlRnwTzsdWBmVz5scEQKs4rZgwLl13Tx2ORZlIkxF0Lw9i9UeJBckO21COVCYrfxjudr9mxx9Og681fQiF8Pv6YDIEFgkXm8kRcx3Bv2HnUWT4LGRSLC2xJ6FZua6BlUeEzujGB6JPzLqvmZquHOnfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DrkMylv9D0BlbglNZ7NZbHyBmET2VmAmmDFaO+U+kk=;
 b=N559BVY4XjvxJpEYOGcmD2UX/+Sq6flFJDm+8VCw9SX5Uz2/9egyoDukclpqZbAn7FYLV0Je62A8e47DXUXtg4d8Rc/sSEWJi6n7uGpmIxT2tT53ZvZpa6UuwMJK9guSvMytmlrSI+YQ9m/Y9IXS3lT0vUtcPMl1iXihUCXtqLU0mvgIx2YVPf0UU1vjERLA/MbaXwwiUzQB0DDuZtZnQYwa4vutI3KOG2hZriTVpjJs/8zjOP/HVtKUqq7vUwHBLcZ8X3QCLfLsBU0NCQQSRPyvefhtnaGL9k3nyYm14JILgrr2KfbC1DTb8ARCaCUBPT5dh/L0B+3OT8Uizzta1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DrkMylv9D0BlbglNZ7NZbHyBmET2VmAmmDFaO+U+kk=;
 b=Ki/G60ipzS3r1juD8ITOqNSBVBOtLxUwdwkcCuLrjp64w/4WUeKW/zNihax+JyFAh7+1OYVXhu9+bYmTNr8LWKF/r16408BYR5vSYqyNGPROVEZZIRvW6E0cqG3+Ra6ESlZmCFOwE5asfcyVYtF2Rb+yw/pdJaVgQX0LxWuHNw0=
Received: from BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11)
 by BYAPR04MB3910.namprd04.prod.outlook.com (2603:10b6:a02:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 07:46:08 +0000
Received: from BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::152f:249a:afc7:d6d1]) by BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::152f:249a:afc7:d6d1%9]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 07:46:08 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Jiaming Li <lijiaming3@xiaomi.corp-partner.google.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lijiaming3 <lijiaming3@xiaomi.com>
Subject: RE: [RESEND PATCH 2/4] scsi:ufs:add File-Based Optimization
 descriptor
Thread-Topic: [RESEND PATCH 2/4] scsi:ufs:add File-Based Optimization
 descriptor
Thread-Index: AQHY7nxiYzy11zcPc0KihkzA+PILzK4rQKcw
Date:   Wed, 2 Nov 2022 07:46:08 +0000
Message-ID: <BL0PR04MB65642CD12B5CFBCBB14CF602FC399@BL0PR04MB6564.namprd04.prod.outlook.com>
References: <20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com>
 <20221102053058.21021-3-lijiaming3@xiaomi.corp-partner.google.com>
In-Reply-To: <20221102053058.21021-3-lijiaming3@xiaomi.corp-partner.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB6564:EE_|BYAPR04MB3910:EE_
x-ms-office365-filtering-correlation-id: 1df45e87-fb84-4714-16da-08dabca64e26
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mwGuGd2fcYA5RB4GOSR605iPTqKa21rw8EDN+lZHJMhChLb6r8JCO2Yqgg9RO8ybUyKYmQWL6vl8NvHywiblsCQXcClj5yHamF/gj6JuXIjpIhGmzoDky/wEb0pzGOySylUvqIpGNQirKM8vRBGq4IEwLPl+JcIY/uyal54zOPpRBjnePijh72QLp59eojgSO0RxExQOrpzzezRrW/ozh6UINSDfpWPxvtCqW66b98wAdDv+yP8G9tgk6KVqZsFPtC24v/81sYweObRGEm5+q/jDLfvgPi08AhBxG3g/qaaABXLgQVhn9huTH5sdBSeFYggWtIJdrgaBYCWEnSM6Uzx9/EkB4Xt1cfDNqHstdysfquhUJPq3C8tjR3Icamp3kXk6LWz8nhC8BO8K5m+xyFowv+fWESrqBp8HQfpNHrpmu+ZbfEiq7Fvd/CLV76M75ItHDhCBlYH1rp+zHL24HGPl3xIIEW4/sOe/VuLdnUKi7KkJgl6FOVmenlAhm6AjmEI4o4SRWRd7s7sA8kjebv+4zJHDYQ4gIaFIUdYRVExsfOEV8x/xQqVQe4lJlLirMAuDUrATNexRUdCLFRHsHhCvMZARzRN8baMWmEYgDsx7ev3hGJUxp2nof5Eqo0N4E6wtgVo58v5kExBCaQJGu+hNTcilH5kAjef6Lj/e/vimb2DV/0+Rn5+/58eEUMaO7JaR7QRGwhpjE4XeRqU1XsnZT+B1ypUeTBjlDV3Pe3uS+L9UaLcbSiN3/0COIB/N7qpkkidMNTnDwcpzw0ZZsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6564.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199015)(122000001)(82960400001)(38100700002)(33656002)(66446008)(86362001)(66476007)(64756008)(71200400001)(4326008)(8676002)(76116006)(54906003)(110136005)(316002)(7696005)(2906002)(66946007)(83380400001)(66556008)(55016003)(38070700005)(26005)(9686003)(6506007)(8936002)(52536014)(186003)(5660300002)(478600001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uQD2lylNLCEeiXkG9SdVS3nwOSAt2rjtijVtPtjylFGzf5pGkQgJqV/gGkDO?=
 =?us-ascii?Q?G1N++W6mofLN3Fz0QdfxUnpUIloMl3ua4QbFhCCzptu47oXEWczhbtkxLxOj?=
 =?us-ascii?Q?WNUB7zoqpvZGSXJhbQzRRor/TcinGeasGotN8k1BHyeaKCTyRecQs6V281ki?=
 =?us-ascii?Q?TyImiWlYvYwUarzEJVnUZiCbtVDYhZeNpp+g7FemjGFiVIzOjF1pfSzBurWU?=
 =?us-ascii?Q?94WyTU3IHsm2xhQXlj6Y7rUoL8PawHsjM2JsL8gePqM2dm9lri2Ehh6at7yJ?=
 =?us-ascii?Q?t/YECU1TzdcRe2bXArzb4pKfOGcrjgTBMFoUmVKIiah+tX/9gz2JVaupXPmc?=
 =?us-ascii?Q?jp17m8aRIgex3rb4gR43BJ+iek1AfidAY2LSklh9yYuffBdY76W2F2FfNJRD?=
 =?us-ascii?Q?sURAlUFcz6llPf9N4+TJMo7tVYO7v5/W2EEXxXhBBrb8CYVhFokZMUdgLwwg?=
 =?us-ascii?Q?MMhygcbjyJtiB/mRbbwZky7ml5Ommqacsojv6SW2dNOunXLL13BbtauhT0dn?=
 =?us-ascii?Q?x00AE2lLAi5pFBCNM6e+/EzkIM+jXcrgTWH+Ggr3AagiZb9xXxJBOJMEOtCq?=
 =?us-ascii?Q?sHqHkWq/tn+9lIdPzqwlrwaSVJHUGafmjj8KJtqbwltmNPjJfg4V4XtUohz2?=
 =?us-ascii?Q?2/Pl7sMOgoFGWvjHQ+TZWhOjf+TWAh4VRmHeniUVPvFPmkQRQeXgw7nRPv3K?=
 =?us-ascii?Q?cHItsmeuwmjC/s2d/1wNFE1OJm11C53HTM0LUIlbxQXB/IvbRO8CmUvd3dEk?=
 =?us-ascii?Q?PBiBDRk4nW/J7PjwFX7X0+IrU++yqqwLj0ErStvL/0d7DN2qIX/U0kvyUwxI?=
 =?us-ascii?Q?P1hMuHGFe/W4NL/MY6tjbRfN0wa7X7axi7oPoEJok6RwHyYE4J22BfHD/iBh?=
 =?us-ascii?Q?fJ1YspCfQ8mcf3EDzfNmr034pG0d31z0kyKZGgv6HmaHYVAAh0yJ0NNxkm9z?=
 =?us-ascii?Q?hpS1M2z2x+bGEkt2ZbAnq55MLecTRArPom4jbtkOPSDTguCuuRaVXQciE7Hm?=
 =?us-ascii?Q?eoh0gc6px+gJX7R1Pa5ew6GeUMnluY+0K6Zbj1p2Z3DgvJbCMi05QdsqFgA/?=
 =?us-ascii?Q?mDELI3z3Cv26f1nc1+Ike40Ku7f83GxOzKTqD+H+b7Bwzqg9CAq/cAoIyJ9U?=
 =?us-ascii?Q?hfhrio8I/irLlfgB8242W6iiLHP0tsZT+vuBe4qsVA8JOw9381KJCurBPVLc?=
 =?us-ascii?Q?eqtQmGLYeiT1k0gXlI0NsaazXcrwe+MpIjAYTUi1gQaYS5eN5YqE5Nc23rM2?=
 =?us-ascii?Q?QCIHehPLZIZnnRHBnW8AGER4mc9xaYzUBf8QSq7HLyQrNsuH1u22rWuGYTKp?=
 =?us-ascii?Q?51b6gPY/WDAJAG7WtzfNTKhL2xnvv0kRVhODnoz0t48shhuZ1tKO9IZw5h51?=
 =?us-ascii?Q?5XpiLpH72IfxasRUxBolZwkveWNhK/RDx02+XNMKVKNytrnRx7LXiz0yRYxi?=
 =?us-ascii?Q?sOGwvQtA7qLjNWbo7OfKGZEmcY1i9S+ynl2bEEQSVV0ZyhTUwyyWSog8Hmzc?=
 =?us-ascii?Q?JX6YtzC3pq/KqAyrG/jLji4D5G2El/D3GMmnpJoooy8mdAFcz3kz3x7nlXKR?=
 =?us-ascii?Q?rOP1vzoZ72I19NH1s21vqOb8M3+/VcBU+QbB8s6i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6564.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df45e87-fb84-4714-16da-08dabca64e26
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 07:46:08.7746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8HozjLG0SBD/bm3x2LLHtYedRPalfi2KVDJxBtkFZPPZ0dEvn0c024HMxuUEiJBv8IeSjLkjCQ1a8bgwpCIpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3910
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: lijiaming3 <lijiaming3@xiaomi.com>
>=20
> The full information about the descriptor could be found at UFS
> specifications - FBO extension.
>=20
> Signed-off-by: lijiaming3 <lijiaming3@xiaomi.com>
For some reason there are spaces missing in the patch header: scsi: ufs: Ad=
d....
Other than that:
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  Documentation/ABI/testing/sysfs-driver-ufs | 65 ++++++++++++++++++++++
>  drivers/ufs/core/ufs-sysfs.c               | 26 +++++++++
>  include/ufs/ufs.h                          | 13 +++++
>  3 files changed, 104 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs
> b/Documentation/ABI/testing/sysfs-driver-ufs
> index 228aa43e14ed..63daccbf7a8d 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -1710,3 +1710,68 @@ Contact: Avri Altman <avri.altman@wdc.com>
>  Description:   In host control mode the host is the originator of map
> requests.
>                 To avoid flooding the device with map requests, use a sim=
ple
> throttling
>                 mechanism that limits the number of inflight map requests=
.
> +
> +What:
> /sys/bus/platform/drivers/ufshcd/*/fbo_descriptor/fbo_version
> +What:          /sys/bus/platform/devices/*.ufs/fbo_descriptor/fbo_versio=
n
> +Date:          November 2022
> +Contact:       li jiaming <lijiaming3@xiaomi.com>
> +Description:   This file shows the version of UFS file-based optimizatio=
n. This
> +               is one of the UFS fbo descriptor parameters. The full inf=
ormation
> about
> +               the descriptor could be found at UFS specifications - FBO=
 extension.
> +
> +               The file is read only.
> +
> +What:          /sys/bus/platform/drivers/ufshcd/*/fbo_descriptor/fbo_rec=
_lrs
> +What:          /sys/bus/platform/devices/*.ufs/fbo_descriptor/fbo_rec_lr=
s
> +Date:          November 2022
> +Contact:       li jiaming <lijiaming3@xiaomi.com>
> +Description:   This file shows the recommended LBA range size of UFS fil=
e-
> based
> +               optimization to be used by the host. This is one of the U=
FS fbo
> descriptor
> +               parameters. The full information about the descriptor cou=
ld be
> found at UFS
> +               specifications - FBO extension.
> +
> +               The file is read only.
> +
> +What:
> /sys/bus/platform/drivers/ufshcd/*/fbo_descriptor/fbo_max_lrs
> +What:          /sys/bus/platform/devices/*.ufs/fbo_descriptor/fbo_max_lr=
s
> +Date:          November 2022
> +Contact:       li jiaming <lijiaming3@xiaomi.com>
> +Description:   This file shows the max LBA range size of UFS file-based
> +               optimization to be used by the host. This is one of the U=
FS fbo
> descriptor
> +               parameters. The full information about the descriptor cou=
ld be
> found at UFS
> +               specifications - FBO extension.
> +
> +               The file is read only.
> +
> +What:
> /sys/bus/platform/drivers/ufshcd/*/fbo_descriptor/fbo_min_lrs
> +What:          /sys/bus/platform/devices/*.ufs/fbo_descriptor/fbo_min_lr=
s
> +Date:          November 2022
> +Contact:       li jiaming <lijiaming3@xiaomi.com>
> +Description:   This file shows the min LBA range size of UFS file-based
> +               optimization to be used by the host. This is one of the U=
FS fbo
> descriptor
> +               parameters. The full information about the descriptor cou=
ld be
> found at UFS
> +               specifications - FBO extension.
> +
> +               The file is read only.
> +
> +What:
> /sys/bus/platform/drivers/ufshcd/*/fbo_descriptor/fbo_max_lrc
> +What:          /sys/bus/platform/devices/*.ufs/fbo_descriptor/fbo_max_lr=
c
> +Date:          November 2022
> +Contact:       li jiaming <lijiaming3@xiaomi.com>
> +Description:   This file shows the max number of LBA ranges supported by
> read/write
> +               buffer command of UFS file-based optimization. This is on=
e of the
> UFS fbo
> +               descriptor parameters. The full information about the des=
criptor
> could be
> +               found at UFS specifications - FBO extension.
> +
> +               The file is read only.
> +
> +What:          /sys/bus/platform/drivers/ufshcd/*/fbo_descriptor/fbo_lra
> +What:          /sys/bus/platform/devices/*.ufs/fbo_descriptor/fbo_lra
> +Date:          November 2022
> +Contact:       li jiaming <lijiaming3@xiaomi.com>
> +Description:   This file shows the alignment requirement of UFS file-bas=
ed
> +               optimization. This is one of the UFS fbo descriptor param=
eters. The
> +               full information about the descriptor could be found at U=
FS
> +               specifications - FBO extension.
> +
> +               The file is read only.
> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c =
index
> 53aea56d1de1..006d99b15be0 100644
> --- a/drivers/ufs/core/ufs-sysfs.c
> +++ b/drivers/ufs/core/ufs-sysfs.c
> @@ -871,6 +871,31 @@ static const struct attribute_group
> ufs_sysfs_health_descriptor_group =3D {
>         .attrs =3D ufs_sysfs_health_descriptor,  };
>=20
> +#define UFS_FBO_DESC_PARAM(_name, _uname, _size)                       \
> +       UFS_DESC_PARAM(_name, _uname, FBO, _size)
> +
> +UFS_FBO_DESC_PARAM(fbo_version, _VERSION, 2);
> +UFS_FBO_DESC_PARAM(fbo_rec_lrs, _REC_LBA_RANGE_SIZE, 4);
> +UFS_FBO_DESC_PARAM(fbo_max_lrs, _MAX_LBA_RANGE_SIZE, 4);
> +UFS_FBO_DESC_PARAM(fbo_min_lrs, _MIN_LBA_RANGE_SIZE, 4);
> +UFS_FBO_DESC_PARAM(fbo_max_lrc, _MAX_LBA_RANGE_CONUT, 1);
> +UFS_FBO_DESC_PARAM(fbo_lra, _MAX_LBA_RANGE_ALIGNMENT, 2);
> +
> +static struct attribute *ufs_sysfs_fbo_descriptor[] =3D {
> +       &dev_attr_fbo_version.attr,
> +       &dev_attr_fbo_rec_lrs.attr,
> +       &dev_attr_fbo_max_lrs.attr,
> +       &dev_attr_fbo_min_lrs.attr,
> +       &dev_attr_fbo_max_lrc.attr,
> +       &dev_attr_fbo_lra.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group ufs_sysfs_fbo_descriptor_group =3D {
> +       .name =3D "fbo_descriptor",
> +       .attrs =3D ufs_sysfs_fbo_descriptor, };
> +
>  #define UFS_POWER_DESC_PARAM(_name, _uname, _index)                    \
>  static ssize_t _name##_index##_show(struct device *dev,                 =
       \
>         struct device_attribute *attr, char *buf)                       \
> @@ -1220,6 +1245,7 @@ static const struct attribute_group
> *ufs_sysfs_groups[] =3D {
>         &ufs_sysfs_interconnect_descriptor_group,
>         &ufs_sysfs_geometry_descriptor_group,
>         &ufs_sysfs_health_descriptor_group,
> +       &ufs_sysfs_fbo_descriptor_group,
>         &ufs_sysfs_power_descriptor_group,
>         &ufs_sysfs_string_descriptors_group,
>         &ufs_sysfs_flags_group,
> diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h index
> 1bba3fead2ce..c3fd954ce005 100644
> --- a/include/ufs/ufs.h
> +++ b/include/ufs/ufs.h
> @@ -179,6 +179,7 @@ enum desc_idn {
>         QUERY_DESC_IDN_GEOMETRY         =3D 0x7,
>         QUERY_DESC_IDN_POWER            =3D 0x8,
>         QUERY_DESC_IDN_HEALTH           =3D 0x9,
> +       QUERY_DESC_IDN_FBO              =3D 0xA,
>         QUERY_DESC_IDN_MAX,
>  };
>=20
> @@ -319,6 +320,17 @@ enum health_desc_param {
>         HEALTH_DESC_PARAM_LIFE_TIME_EST_B       =3D 0x4,
>  };
>=20
> +/* File-based Optimization descriptor parameters offsets in bytes */
> +enum fbo_desc_param {
> +       FBO_DESC_PARAM_LEN                      =3D 0x0,
> +       FBO_DESC_PARAM_VERSION                  =3D 0x1,
> +       FBO_DESC_PARAM_REC_LBA_RANGE_SIZE       =3D 0x3,
> +       FBO_DESC_PARAM_MAX_LBA_RANGE_SIZE       =3D 0x7,
> +       FBO_DESC_PARAM_MIN_LBA_RANGE_SIZE       =3D 0xB,
> +       FBO_DESC_PARAM_MAX_LBA_RANGE_CONUT      =3D 0xF,
> +       FBO_DESC_PARAM_MAX_LBA_RANGE_ALIGNMENT  =3D 0x10, };
> +
>  /* WriteBooster buffer mode */
>  enum {
>         WB_BUF_MODE_LU_DEDICATED        =3D 0x0,
> @@ -352,6 +364,7 @@ enum {
>         UFS_DEV_EXT_TEMP_NOTIF          =3D BIT(6),
>         UFS_DEV_HPB_SUPPORT             =3D BIT(7),
>         UFS_DEV_WRITE_BOOSTER_SUP       =3D BIT(8),
> +       UFS_DEV_FBO_SUP                 =3D BIT(17),
>  };
>  #define UFS_DEV_HPB_SUPPORT_VERSION            0x310
>=20
> --
> 2.38.1

