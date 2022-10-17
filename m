Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4CA60062F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 07:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJQFQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 01:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJQFQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 01:16:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCEF52E53;
        Sun, 16 Oct 2022 22:16:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf9bJVyy9dKE8W0lwb7LjK6JzxqiiL6DHs7Eq1DimPhzSULSFskzfJEOcEN5bfJm8hls0d/LRICwLNYHz6EtW6kY/nue5AIDfOtEmKTomZrNaS7TJ1u2Qj5S7d0iGot4mykF7T20T6XLofuLd4JzJDNHBXBfH/VAPefzb9tFHR5y7v9KlyF6BygoRnyQiec3Rnf5pTohBuk6EUu5r3nPQork2ppW/wVj7WP/eGwIaUsaWwfdcDA33Dq8JNXv287QW9Fd8Enz1zEzSQJHeiv9FoHhZBRTs19aAoTQo2cKTsXIEk6T54UrjP/0TGnow9/DHN9qr3kJ72QvvZyKb0eQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yVCjUxph9XVdIKNBZDGOfVdqBIPyb7oWHt5V9r8vY0=;
 b=mQ6n5ZqLKb1OBYnsYSey+k5v3U5HKTAUxX6N1+374xv/gES29Y97VoCi6E5yTb+gnThyyVKSgTnnygzlXeY+2hn48lXJUyxxi6nDGYmqvUIY0pCC1SuvSzWzHoVCUBP1HqKzTunRz4QV4Y+b18SFyYNkVKn8Nv/IlLaq1R8FOy4MITcCiPyZNqD0cNlYcvgQ4cmFxB89sfPxAu9EYXvJ4/cLbc4ZPZsmlcAcWkkXeKgDMABn44tmKB7LluZJXr2kB9o2JtUYXhc7CUWgZWse8QJY2pMR78qgIzhQTzwGFwuM79wvxyszTxgf5sCjyQwy/9EunE/gbDpfQVPJzOTr+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yVCjUxph9XVdIKNBZDGOfVdqBIPyb7oWHt5V9r8vY0=;
 b=mnlMVEhg27zmpg1pxOpx+f8ejzotjg7HVDAti1CHbhy0FD2nA4AIInP+4pRdPaXXZW9/6rMpNctLZwruBj1CfDxNxSrL8KGH9FS9GYMPEzDcOnxibWTX+sfsbdyiHrTkEHWqnyq2g8M0SPqfhOWm27dkzjQmTrmVwr31wyjr9Hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MN2PR12MB4502.namprd12.prod.outlook.com (2603:10b6:208:263::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 05:16:46 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 05:16:45 +0000
Date:   Mon, 17 Oct 2022 13:16:22 +0800
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
Subject: Re: [PATCH V3 3/4] selftests: amd-pstate: Trigger gitsource
 benchmark and test cpus
Message-ID: <Y0zlJp/MnInx1qlk@amd.com>
References: <20220914061105.1982477-1-li.meng@amd.com>
 <20220914061105.1982477-4-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914061105.1982477-4-li.meng@amd.com>
X-ClientProxiedBy: TYWP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::9) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|MN2PR12MB4502:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6bd991-b1c3-4169-4b74-08daaffec8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d94k1z+YUJ+HKl3m1AydfQ/xj7D+41xm1ojjvNZue4QmXp0URU5Pe2XC3PI+FT6wpUZro0+U5+H++cpFPv7IH/zlQLARX6EwGfOJGUnVJmDzyvkQfV+XD7fXEsm0ZeVTNwt/yo7bLKc1a2IBafzzsv9hFLPlyDdQiNwCjIdBV3l6qoUa/2h8AQnDdMLBK7XkbmcO84/NUUOqMI5gwzxKSCMmVgCTlYHo2T4mWS91h2ZJpJeIPu7zUxA/Ut3k+RnrMimecWuaDCGCQFnuNxhm6OxjrJUmkA5DqBP5YOpE7p+/dR6QgjuVmtTsclBW/PsDddIjJZk8LeyYY89iLkfiOleN1snc/LgDHq6cTpF2yjOX7G1Zmtgwduw6hPDt1HGCXyOCtCdjAxxKKhTz8iRh9iC9FyEyosuPQTbAgdmlku1lq/pPaao6L2EWzp26wY1yTUIiAFh9dg1nuhb7ghh3OwOtI3QQQvjbpEP73uszAALQv9vVPsotOtDDSquhhiOVh+zuVfW0VtdAnferXQokLRPTi/cCkrwyF9Z1O+4EgJaPnBfke78a28d0BX88FIrQsdtdzOalcEjnJAE16f16NP7aFJsS7hjUREgQ3BjESJa6Sa5DNUUrVd2Q2A9v/yZaBzt9rqIKnk/xPSPvncq6YW9/rJrYeEjleuqVwJ98LEEBQWEYFWG3h6oPXzT8Xj/P8U86sVFccSEzBGfKx1Cz/Kmx3AznY0TNbOtZ13iKFB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199015)(36756003)(86362001)(5660300002)(37006003)(30864003)(2906002)(38100700002)(186003)(2616005)(83380400001)(6506007)(316002)(478600001)(26005)(6512007)(54906003)(6636002)(6486002)(66946007)(66556008)(66476007)(41300700001)(8936002)(6862004)(4326008)(6666004)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lZS5ePb1+K06nk3l5CyUN4YBQyV5ky9TJDwsDtDv+2jr32UG0ZOYxqg1ofvP?=
 =?us-ascii?Q?jgx+WxCKPkMXYtAhiDsFfsp0jgOy8Uet0mymUSC+m5IBlva1RVs0HLYEBN+1?=
 =?us-ascii?Q?26rSxHAux/2gAiro2UpCddjof2jWTG2tejw0+MzcGvQsHFgrRMvVYO14NQiT?=
 =?us-ascii?Q?5DJOfOHOVsa8WzEW+QPkprgpJCn15EMlWVBgv2TUT2OwsB+WXwaldJJFy4MF?=
 =?us-ascii?Q?EPgQCHI4Uz/xBjiuGXyd9ifPfeHhw4Vn5CB9twJW08Pn/ppoLcecSsbrfc/t?=
 =?us-ascii?Q?iLDqVhP9p5gu4HYAEYeE2h6LRHSIszemhKeBETJwBUYg1yuzE2FrPNcFgasR?=
 =?us-ascii?Q?feBpeSNbgQ8BS08TqRcG9IxZma4HT1pLsFv1z+6NQ73xue2lfsQNg3/VjlBG?=
 =?us-ascii?Q?s5Bvf1otHqGUE40SDpbPf1+kMdNVgVLoQXzsiv/wnB9c8LmmYr3agHDRwZH2?=
 =?us-ascii?Q?fhkBeBqB1V+prydrbJPzLSsTRtIgM21zrH035p+A67JHg7L33pHewHuL0wqn?=
 =?us-ascii?Q?FX9Brow36vJcij+IJVKne1wJqtfDpdVid02hbWD6cO4a2oMRY6OGyNa4lZ5A?=
 =?us-ascii?Q?26lyPhjJFLOFjfogrk7U9SwKe6r7zeBp4onQXOf2ENybB2fcJX2UyH/+zyAK?=
 =?us-ascii?Q?ZQ+tBgVWWvZ11MMICL3qwZ/WYOTJzgSbMnsrNsuc8zF6Ib6PY3atb9IDiDz0?=
 =?us-ascii?Q?JJf+MizF1LMx/XyaxhmYBv9/fGvda6BxiDlGgmGo/otjIUeRFPcwRm7hH/BN?=
 =?us-ascii?Q?pbZINF0hi2aJapCrkWoFkVA5/CsswMcUlDLjcvgEguChjwuWIyfNSbQ93RA5?=
 =?us-ascii?Q?k/ljCaFedLPnY38L0O20ba2FPevvVgTLOufOKqhPuKs2PfU2Mt0p5HRVyw1M?=
 =?us-ascii?Q?Bf657CYNjSjbnOS3ZKVkaqre31olli+x9006IrO0c2xdKGqRiJ5aF9BtDd0p?=
 =?us-ascii?Q?e2/x7UhrL3qfOA2iEfwr98z2mYPJTKNCPNWP332ZzhgQ0Mw/s6Xg7vz5HLBm?=
 =?us-ascii?Q?Bq+Z3cg+aunE0bn5/K0Dvkwq39LoUXFoLmsutd1mAQpXy+TkAXi40ul93vlD?=
 =?us-ascii?Q?dlGMJmsffK4S06B4Ddmr0kjObmRYxlU4OrZkYmYNpF1RuePvVn9QpnnzQeXD?=
 =?us-ascii?Q?ZVjumGiYYGVDlrqE20RTEa4jyklfuDkgBOjbk+8EmKy4hRULq2OzDQ5Qe4wG?=
 =?us-ascii?Q?PC9D7Bk3pxun+PbjTFyCl+geQOHozuUaSxDcjUDKmnR1GOnuKGmJMdHeQyf8?=
 =?us-ascii?Q?dIO7QQ9Y8JQfbeFPk1bbx2sNmF09fLTcsVIcKLLbAmiisf+DjETrFEfQhtnK?=
 =?us-ascii?Q?hLw9OjMbmfua3DOkRSn/URS8wHNtp2ghVHlBy0BDxM/yqa0fQlv5oE52wkqn?=
 =?us-ascii?Q?rtiZxvjxj7RD7elpbafem3b10Nfu/+uI+f1rX08tRovoKVC3HtYnemqECzdi?=
 =?us-ascii?Q?DNCHl5igHWsuFE/2l2AF+LkxuZZ5+5SRvGRVuF0s3RhExB1achM56b4koYdg?=
 =?us-ascii?Q?TzBWVLERKpOXunmpP5LHm2jyQmvR0JXKHHCXTwv4571GY+/Z9IFsLCSHuPv2?=
 =?us-ascii?Q?PRWo3gJsTcKLoZD+q09Ax2CFty9vtR8mWGp8+L6A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6bd991-b1c3-4169-4b74-08daaffec8a5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 05:16:45.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5jGmT52akJIj+MW/CbTtPcBMuumGt4UgRaz+ts53enXdbTnebI97tYQkpR/DGhEVxR8atwuR7DZRnHI/8ryuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4502
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 02:11:04PM +0800, Meng, Li (Jassmine) wrote:
> Add gitsource.sh trigger the gitsource testing and monitor the cpu desire
> performance, frequency, load, power consumption and throughput etc.
> 

