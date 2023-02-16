Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4459C698CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBPGM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjBPGM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:12:57 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949A3A256;
        Wed, 15 Feb 2023 22:12:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTPeAuZZiN3YbVXx7iFkMPsaf3vzcgzPbbuf0Vxnt70zljRzTd+GCpR6g1WgzMwsEvTwS8FDy4H3WHu1ZKK5xfg5SdVuIcmwC+2yNMlXW0VhJRIGgZ7W0KhcX6Kj/C44v4oRsIpeck9mnHgPz/pEGx8K3IQ28lZGMJ+At9+4tV+DJdmQ6jUUIRyikdY90teCFcL9UsnM9rdjovNfxbFL36iGfuKjDpcbxgfv3mJLTXhASSL+XpGrHFDNHCuOYQgfJaFFbtmt4AHGQse7jK55ngldFFXE86agv1S4xMyCWJTAND8RITK3seEQgQmayC92GPHJoM6F2GCVbl7HjRE48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzqG3iGD8QmOhLHh8uFBV5mbR0agh3fcyMhOJApJdbE=;
 b=eaXT1tLNJBG2dZ2nKNqtrSHJfjdaCZz/0E61jw5R5MsklBZO48ma5Qqk1Bxcfd+ilnTrsUskFJS0pPMGWYiDfDOkK5umfJiJzcpeGOaUt6CzXUBR7Mljfe88wnQ7XZI6PLZuk8vXCXlPniAUJoU11y/4zECk+jSdmu5td+7aR43HT5EVCKt64txtmH+obQLT1jwODka5f4bt7niCbFSa8Kx6SvGeyi8JYKaoZ/gv5hti04BNKibMX67XWKgjjM5Y0ALU/zNDb3iDKnO0D1ovOw6WOTUH6OLLahvgj767I7P+Q4hxptZKOKmyhIsbRgSoSKaDnGt032qrTbea0+94+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzqG3iGD8QmOhLHh8uFBV5mbR0agh3fcyMhOJApJdbE=;
 b=o7iIFuH3J/vLiUmZmxh3HZn0zK07gRjSBK72nyZnfPWlqX/SvjR1rJTt7Ea7/nCyfriOHxvkAZWNLGRxHfFJomrhuNdGmpTv0qXXoiWHdfqeaQ/dYJHOwNo4+f0tZw7Co9yyL2KfqaHAWJlMe7k+/Do08PzHDp9HhugkNstgsFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 06:12:53 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b%7]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 06:12:53 +0000
Date:   Thu, 16 Feb 2023 14:12:26 +0800
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
Subject: Re: [PATCH v6 4/6] Documentation: amd_pstate: Move amd_pstate param
 to alphabetical order
Message-ID: <Y+3JSn5uVCxMShV/@amd.com>
References: <20230206172157.49887-1-wyes.karny@amd.com>
 <20230206172157.49887-5-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206172157.49887-5-wyes.karny@amd.com>
