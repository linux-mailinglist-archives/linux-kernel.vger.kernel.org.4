Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7B560065B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 07:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJQFfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 01:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJQFfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 01:35:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D694C606;
        Sun, 16 Oct 2022 22:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvctSSeKHxn3FtCFAstxrCdY4KbwH3pkR3HGQjFbQcVlC8Favq3dryeQO+qGxRmuB04YCjjsvZ2ip9BLS7nJtyGfEJOZymsV2oEg0xyxvSW97t/QUPyUVFaUCdnPPlMZiWPzyyc8u/WOJPPg1gaJoypr6qKl58j3hm7uiST/mLHlHZGYncy3U1wYXlSwGEV2SgGsCAVgpEGUS1+23l7+4Zz8DjGD/ov2vZvf/JhmndgzkBiArSxCGaD1HM20qN64KkCn473OJ1uICc5UksM2ZowKcey+PUca8L2b7wnRM6+kJTLNUhS88cEAtua3M6Tg26ekN13691YMDiScKoDgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b66oA5bc1X3pSL3ugdCZyG4oJeGmvHuyWOod68iU1c=;
 b=PxcGF3t4qKDMAfs6NSK7vR+Hv+VSLiYC9A50EDgDxPAM6VxJj9+n+7hIgYSxgL+TW0wV2JNaWMskO164MxwYUsVnzU6Ti3qAd+spwOLTE5d6qBOF5DbvD6dAsv7i5+sydqOSMsaFtqeeulaiwqvuxgzJ/RkAgkltthA5A6SuFUdCfeP/6HCiUBH0e6yGx0zWATXjfNjjL6CYiEhHeskNZv8nBEKcLx9/DzeYwHuSX8uRfz8O1Lrpljt/zc6WDl1yQSMqPn4yIDg2g+EkBWOMGutOov7YGeYDYhRRqS5hr8IulCvqF5Umpw2JUonrfBYsxUKH8Nvs3Tnza4YeY98meQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b66oA5bc1X3pSL3ugdCZyG4oJeGmvHuyWOod68iU1c=;
 b=dKUsH+4pWSNsDaFnw/BmEkRuIQaihRaDOaVuT6pQVOoXZPoaC3X7T9aEsbE40g94pQiJhKXnYB+89A+1JITwOrb531TF4z7dhHSkBXwfbF5sJaX+bWW2sNcvzSwZXA9CNj33iZWow46f6r59szMv8tsIJYEUiWI84xydbGW8B/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 IA1PR12MB6114.namprd12.prod.outlook.com (2603:10b6:208:3ea::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.29; Mon, 17 Oct 2022 05:35:04 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 05:35:04 +0000
Date:   Mon, 17 Oct 2022 13:34:39 +0800
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
Message-ID: <Y0zpb9XNa23uotk0@amd.com>
References: <20220914061105.1982477-1-li.meng@amd.com>
 <Y0y/EeA5uWTFWLHJ@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0y/EeA5uWTFWLHJ@amd.com>
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|IA1PR12MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f72b67d-38f2-4156-d131-08dab0015787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i884hge6hzWXdxpIPtZBtNgPChtBstwNnheDjoVv6lE4ZImf6qk24/n3fU34B+c6b92SwJUucYV7+XWN7/lPJDivaUNwwxrya65WNE5+sL+2G21u2DxP00lYKmVRIPtuUdiEyToEC7RMZ6rIzzde9p7WwDh3e+tc++wk3JN0hSRMyYa77BA7JlQstIYsZ5yuyjnfs21oCmqawnsRRQdfz6oqyBigZLBcgKDUeXKpukJ3jLyddu3CL628PAESPC8rf93kToRBpKHYtUTtNprSZRKE0oykJYdGTrBCj8+iL3lj5Q7ZV8tCBXQM1uVWellY/lshR3Bye6saJZ1q9dsi4YX4ZZre0EzC5GHJhWhItF/HVYZnUftol6u6ZU0S98HmUA+yO9g9UDpiSPCUUb70OzRJRxJQul0GYZvaYtW59jyhnyqNqiGBnC9V1xZDz6F8sG4BQVUmufV9SNtQiRhA4nbZpymVmzwkQunw9HKxkTGHfp0enZnSuP7e0vUjbv2AYkZr/jGS48GjXHEGpugNyK+hco3F0NNcCvvBRLIKx4h80Oewnb0SybHyUglMRQhcMrjw3vEJZKvLXh1eLbsYv2ztHVfGltHuKYtZYofAqPoDPtnN7yuMo7Re7KmtuqRIgaLWYTI8fVL+n8tJaEATZqzGCIZLAVXE2qbsVm64XpYZcPAWy/cmy8LYysdI3jZ+HoXVQUD4fb8ZMXieOFNCKlBqGl8itaw5Nc57vnS/kncvNmkC5yXM0DnNOUqnmyYFgTkqnX+ufzMf2GR6jk7CsDQmkRNMOAdMXwDWCkSlfrM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199015)(36756003)(86362001)(38100700002)(186003)(2906002)(5660300002)(6666004)(6506007)(26005)(2616005)(6512007)(478600001)(83380400001)(6486002)(316002)(6636002)(37006003)(54906003)(66946007)(66556008)(66476007)(8676002)(4326008)(41300700001)(6862004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pg3vEinCPDHhTl9IWMAHxbjCrhMmlhja/uSusWnRID3b/G5t6qdsx+Lxh4YB?=
 =?us-ascii?Q?lNiu+wS4GSIaVrhyQxSuRJG4iK45+idBvhCtDac8LxxzT0YquGjNqctMVEfU?=
 =?us-ascii?Q?2AZX2MAcRKMk8RphzDJHHEDH4CEbmvV/az+FzwhX1iLIq/mbfjoe6taaQKBU?=
 =?us-ascii?Q?ZG44by0Q4ZYdYTJJCbxN4C3PwJ4Qje4TPhgymlcI6XTQ3rB4ixynzy9H2Xbn?=
 =?us-ascii?Q?lNdaQxJA31sleme7cZSUXbXGEzukU9yA1+dBxCc0olTbQZFKPYwmLvChaSTN?=
 =?us-ascii?Q?nkvjVZb4uQcMXQx1/pdr3C+Nrq7/YeL41NDFTd1gS2Tj4F64cYxk6JQ3pWIN?=
 =?us-ascii?Q?aXyRybFqSEwiB6baqBjBirVNXn+e2TrQRAWgYQMbTgEUAkBg/AzgB7y17zRl?=
 =?us-ascii?Q?v+6i85UtajiUmsuTPFAmvGr2Q+0i7BQK+qs3BSsuM/weiTNIR1GPbRuDPwSB?=
 =?us-ascii?Q?9G+dwA0q3D66hD+FUh+D8A3vYPOYpFqs6Rg9Ojmj3q6ZKC7mx6cThd8vRpJ1?=
 =?us-ascii?Q?1HQha2UCWZxRVAl7YBTVS3vYlrs1t0Q41+uwhKkj5c0j6MDDGquRixRqy0/o?=
 =?us-ascii?Q?6j1rt6WDXxqCdebupuLAPO6XkM8xP7txqR7tFxZze3eU8RHxY9sziiI/5+Fs?=
 =?us-ascii?Q?GOm8WlTzu4Pdscv8bFmClPbADrUKXlRmuuAORPFOGHeAHg2nZR8yh5UJzPkO?=
 =?us-ascii?Q?pWLj2iyi008PUT/j3XKz4p+4Pfu/6cfjRFj9vCzN25uNC0tm3zRnxlnWT4bk?=
 =?us-ascii?Q?C6rSbXb26xzF05cQVGQsPmJGpwtRERv6RZSn20Mg3jB50GIkuMlOpQfjexEV?=
 =?us-ascii?Q?8cXP8lYFMIRRA7NCb9YhbfVDW7X3RfOGZUmvuW6NdpNpSC4NM5gi/1HrHIjW?=
 =?us-ascii?Q?2TS+wrYF+nuyjFAe/QQyV5wTwYyCXrXWv/61/bEAbKL1UGCEdHCDCjq6WYqk?=
 =?us-ascii?Q?lv35BYbk+mU5oVurZJyM8OjcWX+JbQg2tBHtB3RJnW4Za874HtNE2LVN4ZkL?=
 =?us-ascii?Q?cO0jBP0mNgYgGZr0jCAfKfLczc4qZ73664asd4fOScOrBs/w2SP/HfJPdcSF?=
 =?us-ascii?Q?YxerwNhrvYiP/KIN84DIwZ8MV1gDGIPtqTX38zrJ0WyQaiD1xSjOpd4liZW+?=
 =?us-ascii?Q?Cm4udm3Hju4S+wU/d26/azwIFqyhJlQSSLS6BWHBvhGtsgT7ZSBg7n7AMMQ6?=
 =?us-ascii?Q?WDc/aYw2AK5BW8U18EGqX1SVGa8xGo9RUVnyO6NOYkGH4aM8rpG3XIefuGxs?=
 =?us-ascii?Q?yB2mjXjeUv/CR/MDJxFnqWW51jJFBSaxFrXroY+BtY4hDnnQCYkAVGizH+UP?=
 =?us-ascii?Q?PdooXha0nc2tLfbaXn8uvAd78CXsxJPhU4HDCEkSFDMeXWD2ToGPx6vhwvKS?=
 =?us-ascii?Q?ILC65eQEbzowOtVfbPJe5Z7iDFueCxi8S/q9jg5CabbSS3n5yK9cXbeSseK3?=
 =?us-ascii?Q?YGicLilOIQLWIcZ9xVuSSFRauToFH4pHJDK2kFrgPzlFs/wgtHcAbWWz7eeY?=
 =?us-ascii?Q?5RVl5pr7TaKZLwfph7ODndCzEn+0R6uJeVp6JvR2sAklYhDj9RJffgvLDk+a?=
 =?us-ascii?Q?ondwzFKFhkqCfxvHWavq7R1IBICsMcSmzcKrPODn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f72b67d-38f2-4156-d131-08dab0015787
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 05:35:03.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKN6FSNi/1/hJZ38DfpCX968ZxfGJP4xJYvwoakJ/txWOPa464t8tgNCJq9OW/aU/R6ZJYzyixvOqv2pFJX2AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6114
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:34:18AM +0800, Huang Rui wrote:
> On Wed, Sep 14, 2022 at 02:11:01PM +0800, Meng, Li (Jassmine) wrote:
> > Hi all:
> > 
> > First, we modify amd-pstate-ut.sh to basic.sh as a basic test, mainly for
> > AMD P-State kernel drivers. The purpose of this modification is to
> > facilitate the subsequent addition of gitsource, tbench and other tests.
> > You can test specific functions by specifying test cases.
> > Default test all cases, include basic, tbench and gitsource etc.
> > 
> > Secondly, add tbench.sh trigger the tbench testing and monitor the cpu
> > information.
> > 1) Download and install tbench codes.
> > 2) Run tbench benchmark on specific governors, ondemand or schedutil.
> > 3) Run tbench benchmark comparative test on acpi-cpufreq kernel driver.
> > 4) Get desire performance, frequency, load by perf.
> > 5) Get power consumption and throughput by amd_pstate_trace.py.
> > 6) Analyse test results and save it in file selftest.tbench.csv. 
> > 7) Plot png images about performance, energy and performance per watt
> > for each test.
> > 
> > Third, add gitsource.sh trigger the gitsource testing and monitor the cpu
> > information.
> > 1) Download and tar gitsource codes.
> > 2) Run gitsource benchmark on specific governors, ondemand or schedutil.
> > 3) Run tbench benchmark comparative test on acpi-cpufreq kernel driver.
> > 4) Get desire performance, frequency, load by perf.
> > 5) Get power consumption and throughput by amd_pstate_trace.py.
> > 6) Get run time by /usr/bin/time.
> > 7) Analyse test results and save it in file selftest.gitsource.csv. 
> > 8) Plot png images about time, energy and performance per watt
> > for each test.
> > 
> 
> The cover letter won't be included into kernel commit. Above steps
> are even clearer than the original patch commit message. So I suggest you
> can move them into related commit log.
> 
> TBench steps -> Patch 2
> Gitsource steps -> Patch 3
> 
> Thanks,
> Ray
> 
> > Finally, modify rst document to introduce test steps and results etc.
> > 
> > See patch series in below git repo:
> > V1:https://lore.kernel.org/lkml/20220706073622.672135-1-li.meng@amd.com/
> > V2:https://lore.kernel.org/lkml/20220804054414.1510764-1-li.meng@amd.com/
> > 
> > Changes from V1->V2:
> > - selftests: amd-pstate: basic
> > - - delete main.sh and merge funtions into run.sh
> > - selftests: amd-pstate: tbench
> > - - modify ppw to performance per watt for tbench.
> > - - add comments for performance per watt for tbench.
> > - - add comparative test on acpi-cpufreq for tbench.
> > - - calculate drop between amd-pstate and acpi-cpufreq etc.
> > - - plot images about perfrmance,energy and ppw for tbench.
> > - selftests: amd-pstate: gitsource
> > - - modify ppw to performance per watt for gitsource.
> > - - add comments for performance per watt for gitsource.
> > - - add comparative test on acpi-cpufreq for gitsource.
> > - - calculate drop between amd-pstate and acpi-cpufreq etc.
> > - - plot images about perfrmance,energy and ppw for gitsource.
> > - Documentation: amd-pstate:
> > - - modify rst doc, introduce comparative test etc.
> > 
> > Changes from V2->V3:
> > - selftests: amd-pstate:
> > - - reduce print logs for governor.
> > - - add a check to see if tbench and the perf tools are already installed.
> > - - install tbench package from apt or yum.
> > - - correct spelling errors from comprison to comparison.
> > 

The series overall look good for me, only very a few comments. Thanks!

Could we please send V4 to address them?

Thanks,
Ray
