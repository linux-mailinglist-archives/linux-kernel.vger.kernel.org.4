Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BD6698CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBPGR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBPGRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:17:53 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A0B769C;
        Wed, 15 Feb 2023 22:17:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKharD67KfRzRmoZ1B7lBPTpucL6h4sMlohJyEoNj8Kp2YiqD1Hv4I5r9h31V9g7CoVeUr9Vv14TK4uQnOBKhL4VUSuHD4NyO7Kvfsvm+Cphh9tpBGIH6N8h3IevU1k9JUxn7n56MP288jIDbqoxYafYG5GVFTxZc5JRJ4XdAVwLR0w1iWtcjMq1j8rswsyvICDGUqTPfcf40HfSgnGqvVXDr/W12uGbQ9WNiLSVRQ92RFI98VS9CsDHX8Y8lwwqnCCpdvPgBu7YMLYs4SmqPix95FgQAGwyOlZ2+sOC4ljJPQV+fS1lQVxWWpBduZzc39Sxc0FRN/BvEMGuYswEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4usPy6kWAnqUvSAGNAVQZVpCjDsmvD8MoubyFaPA2I=;
 b=OE9dK0mmrOpL7l9K56FwO+hTIp9z89sX0M42/+fIZogBEMwvp/Qr8ubNwGxJgKsEntkWSslTmVArMTcp/XZ7Vti7B9rK7koAJVHpt+lpDgXFrCdhAUjIGZdi8DZFDw9omJyycSe0ljywqint+H5yp6g/rGzIG3CVex2KWjRY4en51+TztfPYc+sa/peQiuIWdnrQnFV/zVJO9Ku2HLlbKGML5gONYhE4W++HIaBM/836OFFxQMb0VBLshJwMUkI0aSQCZobsO7xfG/Odxe0wH83ow5l0jr1Teeu8ol4uoIehUtWptiRTjj1psa4vX1OuMbXzh1RQuaqhCdNtkvX4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4usPy6kWAnqUvSAGNAVQZVpCjDsmvD8MoubyFaPA2I=;
 b=PydmWqGg6FW/cDedCLbBiSfryCRgVAcXD3KUH9FIZQxaZ7d132LwrXEwx57RspbAYD0kZnAPOwLrybkOaH0nRNL71ncACQjcNS3XFVkxqQxUlGx8WReGKNPbYQUzL6KtiZ6/BYAhtYsmqHgeunXEHLvcbh2azzeAkVS40lvQHk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 06:17:49 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b%7]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 06:17:49 +0000
Date:   Thu, 16 Feb 2023 14:17:16 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Tor Vic <torvic9@mailbox.org>
Subject: Re: [PATCH v6 6/6] Documentation: amd_pstate: Update amd_pstate
 status sysfs for guided
