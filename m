Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C8460053E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 04:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiJQCef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 22:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiJQCe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 22:34:27 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0BDC61;
        Sun, 16 Oct 2022 19:34:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JD5Y8D+Syf0hdQpArdGaYc4N2W9X5nlI46VBbUC3QmLmSw2TE0047APbDM7D6RzgNt02BmVocNB+PP0PR3Xey1+0nl+/mo/ilx+caT1IK94NtNTpOo3S6CS+AomzFGlaeeZr/eFkMjZ1QSOOC57DeP+GXlSOz0oFQtApQJQVX4zTPLng/E8+pCIaFalp5DNTgkAG+4zlou86HhMZnLnKm5dd2JoJytAus0uuoP37NiFUTZDopay0YmPI0nIIOvWbObqlSt16IbcQGzWOSu46eaACOkGF6AHDuAd0e/Y0VQ7EoMSRmw4+ep64Z0aVozz9V0yXfn8JZ3b21ZOpEdNezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X16Vyoc/jBFItkiRSAU2AK6ckm6FA9Am0qSyUYY+23k=;
 b=PKORq1SWgI9YRleReOHU38TudN3uqUKwtpYB9JuOvnSqAnXlVktRZyGFkkPyg8vE4ITPfukX7mI44WcbjEUdMtBQYEHFVFecvYSxsTm6thyiLtHDoQvdR9eZAvFpaFBgYimxEOR89neS5XMEmariW/1ygxvLp9sjZtZNmlHpcMkpksa0TQBSvakT1qMwJwj0teDLF53F8zqvHUenFm6agADon/+QkpyfbMMHrqxI8iQYegkdnlHdAGlj5iD8kOE062jn/zj6CgrxsVD09np/T0yuI5hUmFd7SfGMsLpBH3qVtAAm29XTwpz+MDZJ8NvEMPXbhSyUZQ+5bkvU/t/+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X16Vyoc/jBFItkiRSAU2AK6ckm6FA9Am0qSyUYY+23k=;
 b=UTks0nsBZtDTPGUw4e7hW9qUwp1IFgojwUGcfstbVBGLFB6cTq/f0rYO8LijhysZvF63f/+8l9DGgOHhf8y8phYgdo+6ChnTKPiZQbI7dOhUXtkZ9k2oKcnP3VHaKHMBMEToNqZ6Mzt/sRapkNTa4z42mZ0D1laqNvqCUs6EsjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 CY8PR12MB7124.namprd12.prod.outlook.com (2603:10b6:930:5f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.33; Mon, 17 Oct 2022 02:34:18 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 02:34:18 +0000
Date:   Mon, 17 Oct 2022 10:33:53 +0800
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
Subject: Re: [PATCH V3 0/4] Add tbench/gitsource new test cases for
 amd-pstate-ut
Message-ID: <Y0y/EeA5uWTFWLHJ@amd.com>
References: <20220914061105.1982477-1-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914061105.1982477-1-li.meng@amd.com>
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|CY8PR12MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f5c7ad-80de-4bcc-6ae3-08daafe81738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tF5QlAKfuvF0cwgw3xrvyWtTd1g73jmWtjuMLR7LTe8DOZdT3mfz6OwE/riUmbTiNKp/9HDLm2pMzPD6XShQKxUoqB+zLydsi8b1DFgvmtSXTv85CAsK1p7gMUbZksBTKhq0ix3cYHF0f8RV9WxEj0Q8r2YiKXPPCpITc4JFACADetm+6yu4wYgF3wjhFRUvOOkFpgWQO4OuphJ9nifuPEDUcEhyIzG6LjwEIJozuLk/vZ7szxeyPhcgqzgRee/h2rSkLm/dEh+6adVDMNDI/6Idq+DV79WsLJAG1oCy8YyWXPswTUtTeRX5joS6dRzUNvMa8v7RYKiPSnsRaaIqY/sdyHKpnn8B8E1UpqkMmHCaKmpxADXG0QCxoAu091NGjHl/wARWvI/ZsyoJdUkbdwPcZ7MbBrEbr/AC5lVSV0nWJ6+P0G8qeY+obFQmhjwKUKCzeTbcFCVX+MFyUUdabB5bOJA9mLBmjasSTwgOqDkiO11GMOdc/pLO30F92oVyKxKfsgLC/P1wyHFq7keaPExsw7bU7MxJ1hSkuhNMzN829oQ8xsy2LZJ4QaiIIvlDP2+4KK1eYeE1WXCcBVv8OtWpnBcru6TuO/qb/Ejp/arY+htOaL+1G8wEz2eAk+dh/rkBIOXF14unXQZ/NGHA3r8+YQpHbY1cv03PYYmV9Dfds1TP855j6ipUPaV491Nh8D2C5/26CtvMy//MY6QfA/cSjsdxXwicJ2QV2zV2TKa3mTliZV13wrYZOd7LAZNA6FkpJqSsurhAB0kKQe8T9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(2906002)(6506007)(6512007)(186003)(41300700001)(36756003)(83380400001)(26005)(8936002)(5660300002)(6862004)(2616005)(38100700002)(86362001)(6636002)(316002)(54906003)(37006003)(66476007)(66556008)(6666004)(6486002)(478600001)(4326008)(66946007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i1/crU8YubwiCbQo5RDdD1ksOBU50x8JyDFNgKUaWIQ6B86Un7aOetdSPOoq?=
 =?us-ascii?Q?5Ej1sOr/o00w60rsTfNy153UqnZmvSHAX1cZWKiRjg3dAoDdetSvzKvsa3Pk?=
 =?us-ascii?Q?5md3yTLYwbrtdt7OFp2lxvTKXeERFAIAWZIeTy4LYE/gjU8tEFU27FLAgYwS?=
 =?us-ascii?Q?77ir+Yjna2DITA3ZYFIDrp6+Z9a9QW4fMaIE7+o7KDxLJP+h2Xyet1K5klj9?=
 =?us-ascii?Q?3bmJqUrAO3NxjnDurGuciVuGLqLwfbjnxZKutg9eEQ7dBNH3WNHpKKTa09fy?=
 =?us-ascii?Q?hU3IjkjphuSw0D66b4PjKPZQ1XF0JRhZsv5yRoNxPpb6gA/KbkAEWTd2gbpo?=
 =?us-ascii?Q?2IXZ5QL7pb5HmfoS66kTubR39uTO4ULNT/21x/ua05bU1VZbjpOh+CjGm0HQ?=
 =?us-ascii?Q?EyJPGLqBrK+vfsMvM9qSkQ81Tb2acQF5pwvHbCM2NtGdpl+T92X7cPRFeiWA?=
 =?us-ascii?Q?/2JFVSqoLELrT7gUGAu5FKtH/gjnRfWTJQEj0lemSipP3Aq06NdhBfCaVwwp?=
 =?us-ascii?Q?HgF6PdItr/nPI6yKyyH7IupQRniFuNlAVkcPOEBBV0btxRPM3tgqjqFDfLAy?=
 =?us-ascii?Q?tEmO+2FGN8YEyczLaKu67168gpqTpcQW0C7SZMAT+bJEq3Q54TmLyoO/wLIb?=
 =?us-ascii?Q?DwBCFBMqsqDgaGwbbu7En1jerKn4MEkVJSLwe/1urZBva1Tq1qFX0KWG1akk?=
 =?us-ascii?Q?XJ0jdk6HyD6Mzh2si82wFFxbuUZmfEq4fQzGr9QDdVfWZyIKRPQT2xxJCOdZ?=
 =?us-ascii?Q?s/ku0O06cNO7maKQ+FaBK2GyoK8I125OtBLTbMimJwMp/EiNsvaC0X3WhsxA?=
 =?us-ascii?Q?qcZTgFAPIlIotb8UVeFXRT58X8Ij1l+W8T4nbYtSC/d7nFasrzuNEjoxgYrI?=
 =?us-ascii?Q?58l4qjPcxjIFNgZhpHiIbokyWn0wBxt1G/OScbrbslQ+4kuaQGWZawceLTa6?=
 =?us-ascii?Q?pZVg1lhWhhL/p8e+bv3aUj/5tBXmzH6229p1A4DXrMZeKL4WjNUrBoJrT7FX?=
 =?us-ascii?Q?IpwraPgV6E92upOdKLJAXY09i4949DZygsM6Qyv23hzV0hvderVbQ54WVEen?=
 =?us-ascii?Q?y28w10GCMDzxTrDVa26IH0F8hg8sTRXK91GTeeWnucFNQBW77cY0n8L5pjGA?=
 =?us-ascii?Q?NUsdx/JHQrubTKUEPXIgr5Udvd6RNPf+jV6dZ0gigaJVKEv44vaxtvvxe0gK?=
 =?us-ascii?Q?VmRnnE9X6X7qGIsru0ZZKGpetq9/t44yFs7GPvjBjRPSNhOLiS8FVmMkT/nl?=
 =?us-ascii?Q?IZ+/WpVZog5beGP6UBpfvoQFXfQJrjB4/j23jH7+ierZ1YQaVIm/M9JtN/of?=
 =?us-ascii?Q?SMpo4hTbDAmtyhouV1qxZyAWcfET3eb3W8B7i8bi5pSe4HFlx9xvv4ZyG/Rh?=
 =?us-ascii?Q?4f/lROcEiuBsyIgyoZW8HGoWNzWCog9Hc8Zwnxq0D69fGUjpKCHVEpVkv5yV?=
 =?us-ascii?Q?GiiKWHNNO+pDr15o3qutrt1cSnWETiHghNAHJiGTT+HBWuEX4/TtH+k6Fa8P?=
 =?us-ascii?Q?eoN99UGFd8QlhJWoPijRf1AKNxm2d4+EzDF4+z8Yg4ceaINuOtFi/eFDM/aB?=
 =?us-ascii?Q?ke93mBP3Y7bD+plSE3A4fVKDTG2dHwdMCD7PvMuW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f5c7ad-80de-4bcc-6ae3-08daafe81738
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 02:34:18.5849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nu0DX1OCbTNYCDNlbQQuH6jacxV2PhlLosxAUPtnXQDNmZ4ycs4Br8vHahNtjpmphlTDOWr8JlGJwDXQ8HPwHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 02:11:01PM +0800, Meng, Li (Jassmine) wrote:
> Hi all:
> 
> First, we modify amd-pstate-ut.sh to basic.sh as a basic test, mainly for
> AMD P-State kernel drivers. The purpose of this modification is to
> facilitate the subsequent addition of gitsource, tbench and other tests.
> You can test specific functions by specifying test cases.
> Default test all cases, include basic, tbench and gitsource etc.
> 
> Secondly, add tbench.sh trigger the tbench testing and monitor the cpu
> information.
> 1) Download and install tbench codes.
> 2) Run tbench benchmark on specific governors, ondemand or schedutil.
> 3) Run tbench benchmark comparative test on acpi-cpufreq kernel driver.
> 4) Get desire performance, frequency, load by perf.
> 5) Get power consumption and throughput by amd_pstate_trace.py.
> 6) Analyse test results and save it in file selftest.tbench.csv. 
> 7) Plot png images about performance, energy and performance per watt
> for each test.
> 
> Third, add gitsource.sh trigger the gitsource testing and monitor the cpu
> information.
> 1) Download and tar gitsource codes.
> 2) Run gitsource benchmark on specific governors, ondemand or schedutil.
> 3) Run tbench benchmark comparative test on acpi-cpufreq kernel driver.
> 4) Get desire performance, frequency, load by perf.
> 5) Get power consumption and throughput by amd_pstate_trace.py.
> 6) Get run time by /usr/bin/time.
> 7) Analyse test results and save it in file selftest.gitsource.csv. 
> 8) Plot png images about time, energy and performance per watt
> for each test.
> 

