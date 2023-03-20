Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8166C09BF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 05:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCTEka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 00:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCTEk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 00:40:28 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5731A971;
        Sun, 19 Mar 2023 21:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz79DCalhOqEUHIP0bmkzpkVOoSOMeREFrt1PXOsanmmxkIwPlr2ose9XNOP+W+J99o97/804cSp697KsE+iZqTqD7jzS6FksClo+nebHsmztTLqpOeg4W2t3rTDFvh6BSZ0Y0+uvlCyczX2cjN/hWOJGuBFgMk0gtMmtxRPhHkgS7y3S35oOQI3rhH3JuND2M+OYW/iqucRRUgohP/2HxMTswlWdaglsghXA0pLa5vgTrTiJrG8M1C3q4WRbCRC5Cks3MnZJQHx2qn/Ou06fwJz8CtfcyI++YuqwUF38gO7REAcWWq3pWHQsqZq/wjcDm7EG9Ys/oCL72SmBalQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1Hj2Bn/hMwqKf5HzYcRRvgkSWSrhzhIlhNbMAMMy1c=;
 b=H971GyWPD9cj8ZVwvMDzy+WnslauaxIyGTDTbhdXLtx/MQJTfoJ7UUMu7vsMk31H3M41HTdbOyTB6LO24PMSwYJzzvLt3XGs/jGZyBXDnJwvG7m24G8ZOK9QSycQS59/w6ZPYQgai7527uQgFQHH525sjL6PUiDTvil0FZDvK2JnFRzB1OhMM9bMh88UzpcYjtwTU9Muru8HV8J1+Ez9NXx+mBWgmqpefpbe+iIgvJo3s9gSpDloxKlDe2M3ZDq22T3p2dqor9U4dlmbiQi6XvrYQ8pWVFqhhAxZYkanMv11+0Sx+OTbiQl7dTnS4RgHwrMaXgdIU3oDPXKejpDFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1Hj2Bn/hMwqKf5HzYcRRvgkSWSrhzhIlhNbMAMMy1c=;
 b=mTXHZM1peIPola6vxd5sG29LfxPHcqZpv+q/DfgJaf12o6inWOSiv8w7OxVbz2QGrAbx6z2vt6zj8ZOhuASwLGP9hJwfk19iodpxfWVWIXJuSnOidrmIbXsaeksMQsaeQTy4WbQazzJGdlps1mLHBvVeJzrdehwrE+Wm18PdeFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 04:40:22 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::d1cf:3d4a:4882:7fd3]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::d1cf:3d4a:4882:7fd3%4]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 04:40:21 +0000
Date:   Mon, 20 Mar 2023 10:10:04 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Huang Rui <ray.huang@amd.com>, Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        gautham.shenoy@amd.com, Tor Vic <torvic9@mailbox.org>,
        Russell Haley <yumpusamongus@gmail.com>
Subject: Re: [PATCH v8 0/6] cpufreq: amd-pstate: Add guided autonomous mode
 support
Message-ID: <ZBfjpJAQRkzEb/+y@bhagirati.amd.com>
References: <20230307112740.132338-1-wyes.karny@amd.com>
 <CAJZ5v0gijQJeCpxgTOD6uj9Cjn8=C+FwX5Ub1SP3xe6ygCaX4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gijQJeCpxgTOD6uj9Cjn8=C+FwX5Ub1SP3xe6ygCaX4Q@mail.gmail.com>
