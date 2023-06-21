Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57535737A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjFUEZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFUEZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:25:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F51172C;
        Tue, 20 Jun 2023 21:25:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5AeONkgc8E+KewmeQjiMNsc6oGyBImxxMd9UieTJFabkV95XtZnzbZtPy2ylPzL4kocuRh9bEPAWkWUCnfzJ2SO6cG7Fuy2StxmbXsKU6NQq24Ut72mhQKc/2NarWRGBLeFhWBXeQEBejddcGPxZeT7nbTCecPVMKYbpjKZNChkLr1yPBV4WiVWtF05DL1N/kAnbWt5zVadblMAgaALQqwqhecMFhpW1LsSnF2MoRK63tSUkV/f40SMOJaWYvC2E35SV59EOok3TAzAyYtF5hhAgM9rnI/6lpS4EjAKVtIFekx7hYK9Gq8QtW0w1ZM8KgQASxPY77j/Pvcop+qQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ydbz+wSY3xZzbfU5gk2pkHlv45OmaHNsIf/D7uUTlg=;
 b=RnTjbwwdhqDExG7rWQEpFrvKVfi3rOlywkK0irj55up6sPPKYjH68orPVou/mQlqIl4QXfwXtybWK93DTPa4A8tDJQqyTbA9Y6xIHfC/3u1lPwj9RQeWm+aSaCBCnq7iB4Q8tZigWyZd52UQ04fMWqHFUlBKkg2a8w7mHlIW39kB8b0HqlgHc39/Vllag7IgvHNAUE9/zyeFxm6jb6s8q5dwJgYrcRTFPm64Q5Nlckoq1Eq2DwISX8CqkPtsBBL1JRSxedccfSEinrMvPqHg3NLq+qMGO8wIetGczqqF7ZG37pVYjt/FUvfkz1y+QEwe9BGZZLHCFiDJVJM43su3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ydbz+wSY3xZzbfU5gk2pkHlv45OmaHNsIf/D7uUTlg=;
 b=iXaP9mMr+HLsqJJpQ22IKDbUbe8l1dEm5d2DRSjcke01UgaGV1NKdH23Q1pDZYRjf2UFTnJuoqBqzCHOc1fVahf6S80z1/37sr5DF73ZWGGVSqq9F7UWJuxova2FrV6XQZwi1+wo0sQBYFiUIxZgvuW+nDqfcPO+4K7G9lOpnos=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Wed, 21 Jun 2023 04:25:04 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 04:25:04 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Len Brown <lenb@kernel.org>, "Huang, Ray" <Ray.Huang@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
Subject: RE: [PATCH v3 2/3] cpufreq: amd-pstate: Set a fallback policy based
 on preferred_profile
Thread-Topic: [PATCH v3 2/3] cpufreq: amd-pstate: Set a fallback policy based
 on preferred_profile
Thread-Index: AQHZo5yBMSRG81IwBEOekQRdyHNwE6+UqW7Q
Date:   Wed, 21 Jun 2023 04:25:04 +0000
Message-ID: <CYYPR12MB8655DF3FCF6714BAC247287E9C5DA@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20230620172433.21325-1-mario.limonciello@amd.com>
 <20230620172433.21325-3-mario.limonciello@amd.com>
