Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09B072AAFF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 12:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjFJKzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 06:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjFJKzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 06:55:21 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D07535B6;
        Sat, 10 Jun 2023 03:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Coy5bMHmKpaJxEuoG6kd2SVCPoWLt2ZJTZwApBvmydXSk4SKlODYHr2EQfWj+QhYa0zEOzXZ8vKgS4ZjVQsW57f96iDKTdP8ob++VNmEmByTqyKwZOAVCfy2dBIZ4PZk8tZFSFWhDQEm3rBRrCSoMilOfNablCatxsFSg7Cr+/vuOUIaoldUFGjMGv18lB/53m2gok27owStcU6y+c074GQIChdG3sA6yo9oIRPgPTg0/AsYuMghvzwC7HsbYq7CD88rl0K+jC3+/H7J8FSJqMRv9sXIL00PrsaX2jQq1u4TQh8ohYSwGnTvIqaj9OmaS5tBt5gr/DWhSLjnYGC3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbTgN/2iNjufD6MbsGjh0QSuTKiQgzK7ltznj4oA39A=;
 b=Jk1k7gDnuVVgZqxcD7BNXrZ5oeHkQUQCIZa7B8xwylarlYbRyNfOIDHb9VqvrzNhsyypim1+7yfB3K6xSRlqfVq/dot6EDs31HZE2KYL8DfDfD0WlUISDa5jSltUd4o6GVC7m2P/sM5NLj4MUTizO/TqFibeBlnKY+yiLYXjG04IbI62xixpTCU+SIXOnd1ZblfCN5gqSbh/FiqHfixK4/UaSQWOQajyoYZzy/FWhcnLx+R89Pp0VMftKqEYN7X0LszN/GZMBc/n+ZzK8BkAoPiMLYcVW/DOPlc38v7cEmXp0leC+g83YyoSj7WUgyHHc1dIG/ittUOCLuFG28KQsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbTgN/2iNjufD6MbsGjh0QSuTKiQgzK7ltznj4oA39A=;
 b=sjjsegkpASOuOBLdCqFoLA+1VJ/tPBlR6vRq6UWZee2XZgvoikubEVWvXdmvwY64Iz2b23A2WTU5oSenL84OnFs+yj9dUo/ZN/oNNwJRa2lH8xRUCtYm5J1rJMaEZMGKAG5zEZDYPY0k0Hxeg7QoijZ8cWf5CjBlHDTKgV+1pqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2506.namprd12.prod.outlook.com (2603:10b6:907:7::12)
 by SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Sat, 10 Jun
 2023 10:55:17 +0000
Received: from MW2PR12MB2506.namprd12.prod.outlook.com
 ([fe80::253c:2975:4f1c:c5ca]) by MW2PR12MB2506.namprd12.prod.outlook.com
 ([fe80::253c:2975:4f1c:c5ca%4]) with mapi id 15.20.6477.028; Sat, 10 Jun 2023
 10:55:17 +0000