The same comment, please add the steps here from the cover letter.

> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  tools/testing/selftests/amd-pstate/Makefile   |   2 +-
>  .../testing/selftests/amd-pstate/gitsource.sh | 345 ++++++++++++++++++
>  tools/testing/selftests/amd-pstate/run.sh     |  32 +-
>  3 files changed, 372 insertions(+), 7 deletions(-)
>  create mode 100755 tools/testing/selftests/amd-pstate/gitsource.sh
> 
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> index cac8dedb7226..5f195ee756d6 100644
> --- a/tools/testing/selftests/amd-pstate/Makefile
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -13,6 +13,6 @@ TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
>  endif
>  
>  TEST_PROGS := run.sh
> -TEST_FILES := basic.sh tbench.sh
> +TEST_FILES := basic.sh tbench.sh gitsource.sh
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
> new file mode 100755
> index 000000000000..a9ad9388eb7b
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/gitsource.sh
> @@ -0,0 +1,345 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Testing and monitor the cpu frequency and performance when
> +# this script trigger gitsource test.
> +
> +# protect against multiple inclusion
> +if [ $FILE_GITSOURCE ]; then
> +	return 0
> +else
> +	FILE_GITSOURCE=DONE
> +fi
> +
> +git_name="git-2.15.1"
> +git_tar="$git_name.tar.gz"
> +gitsource_url="https://github.com/git/git/archive/refs/tags/v2.15.1.tar.gz"
> +gitsource_governors=("ondemand" "schedutil")

