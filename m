Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A1A6DC234
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 02:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjDJAsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 20:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDJAsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 20:48:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB3A2D79
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 17:48:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgBEtFfzhuZ/ec16DSi3zNRHh4C+mHyOgguywZ1CZp/tDuBTRrDqHLZB+IRDelDGH/Fe1TJ8Z0JgjVtBWkwb0YD/xb+xbsl3VYbq8OL4DoMJ2a7r/WAQQsZ4TIcO7HWitVShIJzAr9RNqaoe7zUfQF3qznPY1gRGlqd7mRhwVCq19eXXPaQMzc4NqOQwiD1RA+5YVBzRi5xQN6eA0G02Ejv1Mi2JMnFeM3KLF0+UYUs3avvEaLm4Aeb4KUTGHmRoFtEpyrkI5xIE3mMNYXGzjzEfDgvJAp+psLXVEviZYjcRb1IGF10ZTS525+UF6mr6fJc1gE9F+tf2h6ugeZlzww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KA9cgTrroobhv0JaXUUyguS3+s4N2ASpdqufvhrntTE=;
 b=nDMqcFp0mMD07bDrODBNgYp60lx4lcHQikIO9cXW3X0alDmyvY945UX4c2aJV1XCd7eK/wMHa4MhVnH9YDUwChLToJwOf9cKG9/oRpGSGyl988usG9PN9hPtoUWN5bNx4FOf8wfE+v3IS+iLimWeEK2ADnC8Aio932XeKYA491ki5wKZNf08iV4PHqtaqjHUBRyXI457zoezq4r9WYTE9irdPPgZDr8Wki0TJhN/McrHR6J7d62a8uVZJzfxjC5uQ9dtgobDFy8HIfOi0oG3+OWPiv3hMMPXt9hJ5znICUAFyRu2udfizWsMPMZyumetSh6POJ/F3Bo+3YiuZj+OHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KA9cgTrroobhv0JaXUUyguS3+s4N2ASpdqufvhrntTE=;
 b=j9SCrwDpuumSVwA6QYtHqN0ImwAZSO1luyLY6fkkXwoJJylgisNrIuzTv9re9vIQM43WvqQ5g79llEXwFE7ZStr/plflr+mlADKEqSzaYMIFpKcec4NEbKg+MoXPTCpChkEd80glql2FYT4tJQK89ubn6a+wtG05uq4r+fBoJKg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.34; Mon, 10 Apr 2023 00:48:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::f005:3ff3:4f85:d51c]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::f005:3ff3:4f85:d51c%5]) with mapi id 15.20.6277.034; Mon, 10 Apr 2023
 00:48:05 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     Tom Rix <trix@redhat.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Zhang, Hawking" <Hawking.Zhang@amd.com>,
        "Feng, Kenneth" <Kenneth.Feng@amd.com>,
        "Lazar, Lijo" <Lijo.Lazar@amd.com>,
        "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
        "Huang, Tim" <Tim.Huang@amd.com>,
        "andrealmeid@igalia.com" <andrealmeid@igalia.com>,
        "Liu, Kun" <Kun.Liu2@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH] drm/amd/pm: remove unused num_of_active_display variable
