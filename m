Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F233C66480E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjAJSDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbjAJSDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:03:16 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04050254;
        Tue, 10 Jan 2023 10:00:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1om4CbW89uY3/QCRu5MXWq68Mug3Qbg1eHog2tuyLUqCeI1ZejJcOB4LF/BZYwR5H/8qu61MDRRC9RPbsBBd0ZxHd+yaj2K9G5O9ZBfB7PpSwysszI2c4vcSF6CsBbnC2FGCUYdG4WtRwS7Pa3MjT62Mkz1aUYtsamFMs6ocWFU+KRRxFm5fc/uTtpK+qXsVR2xwMrawQk77EdOXP/nEsSi6oEAhUGPC1HkdvlwrJ29kPT8QNGTPr4Uzmay3cE3tlITypxOQrB2wbaq6iBDM1qZ9BAgBz6K5I6qeDjBMZAOy/5zjUurN5YrkfmZOOARRY89Bwpuy1kC45kXxRPr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pUb88rLaIF7lnJKuDAK6a0P4c19VU1ic/GytsaWjSo=;
 b=B24gssxneKxb6zC95wl0zS7vUTie0K3WSJWz+b1vwrXYL219tWmFBfrIqRXB2S3praebWklNXTtgH3UFAL7UCfiKTdvmcNUUvKuJMb6/nRou3uGBwBKxyM2UKHcrGvFGxx5Zl316jKglecmK83hU1YQcyHurZVmVf8MCKqNRDMmcN5JLHy6yweiw6Sb0xJuWxb5Hlta925ebaB8vTHOEsFuw1PsiiT20MNdaBCFDXcLzvhu7+SR/4Q8e2wm7l65YJrwKmOeXFeEBDsPNNQImoUQcbOoQwe3Vtip1cxCaiJ4qXevTv9GfdQ+xwgVgIIVqJQmTbXRL2xK8sqvmw8UU9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pUb88rLaIF7lnJKuDAK6a0P4c19VU1ic/GytsaWjSo=;
 b=xoUleWr9Y/+VCvKhWw+EBrlE1LmIOqiJ0C1fHXzuqkURZ6al+5gYQcbK7xtxAPb9m+gWWRyHd/wGS4xYxmN+jQr9kwzFDqjcTCZUcLEdOJKhQA9195geTKLOChjNUha3mZ2k8emRV6vxq48eTgOd08ijsKCKyb+s68xpMcGdZMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 18:00:49 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 18:00:49 +0000
