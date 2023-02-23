Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4856A078A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjBWLix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjBWLit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:38:49 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1534DE2F;
        Thu, 23 Feb 2023 03:38:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9cQJSiyW1NOvaMuCVYpySjFTerGiJy6z6aC1kIo9UkbOeQ6HE+Ph+t0KmNWpqogiyTfFiS3WZqdbjInDE8OywRkLZy8FGOOyQqvOYrXRVfCXV/+HlgfDsEINqzro+LLWJkHby83tt87wXaEpP7XOuzxb9nadyUWMOhlz4pG9depmZGQ6UhOvDuSxVn5fsCV/YzpDw5R350TIhr4++bgASckoRk3LZH49Wa0Leq7mlWU4wSsTLqNQ3ASjHF0dV54eyivaT4Ny1umbwvz7v44MgrKm7NBvxK9b0NjWN0YMAB0qYlclMBU8tz74ZqMkDWloifuVf99kMi/zxQMKl0N1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9gVqbjr1GTD6WGi7/Aj+q8E1KeC2Jrzp0i2+IuZWVY=;
 b=FU+GWKw5YT6Wg9zi+a8NMd2oUv1c6c4RVKNrenIqVLvfKdEk3+gvxM7U9mpw1dN15GjCa1LmfaFhQyJXklH3z0kbWYKaW1wpcIxJXIMKxpFohO7ULjuQqRzrwkOg8Db5P7kdD3816gAn5sfPbe3OJJiq0xAQe2qgYW+6P3ZUNstEpmaVPOKcwhZ3d3HCUn3K1S6bZ6lRZyuYNdCSBdrYok9sZ76DSOYNZbFnOotTw6FfRzTu7C9yzdnpZLGFM7u/JjNDtd5oyz+zObRyGw9/HQbjgAPx+Gg15Pux401iL1qhjfohy3x/KbD6A8ZX/+Uc0ZP7w8WZVGKsshwiILT/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9gVqbjr1GTD6WGi7/Aj+q8E1KeC2Jrzp0i2+IuZWVY=;
 b=kV6S+Iwfxc/5LjCLcI4i/VUbs9T2k3+VrfJEfzcBBczCrysU/E0SpKf8yzXo1+vOy0j80aPgNVgFie0R3Cv5eWu8nP5Uy7K6ujx5Q+z2Ugy9wDNowblUwez+0buU1m43Y4mNBkTJA3gDuNNRu7YRpEBw0c58Z60wS4NmTDhlcVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.19; Thu, 23 Feb 2023 11:38:27 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b%7]) with mapi id 15.20.6086.024; Thu, 23 Feb 2023
 11:38:27 +0000
Date:   Thu, 23 Feb 2023 19:38:05 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: amd-pstate: Let user know amd-pstate is
 disabled
