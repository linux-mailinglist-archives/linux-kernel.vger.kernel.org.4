Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E403266DFE1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjAQOEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjAQOE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:04:28 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E5938B78;
        Tue, 17 Jan 2023 06:04:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrlX9zzxoxgyIO34CDBsUCPoX5bjvzf7TjmtnmIiPpf/iAqWcfkLjd1d/rtvsr+YUBHj3gg+557sUA56xO6ejb9rfbxuReHZFpebuShYK1Wag0zI3a2jD5nmXxfANqEvDj0nryW8/jk3iU7xpWmNzRblPHM9FcIZNYiV1lALUVro3qXDjpQI54Yofey9JVYBExZ8CBIuoUg8JMpKAUOmC0X/1loLX8Rk/8z5Y+0mrf2T4s1BDMd4xrEKqurSQayBk2Zf6fWDiM7ZVBPpMdC0OBLEfq+BTRCXdobyRpQzQw0BLt5HgifSXKYkEvTnTZ474atlz7yj6ERKxlExJdbxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KKFSMLVyfiu3HenY4fJJ+Jtp/CWTtngd9uhFJIZUyI=;
 b=THha6yptwmvRoXcTjBpxKdk5NuSQZNLmEdG5FeVJWpt5ARtWi7be5xdO2xGX28B0ku/vhRE1dRkyQawWCea5U4TGyvJl4dr80aDzZQ+bo3rW+xFQiBH9psW+W2Z6wjDtjaycLVRYoEMYm0x4vj609W/5dup3yd34MD/G9HhDJ7pMI/dIXFAHrQMU47NgvZMQkP0e6c3BgY/VsmCTdd3Ygzn/m1PCMkTUvU3lc67DDYzsDOKGLd8ulnF1P1caE5dprfwSN97C1tepeBj0nWrz4+VUUIkT8yoosQum5KQQcgXXrtaYIGEOp5r5/Prev3ApKbLidDu+1/lFWYSDqHVfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KKFSMLVyfiu3HenY4fJJ+Jtp/CWTtngd9uhFJIZUyI=;
 b=FLdcS0oaLL67TOBzLSDb+UecRxwt9HvVKLlcvdudO6IGkEUsnC4n86C8Mmd9Sb/ITs9OxlVSHqB6zxMLOt5f4b136qVBWSmPjr9BBfFUvGnCzxd4aG7CKzMdLoyZaaznGpEhudbxwHf4svHvE+2rCKscUYqVOI1fzRTJrlbr/S8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 14:04:23 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::d17b:f929:12fd:8ae]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::d17b:f929:12fd:8ae%4]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 14:04:23 +0000