Thread-Topic: [PATCH] drm/amd/pm: remove unused num_of_active_display variable
Thread-Index: AQHZY++NgSlsZGATD0eXp4HTRVf+Ka8jxDgA
Date:   Mon, 10 Apr 2023 00:48:04 +0000
Message-ID: <DM6PR12MB26199298CA3AFC2736E8E9CDE4959@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230331164041.1859088-1-trix@redhat.com>
In-Reply-To: <20230331164041.1859088-1-trix@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-10T00:48:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3c994438-802a-4b08-86da-449afd805379;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DS7PR12MB5720:EE_
x-ms-office365-filtering-correlation-id: afbf2686-163d-4c91-a1c0-08db395d3e7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n6n6iSE6KBUDK/4iqAenwfulq3iyTXbAWOjJv3CPZ2UWrVH2PCksP8K6/rLKs8e5snYGQupWLxa59XNsNK/EeIGp0l5nHyOPCDxK/LGieXZjnCpHIxLPMjLvyKpmTxY71w03+YuDKdyZS1vqWW9GGUQgp5Gpk/25mrYl2cu7tu3qqKw9/ymzLAbRt/I3OWtIX3K4ZTbFSiicfWh4USJ0Y6cNLO7re08IUE6oeADLdaxjG0fy3uXM2xaGLdpJqkUolZAkpUYFYyoirfWRs2ZYzooDliVYOc23+Q4JXn30Y2puvQ1pZxWSn8rfD1dcBbIIK/dWqlQhBm4/GiyqdUVf7RO0X+FYz0LQ9fLTPrBD7pUFkTTB5Yya1Zp1rSo9C2oiTba+uQF+8hM/WZyWZwwEzFHnB2LBLB1DJs8uJlcrbSVXR0ZXGAi+/mkbNw4UZy+0Jnvom/WdHzfRTvhmnipAAipJhbZBwK+6smvEHKV3AVJ84UPrEepGvRNetynK9LIdCgEmxgg0672Gs+kxTEZsw+kkg25gd2ndTsPcqevlnw1ltnNh8d020YYkvRQH8wnN3wWFdeGOJSj5t0VIjDKJziXzLGaObNrSzE/nu9+2QW8lIQ3EwtRITD1wEFOPX/0zv9RGH90BF1J16MZs63V8pQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2619.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199021)(316002)(6636002)(66446008)(110136005)(54906003)(64756008)(66556008)(66476007)(4326008)(76116006)(66946007)(86362001)(478600001)(8676002)(7696005)(71200400001)(55016003)(5660300002)(8936002)(41300700001)(52536014)(2906002)(7416002)(921005)(38070700005)(122000001)(33656002)(38100700002)(186003)(26005)(9686003)(6506007)(83380400001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aHIM/BkoRRf2Kij5toaH0BlafKGit3Mk/+eKVrbaiG1q1dG90yTYPH64gY8v?=
 =?us-ascii?Q?hTRClet5dj2LmBr1YFtMvokafpIVcakEyC1rI/BomNCtrPG2+232J60oE9IS?=
 =?us-ascii?Q?DWXlBFh18sZ+7wvH4BtucwKtqMpVRJpHvQER0he80PM0VuNPKV/OkWTMoGuu?=
 =?us-ascii?Q?Zgsga3fzSCTr9chCnSQ7K4xH4EkCLxocUqwdkOPLiKC+omTXt9GRKXtnPm1Y?=
 =?us-ascii?Q?3D+O0NOzgr1E9t+O5pX7Z5KNRzv+s98wRn89MmvPGjva0HdAXGnCjEttv6I5?=
 =?us-ascii?Q?8z7MUsiTYzgrAsYP8DfTVU8oMe14ryYMgzXeot7LuK2nRODb//62gfMZp0pc?=
 =?us-ascii?Q?iobXmUS9H3u3XgU0yVx/4jgX2/iQ9lbwJDZ9iYWMYU93+2cNFNP1N67+zsez?=
 =?us-ascii?Q?b1xgOt9lz98PkbFkvMe3GNC+ZsQ44KoW0zihj7iqNmyBA2MYCMFF0G3y8snD?=
 =?us-ascii?Q?HYklY6gYBXGe8znkFh+43N62Z2YPk7OVGiWkqQqvrob01H6h7YNIDfZuPkdo?=
 =?us-ascii?Q?2RjKCPqxu2m8PrgsMqYB7lN9vC8qxmfsen894bWPzOhNXg0+WTnlmGDemW9q?=
 =?us-ascii?Q?LvYr/yj5E1W5AkiriKRN7ZzkcQKizDuYU4KFGhBTukeA+J9dTtvlf65Hb4mP?=
 =?us-ascii?Q?MZLHI9r6bT+T6p2b+uc2sqjozI4FbiBhbK3mVQm0Kf3Mj+LiQ3IN6iSe07bf?=
 =?us-ascii?Q?iZ+UBLqC1FsYFqnVyrCBW0UW1nGaeuBBvHKqmWamIdc8ZoBW+9PoD9l9v/3u?=
 =?us-ascii?Q?w9YFmFnOySKJ8SEJyKRMAixtaa9HVFmwkZg2K1KOnYyzhD6Xza6f5sT04Caf?=
 =?us-ascii?Q?8h3+Uqpz5a2tq771vyDzY81U6rzg4LiB2EsAt95ebo/K9HAyBoZ8RuAoMdpS?=
 =?us-ascii?Q?50Ps5zFVp06/ZUrME0Cqy7TaJ0eECAIK7RCqSkJj6d2ZWre7iKLbv9XYY9D8?=
 =?us-ascii?Q?9AJoY0wXnLrGDn/f0Onqg/Eo3K7bYBoxVLbiJSIGeJRD5hD2YQuW7fZJd5Iv?=
 =?us-ascii?Q?3DbTy1bd5tTgMM8/O23dRWd2HQqLvEBnGYe3/9flBBXtfoke06IXw4FfQ5gM?=
 =?us-ascii?Q?ioPI/CLRdyH2fxG6uI7ZaAZAXAhG2X7JX+Rxy3Xw+4DHAZLaSji5Cnc0yr0j?=
 =?us-ascii?Q?DAXKIKXpPsd1EpJqomkMn3BjmfgWM1sBPpsCkPoplNP+YqRPYwTAzatnumuD?=
 =?us-ascii?Q?sAk4vMznjz8h4NGkvZmVQ3U04QxNPHlwB8h7GupMXpac729/egop//lCGSC5?=
 =?us-ascii?Q?0BX+9Cv3ImxyBlIDhhSILoV/sI4411Jg/C8H7/SnLm+Xjmq+LuyjrfJb3ngn?=
 =?us-ascii?Q?H+W56Jkf1yQKcRAuoK+D2nP9hnytWcdjvw0UkEbbS118uQ0B6pwpsv3C7FI0?=
 =?us-ascii?Q?lwuGRlvuCR89yIYjLvUcAPBel4v8v6skpOD7HB3KG2bJ+i8djLR41v31LU06?=
 =?us-ascii?Q?5UqZwiTrm2Fa34JuJNzbdrCgqEY4wSbHImMUOdIrAwzhRauxXvZNqhsQ3Gzt?=
 =?us-ascii?Q?Pkd10dh4tRZVi/FfaMTnUD4bODm0vB9a8c0PpVqWIjq8MULx/LN5q8kunmcb?=
 =?us-ascii?Q?q2w+0BHkg6iseHO7VdU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afbf2686-163d-4c91-a1c0-08db395d3e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 00:48:04.5817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UrEoPbEYlO39MTGnqPy75bu5oM439zG1Yz35pi59YmsbiStIeR0lz6EL6VBQ+Eix
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Tom Rix <trix@redhat.com>
> Sent: Saturday, April 1, 2023 12:41 AM
> To: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>;
> airlied@gmail.com; daniel@ffwll.ch; nathan@kernel.org;
> ndesaulniers@google.com; Zhang, Hawking <Hawking.Zhang@amd.com>;
> Feng, Kenneth <Kenneth.Feng@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
> Huang, Tim <Tim.Huang@amd.com>; andrealmeid@igalia.com; Liu, Kun
> <Kun.Liu2@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux=
-
> kernel@vger.kernel.org; llvm@lists.linux.dev; Tom Rix <trix@redhat.com>
> Subject: [PATCH] drm/amd/pm: remove unused num_of_active_display
> variable
>=20
> clang with W=3D1 reports
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:1700:6: error:
> variable
>   'num_of_active_display' set but not used [-Werror,-Wunused-but-set-
> variable]
>         int num_of_active_display =3D 0;
>             ^
> This variable is not used so remove it.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b5d64749990e..f93f7a9ed631 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1696,8 +1696,6 @@ static int smu_display_configuration_change(void
> *handle,
>  					    const struct
> amd_pp_display_configuration *display_config)  {
>  	struct smu_context *smu =3D handle;
> -	int index =3D 0;
> -	int num_of_active_display =3D 0;
>=20
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>  		return -EOPNOTSUPP;
> @@ -1708,11 +1706,6 @@ static int smu_display_configuration_change(void
> *handle,
>  	smu_set_min_dcef_deep_sleep(smu,
>  				    display_config-
> >min_dcef_deep_sleep_set_clk / 100);
>=20
> -	for (index =3D 0; index < display_config-
> >num_path_including_non_display; index++) {
> -		if (display_config->displays[index].controller_id !=3D 0)
> -			num_of_active_display++;
> -	}
> -
>  	return 0;
>  }
>=20
> --
> 2.27.0
