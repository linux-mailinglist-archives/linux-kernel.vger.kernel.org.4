Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F5B736F27
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjFTOvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjFTOvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:51:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365BD1718;
        Tue, 20 Jun 2023 07:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcvAw+zeIleoyTR0JXRbItkNnx/WSLdPBuMSJv2zFYzRIXmf0j+v5SS6so2mCNciHZzU5ujVzgaXWS7ytz2iZ7e88/yKIbJ3ytzv9lKnNTTtvuC43azApD4vDMDpOHviauU4WXtuZ55DRgkf5OyJg+myMyPO2pWAFCUPiJ+qA3wQ+I8CnlRco9FhS/LFFWQaNARlJgpWrcx0xha/VWfMrSUGS6KZVL7ff6ilsuZVaw2KQs9YW+sTs+b9Yrw6Qedq+v6IElsxDHqHjQIwrP/Xf20dHRSkUgAWuztKSYb8U/pWcXhLKTywrRjAeelfuklXEtnYG50EvLYYgeYBb3iCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MAWhAXjUbnqA+MUJwx2eC6TG6LCbwHutE00OZagsoo=;
 b=JIPezC1nR6w+ER7NHKXIlzj6OdWaW5zuzhig8kNE5PW7ial0byq0px/xDYS2LIQH66RC+aJTI3j802FMAEBx9qlT7EZpNZEwYGzFFW8iwT9xuazE3iEVKbDanMY55oGc02EPzc1uqQ5oyPKYN0kMl0B91uG7O1ukHMDooUfPFYNzMgYQUfNmegZf471Y+U80OTu11/lrKsK1Jsyv0FVp+QeCwUUylLO0pbeDKgeWKRb/rQxIl52rEMDrqq0TcH59ELfAQa+wNaWEXL5iydT2RXGrwdA9JvMaeScA771DD9/OR9Q9W8tezf7xPoB/1lREKew3BQSR0DxwPm+IvUkOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MAWhAXjUbnqA+MUJwx2eC6TG6LCbwHutE00OZagsoo=;
 b=CJ/ly3V6/FmSIev0P9o47oL+QWzVLhdBImWOD6gP1PTAykpGgyJAKbUg8oo1YEdVi62HvhvbfLJ5oslpeCCpObzLxCKI9VxyjjWob8v6JTRR5uttPWRK9pqw/uwpThCxeJxuZ6QvOPvDLNsoEG99szCV3OVlauxr2qZAnNvt/Ts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 14:51:06 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 14:51:06 +0000
Date:   Tue, 20 Jun 2023 22:50:43 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] ACPI: CPPC: Add a symbol to check if the
 preferred profile is a server
