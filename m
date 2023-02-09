Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6C268FCCB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjBICCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjBICCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:02:43 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F90227984;
        Wed,  8 Feb 2023 18:02:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsn66g+S20eUmtZqf60S2BIOaDsCT5cBb8jTrt94Tdbx4ymTMFnysbkwPOxSMeSC8qlHx+eznlPXLjyrwo7Go/4C96+X05Tn5SosLcSZMrbHgRw7A89JWDd4RyXiUaRhUjfkrXiT/j3YOO2SnzL8bo/fPsABlK70GJP4MMnmeTuWgsJvXmFWuWE5qgjHM8e37Feu4agqBCZEgWNah9JG9xNzgqddFBGG4NVtk5GVA3w3M93wpDZjyInrbRT+qfetiIdBu0t+TWPXtCwJwo2JGVKzI4zVrAImZTFzXEHtk6zxl8Qxf+nG/2sPJe8BaXt/7VDcpglY/aEXGRXPKnYluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99xeozCEmnTVLYHx8bjBtM2xfVZBpqemsiC2Jix07q4=;
 b=d6edo4gz8zYCffUZPFBbCDer5po8Q+rDHXjWaZQPHncwDNzo+gChA+IcLmlrTVDrmyQJMrf6ZfZndjaXFJyqKixpltYd/MBCzr0umrYRiVzm8hNJnTMmeiiFyEbmYeP2jOLc7psnCW7RWf80a6FZV7Y8L/msfYEQVYOikxyyzTBWMWSVchrKqHEuLPwRQdynWGcMCtBH528EK4rbsIncmRX4xRYbtfk9Ja6UR3GuRTVwYImEObSA4E+leABrCdJPkoiahelfDrUww5vJwAIHA6Fqw/ag1U/FYwk9OzOk37Fl+l/xZSDfQ2QFqM3XAmQ4XOd2LKp/DirduZcqQSHOEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99xeozCEmnTVLYHx8bjBtM2xfVZBpqemsiC2Jix07q4=;
 b=ruam1wl5ZkKBa/Esg+DC58Z1sM5EhwAj7ogbQkf+dpa4jMlNhcK/nQRdC0m/dUt3+Tuu4iGEJIIqZSDx1nUXoxBrOm4+QwmVIWYDIsmhejAi2gJcC0Q5I2g6YJ+9BSW4ud3WUJAi2pQMuJdjLVYrOczY6nbJ5z4BCgwVSUOHAJA=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Thu, 9 Feb
 2023 02:02:36 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::21db:f27a:291b:c35d]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::21db:f27a:291b:c35d%7]) with mapi id 15.20.6064.036; Thu, 9 Feb 2023
 02:02:36 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     "Huang, Ray" <Ray.Huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH] cpufreq: amd-pstate: avoid uninitialized variable use
