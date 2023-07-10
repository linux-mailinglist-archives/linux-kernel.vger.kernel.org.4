Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154B474CC24
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjGJFWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjGJFWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:22:14 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021017.outbound.protection.outlook.com [52.101.57.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74894E5E;
        Sun,  9 Jul 2023 22:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh6rxUNT3iSyXL3iZKhIPyw8BpBmgDICXqjLAeAVCmB020s8YHZMJU8LSFh8kxyjwyCZZHPbCaKCFNHrbmc5O7ReFGlzaeNXBUM5RwCkkrAJ50mdja6p8KDFiD6NxN9EgaGhCG0Q3a+tg6U5AMqDrSSDXyJr2IulznzNb8Ym2UN4xiKxsWgj2JSN1LDMqw/HLrgKOMaSEqCC4mffU7eQYHuZUh7Cv/wvG3BycOtexZSK42dlsjm1XR31ewNLAHGTrAjPmjhCzXwJ8oOFe2oK4xPt6kclTb57xXy2xPxDBPG1AICONuZmouowTMHcsHPwPj/lVVobL2H5hI/d4bAzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJcpo+XniRrmz29tRe/QDcTSvLS8jnmDbKzFaIwEi1E=;
 b=hmiOP9EClQ4jnvRekhu3QgUcYVl3cYFpAkxyAUNRVOkTgmnZj1pADPBRkRUS0EJ2PlrrSSKOSu9OrZq2P0fG6oyyJOxMmf/JonSj9H596/XICY5np8UIh+JqZQhDSTml3y9WvhCuonHCXDzO/E5KEp/1Kwz/wO9/E+WVts2wtczBk8xOTXzDyUmosOE9YyqQiCTMQ0xLJHilrTNmql56ZcTtx91cqe9dSEWZj1p6Wqnckj87+yGYX+9WysjwB9P8ONMFyHjKmdJ3+6+DMUy251hX1awb/SWr2skZVs3qQhkl/qCnzvnqikj0k2MHnotegvfjEx+37rTjLu2cOoGszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJcpo+XniRrmz29tRe/QDcTSvLS8jnmDbKzFaIwEi1E=;
 b=jXO/f27MMuwU710mFxj/Or6YtSYZ/M+hIMSxBOsXhwGnyl3CxhsnEZ76s+FFiSju97xN731IfEddo+SQ1tJtx9B0tXHBmH93cLt5Wo7NltyX+WanwLYgTOxy2ykb54QeIYx69MSZRUVvVhXFnu66UZ6aHah0MT8mqxIaIv4Kto0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3418.namprd21.prod.outlook.com (2603:10b6:8:a0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.5; Mon, 10 Jul 2023 05:20:57 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::733d:6263:4482:ba25]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::733d:6263:4482:ba25%4]) with mapi id 15.20.6609.003; Mon, 10 Jul 2023
 05:20:57 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Deepak Rawat <drawat.floss@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] drm/hyperv: Fix a compilation issue because of not
 including screen_info.h
Thread-Topic: [PATCH] drm/hyperv: Fix a compilation issue because of not
 including screen_info.h
