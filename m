Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB905673136
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjASFc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjASFc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:32:27 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E801AE;
        Wed, 18 Jan 2023 21:32:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7fp8zQf1vNxo/APYYAwWTMoFP/yM0EQiw5HSQn0vo14I28rCk/elaI8a3vguk3KIwcAL78K/KqcOa/QoxL7RsBrHP11P5trG+8e6bpKxyPOZmddZUmnVt+7OoRJorojn1L8vXBjHGPcDJRMPDw2K0dGAqhYKEHWBIW/pSOK7GLwkPDRo3E2oMQdZqoMbDu/ueqz9Lmk5ryduknKFnVEetMmuLx2PnKOnW8MzOSvzagvuV21IU4Qckoszn6ztYvD+DcWp/xXgtLbq9uXw2bn9a3PV9cidpGT8fuBisx2Uba6gjeAQJoXNqKdP1AdIW1lpnNrRjM7f5iELpKsipYMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jdrcz3UydMLriq+u5D9YFpIcLaI+2aHDKVPOl/hgN0=;
 b=KiwxF715bPdU+A8O1nn8ku8/elVNoYblRdOtyjt8wE2F5EKauvPWMhJ5nUqNrRxzy0aifRUk63Agu8APlJs2IM8aP9dIlcr2509SaR5if7tHFG8xDwAuZaV9Uer6x9Io+ciz+Wmohbo9fxa2ubA7FyPiyS44VESVYFN1CU8uk99VK98OB0/4BfnN7Z45q3zp60oi6gGWfhAaNFPHzAPWqLDNR+mjFcyuT5EqcJFBz0x7UFGK1F1/mqIpdpLOOOieOBIGWzPMT8so/ssrtGMwv8q2oXgF2YkqnUvMlbUIR+3hTZAujGb7dpQZIPyQXgPN/F2aLBrmMRH6RfinrxgA+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jdrcz3UydMLriq+u5D9YFpIcLaI+2aHDKVPOl/hgN0=;
 b=RD6BfF8GkS/FIS/b5C71DDaP5fGKiiT9wvRuBEeHn4ZNcID/y/W1NS6oLhe+Ui9pDvX070h06SfwzroW+yQ+mwN6iSB8SdfJoW/CU3pzofuBrtD7vaOm1Y+QC7yOqOan7UFBQ7YdVRqAXxIhZTVZbpOs9Aqdr6T6XLxhnhwb7ME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 05:32:24 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.5986.018; Thu, 19 Jan 2023
 05:32:24 +0000