Thread-Topic: [PATCH] cpufreq: amd-pstate: avoid uninitialized variable use
Thread-Index: AQHZOw8PZYEtrGRu80yOhw5dxibqHq7F3HfQ
Date:   Thu, 9 Feb 2023 02:02:36 +0000
Message-ID: <DM4PR12MB52783DEBD0E16631D5796BA09CD99@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20230207161256.271613-1-arnd@kernel.org>
In-Reply-To: <20230207161256.271613-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-09T02:02:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9e92d278-7e9c-495e-ae27-8414c0af950d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-09T02:02:32Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 41bf277f-ace7-4032-aa95-9b7f38fd7865
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|SA1PR12MB8144:EE_
x-ms-office365-filtering-correlation-id: be853cae-ccc9-43e2-ad65-08db0a41b71e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f7jYbdKvRLGPjjufAZH80xFTKM/VG+U2r1atF/9vjYXjQA0cfiFgLvztjF0KNoefvDU5R3ARQGuUdRKh/3xvDhL2in/oucZKThOF42zdaHNbauvi4AMcmN8z3rjrH6QR6Q3Z71Y2a5TmhnVcGcO9TrJR+ncc188umOETG66F2TDT/s6YmSdnjQeDHPxD5IS3XfgDwxpPP43rgXWO46vkgikRgTB/jmsPnKGgyhD8X+nsMU4mtnhrjJBBu8ISjkyhYSDGQozy56BXM+ps/tZfBuiP++r/o67Cdd3/PKrxgSI9oUMHcFBmUDcYIwVC9HpZOxvSqR5BQMWSnTLbtTiPqmvD5VhENT3BCXz9SVwq+3keKmJacHNWYOgmhxPq1zxEWlNuLzSvhF5qM2Ctx8EU06V1673b5l7okmFY8Cfoi5LpLmeRRQpO+ossrME4bt+gLN98Yw0s9AmAxjVFHu1Vz0tHE2zis2ele0aA9kf25FRCPoalDgOUbJG2CkI1gj//u0PC5mG4Bk1HjHsiZvHatprZ29AImHWIbt/JknpFpfsuf/Xt3A/aRxd9AcA+3tY4ftqVYa+tMVmdpwbQIIEJpN4pnlRxt5qM3/EWtG2F9Ehm8/LFIEf8+T+B13VGr8sC/ObNRp5lIwwpi8+RhC2QpSs/BMXgM5yDNIPz7Aw8sOzWN+8MiCeyJrGmrClJSg36dIdqZKtN3D6yNuZ1cVydpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199018)(83380400001)(54906003)(316002)(66476007)(6916009)(52536014)(2906002)(41300700001)(8936002)(55016003)(5660300002)(38070700005)(33656002)(86362001)(38100700002)(122000001)(66946007)(64756008)(76116006)(66556008)(66446008)(8676002)(4326008)(478600001)(9686003)(26005)(186003)(6506007)(53546011)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+AdzNNkAM8jM5q6hivQQmmbCfA7IejV7sTP2GBO50xjkOfuO+fbVF4qALBXG?=
 =?us-ascii?Q?GyKPXFSn9VSoCH3JhSdhjpGKX1oydEJMRv030eCLJIsgNoromaB5tZkR1nIy?=
 =?us-ascii?Q?R6sNeqJbuz1peHx3eoYKf97SkBKfBkQqi5v5ckYwGAp/jIHo8gfUvo78jxeY?=
 =?us-ascii?Q?D7vWE86mvt9k1Y8iP3e2TAY+hKs7vYkqcNHW5w5rz0U8pMMg6ZKi8yFCsI/I?=
 =?us-ascii?Q?uQz+pgo/IJ24exaGA9qlSRDsL41ZGph72yItNNuhRjMe4zxPYQXwyQv/zZ/j?=
 =?us-ascii?Q?WcUFUnoMnsD8SXYhh7ST/rBXmN7e7dWB2mABdGlzW1WDYVgW5Io80U26m/3R?=
 =?us-ascii?Q?ZUTa0GBaeawPb+MB3bF5k33pPjR2C/HK6AjFI3GRC0T2wXtzeOXXI9424+nJ?=
 =?us-ascii?Q?C1t40yXZYUpTC7Zxa8+ol7x95ss0VXofg2Oi/6mDS27wIJbzLLxHXuW/zIwj?=
 =?us-ascii?Q?cKp89xpA0Q69d8CNn941NUk1EMBAjsXQu1aYgl1fV7JmN71o6zoK0hBidZJD?=
 =?us-ascii?Q?14uDTg+bZ8qwTwiSlSOBhw6rCTYlszxr/fDKXgZv4IFRptJQUGv6fHcJ3G4P?=
 =?us-ascii?Q?zEZxlp+xZqXD8ECq1+Vqpqcgn/lyFxViPi+gdvpUR7kSSXDDKWjPdkFufJjm?=
 =?us-ascii?Q?pNeB6dTIiWG/pKRPMlgGpCYc7xhBiJW+xhM59kncbeT5vUQRhcZXiqZUjo27?=
 =?us-ascii?Q?hpOWhvVSvdVxhcYc8yiBmxrfbU1iarKCAsDHonDW26qfANBEiP6R8ryUQMPS?=
 =?us-ascii?Q?X3wVd9CC9ykXQbTENVGYKy7sywV+ei47KtyVhswh9xMNCVRLz4ejAdyV+D3e?=
 =?us-ascii?Q?NmkkHvg9e7RVwMfJwtPy2mC8qfySyEyjIezxanoWQbCrZe6P0kESWlB4x2jG?=
 =?us-ascii?Q?iLtiRqr243VRpKtq3Fo+DCXkScxv12mKecxsVuW1KYZP9yM/3IogexgxQdEg?=
 =?us-ascii?Q?1T+WH8eYBVSkkpec9AUGCZAaOuoEQygETAw3R+XFdnTBsOzBLxZEbzNYhdn9?=
 =?us-ascii?Q?thH5Qui81RpMu2bZxH/scQBYnDH7wFODi5jCGzAJrCnWPwTxx/gVSmqva8/f?=
 =?us-ascii?Q?Gqp+LWKCvB/AVJYh3Jki3XgIFPRGfv24wl/VvOYJOyhd3JLVdQv3+R0EwVLw?=
 =?us-ascii?Q?diw4jWU5jHucCEPbb3HfITFKGbTRg5Tb7AN1kW7yciPWzR3YBEHxC1ZPURcJ?=
 =?us-ascii?Q?a/Wg+Mc9Vek3oNgV0VpF2f4XVOWAut8jLSMm2UEa3cMDw5F8XvD98ILZPJSl?=
 =?us-ascii?Q?J081V+JJTdKiS6fwSAwez8uAiUcxrxll9VWo2Zb6Ys6ffETKQ9Rm22paU8T5?=
 =?us-ascii?Q?AcjZyBiGvcaUQGbMMilEh+LKYsCRFdKHvalsdIxjT8oMjS+yjFzToIDjAYyq?=
 =?us-ascii?Q?78yeoTIv622HY+x5tmaxWkh38NHzcSITGWNMDmnarFHxyTDB6/KC9X6jWiSn?=
 =?us-ascii?Q?bXwV8rr1VC4jVemnG4Ntq8y1ubS6lOUlV/Jbs+WqmBsHFEcoiOOG2bGvV99I?=
 =?us-ascii?Q?pioFs+R6HM0TxRoln/ouIbSGhYK2IM2D8sfnnWYZNLePPtV3MDwTiaVJ32HH?=
 =?us-ascii?Q?BYXk0Yp2y2sOhgRF3BY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be853cae-ccc9-43e2-ad65-08db0a41b71e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 02:02:36.3981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g8AVtKK6INpUg7UZaqgRKwT/DRkH6fzOjQ3tkr0uiq/uI1msDPzNM2RXhguNGmrif0XwM0/uI83+RG3TDHJVig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Arnd,

> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Wednesday, February 8, 2023 12:13 AM
> To: Huang, Ray <Ray.Huang@amd.com>; Rafael J. Wysocki
> <rafael@kernel.org>; Viresh Kumar <viresh.kumar@linaro.org>; Karny, Wyes
> <Wyes.Karny@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Limonciello,
> Mario <Mario.Limonciello@amd.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Yuan, Perry <Perry.Yuan@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>; Jinzhou Su
> <Jinzhou.Su@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] cpufreq: amd-pstate: avoid uninitialized variable use
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The new epp support causes warnings about three separate but related bugs=
:
>=20
> 1) failing before allocation should just return an error:
>=20
> drivers/cpufreq/amd-pstate.c:951:6: error: variable 'ret' is used uniniti=
alized
> whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (!dev)
>             ^~~~
> drivers/cpufreq/amd-pstate.c:1018:9: note: uninitialized use occurs here
>         return ret;
>                ^~~
>=20
> 2) wrong variable to store return code:
>=20
> drivers/cpufreq/amd-pstate.c:963:6: error: variable 'ret' is used uniniti=
alized
> whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (rc)
>             ^~
> drivers/cpufreq/amd-pstate.c:1019:9: note: uninitialized use occurs here
>         return ret;
>                ^~~
> drivers/cpufreq/amd-pstate.c:963:2: note: remove the 'if' if its conditio=
n is
> always false
>         if (rc)
>         ^~~~~~~
>=20
> 3) calling amd_pstate_set_epp() in cleanup path after determining that it
> should not be called:
>=20
> drivers/cpufreq/amd-pstate.c:1055:6: error: variable 'epp' is used
> uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-
> uninitialized]
>         if (cpudata->epp_policy =3D=3D cpudata->policy)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/cpufreq/amd-pstate.c:1080:30: note: uninitialized use occurs here
>         amd_pstate_set_epp(cpudata, epp);
>                                     ^~~
>=20
> All three are trivial to fix, but most likely there are additional bugs i=
n this
> function when the error handling was not really tested.
>=20
> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support
> for the AMD processors")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/amd-pstate.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 168a28bed6ee..847f5f31396d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -940,7 +940,6 @@ static int amd_pstate_epp_cpu_init(struct
> cpufreq_policy *policy)
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
>  	struct amd_cpudata *cpudata;
>  	struct device *dev;
> -	int rc;
>  	u64 value;
>=20
>  	/*
> @@ -950,7 +949,7 @@ static int amd_pstate_epp_cpu_init(struct
> cpufreq_policy *policy)
>  	amd_perf_ctl_reset(policy->cpu);
>  	dev =3D get_cpu_device(policy->cpu);
>  	if (!dev)
> -		goto free_cpudata1;
> +		return -ENODEV;
>=20
>  	cpudata =3D kzalloc(sizeof(*cpudata), GFP_KERNEL);
>  	if (!cpudata)
> @@ -959,8 +958,8 @@ static int amd_pstate_epp_cpu_init(struct
> cpufreq_policy *policy)
>  	cpudata->cpu =3D policy->cpu;
>  	cpudata->epp_policy =3D 0;
>=20
> -	rc =3D amd_pstate_init_perf(cpudata);
> -	if (rc)
> +	ret =3D amd_pstate_init_perf(cpudata);
> +	if (ret)
>  		goto free_cpudata1;
>=20
>  	min_freq =3D amd_get_min_freq(cpudata);
> @@ -1076,9 +1075,9 @@ static void amd_pstate_epp_init(unsigned int cpu)
>  		value |=3D (u64)epp << 24;
>  	}
>=20
> +	amd_pstate_set_epp(cpudata, epp);
>  skip_epp:
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
> -	amd_pstate_set_epp(cpudata, epp);
>  	cpufreq_cpu_put(policy);
>  }
>=20
> --
> 2.39.1

Thanks for your quick fix patch.
=20
Reviewed-by: Yuan Perry <Perry.Yuan@amd.com>