Thread-Index: AQHZskzhHjpexil9OkqzMs7njg+Rwq+yd3iw
Date:   Mon, 10 Jul 2023 05:20:56 +0000
Message-ID: <BYAPR21MB16887E35CE80D293DE2243E0D730A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230709100514.703759-1-suijingfeng@loongson.cn>
In-Reply-To: <20230709100514.703759-1-suijingfeng@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=aced5778-1600-41dd-aa1b-cffb2d361d0f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-10T05:19:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3418:EE_
x-ms-office365-filtering-correlation-id: 03a967ff-a7aa-4fd0-cbb2-08db810570c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G9U7oBJOiRRSoXo4u5nFTVeGemN5jFiAcys9O9J/ENZuB6KXbNN3DguwHPNv9jfxX6urnpV3bPFUymlYVLtYfC5z7WH2RupRVserc0L63+jZTlXE1XKqSMfzr+krUCDYe/VSLouB9iEkGEzMckHBzT0awu3b47g+onL5n/mdiK/kPrPYlgflMRPzmOtk4ad9x6CfmeexIc8ZVKWoF/gJkEvkNa2WgDZpBI3cIE2+OuxEvIUs6CfFm27Xtf29lwST3FfXaqY7RXjz7f2H22t/ajtQepbzwr92bHYpp6H3UmxlI+gzbQ932/5clTL4E9qPCEM2rWhPbTy5HBkZtqpKUZO4o1DFnZRyKW1PJXbvu/qOmAoFPT9dw5G9xw50Iuw2PStzlpXlcYZlyWHdq6sDNS8ueTiIWkqbvscUFJ3pK9SZfRGr4gSQopug+L+w9hz4EswNQNNsItj8Bpm0vvBK9I82/hvVm3hNHJxioBdkbMSlt3u+PC9ADNkxVum7saY/jrkv9hG/UzgqXXx2D9j7Wb9p5au56PJ58j98qR25gphE7+/eGup5HvGYzhTxSDaaiJ4D8+7MysgUEuDNvxDuWGE1CCOAxdiJzBjONkih8tCtT52X1EBOgIaNtiPKKeM49aVNBAF8epHflOP7vK00SQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(8990500004)(2906002)(83380400001)(82960400001)(55016003)(76116006)(9686003)(6506007)(71200400001)(52536014)(5660300002)(186003)(8936002)(8676002)(26005)(38070700005)(7416002)(38100700002)(86362001)(82950400001)(33656002)(316002)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(41300700001)(122000001)(478600001)(110136005)(966005)(7696005)(54906003)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?83/CgWVFLJ6INpZaxAf18yBjXjN1m44HM8O9C/O2AEyNn6RgbWLwIzlLBgQO?=
 =?us-ascii?Q?0uYiJulWUL5lwk+OktDq7zHhD3yudIP0lkI+bf6oLFj5zSAVqXLl/ln7QyX0?=
 =?us-ascii?Q?zfdlK2D2R3sEAMH/LdYkePk6+N+8y91SaF+cwomBdhMsSvGDb5CA9YCAY6NJ?=
 =?us-ascii?Q?ib6i7VcsBo3EqA6GMcu+u2W/p/hTxoBOGELrzNNkh1eIMP9bGbDISI1lW3LI?=
 =?us-ascii?Q?DgsycnW1g00MwbgI6XxOL06QWm/4dVwPvfvOTGOo3pbs2HWEcRKtwJzrW/UO?=
 =?us-ascii?Q?75JYaRp1WlmsH5B8FmT7a6FIHnk6H1rHyhqes1FPGUZknorDqdlp54PutWXj?=
 =?us-ascii?Q?GPlh7fP4qTIt4FSrjpMYuJc4yUEKF2QbwSD9x5R+EZV4EO89Fp5lzADsq35i?=
 =?us-ascii?Q?y6jkk6lEfH0QTFKOMI94+K/cHkM4y9g2bi4PaEC/+bc8+DbtzMKEUcuR3Ats?=
 =?us-ascii?Q?Ob+XStsbtWIh5KnXOTg38vnu4TC2nZG97IVBDUTl6rMQWAj2jHaK+lIqtMWc?=
 =?us-ascii?Q?qhOi4B6Bb2FHH/jQWVpKvFGL0yqcmLji7DUsT7eFBJEzXSraBIz3+tno0AzJ?=
 =?us-ascii?Q?Cagq6mBD841CZC9w7qlt6QbWeZKBXk5pdwK8NCJIrOl1lMbbvFTKrIiqXIyy?=
 =?us-ascii?Q?JUNk86afMFWVU48mJfbdjeAF1Q//xty2UKZZcH7SJ/TDlXoM9tZIcli5gGax?=
 =?us-ascii?Q?gC11hjKXrhuUvfCgKBGAAnUoUPH8QQT6ll2VPX7t2v8YOD0Y5FCl+GdgOPO0?=
 =?us-ascii?Q?zQN6KTo7wQjg2aXcUceXp2Z0HmAVNGC+RV8PHQFsV81kfxupwNFxQ3jxkjI3?=
 =?us-ascii?Q?1USYx6ZXHKizPENuNDgp2wuqVxCg0zLHmdpJJ+w9PhgKPpA8zwr3GgBq3avh?=
 =?us-ascii?Q?9x1fMZct7DZKaGuynBITWbsTKyqGMbDFXAYWnvCRhdwv2tHNSmNmeWwmGiix?=
 =?us-ascii?Q?euKacVxZ9PUd1ZONaJHr1jbhNScqPUnxG/nT1t58jTraKinZQZPdP7/zZW4a?=
 =?us-ascii?Q?Pp4kGuMWDrP7pFmLj4MZqs3Xq973pfsBamWM5hCHN+FZh/hrAxRdHyjFs4V/?=
 =?us-ascii?Q?p/AyK8iFzrLqE0KCtjS3ddaMBWjeOPMyOTvjSLAbfkzSJx1ycVHbs0N0dcmc?=
 =?us-ascii?Q?ibiHpTK6MAv6587xtNermD9jaqqve1DN2hFNqehSyVgc4QD4xi5ew08RlOpB?=
 =?us-ascii?Q?bEMGYcrQjWxHE4exVK4dxE0eiZpFiAg1dr4m4wcCs4JPQBeGFrwAPZRsC5eo?=
 =?us-ascii?Q?U5N4rAe296YK7jUSl/byvXLd0N9/Wx4C8mRuJpEGnPFY4TkXqsoouzBVl55A?=
 =?us-ascii?Q?hPsTNLO8UDVl4A0hUYfc5B+wt0IpddXRwodI9ZxkPfAuqifzRJj4uUWHRGEe?=
 =?us-ascii?Q?kF3gNYG0vA54qvom33xkZ2oP0vZ+hlC4FRNEyi6fesJ1yM58KePtvWtv0z3I?=
 =?us-ascii?Q?jv6u2ZypOf3kn1vTmOmwH1ilT4zPiSQ7myKpZZeuk+z9V7QWYupxELjwOIVV?=
 =?us-ascii?Q?bsOgco8qleOqYMep1hgQXpmKkPlOnc/p1lQ6+xIqUTHpGiv7U2+tSqmBH519?=
 =?us-ascii?Q?MypmM4rw8H4/cCBXToWNK7ukPHiSZL+NpRICjufsKaLdR1Nj5TbqrVT47MvQ?=
 =?us-ascii?Q?nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a967ff-a7aa-4fd0-cbb2-08db810570c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 05:20:56.9467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwTV98EswrPxcDLnmAqMkTQcUrc+8HxIZhiNuOcpJRZ9CXpM/5UV7MQWaTuD6YYBkk8pRLaM+uuRb4i5+saSd9Ic+4UwfR6BFOgPiHjycNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3418
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn> Sent: Sunday, July 9, 2023 3:0=
5 AM
>=20
>    drivers/video/fbdev/hyperv_fb.c: In function 'hvfb_getmem':
> >> drivers/video/fbdev/hyperv_fb.c:1033:24: error: 'screen_info' undeclar=
ed (first use
> in this function)
>     1033 |                 base =3D screen_info.lfb_base;
>          |                        ^~~~~~~~~~~
>    drivers/video/fbdev/hyperv_fb.c:1033:24: note: each undeclared identif=
ier is reported
> only once for each function it appears in
> --
>    drivers/gpu/drm/hyperv/hyperv_drm_drv.c: In function 'hyperv_setup_vra=
m':
> >> drivers/gpu/drm/hyperv/hyperv_drm_drv.c:75:54: error: 'screen_info' un=
declared
> (first use in this function)
>       75 |         drm_aperture_remove_conflicting_framebuffers(screen_in=
fo.lfb_base,
>          |                                                      ^~~~~~~~~=
~~
>    drivers/gpu/drm/hyperv/hyperv_drm_drv.c:75:54: note: each undeclared i=
dentifier is
> reported only once for each function it appears in
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307090823.nxnT8Kk5-lkp@i=
ntel.com/
> Fixes: 81d2393485f0 ("fbdev/hyperv-fb: Do not set struct fb_info.aperture=
s")
> Fixes: 8b0d13545b09 ("efi: Do not include <linux/screen_info.h> from EFI =
header")
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index a7d2c92d6c6a..8026118c6e03 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -7,6 +7,7 @@
>  #include <linux/hyperv.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/screen_info.h>
>=20
>  #include <drm/drm_aperture.h>
>  #include <drm/drm_atomic_helper.h>
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
