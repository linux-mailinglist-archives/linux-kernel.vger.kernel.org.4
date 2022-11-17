Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA6262D296
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiKQFHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239029AbiKQFHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:07:04 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723802EF55;
        Wed, 16 Nov 2022 21:07:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/UapiEgeQd0rO7Ne3Xj1ROzf9Fvo7e8xsTVtw0LWqMlRmlyx5q3mcxzPa0UDdFmUqHTtVbuVdnhGn1JjjqdvPkkhfi4BXYcv0sgL0BSYhfQLBZb3Szb1C7Pp+d+dYjkOuKrUisF1Sg+X0+MWfR9DA0Ue7CCSeB+pw5enZQas1D73UaiMFSSKb3eFHyV0fb3VueCHs5+WnYvTS7/GXtqAd9MMcf8eYUciVYgdGxfiuDmhaKoTRm6R3MmuB1QTCpcDwNTRcmuGe8p3DhKmqqOVhEucLp2oN/hHLeSJtuUtY7BhwUFcnH02hHBY1btlqJCUX4RbPGH0EGJaMdnPypOVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmq63uGA3e0eI5SSVkKn5tJ4ZuI72oOdIn4eajHwQKs=;
 b=POkEElQS3HXw7vIU1TEAzm4tCVYwGdq5wdsOaTlb0j4NQ2F/4f3quN621m2AAyyxU2lqI3DSc90haWnG+k7mUXlnzlPvrcZJPbqdlr/us4VyaVyBRFsyLpelVUa5flTIfNg1Au3uSLL755AiC0KpxUFSvxgn672oJ0rgcKlbF1KO98lhoK963NtkIInhkDB0wOMgFJyY8VG7MBfwhZvyOPYGM/ogUM+3MFN17q512/V17XCbX4HwNwrGjZ11/bNynHgl/dSt3EHPmm0dKnRwEpLzCoz+JIu80VBqEAb8CokkD1VJF4jb5DEPb42c2pLGHksvpNo9ZnExMFjHAP97IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmq63uGA3e0eI5SSVkKn5tJ4ZuI72oOdIn4eajHwQKs=;
 b=4/Lm+HKCo/SdtDA0jApYvcKWxkf71C6m93zazEPa0PlCS+Ipl3m3SWEEDSQL+xXF/cGr/0cSX347CPj1uLmLDa9bPpyQELcYcL8JCq7RDHH6jPUyDIcdrjjG7KbFjHLYu+0hICkDiDiNmGXUx4YG3V2I7BzXZM3bzp68vOCsJNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Thu, 17 Nov 2022 05:07:01 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::b6f2:3174:a1c2:44b5]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::b6f2:3174:a1c2:44b5%7]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 05:07:01 +0000
Message-ID: <6e085200-0cab-13e6-8657-503a5090d6eb@amd.com>
Date:   Thu, 17 Nov 2022 10:36:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/5] Documentation: amd-pstate: add driver working mode
 introduction
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org,
        Mario.Limonciello@amd.com