Message-ID: <fccf9cd8-7e4a-7ba8-8a96-12d014d8e915@amd.com>
Date:   Tue, 10 Jan 2023 23:30:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Wyes Karny <wyes.karny@amd.com>
Subject: Re: [PATCH v10 00/12] Implement AMD Pstate EPP Driver
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230106061420.95715-1-perry.yuan@amd.com>
Content-Language: en-US
In-Reply-To: <20230106061420.95715-1-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::35) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7a9273-356a-4fe6-e603-08daf3349ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJVYJLlARjaYEE9udpmQOBDMfryDuskVjQ7sZ7x3X2mvQJ7Lxc37CNzSqcSmD1VJjDAeHfJ0tIC7w+CS/9VB5VjHrWUFQg2kMFffouA3e+CxXZs5QpeHH4+kht77lQQMu4Emn6M3UBjaDuTG8GA0uCaeGft1UlndlQVzVcynxwfgm1W1yqH0R2mDLqvFtBZNqAlfJgMNEAwqeqf1gckwErDlZEsogItecUZk1cMbQXbzMXbyzRlbpbePl3KvrVmBOcf8zeuHcF5Z098/7hDtvoLC/cQbS+Mb7mf96teR1aNG+42A5vz2EKJiaUbtPXq5FGsaXdf7axR4HwWelTqt5ddhTTCpSuIImIkxZyeFPhfd5RhY6I47J52yCHaPTde3S0UvLmI7xawu8/401O4E7Zj13r+ZZP3z+ynGqHFEuxp66MOwZY7ihQBYR6HDJQknX5m5aA+0WzzmQXE0MhaKCeTNlLm5WkK8hANyQ9QxvzNqio8qmnKxkAjOunehOoF/gtfOxbT3LyZ6fGsxvhBz5GXnw5Vvvgxb9rKEJt8KQIOl+A5x2vG9NBKwg7dnjpMEUWYEy6zMnslPsMQXG6FK13b9nl0sju1o4iGsCbfbjCcFa1a3l6gLZSQhJS+0allyX9IMWVsduX9jPnW0gJMY2ggnpAmCS+sPJCTaHMPNArju7Ah78GxbQw7EU5MZhUih3bR88SaHrtANekI4enbAuX7wtR/2v529zc5wSM51OETrK/bt2DQRfX8+0kmncr38BMn4ddBgulHAnnn+wFWSgXhQ7+WiPhtBrRp+xvmb2ZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199015)(6512007)(6506007)(186003)(2616005)(6666004)(8676002)(86362001)(4326008)(30864003)(66946007)(38100700002)(66476007)(31696002)(5660300002)(66556008)(478600001)(36756003)(44832011)(53546011)(31686004)(2906002)(26005)(316002)(8936002)(41300700001)(966005)(45080400002)(83380400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2p3ZTN6azE5WnEyQkZvM2gxc1d2S3hoaldKSktTdGc4NGplZlVLZ1FNdXYw?=
 =?utf-8?B?dWFPUmhIUXRQalNlS2RCTGlKSXNJNzBnZVI1cHlQQzZmMGljZ21VeWlpUTJu?=
 =?utf-8?B?WE56Slh6NVptd1FENjZUakY0MDlDRHhDa0FWQVN5NEd4b0txWlFTN3F0Q2Zi?=
 =?utf-8?B?YXdRR2RtZGpwY3poNjQ5Wm8wWGs5Qm11aER6YUUxVGVlRkhOMmZ5cTlHaXpj?=
 =?utf-8?B?SStjd1VlV1IweUN1Sk8xRWhwZlhxRW5wanFLaksxM1kwZ2VMVVZqaVpzRk5o?=
 =?utf-8?B?WWxpN2tRekYxOXNPQk85NTd6eXlVSWU1Z0srV3BYeFdiZ205My9uRjlmS1Rv?=
 =?utf-8?B?TVVtNlNnR2JqQnJqdjI2djExWjBEYko4bk9uSFhHVk1RcWk3SktmYk9oRDQ1?=
 =?utf-8?B?N1FJaXBiQVhvZVpsR09OTmpSa2FZUkxoeSs3S0tvaUJ0M3J2NUJYazB0NFlG?=
 =?utf-8?B?M0NVMGlPK2VpSXV2dllCTllaa0JUR3BVTzlNb3VCb0czZkc0L2RsdFIrRWRj?=
 =?utf-8?B?dUxCcW5OZU5aMTk3ZURpU3FkUUFJSFkzUEhLV2plSnJSaEd3SHRZUlBhYVRJ?=
 =?utf-8?B?VE5pSERkSzhpampZYVZvTzNaeUlKR283T3V2c1hZRDNoUjRnamR0L2p5a2pQ?=
 =?utf-8?B?U2MxVDJScjd1aWEybDVwSjFjYXZBWitTcWM3V3g5M3E4Q0tNV0I1dlNJTHFp?=
 =?utf-8?B?RWh4ZDRndmlGL3M2NmRtaTc4Z3VmUXNxSC9MMUJXQzlMT1pTSjNIQ3ZZRzBz?=
 =?utf-8?B?MEU5OThFczdjSTFhc21CWkdpTU4xV3ZmaXRvRTN1UlEwR0toQmJxenV0TlVU?=
 =?utf-8?B?TXFjTjJ3cnVmU29ub1RjeDBmcElYRmhMWXRKSXhUTVY1RFh5VUVRUHl3dGZC?=
 =?utf-8?B?T2xPMWZCU2F4dDdzaGw1aGJzU0hkdDRob0ZXMU8yQVB1Qlk3KysvWjlTQWNE?=
 =?utf-8?B?eGZFSFVPN1MxRUxGWlQyeVQ1S3VNRUJoS25lTHJZdWVOa01PMmFxSDlVdjlz?=
 =?utf-8?B?ZUt1aUVObkZiS25PQUkwWmRNMVV5QkFFNWhWd05wb29QWlltbHgwU2I1a3py?=
 =?utf-8?B?L1IxbUxvMGEzZWMvS1dOV0lrYnJGWmpCQVNlZlFXVHlTdGxUK2ZDZ3gzTnpZ?=
 =?utf-8?B?T2hmSm1CMFlDVUdzb0dkcS9zS2tYZVllSVdLVnM5SDZJdFVWbng5bTB5Y2Jm?=
 =?utf-8?B?SUhNa29HUWFXYldVb3R1Q204Rk1kLzlqT29wK3VRU2tjeEVJSndSUmNtUVpq?=
 =?utf-8?B?K21TMVMvcVJlWUx3SnNsK29XUmRwQUZ6MElsdmFWQmNJN2pZWHZFWjA4L1c5?=
 =?utf-8?B?bFQrdTB6YkpObFc5bndIY05NNW5pa3JxMk4vQS8yaFRSOXJxYThOMHlQcnZM?=
 =?utf-8?B?cmZZbmc3SllXNzVoOWJEc0U3dlhLVGswNXJSdktHWFhoeFpjTTIvakdKNEtr?=
 =?utf-8?B?MVl5bTFyZEVIVm41bW5mZHhXNU9ERTZhaWJrNVV1bi9wUVhzajFHbnpxbHZw?=
 =?utf-8?B?Qm5JODgxL0NnVlR2Q1BGaVJTYzM3YkZDUkFhVXRsZktOQzN2aTNJRzlWd0hS?=
 =?utf-8?B?NTJ2cE5ncnQyN1kzSGNkOWR0WGFhTERQcmlEUm5LQUFPV3FBQkgvK29Qa0NY?=
 =?utf-8?B?L2g5V0lUUjVEM2VhNmxsZGZqeFozMFRWNXovMFBoMzBEN0JkR2hsVDJ6TzFP?=
 =?utf-8?B?M2hTVWxON1R4b1E2aHJNc0htWlAvNjh5QXoyWDNKeU1DWlphMXF0V3MwdUh5?=
 =?utf-8?B?RlQweXZsTm00Q0Z5eGZjeVRrOHMyRWxZQnBnQXFXTEtwYzlCdDVOVWpCdlNm?=
 =?utf-8?B?UjE0QXdXcFpQczdGekluSTc4SktEM1ZCTStYc1NCdTZBaW5EVVdOQ2VCZmVH?=
 =?utf-8?B?TXlQUEswSTFZRlhxc29aQkxHek80NjZkZENRa2tnQlMrZEMxQ3MyUXdCYktm?=
 =?utf-8?B?NWxhY3NaUW9KQ1lWdkgxczhmZ0o2QU1xUjZCUHo2S2J4TVhMZG5yVkl4d3Y5?=
 =?utf-8?B?Sk16WjlLZjJoYVhqdUkyR1NIV2hXdU13dStuQks2MS9sVnlESnY5TE90eUl3?=
 =?utf-8?B?MTk5dWVBTW92WStiOC90ZHRDTVRmQkxzV0Y0anE2N2xuQks4S05SbTdRVVU1?=
 =?utf-8?Q?fYpqGZSvfAozCensZyA6JYVTn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7a9273-356a-4fe6-e603-08daf3349ab6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 18:00:48.9310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuxNM6f+mPhqqPkC9UKOJiL1ykkcU4x32DssP3frK3Hdo6B0ltmbaA5SD+FdGOrJLSA4erE5QjIkRddbBAjZBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/6/2023 11:44 AM, Perry Yuan wrote:
> Hi all,
> 
> This patchset implements one new AMD CPU frequency driver
> `amd-pstate-epp` instance for better performance and power control.
> CPPC has a parameter called energy preference performance (EPP).
> The EPP is used in the CCLK DPM controller to drive the frequency that a core
> is going to operate during short periods of activity.
> EPP values will be utilized for different OS profiles (balanced, performance, power savings).
> 
> AMD Energy Performance Preference (EPP) provides a hint to the hardware
> if software wants to bias toward performance (0x0) or energy efficiency (0xff)
> The lowlevel power firmware will calculate the runtime frequency according to the EPP preference 
> value. So the EPP hint will impact the CPU cores frequency responsiveness.
> 
> We use the RAPL interface with "perf" tool to get the energy data of the package power.
> Performance Per Watt (PPW) Calculation:
> 
> The PPW calculation is referred by below paper:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsoftware.intel.com%2Fcontent%2Fdam%2Fdevelop%2Fexternal%2Fus%2Fen%2Fdocuments%2Fperformance-per-what-paper.pdf&amp;data=04%7C01%7CPerry.Yuan%40amd.com%7Cac66e8ce98044e9b062708d9ab47c8d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637729147708574423%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=TPOvCE%2Frbb0ptBreWNxHqOi9YnVhcHGKG88vviDLb00%3D&amp;reserved=0
> 
> Below formula is referred from below spec to measure the PPW:
> 
> (F / t) / P = F * t / (t * E) = F / E,
> 
> "F" is the number of frames per second.
> "P" is power measured in watts.
> "E" is energy measured in joules.
> 
> Gitsouce Benchmark Data on ROME Server CPU
> +------------------------------+------------------------------+------------+------------------+
> | Kernel Module                | PPW (1 / s * J)              |Energy(J) | PPW Improvement (%)|
> +==============================+==============================+============+==================+
> | acpi-cpufreq:schedutil       | 5.85658E-05                  | 17074.8    | base             |
> +------------------------------+------------------------------+------------+------------------+
> | acpi-cpufreq:ondemand        | 5.03079E-05                  | 19877.6    | -14.10%          |
> +------------------------------+------------------------------+------------+------------------+
> | acpi-cpufreq:performance     | 5.88132E-05                  | 17003      | 0.42%            |
> +------------------------------+------------------------------+------------+------------------+
> | amd-pstate:ondemand          | 4.60295E-05                  | 21725.2    | -21.41%          |
> +------------------------------+------------------------------+------------+------------------+
> | amd-pstate:schedutil         | 4.70026E-05                  | 21275.4    | -19.7%           |
> +------------------------------+------------------------------+------------+------------------+
> | amd-pstate:performance       | 5.80094E-05                  | 17238.6    | -0.95%           |
> +------------------------------+------------------------------+------------+------------------+
> | EPP:performance              | 5.8292E-05                   | 17155      | -0.47%           |
> +------------------------------+------------------------------+------------+------------------+
> | EPP: balance performance:    | 6.71709E-05                  | 14887.4    | 14.69%           |
> +------------------------------+------------------------------+------------+------------------+
> | EPP:power                    | 6.66951E-05                  | 4993.6     | 13.88%           |
> +------------------------------+------------------------------+------------+------------------+
> 
> Tbench Benchmark Data on ROME Server CPU
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | Kernel Module                               | PPW MB / (s * J)  |Throughput(MB/s)| Energy (J)|PPW Improvement(%)|
> +=============================================+===================+==============+=============+==================+
> | acpi_cpufreq: schedutil                     | 46.39             | 17191        | 37057.3     | base             |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | acpi_cpufreq: ondemand                      | 51.51             | 19269.5      | 37406.5     | 11.04 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | acpi_cpufreq: performance                   | 45.96             | 17063.7      | 37123.7     | -0.74 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: performance(0)               | 54.46             | 20263.1      | 37205       | 17.87 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: balance performance          | 55.03             | 20481.9      | 37221.5     | 19.14 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: balance_power                | 54.43             | 20245.9      | 37194.2     | 17.77 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: power(255)                   | 54.26             | 20181.7      | 37197.4     | 17.40 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | amd-pstate: schedutil                       | 48.22             | 17844.9      | 37006.6     | 3.80 %           |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | amd-pstate: ondemand                        | 61.30             | 22988        | 37503.4     | 33.72 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | amd-pstate: performance                     | 54.52             | 20252.6      | 37147.8     | 17.81 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+

This series + fix mentioned patch 5/12 is:

Tested-by: Wyes Karny <wyes.karny@amd.com>

Test system: AMD Genoa 96C 192T
Kernel: 6.2-rc2 + patch + perf_ctl_reset_fix
Scaling driver: amd_pstate/amd_pstate_epp
(Results are normalized)

================ dbench ================
dbench result comparison:
Here results are throughput (MB/s)
Clients:   passive+perf		   passive+sug		   active+perf+perf	   active+ps+perf	   active+ps+bln_perf	   active+ps+bln_pwr       active+ps+pwr
    1	   1.00 (0.00 pct)	   0.92 (-8.00 pct)	   0.93 (-7.00 pct)	   0.93 (-7.00 pct)	   0.91 (-9.00 pct)	   0.89 (-11.00 pct)	   0.85 (-15.00 pct)
    2	   1.03 (0.00 pct)	   0.96 (-6.79 pct)	   0.97 (-5.82 pct)	   0.97 (-5.82 pct)	   0.97 (-5.82 pct)	   0.96 (-6.79 pct)	   0.95 (-7.76 pct)
    4	   1.93 (0.00 pct)	   1.54 (-20.20 pct)	   1.57 (-18.65 pct)	   1.56 (-19.17 pct)	   1.53 (-20.72 pct)	   1.52 (-21.24 pct)	   1.50 (-22.27 pct)
    8	   3.48 (0.00 pct)	   2.43 (-30.17 pct)	   2.56 (-26.43 pct)	   2.47 (-29.02 pct)	   2.48 (-28.73 pct)	   2.42 (-30.45 pct)	   2.44 (-29.88 pct)
   16	   6.08 (0.00 pct)	   3.84 (-36.84 pct)	   4.05 (-33.38 pct)	   3.93 (-35.36 pct)	   4.06 (-33.22 pct)	   3.99 (-34.37 pct)	   3.86 (-36.51 pct)
   32	   9.25 (0.00 pct)	   5.59 (-39.56 pct)	   6.63 (-28.32 pct)	   6.18 (-33.18 pct)	   6.50 (-29.72 pct)	   6.41 (-30.70 pct)	   5.69 (-38.48 pct)
   64	  13.07 (0.00 pct)	   8.15 (-37.64 pct)	   9.82 (-24.86 pct)	   8.91 (-31.82 pct)	   9.76 (-25.32 pct)	   8.98 (-31.29 pct)	   8.01 (-38.71 pct)
  128	  15.02 (0.00 pct)	  11.35 (-24.43 pct)	  13.47 (-10.31 pct)	  12.30 (-18.10 pct)	  13.32 (-11.31 pct)	  11.38 (-24.23 pct)	  11.13 (-25.89 pct)
  256	  16.37 (0.00 pct)	  14.61 (-10.75 pct)	  16.32 (-0.30 pct)	  15.63 (-4.52 pct)	  16.09 (-1.71 pct)	  14.83 (-9.40 pct)	  14.70 (-10.20 pct)
  512	  15.00 (0.00 pct)	  14.79 (-1.40 pct)	  15.06 (0.40 pct)	  14.96 (-0.26 pct)	  14.95 (-0.33 pct)	  14.64 (-2.40 pct)	  14.76 (-1.60 pct)
dbench power comparison:
Clients:   passive+perf		   passive+sug		   active+perf+perf	   active+ps+perf	   active+ps+bln_perf	   active+ps+bln_pwr       active+ps+pwr
    1	   1.00 (0.00 pct)	   0.99 (-1.00 pct)	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   0.97 (-3.00 pct)	   0.95 (-5.00 pct)	   0.95 (-5.00 pct)
    2	   1.00 (0.00 pct)	   0.96 (-4.00 pct)	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   0.95 (-5.00 pct)	   0.94 (-6.00 pct)	   0.93 (-7.00 pct)
    4	   1.01 (0.00 pct)	   0.97 (-3.96 pct)	   1.01 (0.00 pct)	   1.01 (0.00 pct)	   0.95 (-5.94 pct)	   0.94 (-6.93 pct)	   0.93 (-7.92 pct)
    8	   1.03 (0.00 pct)	   0.98 (-4.85 pct)	   1.01 (-1.94 pct)	   1.01 (-1.94 pct)	   0.95 (-7.76 pct)	   0.94 (-8.73 pct)	   0.93 (-9.70 pct)
   16	   1.05 (0.00 pct)	   0.99 (-5.71 pct)	   1.03 (-1.90 pct)	   1.03 (-1.90 pct)	   0.96 (-8.57 pct)	   0.94 (-10.47 pct)	   0.93 (-11.42 pct)
   32	   1.08 (0.00 pct)	   1.01 (-6.48 pct)	   1.05 (-2.77 pct)	   1.05 (-2.77 pct)	   0.98 (-9.25 pct)	   0.96 (-11.11 pct)	   0.95 (-12.03 pct)
   64	   1.12 (0.00 pct)	   1.04 (-7.14 pct)	   1.09 (-2.67 pct)	   1.09 (-2.67 pct)	   1.00 (-10.71 pct)	   0.98 (-12.50 pct)	   0.97 (-13.39 pct)
  128	   1.15 (0.00 pct)	   1.06 (-7.82 pct)	   1.14 (-0.86 pct)	   1.13 (-1.73 pct)	   1.04 (-9.56 pct)	   1.00 (-13.04 pct)	   0.98 (-14.78 pct)
  256	   1.18 (0.00 pct)	   1.10 (-6.77 pct)	   1.18 (0.00 pct)	   1.19 (0.84 pct)	   1.06 (-10.16 pct)	   1.03 (-12.71 pct)	   1.02 (-13.55 pct)
  512	   1.22 (0.00 pct)	   1.15 (-5.73 pct)	   1.23 (0.81 pct)	   1.23 (0.81 pct)	   1.10 (-9.83 pct)	   1.06 (-13.11 pct)	   1.05 (-13.93 pct)

================ git-source ================
git-source result comparison:
Here results are throughput (compilations per 1000 sec)
Threads:   passive+perf		   passive+sug		   active+perf+perf	   active+ps+perf	   active+ps+bln_perf	   active+ps+bln_pwr	   active+ps+pwr
  192	   1.00 (0.00 pct)	   0.93 (-7.00 pct)	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   0.87 (-13.00 pct)	   0.81 (-19.00 pct)	   0.71 (-29.00 pct)
git-source power comparison:
Threads:   passive+perf		   passive+sug		   active+perf+perf	   active+ps+perf	   active+ps+bln_perf	   active+ps+bln_pwr	   active+ps+pwr
  192	   1.00 (0.00 pct)	   1.03 (3.00 pct)	   1.03 (3.00 pct)	   1.03 (3.00 pct)	   1.02 (2.00 pct)	   1.06 (6.00 pct)	   1.13 (13.00 pct)

================ kernbench ================
kernbench result comparison:
Here results are throughput (compilations per 1000 sec)
Load:	   passive+perf		   passive+sug		   active+perf+perf	   active+ps+perf	   active+ps+bln_perf	   active+ps+bln_pwr	   active+ps+pwr
32	   1.00 (0.00 pct)	   0.94 (-6.00 pct)	   0.97 (-3.00 pct)	   1.01 (1.00 pct)	   0.77 (-23.00 pct)	   0.64 (-36.00 pct)	   0.52 (-48.00 pct)
48	   1.25 (0.00 pct)	   1.20 (-4.00 pct)	   1.25 (0.00 pct)	   1.24 (-0.80 pct)	   0.96 (-23.20 pct)	   0.80 (-36.00 pct)	   0.66 (-47.20 pct)
64	   1.41 (0.00 pct)	   1.37 (-2.83 pct)	   1.40 (-0.70 pct)	   1.43 (1.41 pct)	   1.09 (-22.69 pct)	   0.92 (-34.75 pct)	   0.74 (-47.51 pct)
96	   1.45 (0.00 pct)	   1.40 (-3.44 pct)	   1.44 (-0.68 pct)	   1.44 (-0.68 pct)	   1.22 (-15.86 pct)	   1.05 (-27.58 pct)	   0.93 (-35.86 pct)
128	   1.36 (0.00 pct)	   1.23 (-9.55 pct)	   1.33 (-2.20 pct)	   1.35 (-0.73 pct)	   1.12 (-17.64 pct)	   0.98 (-27.94 pct)	   0.84 (-38.23 pct)
192	   1.22 (0.00 pct)	   1.12 (-8.19 pct)	   1.21 (-0.81 pct)	   1.21 (-0.81 pct)	   1.02 (-16.39 pct)	   0.91 (-25.40 pct)	   0.79 (-35.24 pct)
256	   1.21 (0.00 pct)	   1.10 (-9.09 pct)	   1.21 (0.00 pct)	   1.21 (0.00 pct)	   1.01 (-16.52 pct)	   0.90 (-25.61 pct)	   0.78 (-35.53 pct)
384	   1.22 (0.00 pct)	   1.09 (-10.65 pct)	   1.21 (-0.81 pct)	   1.21 (-0.81 pct)	   1.01 (-17.21 pct)	   0.90 (-26.22 pct)	   0.79 (-35.24 pct)
git-source power comparison:
Clients:   passive+perf		   passive+sug		   active+perf+perf	   active+ps+perf	   active+ps+bln_perf	   active+ps+bln_pwr       active+ps+pwr
   32	   1.00 (0.00 pct)	   1.06 (6.00 pct)	   1.02 (2.00 pct)	   1.00 (0.00 pct)	   1.03 (3.00 pct)	   1.16 (16.00 pct)	   1.39 (39.00 pct)
   48	   0.87 (0.00 pct)	   0.88 (1.14 pct)	   0.87 (0.00 pct)	   0.87 (0.00 pct)	   0.89 (2.29 pct)	   0.98 (12.64 pct)	   1.11 (27.58 pct)
   64	   0.80 (0.00 pct)	   0.79 (-1.25 pct)	   0.80 (0.00 pct)	   0.80 (0.00 pct)	   0.78 (-2.50 pct)	   0.86 (7.50 pct)	   1.03 (28.75 pct)
   96	   0.79 (0.00 pct)	   0.81 (2.53 pct)	   0.79 (0.00 pct)	   0.79 (0.00 pct)	   0.78 (-1.26 pct)	   0.87 (10.12 pct)	   0.95 (20.25 pct)
  128	   0.80 (0.00 pct)	   0.86 (7.50 pct)	   0.82 (2.50 pct)	   0.80 (0.00 pct)	   0.86 (7.50 pct)	   0.91 (13.75 pct)	   1.03 (28.75 pct)
  192	   0.89 (0.00 pct)	   0.96 (7.86 pct)	   0.89 (0.00 pct)	   0.89 (0.00 pct)	   0.96 (7.86 pct)	   1.00 (12.35 pct)	   1.12 (25.84 pct)
  256	   0.89 (0.00 pct)	   0.95 (6.74 pct)	   0.89 (0.00 pct)	   0.89 (0.00 pct)	   0.96 (7.86 pct)	   1.00 (12.35 pct)	   1.12 (25.84 pct)
  384	   0.89 (0.00 pct)	   0.95 (6.74 pct)	   0.90 (1.12 pct)	   0.90 (1.12 pct)	   0.95 (6.74 pct)	   1.00 (12.35 pct)	   1.11 (24.71 pct)

================ tbench ================
tbench result comparison:
Here results are throughput (MB/s)
Clients:   passive+perf		   passive+sug		   active+perf+perf	   active+ps+perf	   active+ps+bln_perf	   active+ps+bln_pwr       active+ps+pwr
    1	   1.00 (0.00 pct)	   0.52 (-48.00 pct)	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   0.76 (-24.00 pct)	   0.64 (-36.00 pct)	   0.51 (-49.00 pct)
    2	   1.97 (0.00 pct)	   1.03 (-47.71 pct)	   2.01 (2.03 pct)	   2.00 (1.52 pct)	   1.52 (-22.84 pct)	   1.27 (-35.53 pct)	   1.02 (-48.22 pct)
    4	   3.85 (0.00 pct)	   2.03 (-47.27 pct)	   3.91 (1.55 pct)	   3.91 (1.55 pct)	   2.95 (-23.37 pct)	   2.49 (-35.32 pct)	   2.01 (-47.79 pct)
    8	   7.47 (0.00 pct)	   4.01 (-46.31 pct)	   7.48 (0.13 pct)	   7.56 (1.20 pct)	   5.73 (-23.29 pct)	   4.88 (-34.67 pct)	   3.93 (-47.38 pct)
   16	  14.12 (0.00 pct)	   7.71 (-45.39 pct)	  14.75 (4.46 pct)	  14.49 (2.62 pct)	  11.13 (-21.17 pct)	   9.37 (-33.64 pct)	   7.69 (-45.53 pct)
   32	  27.87 (0.00 pct)	  14.96 (-46.32 pct)	  27.86 (-0.03 pct)	  27.31 (-2.00 pct)	  21.32 (-23.50 pct)	  17.82 (-36.06 pct)	  14.45 (-48.15 pct)
   64	  46.26 (0.00 pct)	  31.86 (-31.12 pct)	  45.56 (-1.51 pct)	  45.99 (-0.58 pct)	  36.14 (-21.87 pct)	  31.36 (-32.20 pct)	  24.86 (-46.26 pct)
  128	  50.68 (0.00 pct)	  51.09 (0.80 pct)	  50.68 (0.00 pct)	  50.54 (-0.27 pct)	  50.63 (-0.09 pct)	  50.34 (-0.67 pct)	  50.69 (0.01 pct)
  256	 119.57 (0.00 pct)	 120.07 (0.41 pct)	 119.35 (-0.18 pct)	 118.02 (-1.29 pct)	 114.58 (-4.17 pct)	 117.70 (-1.56 pct)	 114.71 (-4.06 pct)
  512	 115.18 (0.00 pct)	 115.93 (0.65 pct)	 114.90 (-0.24 pct)	 115.69 (0.44 pct)	 115.02 (-0.13 pct)	 115.71 (0.46 pct)	 115.21 (0.02 pct)
tbench power comparison:
Clients:   passive+perf		   passive+sug		   active+perf+perf	   active+ps+perf	   active+ps+bln_perf	   active+ps+bln_pwr       active+ps+pwr
    1	   1.00 (0.00 pct)	   0.90 (-10.00 pct)	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   0.92 (-8.00 pct)	   0.90 (-10.00 pct)	   0.89 (-11.00 pct)
    2	   1.02 (0.00 pct)	   0.90 (-11.76 pct)	   1.02 (0.00 pct)	   1.03 (0.98 pct)	   0.93 (-8.82 pct)	   0.91 (-10.78 pct)	   0.90 (-11.76 pct)
    4	   1.08 (0.00 pct)	   0.92 (-14.81 pct)	   1.09 (0.92 pct)	   1.09 (0.92 pct)	   0.97 (-10.18 pct)	   0.94 (-12.96 pct)	   0.92 (-14.81 pct)
    8	   1.21 (0.00 pct)	   0.96 (-20.66 pct)	   1.21 (0.00 pct)	   1.22 (0.82 pct)	   1.03 (-14.87 pct)	   0.98 (-19.00 pct)	   0.96 (-20.66 pct)
   16	   1.44 (0.00 pct)	   1.04 (-27.77 pct)	   1.46 (1.38 pct)	   1.46 (1.38 pct)	   1.16 (-19.44 pct)	   1.08 (-25.00 pct)	   1.03 (-28.47 pct)
   32	   1.87 (0.00 pct)	   1.26 (-32.62 pct)	   1.88 (0.53 pct)	   1.87 (0.00 pct)	   1.39 (-25.66 pct)	   1.24 (-33.68 pct)	   1.16 (-37.96 pct)
   64	   2.41 (0.00 pct)	   1.98 (-17.84 pct)	   2.39 (-0.82 pct)	   2.40 (-0.41 pct)	   1.69 (-29.87 pct)	   1.47 (-39.00 pct)	   1.35 (-43.98 pct)
  128	   2.59 (0.00 pct)	   2.60 (0.38 pct)	   2.59 (0.00 pct)	   2.60 (0.38 pct)	   2.57 (-0.77 pct)	   2.56 (-1.15 pct)	   2.57 (-0.77 pct)
  256	   3.17 (0.00 pct)	   3.17 (0.00 pct)	   3.17 (0.00 pct)	   3.17 (0.00 pct)	   3.12 (-1.57 pct)	   3.15 (-0.63 pct)	   3.12 (-1.57 pct)
  512	   3.18 (0.00 pct)	   3.18 (0.00 pct)	   3.18 (0.00 pct)	   3.18 (0.00 pct)	   3.16 (-0.62 pct)	   3.16 (-0.62 pct)	   3.16 (-0.62 pct)

> 
> changes from v9:
>  * pick up R-B flas added by Mario
>  * pick up R-B flag added by Wyes
>  * rename "default_pstate_driver" to "current_pstate_driver"
>  * update status string to "disable" when driver disabled and update size check
>  * move the common macro definition of EPP to cppc library files for intel_pstate and amd_pstate common using
>  * fix some doc words for new global sysfs patch
> 
> changes from v8:
>  * drive all the feedbacks from Mario and change the codes in this
>   version
>  * drive all the feedbacks from Ray and change the codes in this
>   version
>  * pick up all the R-B flags from Mario
>  * pick up all the R-B flags from Ray
>  * drop boost/refresh_freq_limits callback
>  * reuse policy->driver_data to store amd_cpudata struct
>  * use switch-case in the driver mode switching function
>  * add Kconfig dependency the INTEL_PSTATE for AMD_PSTATE build
>  * fix some other code format and typos
> 
> changes from v7:
>  * remove  iowait boost functions code
>  * pick up ack by flag from Huang Ray.
>  * add one new patch to support multiple working modes in the amd_pstate_param(),aligned with Wyse 
>  * drop the patch "[v7 08/13] cpufreq: amd-pstate: add frequency dynamic boost sysfs control"
>  * replace the cppc_get_epp_caps() with new cppc_get_epp_perf() wihch is
>    more simple to use
>  * remove I/O wait boost code from amd_pstate_update_status()
>  * replace cppc_active var with enum type AMD_PSTATE_ACTIVE
>  * squash amd_pstate_epp_verify_policy() into sigle function
>  * remove "amd pstate" string from the pr_err, pr_debug logs info
>  * rework patch [v7 03/13], move the common EPP profiles declaration
>    into cpufreq.h which will be used by amd-pstate and intel-pstate
>  * combine amd psate init functions.
>  * remove epp_powersave from amd-pstate.h and dropping the codes.
>  * move amd_pstate_params{} from amd-pstate.h into amd-pstate.c
>  * drive some other feedbacks from huang ray 
> 
> changes from v6:
>  * fix one legacy kernel hang issue when amd-pstate driver unregistering
>  * add new documentation to introduce new global sysfs attributes
>  * use sysfs_emit_at() to print epp profiles array
>  * update commit info for patch v6 patch 1/11 as Mario sugguested.
>  * trying to add the EPP profiles into cpufreq.h, but it will cause lots
>    of build failues,continue to keep cpufreq_common.h used in v7
>  * update commit info using amd-pstate as prefix same as before.
>  * remove CONFIG_ACPI for the header as Ray suggested.
>  * move amd_pstate_kobj to where it is used in patch "add frequency dynamic boost sysfs control"
>  * drive feedback removing X86_FEATURE_CPPC check for the epp init from Huang Ray 
>  * drive feedback from Mario
>  
> change from v5:
>  * add one common header `cpufreq_commoncpufreq_common` to extract EPP profiles 
>    definition for amd and intel pstate driver.
>  * remove the epp_off value to avoid confusion.
>  * convert some other sysfs sprintf() function with sysfs_emit() and add onew new patch
>  * add acpi pm server priofile detection to enable dynamic boost control
>  * fix some code format with checkpatch script
>  * move the EPP profile declaration into common header file `cpufreq_common.h`
>  * fix commit typos
> 
> changes from v4:
>  * rebase driver based on the v6.1-rc7
>  * remove the builtin changes patch because pstate driver has been
>    changed to builtin type by another thread patch
>  * update Documentation: amd-pstate: add amd pstate driver mode introduction 
>  * replace sprintf with sysfs_emit() instead.
>  * fix typo for cppc_set_epp_perf() in cppc_acpi.h header
> 
> changes from v3:
>  * add one more document update patch for the active and passive mode
>    introducion.
>  * drive most of the feedbacks from Mario
>  * drive feedback from Rafael for the cppc_acpi driver.
>  * remove the epp raw data set/get function
>  * set the amd-pstate drive by passing kernel parameter
>  * set amd-pstate driver disabled by default if no kernel parameter
>    input from booting
>  * get cppc_set_auto_epp and cppc_set_epp_perf combined
>  * pick up reviewed by flag from Mario
> 
> changes from v2:
>  * change pstate driver as builtin type from module
>  * drop patch "export cpufreq cpu release and acquire"
>  * squash patch of shared mem into single patch of epp implementation
>  * add one new patch to support frequency boost control
>  * add patch to expose driver working status checking
>  * rebase driver into v6.1-rc4 kernel release
>  * move some declaration to amd-pstate.h
>  * drive feedback from Mario for the online/offline patch
>  * drive feedback from Mario for the suspend/resume patch
>  * drive feedback from Ray for the cppc_acpi and some other patches
>  * drive feedback from Nathan for the epp patch
> 
> changes from v1:
>  * rebased to v6.0
>  * drive feedbacks from Mario for the suspend/resume patch
>  * drive feedbacks from Nathan for the EPP support on msr type
>  * fix some typos and code style indent problems
>  * update commit comments for patch 4/7
>  * change the `epp_enabled` module param name to `epp`
>  * set the default epp mode to be false
>  * add testing for the x86_energy_perf_policy utility patchset(will
>    send that utility patchset with another thread)
> 
> v9: https://lore.kernel.org/lkml/20221225163442.2205660-1-perry.yuan@amd.com/
> v8: https://lore.kernel.org/lkml/20221219064042.661122-1-perry.yuan@amd.com/
> v7: https://lore.kernel.org/lkml/20221208111852.386731-1-perry.yuan@amd.com/
> v6: https://lore.kernel.org/lkml/20221202074719.623673-1-perry.yuan@amd.com/
> v5: https://lore.kernel.org/lkml/20221128170314.2276636-1-perry.yuan@amd.com/
> v4: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd.com/
> v3: https://lore.kernel.org/all/20221107175705.2207842-1-Perry.Yuan@amd.com/
> v2: https://lore.kernel.org/all/20221010162248.348141-1-Perry.Yuan@amd.com/
> v1: https://lore.kernel.org/all/20221009071033.21170-1-Perry.Yuan@amd.com/
> 
> Perry Yuan (11):
>   ACPI: CPPC: Add AMD pstate energy performance preference cppc control
>   Documentation: amd-pstate: add EPP profiles introduction
>   cpufreq: intel_pstate: use common macro definition for Energy
>     Preference Performance(EPP)
>   cpufreq: amd-pstate: implement Pstate EPP support for the AMD
>     processors
>   cpufreq: amd-pstate: implement amd pstate cpu online and offline
>     callback
>   cpufreq: amd-pstate: implement suspend and resume callbacks
>   cpufreq: amd-pstate: add driver working mode switch support
>   Documentation: amd-pstate: add amd pstate driver mode introduction
>   Documentation: introduce amd pstate active mode kernel command line
>     options
>   cpufreq: amd-pstate: convert sprintf with sysfs_emit()
>   Documentation: amd-pstate: introduce new global sysfs attributes
> 
> Wyes Karny (1):
>   cpufreq: amd-pstate: optimize driver working mode selection in
>     amd_pstate_param()
> 
>  .../admin-guide/kernel-parameters.txt         |   7 +
>  Documentation/admin-guide/pm/amd-pstate.rst   |  74 +-
>  drivers/acpi/cppc_acpi.c                      |  96 +++
>  drivers/cpufreq/amd-pstate.c                  | 659 +++++++++++++++++-
>  drivers/cpufreq/intel_pstate.c                |  36 -
>  include/acpi/cppc_acpi.h                      |  22 +
>  include/linux/amd-pstate.h                    |  28 +
>  7 files changed, 865 insertions(+), 57 deletions(-)
> 

-- 
Thanks & Regards,
Wyes
