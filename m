Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721E474E91C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjGKI3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjGKI3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:29:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09A41735;
        Tue, 11 Jul 2023 01:28:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5V/BM0V9bUS0Z5SSafu4GOkCKYtJ8g7GW0K4YBvC65qIyRkD29QT0R8w23wT6dqNSm40XEOURLrmJ2SnZ6FKVRQx1RpRwkgXAHMhV4ySyj/fqClirgAB1/YnRGNt10cssG7H5AREqqm37mTjMDxYaC9nLPLF6nLPh4YK1UlnjpKaAjlLl7ImtqLVmBfA8tvmhX06RUWz+mun11h30rbI0yzMr+dkJp3x1cFXSfbuXLd0a7UFOe+iBv2Fdli2jcjZiiuszHKnrqu9IMVe4A8QvKrnzVU/Rhwc5hV/Krxh9LO8ksWIv1A9rS25zqQC0eQUyQRvJk02Onl8+uFV7kt1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxn205Ui8Qd936tPx9RoZ0Q9tabLiTZoeGJ0dgDK9CA=;
 b=msVkmtHxasJ0Hq3GVO9VUseJn161IXHBvZ9o9acte3Zfq9W8tef7S+Y8MaUmFYted7VGDPJ7U49Di3QHw3EhIa9LO7ts9MQfEVRLH2u0nBVbhPuIAbutJpWHYxYlNjjB7PbQXWEfstKmgdD7Sqxh93WKNTj3cNtNbLjLmhGffW4yO5yDZFOnGqspBWhdVP40qgbxJo5O3PZcp+xyZ3C5ogYNgdnAR32yXndH97E8tENwIKb7TEREvBcwIiZTm+He3h/2MIiTCBM1ElEzXuGe/BZLcfy0SsUutpdbr3H2RtEf209BJB8WXZmjg3TsZsRJogzh23OyD0y2ELnxalQ05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxn205Ui8Qd936tPx9RoZ0Q9tabLiTZoeGJ0dgDK9CA=;
 b=3mhzHeBaBFeZarJ0dTArl6c3W1n9ia8C/gbxuizTcquVqb4xAfwIv+Cn0opboQ/AA5qlFik/L9yENXays2kuA33m8HtRplzwW2JOHrAGK4o41hB7jXtTGT0lpXwtpyXVHvHCxlq+5sDHgoJTf+8E+NKsiCvm+o4RYgUiKL2BvW8=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 08:28:31 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::69e5:18e:4b1b:28e]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::69e5:18e:4b1b:28e%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 08:28:31 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     James Clark <james.clark@arm.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
CC:     "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sarangi, Anirudha" <anirudha.sarangi@amd.com>
Subject: RE: [PATCH] perf build: Fix library not found error when using CSLIBS
Thread-Topic: [PATCH] perf build: Fix library not found error when using
 CSLIBS
