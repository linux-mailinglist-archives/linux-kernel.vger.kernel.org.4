Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211E560C09D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiJYBLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiJYBKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:10:20 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003AA386A6;
        Mon, 24 Oct 2022 17:19:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/yidMfSc6y1Doxp2sQVrW9lHM4zj/o+zh55k76r/Gygd/PfnJEfH9zo5lg+dkLYFMeIpHZSWNVjEQ+DTlJCe8DTxdWQoz8S+Zq3aj1t63ql/0i+Um+RZsE3sd0Z1jdA0YNCWpsex/MLuRGFzOlkEf4f8C/mPu5sPNTWhdTdfPZPTjDEtsahGGycC96+CAq2MLS7LVQjZwoCPn5Fzec7y14ZgsbmDbFXZg0udfTQTVr2wCibMhyV9Q1iN9rfsMTQO3/N52ao+ndsBdsiT/zdFmMQh2RS+qmkWmVNEqWBt1RmF3aznDnjl+rFBWEnTocIs9Py64KWvZtrQjbrQUVyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGDPOnK48GOjEFdDKmf61XIQLH97w4v8SykSelKEuN4=;
 b=jreu/TMfj2dHFUkVmo63vC50J8YaVkgrlNYzUBE9BvBFfXpMgkrbSOZiR6myraJ5tyXRBE0isZKMpeixI3RgWPj6kTftF07ZblC1psX3gvaoSCgoQcX0NCl+4wWzuequmFKytc68/YkE1WvcHAR3It2zaKLha2zzVIOQQLz2B4SQswwyjcjSmRIXrU9Wro9JX1vJ3jWl+cJV2CwxfBCeiCA8g1zR2Jt51kuOIr0jDHDD4Bv+vFWdCUivxCPQDzketwyIs9YV/Q71yEmSiZMejsc1ehDTdM26LV0iCPSs08hhyXKmEs0PYdAehI50opHOzldKG9HROhqAkOAPx14Sfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGDPOnK48GOjEFdDKmf61XIQLH97w4v8SykSelKEuN4=;
 b=IsaPV5iJ5V32mmVgSDRIOF5d8BQdoVraqV/ewD3ULuGF+2Lj1OmyCm2awc3bDzh/abaNTvxDLOvaeLfNilRU5AHRoDy3Any5UozQ4XdWo1VmJdw8qFh0JEiOI9vR0zsnX7uYLaHlRQQwqaeHaVWC0y/6ChD8NuJXjKHKCFo55TQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2506.namprd12.prod.outlook.com (2603:10b6:907:7::12)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 25 Oct
 2022 00:19:57 +0000
Received: from MW2PR12MB2506.namprd12.prod.outlook.com
 ([fe80::ec3a:151e:5230:1739]) by MW2PR12MB2506.namprd12.prod.outlook.com
 ([fe80::ec3a:151e:5230:1739%2]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 00:19:57 +0000
Date:   Tue, 25 Oct 2022 08:19:34 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 0/4] Add tbench/gitsource new test cases for
 amd-pstate-ut
