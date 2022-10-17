Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284A5600647
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 07:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJQF20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 01:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJQF2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 01:28:21 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D653537F8;
        Sun, 16 Oct 2022 22:28:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgauU5n6kXkfWzHwmt3qvLcdK+yxp6pY6lcfCjsGBK2foTc4+8ZUtLZj9B6fLFcAnwaDXHGBCIsJee5sr1LdzMZ7dSngUOTVjoWU3CWdGDiDN9YHThKi+nABmdqHj0krh4NNEk1H+K5F7toeReo7qf8Zq2LI5U8blIsQ0d93sdvxkVCYpNT4VrUh+UfLiRba7zzgtuKf1ZOZ5/lLzKCvjO/jBU5lA0JKEZBpGP21Qt3j1juaJCm7f0DFWo1NB1iUja3n0dgVfN7jzmeVJL9wGssCeWBaOXEScHDVtNbIHGiv9s7MWJBWiJzEwm3CCmTPxxmFKTlW4uIGIxuX1NL4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pa9h+hH7uoalqYsMPBTPd1rbY3qPsmsLi5QyhWN5rtc=;
 b=TEwR0H9n1AC/eSNoVX/ZLWygsvux7MLJ1BgDrBttab7AvPEq/qBhHxuDmbImQcI19Gp2Jv4mJT05gBU3fUdeicJiFeLIncS6iTibXVLwG9HfkW7TZk6RxHL+BT44F8DDIxnYL8rlqRJH1tDUVO8KlO3Uhw0tVojgCcoRzpSk6767ufL1T0xcmxtNHwW4KR/PFMx5qVZwKNq3dNgxIev+B8h/txh2M2IJaFIRNAMqcIzoUlh5e+3eoymiW5qVQspX6mGkhmzreyX8kNdZbBc/DbqHN5G3CCSFaUpb+iXHqOhczotQW1KLJnvRmiccpbX+6CFx8BaGnS/gP0dqyW7Yrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pa9h+hH7uoalqYsMPBTPd1rbY3qPsmsLi5QyhWN5rtc=;
 b=0Xy2LorFRWFg7bFjslatBOUsZXMFK3aLrssL4tX21B4Q8kViuAsy6HVHcc4asROD1uC5STBTJB5u6rOrHlBHio7KZMVkKekI6NStcUI7j55ImA/QP1lHgUVrg8jXdrqSeOjtIroMYJ+gtX8wOFKTBoPkE0OqpkpS49aD3HH/FSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.29; Mon, 17 Oct 2022 05:28:17 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 05:28:16 +0000
Date:   Mon, 17 Oct 2022 13:27:55 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 4/4] Documentation: amd-pstate: Add tbench and
 gitsource test introduction
Message-ID: <Y0zn201GVPuR/RNi@amd.com>
References: <20220914061105.1982477-1-li.meng@amd.com>
 <20220914061105.1982477-5-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914061105.1982477-5-li.meng@amd.com>