Thread-Index: AQHZsOoktUGQo2erzUOr31GfubLHo6+0P/bA
Date:   Tue, 11 Jul 2023 08:28:31 +0000
Message-ID: <MN0PR12MB5953B9D303746370D9E3AB98B731A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20230707154546.456720-1-james.clark@arm.com>
In-Reply-To: <20230707154546.456720-1-james.clark@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM6PR12MB4483:EE_
x-ms-office365-filtering-correlation-id: b76b1113-19a7-421d-1955-08db81e8cf6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TipFZkXxNgBI5nDVT8B6e/XK2Shbm8xx/BECQ7O5zvJ9MVD/YgucD/w4SLmflKSZABzyXkjxVTfCaz2WWeGKIn62Vh+M1eCTqBvZSzor4d4UY/cilIXWt84p3Fxcl2IxeBEhhtkjVxndVmuWeRMGjcFOhv0fC+tdFVoKX0NnTfXaWVuGgIGZgw/HF1xgaC+/ldCElyYU2pEAa5McYUoXBr7tNrpjeYeFsmVB34NqCd0zlrfAzFUzgbSvxxrRzAFrVCOc3bj+BMMK/BIRpyisoELHNSpafhVjsdFpo6xzMjaGPRJbOoVZPcbMu131sxo+4szGhtQrr8HeRBEGb+dOq/qgJxHGnrS35rUDt0hq33fGZ63e65ghMkJNh6NHCHlYAMGQkgMG+TXdv1CuijaHfk1T+0Ee0fr9irlAdv0Qi/8c2S90Wrrf2OD1FO0CU29/t0GV+8nk+PF+kDYtBSHQUMGp/6fG8mvSM7z/YsBG2DKLar1LMDfFNAGExpM9PJKK7fe9ebP790IheFBs+1TWV5cDd8guUkthgZ69kZKQAYCS3xMbrVnfye2T0oT1OFqx5FcuuOlczetUVLZLCc01d8D/elBKv9MFTBQ+MEFhuYdWA/sdUCHMbxtEc1OsBvSH6PFXx0vpQsaSpro6lpJUzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(7416002)(5660300002)(52536014)(316002)(64756008)(41300700001)(8936002)(76116006)(66446008)(66946007)(2906002)(66476007)(66556008)(4326008)(8676002)(71200400001)(7696005)(966005)(54906003)(6506007)(53546011)(9686003)(186003)(83380400001)(38100700002)(110136005)(478600001)(122000001)(38070700005)(33656002)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DTY9ZmHDbULf8341b2YVjkZprw737H7hatt7Nna2qhRYXi0DsMZU+bHUyA?=
 =?iso-8859-1?Q?QItWTIcYkXwPZ86aQNjFPCrLg7WQtVvXq8qWUSQVvYukx4rpiA6QBNh8x6?=
 =?iso-8859-1?Q?7VutgHrptoMtNctxYMgN7kgDNmS/h/V7Kz5y7tuOe9iE6sKnXGtLFApLEH?=
 =?iso-8859-1?Q?IAiL9y4KqNKhQO1ClsgaaABMpvnNfPMK1s1J7Gye1lr8FYD3dMj0IS3+XI?=
 =?iso-8859-1?Q?1xcHlxoeamBxQ9tpqR4npzuntiZkZRAo06Ecp/wCJHx6VJKz9rZ8bOqJT8?=
 =?iso-8859-1?Q?BOn42J29Xsqm9M9rgDG49X5KYzDBMwysv+bNRogUQzeTTaVj+tqsoo/TkF?=
 =?iso-8859-1?Q?NArcmpPNHS3e4qKKtRbZ5qqokv8vLhEgZrNtL2UuXhQk9N5175eyELpgLb?=
 =?iso-8859-1?Q?6Wz4QApcRlRx2B6bcPjlRJJpdZQL08N92G3Om0Yu1axgYHl/vZI7WA/3zQ?=
 =?iso-8859-1?Q?N2Qm0lUVBgEk38HN+mFviT7s9T1xMn+6B1TYFA9My4jqXMPGNVVuPumhPd?=
 =?iso-8859-1?Q?Ef046A5tRm+yoqB5SzKXMxehV+jAxU98uNjdrV/zdqzCvmmNVJjywdu/ce?=
 =?iso-8859-1?Q?YXD+NldxOcs6fSPKc6m7tRTg5y50dI2bt25NL/6mTy3e96Nn0fI3fVu8//?=
 =?iso-8859-1?Q?MGYxTt+yW5zFDTwrkJ2Ab8cGX+e8nnaqHEngkxuNSaD0RXgigpJptmkMbC?=
 =?iso-8859-1?Q?Dsjbstj4LX1HETLcmBliair1slPbs6GD1KsUZLb3lagC1xdhM1wfEn5YhV?=
 =?iso-8859-1?Q?rP6KwnUlMbGYR0vvGEHQoc0xL4cNY+SjS+TWuo/k65Vg30PgFgN9ltDLkj?=
 =?iso-8859-1?Q?EpYEW9TihMWnwqrlzzgoGKw15Hmk2AKjZcCRcbiTtXq7LLOmUonDcOIIL+?=
 =?iso-8859-1?Q?PlujMIgEqkW54UGCj65tfUKCg26bTphZterCeczpOdu0JHayTW2oXlj/ES?=
 =?iso-8859-1?Q?OQ17ZGvFXnP8NpGttEtZVhF6hoEa6R0j5taIt5HeAhtkdfvrUT9RIZRWv3?=
 =?iso-8859-1?Q?ukCLK2/UNSdyUXQYGf3XNjy2bf0ilbDuoxKetJBMbMfLZ59yjKjPFeoEVQ?=
 =?iso-8859-1?Q?taIAv75iy8BzHpOPosvSFwHdSylXXJQoOVQXzvCeyxv4cYgy1KwPW862oQ?=
 =?iso-8859-1?Q?6VuJSu1L2Yu0G5xGpeFvLihbsIcKVYaEGOtFGBioVClld0pQxJgFfCobvI?=
 =?iso-8859-1?Q?DBUkdq2BzZLo7rKNW3+0RP354H8RDzTdxDcKXNlPZ78KmxvpSz0BMRhO97?=
 =?iso-8859-1?Q?gk1xWbiQJq7GBQ5QwdGbYCSdrN1avXPTTawJ3YCiyUmOxtEXNzpFTHMXIC?=
 =?iso-8859-1?Q?YRt96EpnSqZGfb0TxyvlyP1lJOnp/TuKqXXCEmA/udgqr/Rjh/rNuBWgZT?=
 =?iso-8859-1?Q?8kEywh3KS8IJ66qgP3T9GjrBx4CtZGRAanc2XYe6fuwXLPajxUmntxKzI+?=
 =?iso-8859-1?Q?cJ2F7IOsJk9MOo3NjvjKyyUgAUGaqyFmotf94CNQh/MygfGaKQkeh5GBcX?=
 =?iso-8859-1?Q?Jf6pE1k2mANht935BsemZfp3B+uVPVStDDj8hetsUtY0YRf0sm3ElvpKpM?=
 =?iso-8859-1?Q?7tTuoFC8sjbgJWUn+6h+mUztDR3s0dLRqkGOxTsYBKFaEnbDZELO56KzR8?=
 =?iso-8859-1?Q?l0fAK+zky1JQTU1rtMEgehjJqSPb/hphlG/ognf+c9Bwc0dSCRK1Z/61GD?=
 =?iso-8859-1?Q?cqmEZo4CpC5l4Q1MhK0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76b1113-19a7-421d-1955-08db81e8cf6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 08:28:31.5158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXVqHFjhBJmJLqvC/fnaifEMWs7X+DAA9PE4oUCsEcXSvq4MR8URcBfsbheat3pq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: James Clark <james.clark@arm.com>
