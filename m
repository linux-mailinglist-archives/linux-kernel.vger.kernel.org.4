Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62056874A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 05:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjBBErH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 23:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjBBEqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 23:46:43 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74D280028;
        Wed,  1 Feb 2023 20:45:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEf7Nl5zA1AA4ogBR9J/DrX+wEdSQAGFC8exaNj0oCUNsRZR5H1R7hdeAfRXT7Az7asaDeImJQDnmlddi82eXSy3KruZe80QkpgLZvtOClbwpwPzuwgRDuQ53wb47CoRgR/AhkCD4GmTS+pz+NJZEJRlkxZcQhdz0kF4lBjRefbFggP0XFJ88G508Ri4c5zGe2zyDY9NKga12fSUjE74T+POX0gtWmDbW8+c4q2cEeg6bRJLz1fuNXS07XomDnHCSvhF+KqIIj8jB3CyvPe8EwF4uOGFnlmITFdl5E7vqD+brJGe7QTMv0ne9L3jvHz7Xwb1XYIc1azabyKkSH1qjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYJ+TmgoIy0MWNSWBzjwkcR2N8yInvYmCtBYjbayew0=;
 b=UP6duvfMUBDTQn/UU5cD/zvpkp1mlzdY8D/Jk/mauWLeXXXQ+Dg7xU/mmRK4PZg5xsOZKapkDnW8sinAkOMkfGl3ZGR88zHVWifa3kefa0gWb/gUhc4M5nXzd1+c8i1V8pyEPhNklMBDIai0nNmXDFK55smqcqhRFFxpAGReOT4yhY5dP5sHseju3XRpSNQ8j5Ujef+bHW5V29CJ40EUqSS9mM4HYriy+5NgrXoGnTPH9lpmYTON5uewbFEg/WFYWJVd30e8OA7xlmMSAR78v07n+JJZ4aWb6JorC/BXYFSPu92fBYAwpFEubBjTjCVlyGBFwQoz4x2B59zoVbVoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYJ+TmgoIy0MWNSWBzjwkcR2N8yInvYmCtBYjbayew0=;
 b=WN1Ycvv24Nxrp5d+j/qxdt2/ZyehpgCLyCefFCmttFX5DUkhBYlC5tLPOG3EJuWQfus4k3gAJZ6253OzCZLpELFdoOfaRCEle15ftKfeDfKT5qH05hksD+pdJqjm6HMFainBKTaRHj2yHrsM/RnH/xGqN8Jt66SBFCCjjV0Oji8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Thu, 2 Feb
 2023 04:44:56 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.6043.033; Thu, 2 Feb 2023
 04:44:56 +0000
Date:   Thu, 2 Feb 2023 04:44:42 +0000
From:   Wyes Karny <wyes.karny@amd.com>
To:     Tor Vic <torvic9@mailbox.org>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
Subject: Re: [PATCH v5 0/6] amd_pstate: Add guided autonomous mode support
Message-ID: <Y9s/ulvjoeD/E2tz@beas>
References: <20230201065823.189828-1-wyes.karny@amd.com>
 <aa2845b9-5e57-4df2-9c59-814eedd752dc@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa2845b9-5e57-4df2-9c59-814eedd752dc@mailbox.org>
