Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B33690459
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjBIJ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjBIJ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:58:37 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40D314483;
        Thu,  9 Feb 2023 01:58:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra7PlIyds8ZNSGZyRQg1yrPdwXAqMc6LG0PKh3SIa+skx9G+Jbt4cpw8FGG97BOvna6zV80/vA5Caffjj9pRKxHKEMHI6W4VITrhEXFukzEWQiQE4EPPrMWTayIkWlpSd3MhkNrQBsX6+fY5Sbsy1hRAOv3bLlCqOfjDNiMVS2Jh/svPb9sXABpHXu9GfF5TnC5/njiJsYmh6ojvNEtpmdnH1TroPCIUViM75zUxyKkjx9gnFAUEM9Vh/XYc1D/7T6VwYPzX8tmXo37bdc85VEKUB9S7rycyEXorcJ9NUxWF5NWffCnV55B1Mnvn7RlEDcIC2RW62wGY61VfBnKTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIWcvfg8gZIDdZkO1cAcGxchAmCSO/RftGxQDuiVEzM=;
 b=nWmr/liwniADHwWvOTGB/qNck9Q8yG4dRCJpVTpgJzetxtmiIXZkILxexEoULvroiX6z6cgeEVh1K7YwpmYIgpAaxzSZ2fqVhxp+HczqcXVFu06oE0jRtEGiBs3EtnDAiZBokTBWmKECYdGVr+4V1Se/PbyCCMoZf4m5mqFnniVIviexbkVxVnKnXofsKSfvWqJvd5JBj3lBZzVFzfx9K3/zjjAc1Zwon/GjF6txYW1aggek+YwcLQBK7720xZ0KrwH8cEr3U9scGxuk4posw6uRI0WjKecuAOQj7ds+BUZ/zvB76dpfRoPw3i427I5VmAjPMLYG8wVrCL5MFBuHSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIWcvfg8gZIDdZkO1cAcGxchAmCSO/RftGxQDuiVEzM=;
 b=GvEhLNK5BwWTLcxlzzC0W90jqY3SgEBfYo2L/DmR/PALBTKMMt8n5Ya5PoeXxbxSuIRewA0Mh0WFrT7dPemVji4ekhU8hf+/kwepokc1bsa6ah2wIqejVX6uyb/ZmPkmxsypg/v2e5GsROGcC3k7uap9h25U5pBGe0xbT2M555E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3888.namprd12.prod.outlook.com (2603:10b6:208:162::32)
 by SA3PR12MB8024.namprd12.prod.outlook.com (2603:10b6:806:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Thu, 9 Feb
 2023 09:58:31 +0000
Received: from MN2PR12MB3888.namprd12.prod.outlook.com
 ([fe80::c055:9ef3:529f:eb29]) by MN2PR12MB3888.namprd12.prod.outlook.com
 ([fe80::c055:9ef3:529f:eb29%7]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 09:58:30 +0000
Date:   Thu, 9 Feb 2023 09:58:18 +0000
From:   Wyes Karny <wyes.karny@amd.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Jinzhou Su <Jinzhou.Su@amd.com>,
        Meng Li <li.meng@amd.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: amd-pstate: avoid uninitialized variable use
Message-ID: <Y+TDurLjotH2WWxL@beas>
References: <20230207161256.271613-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207161256.271613-1-arnd@kernel.org>
X-ClientProxiedBy: PN3PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::22) To MN2PR12MB3888.namprd12.prod.outlook.com
 (2603:10b6:208:162::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3888:EE_|SA3PR12MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 2944d416-3a68-4599-da22-08db0a84328d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zcCCmSe+LI3pKqCiQ7bbg7a/s5cEMd6CKFXex/O7MWOs/5rlhJPZEvPWkA86s7yWzRpS4fbGC2BLhpjC2b9OFNVlL9Fgv2SyLJQonlx7S6cDT6HWLSjtkKYqMgkP+Sjnfpvy1po4JHorYVgFEzMy+IbVHgXa+HTTUkAOOI2WIudLfFtaKXDEmjMtTUsBTi+1GQc7zZszXIahZQX6FVpgGdnf4ieHGpi6Zy9rHW0uen5/BOsuCsxPyPS9/0zPK06YDKmfg7IJHjwAJ9inLIZKhqg2Rv5NdfYSYHnFcyo+FtslP0T+x+XxDL/bltNegSyn412KrT90oaQHRyN62MdR5Z0rmfHZX0wPu9RrIFVTsJs/a/H39k/rnduDU0mw6+qLaxC2xiii7p+i6EzRj9oZ5IShoEzOCgg96RrA4wuVTadxL9FRGVQOGRTABFMs6YgDco33rNQ0kNVDhVvrsgUFdGvxcc1bP7S5r4BiU5m72LdyJjQsPctHI2SYKdMXCvojtDZW5DIrMAEf49Wyrkhr2d6SQU19i/hUPwIGUZDRutEkMFaMS0Vziw7ctO38Q9ObgW+O1enIik1OFZnlp+jgDZSV/JSFoInhktq0dftQf7+hbDHvSMDTC7NysTpyTfvaPKs45N/s3S+zP7sSqyL0LfHoOf/7JpP7GnATm0kzhoGqk8ce+vcUxIcksgLHU/zI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3888.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(8936002)(2906002)(8676002)(4326008)(66476007)(66556008)(66946007)(6916009)(5660300002)(44832011)(6506007)(316002)(33716001)(83380400001)(26005)(54906003)(186003)(41300700001)(6666004)(478600001)(6486002)(6512007)(9686003)(38100700002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8XmggGjsUXzAfDI9mbMLOdrGnhkS/31/qNI3R7FfKPHQ3YdufwPlylFQAN7R?=
 =?us-ascii?Q?bDnWWxysiu4wchs294YhCJLSpsYsqVwb/4dQ9m8oJ3570B/U+F16Oafxvaex?=
 =?us-ascii?Q?79Vfzh6p0yIvmewbM+yBLGq5w6JsTQaYW8JH1AUwEtWFgRJVdM0mdYEoem4r?=
 =?us-ascii?Q?UYAu/1X1r81WUYW0+sdO458SlvJQvwjc5f4R4xlIqnQUvrkq3cnSXt4QziwE?=
 =?us-ascii?Q?sXbkjCPPOCD5fZ4+zI8DpdBUO70Pa1gmmPWXibAiAYy4W66KbuD5erIuTJt6?=
 =?us-ascii?Q?eoiRrdeorjUm3OSAXEkV3I7PayH6o12ij7kKxrFTr06KkHxvgfE6z+Re+6GB?=
 =?us-ascii?Q?D/t+jLTXIDo4knIu5DifPv6k/xLXX4JJs7RsNlJWs09rAvu1Bj2rjU0OH6Ph?=
 =?us-ascii?Q?M7kooer0rbnNSeMkfJcDSOkQQslTWH8JtxjHLDB2jSMczWtLs77/LmffxlsG?=
 =?us-ascii?Q?mXyIpqbAlxzo4XI1gAiEyLQx2+h+eSrcI7d5jF4NCEyoFB/WPj8gzBDib4Xq?=
 =?us-ascii?Q?nYN4Ekna9+8XoK4etTUWzFCLscyzKtUJQ6ECvGLp6ZfyuO9OwHz4KU/bSfR+?=
 =?us-ascii?Q?afhmspCYdRCZ7COKL0G4cJd+KkrzTI3vTN5SRxPb45q5Oc7t7Y+eNyIhamqj?=
 =?us-ascii?Q?nQkLfRLCBR2R0RbRRrjEn33/tpp35qvfgPGBX/BO+KXop2zD/ZabVVgVxU3Y?=
 =?us-ascii?Q?ig6XmxOeXK1ndh5ECcuOjcN/cS/wbhpTbAle1bTfkRomm2/bBsERVovdsW49?=
 =?us-ascii?Q?n+zN13lat8XMOIOIzbHn7BRiErViDAqjpVBe0wW0+z+IFUy+suhdNXpQh88E?=
 =?us-ascii?Q?C2Fed89ouWIvWZsRYq2TfBNq69rlxusd2kgy1NJWsuPPkWyTpH42+A5LKGq5?=
 =?us-ascii?Q?gP1w+CCj+K1dAgYMcA+jWKcJFaoXDjAG/rJmHqrRwGeV6LVIFaPArsrvI4Es?=
 =?us-ascii?Q?WNHc/GdQ1dJrEkFXRhqiwMpQ3BkEu9SWHH1gfxzUBMu2bjJaDfnIyblvvkz3?=
 =?us-ascii?Q?rN56ttBbiThdVEiDmDOKWEgd0IPjbryXu36tCyGnB6qkU7AzpJVjBz+i2PNk?=
 =?us-ascii?Q?oibj9rGRX4Pf3Iw/zZa5/qhAFO6YGNu5E+3uxh2+3rJwEassi8w+oK4UMz0L?=
 =?us-ascii?Q?fiOqg8rVe7lzOa0KbF0nC+eDsNuftpwhwk67v+7+vpRq2qLPROqRrNLklys4?=
 =?us-ascii?Q?bGyhWgo9mglbsI7a9VM01e4bqBGOmuttAbhGxsP4IbH1yHB421gQt6SjdB+D?=
 =?us-ascii?Q?VZxmS4FA4qUmAvqM4qwLqUwqkYYmosn8czAG51lJg0JTOGzOoUr0PCElDYjc?=
 =?us-ascii?Q?LCtM32iNHC1jqvMEXNP168Ft/o3gwnMFNTFFEroVR0WSvY2YaUiB69LRQ3a0?=
 =?us-ascii?Q?Q5nzmCrBxJpfxQbrC9ZOtjOVcjFCtNR5SRLadq7Qh8IjFGRASuxluD9F0V0w?=
 =?us-ascii?Q?qhIrqf/LXQ2GATXxRFpnKvawiU+xov8qH88MRqvYGzJNWo1jxLBbcG0VchXC?=
 =?us-ascii?Q?pFLcIlA0KmPYa30/ACycWOz4jpXwKJH3RpXWYWZWITiiUe2bHmoCog8/Kksm?=
 =?us-ascii?Q?zmYRbhrXRCeFg4ZMGxpZ8419470cGHPRHR5PXBUu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2944d416-3a68-4599-da22-08db0a84328d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 09:58:30.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 631STAog7TcZkOn9iFTlDz1yas3HtWTyVpz9TT6yTWQyftZPITye1aaXdNuiVxcPWhtRQouDpdv1RksUtFr+Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8024
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Ray, Perry,

On 07 Feb 17:12, Arnd Bergmann wrote:
> @@ -1076,9 +1075,9 @@ static void amd_pstate_epp_init(unsigned int cpu)
>  		value |= (u64)epp << 24;
>  	}
>  
> +	amd_pstate_set_epp(cpudata, epp);
>  skip_epp:
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
> -	amd_pstate_set_epp(cpudata, epp);
>  	cpufreq_cpu_put(policy);
>  }

I see an issue here with MSR-based systems.
Here EPP is being set before updating `cppc_req_cached` and for MSR
based systems while updating EPP value, MIN_PERF and MAX_PERF also
updated. So, here whatever value MSR_AMD_CPPC_REQ had for min and max
perf that will be rewritten instead of highest and lowest perf from
MSR_AMD_CPPC_CAP1.

Can we do something like this:

@@ -1053,32 +1052,34 @@ static void amd_pstate_epp_init(unsigned int
cpu)
        value &= ~AMD_CPPC_DES_PERF(~0L);
        value |= AMD_CPPC_DES_PERF(0);

+       /* No need to set epp again if previous and current policy is same */
        if (cpudata->epp_policy == cpudata->policy)
                goto skip_epp;

        cpudata->epp_policy = cpudata->policy;

-       if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
-               epp = amd_pstate_get_epp(cpudata, value);
-               if (epp < 0)
-                       goto skip_epp;
-               /* force the epp value to be zero for performance policy */
-               epp = 0;
-       } else {
-               /* Get BIOS pre-defined epp value */
-               epp = amd_pstate_get_epp(cpudata, value);
-               if (epp)
-                       goto skip_epp;
+       /* Get BIOS pre-defined epp value */
+       epp = amd_pstate_get_epp(cpudata, value);
+       if (epp < 0) {
+               /**
+                * This return value can only be negative for shared_memory
+                * systems where EPP register read/write not supported.
+                */
+               goto skip_epp;
        }
+
+       if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
+               epp = 0;
+
        /* Set initial EPP value */
        if (boot_cpu_has(X86_FEATURE_CPPC)) {
                value &= ~GENMASK_ULL(31, 24);
                value |= (u64)epp << 24;
        }

-skip_epp:
        WRITE_ONCE(cpudata->cppc_req_cached, value);
        amd_pstate_set_epp(cpudata, epp);
+skip_epp:
        cpufreq_cpu_put(policy);
 }


>  
> -- 
> 2.39.1
> 