> Sent: Friday, July 7, 2023 9:16 PM
> To: linux-perf-users@vger.kernel.org; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>
> Cc: coresight@lists.linaro.org; James Clark <james.clark@arm.com>; Peter
> Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>;
> Arnaldo Carvalho de Melo <acme@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Alexander Shishkin
> <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>;
> Namhyung Kim <namhyung@kernel.org>; Ian Rogers <irogers@google.com>;
> Adrian Hunter <adrian.hunter@intel.com>; Uwe Kleine-K=F6nig <uwe@kleine-
> koenig.org>; linux-kernel@vger.kernel.org
> Subject: [PATCH] perf build: Fix library not found error when using CSLIB=
S
>=20
> -L only specifies the search path for libraries directly provided in the =
link line
> with -l. Because -lopencsd isn't specified, it's only linked because it's=
 a
> dependency of -lopencsd_c_api. Dependencies like this are resolved using
> the default system search paths or -rpath-link=3D... rather than -L. This=
 means
> that compilation only works if OpenCSD is installed to the system rather =
than
> provided with the CSLIBS (-L) option.
>=20
> This could be fixed by adding -Wl,-rpath-link=3D$(CSLIBS) but that is les=
s
> conventional than just adding -lopencsd to the link line so that it uses =
-L. -
> lopencsd seems to have been removed in commit ed17b1914978 ("perf
> tools: Drop requirement for libstdc++.so for libopencsd check") because i=
t
> was thought that there was a chance compilation would work even if it did=
n't
> exist, but I think that only applies to libstdc++ so there is no harm to =
add it
> back. libopencsd.so and libopencsd_c_api.so would always exist together.
>=20
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>=20
> The following scenarios now all work:
>=20
>  * Cross build with OpenCSD installed
>  * Cross build using CSLIBS=3D...
>  * Native build with OpenCSD installed
>  * Native build using CSLIBS=3D...
>  * Static cross build with OpenCSD installed
>  * Static cross build with CSLIBS=3D...
>=20
> Reported-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Closes: https://lore.kernel.org/linux-arm-kernel/56905d7a-a91e-883a-b707-
> 9d5f686ba5f1@arm.com/
> Link: https://lore.kernel.org/all/36cc4dc6-bf4b-1093-1c0a-
> 876e368af183@kleine-koenig.org/
> Fixes: ed17b1914978 ("perf tools: Drop requirement for libstdc++.so for
> libopencsd check")
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/Makefile.config | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config inde=
x
> 0609c19caabd..c5db0de49868 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -155,9 +155,9 @@ FEATURE_CHECK_LDFLAGS-libcrypto =3D -lcrypto  ifdef
> CSINCLUDES
>    LIBOPENCSD_CFLAGS :=3D -I$(CSINCLUDES)
>  endif
> -OPENCSDLIBS :=3D -lopencsd_c_api
> +OPENCSDLIBS :=3D -lopencsd_c_api -lopencsd
>  ifeq ($(findstring -static,${LDFLAGS}),-static)
> -  OPENCSDLIBS +=3D -lopencsd -lstdc++
> +  OPENCSDLIBS +=3D -lstdc++
>  endif
>  ifdef CSLIBS
>    LIBOPENCSD_LDFLAGS :=3D -L$(CSLIBS)
> --
> 2.34.1

Tested-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cross compiled for aarch64 on x86_64.

make ARCH=3Darm64 NO_LIBELF=3D1 NO_JVMTI=3D1 VF=3D1 CORESIGHT=3D1 -C  tools=
/perf

file <snip>/linux-xlnx/tools/perf/perf
perf: ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV),=20
dynamically linked, interpreter /lib/ld-linux-aarch64.so.1,=20
BuildID[sha1]=3Def7c524338577b14e7c0f914d882dec4d26e93a2,=20
for GNU/Linux 3.14.0, with debug_info, not stripped

Thanks,
Radhey