Message-ID: <336b70ac-ac93-26ec-a09b-aeca0300d45c@amd.com>
Date:   Thu, 19 Jan 2023 11:02:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 08/11] Documentation: amd-pstate: add amd pstate
 driver mode introduction
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
References: <20230118075210.447418-1-perry.yuan@amd.com>
 <20230118075210.447418-9-perry.yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20230118075210.447418-9-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::33) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: e303f74a-adf5-4161-a468-08daf9de8b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YnihKT+PdQZg3Vun82DWOcqglaFpo21rCfuZ6GjfzeJzm83euimAqK2w3U1cfxQOn9R776uTnMtptUEB2MWs2agtB97R8aTh+vqBddYJ8Oq0AiOkgismeFWHdcyIf0hEWyV7WYvcoak3RCF3hez741r7ZTmPQ7grCU6J9MKtM5K8cI/MEooId+raK06QutPCKH7e50SVntejRXKi+PLTWZJp5BzCDieljmJunuNriizxo3ELapNqLS1rZTEmDFa2R9v35uCXKyAgw78VrTUt8zO8YDstIqaXuebo/A/tEyw6rJeFybWAwqxOAT+xXJpa9Gq5TSYjPCjDZomuHIuELpPc9tn7rMTwX7jLXqPbQSLtOUFn4XCqoCLuaEHMr92RRcBHmorM8SpvylTcAS+eNZtw9Czwex7sV/DpCgXh6Kqt3tCHb1qdRvQs+8Eb1Fv1bd6nqhttmPYIvvhIDIKu8oT1mfWIHuZrD1Szm7AR4az5BADLcvglUjZQ1g2b1H1hVZLETqg5e6YjrW6ccDHZ0TNhksQTCpq2oWUP/AcDQZ5uMdMACAgLqsCrFKMQ/kNESc+qLlatUTOPmFQxGYR/6t1n5zmM7WUMwvSdDKm71WKj9FZL1mP9h0faJ2HCkc67hYZHskewJcsR0JUZ9w6obGg1dIA9z0XcVIeO2f9NzegCtZ0uS54kVCYd88KYuN61St2ssMd6d76xGuu7x5FfniYcFxDC8vb+2nOluRVFDbQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(31686004)(36756003)(86362001)(44832011)(66476007)(2906002)(66946007)(66556008)(8936002)(5660300002)(6862004)(31696002)(38100700002)(316002)(6666004)(37006003)(6636002)(53546011)(6486002)(6506007)(478600001)(8676002)(4326008)(41300700001)(186003)(83380400001)(26005)(6512007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVplWHp3SUhvdnFoRUYrWCsvNnNCUzYrWlVpbW9JbXV6TVVtRkFQNmlPcGdS?=
 =?utf-8?B?cHhsWkdvMVVCZFZsTGhwRTJza3VQTWZOWUZ6UUU5OUtsNmpBc211SFBzeVIr?=
 =?utf-8?B?NHYzUGNlUlBCSGYrQmdiZHpmMHg1TC9va2plMFZtNVBvbVNXdDNZdWdVMUZk?=
 =?utf-8?B?VmxZaW96ZVc0ZlNGZ054V1FpQk41bGVSVHh5R2hzbHYyOWYvWWpZbFZTNHpR?=
 =?utf-8?B?S00vQm4rM1ZUYnIxNUpUa0J3cXlmVFBJTTUwWHdOMVMxWVdEcU5hbDNuc2Qy?=
 =?utf-8?B?eU1CZG51bmRUdi9tckl2VWRtdFNRZTh0KzgraHJqbWo5TjJWM1dNNnJGSXdo?=
 =?utf-8?B?YkM5VlNQM3h5ZVBWQk9GeUNiL3RmeHlycnUwc0x0bnorZ1NELzAvT3o2U1Iy?=
 =?utf-8?B?RUtZampBaEd2dk1PRDNrbXdoWU10dEZsSTBiM2c2RDQvS2dlZDkvRGhKSXRh?=
 =?utf-8?B?SzFYZ1hwZmVNVmlGdndpR2U3TUFlNnAwYXVYYzVxdlY2L21CMG4wZWtRRjNV?=
 =?utf-8?B?Ykh3U2lhNm1ONXgzN29wb0t2eDE1SjMxTnBOZTJZUmNYTVRmMEtXdGZsS2Ir?=
 =?utf-8?B?cnA4dGhtbW9nemVKRFFQYjlPc250OVB3cHNnSWs1UVhHcjdDcmw4V2phWG03?=
 =?utf-8?B?RHQxQlNDWnY1ZmxWZjB6N3cwenJwSHdVYjJGZVduSmNnMzNhcnZRV3o2NGxu?=
 =?utf-8?B?TjFGSThPNUVjRXJwUzh1TXpKd25BTXNVWERFd0UyL1BZN2JidzZ0UnQ0L1VI?=
 =?utf-8?B?TUFRTEgwc1BXeUhUbEIyaTFrd3UrSVF6eVlremREZE51YVkvTFlBN083US8z?=
 =?utf-8?B?V1hIaHorRitTa2M0Z1RkUllLelNnY1N5dTZLZXB6eFF0SjF6K3RWcXNSd3By?=
 =?utf-8?B?V3V5Zjl2Sy91R1NWeDBjcmR0MFh5NjRlU3didGM5TjhIZi9RQ0N6ZWJDakxW?=
 =?utf-8?B?cWkwMHEyZ21yL1ZZOGYyMXh5U3JwK1FOTzJtN1VjT0FCMGVyc0Jsc2ZXZkJW?=
 =?utf-8?B?QnZrOXlCVGxOUTZUUkw3YnBBM004Q2tZajdNclZES2NmTzUyWWhkNnpONnBN?=
 =?utf-8?B?UjFUNHBNaEM3U1FZSVc1ejdjVFZyYWhqWVZLRzZsMEtOSk55U0dKTUZ3d0Yy?=
 =?utf-8?B?Sm1QWlBVVDFOWnNFMjdoMml4QitpN3RvRkhDOHIwRmtrSlJCNHdxbllVbUdZ?=
 =?utf-8?B?N0JWMDU2OEpSV1lPMUdnSWZjSUErN0xlSzE3SjU4MmdkSEJHZXNRR1pUZGxa?=
 =?utf-8?B?ek5PVmo5bGpxZjFmMWlTV2FvTjVXclZOYk50bmloZTRxSlF5S3pRaDFRNDQw?=
 =?utf-8?B?Y0NwSVU4Wkduc0dqZ0FjYndaWm4rdDBBK3RSUHpLYlF0WWN4YTRoZm9hUzcx?=
 =?utf-8?B?cGVTanBMcFN4SFRhZ09HeHF4MUFjQ1dPcElsTWdsRlIvMGJ5Q2szUHNHYUNP?=
 =?utf-8?B?RnZIUCtLMEozMGFHQWJqT1dkdHcwMzJGc0NBVkx3OHVwTGhHcXhGcktRQVhW?=
 =?utf-8?B?TWl1RDg3M21CcjNxN3d6cVNkc25oSGNGMUlBSjVlUVpNTUJ6b01KT0FqSE5r?=
 =?utf-8?B?bW55L1N3TU1uSUY0dEQrY3VVeUkrMG91dkwwbEdaQ0crS2ZNUlhwczBWNm9L?=
 =?utf-8?B?TVV5RFFQNi9EaytibVNZT25ZWm9sYmV4YXdvdjZ0VUZHRmRRN2htbmVub3h0?=
 =?utf-8?B?YUd6c3JJV0dWN1haalU0czB2RVQwSkJlcndTd3VHYWM4dFpnUW56aDQxaDBP?=
 =?utf-8?B?cUt3dlRYc0RkZUVjekJwQ0t2SS9qTWFVMEFwbklzVExObkduVnEvNEtqeU11?=
 =?utf-8?B?aXQvSkJTK2EzaXRGalpkamFydzJyRmxsbDNWUEMybGZUck9BblVMNDBYR1BI?=
 =?utf-8?B?NW44ejFUc2JHeHFWTC81VXJQWk41Mjl4eExsMXlDZGRmTjE0eFdUaERPbjBY?=
 =?utf-8?B?eHphZkF5QVNNbkIrNVBFd2pUS3ZnYUl2SFZ4YmkvMUlhM2h3Y1k4QnBaRUVM?=
 =?utf-8?B?SFM3dHpTc0JJcTFLRC92QkdBU2FpSzBwRHZ5ak95RS91Wjh1T1JLcEF5Z1No?=
 =?utf-8?B?Vk9uc2hBdW9Hc1hlSlVSajZPK0JsRDk0RVJOV0Q5YkpxVTM2L1poaDIvY216?=
 =?utf-8?Q?L+U1s7k+1YEdxaousm3S/Bq1U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e303f74a-adf5-4161-a468-08daf9de8b16
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 05:32:24.1981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0QmwvaueVmMk/He6hxPUw+d0nfhDuaaWmzazwgmPxkYjUFeymbxs1TO5E2oLdbUHLggjJHf78iomHTQbKKhmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2023 1:22 PM, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> The amd-pstate driver has two operation modes supported:
> * CPPC Autonomous (active) mode
> * CPPC non-autonomous (passive) mode.
> active mode and passive mode can be chosen by different kernel parameters.
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> Tested-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>


> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 26 +++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 98a2bb44f80c..b6aee69f564f 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -299,8 +299,30 @@ module which supports the new AMD P-States mechanism on most of the future AMD
>  platforms. The AMD P-States mechanism is the more performance and energy
>  efficiency frequency management method on AMD processors.
>  
> -Kernel Module Options for ``amd-pstate``
> -=========================================
> +
> +AMD Pstate Driver Operation Modes
> +=================================
> +
> +``amd_pstate`` CPPC has two operation modes: CPPC Autonomous(active) mode and
> +CPPC non-autonomous(passive) mode.
> +active mode and passive mode can be chosen by different kernel parameters.
> +When in Autonomous mode, CPPC ignores requests done in the Desired Performance
> +Target register and takes into account only the values set to the Minimum requested
> +performance, Maximum requested performance, and Energy Performance Preference
> +registers. When Autonomous is disabled, it only considers the Desired Performance Target.
> +
> +Active Mode
> +------------
> +
> +``amd_pstate=active``
> +
> +This is the low-level firmware control mode which is implemented by ``amd_pstate_epp``
> +driver with ``amd_pstate=active`` passed to the kernel in the command line.
> +In this mode, ``amd_pstate_epp`` driver provides a hint to the hardware if software
> +wants to bias toward performance (0x0) or energy efficiency (0xff) to the CPPC firmware.
> +then CPPC power algorithm will calculate the runtime workload and adjust the realtime
> +cores frequency according to the power supply and thermal, core voltage and some other
> +hardware conditions.
>  
>  Passive Mode
>  ------------

-- 
Thanks & Regards,
Wyes