X-ClientProxiedBy: SG2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:54::13) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1ebbd3-0217-44d3-abab-08db0fe4d666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bikTEXDizrBGlOtCGtFbDxbsjuadmbRAZfmcv4pVBnaSuInqt0DsB5hTyEjNdA2TqZ5D4Yl5Gi2rAt3Gs07UNgnDgNwFyN7Yxjx1xQHbHvriP8IOemarOkqpillnvmj+mTSuNH5E5wDvjDlspB42J7NmLrQJ1oFWxr0R+1L7kEzZztc4EuPz4XkxcY0jvoV/SwuU4A6Y41e51F2IsJykJoKeywV+J3nRKAzv1vwU8cVbLkUtqvPN1vcIJOc9CI+xrDY1JOAdwCG77Pt+m/1F576lJFNqVjzDKhFY/hNWaC3QdYMYjUlXDmzKaDlI4GWKGX3XKjmmjlDyJ6gNJu/8bVIsySgU3822SzwQS9VOUDLeAL9uDDX/MMKWN0mPEnOmhjo1ivoIE9RX+3/sHhNGYoNhEZAHo1bbVuyzQEjp4fJ/dxa3XAc9IB+xoMs/wPJEPIc/aYpQtBGBjAxlq1yjXuTBLZUtMeckvfQNlXXKdIzSYTsCtKRWxGb7wHRDaNKCkoXt6nTHrh4JXAmBCwgOA427CfAmm2CuPP9/Vt/YFz2jMtrwpq2Y+GtXGvI77cDlAGlHmJ08PlPt6h3ONr94DIL19GF9JkzdEKcfEfIEsUzfPw7YCNWy79dURwv8r45k98pB0iF2uYy2JhkO7yTD6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199018)(36756003)(2906002)(54906003)(6636002)(5660300002)(7416002)(8936002)(6862004)(66946007)(66476007)(66556008)(316002)(37006003)(4326008)(8676002)(41300700001)(478600001)(6486002)(86362001)(6512007)(186003)(26005)(6506007)(6666004)(2616005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8/QUPrkjqrAnFsfPeBByDDjU4a/SZGnN3HzuIlA9oFAKdOrJMo1Tvfd7ASc/?=
 =?us-ascii?Q?vtYRQpTNek9ugPTx4ykoM1U35QDfHzJosmDECGrecRYw14aUe43WOAIooTQH?=
 =?us-ascii?Q?sPbYrHotgIf/mbAEtMkHBoL7wMLDqEGUFG9pApxKhnUks8A6APDD12rVYLuG?=
 =?us-ascii?Q?pKJ25hpXruxS9Xkd2h700MGRtdHvyJgKz4873ii9qZu3gVUnmd2YJj668BA7?=
 =?us-ascii?Q?C/CItUG+YEQ64vkJmFKjAfxcs4GEm0Px3OzkcWedrkJJtX1CoFstlQ052Id/?=
 =?us-ascii?Q?svgnKS9mY4O3MMfKNrm4sH/h4ntX4ubUjhHGRYWqBJSHoBdkHuQFxeXKl0F3?=
 =?us-ascii?Q?z39blwb8RejY9tuXD4mxjWBAwkYhZy4Ckkd27qKxqdIOqaIu0JM4RYOGaQZJ?=
 =?us-ascii?Q?4JT+zvyr9lXOfK6pmaB3+THebgkKdxbTKlhBY3Hu3Qgk8fN+B39msA/HJq8X?=
 =?us-ascii?Q?6a3EH3EbZ9AZYIv0iG5S141ojkfJNIutfEX/DowXMWPsIa556pfB7nar3M9x?=
 =?us-ascii?Q?24ZGa7Mw2kHK/GH6w/LOj9XXL/pAoJnT8utEx3nIxp/DloZ8lj15GwH9JIyR?=
 =?us-ascii?Q?3XajLahfaE4Rg58DL41LTacBu+Kgv/IeYYsBS/mGmgFK/QzFtsI7FUdkcau/?=
 =?us-ascii?Q?UxIrcCbEdsJZ2P1+ToTT7TEUO6mbknpxPH9GOICYcPClpfmhJuXGCJp6Y+YB?=
 =?us-ascii?Q?33tUATSLAjUsbIJ6uglp0EAaAJ4WHLDL2LkIy0AdDXsbxC9VDOR/hLg0yp6D?=
 =?us-ascii?Q?99ikIIhAAJrAkerfOKvnzetQ+Phc/5pqm6RK7UO0U7MZiOyg5LrPT7AJBIVH?=
 =?us-ascii?Q?VTLIxRj5DO14gouFHBY2r+FksekSyXxOPzLVJm4E/ZLDBpv2AsyTKEig7xGA?=
 =?us-ascii?Q?sB2yAQWsMZGlm2LiXqC217lbc84zWXVkqomEzSfS7HuKB2MJegzBW7EEY0R4?=
 =?us-ascii?Q?JJUsXKxDhD5rF/0sI5gVgzKtuG+vdBz/7CBriblbdfS8MgWVmRbcT6EKU4C7?=
 =?us-ascii?Q?aP+xBnSw7ys0uggaqIgxDIbiBVoFQfuF33CgLyluIdpT9PTLe7SSjGAVCg38?=
 =?us-ascii?Q?aKV0zpbrUqrQEgM9OOMTx7LRbI5gtjnEJGTwHo/+mDnX7+9jQC8N6fGHS6At?=
 =?us-ascii?Q?ulhGR5bNqJ7Eb9xlp8ZhWOyu1DbXpN+RIM84GolTaTzSi7WK4MJlAREW14oy?=
 =?us-ascii?Q?lpVyRpDyBx/O27rnFk6A6eM/ezCD6GbIpdhAT/KujE4tlgHwaB2X6xPEp98K?=
 =?us-ascii?Q?YnsrXTF57+KgrQmj6McLdJj/e3eHBEUshVP2ttT3i2GKfFsIElHCAA0o6Q6/?=
 =?us-ascii?Q?gDL0XX0hYG31DSUGHHmM+9AAaJ3SO5afBpnscVYi6+fGpclgYcWUEooqaWrl?=
 =?us-ascii?Q?9Jz/d/89TbiHdPGgRnJQETrKmtI0vdfwRbZJBSt0W9RYGe0xV3RvBzXb/7p7?=
 =?us-ascii?Q?NItWHm/Hp7Ih7+dsA9nWpNapge+fwCA5nYntBz6Vy0pYYwIqV05vmFIWX7a0?=
 =?us-ascii?Q?K7AgVrNuEof6+A+1DFDzHgKWS7ir1DHcq4FQw6yXMToIMrnvzR+i+qzlbk3q?=
 =?us-ascii?Q?zR5RoASEpjOVIO0GgWEHjmULp1Mi8peL6ynQtMsh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1ebbd3-0217-44d3-abab-08db0fe4d666
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 06:12:52.9101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSI7260xdMDQvn3N1olF88vVftmB+46yXZucNoTblDHQQ51Ps9lw7uVEHQhI1d3fNftU4u34Pv+p3VGZq2Evag==
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

On Tue, Feb 07, 2023 at 01:21:55AM +0800, Karny, Wyes wrote:
> Move amd_pstate command line param description to correct alphabetical
> order.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Wyes, could you squeeze this minor patch to patch 3? I think we won't need
an additional patch to fix alphabetical order in the documentation.

Thanks,
Ray

> ---
>  .../admin-guide/kernel-parameters.txt         | 46 +++++++++----------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 56d5c189e458..d7685b4268ba 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -339,6 +339,29 @@
>  			             This mode requires kvm-amd.avic=1.
>  			             (Default when IOMMU HW support is present.)
>  
> +	amd_pstate=	[X86]
> +			disable
> +			  Do not enable amd_pstate as the default
> +			  scaling driver for the supported processors
> +			passive
> +			  Use amd_pstate with passive mode as a scaling driver.
> +			  In this mode autonomous selection is disabled.
> +			  Driver requests a desired performance level and platform
> +			  tries to match the same performance level if it is
> +			  satisfied by guaranteed performance level.
> +			active
> +			  Use amd_pstate_epp driver instance as the scaling driver,
> +			  driver provides a hint to the hardware if software wants
> +			  to bias toward performance (0x0) or energy efficiency (0xff)
> +			  to the CPPC firmware. then CPPC power algorithm will
> +			  calculate the runtime workload and adjust the realtime cores
> +			  frequency.
> +			guided
> +			  Activate guided autonomous mode. Driver requests minimum and
> +			  maximum performance level and the platform autonomously
> +			  selects a performance level in this range and appropriate
> +			  to the current workload.
> +
>  	amijoy.map=	[HW,JOY] Amiga joystick support
>  			Map of devices attached to JOY0DAT and JOY1DAT
>  			Format: <a>,<b>
> @@ -7009,26 +7032,3 @@
>  				memory, and other data can't be written using
>  				xmon commands.
>  			off	xmon is disabled.
> -
> -	amd_pstate=	[X86]
> -			disable
> -			  Do not enable amd_pstate as the default
> -			  scaling driver for the supported processors
> -			passive
> -			  Use amd_pstate with passive mode as a scaling driver.
> -			  In this mode autonomous selection is disabled.
> -			  Driver requests a desired performance level and platform
> -			  tries to match the same performance level if it is
> -			  satisfied by guaranteed performance level.
> -			active
> -			  Use amd_pstate_epp driver instance as the scaling driver,
> -			  driver provides a hint to the hardware if software wants
> -			  to bias toward performance (0x0) or energy efficiency (0xff)
> -			  to the CPPC firmware. then CPPC power algorithm will
> -			  calculate the runtime workload and adjust the realtime cores
> -			  frequency.
> -			guided
> -			  Activate guided autonomous mode. Driver requests minimum and
> -			  maximum performance level and the platform autonomously
> -			  selects a performance level in this range and appropriate
> -			  to the current workload.
> -- 
> 2.34.1
> 