Message-ID: <ZJG8w8le9AyRWKzO@amd.com>
References: <20230615063200.4029760-1-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615063200.4029760-1-perry.yuan@amd.com>
X-ClientProxiedBy: SG2PR03CA0122.apcprd03.prod.outlook.com
 (2603:1096:4:91::26) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb90ffd-efcf-4ecc-536a-08db719dc6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYiUzocSDGp533UCwBocKbz5MuCV6OfcI+x/ZWuxRhd9x77H5oqXcQvHEixj1pH9H866TJBE6y32TypPWH3g+vIiT5NhVMAh3vbHhV5J+s41ybj/VEm2IOvaUrgxN6DPtN21WRZwIfPUbIPYwFoCJHM3QvJg1q3acVeXBb8nesyVuHrINDb/MxjeQ2E15H+Uzgw0atVDaap4XoeP4Lvo2zjF9XjbSQqwLODYLkrpyKnzsSjeKKUc7Ra7Fi4gJk2Ln14hwEEEJuBqt/h0TiLtwcz1+EfpG0NgbFo0S6vVrEbsNLr8u+0WdvZWGkd2grG1TbFWZjrJ3JGLJqDQFUQVUiHmvUrb8v6RtmRGUc3GXtUzwI9iUhFXR7wVrqkEGBOabJjdN5nbY0+2bL0L/y4VI9ks5sC+Mb4rGYGiQ/2wOBY4ZDHxNipan0p8iyaRGjexNtg/u1xFFkH8kwmr47/DxbA9/HbFHS4s4ind6bLDEbdp6HBfCZd5vaWIbdjHhAd94UNEToRkwGduF9zIa+3p0A/PCVAnKZfrlqdiz2Pm3hQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(2906002)(6862004)(2616005)(83380400001)(8676002)(478600001)(966005)(6486002)(6666004)(54906003)(37006003)(5660300002)(6506007)(6512007)(8936002)(6636002)(316002)(66946007)(66556008)(66476007)(4326008)(26005)(186003)(41300700001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nrl57oLO8axYOtIIh0wsnJo8XltGHvdmuHAX/Qp83Oc7fe05TW6GEbd1e99r?=
 =?us-ascii?Q?aF+koP4+YiJEmc7gK7LH9mkg/hIupEC8Y3ZTBkooxM8i3N3NAmb7CxtFao7d?=
 =?us-ascii?Q?cVcJywYBw3D3608LHAeRZ4D3fDoAe9cEgzSejAZxJkXVtrzXDR5jDTe6fFOX?=
 =?us-ascii?Q?SgHBuMWRY7wkTfYN7Qe4MeTWQRPoHGX/HhizYPTlP18ji8tHqMrvo054S2ur?=
 =?us-ascii?Q?ZgnzTazq0BPGBaYO+p9eTGBzfwV6mFxQ28FLuQK5JJVB+deKU+Ob1WgHe1Pt?=
 =?us-ascii?Q?j1zcjm3QflgG3hIVBMkhJmakHqyh4buTrk/sIEdRZ16p3lWa+YbTSn/lRGYv?=
 =?us-ascii?Q?lGE5lRy0UeJKM0qWHlhm001HOyC/0qneIoB5rY18BXP4K9WUAnjCxRjWkTPF?=
 =?us-ascii?Q?Mg4UKRrmn+yXZ4/7uuxYrGxT16uWcYs7j8Sgrz/ytE/mTYwpV9wjZsO20JQt?=
 =?us-ascii?Q?kwlSfvKK5yDF4fsDU83V9IVDjKaFrCuLfi4kaB3w0R+JCsW0tmhyqGPZOAPp?=
 =?us-ascii?Q?vd32vjOoH/cPxtalUk3S9aPQIIq/0XXYkvUKHBm0G4A9FooMTtfzO5Udy9qY?=
 =?us-ascii?Q?v4UlyooC1TW2+AheHm1yX+gyLfcBwX8bLPiPgqXA1O6SDnlWG7cRDJXJvZoF?=
 =?us-ascii?Q?eGBfLOFiGyGNgHrAghrxKB3Z3FgPmMq2d7Zx8Y/IIOBc/3PD2qnSy7rpvTMF?=
 =?us-ascii?Q?j96Za7iBFy4TRdCGTUqX7XenYuHBlAFTo4OFyvbITFkNMyZdbnq3PlZxgdPn?=
 =?us-ascii?Q?FlFcuABk6Gk+CLGayldVwxShBl2UcMFnDPFIEQDGbux6UyEDVhmOseKTXsfk?=
 =?us-ascii?Q?cNzUA++zSZoBHdehUFWZP8Qw5IQUJjC4XZ3ZazUTIyGtfxEGENva9b2SkpCS?=
 =?us-ascii?Q?f2McwMiPm1RoxLZ4/Fbh1ZDW9THuyqtwjSoWBEC9EPt0qKXII3glEJ91KZu3?=
 =?us-ascii?Q?2D3uzqPIF0DV3uimuRYE5C0FqT5xul4q5tCTUkhE3bm9IVImdOs24tgBU21W?=
 =?us-ascii?Q?SRuh1So/GhEW2py8CPnpTrSgXJB8oJ8Ioc0nYE/xPT1x8aZulyU+uCNtcG+D?=
 =?us-ascii?Q?DsMT35Yohz5Abqq1EZxOjaaT1Dk3++nosgcuq185gGFr3WZlif1Tq081hc7z?=
 =?us-ascii?Q?KB6vaGAMz8hP9CyWR6oS/G/JRDoAaF0iye29jTPZXCCK//H8yGvDtndDVCOr?=
 =?us-ascii?Q?IMR7NiYLeoI55ShRukat3GowCdZRxOQmhClPHNtYye3fFkKs+QmNET73j23A?=
 =?us-ascii?Q?e7+BdkrVMp+UhfQ1HOQBWL/MRytFq8JLXLKYapzeWRrKo/XsTeyMu8w8eVeN?=
 =?us-ascii?Q?fpfiTiTQYn+NSPYZ3kNUFO8T+Tg2Y6Rdt+cLk8uRdwZInIkCDvMusfL+zELU?=
 =?us-ascii?Q?Vw1VtGDcpCXCD127n91E7+VAfk6rTsKU2fXDovhkH2PoK0B9vjWXjHNjjZfq?=
 =?us-ascii?Q?+pPYXbbfPE7Z0DsIa1aLlhjGGWx+OeKPuQJiB4iTpjGrykR2Bu56Wf1Ex7N2?=
 =?us-ascii?Q?dter45y3jdt+2gs7e7HmFWsKJS3qhvXKKdd2iDjKyNdkD9JJnkoeQdWTwdF4?=
 =?us-ascii?Q?j4sU7wGfhlbJZnIrpy2JG/FT71IHoEhr+pZ62k1W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb90ffd-efcf-4ecc-536a-08db719dc6e1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 14:51:06.5891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXx6m0PU5u7WfwRfyZ1/yzN8Drsb/KDNgk4AMgeIQvLniv4gJBZGvJo1+QcidrN6DgTFROg+JedNGX/zV2fTnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
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

On Thu, Jun 15, 2023 at 02:32:00PM +0800, Yuan, Perry wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> This symbol will be used by intel-pstate and amd-pstate for making
> decisions based on what the FADT indicates the system pm profile is.
> 
> Suggested-by: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fixed-acpi-description-table-fadt
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/cppc_acpi.c | 34 ++++++++++++++++++++++++++++++++++
>  include/acpi/actbl.h     |  3 ++-
>  include/acpi/processor.h | 10 ++++++++++
>  3 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..d8827eae3ba4 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -941,6 +941,40 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
>  }
>  EXPORT_SYMBOL_GPL(acpi_cppc_processor_exit);
>  
> +
> +/**
> + * acpi_pm_profile_server() - Check if the system is a server.
> + *
> + * Return: true for server profiles, false for anything else
> + */
> +bool acpi_pm_profile_server(void)
> +{
> +	switch (acpi_gbl_FADT.preferred_profile) {
> +	case PM_ENTERPRISE_SERVER:
> +	case PM_SOHO_SERVER:
> +	case PM_PERFORMANCE_SERVER:
> +		return true;
> +	}
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(acpi_pm_profile_server);
> +
> +/**
> + * acpi_pm_profile_undefined() - Check if the system is an undefined pm profile.
> + *
> + * Return: true for undefined profiles, false for anything else
> + */
> +bool acpi_pm_profile_undefined(void)
> +{
> +	if (acpi_gbl_FADT.preferred_profile == PM_UNSPECIFIED)
> +		return true;
> +	if (acpi_gbl_FADT.preferred_profile >= NR_PM_PROFILES)
> +		return true;

May I know the acpi_gbl_FADT.preferred_profile value of powerful desktop
such as threadripper or AM4/AM5 socket types of processors?

I am thinking whether we can use this way to differentiate powerful desktop
and mobile platforms.

Thanks,
Ray

> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(acpi_pm_profile_undefined);
> +
> +
>  /**
>   * cpc_read_ffh() - Read FFH register
>   * @cpunum:	CPU number to read
> diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
> index e5dfb6f4de52..451f6276da49 100644
> --- a/include/acpi/actbl.h
> +++ b/include/acpi/actbl.h
> @@ -307,7 +307,8 @@ enum acpi_preferred_pm_profiles {
>  	PM_SOHO_SERVER = 5,
>  	PM_APPLIANCE_PC = 6,
>  	PM_PERFORMANCE_SERVER = 7,
> -	PM_TABLET = 8
> +	PM_TABLET = 8,
> +	NR_PM_PROFILES = 9
>  };
>  
>  /* Values for sleep_status and sleep_control registers (V5+ FADT) */
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 94181fe9780a..05a45ebddaea 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -360,6 +360,8 @@ int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
>  #ifdef CONFIG_ACPI_CPPC_LIB
>  extern int acpi_cppc_processor_probe(struct acpi_processor *pr);
>  extern void acpi_cppc_processor_exit(struct acpi_processor *pr);
> +extern bool acpi_pm_profile_server(void);
> +extern bool acpi_pm_profile_undefined(void);
>  #else
>  static inline int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  {
> @@ -369,6 +371,14 @@ static inline void acpi_cppc_processor_exit(struct acpi_processor *pr)
>  {
>  	return;
>  }
> +static inline bool acpi_pm_profile_server(void)
> +{
> +	return false;
> +}
> +static inline bool acpi_pm_profile_undefined(void)
> +{
> +	return true;
> +}
>  #endif	/* CONFIG_ACPI_CPPC_LIB */
>  
>  /* in processor_pdc.c */
> -- 
> 2.34.1
> 