X-ClientProxiedBy: PN3PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::20) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 13744f35-26b8-4895-7296-08db28fd36c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d4ujUQGmTqnf9fxgYvTSXgOxlvAKQmmgASWoUtnMm81ThCkxLadTBYAmyy1qeRGyambSj5LgQBBJk8Gl9QRRNWnbxpOTAUMegxENAav4KYMo7Yi0nZ+J/qFrIFVnx3Z+3pP7g6p7MD4qz2Eji2UnpHvs+cTNg6LYjZQHHdSBZwQ5DLkA5EaO+jNJ9TjkUPTmRaPBgqOlUAtPnWPUbqQMMJy2YOS/lQMFvHfbjNIGma6ovs2MCpbKEwvKJHp9txps5DLj2J6c9BcTWinXzC41KLGIby3RsozwLpTnV+a+C7jRh2/lHAWdU2fBA/x1PLamAS4IF3g0nkoMt/o6ia3nHlsMuEvTBNZqai+nFSUWFRalJjCYTaVkeaHkDiZEu5PmbgVgvCAOWEmsjANebJVdK8QZlca94cnxrY/4OccXiFsniKURc3PTtqL/qI72BXHan59pinnuTClFMu9vHwS3uSDKvqoKkH1DNfrFmAzdPCRyyrXr52D+WT9BNH4ioo6SGCua3c9EcXmT43FaOxkSdlFlu5dabruKEAAUq0cX/n2Q6GtuTmm+G2zm0Elb777Pwd5gXniVKcS+iZrNJmOZC7iKhJly3CINrk+cGoBoT/bYK3eLoP7Q5qlf0mveF8dy0r7EkyR+TMpWGupngVsF3Iax4Noh3ghluGH1GFEV8SQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199018)(26005)(6506007)(53546011)(6512007)(6666004)(966005)(316002)(83380400001)(8676002)(6916009)(6486002)(4326008)(54906003)(66476007)(186003)(478600001)(66946007)(5660300002)(7416002)(8936002)(44832011)(2906002)(41300700001)(66556008)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFovYVFLM0RlMkQyZEtrZjlzeW95Wit5NTdNc242Mmx0U3cwU25rakVKRWRw?=
 =?utf-8?B?TDRtU1ZBY1g2a2Rma2FIUk9iMG5NU3AwUGhsWEw3WTFEWnRTZGFRZk93STJ0?=
 =?utf-8?B?RERFck12VldySGh5V1FYVjFla1RVcDM1eXFnY1FCMWJXZXFkWjR4YzMxblZ2?=
 =?utf-8?B?MkZOVGR0eHMydWZTZ2FsblY2ZXZxU2JMY04rSGdmcndxUStWamgzWUVlYk9j?=
 =?utf-8?B?eFA0cnh6MTgwRGVFWnUxbG56V08xOHlYckl6aXU1WkIwalo0Wm1HT0t4Nkpr?=
 =?utf-8?B?ME1BRTdTK2ZhTkJxb2oyazZHUVBMUzlZUStZWkJ6dVVCZHZQejRDVGtFZlkw?=
 =?utf-8?B?MU9sWUpDRVR3Qm1xNzRRTURUTzhpSkUrODdDY0QybzdBT0xsRCtldDJZNUMw?=
 =?utf-8?B?SDFxRFduVG1kMHV5c3BWSGdiZXZUSk1mRnNxbGNjNG5aLzNDUmV2YXRrM3cr?=
 =?utf-8?B?V3hTQ0xnRVRvb0wzcExHUEIwYXBDVVhqV3UyYkJQMHUydERJaHlZczJXMlVl?=
 =?utf-8?B?RVdsNGFGRFhpdmNiMzZCU0g3L2ZhK0NFOUl5SGRQMkdFOXlrbU55ckJldlRq?=
 =?utf-8?B?V0hEVjJjb1NvSHV4cUtRYzlobEV2RGE5bHBIdGdBazBWZnUrZ0tZSmw2MnZH?=
 =?utf-8?B?a1BRQkkzSHZYTUJVazNNTHBRMlorQW5VTDNKNDZkZmtObmpLRmN0c2pQaU52?=
 =?utf-8?B?SDV1cXhOQnIzamVZbUNWR05QeGh5L1RTd1JIbkZ4UjZSVlJ3Q0pJYzVKN3dJ?=
 =?utf-8?B?VUxwS080SWtINW5taHR1R2ZHQ1NxUUQ0cnNCZHhJaG5KRWxxTm9VL2hkUWx6?=
 =?utf-8?B?UTBvQk1qVlM3b0s3REVxZ2tPL29mNlRFY3FPV3MybnVLeTU5ejZvT1NKTTZX?=
 =?utf-8?B?bU1nMFFJSC8vQVFFZjdvaGx2WHVJNXZoOFJKUm45UjBFdzhkU1NncHVRZG9n?=
 =?utf-8?B?SVBSdHFkMW0rS1BqOGlWYTlIVjFoV2FIN3BZakhLVk8yQ0dyOTRWdlBmS05p?=
 =?utf-8?B?VzVVb3ZOVGVWTlVuUVpkMGtzcTJnSVNhYitQYXVESG8rZTFpQWNhZ3RkNXds?=
 =?utf-8?B?TUtaTWtJRkVadElNaXoyVlYvZDVvL21wVTZrZkF5bG1EbDlyMHBGZlVpUmNU?=
 =?utf-8?B?ckFWT0JXOXhLQU1HK0dIZGtMZmFiWTVybWxVckRVaUdDTFJBcndYUFZGbDFt?=
 =?utf-8?B?VUZzNHRncGVUam9FTHI2alpLVENTSS9SR0hXVVFGVXBYM0NLVHJra2d4VU4y?=
 =?utf-8?B?U2hMbzZlTW9JRVRZNVM0VDN5UEM0N0xGK3RzUE1UejBUdTJVMUtMVjM4TW9s?=
 =?utf-8?B?Z2lSLzVkTnZTR3AyelEwTEhkdURZVXlwOHg2eG1rZkd1a1lEa2hzd2dpT0xx?=
 =?utf-8?B?OWoxTk9tbXVRV1V4cVN3RWhZOW1yRU11VXhvQnZ4NUpxWitzcWt3ZFNiYjZt?=
 =?utf-8?B?eW9WcXBHeXRwdkhhKzNqSE9QbFpYUCtOcnE0TE5nWEVzRzVYcHBLdFZtRis3?=
 =?utf-8?B?NkdUY1B5TnFJaHFVRDBLMkZGam81UFFMVkFUZENhVkFUSnZjbVlZc1BSMVZC?=
 =?utf-8?B?VGFjNmJ0RFQvS25JMkJ6d2RQb25FYm5BQ1hzRFlkMmVWSnY5YnNIZVNPOW9K?=
 =?utf-8?B?bHBtejNuOXFnenA2cFhrZXBTMkI2Ym1VeFVocGloak9sSEFHaGFwUGpyVmVS?=
 =?utf-8?B?TXlXRTJtSFJsM2ZBTlBqd0M4dEVMRmhmWkg5TklDQUNZanMySk51RGlJdGVR?=
 =?utf-8?B?RURLc3JXaXBHV01rVFN6RkpPdG9Rd2tBOHRwVDc4NnVONWxUbHNpVGo2Vy9h?=
 =?utf-8?B?R0lZVlJidzZXT2k0WWc0UFpBZloyempkRUxRN20rUVI2cGkzZXh6VGNsS3JW?=
 =?utf-8?B?TXE2ZlRMaXhuUHQxMGZseVJ0MWlQUmVpYktmNmNGNE1aZHhIcHJwL0hLbFN5?=
 =?utf-8?B?YnA1cFc1MHA4Z3B3MUJXY0tGZU5CRTR4cDYzdnM4aUVTNk5uTGVNakVLei9K?=
 =?utf-8?B?aWh1N04vclJVekUyWkN1TWZUTm9nOVNCT3JqVm5rZXNuLzhBRGtQYTJhdVcx?=
 =?utf-8?B?WGJJSnhVc3hvT3pjeHlsU0VRb3g2bXpkTXhRQi9MZUxPTHVJa0VtQTFyZk9Z?=
 =?utf-8?Q?spmcIkyrlxfXxTFYy19jzCe8B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13744f35-26b8-4895-7296-08db28fd36c2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 04:40:21.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJTV7BfkpNzzPTSIUWeRvzH937mnDnq3Hwac908bnFXnPXJ7452qf2AV7YgIo4bADxCq6FsdS1o+4K7kqIPegw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 17 Mar 19:10, Rafael J. Wysocki wrote:
> On Tue, Mar 7, 2023 at 12:28 PM Wyes Karny <wyes.karny@amd.com> wrote:
> >
> > From ACPI spec[1] below 3 modes for CPPC can be defined:
> > 1. Non autonomous: OS scaling governor specifies operating frequency/
> >    performance level through `Desired Performance` register and platform
> > follows that.
> > 2. Guided autonomous: OS scaling governor specifies min and max
> >    frequencies/ performance levels through `Minimum Performance` and
> > `Maximum Performance` register, and platform can autonomously select an
> > operating frequency in this range.
> > 3. Fully autonomous: OS only hints (via EPP) to platform for the required
> >    energy performance preference for the workload and platform autonomously
> > scales the frequency.
> >
> > Currently (1) is supported by amd_pstate as passive mode, and (3) is
> > implemented by EPP support[2]. This change is to support (2).
> >
> > In guided autonomous mode the min_perf is based on the input from the
> > scaling governor. For example, in case of schedutil this value depends
> > on the current utilization. And max_perf is set to max capacity.
> >
> > To activate guided auto mode ``amd_pstate=guided`` command line
> > parameter has to be passed in the kernel.
> >
> > Below are the results (normalized) of benchmarks with this patch:
> > System: Genoa 96C 192T
> > Kernel: 6.3-rc1 + patch
> > Scaling governor: schedutil
> >
> > ================ dbench comparisons ================
> > dbench result comparison:
> > Here results are throughput (MB/s)
> > Clients:   acpi-cpufreq            amd_pst+passive         amd_pst+guided
> >     1      1.00 (0.00 pct)         1.01 (1.00 pct)         1.02 (2.00 pct)
> >     2      1.07 (0.00 pct)         1.06 (-0.93 pct)        1.07 (0.00 pct)
> >     4      1.68 (0.00 pct)         1.70 (1.19 pct)         1.72 (2.38 pct)
> >     8      2.61 (0.00 pct)         2.68 (2.68 pct)         2.76 (5.74 pct)
> >    16      4.16 (0.00 pct)         4.24 (1.92 pct)         4.53 (8.89 pct)
> >    32      5.98 (0.00 pct)         6.17 (3.17 pct)         7.30 (22.07 pct)
> >    64      8.67 (0.00 pct)         8.99 (3.69 pct)        10.71 (23.52 pct)
> >   128     11.98 (0.00 pct)        12.52 (4.50 pct)        14.67 (22.45 pct)
> >   256     15.73 (0.00 pct)        16.13 (2.54 pct)        17.81 (13.22 pct)
> >   512     15.77 (0.00 pct)        16.32 (3.48 pct)        16.39 (3.93 pct)
> > dbench power comparison:
> > Clients:   acpi-cpufreq            amd_pst+passive         amd_pst+guided
> >     1      1.00 (0.00 pct)         1.00 (0.00 pct)         1.04 (4.00 pct)
> >     2      0.99 (0.00 pct)         0.97 (-2.02 pct)        1.02 (3.03 pct)
> >     4      0.98 (0.00 pct)         0.98 (0.00 pct)         1.02 (4.08 pct)
> >     8      0.98 (0.00 pct)         0.99 (1.02 pct)         1.02 (4.08 pct)
> >    16      0.99 (0.00 pct)         1.00 (1.01 pct)         1.04 (5.05 pct)
> >    32      1.02 (0.00 pct)         1.02 (0.00 pct)         1.07 (4.90 pct)
> >    64      1.05 (0.00 pct)         1.05 (0.00 pct)         1.11 (5.71 pct)
> >   128      1.08 (0.00 pct)         1.08 (0.00 pct)         1.15 (6.48 pct)
> >   256      1.12 (0.00 pct)         1.12 (0.00 pct)         1.20 (7.14 pct)
> >   512      1.18 (0.00 pct)         1.17 (-0.84 pct)        1.26 (6.77 pct)
> >
> > ================ git-source comparisons ================
> > git-source result comparison:
> > Here results are throughput (compilations per 1000 sec)
> > Threads:   acpi-cpufreq            amd_pst+passive         amd_pst+guided
> >   192      1.00 (0.00 pct)         0.93 (-7.00 pct)        1.00 (0.00 pct)
> > git-source power comparison:
> > Threads:   acpi-cpufreq            amd_pst+passive         amd_pst+guided
> >   192      1.00 (0.00 pct)         1.00 (0.00 pct)         0.96 (-4.00 pct)
> >
> > ================ kernbench comparisons ================
> > kernbench result comparison:
> > Here results are throughput (compilations per 1000 sec)
> > Load:      acpi-cpufreq            amd_pst+passive         amd_pst+guided
> > 32         1.00 (0.00 pct)         1.01 (1.00 pct)         1.02 (2.00 pct)
> > 48         1.26 (0.00 pct)         1.28 (1.58 pct)         1.25 (-0.79 pct)
> > 64         1.39 (0.00 pct)         1.47 (5.75 pct)         1.43 (2.87 pct)
> > 96         1.48 (0.00 pct)         1.50 (1.35 pct)         1.49 (0.67 pct)
> > 128        1.29 (0.00 pct)         1.32 (2.32 pct)         1.33 (3.10 pct)
> > 192        1.17 (0.00 pct)         1.20 (2.56 pct)         1.21 (3.41 pct)
> > 256        1.17 (0.00 pct)         1.18 (0.85 pct)         1.20 (2.56 pct)
> > 384        1.16 (0.00 pct)         1.17 (0.86 pct)         1.21 (4.31 pct)
> > kernbench power comparison:
> > Clients:   acpi-cpufreq            amd_pst+passive         amd_pst+guided
> >    32      1.00 (0.00 pct)         0.97 (-3.00 pct)        1.00 (0.00 pct)
> >    48      0.87 (0.00 pct)         0.81 (-6.89 pct)        0.88 (1.14 pct)
> >    64      0.81 (0.00 pct)         0.73 (-9.87 pct)        0.77 (-4.93 pct)
> >    96      0.75 (0.00 pct)         0.74 (-1.33 pct)        0.75 (0.00 pct)
> >   128      0.83 (0.00 pct)         0.79 (-4.81 pct)        0.83 (0.00 pct)
> >   192      0.92 (0.00 pct)         0.88 (-4.34 pct)        0.92 (0.00 pct)
> >   256      0.92 (0.00 pct)         0.88 (-4.34 pct)        0.92 (0.00 pct)
> >   384      0.92 (0.00 pct)         0.88 (-4.34 pct)        0.92 (0.00 pct)
> >
> > ================ tbench comparisons ================
> > tbench result comparison:
> > Here results are throughput (MB/s)
> > Clients:   acpi-cpufreq            amd_pst+passive         amd_pst+guided
> >     1      1.00 (0.00 pct)         0.70 (-30.00 pct)       1.37 (37.00 pct)
> >     2      2.64 (0.00 pct)         1.39 (-47.34 pct)       2.70 (2.27 pct)
> >     4      4.89 (0.00 pct)         2.75 (-43.76 pct)       5.28 (7.97 pct)
> >     8      9.46 (0.00 pct)         5.42 (-42.70 pct)      10.22 (8.03 pct)
> >    16     19.05 (0.00 pct)        10.42 (-45.30 pct)      19.94 (4.67 pct)
> >    32     37.50 (0.00 pct)        20.23 (-46.05 pct)      36.87 (-1.68 pct)
> >    64     61.24 (0.00 pct)        43.08 (-29.65 pct)      62.96 (2.80 pct)
> >   128     67.16 (0.00 pct)        69.08 (2.85 pct)        67.34 (0.26 pct)
> >   256    154.59 (0.00 pct)       162.33 (5.00 pct)       156.78 (1.41 pct)
> >   512    154.02 (0.00 pct)       156.74 (1.76 pct)       153.48 (-0.35 pct)
> > tbench power comparison:
> > Clients:   acpi-cpufreq            amd_pst+passive         amd_pst+guided
> >     1      1.00 (0.00 pct)         0.97 (-3.00 pct)        1.08 (8.00 pct)
> >     2      1.04 (0.00 pct)         0.97 (-6.73 pct)        1.11 (6.73 pct)
> >     4      1.12 (0.00 pct)         0.99 (-11.60 pct)       1.18 (5.35 pct)
> >     8      1.25 (0.00 pct)         1.04 (-16.80 pct)       1.31 (4.80 pct)
> >    16      1.53 (0.00 pct)         1.13 (-26.14 pct)       1.58 (3.26 pct)
> >    32      2.01 (0.00 pct)         1.36 (-32.33 pct)       2.03 (0.99 pct)
> >    64      2.58 (0.00 pct)         2.14 (-17.05 pct)       2.61 (1.16 pct)
> >   128      2.80 (0.00 pct)         2.81 (0.35 pct)         2.81 (0.35 pct)
> >   256      3.39 (0.00 pct)         3.43 (1.17 pct)         3.42 (0.88 pct)
> >   512      3.44 (0.00 pct)         3.44 (0.00 pct)         3.44 (0.00 pct)
> >
> > Change log:
> >
> > v7 -> v8:
> > - Rebased on top of 6.3-rc1 tip
> > - Pickup tested-by flag by Oleksandr
> 
> This series has been applied as 6.4 material, but I generally prefer
> ACPI and CPPC to be spelled in capitals in patch subjects and you
> should be more careful about comments and white space added by your
> patches (I have fixed up a few assorted issues of these types in the
> patches).
> 
> Thanks!

