Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63E3698EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBPIfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBPIfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:35:37 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A40E3403E;
        Thu, 16 Feb 2023 00:35:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJTkyaYeZKS4P7YJwPChFNdfI7QVQcudHv3mVvWkqszmkgqYBcKXyCcKMHtHs7PAHxeJyPs8lm5NO86I9dE0aM31WmLojpJxdT36ZT5CIUJu4pU1MP00/zDxaFvaDe0ZRZHdeFdh9qclnsU5kAwLW/9SZX0y3+ygXundgI4IvJO0xa6tFCB+Gw+ozevNFFVl7hIqICgrAe8uXhdE3PBb7oKYo9NVzIYQG701gxlJZa83LzA44d9OhJvVPHbE27xp5gGc9Uv42vEoA/4X7okUt0LeYsTKCluLJNDO6Mn1ZYwdbOpFQSrAbkYr2xCmCHzA7Qz2snKMFPNERpwavK5siQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxLPUvThAmp5HXVaRURWlsUEKGrxLYijh1DJCIPoap4=;
 b=asg0QQhbUdGv3KNdw/8515hRKfDNbMpYQ+OJuE1Odv8N2qDxsQWetueXwiRMJ1gG1eV5AMEdh4GAcEBtyua0ozaEfdDHvOt8U5BVvQVn9HzBRs3PKt+VzctVyQAY0fBTIIjPklXqkxXPQxGKp/oHDMoCFaWz2wDHTyahr8HlT1MaESqZcDgVj4Xlk7Iw7pk063vuUlt+6Sz5GC9ZlGJpDqHk6+NNAQ1emxgpP2IMmJZbIkIXC2MBBzG/WL4HjC2TazLreJhcbZqqgZcZ2Qkutw/o352s47jV8mGhvsNjW0EGi41WmGWuRa5YzmjQtcWFIlIojwGdPxqKu06Q/HGQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxLPUvThAmp5HXVaRURWlsUEKGrxLYijh1DJCIPoap4=;
 b=Ywo2wbEw/QJxTrYYXUDoCaqovOxXMZnVl+iSTtwWiXitmq04+NK8fOFMGER/hRsMjnsKqiw3I9ONQ8Z+f41vmgvlimt1hnYlH0Pz36dPgW+tj8iqZ2sTAwqYoczPdS2wy3lh56rkMhISFGkTApRuPNk8XmMnpmZJRlDGAvfiTcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.28; Thu, 16 Feb
 2023 08:35:32 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b%7]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 08:35:32 +0000
Date:   Thu, 16 Feb 2023 16:35:04 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Shukla, Santosh" <Santosh.Shukla@amd.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        Tor Vic <torvic9@mailbox.org>,
        Russell Haley <yumpusamongus@gmail.com>
Subject: Re: [PATCH v7 0/6] cpufreq: amd-pstate: Add guided autonomous mode
 support