X-ClientProxiedBy: TYAPR01CA0148.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::16) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 607b9698-024b-4429-6f15-08dab00064e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJTBit8nA6sD1QfJRzurGZNATE+xwPGOvuykLbgjlJTZFpEwW8la/9PZRdkHMrcFSi+d4PMn9cBIY9qdZIaXcOk70gcVfEf4stOs50NYo0IWCU/DmgP2YmRMV3dpceES9Aao5ItFFD8QAWd94EWjnFxbCOtOPEMcprSVkcdC6F5O/Mn8sJLeJw7QtLZ8xN9KCOJeVb7tP+KuWSmd/71m8uYTGYYbH8KOE6KUdmfHgH0/JHHob2jLUO0NF5a83OA+VPhm1kNrw6mJlfFD3I66K6npMsdoT8/p9N7ktJTAQw0TMHeBzlI++UbYEL1yDsO+5nfCANVd2PXg4nrhXKpj5Rf59+3Hsmg3jgpySUcK8i+ZWAs1P8ohxYlrRQw7lNhLx5lWi/7o1cKmKWFCRwqvdoyVbQCpPboh5uIjjtK45ZX4PYRY2OWrDvbXbRmh6IL5Pis73QhzY7MtnOpoM0d5CJ459IYrFKsdZSRDV/0qSa1QOXhzp61zmU7fOK/VXD5/C1tQxPLVQaZV4dsaqruQBIGYwzeWfsFOq6OJrRTsVXaVKTjlrfl+eOh8QLAVhMUcXsBVw+2CCiD/mQ95pq7U8lcgD9raxVTV0zfPFiOo1hVtQiE0/LQiVEkpvwETgusXeIX9vQo6FCKGSWKM3cziAUOjqF+K1hRUklHVLOe0P8o4k4vdA2r5dXDrKAebAxN+8xifXhm8OTtIFgd4Dv7i7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199015)(38100700002)(6486002)(478600001)(2616005)(186003)(316002)(8676002)(4326008)(54906003)(66946007)(66476007)(66556008)(37006003)(6636002)(6666004)(6506007)(5660300002)(36756003)(26005)(41300700001)(6512007)(6862004)(8936002)(30864003)(86362001)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C27krD2m26x6Mt1Vpw6HyqW6X/MNefTtuREFAicnbubB4PNRumoF7bjlt94M?=
 =?us-ascii?Q?RLTZIaMa79trP/24s96ABLzLD6z4nytgXQkDeifcUz9FjYvnImI1DpunCPZy?=
 =?us-ascii?Q?UR6+MkpNJPC5zZvwowfHqD7ZlnXeUL6tpMqqzSDnCldFlbWCwpqNmHO9j0v4?=
 =?us-ascii?Q?0rH07w9UkFLjYxCxdhMKYiZPwceYEFwdZ46nhlfnVUV5ThbqjiQhF1fLrkSt?=
 =?us-ascii?Q?6btKrP/weCAWSA3agqgahseUYsiQhDU6FVfwEdGv1z48RaGcU52GNCBdCPz+?=
 =?us-ascii?Q?mcvv6HuUwWDlqJFMAV4j5kWdL35i2kGQX2lxbxpwzWAPPVLvICt1Q2TlnVnp?=
 =?us-ascii?Q?jKTWr7gFoQdtVfs0zZ5ZQugB3SDSLMrd2YMMYsXo5/HjNsfHuFnJm92b36dn?=
 =?us-ascii?Q?/fnYLDYX0uqElNXnmK6iYrTCzFTdlaEZP8FmHBfNXRVsVrL2timcmXiCCe7P?=
 =?us-ascii?Q?rKWZyufDaRHYADUA4SDADfE3oonDvuX3LybwT62pKKHE4JnCzdkaVd5T7sjX?=
 =?us-ascii?Q?Z6i0Js2DTHK72Jfnf3WtRJqmzAHiTvQ1Eh9Ly1KKfSMkXJMkusWTd9c/FpUE?=
 =?us-ascii?Q?AUW/rBnH2UpWTS/yHW+EOYVF+enNbJgfszisJ5DDcpHuAQO4tOw7h0Be18lT?=
 =?us-ascii?Q?AxAXNpoKyAzX5Mq0oKaETho67z9Oo8efmf30rCQk66D0QM+uYxRF47FyU4Nl?=
 =?us-ascii?Q?As0XgqC3md3phmNadVtVo/5DAITxFj+Fu6w/2USK9ZMny8aOZFQ/XDcq64mU?=
 =?us-ascii?Q?Z7IPsk4Xp+yc/ypZI6N5jGNtN8Pt1jcx3qJAfw2c0MKve+XCYaeP8LtHS7Bu?=
 =?us-ascii?Q?DNSDcHUMY0cyESb4qOA9DTXcTfRWVcD6W91VmGZ7FRZCYgK5/m34lStkTErp?=
 =?us-ascii?Q?PkmBwpP3wPGYV2RvHY/AaJmlWuIj/NvWrgNBgnIcLObFM9Y/+a69/xL3CN+k?=
 =?us-ascii?Q?ig8KgvNxYf9qFClLNHyZ9l5HR5clbTQ2wWoTb4DwsscofULfbK9R7IMSG2eK?=
 =?us-ascii?Q?6bXorbJ8wUFAEnlReficQupcJ/ibwlHIeV7wfricrQBBQekWKyb/vymkrR7V?=
 =?us-ascii?Q?xkXlqJYZKWLnPtgqq9epNFe1aIXrr1TSMY4vh2DIgq1a50TzINv3oQztL62e?=
 =?us-ascii?Q?hNXRzGIk45cOEvWkN5EGUxGP0h225oE7JXC1+EvFBEuojg7Wf4IePILpxa52?=
 =?us-ascii?Q?9DR2WXg9zEFVD27iUwcBWUvcodBdwjH1hiDHNrzX1zs+rAz5w9YRJqnNAnLk?=
 =?us-ascii?Q?/TgFja6dJ9LWVlFur1J7HWAYbBqT/OOfrTBTZwjT4CR2R0rINsRt2isuITas?=
 =?us-ascii?Q?yWmj9LQCV4CQTQ6xwMFJhmRlgjDZqQ2eOEkujBZHCoqSeK3HpXBe8qn8qcoj?=
 =?us-ascii?Q?sjBGVm1G5TT9IujWHIiydTN3EVKgzC3Y80WFM3ALbcSoGkgcw/JU8PkKSrlB?=
 =?us-ascii?Q?FvwDmoyDV+oKuuS/ihy+oMHDLW7rC1eBe08XqFlEyq2lPDZjKtrwiPK39AEQ?=
 =?us-ascii?Q?YcMIkfDWjaJiYs5iNB/e8jx43+432jX/k5+CYlDJAivdE30W+IXX3k0z8Qjn?=
 =?us-ascii?Q?3KkDZCPzQwa3WdHN8ULIa1WfaHs/30Nh35L3DNWY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607b9698-024b-4429-6f15-08dab00064e8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 05:28:16.8445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72glk1cu6FJzQ0yyWE5S/F/RlB12DzOivrolivUJAWUzjHB8Osig5vghMBmNJy2KceoGlwTJdpq839YprcL0AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 02:11:05PM +0800, Meng, Li (Jassmine) wrote:
> Introduce tbench and gitsource test cases design and implementation.
> Monitor cpus changes about performance and power consumption etc.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 192 ++++++++++++++++++--
>  1 file changed, 173 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 8f3d30c5a0d8..6dda74ad717c 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -409,37 +409,55 @@ Unit Tests for amd-pstate
>  
>  1. Test case decriptions
>  
> +    1). basic tests

basic -> Basic

> +
> +        Test prerequisite and basic functions for the ``amd-pstate`` driver.
> +
>          +---------+--------------------------------+------------------------------------------------------------------------------------+
>          | Index   | Functions                      | Description                                                                        |
>          +=========+================================+====================================================================================+
> -        | 0       | amd_pstate_ut_acpi_cpc_valid   || Check whether the _CPC object is present in SBIOS.                                |
> +        | 1       | amd_pstate_ut_acpi_cpc_valid   || Check whether the _CPC object is present in SBIOS.                                |
>          |         |                                ||                                                                                   |
>          |         |                                || The detail refer to `Processor Support <processor_support_>`_.                    |
>          +---------+--------------------------------+------------------------------------------------------------------------------------+
> -        | 1       | amd_pstate_ut_check_enabled    || Check whether AMD P-State is enabled.                                             |
> +        | 2       | amd_pstate_ut_check_enabled    || Check whether AMD P-State is enabled.                                             |
>          |         |                                ||                                                                                   |
>          |         |                                || AMD P-States and ACPI hardware P-States always can be supported in one processor. |
>          |         |                                | But AMD P-States has the higher priority and if it is enabled with                 |
>          |         |                                | :c:macro:`MSR_AMD_CPPC_ENABLE` or ``cppc_set_enable``, it will respond to the      |
>          |         |                                | request from AMD P-States.                                                         |
>          +---------+--------------------------------+------------------------------------------------------------------------------------+
> -        | 2       | amd_pstate_ut_check_perf       || Check if the each performance values are reasonable.                              |
> +        | 3       | amd_pstate_ut_check_perf       || Check if the each performance values are reasonable.                              |
>          |         |                                || highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0.           |
>          +---------+--------------------------------+------------------------------------------------------------------------------------+
> -        | 3       | amd_pstate_ut_check_freq       || Check if the each frequency values and max freq when set support boost mode       |
> +        | 4       | amd_pstate_ut_check_freq       || Check if the each frequency values and max freq when set support boost mode       |
>          |         |                                | are reasonable.                                                                    |
>          |         |                                || max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0                   |
>          |         |                                || If boost is not active but supported, this maximum frequency will be larger than  |
>          |         |                                | the one in ``cpuinfo``.                                                            |
>          +---------+--------------------------------+------------------------------------------------------------------------------------+
>  
> +    2). Tbench test
> +
> +        Test and monitor the cpu changes when running tbench benchmark under the specified governor.
> +        These changes include desire performance, frequency, load, performance, energy etc.
> +        The specified governor is ondemand or schedutil.
> +        Tbench can also be tested on the acpi-cpufreq kernel driver for comparison.

let's align the same format in this document. 

acpi-cpufreq -> ``acpi-cpufreq``
amd-pstate-ut -> ``amd-pstate-ut``

Others look good for me.

Thanks,
Ray

