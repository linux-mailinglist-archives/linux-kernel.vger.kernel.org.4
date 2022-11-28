Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313F863B62D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiK1XyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbiK1XyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:54:04 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2104.outbound.protection.outlook.com [40.107.113.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E76A14D33;
        Mon, 28 Nov 2022 15:54:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/ncrzW0/FD4U+BxnJSg3mAYqKLP7+rj/qhEqgBc0dC1SLQgCNea4TvlV6OkytO12yJsYURJuvVdLeV8n2FYwZ035unn2/RsGk1ChjkhZq3j/xmoy8f4w3KWVDlf31xj6EPmxybVWr94e/2s+sy6UBnOphXUbet2YLAq8Bx7brz+thn+WBBdmlWV57WjIacvmN2fhfsNG0mpEG2ZDNu9229FWd/l27ukwWzHUmILW9k4bd9bCgrC8kzMMDatkBn+J9Jcp7mbzLqMWya1zJGF1Xdddsl5/Rf6JqBaL76psPrKKA9kzZZ3hEHYrzg45Abwd32v3EE345G8GRjaqOg98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HX+0PmQp36/2l4TZL9L23ZFjRL0nVzvu99j9OEO0hDc=;
 b=jvOK/m4dO6NNCae8kgiIhnz1/bnLW+3Pb0CDd9/qhiHOGcm6BrTn7MfjNmZBKJPoHCuHL8rwnUW9VixLVY/3Q37Blb71d0uQ+ncrDp/lUMblukRsYtL7OVjvFtsDbFmmaPLXjpNXnd5ITTZR2OSX6hUI0nzFc8WzOicqgy/QOEsNVfRCQ8C4MF/DIyqWrDRoXRHKPY9+sYMmcKmMTU4CM5n6Bz/XBO3m58TW0JMLtCHTYpdupQNK0URI1ryd8R2t8+VLo9dMZL9ory8GxZqHkeMfh+Sx8tpNxKc2/Q25krWyi3v3n12p+AqCfWsCPZT7UDlKJDo8TVyMRpIX0Pbc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HX+0PmQp36/2l4TZL9L23ZFjRL0nVzvu99j9OEO0hDc=;
 b=mPHYjGv2RjQExjGGsjBeizhRVxWc+akJ9yc5CcHyTpzvIz0wU6ktyOJT5JTaaMrcrBUpArstjc4/LfCvn6rW2rsCdrOTCcUFpljxYt+HQmEyoBvg+N4ilBmIWv0o1UBais4iW4HveLJDUi2UacfOLDfwJiLKwk9UYhuEYAkOFPo=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS0PR01MB5492.jpnprd01.prod.outlook.com (2603:1096:604:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 23:53:59 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2b87:97f9:d59f:8839]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2b87:97f9:d59f:8839%5]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 23:53:58 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] media: rzg2l-cru: Remove unnecessary shadowing of ret in
 rzg2l_csi2_s_stream()
Thread-Topic: [PATCH] media: rzg2l-cru: Remove unnecessary shadowing of ret in
 rzg2l_csi2_s_stream()