Message-ID: <Y+3KbMV5u2GUPnUe@amd.com>
References: <20230206172157.49887-1-wyes.karny@amd.com>
 <20230206172157.49887-7-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206172157.49887-7-wyes.karny@amd.com>
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: df51a0c5-dbb1-495b-3be1-08db0fe5873d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h94hQ5drAkOaex+G0zcZX/V+kWr4ngiFkYpEkgqCXcqKIQugg/cu65bjt2mMlIMh7Z3pypfO5DhL4yVc9vxxFTLkyTASNVISA8VRcBEA9nj9+jqydp/Je1GJDRD79ovk1kjDu1W52ysGiqREEzZErRFngtnoCg47+pAYo4MhZ5VqrGGgpRfsOwIL9FIE5z5R1xZPdstB9kjMVQeN5Atkvz4yM4xxUNcBhhxg2DD88oaYWWX3rTvH/qODgKqmS7Ot1cqoJ5+RgY8+QzEQdjOOuUDGFivjHHqcSa9bwB8DOeJvODhZS4jH1WUuHAS41JEtM6IuU/2Ogp9Th6YJhzDNXPVtNLKooroha3rjlUYr6nAqo3G4Yzj6hyTiDHTmkK4AM7DGK0BfpHRZL4S419BC8lBmLBwPRFlhwUV/v/gehhafzXxFMzfTb46RRFeG9sr3Li152u1DUYqK04nE8BGKIma+J3hnP5UFGpkzngy39wH5HFVzJ7T51A42N9FoLHvVTMC/W/L1/YxaS5ZmqOb5cyz5gLGWJeCw67RSwyB8AGIhYHvygKty/FU7xttRayDQs667+B4MWegYudx838IR/PfXlBcmy4ckdZgwHjQqZ6qW6skyP/PlN8OlCpfLzOTfK/fy6+hYJ4ZQKWigsdEGdpuX9SsX9hvs8+5AFEuO3ViCAsf7hOLtVDNsQ0XOKmRr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199018)(36756003)(2906002)(54906003)(6636002)(15650500001)(5660300002)(7416002)(8936002)(6862004)(66946007)(66476007)(66556008)(316002)(37006003)(4326008)(8676002)(41300700001)(478600001)(6486002)(86362001)(6512007)(186003)(26005)(6506007)(6666004)(2616005)(83380400001)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Niq8Me8KnNRcMHiwEg9jwfzGKl8xi1FyebAgsnussZSQxbMAYlHZokXARnj+?=
 =?us-ascii?Q?1OjE6LB7L6Kc5prnNxSiayU9Pt7K5PkkOpWuqjUHxeO+iuK3L50FcABH0LVk?=
 =?us-ascii?Q?ryboF+qCwe4AIUHoTj0MBhZMXOY1/v7vqJoHbymTh8S97of1QJx/ffGE1qCJ?=
 =?us-ascii?Q?3gIVHQlJo+5djNRNZJs4RazJUt2ke0xhCoBDWmnJWOue7q4MqvfRE/Hv3MKC?=
 =?us-ascii?Q?uiD5cIiyApkGWeaL2zw38wPo9fnG4c6yCmtYmq9Mr910WMCq24nkR3QfpY4l?=
 =?us-ascii?Q?JqCnzJN6GbU7UDXi5hoVGylQ/llemA/Sdoi+T2Yn8OWPmNl/JCQDbQCa/7F2?=
 =?us-ascii?Q?mZHwQkStf5ZW+wDQS+ZZvjdfvHhn+sc4+z9GmTYkjhhciKOBjHwYafrNYFzb?=
 =?us-ascii?Q?wAkt3m/1oVMMV2/ghbTIDwHLXf1umv6DOTLwWY3i8IrMx97qa9korGLiidUi?=
 =?us-ascii?Q?O6jPgfUtlQzJuEWulFaGh+qJIuglTp78k19bqHoHKa5R/yzeGpt5CNfHMkWV?=
 =?us-ascii?Q?UjSdS1gS6TTXgxBbbr0S0o5XS9aRO5UPlHAEwYmKayo7Qv9Ne9Ffkl8o4Spn?=
 =?us-ascii?Q?gdEfwPZhfp4CSoUM/Eo0IqW7m+kzBWBYjZS9ceuI4s22YyYNCHZJ2LlJfCw7?=
 =?us-ascii?Q?HzbW9QvLgxBcZYengSzhrhdKnjLdMAvbX2do9AA7J7P6DKRIZbewDQb77UqJ?=
 =?us-ascii?Q?7ePnDDFT7TA5fSKZsdyIQdV86/PNwNcgf9RhRULriDt01yE/d1rRkeP8FKNU?=
 =?us-ascii?Q?Xnq57ZMkIIjgm2h7s6yL79JTeS5Kq8DNFQy34tHDhhrIySzBgutALaak4WSy?=
 =?us-ascii?Q?ME3HcJVY00aYA6HsK0VJWaZiHAEsGZeZ7gaQBYqE1kzhKeMWDAWwQvPJTarq?=
 =?us-ascii?Q?04LeHl2+z1VEtjeaRG56xOQovvj+eIq92khFwcxeWdoL7LSfzY8G5ghSIuh6?=
 =?us-ascii?Q?sAZucRJNsFCW3+lGCqglnJxvcWmh4sLSW3cI3fHWsMn+OpZ/ObeHzglxiueI?=
 =?us-ascii?Q?2+iXyme2M7tXANpEtZJjK48mNVoc6OwSxP59hQtk2fB3Va6nSPB2pnz4tWvH?=
 =?us-ascii?Q?m2YGdtoTBfxUA7+hP32MRXfyeyf/cHokKwMQ00JET9FGD54vmsXBWghfCR8H?=
 =?us-ascii?Q?y7TNI2N2o/r06DuX1Ap0yNTzIc39AcalznmvIzEbVJNVQ4ZI9HsmnD+vm2O4?=
 =?us-ascii?Q?9Oc4Hfs2dQxb6C1quJlBMQ5reVz0tD5+fn8Yia6KH9ZmNKsrpCCN4O2BvbA0?=
 =?us-ascii?Q?oOlWWfCIUVsFG4EIJfGI/7qYinO3i0NFB3rqM8OG6+RmyX6bvzu8JjcYKSNM?=
 =?us-ascii?Q?oZPK5c89pnnakAEaFFxkoOxaEMwVCWcUHtOSYMcKp7ExeBgGWXj2l90Dteh8?=
 =?us-ascii?Q?7DyFmzsiRXFqoJ0orq+i6GwMzeaoaLXLKEtxff7ASuwoZksRPFKDbSSl+hd9?=
 =?us-ascii?Q?3gGOSJeFx3Wq8sUT7gihcujAWFCDZqto9NJnqoEUZzB4yCoOKcipoKHSSfAT?=
 =?us-ascii?Q?9s+S65myfl/RGDoPsk5cy20r6G9QCyPbgJQQ/uc7wJQGo1GmF68pEzBs0ysv?=
 =?us-ascii?Q?mCUBGcLtGYGXaNzSFn6hc9kd2elJG7fCFGTdw7qn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df51a0c5-dbb1-495b-3be1-08db0fe5873d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 06:17:49.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/CcJLXEcwiULz1t0d4bZCi65T+blnz1PFC5qmvnYFTDmaPC+TrKklK48PqdYWlPaUJwMAP/XKV57RRUA58Z5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 01:21:57AM +0800, Karny, Wyes wrote:
> Update amd_pstate status sysfs for guided mode.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 31 ++++++++++++++++-----
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 5304adf2fc2f..95d2d0a803fe 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -303,13 +303,18 @@ efficiency frequency management method on AMD processors.
>  AMD Pstate Driver Operation Modes
>  =================================
>  
> -``amd_pstate`` CPPC has two operation modes: CPPC Autonomous(active) mode and
> -CPPC non-autonomous(passive) mode.
> -active mode and passive mode can be chosen by different kernel parameters.
> -When in Autonomous mode, CPPC ignores requests done in the Desired Performance
> -Target register and takes into account only the values set to the Minimum requested
> -performance, Maximum requested performance, and Energy Performance Preference
> -registers. When Autonomous is disabled, it only considers the Desired Performance Target.
> +``amd_pstate`` CPPC has 3 operation modes: autonomous (active) mode,
> +non-autonomous (passive) mode and guided autonomous (guided) mode.
> +Active/passive/guided mode can be chosen by different kernel parameters.
> +
> +- In autonomous mode, platform ignores the desired performance level request
> +  and takes into account only the values set to the minimum, maximum and energy
> +  performance preference registers.
> +- In non-autonomous mode, platform gets desired performance level
> +  from OS directly through Desired Performance Register.
> +- In guided-autonomous mode, platform sets operating performance level
> +  autonomously according to the current workload and within the limits set by
> +  OS through min and max performance registers.
>  
>  Active Mode
>  ------------
> @@ -338,6 +343,15 @@ to the Performance Reduction Tolerance register. Above the nominal performance l
>  processor must provide at least nominal performance requested and go higher if current
>  operating conditions allow.
>  
> +Guided Mode
> +-----------
> +
> +``amd_pstate=guided``
> +
> +If ``amd_pstate=guided`` is passed to kernel command line option then this mode
> +is activated.  In this mode, driver requests minimum and maximum performance
> +level and the platform autonomously selects a performance level in this range
> +and appropriate to the current workload.
>  
>  User Space Interface in ``sysfs``
>  =================================
> @@ -358,6 +372,9 @@ control its functionality at the system level.  They are located in the
>  	"passive"
>  		The driver is functional and in the ``passive mode``
>  
> +	"guided"
> +		The driver is functional and in the ``guided mode``
> +
>  	"disable"
>  		The driver is unregistered and not functional now.
>  
> -- 
> 2.34.1
> 
