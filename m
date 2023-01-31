Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FF368344B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjAaRvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAaRu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:50:58 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B971230D8;
        Tue, 31 Jan 2023 09:50:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbskzU7X9Fy1feYQOMwfReVNyBZCcsxLwpu1H601V3gPyHVyddIi4YS43pIwdASm+6Uq4RBuqImhTIt4BdGxP+X/D7Odx2FzUlRdBh4h3XbzICrmg9z+Q6s881CzFR2BQxTcyXE/k2lCXYN8y1aptZUscKQ7VdLy57YOB/O8zLK2DKnJ/dlq22suVETh0QEU7NjMTLU5/IB+SZPSs2pCh5IV+I794T2byv3LSUku9jQHNtf/3cWWQf681YlZEmB8lleWTWniqChfuy2fmUII0NqI1zYuq1fshXxB+vXPxjJXCbtWZP3GJ5r0HT+pQ9+DMLBkJUVIi8IlQq8o5aoFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/h8lmHZ2ZmGfvfyx77Io58q5Eit8nG/QiqTaT7ESWUE=;
 b=RfjiwDlVRdbGYxXQPnXWzlHr6bMEdMTkOxle1Cp1BPE9iu1aC7mscycanV3Pv+2w/SDUj7mP6zQn9lFL4E80/TGfLlzuT/ArjWvmT2Lp10OBjGAh5B2NKRK3B5KJKwS43RkJpQf4ZjPuIegwfl5entEc26sgVo6m4lZFnGI+9nj7+6W02upGukdtcwBFewgW8l6ccYzrqLvmmGOKvpJ8wTSE84ZvFkKg3FXj5gJrFdc5TriT7y8TPSaNu3uE47JJSAiHCdBoM3b9W7qIlKT/b5+cYBMViRvI9rvUTbS4mDGWygpHjyzttZdVeMjaacQw7Jw8gJpmaM5PkbBCNjZ+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/h8lmHZ2ZmGfvfyx77Io58q5Eit8nG/QiqTaT7ESWUE=;
 b=yVwHCP1L+vgnxNvszSCKMFpaMrOD2JAmZweIHs7CP1ZyvWMOkKCjnzRIhWOAX2MnNSVp29rNX8Z0ZLou/QWGB4g8xbxm/9lALTPuXfvZVZtSfBxgWIazVRcLT1l21+9m5zyYgHaQIZM3zwMclkSm0113TYxcPs2ib83JY2x/GDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 17:50:54 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.6043.033; Tue, 31 Jan 2023
 17:50:54 +0000
Date:   Tue, 31 Jan 2023 17:50:40 +0000
From:   Wyes Karny <wyes.karny@amd.com>
To:     torvic9@mailbox.org
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
Subject: Re: [PATCH v4 0/6] amd_pstate: Add guided autonomous mode support
Message-ID: <Y9lU8BZKP/eorxmk@beas>
References: <20230131052141.96475-1-wyes.karny@amd.com>
 <1501106335.274.1675161471528@office.mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501106335.274.1675161471528@office.mailbox.org>