Message-ID: <Y+3quFxebDAKLeg5@amd.com>
References: <20230216081802.38007-1-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216081802.38007-1-wyes.karny@amd.com>
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 6038e5ba-4321-4b5c-e489-08db0ff8c435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hAw4rmZ4V5mqEUDXSIceSZi+HCFyQQ0duuyNgeCn3yO1Cg9VBAGvz/BYGxCTGE8pg5zfoo0UkTAVVIZebDDpDB2G/kGKMFTlRdfQcY2Q5ag+GNVqJOqjLV0OCWCn77VUZL6p/Rp60MZ0Asdh6LScnzfY+Tqe+hNP3MFJcxVEw895wEuA1kxnsFEMYr5hhP0VP01KpXSlWXA2vKq8rh8f7M02D9xh/zlgXeZdqUCNfZZYAJvAQUAi4jaLXifTaV5sKDNr1yS19YSwdsaoMXRrveMAlIHMao3eGFjGPFY2iKqTlR2qyzA8fh8tdV83H1xtXg8k47LVS7zuvbTu99u8gipX2N0MPdp/JlMSK0wHX11i1mnus35fgXPiULEo5107YyZbztrOvCnjdFY5qkxQMm7juwkUVK73TRj1Ls/vaWawU+DofpAL9UCW8xU+z4VyU2k7rQILame2Mjm0A8Qg0A8cpwm/qWQsa8AOsOwA8N83MuytweZW1RZEwVU0vpMJ7ymN9ydvCs+OEHgpoQhgXuFai3rzQpcJ7NApSy5CZc0Ne1vKbAIO2TrQiX2srITyiV9SW4uuYME6IeUFgspUFn8VS3KuVwXD/cg8CZyBmpLAtRQYJDkOEJhpVfTw5ycuMwxm4w1fA2oZdk0fRPF/EOlf6tceuPhNV+mAuZbfQTHS3Bh93S7diBs0M8xswce7MBCyUuNGI4c5nV1z6ZNzLgsXTEuF1JGu7BB8v8Rv84=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199018)(478600001)(966005)(6486002)(83380400001)(86362001)(38100700002)(6666004)(36756003)(26005)(186003)(6512007)(6506007)(2616005)(66946007)(316002)(66476007)(66556008)(5660300002)(7416002)(4326008)(8676002)(8936002)(54906003)(110136005)(41300700001)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qaiNLE7FlfIfyD3ri7zCiR2NJd/BjSbqMLRKA9rqmT3v23GkiZYvsMU0jlF/?=
 =?us-ascii?Q?hWSywpkeseKtCs8HJTSeY55SIbNQ7ecGOnV5eSzszPksMR1I6/n9p7GXetgF?=
 =?us-ascii?Q?U/TPLk379m+iYhEkhmMQNZobC1oB/r6xpZxksmbWr6eWMQbKsWtY0UfR9mnF?=
 =?us-ascii?Q?0A+VKoQgWixFgxy8gimZazB86TslPEweUVXfzlvdRIbuAzNKfqzehDjkQZeG?=
 =?us-ascii?Q?aQo/niH8ijYmA1T3Sau4dnCPFrGXsmrB3iP3zSE8X6ORRWItOm+4435ft4FJ?=
 =?us-ascii?Q?TPU9ZsPtyV2dsYeUMQRpbjbYCiIcXsN7/8KpxR+oCmzmxZ5LqwcCf2KRq8Sy?=
 =?us-ascii?Q?0ll/zZ27u9v2kDkO9HmNYgs0f/pDymkOhWJyppm2BoBul613AzD0LhigvmQo?=
 =?us-ascii?Q?kmflO/mFO5XTEUwzkICmFG1cPttTjPGf7f2n8IR8O84efGxyLFsZCL5NmLRA?=
 =?us-ascii?Q?yh1NlebktdGiOHVQGNCEgGm5zBdbIXONdOIsvXndw3wlNNF73foDVDQfFRf+?=
 =?us-ascii?Q?5Y8q9OHbiF0+3bZ2bmJ3wEaUwBl7o7m4y2vFdaV1PPIfP4LdyIDpSTQyfA90?=
 =?us-ascii?Q?pzkCU3BiPnJMdLSJesZcfbAY5rqIoBtLY+iZggK4Ik2mgwD1CEkLE61X2YuR?=
 =?us-ascii?Q?RIgC1y1dPQLXDw623QGk72ZZLQHHmFBqjs6I8kZ3Oea8zR0bJ2kJjYivqkin?=
 =?us-ascii?Q?NhP6ovsNAhwQg5aVs5IjoFcTgjeZ8KYm8tgGPxwBbJh+LTFQd/rZ4GAKbI2/?=
 =?us-ascii?Q?SOMeYrj9qUg/BLJ4dIWBtwgv2wzNP6eCAUjYZ/UIK2sUsW17myBVJAlXb8Dn?=
 =?us-ascii?Q?8YjJnj/fVJki9toL33CLCPflEz/3z3qLajPqtxiLLhbyfIlPkwCj0sdPf2LS?=
 =?us-ascii?Q?EKL4jdKBH2mFQdwlVA1TAo3prZdZj5Wx06kWo7dUgoILeAb8XBIOSmRDT3+y?=
 =?us-ascii?Q?fVbi+DrAo4WUTh9vdNV5vLRkymKLLm8t4ZFwJ1aTVssq6yWhpz9Ddz+cHs3q?=
 =?us-ascii?Q?9/agDNu137YVu6M7zTFCqt5/zhg7t2xY95ejuQNtGgPn6h3xxwxHAlDhpFCr?=
 =?us-ascii?Q?02cO2ZZic5JHbbMV0oNKcSg2r46U8azxdgcZeBfPBcU4+ygM2YzLtMB36Fpk?=
 =?us-ascii?Q?9G1bdrJBJMkLT+fVAyTslYPD0jD9SkcJJeLdJ5/XJJ4VYnUtrkW2fIZueKdS?=
 =?us-ascii?Q?Jh4dy2GPXrLX3cv6URUXhOSC5GB8Oxg+B6+mi47UZgKIiS6KLHRZQq6pcgSh?=
 =?us-ascii?Q?+YN8ihBmI7lM3Uka0yNLttec8b4OJfmmGKju97LXSRRa6KPazOgjKjJZk/E4?=
 =?us-ascii?Q?7I3vjo5C9l5zIFTp6S8+LyQuhSaKM9c4z2/5rjqHYJn//o3yPYvygG37Jixl?=
 =?us-ascii?Q?052b0na14JCNRsmxVFXV7V/Ukjep2nkkj92DW49ckG1s6nJwnWiQkxRM03KG?=
 =?us-ascii?Q?iel59OFpYt17FFXWBQ/+uUlZeM5adBghprWNIIIXrRLx7b0OQirWBIWwMuKk?=
 =?us-ascii?Q?ZVU57yKTEFhctzZA3tteUKIrlGFX1b84a2upmNdqixbNyLqB3Hrl3npuljB7?=
 =?us-ascii?Q?OMG2VEM8rqQYY3SlAna1XJBF7IIwHcLaZk2rh0Vg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6038e5ba-4321-4b5c-e489-08db0ff8c435
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 08:35:32.2791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRqyoN6f4qbsjCsfI6YHaGSE936kGv1cFA0hgktqyAqvPfiRZvZiC0ZEjl2awZv4zFCyNres7TC31/EukfN+6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 04:17:56PM +0800, Karny, Wyes wrote:
> From ACPI spec[1] below 3 modes for CPPC can be defined:
> 1. Non autonomous: OS scaling governor specifies operating frequency/
>    performance level through `Desired Performance` register and platform
> follows that.
> 2. Guided autonomous: OS scaling governor specifies min and max
>    frequencies/ performance levels through `Minimum Performance` and
> `Maximum Performance` register, and platform can autonomously select an
> operating frequency in this range.
> 3. Fully autonomous: OS only hints (via EPP) to platform for the required
>    energy performance preference for the workload and platform autonomously
> scales the frequency.
> 
> Currently (1) is supported by amd_pstate as passive mode, and (3) is
> implemented by EPP support[2]. This change is to support (2).
> 
> In guided autonomous mode the min_perf is based on the input from the
> scaling governor. For example, in case of schedutil this value depends
> on the current utilization. And max_perf is set to max capacity.
> 
> To activate guided auto mode ``amd_pstate=guided`` command line
> parameter has to be passed in the kernel.
> 
> Below are the results (normalized) of benchmarks with this patch:
> System: Genoa 96C 192T
> Kernel: 6.2.0-rc2 + EPP v12 + patch
> Scaling governor: schedutil
> 
> ================ dbench comparisons ================
> dbench result comparison:
> Here results are throughput (MB/s)
> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>     1	   1.00 (0.00 pct)	   1.01 (1.00 pct)	   1.02 (2.00 pct)
>     2	   1.07 (0.00 pct)	   1.06 (-0.93 pct)	   1.07 (0.00 pct)
>     4	   1.68 (0.00 pct)	   1.70 (1.19 pct)	   1.72 (2.38 pct)
>     8	   2.61 (0.00 pct)	   2.68 (2.68 pct)	   2.76 (5.74 pct)
>    16	   4.16 (0.00 pct)	   4.24 (1.92 pct)	   4.53 (8.89 pct)
>    32	   5.98 (0.00 pct)	   6.17 (3.17 pct)	   7.30 (22.07 pct)
>    64	   8.67 (0.00 pct)	   8.99 (3.69 pct)	  10.71 (23.52 pct)
>   128	  11.98 (0.00 pct)	  12.52 (4.50 pct)	  14.67 (22.45 pct)
>   256	  15.73 (0.00 pct)	  16.13 (2.54 pct)	  17.81 (13.22 pct)
>   512	  15.77 (0.00 pct)	  16.32 (3.48 pct)	  16.39 (3.93 pct)
> dbench power comparison:
> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>     1	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   1.04 (4.00 pct)
>     2	   0.99 (0.00 pct)	   0.97 (-2.02 pct)	   1.02 (3.03 pct)
>     4	   0.98 (0.00 pct)	   0.98 (0.00 pct)	   1.02 (4.08 pct)
>     8	   0.98 (0.00 pct)	   0.99 (1.02 pct)	   1.02 (4.08 pct)
>    16	   0.99 (0.00 pct)	   1.00 (1.01 pct)	   1.04 (5.05 pct)
>    32	   1.02 (0.00 pct)	   1.02 (0.00 pct)	   1.07 (4.90 pct)
>    64	   1.05 (0.00 pct)	   1.05 (0.00 pct)	   1.11 (5.71 pct)
>   128	   1.08 (0.00 pct)	   1.08 (0.00 pct)	   1.15 (6.48 pct)
>   256	   1.12 (0.00 pct)	   1.12 (0.00 pct)	   1.20 (7.14 pct)
>   512	   1.18 (0.00 pct)	   1.17 (-0.84 pct)	   1.26 (6.77 pct)
> 
> ================ git-source comparisons ================
> git-source result comparison:
> Here results are throughput (compilations per 1000 sec)
> Threads:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>   192	   1.00 (0.00 pct)	   0.93 (-7.00 pct)	   1.00 (0.00 pct)
> git-source power comparison:
> Threads:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>   192	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   0.96 (-4.00 pct)
> 
> ================ kernbench comparisons ================
> kernbench result comparison:
> Here results are throughput (compilations per 1000 sec)
> Load:	   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
> 32	   1.00 (0.00 pct)	   1.01 (1.00 pct)	   1.02 (2.00 pct)
> 48	   1.26 (0.00 pct)	   1.28 (1.58 pct)	   1.25 (-0.79 pct)
> 64	   1.39 (0.00 pct)	   1.47 (5.75 pct)	   1.43 (2.87 pct)
> 96	   1.48 (0.00 pct)	   1.50 (1.35 pct)	   1.49 (0.67 pct)
> 128	   1.29 (0.00 pct)	   1.32 (2.32 pct)	   1.33 (3.10 pct)
> 192	   1.17 (0.00 pct)	   1.20 (2.56 pct)	   1.21 (3.41 pct)
> 256	   1.17 (0.00 pct)	   1.18 (0.85 pct)	   1.20 (2.56 pct)
> 384	   1.16 (0.00 pct)	   1.17 (0.86 pct)	   1.21 (4.31 pct)
> kernbench power comparison:
> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>    32	   1.00 (0.00 pct)	   0.97 (-3.00 pct)	   1.00 (0.00 pct)
>    48	   0.87 (0.00 pct)	   0.81 (-6.89 pct)	   0.88 (1.14 pct)
>    64	   0.81 (0.00 pct)	   0.73 (-9.87 pct)	   0.77 (-4.93 pct)
>    96	   0.75 (0.00 pct)	   0.74 (-1.33 pct)	   0.75 (0.00 pct)
>   128	   0.83 (0.00 pct)	   0.79 (-4.81 pct)	   0.83 (0.00 pct)
>   192	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
>   256	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
>   384	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
> 
> ================ tbench comparisons ================
> tbench result comparison:
> Here results are throughput (MB/s)
> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>     1	   1.00 (0.00 pct)	   0.70 (-30.00 pct)	   1.37 (37.00 pct)
>     2	   2.64 (0.00 pct)	   1.39 (-47.34 pct)	   2.70 (2.27 pct)
>     4	   4.89 (0.00 pct)	   2.75 (-43.76 pct)	   5.28 (7.97 pct)
>     8	   9.46 (0.00 pct)	   5.42 (-42.70 pct)	  10.22 (8.03 pct)
>    16	  19.05 (0.00 pct)	  10.42 (-45.30 pct)	  19.94 (4.67 pct)
>    32	  37.50 (0.00 pct)	  20.23 (-46.05 pct)	  36.87 (-1.68 pct)
>    64	  61.24 (0.00 pct)	  43.08 (-29.65 pct)	  62.96 (2.80 pct)
>   128	  67.16 (0.00 pct)	  69.08 (2.85 pct)	  67.34 (0.26 pct)
>   256	 154.59 (0.00 pct)	 162.33 (5.00 pct)	 156.78 (1.41 pct)
>   512	 154.02 (0.00 pct)	 156.74 (1.76 pct)	 153.48 (-0.35 pct)
> tbench power comparison:
> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>     1	   1.00 (0.00 pct)	   0.97 (-3.00 pct)	   1.08 (8.00 pct)
>     2	   1.04 (0.00 pct)	   0.97 (-6.73 pct)	   1.11 (6.73 pct)
>     4	   1.12 (0.00 pct)	   0.99 (-11.60 pct)	   1.18 (5.35 pct)
>     8	   1.25 (0.00 pct)	   1.04 (-16.80 pct)	   1.31 (4.80 pct)
>    16	   1.53 (0.00 pct)	   1.13 (-26.14 pct)	   1.58 (3.26 pct)
>    32	   2.01 (0.00 pct)	   1.36 (-32.33 pct)	   2.03 (0.99 pct)
>    64	   2.58 (0.00 pct)	   2.14 (-17.05 pct)	   2.61 (1.16 pct)
>   128	   2.80 (0.00 pct)	   2.81 (0.35 pct)	   2.81 (0.35 pct)
>   256	   3.39 (0.00 pct)	   3.43 (1.17 pct)	   3.42 (0.88 pct)
>   512	   3.44 (0.00 pct)	   3.44 (0.00 pct)	   3.44 (0.00 pct)
> 
> Note: this series is based on top of EPP v12 [3] series
> 
> Change log:
> 
> v6 -> v7:
> - Addressed comments by Ray
> - Reorder and rebase patches
> - Pick up Ack by Ray
> 
> v5 -> v6:
> - Don't return -EBUSY when changing to same mode
> 
> v4 -> v5:
> - Rebased on top of EPP v12 series
> - Addressed comments form Mario regarding documentation
> - Picked up RB flags from Mario and Bagas Sanjaya
> 
> v3 -> v4:
> - Fixed active mode low frequency issue reported by Peter Jung and Tor Vic
> - Documentation modification suggested by Bagas Sanjaya
> 
> v2 -> v3:
> - Addressed review comments form Mario.
> - Picked up RB tag from Mario.
> - Rebase on top of EPP v11 [3].
> 
> v1 -> v2:
> - Fix issue with shared mem systems.
> - Rebase on top of EPP series.
> 
> [1]: https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> [2]: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd.com/
> [3]: https://lore.kernel.org/linux-pm/20230131090016.3970625-1-perry.yuan@amd.com/
> 
> Wyes Karny (6):
>   acpi: cppc: Add min and max perf reg writing support
>   acpi: cppc: Add auto select register read/write support
>   Documentation: cpufreq: amd-pstate: Move amd_pstate param to
>     alphabetical order
>   cpufreq: amd-pstate: Add guided autonomous mode
>   cpufreq: amd-pstate: Add guided mode control support via sysfs
>   Documentation: cpufreq: amd-pstate: Update amd_pstate status sysfs for
>     guided
> 
>  .../admin-guide/kernel-parameters.txt         |  40 ++--
>  Documentation/admin-guide/pm/amd-pstate.rst   |  31 ++-
>  drivers/acpi/cppc_acpi.c                      | 121 +++++++++++-
>  drivers/cpufreq/amd-pstate.c                  | 177 +++++++++++++-----
>  include/acpi/cppc_acpi.h                      |  11 ++
>  include/linux/amd-pstate.h                    |   2 +
>  6 files changed, 302 insertions(+), 80 deletions(-)
> 

Hi Rafael,

Could you please apply these series into 6.3 or please kindly let us know
if you have any comments?

Thanks,
Ray
