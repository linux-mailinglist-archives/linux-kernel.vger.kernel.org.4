Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4671A60056A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 04:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiJQCsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 22:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiJQCsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 22:48:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F24B46DB0;
        Sun, 16 Oct 2022 19:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkTs8Ovw88JI8rjDEvmxU+CBK9nNGQ/iLG7F0Z/Hxs38JSzxKIZEOHmLHWH0MU3ZAgD1FnKfzskt+n0+O0xrHhGhXQ3xplAB9Ev37n6SqUYVLmZTWW4Pxc4uLja5BsGnUONBy7+PPbkjq82kynhsUP7CC458DTaEcjJHeShDXjYhVyLBoNs//EjgNHzlig8sBTUijw86o2AgRttC+2wrH7Co7kTWC7ergW4WaOAUm+jQYOu93x99s/Sp4TfK9Nz1/BTFQjkjbUbWFlycSLpe0RenNlvU/oSo0TvcVfxOs6jBHQ4Acpbc1Yv21jXWc8aC6EU5oOMNFw3OSCTpW1zDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGkCJgPA9vqN+LF+Pb9SLBpsMVgCQ4qfakeVP2t83yc=;
 b=YXxbOO2bfr2FwjihPQrvgp0mlL1tU4pAxjzY8G0JI+xyq1DmOVGdxvZI75bZbo+KgBLR/CTsy51YXACFyXg38zogZQiTDzh274y4cGWGoo68iWUtArygIrammbp8xdtu5dGPv0YqGB7d3HmSXH7PXHmNFRkBVQ2FoiJCPLmYWMUDm/Xr5nBWqgTxamnYubXRj2Dt8hNqUfA5nRIoidwcT3A/1ZxcnOaA4LhzuN5Xtske0rw+I0TcthH96ydNeifGEP26z1MXJVRNRL+mdQmZbYqjaP+qowq4rnnEowlH1QYEJvrpABxpPuNxqZhjFpuIOl3te8FKy29OHzUCGgHwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGkCJgPA9vqN+LF+Pb9SLBpsMVgCQ4qfakeVP2t83yc=;
 b=HPdk0ZvkfaPhJZ7xnLjLn1FcFcwnrcd8SISyVbaYIpBBCuLQqV3t6JQ+2Qa1+obs+yJzimXqwD6T6nCXX5OnXzgLdZG9Oji0qTIZIZf+Zn+tk4ZfKcuXvQM3cHVuxFITyMgMdTo5jTbIh+Wi4H5m9Y5R6pqHztAjBaZ4OVbnRzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.32; Mon, 17 Oct 2022 02:48:34 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 02:48:33 +0000
Date:   Mon, 17 Oct 2022 10:48:09 +0800
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
Subject: Re: [PATCH V3 1/4] selftests: amd-pstate: Modify amd-pstate-ut.sh to
 basic.sh.