The cover letter won't be included into kernel commit. Above steps
are even clearer than the original patch commit message. So I suggest you
can move them into related commit log.

TBench steps -> Patch 2
Gitsource steps -> Patch 3

Thanks,
Ray

> Finally, modify rst document to introduce test steps and results etc.
> 
> See patch series in below git repo:
> V1:https://lore.kernel.org/lkml/20220706073622.672135-1-li.meng@amd.com/
> V2:https://lore.kernel.org/lkml/20220804054414.1510764-1-li.meng@amd.com/
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
> Thanks, 
> Jasmine 
> 
> Meng Li (4):
>   selftests: amd-pstate: Modify amd-pstate-ut.sh to basic.sh.
>   selftests: amd-pstate: Trigger tbench benchmark and test cpus
>   selftests: amd-pstate: Trigger gitsource benchmark and test cpus
>   Documentation: amd-pstate: Add tbench and gitsource test introduction
> 
>  Documentation/admin-guide/pm/amd-pstate.rst   | 192 ++++++++-
>  tools/testing/selftests/amd-pstate/Makefile   |  11 +-
>  .../selftests/amd-pstate/amd-pstate-ut.sh     |  56 ---
>  tools/testing/selftests/amd-pstate/basic.sh   |  38 ++
>  .../testing/selftests/amd-pstate/gitsource.sh | 345 ++++++++++++++++
>  tools/testing/selftests/amd-pstate/run.sh     | 387 ++++++++++++++++++
>  tools/testing/selftests/amd-pstate/tbench.sh  | 334 +++++++++++++++
>  7 files changed, 1287 insertions(+), 76 deletions(-)
>  delete mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
>  create mode 100755 tools/testing/selftests/amd-pstate/basic.sh
>  create mode 100755 tools/testing/selftests/amd-pstate/gitsource.sh
>  create mode 100755 tools/testing/selftests/amd-pstate/run.sh
>  create mode 100755 tools/testing/selftests/amd-pstate/tbench.sh
> 
> -- 
> 2.34.1
> 
