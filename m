Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4EC70B678
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjEVH1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjEVH1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:27:09 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45C0B7;
        Mon, 22 May 2023 00:27:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0KnQn3++e61DC1pqRvK3O4xJD7HnphvbZncwrhViHo9Dyt4/TEodxkox79snBwFGjq7I8fpoAyL4C17+Mq32F809wR9MNaa9gbMQvn+Ge0cj7wgjn2KSLO3+Megu4uF2G3kDprlUV+P5I3QAZr4DE9xKFWV/HgGSjRYGqLctyCWxpQ5zy34CT8KEYBPqoOS2+b+cxpk2orcHAMz2+KsKGX55FUGzc52buw0OOWI7yL5tFjOWz1DnLwKMQ/YeJBTidU5ee6EES7/10/uwROacET8zOs1+qerX4rvNiSQVPv9FzxDFTFPuDg6suQDGW9KgcCPgKwnWmG+oOGUFVokGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0z73fn6aqHgll2XnWe+cMpkUZ7Q8ZKGPShwhUzZub4c=;
 b=POTPbaUvV9zRadwHfR6dSGNPjO1qqcsl1R/BCSFQcpN25v9WYRar8xR/7NgOmGfwqq6PGJUpIi0a/Ginqlr57M1IYiBovWAomPa9UUmO28sBvHPgQyDIhKXPVT3kT0RAaGMdZFLzRSK7aA5/T9RcGTY5651tUPpvARQjcEyiv5NR5m5ZRgayPB/Xogji3etGatZ8xdqY3kiYBtDYbwp3VY08fuHWWzGyyadzeTQiwc9NbNcNbdzTYjGG9PmnybvQfLU63bkatuJQQnIqeBmYnX9RZbPfHBCOdEUOyefeJM0RbOA1qMPXZBhta09D28Oqu8PD/ThfKqwRsa4x3zERGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0z73fn6aqHgll2XnWe+cMpkUZ7Q8ZKGPShwhUzZub4c=;
 b=fM6ex2Z9FBCw0TAOl9EgiwTEea7Hn+wxD+bwa8MaYd0SYUOPdm3qXZVi9ToME3Tr+JmrtgXY+q0DT2QUao/UCU1YBHCRHJoVAvXGGCnDFzFCIIOurkJSQfFtuXZe5dxGktiW36PZjMACsoJ9VQCIo8T86OT3E9EPMyHDo3QMxxk=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 07:27:05 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::5edd:a5dc:b0d0:940]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::5edd:a5dc:b0d0:940%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 07:27:05 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
CC:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Jinzhou.Su@amd.com" <Jinzhou.Su@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH 2/2] cpufreq/amd-pstate: Remove unnecessary active state
 checks
Thread-Topic: [PATCH 2/2] cpufreq/amd-pstate: Remove unnecessary active state
 checks
Thread-Index: AQHZjHeCAayJbJcPTkK8OPKD1oew0a9l43kw
Date:   Mon, 22 May 2023 07:27:05 +0000
Message-ID: <CYYPR12MB8655D429C48DFB2ADB819D479C439@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20230522063325.80193-1-wyes.karny@amd.com>
 <20230522063325.80193-3-wyes.karny@amd.com>