Thank you for taking this patch series.

Regards,
Wyes

> 
> > v6 -> v7:
> > - Addressed comments by Ray
> > - Reorder and rebase patches
> > - Pick up Ack by Ray
> >
> > v5 -> v6:
> > - Don't return -EBUSY when changing to same mode
> >
> > v4 -> v5:
> > - Rebased on top of EPP v12 series
> > - Addressed comments form Mario regarding documentation
> > - Picked up RB flags from Mario and Bagas Sanjaya
> >
> > v3 -> v4:
> > - Fixed active mode low frequency issue reported by Peter Jung and Tor Vic
> > - Documentation modification suggested by Bagas Sanjaya
> >
> > v2 -> v3:
> > - Addressed review comments form Mario.
> > - Picked up RB tag from Mario.
> > - Rebase on top of EPP v11 [3].
> >
> > v1 -> v2:
> > - Fix issue with shared mem systems.
> > - Rebase on top of EPP series.
> >
> > [1]: https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> > [2]: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd.com/
> > [3]: https://lore.kernel.org/linux-pm/20230131090016.3970625-1-perry.yuan@amd.com/
> >
> > Wyes Karny (6):
> >   acpi: cppc: Add min and max perf reg writing support
> >   acpi: cppc: Add auto select register read/write support
> >   Documentation: cpufreq: amd-pstate: Move amd_pstate param to
> >     alphabetical order
> >   cpufreq: amd-pstate: Add guided autonomous mode
> >   cpufreq: amd-pstate: Add guided mode control support via sysfs
> >   Documentation: cpufreq: amd-pstate: Update amd_pstate status sysfs for
> >     guided
> >
> >  .../admin-guide/kernel-parameters.txt         |  40 ++--
> >  Documentation/admin-guide/pm/amd-pstate.rst   |  31 ++-
> >  drivers/acpi/cppc_acpi.c                      | 121 +++++++++++-
> >  drivers/cpufreq/amd-pstate.c                  | 177 +++++++++++++-----
> >  include/acpi/cppc_acpi.h                      |  11 ++
> >  include/linux/amd-pstate.h                    |   2 +
> >  6 files changed, 302 insertions(+), 80 deletions(-)
> >
> > --
> > 2.34.1
> >