X-ClientProxiedBy: PN3PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::17) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 70780c76-0fbe-46b4-80bf-08db04d83b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrUSfCTrKbZWTVicjVZUAqBM/rn8JotHUg9q9pzNs70ewSol+DCgwUaToalLgHt7DWRppOfJyMcKDgeA/VanwBmnp1CU1wbXcMYvGxQsfsZ5ryt3eoNlmuMMzGXdcL1CGl/crlWOtCTk0CGeSsUMDM+ZDLipdq5R98HOKMa0w9LNWyyS04WhqTm6SHQ0uzz2fbWMyVtpCzNMVY3xmiw2PWfcCWZYvsvlhIIs17lm+0NEunuPC9nV5WYs3UPo4Nk5Awm2b7P9lcZ8e6X1CDoCD/8jV3aeuQRB/Fx7SFsU9cWo+Akqd0t5rUaV/TV3i3Quy+uHtqZHTRqU0wQRTlsQaFDjmnN+Z1wgb7L+J/om5N3HJ10Mm/DZ7b2gQ897KWijRy9b9Z9z/wv2NdZ9RN7bSlHt9Qwc1WRFLJwwC3pGc8CgTXvi7XAxiLOPz6fg2GuW3IHy77kB/Ft+IrSTqwUnGguvYjOtBtvX46SzGF7oyngsu2EIV88iETEguwtERWGp428tkN8z2JzSqR7yiU1wjm7/IZxeWfst3vycskUX/JdDHMwtBb71Dww1aMd906YY7rpoC9cFft6A8W0qePz8Mn6iphxkm66/2EUT+y2hi0qZH2qQxxlIradox7ymewG/kmq/TWqaxoaHLXAS1GSky15jPa4/ufPXMhldAAvrStqaIFovFLtj3hMN1tpo5mvv1JfXYDWvLN/xANOQMzr3Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199018)(41300700001)(66476007)(4326008)(8676002)(6916009)(8936002)(66946007)(316002)(6486002)(66556008)(966005)(5660300002)(54906003)(6666004)(7416002)(6506007)(44832011)(83380400001)(26005)(9686003)(6512007)(186003)(478600001)(53546011)(2906002)(86362001)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o4/USMA26S9HpeG2GNn7H4pOgwhkYf7EO8vjcozxUwyWqdxkietbrkRUnFaI?=
 =?us-ascii?Q?hVdIr8krd3GiLkzrkQSRMaDj23Swu0ycl5Nut58W19UzMbd8rQogoPtEtOcH?=
 =?us-ascii?Q?AFdZ8llY8S6+Lnn67JboKykzlZuro0y2COiYCUE2pMSj9g+B4jMRzgmbUn2t?=
 =?us-ascii?Q?A8M93CSydXgr3Q9seuJXXaIa4Xqou+UM0tdMiVmuZUUsyhaMuwqNluGdQHgE?=
 =?us-ascii?Q?CVV40KcRZUnDdYfyRC9iK//SJTkkrxZ7LoBr1X+Yfftc+H8YWWjFWl1O0VQ+?=
 =?us-ascii?Q?YGnr0QXFB/s4xkc135yB4KdvZSpS1KK7yqPuhQQt5eKyiNh1GqM3kyy9NqxR?=
 =?us-ascii?Q?VsJLCpXyelLJGQuWYQJ4CKWy4moswFepvHARlNf3x2dbFnESD+g4hEzn+saU?=
 =?us-ascii?Q?v5/rYoXY2S8G/Nuh5i41wEKpvecsjNz5WO20Yq6nn3A5KWq/cqk2eT0EJveB?=
 =?us-ascii?Q?VVKp5A7cXQr/BXeCpsQwroBHtZsZ+XGJ5AVVfh9TX83fPNaukdPAR7KQ/C+o?=
 =?us-ascii?Q?DNzk7o0un+gdhwWjaO9Av8jkNXBH5Vq6ON+Fjsw922yUifsYQVw/wkd5H+/e?=
 =?us-ascii?Q?Ypp8Mkhb5OVW8a0W2lnp1T2/xF+c+vS8MJR/lWvfrSOxXRSeMo4ut2RtPOxb?=
 =?us-ascii?Q?GIYTfsl/qmlHgFussd8wZZ5By0pb+YzDhmb5k4aNTcE81DLYNRlAadPcQ84F?=
 =?us-ascii?Q?V8jcxSpaZGo17/M28ajAeJRUCSOcdW53fdPmdAiUwvlwJo9LpL1uy6VTeKzm?=
 =?us-ascii?Q?lHwnvxyPm1+sDsPOBBaZyFbV/jPv1c+NBvTjTmGYevmeTEGvnv116GNLPX4g?=
 =?us-ascii?Q?C5DsZepdG7Na2X+wlJjjSknGkmJvF6Qr+oE+2yjFTCextWqv/kiq+MzzE55b?=
 =?us-ascii?Q?14B80o4IRr2pK8lgYOFFsS4dYOw+hi3KhGK0+0RI8QRxNwrUAEp31y3XzFVF?=
 =?us-ascii?Q?P7FRyHerEy6fIGxvr9NkBzsLkFq2PTKYP3dNLzAdiI7v+/sD+RzYXg86Wo+d?=
 =?us-ascii?Q?W1SLTcG7giBWgwl+xQDz2A0jSTdRqyv2N+0LPpoDEHiE0HgwbiWF+5jNpkZi?=
 =?us-ascii?Q?t+grfLJQuI7Nc7U63PQSWfj83+7T8hkGsz3HLBCroCJCfg0+Vg3ASbk5/9dF?=
 =?us-ascii?Q?XAnSkCH+uOlyRMueu24WiQnwhjgofa7Hr51At5t6yvtLVuJA+aXnG5gO21Su?=
 =?us-ascii?Q?N+R1USVLZEbiu+g5PPVFRw/9CQdJZtrA2VR1lCaoBVrf/6UQLMKxzP+3zKKd?=
 =?us-ascii?Q?5V3UCPn/w+YzPNPucKNCwKxqm58ZsSYCkvp0gGp4Oc5tx+uOwc7BPuT/oGSA?=
 =?us-ascii?Q?Yj0QeMsT/N9qYfRWluWwal+ds/ZNO7BKf1hW4UnY1OTbFHz7UFnilI78yWrJ?=
 =?us-ascii?Q?BvBxtNunbhD1HOlZLRbUEhYoZHddyiKacbKFvMcR3yU/+zIIeSeOm2z4tkUU?=
 =?us-ascii?Q?y79eHB7gfieYF5QCYHmo5YSiBybzE7cBr7KwR3cvO0xf87CBda6vqZQjuwLP?=
 =?us-ascii?Q?rcYhN/5bRMoBuXQ0yyQNvUIUIUt+KTddSvY842bSKoOaG8fr/sJDfhQpkyr1?=
 =?us-ascii?Q?QByQAV2/fl5exs88BMUkBAZRPWZWoYWnq5tHi4eb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70780c76-0fbe-46b4-80bf-08db04d83b35
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 04:44:56.0241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vl3UX+ZMTNjwLUro5iJwKEyBsULMVZq+560wm7BPDJtLgrhJwegyGEaODVls858Z+/La7Y/Ynq8JfTACA3RhWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tor Vic,