Do we assign the specific version for TBench as well?

The rest looks good for me.

Thanks,
Ray

> +
> +# $1: governor, $2: round, $3: des-perf, $4: freq, $5: load, $6: time $7: energy, $8: PPW
> +store_csv_gitsource()
> +{
> +	echo "$1, $2, $3, $4, $5, $6, $7, $8" | tee -a $OUTFILE_GIT.csv > /dev/null 2>&1
> +}
> +
> +# clear some special lines
> +clear_csv_gitsource()
> +{
> +	if [ -f $OUTFILE_GIT.csv ]; then
> +		sed -i '/Comprison(%)/d' $OUTFILE_GIT.csv
> +		sed -i "/$(scaling_name)/d" $OUTFILE_GIT.csv
> +	fi
> +}
> +
> +# find string $1 in file csv and get the number of lines
> +get_lines_csv_gitsource()
> +{
> +	if [ -f $OUTFILE_GIT.csv ]; then
> +		return `grep -c "$1" $OUTFILE_GIT.csv`
> +	else
> +		return 0
> +	fi
> +}
> +
> +pre_clear_gitsource()
> +{
> +	post_clear_gitsource
> +	rm -rf gitsource_*.png
> +	clear_csv_gitsource
> +}
> +
> +post_clear_gitsource()
> +{
> +	rm -rf results/tracer-gitsource*
> +	rm -rf $OUTFILE_GIT*.log
> +	rm -rf $OUTFILE_GIT*.result
> +}
> +
> +install_gitsource()
> +{
> +	if [ ! -d $git_name ]; then
> +		printf "Download gitsource, please wait a moment ...\n\n"
> +		wget -O $git_tar $gitsource_url > /dev/null 2>&1
> +
> +		printf "Tar gitsource ...\n\n"
> +		tar -xzf $git_tar
> +	fi
> +}
> +
> +# $1: governor, $2: loop
> +run_gitsource()
> +{
> +	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
> +	./amd_pstate_trace.py -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
> +
> +	printf "Make and test gitsource for $1 #$2 make_cpus: $MAKE_CPUS\n"
> +	cd $git_name
> +	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o ../$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > ../$OUTFILE_GIT-perf-$1-$2.log 2>&1
> +	cd ..
> +
> +	for job in `jobs -p`
> +	do
> +		echo "Waiting for job id $job"
> +		wait $job
> +	done
> +}
> +
> +# $1: governor, $2: loop
> +parse_gitsource()
> +{
> +	awk '{print $5}' results/tracer-gitsource-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_GIT-des-perf-$1-$2.log
> +	avg_des_perf=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_GIT-des-perf-$1-$2.log)
> +	printf "Gitsource-$1-#$2 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_GIT.result
> +
> +	awk '{print $7}' results/tracer-gitsource-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_GIT-freq-$1-$2.log
> +	avg_freq=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_GIT-freq-$1-$2.log)
> +	printf "Gitsource-$1-#$2 avg freq: $avg_freq\n" | tee -a $OUTFILE_GIT.result
> +
> +	awk '{print $11}' results/tracer-gitsource-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_GIT-load-$1-$2.log
> +	avg_load=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_GIT-load-$1-$2.log)
> +	printf "Gitsource-$1-#$2 avg load: $avg_load\n" | tee -a $OUTFILE_GIT.result
> +
> +	grep user $OUTFILE_GIT.time-gitsource-$1-$2.log | awk '{print $1}' | sed -e 's/user//' > $OUTFILE_GIT-time-$1-$2.log
> +	time_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-time-$1-$2.log)
> +	printf "Gitsource-$1-#$2 user time(s): $time_sum\n" | tee -a $OUTFILE_GIT.result
> +
> +	grep Joules $OUTFILE_GIT-perf-$1-$2.log | awk '{print $4}' > $OUTFILE_GIT-energy-$1-$2.log
> +	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-energy-$1-$2.log)
> +	printf "Gitsource-$1-#$2 power consumption(J): $en_sum\n" | tee -a $OUTFILE_GIT.result
> +
> +	# Permance is the number of run gitsource per second, denoted 1/t, where 1 is the number of run gitsource in t
> +	# senconds. It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
> +	# and t is time measured in seconds(s). This means that performance per watt becomes
> +	#        1/t     1/t     1
> +	#       ----- = ----- = ---
> +	#         P      E/t     E
> +	# with unit given by 1 per joule.
> +	ppw=`echo "scale=9;1/$en_sum" | bc | awk '{printf "%.9f", $0}'`
> +	printf "Gitsource-$1-#$2 performance per watt(1/J): $ppw\n" | tee -a $OUTFILE_GIT.result
> +	printf "\n" | tee -a $OUTFILE_GIT.result
> +
> +	driver_name=`echo $(scaling_name)`
> +	store_csv_gitsource "$driver_name-$1" $2 $avg_des_perf $avg_freq $avg_load $time_sum $en_sum $ppw
> +}
> +
> +# $1: governor
> +loop_gitsource()
> +{
> +	printf "\nGitsource total test times is $LOOP_TIMES for $1\n\n"
> +	for i in `seq 1 $LOOP_TIMES`
> +	do
> +		run_gitsource $1 $i
> +		parse_gitsource $1 $i
> +	done
> +}
> +
> +# $1: governor
> +gather_gitsource()
> +{
> +	printf "Gitsource test result for $1 (loops:$LOOP_TIMES)" | tee -a $OUTFILE_GIT.result
> +	printf "\n--------------------------------------------------\n" | tee -a $OUTFILE_GIT.result
> +
> +	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "avg des perf:" | awk '{print $NF}' > $OUTFILE_GIT-des-perf-$1.log
> +	avg_des_perf=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-des-perf-$1.log)
> +	printf "Gitsource-$1 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_GIT.result
> +
> +	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "avg freq:" | awk '{print $NF}' > $OUTFILE_GIT-freq-$1.log
> +	avg_freq=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-freq-$1.log)
> +	printf "Gitsource-$1 avg freq: $avg_freq\n" | tee -a $OUTFILE_GIT.result
> +
> +	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "avg load:" | awk '{print $NF}' > $OUTFILE_GIT-load-$1.log
> +	avg_load=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-load-$1.log)
> +	printf "Gitsource-$1 avg load: $avg_load\n" | tee -a $OUTFILE_GIT.result
> +
> +	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "user time(s):" | awk '{print $NF}' > $OUTFILE_GIT-time-$1.log
> +	time_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-time-$1.log)
> +	printf "Gitsource-$1 total user time(s): $time_sum\n" | tee -a $OUTFILE_GIT.result
> +
> +	avg_time=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-time-$1.log)
> +	printf "Gitsource-$1 avg user times(s): $avg_time\n" | tee -a $OUTFILE_GIT.result
> +
> +	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "power consumption(J):" | awk '{print $NF}' > $OUTFILE_GIT-energy-$1.log
> +	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-energy-$1.log)
> +	printf "Gitsource-$1 total power consumption(J): $en_sum\n" | tee -a $OUTFILE_GIT.result
> +
> +	avg_en=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-energy-$1.log)
> +	printf "Gitsource-$1 avg power consumption(J): $avg_en\n" | tee -a $OUTFILE_GIT.result
> +
> +	# Permance is the number of run gitsource per second, denoted 1/t, where 1 is the number of run gitsource in t
> +	# senconds. It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
> +	# and t is time measured in seconds(s). This means that performance per watt becomes
> +	#        1/t     1/t     1
> +	#       ----- = ----- = ---
> +	#         P      E/t     E
> +	# with unit given by 1 per joule.
> +	ppw=`echo "scale=9;1/$avg_en" | bc | awk '{printf "%.9f", $0}'`
> +	printf "Gitsource-$1 performance per watt(1/J): $ppw\n" | tee -a $OUTFILE_GIT.result
> +	printf "\n" | tee -a $OUTFILE_GIT.result
> +
> +	driver_name=`echo $(scaling_name)`
> +	store_csv_gitsource "$driver_name-$1" "Average" $avg_des_perf $avg_freq $avg_load $avg_time $avg_en $ppw
> +}
> +
> +# $1: base scaling_driver $2: base governor $3: comparison scaling_driver $4: comparison governor
> +__calc_comp_gitsource()
> +{
> +	base=`grep "$1-$2" $OUTFILE_GIT.csv | grep "Average"`
> +	comp=`grep "$3-$4" $OUTFILE_GIT.csv | grep "Average"`
> +
> +	if [ -n "$base" -a -n "$comp" ]; then
> +		printf "\n==================================================\n" | tee -a $OUTFILE_GIT.result
> +		printf "Gitsource comparison $1-$2 VS $3-$4" | tee -a $OUTFILE_GIT.result
> +		printf "\n==================================================\n" | tee -a $OUTFILE_GIT.result
> +
> +		# get the base values
> +		des_perf_base=`echo "$base" | awk '{print $3}' | sed s/,//`
> +		freq_base=`echo "$base" | awk '{print $4}' | sed s/,//`
> +		load_base=`echo "$base" | awk '{print $5}' | sed s/,//`
> +		time_base=`echo "$base" | awk '{print $6}' | sed s/,//`
> +		energy_base=`echo "$base" | awk '{print $7}' | sed s/,//`
> +		ppw_base=`echo "$base" | awk '{print $8}' | sed s/,//`
> +
> +		# get the comparison values
> +		des_perf_comp=`echo "$comp" | awk '{print $3}' | sed s/,//`
> +		freq_comp=`echo "$comp" | awk '{print $4}' | sed s/,//`
> +		load_comp=`echo "$comp" | awk '{print $5}' | sed s/,//`
> +		time_comp=`echo "$comp" | awk '{print $6}' | sed s/,//`
> +		energy_comp=`echo "$comp" | awk '{print $7}' | sed s/,//`
> +		ppw_comp=`echo "$comp" | awk '{print $8}' | sed s/,//`
> +
> +		# compare the base and comp values
> +		des_perf_drop=`echo "scale=4;($des_perf_comp-$des_perf_base)*100/$des_perf_base" | bc | awk '{printf "%.4f", $0}'`
> +		printf "Gitsource-$1 des perf base: $des_perf_base comprison: $des_perf_comp percent: $des_perf_drop\n" | tee -a $OUTFILE_GIT.result
> +
> +		freq_drop=`echo "scale=4;($freq_comp-$freq_base)*100/$freq_base" | bc | awk '{printf "%.4f", $0}'`
> +		printf "Gitsource-$1 freq base: $freq_base comprison: $freq_comp percent: $freq_drop\n" | tee -a $OUTFILE_GIT.result
> +
> +		load_drop=`echo "scale=4;($load_comp-$load_base)*100/$load_base" | bc | awk '{printf "%.4f", $0}'`
> +		printf "Gitsource-$1 load base: $load_base comprison: $load_comp percent: $load_drop\n" | tee -a $OUTFILE_GIT.result
> +
> +		time_drop=`echo "scale=4;($time_comp-$time_base)*100/$time_base" | bc | awk '{printf "%.4f", $0}'`
> +		printf "Gitsource-$1 perf base: $time_base comprison: $time_comp percent: $time_drop\n" | tee -a $OUTFILE_GIT.result
> +
> +		energy_drop=`echo "scale=4;($energy_comp-$energy_base)*100/$energy_base" | bc | awk '{printf "%.4f", $0}'`
> +		printf "Gitsource-$1 energy base: $energy_base comprison: $energy_comp percent: $energy_drop\n" | tee -a $OUTFILE_GIT.result
> +
> +		ppw_drop=`echo "scale=4;($ppw_comp-$ppw_base)*100/$ppw_base" | bc | awk '{printf "%.4f", $0}'`
> +		printf "Gitsource-$1 performance per watt base: $ppw_base comprison: $ppw_comp percent: $ppw_drop\n" | tee -a $OUTFILE_GIT.result
> +		printf "\n" | tee -a $OUTFILE_GIT.result
> +
> +		store_csv_gitsource "$1-$2 VS $3-$4" "Comprison(%)" "$des_perf_drop" "$freq_drop" "$load_drop" "$time_drop" "$energy_drop" "$ppw_drop"
> +	fi
> +}
> +
> +# calculate the comparison(%)
> +calc_comp_gitsource()
> +{
> +	# acpi-cpufreq-ondemand VS acpi-cpufreq-schedutil
> +	__calc_comp_gitsource ${all_scaling_names[0]} ${gitsource_governors[0]} ${all_scaling_names[0]} ${gitsource_governors[1]}
> +
> +	# amd-pstate-ondemand VS amd-pstate-schedutil
> +	__calc_comp_gitsource ${all_scaling_names[1]} ${gitsource_governors[0]} ${all_scaling_names[1]} ${gitsource_governors[1]}
> +
> +	# acpi-cpufreq-ondemand VS amd-pstate-ondemand
> +	__calc_comp_gitsource ${all_scaling_names[0]} ${gitsource_governors[0]} ${all_scaling_names[1]} ${gitsource_governors[0]}
> +
> +	# acpi-cpufreq-schedutil VS amd-pstate-schedutil
> +	__calc_comp_gitsource ${all_scaling_names[0]} ${gitsource_governors[1]} ${all_scaling_names[1]} ${gitsource_governors[1]}
> +}
> +
> +# $1: file_name, $2: title, $3: ylable, $4: column
> +plot_png_gitsource()
> +{
> +	# all_scaling_names[1] all_scaling_names[0] flag
> +	#    amd-pstate           acpi-cpufreq
> +	#         N                   N             0
> +	#         N                   Y             1
> +	#         Y                   N             2
> +	#         Y                   Y             3
> +	ret=`grep -c "${all_scaling_names[1]}" $OUTFILE_GIT.csv`
> +	if [ $ret -eq 0 ]; then
> +		ret=`grep -c "${all_scaling_names[0]}" $OUTFILE_GIT.csv`
> +		if [ $ret -eq 0 ]; then
> +			flag=0
> +		else
> +			flag=1
> +		fi
> +	else
> +		ret=`grep -c "${all_scaling_names[0]}" $OUTFILE_GIT.csv`
> +		if [ $ret -eq 0 ]; then
> +			flag=2
> +		else
> +			flag=3
> +		fi
> +	fi
> +
> +	gnuplot << EOF
> +		set term png
> +		set output "$1"
> +
> +		set title "$2"
> +		set xlabel "Test Cycles (round)"
> +		set ylabel "$3"
> +
> +		set grid
> +		set style data histogram
> +		set style fill solid 0.5 border
> +		set boxwidth 0.8
> +
> +		if ($flag == 1) {
> +			plot \
> +			"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${gitsource_governors[0]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${gitsource_governors[0]}", \
> +			"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${gitsource_governors[1]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${gitsource_governors[1]}"
> +		} else {
> +			if ($flag == 2) {
> +				plot \
> +				"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${gitsource_governors[0]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${gitsource_governors[0]}", \
> +				"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${gitsource_governors[1]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${gitsource_governors[1]}"
> +			} else {
> +				if ($flag == 3 ) {
> +					plot \
> +					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${gitsource_governors[0]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${gitsource_governors[0]}", \
> +					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${gitsource_governors[1]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${gitsource_governors[1]}", \
> +					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${gitsource_governors[0]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${gitsource_governors[0]}", \
> +					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${gitsource_governors[1]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${gitsource_governors[1]}"
> +				}
> +			}
> +		}
> +		quit
> +EOF
> +}
> +
> +amd_pstate_gitsource()
> +{
> +	printf "\n---------------------------------------------\n"
> +	printf "*** Running gitsource                     ***"
> +	printf "\n---------------------------------------------\n"
> +
> +	pre_clear_gitsource
> +
> +	install_gitsource
> +
> +	get_lines_csv_gitsource "Governor"
> +	if [ $? -eq 0 ]; then
> +		# add titles and unit for csv file
> +		store_csv_gitsource "Governor" "Round" "Des-perf" "Freq" "Load" "Time" "Energy" "Performance Per Watt"
> +		store_csv_gitsource "Unit" "" "" "GHz" "" "s" "J" "1/J"
> +	fi
> +
> +	backup_governor
> +	for governor in ${gitsource_governors[*]} ; do
> +		printf "\nSpecified governor is $governor\n\n"
> +		switch_governor $governor
> +		loop_gitsource $governor
> +		gather_gitsource $governor
> +	done
> +	restore_governor
> +
> +	plot_png_gitsource "gitsouce_time.png" "Gitsource Benchmark Time" "Time (s)" 6
> +	plot_png_gitsource "gitsource_energy.png" "Gitsource Benchmark Energy" "Energy (J)" 7
> +	plot_png_gitsource "gitsource_ppw.png" "Gitsource Benchmark Performance Per Watt" "Performance Per Watt (1/J)" 8
> +
> +	calc_comp_gitsource
> +
> +	post_clear_gitsource
> +}
> diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
> index dea61e4443fc..9ef6eff347d3 100755
> --- a/tools/testing/selftests/amd-pstate/run.sh
> +++ b/tools/testing/selftests/amd-pstate/run.sh
> @@ -10,6 +10,7 @@ fi
>  
>  source basic.sh
>  source tbench.sh
> +source gitsource.sh
>  
>  # amd-pstate-ut only run on x86/x86_64 AMD systems.
>  ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
> @@ -18,6 +19,7 @@ VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
>  FUNC=all
>  OUTFILE=selftest
>  OUTFILE_TBENCH="$OUTFILE.tbench"
> +OUTFILE_GIT="$OUTFILE.gitsource"
>  
>  SYSFS=
>  CPUROOT=
> @@ -130,6 +132,9 @@ amd_pstate_all()
>  
>  	# tbench
>  	amd_pstate_tbench
> +
> +	# gitsource
> +	amd_pstate_gitsource
>  }
>  
>  helpme()
> @@ -139,7 +144,8 @@ helpme()
>  	[-o <output-file-for-dump>]
>  	[-c <all: All testing,
>  	     basic: Basic testing,
> -	     tbench: Tbench testing.>]
> +	     tbench: Tbench testing,
> +	     gitsource: Gitsource testing.>]
>  	[-t <tbench time limit>]
>  	[-p <tbench process number>]
>  	[-l <loop times for tbench>]
> @@ -158,7 +164,7 @@ parse_arguments()
>  				helpme
>  				;;
>  
> -			c) # --func_type (Function to perform: basic, tbench (default: all))
> +			c) # --func_type (Function to perform: basic, tbench, gitsource (default: all))
>  				FUNC=$OPTARG
>  				;;
>  
> @@ -174,7 +180,7 @@ parse_arguments()
>  				PROCESS_NUM=$OPTARG
>  				;;
>  
> -			l) # --tbench-loop-times
> +			l) # --tbench/gitsource-loop-times
>  				LOOP_TIMES=$OPTARG
>  				;;
>  
> @@ -242,16 +248,16 @@ prerequisite()
>  		fi
>  	else
>  		case "$FUNC" in
> -			"tbench")
> +			"tbench" | "gitsource")
>  				if [ "$scaling_driver" != "$COMPARATIVE_TEST" ]; then
> -					echo "$0 # Skipped: Comparison test can only run on $COMPARATIVE_TEST driver."
> +					echo "$0 # Skipped: Comparison test can only run on $COMPARISON_TEST driver."
>  					echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
>  					exit $ksft_skip
>  				fi
>  				;;
>  
>  			*)
> -				echo "$0 # Skipped: Comparison test are only for tbench."
> +				echo "$0 # Skipped: Comparison test are only for tbench or gitsource."
>  				echo "$0 # Current comparative test is for $FUNC."
>  				exit $ksft_skip
>  				;;
> @@ -274,6 +280,10 @@ prerequisite()
>  			command_perf
>  			command_tbench
>  			;;
> +
> +		"gitsource")
> +			command_perf
> +			;;
>  	esac
>  
>  	SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`
> @@ -321,6 +331,10 @@ do_test()
>  			amd_pstate_tbench
>  			;;
>  
> +		"gitsource")
> +			amd_pstate_gitsource
> +			;;
> +
>  		*)
>  			echo "Invalid [-f] function type"
>  			helpme
> @@ -344,6 +358,12 @@ pre_clear_dumps()
>  			rm -rf tbench_*.png
>  			;;
>  
> +		"gitsource")
> +			rm -rf $OUTFILE.log
> +			rm -rf $OUTFILE.backup_governor.log
> +			rm -rf gitsource_*.png
> +			;;
> +
>  		*)
>  			;;
>  	esac
> -- 
> 2.34.1
> 