X-ClientProxiedBy: PN2PR01CA0225.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::20) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f0b070-0900-46a3-9ec0-08db03b3b30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8+x/EN1tZLW+PegxQgQzfvzygOKqq6KBGOHHJ5Rm53FkWCDQ3ZGJS4D5989rkavzIVrzPBdBDat2T2AU7zkfsRdXJRye+SsoB8VzzVUEweD8jFvv+g/la9QlRHxyLm4XJW/uYdBDAXvUQ72Afv0rQQZ/q7RJn2SWhk9rOERzTgz+BMuqPLUQoJKOXUPI4EVBDAhPwqip4u+hbiSaIlWYZB7jLRqeVISD1plYMuFpE90S79yecley6XVLGyLn5mt1hrCPt800viwKmBFF8uThwwaNArW4g3S6/bWbWwy26IF4pi6CAKV87LB/gQhuVgqBnKqkRvfKQgwhIIHWSn+/m7fh9Xh5PxDfBp+PLumm2fhgeuuMA163GIwVKqOZ9xxy56IuIbzbw8ozca6l5iIQfVy9nS0Jkxv89pLwltXuM4ljYKjQjwgLbRXT6eQoaFSNpUfeOtlvkFpS5/wRyUkT7l8V2N+yQTkh+qd41hNzNhht7iKSr3ndhfpCXPWK8WZM1rEMLmFp2z4mRPZ8xP9IB0SZNcLqMRYTM6zvC/qrM9szBDa67zoT/nl+5Fc9bUWG/gkfITyRpxjDXGu2QrfR+1eUujyyQErTSXcto9GEdnRUpZVXIX4xe80S7i/birV2bbFmYjKXq8oe3syxR00wFNZI866ZFFybNFjuOew7oO6XnNa0ea2oxPYFT8oUOK1MMCgiwUfnsDqXrN/LxG9njg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199018)(6666004)(6916009)(4326008)(66946007)(8676002)(66556008)(8936002)(44832011)(83380400001)(966005)(7416002)(41300700001)(6506007)(5660300002)(316002)(54906003)(478600001)(9686003)(186003)(6512007)(26005)(38100700002)(86362001)(66476007)(33716001)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fmJBpxaibXYWggRPmL2lEVy80SgmOMmOmsW5Mpk7HoG8y/cga7RNTwaIZ7BS?=
 =?us-ascii?Q?452/J/22Rd+1zs0Ui9zlZH1BnU6yPkRpJZbXpI+vI9jLlhthQkOCT+cVBczP?=
 =?us-ascii?Q?wLA9uCZ3k5XytLThl7nKRs+BeumHy+kF85rsWfYmVrcn9x5RTlQLYayMhCWj?=
 =?us-ascii?Q?no+UZyDEz124IX4fhBvplQH/2RGri6ku659BbqIw/io/N5/Nc+N1SkaVs2FH?=
 =?us-ascii?Q?W1xUXYlD0QU5Fbmo8/itaVN2rzB6AZWXfSAuzklMOaw4BPS7NkC1V+QSdq66?=
 =?us-ascii?Q?ZTlwAdOcZjNjWmHJ7c2i8d9Gn0KTuUQQnIeuRbTWLsIz41LIPZVSOZ7V2q9G?=
 =?us-ascii?Q?dnEcnv2+LaQllSkcOgnEXQ0YRQa2fGSurbXkZnrMycVgfd5IGY5b4qBSf4KS?=
 =?us-ascii?Q?zY5w6kdPXtZCgIMl0QogxgX6ezN9ZEsHgkX8n4YsZcAwMUtBDhs+Bl59n4ZD?=
 =?us-ascii?Q?HU/XuAY87i4WcXY3CxlX9HKCr2ztIqe69fcYZPRTJVcRmrWuxxbBR3sRtq9z?=
 =?us-ascii?Q?DBlTvQcq89I+71wHW/0VYLUlTkz4vWoPOn1WwwQWi1tolmAuUaIr4IiuNB9P?=
 =?us-ascii?Q?/t2bhBVvH986TNefbQyTFSTeTCF787E1TzpY6zkkVerMiWJWIWTtvqJj1UjH?=
 =?us-ascii?Q?QxD8ZhLGaGQe0NPhP9Q3k0G2uJ0n492FgsRcd7zh6DpZlWYIMy8nwMWL3vYN?=
 =?us-ascii?Q?3NssSN14qI7W1QNa68tL5/xYRL+l+6QOlkLt+n1Lxhg13tKD9RRPb6LVEFYW?=
 =?us-ascii?Q?zCPF3hRi+WdQMgboinvLh6lRmOUTTVmf1F9BpEJHLmgUukv3JTcekGHqf/ev?=
 =?us-ascii?Q?YjdAEoWfCDFFsBuoW6NmRGsPaG1xIiW7nOX9xyO+E57yuDojTDA4vjiOOWUi?=
 =?us-ascii?Q?qzMa/KrgPxO1eACvAzYgxVNoLoSfrX7ABnNhCP8ufJqDX9u+qMLrEtiCBEKS?=
 =?us-ascii?Q?gXNLhpt2ggAQ7teEurxGXGpEamBPzr8CkTm8VY4/JjMRYB2TbFecTStUV1Cq?=
 =?us-ascii?Q?AxpYSg6Zsf5dL9dtJCGkm/4qEkKlBkQhRJsHMuHEPaWtDumiX1YoObQG99tD?=
 =?us-ascii?Q?HUdHHV+qPpxMBoHObi3IzqSwn+YtjiRZXGEvcBQ/NIogq3SvWCZq2nAdgiTf?=
 =?us-ascii?Q?AbKED+ToZLurrbgmXO+62+qvXF0tHprYtYMm+KMDO81+C9NQVhf0z3+lNn8w?=
 =?us-ascii?Q?yI4b6TrW2/EjPDZEHlNwOfHV2weBJ2lyWtvxG/Mcj5Ii33I1otSLy3agLGdf?=
 =?us-ascii?Q?xSKlUiUs/gdXNW/JM1LLELAQtuwbwkAeJjlMFsEOCiGJxH5Kw9O8xYjTP2yf?=
 =?us-ascii?Q?y7gjMEgCyUivYnEaIdVebT70HnEYkgGELvId1HA8Qhx8/8hMoI+6SRTlCG7Z?=
 =?us-ascii?Q?B/IUVWMz6+Vc6ozlwktZMCjH0jQfZr5Xixf3RKRObbe0WPEvrc/i4YkXDN7k?=
 =?us-ascii?Q?36B2zUdeTM2PIxNt/fjN14SbnG3P33+p2geyI1aULKGZhEED8MRc4DstmobH?=
 =?us-ascii?Q?C9VjKvAWXTEKinCInhUGMgyhfn8gXZiaXVP27FTEWHUH/2m3Jx9LHyg10XXG?=
 =?us-ascii?Q?XeNm4+4RIY+STFmvE23inbDvuUytiItZHMalRZ19?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f0b070-0900-46a3-9ec0-08db03b3b30a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 17:50:54.3247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hp4uPEdvE6laU1ZGDoKRGiHFdmuun5GUPhn8W+ySRnVnjuymgbmdZYfxwgmiWWaaro4Bg5ugslsDUWPt8tZ35Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jan 11:37, torvic9@mailbox.org wrote:
> 
> > Wyes Karny <wyes.karny@amd.com> hat am 31.01.2023 05:21 GMT geschrieben:
> > 
> >  
> > From ACPI spec[1] below 3 modes for CPPC can be defined:
> > 1. Non autonomous: OS scaling governor specifies operating frequency/
> >    performance level through `Desired Performance` register and platform
> > follows that.
> > 2. Guided autonomous: OS scaling governor specifies min and max
> >    frequencies/ performance levels through `Minimum Performance` and
> > `Maximum Performance` register, and platform can autonomously select an
> > operating frequency in this range.
> > 3. Fully autonomous: OS only hints (via EPP) to platform for the required
> >    energy performance preference for the workload and platform autonomously
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
> >     1	   1.00 (0.00 pct)	   1.01 (1.00 pct)	   1.02 (2.00 pct)
> >     2	   1.07 (0.00 pct)	   1.06 (-0.93 pct)	   1.07 (0.00 pct)
> >     4	   1.68 (0.00 pct)	   1.70 (1.19 pct)	   1.72 (2.38 pct)
> >     8	   2.61 (0.00 pct)	   2.68 (2.68 pct)	   2.76 (5.74 pct)
> >    16	   4.16 (0.00 pct)	   4.24 (1.92 pct)	   4.53 (8.89 pct)
> >    32	   5.98 (0.00 pct)	   6.17 (3.17 pct)	   7.30 (22.07 pct)
> >    64	   8.67 (0.00 pct)	   8.99 (3.69 pct)	  10.71 (23.52 pct)
> >   128	  11.98 (0.00 pct)	  12.52 (4.50 pct)	  14.67 (22.45 pct)
> >   256	  15.73 (0.00 pct)	  16.13 (2.54 pct)	  17.81 (13.22 pct)
> >   512	  15.77 (0.00 pct)	  16.32 (3.48 pct)	  16.39 (3.93 pct)
> > dbench power comparison:
> > Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
> >     1	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   1.04 (4.00 pct)
> >     2	   0.99 (0.00 pct)	   0.97 (-2.02 pct)	   1.02 (3.03 pct)
> >     4	   0.98 (0.00 pct)	   0.98 (0.00 pct)	   1.02 (4.08 pct)
> >     8	   0.98 (0.00 pct)	   0.99 (1.02 pct)	   1.02 (4.08 pct)
> >    16	   0.99 (0.00 pct)	   1.00 (1.01 pct)	   1.04 (5.05 pct)
> >    32	   1.02 (0.00 pct)	   1.02 (0.00 pct)	   1.07 (4.90 pct)
> >    64	   1.05 (0.00 pct)	   1.05 (0.00 pct)	   1.11 (5.71 pct)
> >   128	   1.08 (0.00 pct)	   1.08 (0.00 pct)	   1.15 (6.48 pct)
> >   256	   1.12 (0.00 pct)	   1.12 (0.00 pct)	   1.20 (7.14 pct)
> >   512	   1.18 (0.00 pct)	   1.17 (-0.84 pct)	   1.26 (6.77 pct)
> > 
> > ================ git-source comparisons ================
> > git-source result comparison:
> > Here results are throughput (compilations per 1000 sec)
> > Threads:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
> >   192	   1.00 (0.00 pct)	   0.93 (-7.00 pct)	   1.00 (0.00 pct)
> > git-source power comparison:
> > Threads:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
> >   192	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   0.96 (-4.00 pct)
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
> >    32	   1.00 (0.00 pct)	   0.97 (-3.00 pct)	   1.00 (0.00 pct)
> >    48	   0.87 (0.00 pct)	   0.81 (-6.89 pct)	   0.88 (1.14 pct)
> >    64	   0.81 (0.00 pct)	   0.73 (-9.87 pct)	   0.77 (-4.93 pct)
> >    96	   0.75 (0.00 pct)	   0.74 (-1.33 pct)	   0.75 (0.00 pct)
> >   128	   0.83 (0.00 pct)	   0.79 (-4.81 pct)	   0.83 (0.00 pct)
> >   192	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
> >   256	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
> >   384	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
> > 
> > ================ tbench comparisons ================
> > tbench result comparison:
> > Here results are throughput (MB/s)
> > Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
> >     1	   1.00 (0.00 pct)	   0.70 (-30.00 pct)	   1.37 (37.00 pct)
> >     2	   2.64 (0.00 pct)	   1.39 (-47.34 pct)	   2.70 (2.27 pct)
> >     4	   4.89 (0.00 pct)	   2.75 (-43.76 pct)	   5.28 (7.97 pct)
> >     8	   9.46 (0.00 pct)	   5.42 (-42.70 pct)	  10.22 (8.03 pct)
> >    16	  19.05 (0.00 pct)	  10.42 (-45.30 pct)	  19.94 (4.67 pct)
> >    32	  37.50 (0.00 pct)	  20.23 (-46.05 pct)	  36.87 (-1.68 pct)
> >    64	  61.24 (0.00 pct)	  43.08 (-29.65 pct)	  62.96 (2.80 pct)
> >   128	  67.16 (0.00 pct)	  69.08 (2.85 pct)	  67.34 (0.26 pct)
> >   256	 154.59 (0.00 pct)	 162.33 (5.00 pct)	 156.78 (1.41 pct)
> >   512	 154.02 (0.00 pct)	 156.74 (1.76 pct)	 153.48 (-0.35 pct)
> > tbench power comparison:
> > Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
> >     1	   1.00 (0.00 pct)	   0.97 (-3.00 pct)	   1.08 (8.00 pct)
> >     2	   1.04 (0.00 pct)	   0.97 (-6.73 pct)	   1.11 (6.73 pct)
> >     4	   1.12 (0.00 pct)	   0.99 (-11.60 pct)	   1.18 (5.35 pct)
> >     8	   1.25 (0.00 pct)	   1.04 (-16.80 pct)	   1.31 (4.80 pct)
> >    16	   1.53 (0.00 pct)	   1.13 (-26.14 pct)	   1.58 (3.26 pct)
> >    32	   2.01 (0.00 pct)	   1.36 (-32.33 pct)	   2.03 (0.99 pct)
> >    64	   2.58 (0.00 pct)	   2.14 (-17.05 pct)	   2.61 (1.16 pct)
> >   128	   2.80 (0.00 pct)	   2.81 (0.35 pct)	   2.81 (0.35 pct)
> >   256	   3.39 (0.00 pct)	   3.43 (1.17 pct)	   3.42 (0.88 pct)
> >   512	   3.44 (0.00 pct)	   3.44 (0.00 pct)	   3.44 (0.00 pct)
> > 
> > Note: this series is based on top of EPP v11 [3] series
> 
> Hi Wyes,
> 
> Can you rebase this patchset onto the newest EPP v12 series [1] ?