Message-ID: <Y1crluIArwEksyIp@amd.com>
References: <20221024013356.1639489-1-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024013356.1639489-1-li.meng@amd.com>
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To MW2PR12MB2506.namprd12.prod.outlook.com
 (2603:10b6:907:7::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2506:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 010880d6-56d4-4089-d97f-08dab61ea56e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1iuK+ICExRJepMoeRqMV6xOfXoUMASygEDsyQg4ggi9S/EaeDc7b/JnKDO6LWETtQG9aMGiGskBhbaXdDCiut8XML4dB/StwMWXlJwFMTYIUzJwDRFRS9StbiDM1pWLOo5PddLz9U9juj5+9dJq8dy8v9yLF8GlO+t9zq62kOaSLyqcJgth7Fi31kvYsvyM0R/PsPrezWWwM55qZtVXvoFo2jSCjdjr8JhCfiUjsbiYW7RzmTxfdsl3ROJU6sg9y+Fcy4CuHj1z95MxlR+Ssk6scBNQfY0VTbl0/m784cT+5Y2oC/vTOQwiLd6sBccIVF3s2cyT1X+oauccJC3kpcT2ukLlXVwJXhrwJ98U2qwjXiIbCCSpeDPS6enrbagf7C7dYX4DtgIVi8W/uOzgpo1si4GqxmuMaW8RKi8qmP3mvDKF5/ej3pJ/HQci4eMtmFOkfk0+vm/DT5+s+Os3bijIMMxnSOgn/HJRcbU6rfWSrRZslR/QuViZ3l0Ey+AyLAHH3gIYZPTqhLATBvef/sA3l/mCyAhP1pFnTRyFY5KarvwBb6ePXqRuIOPioG3icz4Td9lssPZHnC7+yBo5h0UnewyNb4lnWQBNjqdCg7qpiBwHzoJVYaf2uqcsQpnoDZV5t2w6AuR02f/Dg9XT4iTGXIzFUXvb+Wyq8ytXb0u6Jc+aGZB2G+hzINZiMW3JWTNzUaf7Cn5k1LKuNInYrbzUF540mH6LqF7jwN6TEvDBLFTQGLSHkjExmkDpSUd/aUdPCXpM3qHx+vLYLTp+aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199015)(6862004)(36756003)(38100700002)(86362001)(6666004)(5660300002)(8936002)(83380400001)(2616005)(54906003)(6512007)(37006003)(316002)(6636002)(6506007)(66946007)(478600001)(41300700001)(6486002)(66556008)(8676002)(2906002)(4326008)(66476007)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X8Vg9DSd7hMbe1LwV0B619BWZONrRuMHTSXG7bBE8+yiSH301ALQ+QbqJ5oF?=
 =?us-ascii?Q?IBlUNGQgwuQQIxQVY8vJu3m3HotTCfScx8bMRnwmp5FzaWgJizsJmi4W4Z+K?=
 =?us-ascii?Q?qMXmJVgMYZHzhxR/4cEFFpfT1JL892abtwLWtTosePIbM6gYn9CrVXT+796F?=
 =?us-ascii?Q?/tXymkgB76ILbDJhg7OhNFtC2jvGdGzTNYpMSvOxSnFjhwiorKIh8eoEq40M?=
 =?us-ascii?Q?434XaeDQjqlKPK20V6eafvTPM5oI28XrtvUhfo85fBg3MSw2HvFOC0QiuWq4?=
 =?us-ascii?Q?g9b7CyStjF3MHx9Y5nzqxvjIMiF+K+Mh2G+5Qx/PUOZ1x5jVsfNiiaTPjJWR?=
 =?us-ascii?Q?Rm4eKwq8V1/4ZIEqbAwDRxIp9p++o/r6RU0dbagYpCQWFHrCSXM4lvtTuuOV?=
 =?us-ascii?Q?OTmivejwl6u0o4ceyv69HNbAgV9rKKYLW5gj7StG0zkwHgldzUpnB0UrNUJX?=
 =?us-ascii?Q?7q55p7V9scxRCKyYO0tlnk+NXFhdVwSrdsL5XBNakxDnz0JRh1KTUWG7BePK?=
 =?us-ascii?Q?8i4Ej1Q027kiSNSp1CNa6pnD7390o4nYnpxz812AEMsy8qmtp0bwgXUubeM7?=
 =?us-ascii?Q?L+WxbwpETJlYj8u0dINegDDje8n1xRqxcRs5ibeT6lW0O07KBaBMK6iVWOKX?=
 =?us-ascii?Q?xKhg136j/qKpWjkw5DLOVlIEEFLyvKIjOHPIoOD7Xdivem2FzQwJJucAeYWY?=
 =?us-ascii?Q?6CCcR4Cqe7VRu0MFFSDowF+Adk6kiYL9IfNbgTmMH0Id6aF8Tl66k9bybEc7?=
 =?us-ascii?Q?Fb7IdBlwu/E3qDCXlerlJQS9jcua6Lek0B/0OFoAtz0kLgbx8P3hhBuDbYYd?=
 =?us-ascii?Q?malIX2rSFeUP8T3pqoALX3w38Xy5+K7XER3Wa4RRvagiS9Mp82zAhYTtG+r1?=
 =?us-ascii?Q?6Mo/HwenTSPLsAG0GmTjKLZtRehB4m9QvYYwrZZDrgBkKmq229fIBSpcPrv1?=
 =?us-ascii?Q?G+i3eeaonAXgWF49aFweHFxEn1/2RHy0mQ8Ai0sudCHF/RkHl7UqDIjQ9VuB?=
 =?us-ascii?Q?BVLm/hw3qLU3zdxUPgNApOyFPRxwrtXTGVR4m0AAutwo91oYbgP6vI3CFrVe?=
 =?us-ascii?Q?O+ug/BAYoTH+XuuknDldfZ4HnnFhBCP+OfSOAVMvaH5f7a7eiUAkjXtQazPe?=
 =?us-ascii?Q?peUvUo7hisyGdl30NIt+t4YgyliwfDhMGedh5DoeiKCqxF0+dhOV7ZKSn34C?=
 =?us-ascii?Q?3FbbqiONCBW9GAtc9cFSKHGmlRni6u1skmopMBI0cuUnPn1fBsbGyna1zdp/?=
 =?us-ascii?Q?zbNZdbzAn1QTsdrXxqde38O145bVRMfw9dQZPVzedXXWIoRyP2FOnXexS5tr?=
 =?us-ascii?Q?cRtBv18pfTwvzVKU72StwCFXs+4B/xjDiw2zSXdHAjPmJsHHqDKX2erVbgVa?=
 =?us-ascii?Q?hDjU52BVOxFisWS1KZpeKVUEARPyW8oST0+7W4S0hwATfMWMuylxqukBLlYy?=
 =?us-ascii?Q?rRY9/SBvVK3Hyl1QwxhiFgiSvGTV9tJ/24E6bewMfYKLMtnL23A9QY8vBGZd?=
 =?us-ascii?Q?aYHPXXDf5pTYeZ93ARAiLuRZ6ioFIDj2NiItYqvXydszumOjyoBXfQm+lpk+?=
 =?us-ascii?Q?L1mWbmHhhTIsqZRxSTEWqEPBk73qn2HJiZe9K60a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010880d6-56d4-4089-d97f-08dab61ea56e
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 00:19:57.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCUbrPOJ9QwpV8ySyfQ3Vx4sGyLd9p5eEsrTHbnRHBE1JjEdc/6oWmixmqJO8f8DjprAWAcManyaiNH3llbfwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:33:52AM +0800, Meng, Li (Jassmine) wrote:
> Hi all:
> 
> First, we modify amd-pstate-ut.sh to basic.sh as a basic test, mainly for
> AMD P-State kernel drivers. The purpose of this modification is to
> facilitate the subsequent addition of gitsource, tbench and other tests.
> You can test specific functions by specifying test cases.
> Default test all cases, include basic, tbench and gitsource etc.
> 
> Secondly, add tbench.sh trigger the tbench testing and monitor the cpu
> 
> Third, add gitsource.sh trigger the gitsource testing and monitor the cpu
> information.
> 
> Finally, modify rst document to introduce test steps and results etc.
> 