Date:   Tue, 17 Jan 2023 22:03:59 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 00/12] Implement AMD Pstate EPP Driver
Message-ID: <Y8aqzzBq2QliA0Zp@amd.com>
References: <20230106061420.95715-1-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106061420.95715-1-perry.yuan@amd.com>
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f58ba7-4b18-4aa3-2fdc-08daf893bc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7v8QB3agNl39a60Vsfdee9psxqNDapw0YjKKHa0/FjYFqqgEYE4SbOpWcdla5+XhCGoX2RL6LhHtikc2Eq4SWhdLxEF5DG9XfY68xHSN387x2HIa4b4Vem7bl+r4YuleBR9H5D6OpMcFQBUIQdJrFeRHxlaPVbPzH3SsVpbEnrj0ZixiraZcjuhp0hEUjQEcgo2Rf5KGXMgO3H/BcmvwzjD7OlLiZWl57eVKS1svkw04TezjShwHcT6G6Nx+jza41LR86Udk3juXPS7FQ7ExN0Z6+nUTpknDhjhOpLjwfS/e39AXwq1w4SkdWnsMzUFjkN0bkIHkbb3ttsfdA3XDik2uy0v7W3QA94nnMZrYblW0B/eI/rrQkAhYIkqn5XYR0CDnLP5Kx2YykCuI0zfXOR3WA2HsftDzZ41PvWPdVngGjttaIqngmpSVe26tSryMo1eMdbTyhWhjUybB5n5B7uA45k1tsXU4M/AWfuzF/SNp0GLu8sH+9LrZQ/lqg0rU9npFyg6mR5edgB0BP2ZQyBgMKlWXCwarzrxAuQIk5gFfdtQSjCKiCzUFxCpvi5/Yv8A7jlaTcFtwpjVnABVD2UtSgNMU2tjDsugO7he3ThLhvRCOWQadnF2BNCTLSY2GuVpvIQcPgMM7MvyzP0WrmGjsSbSoip9ZWXP2zdML9NiQe9ZLLGTkwqUseFqnLTdfEsFHCqSU/mwRU39ACtnAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(6862004)(8936002)(66946007)(41300700001)(66556008)(8676002)(66476007)(4326008)(6666004)(54906003)(37006003)(6636002)(36756003)(316002)(2616005)(30864003)(45080400002)(6512007)(2906002)(5660300002)(966005)(86362001)(478600001)(26005)(186003)(6506007)(83380400001)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JIGL24zbm6JopHvif9WNK1QEcU+43xmfOrY6u6jleWQ19hOyzWwiK7TDK/K0?=
 =?us-ascii?Q?Z6RIg96u28rrbgK0s25BEhkNGs4wpsORdg4YT5q+kOllBIaI/YQJRdDx3Apk?=
 =?us-ascii?Q?f26S45V6SEyZ8L6APigCijkhTp9uWbPtXdC9jNDDGCWj5LdicQNru1j++XZp?=
 =?us-ascii?Q?Nx/6jt3TnAAHe/k3M3vkOw5piedK26m6gRVbj77+2QdFVifgR5ULrK7eE2Cg?=
 =?us-ascii?Q?la69KhjTqNHhxq9OrpZKOKN/RUvwmkArccSpPfoMh9Kgvw7nvYWgC/5X9zwg?=
 =?us-ascii?Q?BCXYqMYrBEy/qzhlnPxxl2Q44ySwlR1T9AdHy2n01qPwTLhV+oEb7VyLLwMH?=
 =?us-ascii?Q?8NtuTDAcaaphdJCcFkE6NNQ8RGvtf133KtckXxJWRYKkGJfirO2e08O7REoI?=
 =?us-ascii?Q?04mFHlzHzy6a4jSkcSXDXOTnZ6Eszzd1WbfJeo2skUtjBFwQ6/b4Xt9CIqGN?=
 =?us-ascii?Q?3X9q9X/tbXuYOeseccNVPjj4sPh+BnW/tHOZchNCbh/JOKvfErVpbs7St2ab?=
 =?us-ascii?Q?zOxivs91bv1w0/zBZM6CBAb4l9TmDPbl7CE//HLHRCrHDFJo5X8KUbUID9e0?=
 =?us-ascii?Q?UmtT5Pzt6KPpM64JoMeYO8/mLX/Xxk8CPFanSgYn5TilX814eCRj/Jg6jY69?=
 =?us-ascii?Q?y21SOCCBSgQouh1JeGohBbARzvBTv1Yyhn44zuMnjou1wDMnpfykGrVug4ng?=
 =?us-ascii?Q?1vlX8YQRmkF7wiSCEb3/D0pLDYHnHmVdhtohTasP/kjPlmU4b6BCj06zv1jz?=
 =?us-ascii?Q?dnC227jS2A1XCzOutIYap5ZubAvxmgVkaH6HZgO4mLGMWIuz+5gYhc/SEh9m?=
 =?us-ascii?Q?cUTEO/OjCOK8zSR4/iLLEpydzgL2D934iqqTo3myVcDRpC/48ITvD1O1zSEt?=
 =?us-ascii?Q?ob+R4BOQEOy+yptZNkRgl+B9BEnFB40j7KrHTiA0404C7e3NrH4OJy/m6EYz?=
 =?us-ascii?Q?tGL1iT24TlN8IAoAKBAaP9Mk3qQAv3ySb86iorzdYlVCEk9oc/zwWGz7wWLR?=
 =?us-ascii?Q?zG0DsUG2RcqQ38sMsGJ3/iusUCvxEIZcKdbPor9mwVWt3k22jysbXDBKrrSk?=
 =?us-ascii?Q?nPPszLWc9yf4mf1GJ7nmTL7ZXRxUaHkhmV37hyIMy2augn3UvB1NKf4/xYCs?=
 =?us-ascii?Q?U/+wOqB3yhxvYTjFiBCNiXHfzaNjMRfYb4zRughOj9MhVAUMi4TzvnMeF+Va?=
 =?us-ascii?Q?sSiuStJ8NVZjSuMZFPJ9+Ahf3Ha4FQ0dLuU7PzCjxKRjcGovzpO61XznJxac?=
 =?us-ascii?Q?oVLqSqb77P/i+14IP7dWVIY0DhLBRweb7CqAXDBeV2uIOKHALTIphY6O3KIA?=
 =?us-ascii?Q?yP04dyTwb15AgmfV3TweTyrIhXNlZQKIcXBKFCCOJ6BSX2JSKrfndXQ2HFHr?=
 =?us-ascii?Q?z5H67hLfO/4KyXNfIvJkeqaW5MOZT2qHcjBwtxJ2t8SudmAHTfWLyN1dCTUC?=
 =?us-ascii?Q?eJ9SxAMouvwlitiDF9NImzm9Ly6sdpH1ihzDWyekfp7yanQWTztJ1XPlwdCR?=
 =?us-ascii?Q?/92T72uPM1Fm7TtB4vfoNtZPqGnSzdkAwtqHAXx+EJEDrQS3LLIkvO8AEYBe?=
 =?us-ascii?Q?r4WbK1Tn45tLPJJCHwr5GT9b7LJh4pUPAy0sclxn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f58ba7-4b18-4aa3-2fdc-08daf893bc56
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 14:04:23.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3H9f6gtGz/Y3yBjECMeTxuyiCQRO3EWYH1/kj/ap4LiNcng+o/RrPpYChoVaIc1Q5rIp70DYeR8lkSif9o6JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 02:14:08PM +0800, Yuan, Perry wrote:
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

Most of the patches look good for me, thanks!

Only patch 3, as Intel P-State actually won't use CPPC (won't expose _CPC
object in SBIOS), it may not be good to align the common definition in
acpi_cppc.h.

Thanks,
Ray

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
> -- 
> 2.34.1
> 
