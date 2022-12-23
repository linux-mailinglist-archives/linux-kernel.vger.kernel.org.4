Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E21A654B99
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 04:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiLWDKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 22:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWDKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 22:10:52 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23976270;
        Thu, 22 Dec 2022 19:10:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUYRW4z2f0KkNUOoRLiwrrmQuwsY4tsOZZBtxO1CR4FcY6gPnrLEgmmpwK/Cc3Sgo9u78WZnJRB78rypwwCKvU1F62HVzfsJ6VoyPtUESIGBS8QIv8YxD49E1vvUOIdbgc/ibCGe8AGH5e3N6QVaY58CdFdt2WzBeiRx/RN3KNOVnSKJOXbi41ZWldQpqnHARELH6EyO5qvPoivqYyFL6MhM03vS9LbUAtGNd0jMkQiaBI6g84PhFJNMlgJL+WNCe95uyPkHO8/1KBUdgz7eEQFQLF946Z00pEN0eHztSWW3bZV9EnA8y+qEdc9AmrhceABYHb6b9SUHi3gs0ECIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCtLbZGp2Hio6FU9u+l3DdUbDLCMpWLZG8bzqjFFUCo=;
 b=jJavJduF/CJ7T7ogHRtMT+QXe8geUpaBkUIkg1a54RjQBWKm77UUD/rwFXcmOZWlU6qmUv37BLhYw+XPZab3UY3kenP2BmZ6neyZ0rH/C4GM7ynJ1eTl0FlfjsnA2g5+ODH0QQXOSNkRp/3meoCBMr5TF1G9N/fr7KY2CKkgaUthYfNrFeZaVvaCLi5E+dgCI3q9K9VyIwv0jC4VdP3vkKQzbMm9fFZGcfR/MHCXzDL0NB6hxfown5upy3hlZzIiRo8NQLcRazgRRsR3WsmZJAthFNbVdeFLLtR8O8T7Qfc1+UaD7gfWH/2jryGgH7NSiHdru4fPupD1d27NOdSO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCtLbZGp2Hio6FU9u+l3DdUbDLCMpWLZG8bzqjFFUCo=;
 b=depVSGruagcgGA5FD9DwDSnjN3fUIMwtiSryuj8A8JZOWUJpgod/KirXLS7IOp7YVxAHFtIX6no7iDKePiuBVD9OSAHg18sckUrEMoI4KK8BwLkacZrB+wohtHwCvCm0QtcSO8XbcoykuXRf4/FyBnD5J5r7MuUpU3WWJAkwmEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13; Fri, 23 Dec
 2022 03:10:45 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Fri, 23 Dec 2022
 03:10:45 +0000