Series look good for me right now, thanks!
Next time, please send them to linux-kselftest@vger.kernel.org as well.

Acked-by: Huang Rui <ray.huang@amd.com>

Shuah, could you please take a look at these series?

Thanks,
Ray

> See patch series in below git repo:
> V1:https://lore.kernel.org/lkml/20220706073622.672135-1-li.meng@amd.com/
> V2:https://lore.kernel.org/lkml/20220804054414.1510764-1-li.meng@amd.com/
> V3:https://lore.kernel.org/lkml/20220914061105.1982477-1-li.meng@amd.com/
> 
> Changes from V1->V2:
> - selftests: amd-pstate: basic
> - - delete main.sh and merge funtions into run.sh
> - selftests: amd-pstate: tbench
> - - modify ppw to performance per watt for tbench.
> - - add comments for performance per watt for tbench.
> - - add comparative test on acpi-cpufreq for tbench.
> - - calculate drop between amd-pstate and acpi-cpufreq etc.
> - - plot images about perfrmance,energy and ppw for tbench.
> - selftests: amd-pstate: gitsource
> - - modify ppw to performance per watt for gitsource.
> - - add comments for performance per watt for gitsource.
> - - add comparative test on acpi-cpufreq for gitsource.
> - - calculate drop between amd-pstate and acpi-cpufreq etc.
> - - plot images about perfrmance,energy and ppw for gitsource.
> - Documentation: amd-pstate:
> - - modify rst doc, introduce comparative test etc.
> 
> Changes from V2->V3:
> - selftests: amd-pstate:
> - - reduce print logs for governor.
> - - add a check to see if tbench and the perf tools are already installed.
> - - install tbench package from apt or yum.
> - - correct spelling errors from comprison to comparison.
> 
> Changes from V2->V3:
> - selftests: amd-pstate:
> - - modify cover letter and commit logs.
> - Documentation: amd-pstate:
> - - modify some format questions.
> 
> Thanks, 
> Jasmine 
> 
> Meng Li (4):
>   selftests: amd-pstate: Modify amd-pstate-ut.sh to basic.sh.
>   selftests: amd-pstate: Trigger tbench benchmark and test cpus
>   selftests: amd-pstate: Trigger gitsource benchmark and test cpus
>   Documentation: amd-pstate: Add tbench and gitsource test introduction
> 
>  Documentation/admin-guide/pm/amd-pstate.rst   | 194 ++++++++-
>  tools/testing/selftests/amd-pstate/Makefile   |  11 +-
>  .../selftests/amd-pstate/amd-pstate-ut.sh     |  56 ---
>  tools/testing/selftests/amd-pstate/basic.sh   |  38 ++
>  .../testing/selftests/amd-pstate/gitsource.sh | 345 ++++++++++++++++
>  tools/testing/selftests/amd-pstate/run.sh     | 387 ++++++++++++++++++
>  tools/testing/selftests/amd-pstate/tbench.sh  | 334 +++++++++++++++
>  7 files changed, 1288 insertions(+), 77 deletions(-)
>  delete mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
>  create mode 100755 tools/testing/selftests/amd-pstate/basic.sh
>  create mode 100755 tools/testing/selftests/amd-pstate/gitsource.sh
>  create mode 100755 tools/testing/selftests/amd-pstate/run.sh
>  create mode 100755 tools/testing/selftests/amd-pstate/tbench.sh
> 
> -- 
> 2.34.1
> 