> +
> +    3). Gitsource test
> +
> +        Test and monitor the cpu changes when running gitsource benchmark under the specified governor.
> +        These changes include desire performance, frequency, load, time, energy etc.
> +        The specified governor is ondemand or schedutil.
> +        Gitsource can also be tested on the acpi-cpufreq kernel driver for comparison.
> +
>  #. How to execute the tests
>  
>     We use test module in the kselftest frameworks to implement it.
>     We create amd-pstate-ut module and tie it into kselftest.(for
>     details refer to Linux Kernel Selftests [4]_).
>  
> -    1. Build
> +    1). Build
>  
>          + open the :c:macro:`CONFIG_X86_AMD_PSTATE` configuration option.
>          + set the :c:macro:`CONFIG_X86_AMD_PSTATE_UT` configuration option to M.
> @@ -449,23 +467,159 @@ Unit Tests for amd-pstate
>              $ cd linux
>              $ make -C tools/testing/selftests
>  
> -    #. Installation & Steps ::
> +        + make perf ::
> +
> +            $ cd tools/perf/
> +            $ make
> +
> +
> +    2). Installation & Steps ::
>  
>          $ make -C tools/testing/selftests install INSTALL_PATH=~/kselftest
> +        $ cp tools/perf/perf /user/bin/perf
>          $ sudo ./kselftest/run_kselftest.sh -c amd-pstate
> -        TAP version 13
> -        1..1
> -        # selftests: amd-pstate: amd-pstate-ut.sh
> -        # amd-pstate-ut: ok
> -        ok 1 selftests: amd-pstate: amd-pstate-ut.sh
> -
> -    #. Results ::
> -
> -         $ dmesg | grep "amd_pstate_ut" | tee log.txt
> -         [12977.570663] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
> -         [12977.570673] amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
> -         [12977.571207] amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
> -         [12977.571212] amd_pstate_ut: 4    amd_pstate_ut_check_freq      success!
> +
> +    3). Specified test case ::
> +
> +        $ cd ~/kselftest/amd-pstate
> +        $ sudo ./run.sh -t basic
> +        $ sudo ./run.sh -t tbench
> +        $ sudo ./run.sh -t tbench -m acpi-cpufreq
> +        $ sudo ./run.sh -t gitsource
> +        $ sudo ./run.sh -t gitsource -m acpi-cpufreq
> +        $ ./run.sh --help
> +        ./run.sh: illegal option -- -
> +        Usage: ./run.sh [OPTION...]
> +                [-h <help>]
> +                [-o <output-file-for-dump>]
> +                [-c <all: All testing,
> +                     basic: Basic testing,
> +                     tbench: Tbench testing,
> +                     gitsource: Gitsource testing.>]
> +                [-t <tbench time limit>]
> +                [-p <tbench process number>]
> +                [-l <loop times for tbench>]
> +                [-i <amd tracer interval>]
> +                [-m <comparative test: acpi-cpufreq>]
> +
> +
> +    4). Results
> +
> +        + basic
> +
> +         When you finish test, you will get the following log info ::
> +
> +          $ dmesg | grep "amd_pstate_ut" | tee log.txt
> +          [12977.570663] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
> +          [12977.570673] amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
> +          [12977.571207] amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
> +          [12977.571212] amd_pstate_ut: 4    amd_pstate_ut_check_freq      success!
> +
> +        + tbench
> +
> +         When you finish test, you will get selftest.tbench.csv and png images.
> +         The selftest.tbench.csv file contains the raw data and the drop of the comparative test.
> +         The png images shows the performance, energy and performan per watt of each test.
> +         Open selftest.tbench.csv :
> +
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + Governor                                        | Round        | Des-perf | Freq    | Load     | Performance | Energy  | Performance Per Watt |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + Unit                                            |              |          | GHz     |          | MB/s        | J       | MB/J                 |
> +         +=================================================+==============+==========+=========+==========+=============+=========+======================+
> +         + amd-pstate-ondemand                             | 1            |          |         |          | 2504.05     | 1563.67 | 158.5378             |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + amd-pstate-ondemand                             | 2            |          |         |          | 2243.64     | 1430.32 | 155.2941             |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + amd-pstate-ondemand                             | 3            |          |         |          | 2183.88     | 1401.32 | 154.2860             |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + amd-pstate-ondemand                             | Average      |          |         |          | 2310.52     | 1465.1  | 156.1268             |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + amd-pstate-schedutil                            | 1            | 165.329  | 1.62257 | 99.798   | 2136.54     | 1395.26 | 151.5971             |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + amd-pstate-schedutil                            | 2            | 166      | 1.49761 | 99.9993  | 2100.56     | 1380.5  | 150.6377             |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + amd-pstate-schedutil                            | 3            | 166      | 1.47806 | 99.9993  | 2084.12     | 1375.76 | 149.9737             |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + amd-pstate-schedutil                            | Average      | 165.776  | 1.53275 | 99.9322  | 2107.07     | 1383.84 | 150.7399             |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand                           | 1            |          |         |          | 2529.9      | 1564.4  | 160.0997             |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand                           | 2            |          |         |          | 2249.76     | 1432.97 | 155.4297             |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand                           | 3            |          |         |          | 2181.46     | 1406.88 | 153.5060             |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand                           | Average      |          |         |          | 2320.37     | 1468.08 | 156.4741             |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-schedutil                          | 1            |          |         |          | 2137.64     | 1385.24 | 152.7723             |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-schedutil                          | 2            |          |         |          | 2107.05     | 1372.23 | 152.0138             |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-schedutil                          | 3            |          |         |          | 2085.86     | 1365.35 | 151.2433             |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-schedutil                          | Average      |          |         |          | 2110.18     | 1374.27 | 152.0136             |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand VS acpi-cpufreq-schedutil | Comprison(%) |          |         |          | -9.0584     | -6.3899 | -2.8506              |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + amd-pstate-ondemand VS amd-pstate-schedutil     | Comprison(%) |          |         |          | 8.8053      | -5.5463 | -3.4503              |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand VS amd-pstate-ondemand    | Comprison(%) |          |         |          | -0.4245     | -0.2029 | -0.2219              |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-schedutil VS amd-pstate-schedutil  | Comprison(%) |          |         |          | -0.1473     | 0.6963  | -0.8378              |
> +         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
> +
> +        + gitsource
> +
> +         When you finish test, you will get selftest.gitsource.csv and png images.
> +         The selftest.gitsource.csv file contains the raw data and the drop of the comparative test.
> +         The png images shows the performance, energy and performan per watt of each test.
> +         Open selftest.gitsource.csv :
> +
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + Governor                                        | Round        | Des-perf | Freq     | Load     | Time        | Energy  | Performance Per Watt |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + Unit                                            |              |          | GHz      |          | s           | J       | 1/J                  |
> +         +=================================================+==============+==========+==========+==========+=============+=========+======================+
> +         + amd-pstate-ondemand                             | 1            | 50.119   | 2.10509  | 23.3076  | 475.69      | 865.78  | 0.001155027          |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + amd-pstate-ondemand                             | 2            | 94.8006  | 1.98771  | 56.6533  | 467.1       | 839.67  | 0.001190944          |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + amd-pstate-ondemand                             | 3            | 76.6091  | 2.53251  | 43.7791  | 467.69      | 855.85  | 0.001168429          |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + amd-pstate-ondemand                             | Average      | 73.8429  | 2.20844  | 41.2467  | 470.16      | 853.767 | 0.001171279          |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + amd-pstate-schedutil                            | 1            | 165.919  | 1.62319  | 98.3868  | 464.17      | 866.8   | 0.001153668          |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + amd-pstate-schedutil                            | 2            | 165.97   | 1.31309  | 99.5712  | 480.15      | 880.4   | 0.001135847          |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + amd-pstate-schedutil                            | 3            | 165.973  | 1.28448  | 99.9252  | 481.79      | 867.02  | 0.001153375          |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + amd-pstate-schedutil                            | Average      | 165.954  | 1.40692  | 99.2944  | 475.37      | 871.407 | 0.001147569          |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand                           | 1            |          |          |          | 2379.62     | 742.96  | 0.001345967          |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand                           | 2            |          |          |          | 441.74      | 817.49  | 0.001223256          |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand                           | 3            |          |          |          | 455.48      | 820.01  | 0.001219497          |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand                           | Average      |          |          |          | 425.613     | 793.487 | 0.001260260          |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-schedutil                          | 1            |          |          |          | 459.69      | 838.54  | 0.001192548          |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-schedutil                          | 2            |          |          |          | 466.55      | 830.89  | 0.001203528          |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-schedutil                          | 3            |          |          |          | 470.38      | 837.32  | 0.001194286          |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-schedutil                          | Average      |          |          |          | 465.54      | 835.583 | 0.001196769          |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand VS acpi-cpufreq-schedutil | Comprison(%) |          |          |          | 9.3810      | 5.3051  | -5.0379              |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + amd-pstate-ondemand VS amd-pstate-schedutil     | Comprison(%) | 124.7392 | -36.2934 | 140.7329 | 1.1081      | 2.0661  | -2.0242              |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand VS amd-pstate-ondemand    | Comprison(%) |          |          |          | 10.4665     | 7.5968  | -7.0605              |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
> +         + acpi-cpufreq-schedutil VS amd-pstate-schedutil  | Comprison(%) |          |          |          | 2.1115      | 4.2873  | -4.1110              |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
>  
>  Reference
>  ===========
> -- 
> 2.34.1
> 
