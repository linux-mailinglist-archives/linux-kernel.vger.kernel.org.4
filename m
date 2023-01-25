Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC9567AFA1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjAYKZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbjAYKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:25:31 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9082B63B;
        Wed, 25 Jan 2023 02:25:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArCzP5VBxOUIMtJlvVn+YceLBHc0b4zXpD3tIn9kUe4j5/uPUNcCDP6awqtXZZLkCtsHmhD/+bYreI7BvzYWWYvt50PZOKRxR9XWSwfvfnAo79qpGj2QQF5Q114mbpgjDOBnCLxveefFo7KsB/lpr5if/yO2nV0l0ecoqGHZtw0N+uX1oFPI6+JWDF/YYSHD6gZlgF9yMSCYdkSJuROU0pkgbOVuPlX7ZTHW0btU/ejPPInxZQBrQyh7cSLC1Me7cNCJpeBTA/xMj1uhdovJNWcsOjPBMaYXSFOZXQKH2QBsDk9hlOot46pStq7taWRlPBlsZjbhoJcdffT+2S873w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceajdwDpSbEZqZMeNHMI5/5BToxhFv0W4n3MdDRLx3U=;
 b=PmIh9ZEq3wxfSD3o36fnL4gvmLU5pKBjjFGcxYVKYvMCFYqEcNzAcez1w3sMfNc5VXgKpvQcX747lkR4yjjsk5N3JNNWYayzWdlvtPnU5BgeDRiuz56kD18VaAshM0M1EcgLyk2AO0aZnDqTcEorLsJ7jQ3JpJZDvzTXvR3oZerjNEz4VpDkzuHuiYtwhjKT6tSbuScjlzgkx5we3AV+DNvE34UW+wFRrSHFL5lTKui0HCXtSoj/EzxqPrRXAAmOemvKcgP2z4aQswvnPdK2QUqHEvjji9wBfOtzK0fwCQaung3vr1SqvCPoHjJ+36ux4IFomLF5zUPSnqil8fEMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceajdwDpSbEZqZMeNHMI5/5BToxhFv0W4n3MdDRLx3U=;
 b=s7+/W+6IEhWpOdePNOrKaa4JUvMjXJvlXtNkOlBIi4KbwiJmU9aW9Hn+C5WEUEEJPTB+Iv8BlL2+sKuUepun3qSiHGL0EfOvAxT9YTKpwvI6b6XqO1p9UL21HPggJrdAeqReAJxLL4GARUk85ZJT+gmch8yDCz/dT4BET5Ou3eM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 10:25:28 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 10:25:27 +0000
Date:   Wed, 25 Jan 2023 10:25:11 +0000
From:   Wyes Karny <wyes.karny@amd.com>
To:     Tor Vic <torvic9@mailbox.org>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>,
        gautham.shenoy@amd.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>, santosh.shukla@amd.com,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3 0/6] amd_pstate: Add guided autonomous mode support
Message-ID: <Y9EDh3YTAiUBKS7g@beas>
References: <20230119115017.10188-1-wyes.karny@amd.com>
 <8c09f806-b00d-515b-bd1d-2f433e44b1a4@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c09f806-b00d-515b-bd1d-2f433e44b1a4@mailbox.org>