Thread-Index: AQHZAvD+TzEN+26BO0Oadq85NNUNv65VAWvg
Date:   Mon, 28 Nov 2022 23:53:58 +0000
Message-ID: <OSZPR01MB7019DDDF3BE79CABBD8A582FAA139@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20221128061622.1470489-1-nathan@kernel.org>
In-Reply-To: <20221128061622.1470489-1-nathan@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OS0PR01MB5492:EE_
x-ms-office365-filtering-correlation-id: 3b49d1fa-717e-47aa-2426-08dad19bd154
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GbXXGkLade4vPuCny5nsPTThob5QYWDXmews5hcaeKwoDc3fG4xQR7iH2nJSdfL9a7CzhSZ1yQQgv9CpKugUKllQLFJe9bBQB2K8bE0ScHWzRnU5glhuI2naQdtuJ9LJaFBSMP9qrWBGF80fmVIMTdUgbnz6bipHf38quSsODI2cv0GNCPV81OVw99rxDudK/J5bK72Qgb6nRTDDAFIRT7DXx6rsGwPT+I79mGcuUc61HufucwCNW4Vqs5Ogrz7SHfQBeylFg9gPJiR+Ho+fJ9sUEz39MMPF+49STbjHGBKHFOQQpDzWlDkXH49TD+G+2DDbZLSSP7G/3dEEwaJVsGpLAmV6Us1oYzGKi4hNJnvGXmZwnsfblHFeJ1x859aycIcJpo7KzUJa8ohcGdnIt0EP6pkcWst+4UyMhkvC02ks/uR48z1LriUlv3uvY5TG3frP71lteRMTHZTox3O0K3wQOQgmC6qexQz2XvYEqdvAEiHXrgIr8qP34Req26EDwe2sovl4ZfH41wzLB/RdaW8ll34P3eAmKFuZes2yVoT1UM0BMPqDk7XcDFJLdrCGyJfFC/bIMndHeQt/BAuxYu+mfxPaM65qggjyjWFLL8CuixYopfDXEuzz/wGiIV2UX0qXl9TikpRahEIj/cA2xCfAVBS6gi0ZDson7RIjhAyG2jPhMYqr9FmnF7HKvpnayJVwuVYqZEv6ILJleM2f5WIdqeCcHCG8XOQ4jckTYa0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199015)(55016003)(38070700005)(2906002)(33656002)(86362001)(7696005)(71200400001)(966005)(478600001)(53546011)(6506007)(316002)(76116006)(66446008)(52536014)(66946007)(41300700001)(66476007)(45080400002)(5660300002)(4326008)(8676002)(54906003)(64756008)(66556008)(26005)(110136005)(8936002)(122000001)(9686003)(38100700002)(83380400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zeFVKnLvzob2kPGIjNbzjFmRo5+z8n9NDzVRdv0sYpsDuZN8zrwtiO5cGcTm?=
 =?us-ascii?Q?DLhVkoJmtIzcDBC3QIlAbpaKzyv+4l8jm8hL5Aa7LadeFFRUe+ECpJPo284o?=
 =?us-ascii?Q?mwpNdOdENhUU/F57QM1JUWOvQKy/WWMNjVQDrcUAwxwY1vdlOD1npEtx1IOx?=
 =?us-ascii?Q?M6DHJEYXVW7QpJ0nsdsLkSlk4pKv7pMpAPTFLYGzBEZtUe5SBc1m8hcrMvFA?=
 =?us-ascii?Q?EDzRhIaiC6+PdArALbc8ARTAQKrEHUJYAcScG1UR0My+1nQhCa2IecQVJDT5?=
 =?us-ascii?Q?dh6eddqHu4dw0+2kSRZukPqmybG3tVGqGFG3tmTsiZQqIITo+cCltkzkJwv7?=
 =?us-ascii?Q?EPd15sNfQggq4WGzOnJZ/HhuwPnAHD5rQ0Z9qtLSmqVikh5V/dFtE+c+ChS0?=
 =?us-ascii?Q?goZm3Oi0PjCFMM0EIethGcS9pyf8+/s0JJMhik6AgpqQ4kzYiDimNxgB9TGj?=
 =?us-ascii?Q?Wat3o5wTOZo09Nhv1pp+adsJG1DVywj8xLZvL5CxjR2eUOSS6uNRElJRbcwv?=
 =?us-ascii?Q?h5By62LuMmQFKlseMaMfqfGh7InrQScr7ZZi74iutEQ7Csj8TPAOaR0yHcLz?=
 =?us-ascii?Q?qxDc/5zw2Jc0X4kWBpdMDLoe9iEEXUsV8QGWkRLoDtlVfh4PXFQ5LE5V5/16?=
 =?us-ascii?Q?E2jt6Pdr2q7M8TkEiG4RfW1ItuaXn5w9Wl09kziH65VUtBoFEuamou+kZ0jk?=
 =?us-ascii?Q?mzVEBG6eJOYZ2vGVqdGpcqYZ0fLpC8LQU4V88X6ht5GuNR8HqjA0XSn9qm72?=
 =?us-ascii?Q?ktShrnEKEoZcdgj8J92Z5vJIhiqT0COeFLdOLnSTuqzqwlgsJOeG9ZTIadly?=
 =?us-ascii?Q?VYml0ZIkO93ONqvVHLa2VXGADQjy8EULSeXJvo39y2nR6b/PAJc1W5pvsTDh?=
 =?us-ascii?Q?wT4rskUiCrTudvuIl+hw+AeYlv6qtuk8/1+V5CYZfBs1o3RT7XJYax0bCwkX?=
 =?us-ascii?Q?yxodWW3OuB2uJEMnpzhxZjueKsfUwmG66Q5Op9pG3jIw+dEbU5Y3FyQphb49?=
 =?us-ascii?Q?HYJJa7EpjLVUzRRppGMXCp4E/cDNlX3xnITVVId40L1xq2H2K2beeEMW/cMF?=
 =?us-ascii?Q?iAfE9Tcq6UudVSPqGk64Q84dagSicnzDz23JfFFIavsPDXLPpCBMvCqYEoYP?=
 =?us-ascii?Q?WliPk5XeCP7CKXwC/q2/MnOUCpI8Et3fVrF/G+/caLhrOveIqPl5RsD0EIH9?=
 =?us-ascii?Q?RL/pz7SOPtinOV1vq1OzRIT4JKBMb02ZEBpv0dCgiydE4ygu9dr4LbfDH1nU?=
 =?us-ascii?Q?zKE7H88C//zHcPc7sI2Qq30H8irnORKJ0iymhG3i9wz7uEiPq5rXa1exOe2G?=
 =?us-ascii?Q?T8z02R8uvpvN8tHLmQJapfAXsSZUs27RczVqDwQj0VEHAMTRShBmgMqKyQI2?=
 =?us-ascii?Q?lH5nypmQSbiyBPyS3d31QizzbVMw7naGZZWShJRZ/dpPzqAw4kXeKe9i8hQm?=
 =?us-ascii?Q?VxTIhsHuhv4rHNuXZpmTTYo/DVVba38K6k8wi/C5DS+JPB7eKWhYUAGIb0pW?=
 =?us-ascii?Q?LtG0WmwcDmqwap9AlhWjT56e3gtp0a8KXUarJawt52Kf9uWJPgI9f3SCcHho?=
 =?us-ascii?Q?9EYthjrNzKx0J/PXQmEoCIsnq3znHgcAoMrTpsxGXhvDnf6JWR4aoWNsh8VQ?=
 =?us-ascii?Q?d8V37M1GbjcN9ZbnYNpwMG4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b49d1fa-717e-47aa-2426-08dad19bd154
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 23:53:58.8122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZyKMXg3yVibY+jfWSPqJXgxRQ3koM8lv0f68p+f+Wq8UtARqwktfJnnCi28+xhCQtaR5k/0ffTXLkrf9n4vHSwbOFgFIZwWN4h/NgW+HnK/YXY2jB3Fg2+FkY6xAXy9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5492
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

Thank you for the patch.

> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
> Sent: 28 November 2022 06:16
> To: Mauro Carvalho Chehab <mchehab@kernel.org>; Sakari Ailus <sakari.ailu=
s@linux.intel.com>; Prabhakar
> Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>; Tom Rix <trix@redhat.com>=
; linux-
> media@vger.kernel.org; linux-kernel@vger.kernel.org; llvm@lists.linux.dev=
; patches@lists.linux.dev;
> Nathan Chancellor <nathan@kernel.org>
> Subject: [PATCH] media: rzg2l-cru: Remove unnecessary shadowing of ret in=
 rzg2l_csi2_s_stream()
>=20
> Clang warns:
>=20
>   drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:445:7: error: var=
iable 'ret' is used
> uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninit=
ialized]
>                   if (ret)
>                       ^~~
>   drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:475:9: note: unin=
itialized use occurs here
>           return ret;
>                 ^~~
>   drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:445:3: note: remo=
ve the 'if' if its condition
> is always false
>                   if (ret)
>                   ^~~~~~~~
>   drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:441:7: error: var=
iable 'ret' is used
> uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninit=
ialized]
>                   if (ret)
>                       ^~~
>   drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:475:9: note: unin=
itialized use occurs here
>           return ret;
>                 ^~~
>   drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:441:3: note: remo=
ve the 'if' if its condition
> is always false
>                   if (ret)
>                   ^~~~~~~~
>   drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:431:9: note: init=
ialize the variable 'ret' to
> silence this warning
>           int ret;
>                 ^
>                   =3D 0
>   2 errors generated.
>=20
> ret is unnecessarily shadowed, meaning the assignments to ret within the =
first 'if (enable)' block are
> only applied to the inner scope, not the outer one as intended. Remove th=
e shadowing to fix the
> warnings and make everything work correctly.
>=20
> Fixes: 51e8415e39a9 ("media: platform: Add Renesas RZ/G2L MIPI CSI-2 rece=
iver driver")
> Link:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.com%2FClangBuiltLinux%2Flinux
> %2Fissues%2F1764&amp;data=3D05%7C01%7Cprabhakar.mahadev-
> lad.rj%40bp.renesas.com%7C76d2a49f939a46e8d15208dad1081ed7%7C53d82571da19=
47e49cb4625a166a4a2a%7C0%7C0%
> 7C638052130064697087%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dfp%2F1JCtgKY8E6qVMRlLewVLYc9WDZ%2By=
Ntg6t%2BGqIUvk%3D&amp;reserved=3D
> 0
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar
