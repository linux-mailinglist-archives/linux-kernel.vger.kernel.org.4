Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0D6721F9F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjFEHdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjFEHdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:33:33 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2135.outbound.protection.outlook.com [40.107.220.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1BF10C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2o5vdcBAYYS7bww2FJv/NLRHEvd4PJJ3Em9j2FW00YlPaposO/hdtfxAQTRsd7QW5EQMKsXvJleb6gjFvsLgmg9/l8nytJdIWvXQnyNrgMDT9HkoF5gKW6adSpEbbTgvDpTg4tSugYFBCmSyW4Z+//u/PHPhLRfmh2uvxrhKgQgD6FbN+2upNkoKc8kI4QasGONZs3XM8oedT2WX86XoCMM+NWcJwdnrI688kQbm7eAgj0kiZhE/Dd86yC8D5m+70jPlon6DxyBopvWa7WvXUCmB/G6KMezCUtiNC9ZEOVJoOc00yGulBjpu6CB4+pY+ypVLMpLk0qc72Xt8TBcIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irha/DoO/9KJ35FDRvDuaWijC0+f+bxB96MXh8XAFMo=;
 b=EYI3REQFQS6cvU+eJTtHY3YAHd44jwleINOSsQjHr4hMZObfj8amsJjH9OyduUhnAAYLKDtVxzDXhvQEvM4Jmy0sHMw4coAXZmVwQasXUpuyeVVrnIaow3PZoz7UOEseNB3N9T9zq4flf6lxZyREjT/D3KloiqqLfge6UlCQNN3nXUOtXrqQNq4eJP6fN454QhMSe3TB8kBk9pWBVt2mcpqHQpSwVymNz99oQr5CcHP03Vq49CFkjGs3KkKNVSZBNLMvCxWF6xNTCdGEWG/SdjNwzhlEU6pPBJZS3hX+SsxXDYSA9KKUL5wk6i3DInv8Upwybi2uohhHkkcK5qhsoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irha/DoO/9KJ35FDRvDuaWijC0+f+bxB96MXh8XAFMo=;
 b=IGzTjl5FDZuvYTAupRwgobYogu175/aviad+jG9hoDRHXhX60XDzxEJDhCp/lLmBByCkRuN8uM7Gd92gERzLcrgjs5HCt9F3MMRwy+UrRuSn8jNOkoZcfItdUH7/sOxDMDg54J8Wdtp/gJy3XHtIKfgp/+lIkOzDrAxOj9eFAgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA0PR01MB6491.prod.exchangelabs.com (2603:10b6:806:ea::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Mon, 5 Jun 2023 07:33:24 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 07:33:24 +0000
Date:   Mon, 5 Jun 2023 00:33:19 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        bwicaksono@nvidia.com, ilkka@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] perf/arm_cspmu: Clean up ACPI dependency
In-Reply-To: <70067704d217cd7504d9552d8485a54e5c071c90.1685619571.git.robin.murphy@arm.com>
Message-ID: <a096d294-76bc-b2b7-be57-64cacc68d890@os.amperecomputing.com>
References: <cover.1685619571.git.robin.murphy@arm.com> <70067704d217cd7504d9552d8485a54e5c071c90.1685619571.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH0PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:610:75::32) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA0PR01MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d65275a-0690-4cb0-d5a5-08db6597258b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: di/33NPZYtityg200Kz1NZ+UmenYIKoUzjkpFDpCTayfNODQPWiuTWMtdwXBl3etYpTVr9cssOfTjPPPUEMAkC8TjDQ9lI0FCCdQZF2mHY7WnkbMG3GD3uHKJH/f4D1+3YVZ+FyUlqfThC5LD0GBvt1Q/AOy1/Nz9rR6A2/HCVFRw5hChAx746dgUZXiR5pYXLFCKGKnNKSlUKkAdA/G/WCECQjQr6hKujzY7KuhyWOg1/NQKdzH7nuzhq8C+VCIcF/O8G7Hrn90zh224zbysYtC6tE9TM6SwD7UyEF/b9Rv+yLpu+OzhBPIHIW6qLELTuxyNmlZG18CJ0vK/Nm+0RlxjjUwWHfgVxJDjTmi6hmCAx4vpRrSONXXK0LRIwoJNyoBRrBg9w5aD6sVFZdE7MpLG4om9J0duzKE06i+FVxWVb6nPjGr2G71D0vTgv9TP6q5p/+7MQ9sHr3o+6/B5Yjo+hz9wsfrpth6O69aKypa2z7ulNgwwSbHcm1+rZNhcFkdWumAWBiKArqoCIYd44Q0rwL3aNckydBv/YSxRHBTyjux6/kp00+Qzkc63aFeQZMirtS2Zzejt4t8tebmeBDbfhAnlU6cc4jWrr4VFhtexugd+fEbjq4iauN/BonG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39850400004)(136003)(376002)(346002)(451199021)(8676002)(66556008)(6916009)(4326008)(66476007)(8936002)(66946007)(5660300002)(316002)(31686004)(41300700001)(186003)(2906002)(478600001)(38100700002)(6512007)(6506007)(26005)(31696002)(86362001)(38350700002)(6486002)(52116002)(2616005)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tYdzts1DlbTCM+q4peyectPYsOIAf2z1HnDPvlZxA+dIK+BCxi/xAFdw5bGM?=
 =?us-ascii?Q?pcyaVcIsi+0AK8LlRcRntqV0Tl57pUoLCmUQPKVT4O4vZ1ixznJ7OEAvb3QY?=
 =?us-ascii?Q?V1OhlpNnf4X8fTSvV7ckykKam/QM/6Jxkf18uLFBZpHmjmsIAylx9Zcq4ivg?=
 =?us-ascii?Q?pbpbFx49FiGgrbldEYS+DjLDobehqk+6wOXSftnPQmnm6ollt+DjjBdz6mjN?=
 =?us-ascii?Q?9Y6VZb/pZhE01xzXNnihS7S6EWGyPKz333vaD1AouF8txmtrUU3l+ln16HVv?=
 =?us-ascii?Q?hp9NVQugx3U1mEr+CFQu/ldgMYijOTJN+dW8yvM1yhby7Ya5rAy3utXCqMnx?=
 =?us-ascii?Q?PQ0qojAFxdqeDN8UC8VDDloQvLf0sk6djlvERe0Ru569vWORig32RFOtyGaa?=
 =?us-ascii?Q?gAH18m2c7Y32mKzpoKukPJJwGtLgNSjSRV89LSNx7wkfmZZuTb+HyVgj+bL8?=
 =?us-ascii?Q?kUULDD1zREx403WmIutaMZHRMOFZnAjS4JmkZIw2O7HSYYnbgDMxT8fMWZJ2?=
 =?us-ascii?Q?HhfFch9defbKyre1LP1fmPPoUeRrgnytLS9owsnW7mtJev1mfQkNE/V7IXaq?=
 =?us-ascii?Q?6QMQR6qo/nbOarlaAGTVr7mmcYf5bOQHUiqrai4VIGtuXyyrqIaZRHUy9YWp?=
 =?us-ascii?Q?MIhdmLXp/ERVJcaaCvbARucjDULSqpZWZGL+x7IOGFSUsmL2B7hTScJmm+rD?=
 =?us-ascii?Q?fixRUHTH9MBESDQWdARIebCWdHo5454ku9Tpb0/qVn3qN6CPSqB20lWaq0bP?=
 =?us-ascii?Q?e51yM8vCT4DXWsr9YGUBMlLfgL2Az7ccBPcba+9bwhgkejV6+Qy5eVGDbsYn?=
 =?us-ascii?Q?KcrpjNHMcukmZwD1vigb3uQD6NaY7fusxXHVln/3pH1CMAqV5PoBBT5zoymL?=
 =?us-ascii?Q?m44MCiLYO2eWknJRmgR6RxAC6TcPqHY5122gImylrBxz72TVOJ+P61oA0o22?=
 =?us-ascii?Q?Ex2EFrqiyzucuijf4l72OVdRNLAFz4ligJ7vzGGSHpDH/z2eppQ/F6BHuHCa?=
 =?us-ascii?Q?9dBV09Cz0SLrMnb3gnaPVyCh6KoLJMLx25SbZr7WEugCpoacLqq8ag+jhIFG?=
 =?us-ascii?Q?tiXGXS6OEMBHs5g3xi/yYTyDP3al2UMpXuoXszs+vK/Cvy7bKKfGSll6Bfmo?=
 =?us-ascii?Q?15U6MMYXfPg8giGeAltE9r4VymCktyvsI0mvcFmSqVhj2Md2iIWM/Ni2kb/U?=
 =?us-ascii?Q?2lVvWTXdu7iJUG5HQze/fYM9F9MZ+or2RGjiKBYByffaak7LvryqFGzAUQab?=
 =?us-ascii?Q?SNn7szmmvj6w/MecfwLZkr/TXsljlKKqkxTv3oSEALckEqpPs1V5pg4YkV7o?=
 =?us-ascii?Q?FTn1+7xsNQg4amcrAFAgWB3orBbXzo6/FdncuMWCPNJldkwcK1N2I3QMi/QJ?=
 =?us-ascii?Q?TsyYF6xo0HDmI55rvpk7XgUfWSaW7Ds8zIBWAPXsEHf8r9FW3RxhboO137CR?=
 =?us-ascii?Q?HJ6r3m243JUhAU3bcL0nJW6WcVcPAKkFUU5grsdpLOvAPc1GP59PmMDSI2NZ?=
 =?us-ascii?Q?WTHZ+kMOB6Kcm8NOEtvNwHy6U6Z1je56DplniSozjNqr4WbjFaWjQ7Bc46JO?=
 =?us-ascii?Q?2vMeNWuIQ+5hl4XUaFt9/GNX+LdIaOYezI8yzhpvKSVP74N5L3VOfou83lsp?=
 =?us-ascii?Q?eWnye1laxWIHnkhyuTCZypw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d65275a-0690-4cb0-d5a5-08db6597258b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 07:33:24.8374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHJ+mKZduRyuXQqUCddfSSVPkB0p5CT8VFUn/rJuFzCDgtJsVO3Q6eConJ31nCcJCbqXEzW7362J2aM9/4TApB0NWIekiLrMgY9iMHwOaw5uqozH2JiT0q5FbQwA7R+h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6491
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Jun 2023, Robin Murphy wrote:
> Build-wise, the ACPI dependency consists of only a couple of things
> which could probably stand being factored out into ACPI helpers anyway.
> However for the immediate concern of working towards Devicetree support
> here, it's easy enough to make a few tweaks to contain the affected code
> locally, such that we can relax the Kconfig dependency.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

> ---
> drivers/perf/arm_cspmu/Kconfig     |  3 +--
> drivers/perf/arm_cspmu/arm_cspmu.c | 17 +++++++++++++++--
> 2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
> index 0b316fe69a45..25d25ded0983 100644
> --- a/drivers/perf/arm_cspmu/Kconfig
> +++ b/drivers/perf/arm_cspmu/Kconfig
> @@ -4,8 +4,7 @@
>
> config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
> 	tristate "ARM Coresight Architecture PMU"
> -	depends on ARM64 && ACPI
> -	depends on ACPI_APMT || COMPILE_TEST
> +	depends on ARM64 || COMPILE_TEST
> 	help
> 	  Provides support for performance monitoring unit (PMU) devices
> 	  based on ARM CoreSight PMU architecture. Note that this PMU
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 72dc7a9e1ca8..3b91115c376d 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -28,7 +28,6 @@
> #include <linux/module.h>
> #include <linux/perf_event.h>
> #include <linux/platform_device.h>
> -#include <acpi/processor.h>
>
> #include "arm_cspmu.h"
> #include "nvidia_cspmu.h"
> @@ -1075,6 +1074,9 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
> 	return 0;
> }
>
> +#if defined(CONFIG_ACPI) && defined(CONFIG_ARM64)
> +#include <acpi/processor.h>
> +
> static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
> {
> 	u32 acpi_uid;
> @@ -1099,7 +1101,7 @@ static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
> 	return -ENODEV;
> }
>
> -static int arm_cspmu_get_cpus(struct arm_cspmu *cspmu)
> +static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
> {
> 	struct device *dev;
> 	struct acpi_apmt_node *apmt_node;
> @@ -1135,6 +1137,17 @@ static int arm_cspmu_get_cpus(struct arm_cspmu *cspmu)
>
> 	return 0;
> }
> +#else
> +static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
> +static int arm_cspmu_get_cpus(struct arm_cspmu *cspmu)
> +{
> +	return arm_cspmu_acpi_get_cpus(cspmu);
> +}
>
> static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
> {
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