In-Reply-To: <20230620172433.21325-3-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6d5fd617-d590-4951-8fdc-044a43be1135;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-21T04:24:53Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DM4PR12MB6469:EE_
x-ms-office365-filtering-correlation-id: d19cf6d6-3421-4f38-29b1-08db720f7cbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uHe8Zr0wEaG1NBfddILmdwc6lB2EKHupxB46z2x+HFYc5tyB55/dS9Wsd1Ags7aohjQ+SKUeVA4Dx7wvm+rY4AN44ri9mxB13B7oRd46zWDqI1XlOpqWy07wJOsohc4KGJqDNKNAgM3yIepgEnKjmutTBplQoPCdkjytcv2jmCfQMRr76MIVr25t290LRCwkgDqedK62ghA/KImF8kqG6u/kazLMbt6D8WawNExB6owbJFTJOB6OzWzeNFXrrY0MwZwRdhKgP92xEkXrkLjIxGTnuGlWne2/lIrOKv4GghtSXVbjtdKm9kmeRbdK8ZPHNuRVSRi7pgOh0rjGNaM9lJW0TPcEKsLo7zLlRgh2En715f2z7YelUlY7scr6ON51dPCDFIC7dhnPqvNL9cfTq87Z346vP4rik0yqeM0wPE61riu3pNJSzxfCQj5DL8I4yFXn6g3DtgANz+UIDnAoRZGYUUA8ufcjHi9lek5KXdEj1kkOT1MObjbftU1DxyHwqjBZWLWwF+buyaHf8mq89ZeXDtqAwlASESCj018CNI6ZNl6RuMYRm53PgXBDwtfa3kI/dCKQiIGlSfrLNuBj72IMUykK9ECxMd2dnOs4nBk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(71200400001)(86362001)(52536014)(83380400001)(2906002)(38070700005)(122000001)(5660300002)(4326008)(110136005)(54906003)(66946007)(8936002)(66556008)(186003)(64756008)(66446008)(66476007)(9686003)(966005)(38100700002)(478600001)(76116006)(55016003)(53546011)(6506007)(41300700001)(26005)(7696005)(33656002)(316002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aS7yMu+3CBXmt1UnPfusmxcc54S6noatDfVgnFIHBPz1WQ2YyNeCiceMn3aj?=
 =?us-ascii?Q?BPz1be3gStK3QFCgxX8VgKVPP+n95rw3N2Q4GjkzCsJYjPVUtd09FEZzkitR?=
 =?us-ascii?Q?vhUMJvpa3CI+O9bpAFR94k17Z73QGezqipNo4cFxxwWpllxrE0u0lbd4nzeB?=
 =?us-ascii?Q?fgrAY3wIMKJ37BioSMC0dx3C/FIiucBcsftoE2SMFWMeE1VspyHMMJDL0/Sq?=
 =?us-ascii?Q?FzLwWyTHk9gNBYFbYlAr0roDMQ8wcAtdZPG9u3u0NgaluGs/CyEatQGVRAun?=
 =?us-ascii?Q?Mtc9+jYmAIRhui7ZPxOogRagZQIbMsnNJxVqlJnBSCeUnoX4TJNjcK2Jq9aU?=
 =?us-ascii?Q?CdWlKq5QKbKXK4GYvVNN02KQWh40msSf0Nhiy5fF+L2DZ3qoy87ULXdeysRS?=
 =?us-ascii?Q?NAoKk9EorWSSTy3HszhL7uUuxP68zJuniB4f+O8vlc67jkvpfxtyDf0pwQsE?=
 =?us-ascii?Q?h6h/sNUQIg8s7ZFU3f2YEGgHY31JVH9BTDHpTasIbx/TsvLD/GT9+FyolWQZ?=
 =?us-ascii?Q?v2axe1HSR35Myk9eOO4Mop0JLE38qg40mZe15osMSimbsXSEFND45AuNiSiY?=
 =?us-ascii?Q?Y+Y5lYG3plzwhfXqOOWz1qa9gRogmY8L2VyCnEkd8tu5PURQY44rAAWdUQ8U?=
 =?us-ascii?Q?uLhBhfCZByN3XxKLAdg8PGQ3ZP6s9fp8csiMBxFU4EO0w7+yGVuH/Bv6yXLl?=
 =?us-ascii?Q?qzK74lwqpNGdChx1o/9cAYVvkdQNF5lsTvkDnluzxNEhi40FDB80gE8b7S7M?=
 =?us-ascii?Q?EATq7zwFzj05otSPiQcnkWHxd7OviUM/5MntkW8Jhm3feWpAbNfKFgD2d18s?=
 =?us-ascii?Q?jWi2FJf2dLtNP9nQRrrGVO6lQoXuHjzshOlIkNJI0piRUfl+U/6tzh2weCKu?=
 =?us-ascii?Q?A43V13BoHLmFsepGvMP+jXMTeUnqiUtElkpy8qclOwGsjPB/I9p+0wLJTxSq?=
 =?us-ascii?Q?56MIY5TeSOcD4ct2hejjDcdjGaHQ/E53qYH8dO6+mNS9ZBegU90xCU6aqCJ6?=
 =?us-ascii?Q?SPzki50U8YBcA68gpwnCytLfmzaSq79H30R0WsKFos2dNScAwFD74olQPQD8?=
 =?us-ascii?Q?iOt0jl3RMzCjxLORJs34NhNs8uQHyXj5cKj8pTfoK5/Zy/Sf5DGReeCw+BfP?=
 =?us-ascii?Q?h3GOwuquUPw+IJodjmzryEh/6X0prCMys+MMQq8lcFhFwMVC8ZTN1nHTn0CC?=
 =?us-ascii?Q?MtSBYjKdbKbFb33rpRJTjGt7wIqCgRznu7HyLEBIvl4gIHw6F32Fj3gSaJAP?=
 =?us-ascii?Q?wCiGkJgcNIZxxUtqtBeBM0ZGXaW0226WQ1WMHTPe1Ybn9irKlGJXr8HHTSZx?=
 =?us-ascii?Q?YMqu0lYdXY2d88XazU1JdGpNz80XEbBS0SXgN6LKphVK2sAZso44GorXKVqC?=
 =?us-ascii?Q?H/b/AauFp0u4CS8UyDmPv5z1qWetDXH9IuwmgBDcrMuFSiNdmdzlIqYJ9H9+?=
 =?us-ascii?Q?WFTEyLKWx9Ugp1gHlUj/U2nfZavf9FEGdx9SXTwwFBrWUOsmXDRVWve2SkXn?=
 =?us-ascii?Q?Q+BWS2R5/srA82DIs2lCZbjbx6OrgsIgWIVWU0xuqP6ForBqrkyjomJjphSo?=
 =?us-ascii?Q?j7TGUllzMpcSB6DHv0Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19cf6d6-3421-4f38-29b1-08db720f7cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 04:25:04.5754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1Aw+qtxSL9W0G+xVqrGft8NtE6SYOg+LI9OjsW1azedU1MWFMsJqYuetW5URQrlnlyL3xxVj2sO0tQiNM6zEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Wednesday, June 21, 2023 1:25 AM
> To: Rafael J . Wysocki <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>; Huang, Ray <Ray.Huang@amd.com>;
> linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> pm@vger.kernel.org; Shenoy, Gautham Ranjal
> <gautham.shenoy@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> Yuan, Perry <Perry.Yuan@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH v3 2/3] cpufreq: amd-pstate: Set a fallback policy based =
on
> preferred_profile
>
> If a user's configuration doesn't explicitly specify the cpufreq scaling =
governor
> then the code currently explicitly falls back to 'powersave'. This defaul=
t is fine
> for notebooks and desktops, but servers and undefined machines should
> default to 'performance'.
>
> Look at the 'preferred_profile' field from the FADT to set this policy
> accordingly.
>
> Link:
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Progr
> amming_Model/ACPI_Software_Programming_Model.html#fixed-acpi-
> description-table-fadt
> Acked-by: Huang Rui <ray.huang@amd.com>
> Suggested-by: Wyes Karny <Wyes.Karny@amd.com>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>  * Move new symbols out of patch 1 into this patch
>  * Add Ray's tag
> ---
>  drivers/cpufreq/amd-pstate.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d8269994322e..3546d7db614d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1071,6 +1071,26 @@ static const struct attribute_group
> amd_pstate_global_attr_group =3D {
>       .attrs =3D pstate_global_attributes,
>  };
>
> +static bool amd_pstate_acpi_pm_profile_server(void)
> +{
> +     switch (acpi_gbl_FADT.preferred_profile) {
> +     case PM_ENTERPRISE_SERVER:
> +     case PM_SOHO_SERVER:
> +     case PM_PERFORMANCE_SERVER:
> +             return true;
> +     }
> +     return false;
> +}
> +
> +static bool amd_pstate_acpi_pm_profile_undefined(void)
> +{
> +     if (acpi_gbl_FADT.preferred_profile =3D=3D PM_UNSPECIFIED)
> +             return true;
> +     if (acpi_gbl_FADT.preferred_profile >=3D NR_PM_PROFILES)
> +             return true;
> +     return false;
> +}
> +
>  static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)  {
>       int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -1128,10 +1148,14 @@ static int amd_pstate_epp_cpu_init(struct
> cpufreq_policy *policy)
>       policy->max =3D policy->cpuinfo.max_freq;
>
>       /*
> -      * Set the policy to powersave to provide a valid fallback value in=
 case
> +      * Set the policy to provide a valid fallback value in case
>        * the default cpufreq governor is neither powersave nor
> performance.
>        */
> -     policy->policy =3D CPUFREQ_POLICY_POWERSAVE;
> +     if (amd_pstate_acpi_pm_profile_server() ||
> +         amd_pstate_acpi_pm_profile_undefined())
> +             policy->policy =3D CPUFREQ_POLICY_PERFORMANCE;
> +     else
> +             policy->policy =3D CPUFREQ_POLICY_POWERSAVE;
>
>       if (boot_cpu_has(X86_FEATURE_CPPC)) {
>               ret =3D rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> &value);
> --
> 2.34.1
Reviewed-by: Perry Yuan <Perry.Yuan@amd.com>