Date:   Fri, 23 Dec 2022 11:10:24 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 03/13] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Message-ID: <Y6UcIBWKlYsUOybH@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-4-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219064042.661122-4-perry.yuan@amd.com>
X-ClientProxiedBy: TYCP286CA0172.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::10) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|BL1PR12MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: 8090ac47-9074-4a9f-b3b1-08dae4934876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 20tGK61wtgluSFWY0ru4clM3NCryhzXzM+CMKgoQG3uxwEQMDO5rqyr4quX2kWaLQTqxbh/p2swzMFv8CrYiwAOyF8PBf/MqvYVbpIpl8T6RpUrKjeFXr0NqM8ou03BPfEKpaY7pLlDa4gWaWj5c/Y50x0sysv9vYFuKwhZDQ4j7EdO9TMcysD9OToOuXl+hLj2xyXzyQOIiCca4at8sVBg27eF934NoYrHQf6HApAdLHi7STdMUTxJry+JFa4Y1WR39/gZLJ5Xo3EETIluPh+xa092u+fytsW1ISz40gq11hWVoZQ/TGFSMzyhk5quJnHuRT5xjrAlHGavk0sRHbr98qXidWKnhh82IVclFlPhDBNDIqzyv+RzafGQ92gA2E92XoXUhUjPdPaooH76jbcuMw47TUHtF1EB4Ke44IrezYhqbkR4JwRz1JtSzjLQVLAFWpPEbgt0KsMlYPg01OjKXYt7MSthJqBg9rZVjgOFQSJks8PUJqDhWiC0vmG8MCUDSU27bOEn8ZGHtvRWLeNadax0y/OoTj3RZdWq7XcPdEtm2fyHdbGVcufU0OOS8WVi4O42DSN+NNM9MqE/L/fo8uMNHrbsLOzMtQegS5hHpN9YifsFIYdQWBWQzMkAHvWDYrGaPTHYhIiK1jBIHhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199015)(6506007)(186003)(26005)(6512007)(478600001)(6486002)(6666004)(36756003)(38100700002)(86362001)(83380400001)(54906003)(2616005)(5660300002)(6862004)(8936002)(2906002)(4326008)(8676002)(66556008)(66946007)(66476007)(37006003)(6636002)(316002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tPW4nBsFX1V5bm23y3cmK83A/65ne5b2Xtxt8IxYrE9Pj+tuXCWsXxkXqMm7?=
 =?us-ascii?Q?LfQsDrjDiyfulFIGQ4Vzc3F4rND0XBH47Yh+1kvA+0TH9baXPt0W2JjIMvdN?=
 =?us-ascii?Q?IU1Zy807EI3VgIfArAKMEYj4j0zUDSxKum8PLfCY9nmaxvfPwII7bdg7Foje?=
 =?us-ascii?Q?G7M8SFoJlMXUgpLBZ+bFoBJQOM8q8dU0T2pKeHcDbum04+GK/OQvRgAeso2k?=
 =?us-ascii?Q?1lTYxk4r1xJUca43IxP+gry0x+X7qj0nf+RS3cbGwuFYrtiRAVodNnKtZzzG?=
 =?us-ascii?Q?JhAps14ETEZbWjBkryu9tzcS2tt6+VK2jgIOaH7Q/g9GPG4uujdP+JhTI6u9?=
 =?us-ascii?Q?j+9uXyz2l1p4CjemwNNSbUq2fULhRzq42hYXrXeAaJh8/f+sg7pExYZ17pJm?=
 =?us-ascii?Q?U81tWknohahDaQctrYsWT+YYL20a0GcvDL78IiS6MXTWLPABT3Y6kZhRjhNR?=
 =?us-ascii?Q?7KEvQHQzTn39UiqxeXL3pFJQEJnWA3A3c+tl7qH9AsqVPsYJdO6H0CoAwsLF?=
 =?us-ascii?Q?rJ6KATSd2QT931UMLs5LzP6c060QnDcXXqvx2IBkkj+npc8/n7PMtQOiczDm?=
 =?us-ascii?Q?lkZ5R28+aD8Js1Try1+KAXpJAP65nwGHM3mt8EOYBnpV6wXDE1oJhYkJuADe?=
 =?us-ascii?Q?tyUWG/15vh9Gl9qudp1Qo5IC/8Cw4oG4zG/cpHdxirxxmPrjgyaQFYb+3Mys?=
 =?us-ascii?Q?P24Yph3kN6jcNPpqLc5hzFED/KApX5TDmhdOTO3rAohF3QJbVIr3xwKmpPsR?=
 =?us-ascii?Q?c247XxirWm2AmqFy5XK5Cu+nt5YSprV9OufvynNOZRWkni9sD+LdAjug747x?=
 =?us-ascii?Q?kFbLwyqPk2E5XrBMlOg22LI2FIjhhiVPZHCn7X37vwnrndNyWN/2Th54jisJ?=
 =?us-ascii?Q?S5lB6BmMC2ddlHEukuxiwtBgVSzdm0Sv1OONtpmo8q0WobQo9bM3r/tkzInr?=
 =?us-ascii?Q?8tg7yhvCLFA4qwEkWpQr5pvW3DY2EtMLwaFJ+scUV2I28HaEHmQTBLktRalE?=
 =?us-ascii?Q?6jgoTIHcr46V8dNnPngMQkxqiCYd+K9alR81W0UHrDH1tNC13d/aA8tS3v8W?=
 =?us-ascii?Q?ijg6qGWNvjowFrUzpKNflFeSXbNWcSR6lEfxu/JlThcDCG53sFLsarx7h/QG?=
 =?us-ascii?Q?/XHuiASP847aIH/B9lnoHVVjekP21oXPZXzPttYANHgHaHHMvqOG0vIionje?=
 =?us-ascii?Q?qxeCiB6xjf7MzgStCmqLAKkhAAiUZHWpsjB0puCoCnhS/iCbnChutMmEkiTp?=
 =?us-ascii?Q?D1TE8TiXY+e+WTyYHEcztGtLYaFrEBsif5+RXsYSn5inpfaAT/f7IpYY8x6p?=
 =?us-ascii?Q?3o3gfvtM9n5CeH20XF5Vmm7Y3FiiC/cDMamJdj/b+KhqcBkCzZDArI+BUzLt?=
 =?us-ascii?Q?0ZalZKLGUPMDm2QkLVYI8FPdiDLVR3PNRha4vji8tJiLUf1AOlxv8OxpLNj4?=
 =?us-ascii?Q?x8P3AM72WhRQ2RLdwrI4GQdRtIytjDGKUJsvQONjq4/0t3bBOZ7Pk6Iyafst?=
 =?us-ascii?Q?4pdDhjfvrGmukkJfpLc2PX2DQrKTolEU1kkXveGxCTzgaZ5pFwbqBQNc+Tix?=
 =?us-ascii?Q?ietObhAltVpzs/rkUBZUBbcoF/ekJlCifca74i7v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8090ac47-9074-4a9f-b3b1-08dae4934876
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 03:10:45.5754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+v/UDw56jkkcovmMd7TesLadFeFokpyCGlidZ9klRv20O3hZhz+h5AyYxWTL8XK7Yk1+yCzEZraNaQ910soVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:40:32PM +0800, Yuan, Perry wrote:
> make the energy preference performance strings and profiles using one
> common header for intel_pstate driver, then the amd_pstate epp driver can
> use the common header as well. This will simpify the intel_pstate and
> amd_pstate driver.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 13 +++----------
>  include/linux/cpufreq.h        | 11 +++++++++++
>  2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index ad9be31753b6..93a60fdac0fc 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -640,15 +640,7 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
>   *	4		power
>   */
>  
> -enum energy_perf_value_index {
> -	EPP_INDEX_DEFAULT = 0,
> -	EPP_INDEX_PERFORMANCE,
> -	EPP_INDEX_BALANCE_PERFORMANCE,
> -	EPP_INDEX_BALANCE_POWERSAVE,
> -	EPP_INDEX_POWERSAVE,
> -};
> -
> -static const char * const energy_perf_strings[] = {
> +const char * const energy_perf_strings[] = {
>  	[EPP_INDEX_DEFAULT] = "default",
>  	[EPP_INDEX_PERFORMANCE] = "performance",
>  	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
> @@ -656,7 +648,8 @@ static const char * const energy_perf_strings[] = {
>  	[EPP_INDEX_POWERSAVE] = "power",
>  	NULL
>  };
> -static unsigned int epp_values[] = {
> +
> +unsigned int epp_values[] = {
>  	[EPP_INDEX_DEFAULT] = 0, /* Unused index */
>  	[EPP_INDEX_PERFORMANCE] = HWP_EPP_PERFORMANCE,
>  	[EPP_INDEX_BALANCE_PERFORMANCE] = HWP_EPP_BALANCE_PERFORMANCE,
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d5595d57f4e5..e63309d497fe 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -20,6 +20,7 @@
>  #include <linux/pm_qos.h>
>  #include <linux/spinlock.h>
>  #include <linux/sysfs.h>
> +#include <asm/msr.h>

Please don't include msr header in cpufreq common file, we already include
it in amd-pstate.c, that's fairly enough.

Thanks,
Ray

>  
>  /*********************************************************************
>   *                        CPUFREQ INTERFACE                          *
> @@ -185,6 +186,16 @@ struct cpufreq_freqs {
>  	u8 flags;		/* flags of cpufreq_driver, see below. */
>  };
>  
> +enum energy_perf_value_index {
> +	EPP_INDEX_DEFAULT = 0,
> +	EPP_INDEX_PERFORMANCE,
> +	EPP_INDEX_BALANCE_PERFORMANCE,
> +	EPP_INDEX_BALANCE_POWERSAVE,
> +	EPP_INDEX_POWERSAVE,
> +};
> +extern const char * const energy_perf_strings[];
> +extern unsigned int epp_values[];
> +
>  /* Only for ACPI */
>  #define CPUFREQ_SHARED_TYPE_NONE (0) /* None */
>  #define CPUFREQ_SHARED_TYPE_HW	 (1) /* HW does needed coordination */
> -- 
> 2.34.1
> 