X-ClientProxiedBy: PN2PR01CA0239.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::18) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: b833c193-89d2-4e40-bc49-08dafebe7a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQGtrJBgvEynOcYyiHaJsIR0zz8p/teN3VvmtKv0zsk/pu6dII9GYxCBRBjdlD7VssAdUkpyHgRyK3Wv7dhxB2H0GZl7f3AXRQ2RO0lltaZMt3hnXQ3/U4q4ynXxja0MkuBnHSWpkwptE4KSZdsaQrR+iQgu5vGpX1kZZIcERBTRLsoqQ1vVg627Vw0Am/mAUbc/Ybqhp1r0hYQZxhGLZi14zi3k3NbkItde/uviEGaaXrnpXnww8Wj30z5sB2m8hwhvSqV9KUzPJEJY0oJ5//qvmmmEpy8NGKbKOfrtITGEmdCIHb0/16JY4qQqGfHWou1quTLZZnnQ3cQqgM0YhOHm6YZYQq35BVhcZdOe/G7PPaTpz0D9j9nPfSV26SWnwrrkNRJ/4+0Rnlehvd42OlLHYu8cMrjJt41Bn3Jql6yllquhiJ10zAIOsKNt6Lr1qay2zlptwj0TbXfjPechD6/TBlRTNHpf0r0F7XOqLLvlu+Ri5sZOvkX16/WBNkp+O4MJ0tQNZdIEkRP7RmooziEgw7qHMbOWebyvyx/ZqcKEBS+MTebE98YDKtYBkOSjwhJ90udguc/R2D7uXkNBQgkZuAK4AV8lZMmKZ54AC7u4TPLvjDsnSnfArIB/oK3hILNec7hj3P7JV8IFqjTETI5A97Xa5uBeXn9psjXWvhC9f9H6hn6rdyKGqZxQhg4dZX1DUW5fBqgZhM4Skpn3OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199018)(41300700001)(38100700002)(4326008)(5660300002)(7416002)(2906002)(26005)(8676002)(66946007)(6486002)(33716001)(66476007)(316002)(53546011)(6512007)(6916009)(6506007)(6666004)(8936002)(9686003)(54906003)(66556008)(83380400001)(86362001)(186003)(44832011)(966005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CkzcH1cKpkGvnU1vhbZoSYe02y7MyGubt5rwI4JnGsuv4hIiTsojQ89OaN9I?=
 =?us-ascii?Q?MTF9RyKmSqJtYyJi1QW16lvnB6A4I6yyQTTswpmTUWBw0x0rIOjfZ9Y6PHRO?=
 =?us-ascii?Q?z43p3fg+XeDZGSkADcZHrS3+mAkREcuuh91pGm3+NfYH2yTertCywnMXJX7n?=
 =?us-ascii?Q?lN//277kb1HQEsn7h8yWv9yRizMKbcnSAznrDqPqd9qGCJoGGVvyvOl7jnbK?=
 =?us-ascii?Q?dleLaPZ54Q+xVjm+S7zectnizPnvl2i/37WgSt7hNiwNwXl0ANbPWmm8no/1?=
 =?us-ascii?Q?VKDRHNLNde3vQrFTYEZpMMZ6dY2lzU1jEzqbA2nkZIiVrCM0wbfEy2zirnmW?=
 =?us-ascii?Q?KU3AckBsMv2mzAmV/Y9/3hd7Pyw6zeFB164B3lFSCZK/dVMN288J5obV9x0H?=
 =?us-ascii?Q?tWiAvD3WLc8BV9qX2tYuILwE7weK+saugLid+3UE32e5CGwLbng0bb4Fly4J?=
 =?us-ascii?Q?UQXflG8wHKwcijF02DvjwAZK9p1dGicrI4G86HiV/qQqkTY+iM1LXRRvki3G?=
 =?us-ascii?Q?hjC79jfB1lZCgw/iPpWtGJjcX3KRqgNaNnASWtoQ/PKhGVcxsP9RZ6fVimu5?=
 =?us-ascii?Q?ULx8JT+Gc67h0l36OTViULjSPLcItTw4CUuXLRmM3FScuJtlAOXwFJNj6zQM?=
 =?us-ascii?Q?eZY2vhi5gUUR5JjRUbOsZviBAm1oAy8DJ1eNeToNggETZRIPCggtW/xEWn4r?=
 =?us-ascii?Q?ksAdbPlkt//UYXX7LcVZ32diHxp1LYwFX41L99ibpntnZt4ztudsqogSKqAW?=
 =?us-ascii?Q?fMhPGLVpndgwhAJAiuxU/vyqO8dQZ6uW0ay2EOzV4koLlRLN1w3le9JS09Fa?=
 =?us-ascii?Q?BoIV5KfNOSl17JBKRiTGebGvlDlLIBf+WlAEX7eoUTCCVENSDmeRdrWqofxQ?=
 =?us-ascii?Q?49NyKxvHOx60CFW68mFrvvAj9bXRJUAs7BJChHpEiyCoPSaVNLBm+MFrpatl?=
 =?us-ascii?Q?+fqYq0Hh+YCelwxOj7HEgoRJiy2LWJWJfSWSSVfP3QywIN+MbFt5La/J+RfY?=
 =?us-ascii?Q?vebLrA8u8WIijwuiJ94DaOfGbM+1PaznWda3HUeYmoZFQcN49D8PG8S1p4H1?=
 =?us-ascii?Q?RyC4/hMVV2TS8huKvQOIr4Lxz2O4Gfyaztbq0lgCL+6rZpsicxojWEjRd6Th?=
 =?us-ascii?Q?Zhyg7E3Q+SRw/WEg6V6lWvlOBXlXha1v9geoBEQXXZrCnG5JGzSOgFaz4iBF?=
 =?us-ascii?Q?n+2o5IDM8FH6k01X/ecrsqmYD8VWeQUeQYIytWwmvoBKIDpsVZRMxbu4ar4c?=
 =?us-ascii?Q?aPl3Xm7P80pu54QWf+ITvnf3h3EXMYJfOl1EQoeBbLsIk695Jnkp7oNjNwaR?=
 =?us-ascii?Q?Z+nWGe7ZNG7VVg+a23GXmPHsxXRQR92qMBYVcnkt3Rl0ZFKARzsaRbkskuwf?=
 =?us-ascii?Q?OuC+a8Uv5tRw7CMymdymsvfPY2V3AKAXX9qlWD5yvZBkY8f14EJDlsalAQCM?=
 =?us-ascii?Q?iDGN+DTb2rk8LMHrAIMDhpAzN0171CXjQcDWA/tBTPMfW8gS3Le6IdH7ToFg?=
 =?us-ascii?Q?ZWV8kkz0/aDXmuLjqc+4coDKn1GsgEnPDQ4ch/V4qPt59rhpa8CqDF5CVkNC?=
 =?us-ascii?Q?jIIEJNib04XAtg7bG8c0NFiJum0MPCaQKLGX6tK1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b833c193-89d2-4e40-bc49-08dafebe7a04
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 10:25:27.3530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFsWk4XX8glfh/Xhsf1w6CxwSnBIiHo0mIkeeSNAq2uR4WuxwShijVJBzmS2mUqs6E+sBrOybytJ9cz89/nIuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jan 20:40, Tor Vic wrote:
> 
> 
> On 19.01.23 11:50, Wyes Karny wrote:
> > > From ACPI spec[1] below 3 modes for CPPC can be defined:
> > 1. Non autonomous: OS scaling governor specifies operating frequency/
> >     performance level through `Desired Performance` register and platform
> > follows that.
> > 2. Guided autonomous: OS scaling governor specifies min and max
> >     frequencies/ performance levels through `Minimum Performance` and
> > `Maximum Performance` register, and platform can autonomously select an
> > operating frequency in this range.
> > 3. Fully autonomous: OS only hints (via EPP) to platform for the required
> >     energy performance preference for the workload and platform autonomously
> > scales the frequency.
> > 
> > Currently (1) is supported by amd_pstate as passive mode, and (3) is
> > implemented by EPP support[2]. This change is to support (2).
> > 
> > In guided autonomous mode the min_perf is based on the input from the
> > scaling governor. For example, in case of schedutil this value depends
> > on the current utilization. And max_perf is set to max capacity.
> > 
> > To activate guided auto mode ``amd_pstate=guided`` command line
> > parameter has to be passed in the kernel.
> > 
> > Below are the results (normalized) of benchmarks with this patch:
> > System: Genoa 96C 192T
> > Kernel: 6.2.0-rc2 + EPP v11 + patch
> > Scaling governor: schedutil
> > 
> > ================ dbench comparisons ================
> > dbench result comparison:
> > Here results are throughput (MB/s)
> > Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
> >      1	   1.00 (0.00 pct)	   1.01 (1.00 pct)	   1.02 (2.00 pct)
> >      2	   1.07 (0.00 pct)	   1.06 (-0.93 pct)	   1.07 (0.00 pct)
> >      4	   1.68 (0.00 pct)	   1.70 (1.19 pct)	   1.72 (2.38 pct)
> >      8	   2.61 (0.00 pct)	   2.68 (2.68 pct)	   2.76 (5.74 pct)
> >     16	   4.16 (0.00 pct)	   4.24 (1.92 pct)	   4.53 (8.89 pct)
> >     32	   5.98 (0.00 pct)	   6.17 (3.17 pct)	   7.30 (22.07 pct)
> >     64	   8.67 (0.00 pct)	   8.99 (3.69 pct)	  10.71 (23.52 pct)
> >    128	  11.98 (0.00 pct)	  12.52 (4.50 pct)	  14.67 (22.45 pct)
> >    256	  15.73 (0.00 pct)	  16.13 (2.54 pct)	  17.81 (13.22 pct)
> >    512	  15.77 (0.00 pct)	  16.32 (3.48 pct)	  16.39 (3.93 pct)
> > dbench power comparison:
> > Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
> >      1	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   1.04 (4.00 pct)
> >      2	   0.99 (0.00 pct)	   0.97 (-2.02 pct)	   1.02 (3.03 pct)
> >      4	   0.98 (0.00 pct)	   0.98 (0.00 pct)	   1.02 (4.08 pct)
> >      8	   0.98 (0.00 pct)	   0.99 (1.02 pct)	   1.02 (4.08 pct)
> >     16	   0.99 (0.00 pct)	   1.00 (1.01 pct)	   1.04 (5.05 pct)
> >     32	   1.02 (0.00 pct)	   1.02 (0.00 pct)	   1.07 (4.90 pct)
> >     64	   1.05 (0.00 pct)	   1.05 (0.00 pct)	   1.11 (5.71 pct)
> >    128	   1.08 (0.00 pct)	   1.08 (0.00 pct)	   1.15 (6.48 pct)
> >    256	   1.12 (0.00 pct)	   1.12 (0.00 pct)	   1.20 (7.14 pct)
> >    512	   1.18 (0.00 pct)	   1.17 (-0.84 pct)	   1.26 (6.77 pct)
> > 
> > ================ git-source comparisons ================
> > git-source result comparison:
> > Here results are throughput (compilations per 1000 sec)
> > Threads:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
> >    192	   1.00 (0.00 pct)	   0.93 (-7.00 pct)	   1.00 (0.00 pct)
> > git-source power comparison:
> > Threads:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
> >    192	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   0.96 (-4.00 pct)
> > 
> > ================ kernbench comparisons ================
> > kernbench result comparison:
> > Here results are throughput (compilations per 1000 sec)
> > Load:	   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
> > 32	   1.00 (0.00 pct)	   1.01 (1.00 pct)	   1.02 (2.00 pct)
> > 48	   1.26 (0.00 pct)	   1.28 (1.58 pct)	   1.25 (-0.79 pct)
> > 64	   1.39 (0.00 pct)	   1.47 (5.75 pct)	   1.43 (2.87 pct)
> > 96	   1.48 (0.00 pct)	   1.50 (1.35 pct)	   1.49 (0.67 pct)
> > 128	   1.29 (0.00 pct)	   1.32 (2.32 pct)	   1.33 (3.10 pct)
> > 192	   1.17 (0.00 pct)	   1.20 (2.56 pct)	   1.21 (3.41 pct)
> > 256	   1.17 (0.00 pct)	   1.18 (0.85 pct)	   1.20 (2.56 pct)
> > 384	   1.16 (0.00 pct)	   1.17 (0.86 pct)	   1.21 (4.31 pct)
> > kernbench power comparison:
> > Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
> >     32	   1.00 (0.00 pct)	   0.97 (-3.00 pct)	   1.00 (0.00 pct)
> >     48	   0.87 (0.00 pct)	   0.81 (-6.89 pct)	   0.88 (1.14 pct)
> >     64	   0.81 (0.00 pct)	   0.73 (-9.87 pct)	   0.77 (-4.93 pct)
> >     96	   0.75 (0.00 pct)	   0.74 (-1.33 pct)	   0.75 (0.00 pct)
> >    128	   0.83 (0.00 pct)	   0.79 (-4.81 pct)	   0.83 (0.00 pct)
> >    192	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
> >    256	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
> >    384	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
> > 
> > ================ tbench comparisons ================
> > tbench result comparison:
> > Here results are throughput (MB/s)
> > Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
> >      1	   1.00 (0.00 pct)	   0.70 (-30.00 pct)	   1.37 (37.00 pct)
> >      2	   2.64 (0.00 pct)	   1.39 (-47.34 pct)	   2.70 (2.27 pct)
> >      4	   4.89 (0.00 pct)	   2.75 (-43.76 pct)	   5.28 (7.97 pct)
> >      8	   9.46 (0.00 pct)	   5.42 (-42.70 pct)	  10.22 (8.03 pct)
> >     16	  19.05 (0.00 pct)	  10.42 (-45.30 pct)	  19.94 (4.67 pct)
> >     32	  37.50 (0.00 pct)	  20.23 (-46.05 pct)	  36.87 (-1.68 pct)
> >     64	  61.24 (0.00 pct)	  43.08 (-29.65 pct)	  62.96 (2.80 pct)
> >    128	  67.16 (0.00 pct)	  69.08 (2.85 pct)	  67.34 (0.26 pct)
> >    256	 154.59 (0.00 pct)	 162.33 (5.00 pct)	 156.78 (1.41 pct)
> >    512	 154.02 (0.00 pct)	 156.74 (1.76 pct)	 153.48 (-0.35 pct)
> > tbench power comparison:
> > Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
> >      1	   1.00 (0.00 pct)	   0.97 (-3.00 pct)	   1.08 (8.00 pct)
> >      2	   1.04 (0.00 pct)	   0.97 (-6.73 pct)	   1.11 (6.73 pct)
> >      4	   1.12 (0.00 pct)	   0.99 (-11.60 pct)	   1.18 (5.35 pct)
> >      8	   1.25 (0.00 pct)	   1.04 (-16.80 pct)	   1.31 (4.80 pct)
> >     16	   1.53 (0.00 pct)	   1.13 (-26.14 pct)	   1.58 (3.26 pct)
> >     32	   2.01 (0.00 pct)	   1.36 (-32.33 pct)	   2.03 (0.99 pct)
> >     64	   2.58 (0.00 pct)	   2.14 (-17.05 pct)	   2.61 (1.16 pct)
> >    128	   2.80 (0.00 pct)	   2.81 (0.35 pct)	   2.81 (0.35 pct)
> >    256	   3.39 (0.00 pct)	   3.43 (1.17 pct)	   3.42 (0.88 pct)
> >    512	   3.44 (0.00 pct)	   3.44 (0.00 pct)	   3.44 (0.00 pct)
> > 
> > Note: this series is based on top of EPP v11 [3] series
> > 
> > Change log:
> > 
> > v2 -> v3:
> > - Addressed review comments form Mario.
> > - Picked up RB tag from Mario.
> > - Rebase on top of EPP v11 [3].
> > 
> > v1 -> v2:
> > - Fix issue with shared mem systems.
> > - Rebase on top of EPP series.
> > 
> > [1]: https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> > [2]: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd.com/
> > [3]: https://lore.kernel.org/linux-pm/20230118075210.447418-1-perry.yuan@amd.com/
> > 
> > 
> > Wyes Karny (6):
> >    acpi: cppc: Add min and max perf reg writing support
> >    acpi: cppc: Add auto select register read/write support
> >    cpufreq: amd_pstate: Add guided autonomous mode
> >    Documentation: amd_pstate: Move amd_pstate param to alphabetical order
> >    cpufreq: amd_pstate: Add guided mode control support via sysfs
> >    Documentation: amd_pstate: Update amd_pstate status sysfs for guided
> > 
> >   .../admin-guide/kernel-parameters.txt         |  41 ++--
> >   Documentation/admin-guide/pm/amd-pstate.rst   |  32 ++-
> >   drivers/acpi/cppc_acpi.c                      | 113 ++++++++++-
> >   drivers/cpufreq/amd-pstate.c                  | 184 +++++++++++++-----
> >   include/acpi/cppc_acpi.h                      |  11 ++
> >   include/linux/amd-pstate.h                    |   2 +
> >   6 files changed, 302 insertions(+), 81 deletions(-)
> > 
> 
> 
> The "active" mode seems to be broken here on a Zen2 3900X running Linux 6.1.
> Frequency remains stuck at minimum which is +-500 MHz.

I'll send a fix for this in v4.

> 
> Some queries of the new /sys devices lead to I/O error:
> 
>   # LANG=C cat /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_*
>   166
>   cat:
> /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq:
> Input/output error
>   cat: /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq:
> Input/output error

I'll check this. Thanks for reporting.
> 
> The "guided" mode seems to work fine with no stuck frequency, but also
> produces I/O error on some /sys files.
> 
> I haven't tested "passive".
> 
> Cheers,
> 
> Tor Vic

Thanks,
Wyes