In-Reply-To: <20230522063325.80193-3-wyes.karny@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-22T07:27:01Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8d68c4e3-5f1a-48bd-834f-b747fd1a45d7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-22T07:27:01Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 309a8386-5d19-47b3-a4b9-8b35819e0d3b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CY8PR12MB7659:EE_
x-ms-office365-filtering-correlation-id: 90272f28-c3c1-433b-9cf9-08db5a95f1b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vXTrWa7HvvjQspnBmL2lFzJSGg7zl6E3J3Ma7DjQKK2oq4GBKr5H+ODP1NpadLS4ewXl259BYyXujH5azbOZ+NbW3Rg/B2Bf7BZsSma3ZP4h3GNV0b4Un+NSqwKG9IMaawL6seW3nMtWqgZ8qXXG3L05J2et0/gR/yL2JxP38iLfXrFEsxL2r5uRp0NchqoVifnfCGfA3S33z0eMPvLUc7udOcgDP+Pc4Xmckupc4n/LpREE3jMaUHdb2mY5ODp6DPMDfpwv9BiZ9Rb8dJlCxcRldGZ+WXEGZBrWGY77TfnQNctQ5i98b9YtHQiOuyFtOQ+9FAjw30f4gWEzkolDXCLLehChJxfmhOPTRPcwVZHL3Y62wWgUAu5t7dbFU6rcz2myBiIPf1k8gC1lbyKmwsijGiVHSYOXZ0C03FKN62kBid9z8GnUHcbULTQkN/y4LPemj5nfaYYg3GKqWv2scjPFPvI2SMAOfW9N+2HJMT1a4aZzzrQ+RD+pb1i6hBGk+0lFEakPznqtBniY6Wmyqi3b5lZ7SvxxHj2d6HUgErCXHSmBG0EV6UG+obJ8nerl3wNBg6GLbhHWwJoKdecMEG+Fa7IPAEjpl/3yCAqdcyvOImD8zyFc4EQPbjNJAPYd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(52536014)(5660300002)(8676002)(8936002)(6862004)(33656002)(83380400001)(2906002)(186003)(122000001)(38100700002)(38070700005)(86362001)(55016003)(6506007)(53546011)(9686003)(54906003)(71200400001)(316002)(478600001)(66556008)(66476007)(66446008)(64756008)(6636002)(4326008)(76116006)(66946007)(7696005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bH4gOnv+neCikmx8T9c9N7aPmsyJyPjZMLGicfRvF3Gi8zdUNVU9uVb4crgI?=
 =?us-ascii?Q?aj+V55gXFTCJBkASf23/iLXQlZaJL2kEC9iMEovJ6/tDG95fu+kdHMN9tazB?=
 =?us-ascii?Q?wqx4g75AOLumMvanEPNnihF5dEyf0SFDQkUn0yBaeZYY1s8sVOmulNm4OK5B?=
 =?us-ascii?Q?EIz8n6xQ6nluxJ3dzN3xcv/lcr3ICKfeCSZFklvj+emWzhbABBS/f948sq0s?=
 =?us-ascii?Q?mku1wUOR+Uqj3S2Faos2XZJrLd2w4atA6GMtqI+AipBiif1PMMz3oK1ro+2C?=
 =?us-ascii?Q?jpKWYgL5vmw94JsZz8q49CMtng/yCYsP8HSZ4cGev+tzdVxE3UA9dU4+nXGm?=
 =?us-ascii?Q?eC1jDzqkhci2HaLrR+waQyH0pRstz7R0ZIBh5J7Z/o2wYlozabDzia9sv1N4?=
 =?us-ascii?Q?VbRgfEKads0XlBZhvEj9n8uMCn1b4LiFgofS6svCaFubqh1XnBSv6L0lXE+k?=
 =?us-ascii?Q?0FSYF/kJQKbXHrJnFkrpC2/7uWjK/HrRfajYTXRD45QFvt8MEURgYHLcQaRl?=
 =?us-ascii?Q?5yOct1ptsc6pdYr7f3Rp7zfkgbxiwHWxLe7NlCNVzoVITZCspdSpidPsFyst?=
 =?us-ascii?Q?eo89QAmQm3S+7hki6z60Xu2PkPm/Ed1FvisHJ3k2DUNF5SZyMZIj84jefB4B?=
 =?us-ascii?Q?Fp/vfJ6MBLvMjBtHVHfd13amXiV/ADsISvzelUTgiHuU3ByYkWCdNmm89IEF?=
 =?us-ascii?Q?MwAqdlIdRxPJlewKH/Ykj6e3i6+p+g7qY3IYP3AoSd4UR3iQaeEmam6liR8F?=
 =?us-ascii?Q?VCIZKygKvAZbM8+CqIVbXiGeApOnncdUTctbFMdSrG9ucD77HpGUJlZtg9gy?=
 =?us-ascii?Q?GZfLZ+y9wJp62YARUslG2sGXYkGUCwOT3/nX4yle0vR9USaRyRUl+xVlugyq?=
 =?us-ascii?Q?14uaDumwUb2P5RjwT8wqupmV2TwexvvQypoxYw+vzlTBESp7exJ/cBEaAJ26?=
 =?us-ascii?Q?YAXmbSHa+VUkLdICzKKkGwxKhFHAq3Ae2ujwd6MfTZNNah3G9D+HsSxyqJqQ?=
 =?us-ascii?Q?JMa0hfAaCJkotNTpajI2esgzioz8DsKg+GIaLsPWbMmqDMdpdbfjEZuMMqXi?=
 =?us-ascii?Q?XK1kaLAbV0n/ff7X4pbsx0xzrYFxl1Wftot+44boHfnZZOVgw+dxD8tpPmmN?=
 =?us-ascii?Q?xydaa0YlR2cL2M1SkBu5WZgiVzp80zz8JaHUCLKH+Hqt0iEqRNE7CPHI1rrN?=
 =?us-ascii?Q?Ok8Y096yI/9D2g//RZw1BzAwF2Yl1wT1MtAOuv26/+Jbcm7jm9++2CkIpcHt?=
 =?us-ascii?Q?oJ49zJv98TywgezLSWKUg07/JQV3QWB0DVf5S9ZLQTmOxjp7cK3TCuOQgNnc?=
 =?us-ascii?Q?1Ya1r/DK101WoYSoL3Bpl+54L9wwOp7/UrshflT+T/XfgJrJykX1dh1JRGTx?=
 =?us-ascii?Q?0yJ8HW5GKpxI9OnaRyH62rNq2scWtAa/InPEDs+eG+p0VjtmLpXf7YwqFEH6?=
 =?us-ascii?Q?+Xq7nMIyD8Y+d7+tcqih54vevqCwim7QclyRvqjw0GURGQ36cnNdXDa4r4+R?=
 =?us-ascii?Q?tYOxBs698v4ysh7yuCqMVIaSbEXsZHI+GFigaJ7Hb9a4P1pagWqT0OyAXQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90272f28-c3c1-433b-9cf9-08db5a95f1b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 07:27:05.4746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBswPweu8xpyLk5+k/GLV+yoB1VH3+ASVDVSL2h+LhjZnf4cT0fcTkehXcJdvUFNKo0pi5pnNuYKB29SBnyn0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Wyse.

> -----Original Message-----
> From: Karny, Wyes <Wyes.Karny@amd.com>
> Sent: Monday, May 22, 2023 2:33 PM
> To: Huang, Ray <Ray.Huang@amd.com>; rafael@kernel.org;
> viresh.kumar@linaro.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Jinzhou.Su@amd.com;
> Yuan, Perry <Perry.Yuan@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; Karny, Wyes <Wyes.Karny@amd.com>
> Subject: [PATCH 2/2] cpufreq/amd-pstate: Remove unnecessary active state
> checks
>=20
> Some functions are only specific to amd_pstate active mode driver.  This
> functions cannot be called from passive/guided mode paths, therefore remo=
ve
> these unnecessary checks.
>=20
> Fixes: d4da12f8033a ("cpufreq: amd-pstate: implement amd pstate cpu onlin=
e
> and offline callback")
> Fixes: 50ddd2f78269 ("cpufreq: amd-pstate: implement suspend and resume
> callbacks")
>=20
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c =
index
> 8c72f95ac315..fda66a206d26 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1209,10 +1209,8 @@ static int amd_pstate_epp_cpu_online(struct
> cpufreq_policy *policy)
>=20
>  	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
>=20
> -	if (cppc_state =3D=3D AMD_PSTATE_ACTIVE) {
> -		amd_pstate_epp_reenable(policy->cpu, cpudata);
> -		cpudata->suspended =3D false;
> -	}
> +	amd_pstate_epp_reenable(policy->cpu, cpudata);
> +	cpudata->suspended =3D false;
>=20

Thanks for your patch to improve the pstate driver.=20
Have you tested the online and offline callback can work for non-epp modes =
?
If the callback works well, glad to add the review by for the patch.

Perry.=20

>  	return 0;
>  }
> @@ -1255,8 +1253,7 @@ static int amd_pstate_epp_cpu_offline(struct
> cpufreq_policy *policy)
>  	if (cpudata->suspended)
>  		return 0;
>=20
> -	if (cppc_state =3D=3D AMD_PSTATE_ACTIVE)
> -		amd_pstate_epp_offline(policy);
> +	amd_pstate_epp_offline(policy);
>=20
>  	return 0;
>  }
> @@ -1273,10 +1270,6 @@ static int amd_pstate_epp_suspend(struct
> cpufreq_policy *policy)
>  	struct amd_cpudata *cpudata =3D policy->driver_data;
>  	int ret;
>=20
> -	/* avoid suspending when EPP is not enabled */
> -	if (cppc_state !=3D AMD_PSTATE_ACTIVE)
> -		return 0;
> -
>  	/* set this flag to avoid setting core offline*/
>  	cpudata->suspended =3D true;
>=20
> --
> 2.34.1