Cc:     Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Deepak.Sharma@amd.com, Shimmer.Huang@amd.com, Li.Meng@amd.com,
        Xiaojian.Du@amd.com, gautham.shenoy@amd.com,
        ananth.narayan@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221117024955.3319484-1-Perry.Yuan@amd.com>
 <20221117024955.3319484-5-Perry.Yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20221117024955.3319484-5-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PN2PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::24) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f30c88-5984-4cc4-c920-08dac8598f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/Lli8zlsXtBpCYcAfB1XIVtOUOVlE8qZDyTZL4kX0kD2jsOByyh5zj16yRlA/q9JYQ0K5W3MXXW521plEuPUyF6ihig6zxhcvLl48MDTTa4Ou2Zeq7Z2+clGjT2pAW3sjRMj5h0zQ46TDPn8Sdt+CDtB57urh1Bcve/ilJqHQm1xPD1/lqJ2Xm/VjupHMvyrMD05GGp5S00WKgKCAPQIXQInB9xT5LnYYlVhGWFV6KKHsrsHqo6TZAKf0F2QbxynxBnth5NfhkhE4Km1zriB6heoZ4F9bBWnCoGi6aSu3O/ahUj7JGR7zU1Kec8zWd9lNiGU8tjSoj5d4mAIlkd3DcMQ5mdnywdfO+YEd4lP9b/lSw++zSU6xmqqXiKagoZCBzNoH92C7TQ7JcmRCVH5B0gr3gdccAYXn/LUVz0+B3tSXQj9gYYApA76vwviK3CJQpzS1CRzqtCdnrSqDASJj0LAMfKF8403w+2af57sO0BDzW5BnNoR3icEXGy9uGIHzxYt+CGlsfter4fimffFlWEFngKa9S7WerhCG9xYN//VNOLh1NDreBwdTvA3WQ0xGkAk6sqTc6mD2T8ts9u7ApiQqJXe20wD33a+P3axoDgtTkdc6qLVptbnr3UNxJs4InLYou65CLBKfZfvBkAXnd7VSHZTE+zCv1hNq+9MXs4HXsto9IDRH3gzPjh0xn7KHcWGMY38UpXCAIGQkz5etVkLYkdOZ1Ljzvroa85nxkPl9bRj/rItICcF4wkx4aq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(316002)(6636002)(41300700001)(36756003)(4326008)(8676002)(66476007)(66556008)(66946007)(5660300002)(31696002)(2616005)(186003)(38100700002)(83380400001)(8936002)(44832011)(86362001)(26005)(2906002)(53546011)(6666004)(478600001)(6486002)(6506007)(6512007)(31686004)(45980500001)(43740500002)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDZtSW9ndDNoakJYUnBNaUlaaU81ZllOaUpLY2loQWpLVVVoa09qcjN1cU84?=
 =?utf-8?B?ZTN5bmFVQlpxMkpkNmx0WjQ4bDdkbVd4N09zZW5JcVF1N0tIMGl5UlpUWWdH?=
 =?utf-8?B?MGtENTUzdXJwRmsrbXF0UXNNR00remYzcE5EMGEvbkVqSE94Y1Z5cTNCaWo5?=
 =?utf-8?B?MXZhUjhwcld0ZUlPeWJ4blcxbkt0d0hTSWE3Q1VORjVBVG11Zy9sK1c2UEh5?=
 =?utf-8?B?bE45TFdaVE1lWEg3U1BOS1ZQUWxUbzhld04rcVhtQWFvQlZMSU4zQzRJZkJE?=
 =?utf-8?B?YTJLOVRzb09DbWNhSGZEWUFXSmt0N0JRK01pTXd6Q3g4WDdQNTVoend2RHZN?=
 =?utf-8?B?cjJGYzl5MXR0WS9BNDZyWksybmFEV2M0ckE2RkZEbE1WKzFMdEhndXNqNWJW?=
 =?utf-8?B?bDE5cTkyeEY5WDJkRjk4NENwUm5EaVh3RGI5c0RsczhuZXlyVWhKRElzTVFP?=
 =?utf-8?B?ZU5ERkFVMi95ZjlQemtGblJJcTdaM2lqMEpvL1dvQXVwQ24yT3RNeG5XcDdW?=
 =?utf-8?B?NlI3NTRWekVIY2hZa3UvUjVnRUVNd29mV0J1dU45MEpJQkZ6anRZRUw4SVB6?=
 =?utf-8?B?b2dvdFU5NXJzRmxyS0JMTlZWc3RtK0RKUlV1UElvaFFSd3RPUmlSNEpWWFdu?=
 =?utf-8?B?UFIvcDk1RXNUR0V6Y3ljUmhMWFh6WmZMOXlac2RkdGhGaktSVkRzUGxnZG5q?=
 =?utf-8?B?U1RnRjQybUZKVTNxUXpYUVliWWkzbkRsN1V5cXhYQmtwdkRDRER3UzF6SXFV?=
 =?utf-8?B?TDgxWUt5SkRoYUtST2VPUHVkSUZXWUNDNmdNU0N0TDdPbkxNVUdjRk5hQ1Vj?=
 =?utf-8?B?K0EvYm9KdmErcURLSnRSSGhnYkFvQlNZc1puanlHQkRZZDNRdFdrKzVkc0ZN?=
 =?utf-8?B?NGtDaUdrWUtEL3FwU0hQTGtjTWdyUENoaEtPUWxnTUlUWlR2bTRjZGlNMnI3?=
 =?utf-8?B?NWxFTDZWNlIxVkt3WGxSaUYzSU54cC9nOU1xUlQ3RkY1VjNnMHZKZGJRMUlF?=
 =?utf-8?B?cUhVTTdGYVF2TTJUaWRhR1NOWTdMMm1HL0JKOUpmNGk5blg0b2lkVnU0VGwz?=
 =?utf-8?B?NitLTEwvdVZ6Sk05cDBQK042ZnNjTE5BalZYaHc1cGRBTFNxNVVsUXU4Z2VS?=
 =?utf-8?B?VUFCd3BmdEpSVDI5S05CSUxoZTUvcHQwMzVDSSt6Y0Fmb1VaM1gwWGI3VWJW?=
 =?utf-8?B?clc1NlhxQkFoY01MbGdKOEl6aUExMThjVnpMN3puYlhJK1NqN2d0UkhtNUp2?=
 =?utf-8?B?a0pRR1FWeTYzV2Z0YlNBeGxISnZpSTlQMEhMbFBrQlhLMzdDU3RZNk9lWjkr?=
 =?utf-8?B?ZzFmYlI0UmhHTU5CTm9Yd3VqMyt6dWJRNGZjS2tQYzFXaTBPRUlqak9CWUNI?=
 =?utf-8?B?aWN4aUhnVzZwTFNVc1pNN2JEWUZUT2I3Y055a0FxNXVyYUtQRk9iREcyQUxX?=
 =?utf-8?B?ZGsvM2l5Y0FTbWZCenY1dFFPdDFTRjdvMm9QUEFCeExPMWtxMWVkbGtqODRI?=
 =?utf-8?B?U1JQYWJvbGtPWTJldnBxZHhiWHU0T3R2L0p2VWJhSkJGZ2tDaVVUWlVDOFF3?=
 =?utf-8?B?bUdIWCsvWDVtWEJNOE9Jcnc4ZENBVWZ4a29ReFo1bE1xYU1UWnpvdHJXL01w?=
 =?utf-8?B?NkpHZEhJZEE4Y1k2U1gwNi9zdmdINWxFNVRjUnhpZ1NMeXhqM0RCZHlvNENt?=
 =?utf-8?B?WDlLYjFySnlFQU55dmxKdHNZKzJrNFphUEc3c3NMUHIwZkU0NEtwbzZUOUN5?=
 =?utf-8?B?S0lWYkN0M1lPSWZ0YnBIbGhvSjdiOEtzVlNYNlUvaEdwRm9wVGgxRWE3MlIz?=
 =?utf-8?B?d0NocFQ5U25vWlhFNExSYUZsdFdaekp5YThqaWN4dFdoZHBGb3I5OEc1anRP?=
 =?utf-8?B?OVY3cU9xbmFveVZ5bTlOeEhXOXBQcHB4NGo5QSt5bDVLOTBFZGM2Yy9TYW12?=
 =?utf-8?B?QmJiMDZxa1NqbVI0N0VkM3V3ZG5KbUdjOFpFOXdiMWRRcElRQ2w4MWpNQnZo?=
 =?utf-8?B?MHI4U0s1L29xb29SM294RG1XdlhIR01qcXVVaW9KMUlEZFNYUkl1dUM3b2ZZ?=
 =?utf-8?B?MDdVaVZzbDl2N0xsM3BVWi94ZjhXSXJxWVo3SXE4YmhBZUZCamFXOFdvdTcw?=
 =?utf-8?Q?9vzdRw3nJteAFAJsXMrteAcBo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f30c88-5984-4cc4-c920-08dac8598f70
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 05:07:01.4274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZljGxLrBtG91cHz8s7Put7a/Y63aLJj2X/Kl87zXxYcFh3iIAfd5N6NRCt9yEAIwPgFZ74VN0GFjbhCYF7OzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2022 8:19 AM, Perry Yuan wrote:
> Introduce the `amd-pstate` driver new working mode with
> `amd-pstate=3Dpassive` added to kernel command line.
> If there is no passive mode enabled by user, amd-pstate driver will be
> disabled by default for now.
>=20
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Tested-by: Wyes Karny <wyes.karny@amd.com>

> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 30 +++++++++------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/=
admin-guide/pm/amd-pstate.rst
> index 8f3d30c5a0d8..06e23538f79c 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -283,23 +283,19 @@ efficiency frequency management method on AMD proce=
ssors.
>  Kernel Module Options for ``amd-pstate``
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -.. _shared_mem:
> -
> -``shared_mem``
> -Use a module param (shared_mem) to enable related processors manually wi=
th
> -**amd_pstate.shared_mem=3D1**.
> -Due to the performance issue on the processors with `Shared Memory Suppo=
rt
> -<perf_cap_>`_, we disable it presently and will re-enable this by defaul=
t
> -once we address performance issue with this solution.
> -
> -To check whether the current processor is using `Full MSR Support <perf_=
cap_>`_
> -or `Shared Memory Support <perf_cap_>`_ : ::
> -
> -  ray@hr-test1:~$ lscpu | grep cppc
> -  Flags:                           fpu vme de pse tsc msr pae mce cx8 ap=
ic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx =
mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cp=
uid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1=
 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy sv=
m extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wd=
t tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 c=
dp_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bm=
i2 erms invpcid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt x=
savec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clze=
ro irperf xsaveerptr rdpru wbnoinvd cppc arat npt lbrv svm_lock nrip_save t=
sc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic =
v_vmsave_vmload vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overf=
low_recov succor smca fsrm
> -
> -If the CPU flags have ``cppc``, then this processor supports `Full MSR S=
upport
> -<perf_cap_>`_. Otherwise, it supports `Shared Memory Support <perf_cap_>=
`_.
> +Passive Mode
> +------------
> +
> +``amd_pstate=3Dpassive``
> +
> +It will be enabled if the ``amd_pstate=3Dpassive`` is passed to the kern=
el in the command line.
> +In this mode, ``amd_pstate`` driver software specifies a desired QoS tar=
get in the CPPC
> +performance scale as a relative number. This can be expressed as percent=
age of nominal
> +performance (infrastructure max). Below the nominal sustained performanc=
e level,
> +desired performance expresses the average performance level of the proce=
ssor subject
> +to the Performance Reduction Tolerance register. Above the nominal perfo=
rmance level,
> +processor must provide at least nominal performance requested and go hig=
her if current
> +operating conditions allow.
> =20
> =20
>  ``cpupower`` tool support for ``amd-pstate``

--=20
Thanks & Regards,
Wyes