Date:   Sat, 10 Jun 2023 18:54:56 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: Set default governor to schedutil
Message-ID: <ZIRWgJ/XW0VzKD6J@amd.com>
References: <20230608095358.30548-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608095358.30548-1-mario.limonciello@amd.com>
X-ClientProxiedBy: TYAPR01CA0048.jpnprd01.prod.outlook.com
 (2603:1096:404:28::36) To MW2PR12MB2506.namprd12.prod.outlook.com
 (2603:10b6:907:7::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2506:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae662ad-a742-4413-8e8a-08db69a12ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3izkJN8xUwldBAk+Leyez0/M+Lw587q59wAWtXDYnL8wna3z7x6mgd648ahn1/xncvTi+qMZRpd441k636Taa7Z7FBRlxnplo1jbm2JbDy7krZ7lY4xQkCv/d0TbVnDMlqJuBZWHFMhQ7dooEoZf4Ixep3MTykXdLyrlb6LPpuLDXewXabe1cEh7DGRCeNYu1cc6pPtLIQsY30/PsoJFM6I4KOo90yQBkLYf6Oq3iKfT3CGSY1cU3w9MrefveHTvEGYH5FUvgYMilTDL0RB2lDem1u4FczZ7XPnhLKb1L5PszzXG/6CghIdJ9LJQg/23Wi8NsZrJf9yZII+L+eQXSA93vdaoWwMMQBTjatiIX+3CkzSBaeyKdGu0mylWfA7IKytcNrwOxRBcO7ycJeQ7mc/OWLJJsalv9A8J1sc1S17RrXMngtAWpD+GGBz+y6xvzekXleLnkIOTsjI2iO+lvTbPrzi+qn9NXVhaLYzpzSvpYcFPcJu3no1GP7+Ass0eT+H67F7qTQes4ffqD+dzNeCjUanVlCArxmSttzgijtF76d/T/yjihpQrHbea33i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(316002)(66946007)(6666004)(478600001)(4326008)(54906003)(66556008)(6636002)(66476007)(37006003)(36756003)(86362001)(6486002)(6506007)(26005)(6512007)(186003)(83380400001)(41300700001)(8936002)(8676002)(6862004)(5660300002)(2906002)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v1QplHSt/m1yo6miI/WyyC7fz1wjcKHr8QHhFF1Kid8EqvAfuAf79Chwglhw?=
 =?us-ascii?Q?WckMZrUrgve+xhDARoRwNdNYgSHauAg5ZKlR+Pfi0mQVEEiOiwLcMMwNsxbO?=
 =?us-ascii?Q?W3tK4A6gDDok5ZGD0yKa0uQSK8symk9cBq/nyLJm/+TXl4uBd8BuIpO65WUf?=
 =?us-ascii?Q?NGEAaw0KhVFwWtrfRBsNS4J584nYxbpGhDeMO97CMTozH+cCXmRUoHFiXuaV?=
 =?us-ascii?Q?dwoXYvZh4F6F+0q0GFBCyYfw+aJTu/S5hYCm7vfVDdZOrgcgJxJ7voyvpV2G?=
 =?us-ascii?Q?5G5I5X4VbYi7hQG3+QJQxwv3ASoF1/PdfOFAKOdvH+5hATRp2fwkfdkrimwD?=
 =?us-ascii?Q?JIgSltb4b2egWtTRR+0FOPfKLxf64fMPBtlrIpWRp29nXojuZIGLDLd7uOSk?=
 =?us-ascii?Q?XzUsXuPQM7AOdN2KUUja+upEi+JyARSBAHAwN321kV2JxJsso9+IhBDNZJAk?=
 =?us-ascii?Q?aDJ5fNJ4VammsLCRsWmqH8UspvIwI4kL9rvz8HbHMV5rGgEPSyLjj/jdtUlV?=
 =?us-ascii?Q?CMmUUAn0seXWuTNGrAxwOnM2/HvfmgO2d/yt5f2A5mf4UdPGyi9oJBDJJxwi?=
 =?us-ascii?Q?8uFPPm2In+DvbgJ70IoogvVVEFLNMH/MSc7XWtUIDyd8PHmgYFETuOynVA1c?=
 =?us-ascii?Q?wK/uLmyWq+64stSboRZpNxEdZ53BON790VcQjmmT8iTOaycL+JoyVeSm7m0i?=
 =?us-ascii?Q?dKLIEKw83hgchUrns8Yv7xfJJEzDJ9tVNns4Vp7hyFm9AmiRCYFcS59eTkXp?=
 =?us-ascii?Q?ZCmYY/BRAammZj4Y6IVe0VSiZkLCTMCzzNFYX/SkGb92BXb7TgLiX7P9HzZI?=
 =?us-ascii?Q?ZUUUFQ2YNm1kDP4sxVFgScG+odECXVwrQek1qCyLT/CTElOMC3LWdXDE2U8w?=
 =?us-ascii?Q?8I+V7xJ4fcx0kLIWsC1xeHGHTrWBiu1EJAb9snvo2g0va0I3cBqRKGfAI9bc?=
 =?us-ascii?Q?8tuzOK3cpnM4kIeEz0SROrO2gT+nFFfQYNERFWKykTu5CEPD/aurr5keYh82?=
 =?us-ascii?Q?dJsIFnL+zXUwY+FfYQ5i/v6Vsjbs63kg0r9Q3QqD+oPtZUUPMaF3CiMKRsxL?=
 =?us-ascii?Q?9F81W5alTtfN8jiWIOsQuI8LcQ2oXX8HCOtjwcXx1Vvg52OovIy6z1MWvn5A?=
 =?us-ascii?Q?5YLA9KzriG1JrD/V1ES7l1/6SuDplr/tbt8Gz25UIkzFT5gUHAPXuo8j6PXL?=
 =?us-ascii?Q?bVz6h6zro2UkUFMG619GGJAzPlrmX57p1MktrDtgw2yI3Ml3ejwuy1BH1ET/?=
 =?us-ascii?Q?hHrvDrX+Jkuy3Z8Qv/S7Pb3/kJPl0SH339mSwHg+mlTlmb7RPonARk2p0cke?=
 =?us-ascii?Q?YceVf3b/cHHITIYwHNn+kT2dre5Wm8MIJKgJIfqGxTfZiQtBssi2dv8e6we9?=
 =?us-ascii?Q?cn1gouy/6qwuqRViHVvSqKc5wtYIb9urstnVsFyx458r2XbeLMkEa1f0gyo+?=
 =?us-ascii?Q?ZFWKZhJjc0r2Wzk8tAyY3De+hwi8Phiy9E89ygfBs4IjJj9+VqsFCqgbUJJ2?=
 =?us-ascii?Q?M6hp50APydye6DcOPZnYvqGiwMAa7jjrL/Vn2bJyfI+f65im1W8CRdqG5LaA?=
 =?us-ascii?Q?7t5sOCyYPw9PgFxGX/2dwKtMRvFs2clupJxXK9aQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae662ad-a742-4413-8e8a-08db69a12ce7
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 10:55:16.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p72ukTfDqFmM9QHXST34xu21Yd4QUam6lpTkNbxEvXUZeR1qiYfq2i8ktiEY/W1QQ4+CBa9+ULVenWM88jHIHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059
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

On Thu, Jun 08, 2023 at 05:53:58PM +0800, Limonciello, Mario wrote:
> The Kconfig currently defaults the governor to schedutil on x86_64
> only when intel-pstate and SMP have been selected.
> 
> If the kernel is built only with amd-pstate, the default governor
> should also be schedutil.
> 
> Cc: Sun Peng (Leo) Li <sunpeng.li@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 2c839bd2b051..a1c51abddbc5 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -38,7 +38,7 @@ choice
>  	prompt "Default CPUFreq governor"
>  	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1110_CPUFREQ
>  	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
> -	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
> +	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if (X86_INTEL_PSTATE || X86_AMD_PSTATE) && SMP
>  	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
>  	help
>  	  This option sets which CPUFreq governor shall be loaded at
> -- 
> 2.34.1
> 