Message-ID: <Y/dQHXtdDWiZOADY@amd.com>
References: <20230223070252.2029174-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223070252.2029174-1-kai.heng.feng@canonical.com>
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 728ae143-96dc-4f49-6bff-08db15927ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XkdCd3IA65R1ocxYWtvu4pDf93NJnqzt6cE1wDRUZc9zyZts1KMJbBtZn96G+dSsDUX4DnmboGQYcZbwStwtSabwhxxjoDCBDSHmjmQ1pI3p4uotvnfGSLlCpsIitKA4O3VOyvy0vOkGd9E8xD6P79QDb9+SUPOm11dmvfMo8j5vleYyaTQMFB339V4SAQ76IjnG1vJqRsn6P5snVgVwTOU8+S/nxRmv+DBR1PNWTvbFbK3+eqw10nqpPeDbgUdqMwh9N5obFxtkF9K/f21VjIRmSkx4ff4e1k1xGCZ0b1veZpHjK/qZ8RzPN2CLJSWiohdqG4jATQWdRuMwS55YVSHtodyXMRw+Vujt47bqFYUdgw+9i1Gvzl7DLktovOltPOzP/B8h1Y+OBwnMaMF/KrwwguidqpmytM7vyNKIlJbk3HqkIIm2y239yWW0C47GsRzEgBW3qkruqsWb3hLDq/nG2rRp8dO3yFd58zVuyDtTYWq519N8XUQ+Vq9SwkY0O2w+eQ0NfukOIY6ezWVqXWGmuINZ9Hc+2VPzfXQZREElqOqcf3HD3FlPXPCAMWqCHgMsWBHsFy6O+mUiUEWAatvieJighLOyr7+zOz31Az3iIIaLAVlP6KW3hgGmfqfS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199018)(38100700002)(83380400001)(2616005)(8676002)(316002)(8936002)(4326008)(5660300002)(54906003)(6916009)(66556008)(478600001)(86362001)(6486002)(36756003)(66946007)(66476007)(41300700001)(6512007)(966005)(2906002)(6666004)(6506007)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yrsvU7mfEnDTstkhu1vYYH4Kbu1IHBnAVNxzs8HquWEMH/gW3ymubvIzriK/?=
 =?us-ascii?Q?AD6e70DfGoczXL5SCvNY5C9iJaVXyeAiqhTsFgjCBGbqJDLjMSFY+N07Ehai?=
 =?us-ascii?Q?dW6SdeM8zBIHkeNCrIsW3/SCzqF0wm78L9xPhCUPuT4sS9LFPpvf4Fw+tsRP?=
 =?us-ascii?Q?LNkxvRgpdNVb0HmVuRnJH8pdNKL73ki5A0uRolbLSR0BtFxZDg9ZDKfI7gVB?=
 =?us-ascii?Q?y27jNM3/jo3jHidJ2mtasnHsAWmUJeGf+vZ9ug3sf9Pek7teeQjY7yiTBRcA?=
 =?us-ascii?Q?vn1fJEhzCSTQUpKUb8X6TRkSc5pmAV0GNZ8XM/0o1FiT1KlW/8NhCgfXXpDS?=
 =?us-ascii?Q?lW6pV+J5+T0s4W5Ew01LGDxyHfbBh/dMoHgDkV289IbfODQAzYfIs83pKKCq?=
 =?us-ascii?Q?CHZTT0Jmu1c2L3uG4/sZUQ3lWFnHHg7+W7xyPR16pXwBdJCRX+LBvP9G+WzO?=
 =?us-ascii?Q?hDlkIN/vDnlo2jUFbHNBu7Mx0DzOVtua8+Sj9ameGO6aHnUTGryDKmmIVNH6?=
 =?us-ascii?Q?Nx/pXwp3r2bgvchN6HtBfG0BA0lsizgzaG24CDTgcL9S+3vS9kaVj3eyGW/Z?=
 =?us-ascii?Q?zpg22MvEzKNPyIeTUhhC3URojA1UTJ7IYLCvkfXmuAO1SDtloX3nzoTGt1ja?=
 =?us-ascii?Q?cRA37qStxniWIYezpwxre5hOR6E9glOgP2cNvMpfBh0NdzuLbvAdMeWMMrnO?=
 =?us-ascii?Q?cm/UCW7gAy+RFQymNtQpaztgSojXaGw6/M6+saGqS55gqt6TdnJqNShKBlC7?=
 =?us-ascii?Q?LW9zjBDWSkrJWJxlJohqhShQsJxVOztS5bdCsWxQWzZWX4HTKwX+KxsQBpjr?=
 =?us-ascii?Q?Sr66DcP7s9vLWTPTYE7UHvvkbyuBjcxWV8aPrfPICaeGmKZVnfQ7uWaECJNw?=
 =?us-ascii?Q?bdwOsWAU9DPRYMDgbuKMnUp8QfAeXMuILSShLUgW7nC9BAo4Mbsdwe3q9cAO?=
 =?us-ascii?Q?yNaXNOI9gHR1Lghu00AaPGAfdeTtPZQDVgVI91Ocjvl8FxRXF7k+4qgrF7A1?=
 =?us-ascii?Q?RqTp4YPcX+Ymt7Wu7SF5wP4Xqq8igPt+YALGbP9cEzBJGhRuxT7zjogupbbv?=
 =?us-ascii?Q?9hMshYI0pbwJQU+2j6NVD7FLSSVTk0S8YKW8IFqurcVJKdsylBGaZP/J94BS?=
 =?us-ascii?Q?ERlKVATeUkmugYO6wQVi4ZIHMTiWlTUACFK0g36MmUpG7dDlnBnlU+JKkK4h?=
 =?us-ascii?Q?6RV0kMvpemnlPbdgZC0u+Lwn1ZR3jtegSoiuFLZ4s4dcmKt5El6dcfFTLn24?=
 =?us-ascii?Q?khzUBD4mpgDgYxyWPs2Seo/GGR9b15tNUWKuaYRfHgzGk74XtQPclRfhpsky?=
 =?us-ascii?Q?X9znGIb7fEQ8JeJeKnc9P3SO7xLQpbdPk/9BlpSyijPwWaYhET9j9cSp4EEb?=
 =?us-ascii?Q?Utu8d/gwmGGjeeOfYX/hSsE8HnWCkvJTYfzjx3NycUaPngz236pLFJj2RlIB?=
 =?us-ascii?Q?DWouJDbIH5UeTECxJHE09G6DL27Be7dZzFrznsjaOeJcOq+R3owdvk1/xrEd?=
 =?us-ascii?Q?fpCslcoycDj0haJWNvO66DqrR9FiMtuhFqn6AkAopuc6ktf0rs3jRw36wCmp?=
 =?us-ascii?Q?w+2g8/xdlW995jHQagm31rAmSMwxamrCke6NuBJf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728ae143-96dc-4f49-6bff-08db15927ac1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 11:38:27.3212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wA5IYKAXzmrqQZOJaHQcAolhzTdxojRzPFjrfNWJ0jJBdcM/ScpHDAWuzeuOq+R/3+Oo6Un8PX8Crkp+2LN6Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 03:02:52PM +0800, Kai-Heng Feng wrote:
> Commit 202e683df37c ("cpufreq: amd-pstate: add amd-pstate driver
> parameter for mode selection") changed the driver to be disabled by
> default, and this can surprise users.
> 
> Let users know what happened so they can decide what to do next.
> 
> Link: https://bugs.launchpad.net/bugs/2006942
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Please feel free to add my Acked on V2 as well.

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
> v2:
>  - Remove redundancy in pr_info().
>  - Fix spelling and URL tag.
> 
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 45c88894fd8e..f965f54f7ae7 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1263,7 +1263,7 @@ static int __init amd_pstate_init(void)
>  	 * with amd_pstate=passive or other modes in kernel command line
>  	 */
>  	if (cppc_state == AMD_PSTATE_DISABLE) {
> -		pr_debug("driver load is disabled, boot with specific mode to enable this\n");
> +		pr_info("driver load is disabled, boot with specific mode to enable this\n");
>  		return -ENODEV;
>  	}
>  
> -- 
> 2.34.1
> 