On 01 Feb 18:35, Tor Vic wrote:
> 
> On 01.02.23 06:58, Wyes Karny wrote:
> >  From ACPI spec[1] below 3 modes for CPPC can be defined:
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
> > Kernel: 6.2.0-rc2 + EPP v12 + patch
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
> > Note: this series is based on top of EPP v12 [3] series
> > 
> > Change log:
> > 
> > v4 -> v5:
> > - Rebased on top of EPP v12 series
> > - Addressed comments form Mario regarding documentation
> > - Picked up RB flags from Mario and Bagas Sanjaya
> > 
> > v3 -> v4:
> > - Fixed active mode low frequency issue reported by Peter Jung and Tor Vic
> > - Documentation modification suggested by Bagas Sanjaya
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
> > [3]: https://lore.kernel.org/linux-pm/20230131090016.3970625-1-perry.yuan@amd.com/
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
> >   Documentation/admin-guide/pm/amd-pstate.rst   |  34 +++-
> >   drivers/acpi/cppc_acpi.c                      | 121 +++++++++++-
> >   drivers/cpufreq/amd-pstate.c                  | 183 +++++++++++++-----
> >   include/acpi/cppc_acpi.h                      |  11 ++
> >   include/linux/amd-pstate.h                    |   2 +
> >   6 files changed, 311 insertions(+), 81 deletions(-)
> > 
> 
> I tested "active" mode on a Zen2, using EPP v12 and this series on top.
> 
> Here is the output of 'cpupower frequency-info' run as root under full load:
> 
>   analyzing CPU 0:
>     driver: amd_pstate_epp
>     CPUs which run at the same hardware frequency: 0
>     CPUs which need to have their frequency coordinated by software: 0
>     maximum transition latency:  Cannot determine or is not supported.
>     hardware limits: 550 MHz - 4.67 GHz
>     available cpufreq governors: performance powersave
>     current policy: frequency should be within 550 MHz and 4.67 GHz.
>                   The governor "powersave" may decide which speed to use
>                   within this range.
>     current CPU frequency: Unable to call hardware
>     current CPU frequency: 4.18 GHz (asserted by call to kernel)
>     boost state support:
>       Supported: yes
>       Active: yes
>       Boost States: 0
>       Total States: 3
>       Pstate-P0:  3800MHz
>       Pstate-P1:  2800MHz
>       Pstate-P2:  2200MHz
> 
> Changing EPP mode via sysfs works.
> 
> ----
> 
> Live-switching to "guided" mode via sysfs also seems to work fine:
> 
>   analyzing CPU 0:
>     driver: amd-pstate
>     CPUs which run at the same hardware frequency: 0
>     CPUs which need to have their frequency coordinated by software: 0
>     maximum transition latency: 20.0 us
>     hardware limits: 550 MHz - 4.67 GHz
>     available cpufreq governors: ondemand powersave performance schedutil
>     current policy: frequency should be within 550 MHz and 4.67 GHz.
>                   The governor "ondemand" may decide which speed to use
>                   within this range.
>     current CPU frequency: Unable to call hardware
>     current CPU frequency: 3.71 GHz (asserted by call to kernel)
>     boost state support:
>       Supported: yes
>       Active: yes
>       AMD PSTATE Highest Performance: 166. Maximum Frequency: 4.67 GHz.
>       AMD PSTATE Nominal Performance: 135. Nominal Frequency: 3.80 GHz.
>       AMD PSTATE Lowest Non-linear Performance: 62. Lowest Non-linear
> Frequency: 1.74 GHz.
>     AMD PSTATE Lowest Performance: 20. Lowest Frequency: 550 MHz.
> 
> ----
> 
> Seems to work fine so far.
> Hope this helps.
> I can test more in detail and give you a Tested-by tag if wanted.

Thanks for testing this. Please feel free to add Tested-by tag after your
testing done.

Thanks,
Wyes
> 
> Thanks,
> 
> Tor Vic