Message-ID: <Y0zCaXIT9GhBUD0K@amd.com>
References: <20220914061105.1982477-1-li.meng@amd.com>
 <20220914061105.1982477-2-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914061105.1982477-2-li.meng@amd.com>
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: de531ea5-2664-4019-614b-08daafea14f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMoiijTs8oHsmuEdSFA7Ah+SsV4GY+RuiPCL0G9Baj6WDkFWm/gnN8pYVRF+7E4vG3+Nx2txsEWA2EfyABSNijTHw0oTmHU6Hs6/eMpwSmiBa7XpHoxxcCxMQCp/wnb5hwPZtQhtRMmFoOynLbxW5VpEPps3mJ3FP704DYhON75vWOETB5rVx6YT3Z2o9aDs//+jLYDK8T4nuJzZ+upGjDGwxeF6yrE0REIPaZQ9iO2WMRpABAGKhGIXc7pjcwGwciNk+h37i6wFjt5JKvyXcyBjj0oDra0n/2n1/s0Djgh2pli5Ychp1Kx8JAFyBO91TKVWKm0lbXaLJ+7QcX5+gmIgIwBf7lhKfmlcBD43BFOeVhvN6/CdsYdNxNzrK8fXFo+Bh8b3+wsBbdDoN2SVMoV64nAe6lJM0i/EZjxSKxNcya3FHBlIv8SM+oRk+Z4mrqA8m6Gy3eOeNJjgcM4K3OwmtiSeApV+PbgQuTp9phdLDiz59zh6F6FILiXCsKVSJKwgzINfFsmJ0tmF0d8GNcKncDB1t/u9pFDPw1y9+y5DS7OrKXdvDaDyN4EfzDWd8OrOGg9VDHQDB8lZus2hyOq9nbsgqoO43g4WkSgbY3EINKxM6vNTGl2Nttjr0lipKngX2m8afYHv9NEzz7BTqpjBRFZu8LD5AeqFDee1Rd9d6ejQ//eLs8fOOsXFjUz1d4p/FBJlzVleS0Rmfick+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199015)(36756003)(86362001)(5660300002)(37006003)(2906002)(38100700002)(186003)(2616005)(54906003)(6486002)(83380400001)(6506007)(316002)(478600001)(6512007)(6636002)(26005)(66946007)(66556008)(66476007)(6862004)(41300700001)(6666004)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8PqNi4PyUwIpUNKQ5qcVCCsgglPKYzzoBfSgtrG1J+PWFA4gQGUIM3msLuUK?=
 =?us-ascii?Q?fGfrP7lI6PeB0DFgSoR3wgHwZWwKjt7m4Lm0wB+a7L5vbOg9BjwdXS2mw4Et?=
 =?us-ascii?Q?cz0dZE4PPQN+FnsrdOtXyIcApOPjTy9BgZkqvsXKWN9ne2XE62lcPiHsHBHW?=
 =?us-ascii?Q?mNEIFJa+69p4zae8+CvEbILN2eHTfOQ8TecCAszUPbzFnBDcmF5YsuZbYl5H?=
 =?us-ascii?Q?zMx3xRkceXtCYwAobs5h5SKrmWAgiRuGa9F7dZVHc1G2IjDGfRb/l841eSU1?=
 =?us-ascii?Q?CdyAHCWB08WXoT+sfLEzwn8HUQth127etVlat0xNFj3h14YOGB/eGO/DR3Zy?=
 =?us-ascii?Q?5/DgI17CciX+2Z23Hj871PDWAGa1h7K2hJN7z4fIO2L4JBkOhy7Owez4p37b?=
 =?us-ascii?Q?ja320QI5ZKCN8SnFQzLPCKDFHZvLlBaINRSMuKUkoAF48iPmWYzY1Xi1GZv1?=
 =?us-ascii?Q?qgUDZ/5UKLUiE2VjDXWex/iKc7HyGeE9HZfVLi5xoV4VSt9cc/219Y3H+Yki?=
 =?us-ascii?Q?y+rxEQmqFatXrdwcTs8yvY+fe8vmXHaygaGu5lt7c13ISJHxrIY64PQslKwe?=
 =?us-ascii?Q?q4OxERQaJWhJYmPPxLyJfLBC0yG0rKNnwkhht8mOMatbvhagFmQNsDhqpoHB?=
 =?us-ascii?Q?QwjIoXYp6VrWg4n9ftoI/YIrPshpZkQ3WWetPCTbf/yjjl3KiXowg9Vdry/f?=
 =?us-ascii?Q?keKcKYYXsERh718ZD9FVMFLL7xmMRTNWOu5posDV2R6FIE4vOaG/r5SbkuRb?=
 =?us-ascii?Q?rgVu+xu1JuZXUCFm8zPfRL2jQ5xkcqu555SAXs82LDJL+ohlMS/hsCej+DT2?=
 =?us-ascii?Q?N0OVTum8YikawmAwFSLxxNQMMpZfwINBF+sfjuBEm4jD4bYqM5EsxIHsz4r4?=
 =?us-ascii?Q?jyRjSvrZAIILMf8L4ceUZPY+t6L7Zs5/QJa3tuu23yHQAtlLXA2HNq3XSACk?=
 =?us-ascii?Q?pu0EX1QeuAtoAQPhHy0SVw7zW4WAb2er/eMW+4mhx5U5F2Hi+cmze/dn2lVo?=
 =?us-ascii?Q?w/cEt+KxMw9qZB24hvNjUmqg1zLM2oqs5IcdcJDnr5mN48Tnr9MkI5SsQGlF?=
 =?us-ascii?Q?JRnEi75RK21adzouYCoUfMF7r92VvrAHT283vU3vPWjCNJsj1O/4uIQ+W0Xv?=
 =?us-ascii?Q?8rP/suvJDOA+Sobcd9DcZsyZNiptLJ1u4IlQIFNJnk5XE0pISZZVOEg1Fed+?=
 =?us-ascii?Q?V9NUuqw582XzPWDJHzONO///lYl6TXt27J5y9QtfANZvUxJ3P9fTv+/WBcOu?=
 =?us-ascii?Q?Hhv8CbamFfMG2kII7vPGMcaVMrCf49zbep4zGK/UX5tZBVq9yE8mkMOUrtXP?=
 =?us-ascii?Q?BaglPPrtCfxUk5D/MElbCoaqssZ+LpCL7VERCpfzTy7EhgdzaN2BSdEUBSjt?=
 =?us-ascii?Q?d0Dm0FuoOeM4Hrq+T6aAdJIydKdsxxGH0qIlPIMLty96UAV1Ha2nq4OuR5O1?=
 =?us-ascii?Q?u//eNI0RIvbwFj4jZXf2Sc8sDo+deU8bQYVqruquwhNWV7Nr4UK3QCGLJcSG?=
 =?us-ascii?Q?+Yc/cMC0eZZS6X4glUyWEn2GxWqECQ7IacK6EhSZZqT1Qjt9KZKbNZt1HQyQ?=
 =?us-ascii?Q?HwXl0mkmfKCb51BTZEPKyoEgv8r9oxnL5UqtAmlo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de531ea5-2664-4019-614b-08daafea14f5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 02:48:33.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4LU0ZpVhs7NFlB6M/IEeRmYOXRYL/zDeIDx1IPvcv4e3xiWB5FKLoNLocdX09qqQV4PBmvJ54R2o9Oq6Bh8Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 02:11:02PM +0800, Meng, Li (Jassmine) wrote:
> Modify amd-pstate-ut.sh to basic.sh.
> The purpose of this modification is to facilitate the subsequent
> addition of gitsource, tbench and other tests.
> Then you can specify test case in kselftest/amd-pstate, for example:
> sudo ./run.sh -c basic, this command only test basic kernel funcitions.
> The detail please run the below script.
> ./run.sh --help
> 
> Signed-off-by: Meng Li <li.meng@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  tools/testing/selftests/amd-pstate/Makefile   |   3 +-
>  .../selftests/amd-pstate/amd-pstate-ut.sh     |  56 -------
>  tools/testing/selftests/amd-pstate/basic.sh   |  38 +++++
>  tools/testing/selftests/amd-pstate/run.sh     | 142 ++++++++++++++++++
>  4 files changed, 182 insertions(+), 57 deletions(-)
>  delete mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
>  create mode 100755 tools/testing/selftests/amd-pstate/basic.sh
>  create mode 100755 tools/testing/selftests/amd-pstate/run.sh
> 
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> index 199867f44b32..6f4c7b01e3bb 100644
> --- a/tools/testing/selftests/amd-pstate/Makefile
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -4,6 +4,7 @@
>  # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
>  all:
>  
> -TEST_PROGS := amd-pstate-ut.sh
> +TEST_PROGS := run.sh
> +TEST_FILES := basic.sh
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> deleted file mode 100755
> index f8e82d91ffcf..000000000000
> --- a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -# amd-pstate-ut is a test module for testing the amd-pstate driver.
> -# It can only run on x86 architectures and current cpufreq driver
> -# must be amd-pstate.
> -# (1) It can help all users to verify their processor support
> -# (SBIOS/Firmware or Hardware).
> -# (2) Kernel can have a basic function test to avoid the kernel
> -# regression during the update.
> -# (3) We can introduce more functional or performance tests to align
> -# the result together, it will benefit power and performance scale optimization.
> -
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4
> -
> -# amd-pstate-ut only run on x86/x86_64 AMD systems.
> -ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
> -VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
> -
> -if ! echo "$ARCH" | grep -q x86; then
> -	echo "$0 # Skipped: Test can only run on x86 architectures."
> -	exit $ksft_skip
> -fi
> -
> -if ! echo "$VENDOR" | grep -iq amd; then
> -	echo "$0 # Skipped: Test can only run on AMD CPU."
> -	echo "$0 # Current cpu vendor is $VENDOR."
> -	exit $ksft_skip
> -fi
> -
> -scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
> -if [ "$scaling_driver" != "amd-pstate" ]; then
> -	echo "$0 # Skipped: Test can only run on amd-pstate driver."
> -	echo "$0 # Please set X86_AMD_PSTATE enabled."
> -	echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
> -	exit $ksft_skip
> -fi
> -
> -msg="Skip all tests:"
> -if [ ! -w /dev ]; then
> -    echo $msg please run this as root >&2
> -    exit $ksft_skip
> -fi
> -
> -if ! /sbin/modprobe -q -n amd-pstate-ut; then
> -	echo "amd-pstate-ut: module amd-pstate-ut is not found [SKIP]"
> -	exit $ksft_skip
> -fi
> -if /sbin/modprobe -q amd-pstate-ut; then
> -	/sbin/modprobe -q -r amd-pstate-ut
> -	echo "amd-pstate-ut: ok"
> -else
> -	echo "amd-pstate-ut: [FAIL]"
> -	exit 1
> -fi
> diff --git a/tools/testing/selftests/amd-pstate/basic.sh b/tools/testing/selftests/amd-pstate/basic.sh
> new file mode 100755
> index 000000000000..e4c43193e4a3
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/basic.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# amd-pstate-ut is a test module for testing the amd-pstate driver.
> +# It can only run on x86 architectures and current cpufreq driver
> +# must be amd-pstate.
> +# (1) It can help all users to verify their processor support
> +# (SBIOS/Firmware or Hardware).
> +# (2) Kernel can have a basic function test to avoid the kernel
> +# regression during the update.
> +# (3) We can introduce more functional or performance tests to align
> +# the result together, it will benefit power and performance scale optimization.
> +
> +# protect against multiple inclusion
> +if [ $FILE_BASIC ]; then
> +	return 0
> +else
> +	FILE_BASIC=DONE
> +fi
> +
> +amd_pstate_basic()
> +{
> +	printf "\n---------------------------------------------\n"
> +	printf "*** Running AMD P-state ut                ***"
> +	printf "\n---------------------------------------------\n"
> +
> +	if ! /sbin/modprobe -q -n amd-pstate-ut; then
> +		echo "amd-pstate-ut: module amd-pstate-ut is not found [SKIP]"
> +		exit $ksft_skip
> +	fi
> +	if /sbin/modprobe -q amd-pstate-ut; then
> +		/sbin/modprobe -q -r amd-pstate-ut
> +		echo "amd-pstate-basic: ok"
> +	else
> +		echo "amd-pstate-basic: [FAIL]"
> +		exit 1
> +	fi
> +}
> diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
> new file mode 100755
> index 000000000000..715e9d01484f
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/run.sh
> @@ -0,0 +1,142 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# protect against multiple inclusion
> +if [ $FILE_MAIN ]; then
> +	return 0
> +else
> +	FILE_MAIN=DONE
> +fi
> +
> +source basic.sh
> +
> +# amd-pstate-ut only run on x86/x86_64 AMD systems.
> +ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
> +VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
> +
> +FUNC=all
> +OUTFILE=selftest
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +# All amd-pstate tests
> +amd_pstate_all()
> +{
> +	printf "\n=============================================\n"
> +	printf "***** Running AMD P-state Sanity Tests  *****\n"
> +	printf "=============================================\n\n"
> +
> +	# unit test for amd-pstate kernel driver
> +	amd_pstate_basic
> +}
> +
> +helpme()
> +{
> +	printf "Usage: $0 [OPTION...]
> +	[-h <help>]
> +	[-o <output-file-for-dump>]
> +	[-c <all: All testing,
> +	     basic: Basic testing.>]
> +	\n"
> +	exit 2
> +}
> +
> +parse_arguments()
> +{
> +	while getopts ho:c: arg
> +	do
> +		case $arg in
> +			h) # --help
> +				helpme
> +				;;
> +
> +			c) # --func_type (Function to perform: basic (default: all))
> +				FUNC=$OPTARG
> +				;;
> +
> +			o) # --output-file (Output file to store dumps)
> +				OUTFILE=$OPTARG
> +				;;
> +
> +			*)
> +				helpme
> +				;;
> +		esac
> +	done
> +}
> +
> +prerequisite()
> +{
> +	if ! echo "$ARCH" | grep -q x86; then
> +		echo "$0 # Skipped: Test can only run on x86 architectures."
> +		exit $ksft_skip
> +	fi
> +
> +	if ! echo "$VENDOR" | grep -iq amd; then
> +		echo "$0 # Skipped: Test can only run on AMD CPU."
> +		echo "$0 # Current cpu vendor is $VENDOR."
> +		exit $ksft_skip
> +	fi
> +
> +	scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
> +	if [ "$scaling_driver" != "amd-pstate" ]; then
> +		echo "$0 # Skipped: Test can only run on amd-pstate driver."
> +		echo "$0 # Please set X86_AMD_PSTATE enabled."
> +		echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
> +		exit $ksft_skip
> +	fi
> +
> +	msg="Skip all tests:"
> +	if [ ! -w /dev ]; then
> +		echo $msg please run this as root >&2
> +		exit $ksft_skip
> +	fi
> +}
> +
> +do_test()
> +{
> +	case "$FUNC" in
> +		"all")
> +			amd_pstate_all
> +			;;
> +
> +		"basic")
> +			amd_pstate_basic
> +			;;
> +
> +		*)
> +			echo "Invalid [-f] function type"
> +			helpme
> +			;;
> +	esac
> +}
> +
> +# clear dumps
> +pre_clear_dumps()
> +{
> +	case "$FUNC" in
> +		"all")
> +			rm -rf $OUTFILE*
> +			;;
> +
> +		*)
> +			;;
> +	esac
> +}
> +
> +post_clear_dumps()
> +{
> +	rm -rf $OUTFILE.log
> +}
> +
> +# Parse arguments
> +parse_arguments $@
> +
> +# Make sure all requirements are met
> +prerequisite
> +
> +# Run requested functions
> +pre_clear_dumps
> +do_test | tee -a $OUTFILE.log
> +post_clear_dumps
> -- 
> 2.34.1
> 