Sure, I'll rebase this on top of EPP v12.

Thanks,
Wyes

> 
> [1] https://lore.kernel.org/linux-pm/20230131090016.3970625-1-perry.yuan@amd.com/
> 
> Cheers,
> Tor Vic
> 
> > 
> > Change log:
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
> > [3]: https://lore.kernel.org/linux-pm/20230118075210.447418-1-perry.yuan@amd.com/
> > 
> > Wyes Karny (6):
> >   acpi: cppc: Add min and max perf reg writing support
> >   acpi: cppc: Add auto select register read/write support
> >   cpufreq: amd_pstate: Add guided autonomous mode
> >   Documentation: amd_pstate: Move amd_pstate param to alphabetical order
> >   cpufreq: amd_pstate: Add guided mode control support via sysfs
> >   Documentation: amd_pstate: Update amd_pstate status sysfs for guided
> > 
> >  .../admin-guide/kernel-parameters.txt         |  41 ++--
> >  Documentation/admin-guide/pm/amd-pstate.rst   |  31 ++-
> >  drivers/acpi/cppc_acpi.c                      | 121 +++++++++++-
> >  drivers/cpufreq/amd-pstate.c                  | 184 +++++++++++++-----
> >  include/acpi/cppc_acpi.h                      |  11 ++
> >  include/linux/amd-pstate.h                    |   2 +
> >  6 files changed, 309 insertions(+), 81 deletions(-)
> > 
> > -- 
> > 2.34.1
