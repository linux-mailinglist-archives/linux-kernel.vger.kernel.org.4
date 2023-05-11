Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232186FEBDD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjEKGpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbjEKGpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:45:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA184C3F
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:45:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfBirSseJJbIKG1Qv5lapTyhJRdztmW49EScd7yWXwuVRItR+/Qk75QbT1HS5cJAaYWT14+l/i+FeAPsZcfnKgSGz0pWuRoLI9eXLhZiEEmmUwQT+w+TvcUzDQaSIlIX8DFzu3gigHABF9NWyNUaoIq+BoRLtFzC18zoR/J6FqEJ52dhDeL/5ro84GIaezVpmpQjwkeNnIroibDBKLBz0peLYvQPM75LXIVqbEK1WDHRD4dcYcPbZGi+c7wMT9kh5mcSs5Xot9c+GnJ2lTOw8gYoEAD6Lig1bvTh0vHtoDU8/aJpZVwUIqswzsbPLxTsOnvmcXO/XUHhWkZLgXkE6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rckVjdimZg4WdPtDOQrQYZPpJIeTUUo9G0aFEZEr9NQ=;
 b=jA7mBNwwZOLWAT1FJWsON10DZCfmx4sea+KOKyuE1YAagGI1ft+wbfVWGDjWWedPoW/IVxsSpH+MHfiOPA7MyR2ups3cGxeQLCLMUxAYca/gIvfhIlRdzwfiEfUYtDyNhR0gMCddsvVAIwQwOIJZrzFRrBJtrwn2zrzH08hniDYNtbSaeSC1PZMdo+QCo5WX93oMvEhxmVTF3Sx96TZ7AUukEaaZtUcyV8mZFAiXLw93LPYwOSrh8YkTIhtSeFTcxXx7d16Vzng5N9Y1dQZLj5mjZU0E+nzZPpYI+Ase8lUavKGIWKkLcoP2Rvp/gftbXpOShS+vE7Fgk85YngjeNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rckVjdimZg4WdPtDOQrQYZPpJIeTUUo9G0aFEZEr9NQ=;
 b=Qo1/6j8Fd7p876rTGqd+jUXN8RmXXwctMBODYz1BUvT7rx0zV7d92OLJ5tEK8XqUofQ3cvnmY5NNrTtCmTSi17tRYYen9R1/uFnIwwj6uOI3zwYs/psSkfxxIEaXc1h+J0k6VhZrftT90aP6EiGGDCexEBfa0Q880I+rFvfKdS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by BN9PR12MB5177.namprd12.prod.outlook.com (2603:10b6:408:11a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 06:44:59 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::13fd:6611:29cf:a351]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::13fd:6611:29cf:a351%4]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 06:44:59 +0000
Message-ID: <db995c11-08ba-9abf-812f-01407f70a5d4@amd.com>
Date:   Thu, 11 May 2023 12:14:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [linus:master] [sched/numa] fc137c0dda:
 autonuma-benchmark.numa01.seconds 118.9% regression
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Hildenbrand <david@redhat.com>,
        Disha Talreja <dishaa.talreja@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
        yu.c.chen@intel.com
References: <202305101547.20f4c32a-oliver.sang@intel.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <202305101547.20f4c32a-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::28) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|BN9PR12MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: c933b0f8-12ba-438d-a5e8-08db51eb3d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eE5/iVnGIBnLWilOvIcA/FNSeVXZOSvVPRqExY4t8MxGk90pa0wWkLyIyeKx6NaZ58G2UlW3u5+M0dlFBTmL2kD1giSsVrTePzvcNeQJ2ggxrZ4fMcY2kXgZrpqhl7eaUy54yEZm4eQRBloYIM17ZZ+J+VBBT5AWeLIngLBVIbgKdJoApYtwXWyPRDA5Iox4a/QboXQ8GduePC9AbFx8X71naB0IgIdzLpGIjhviyRyijZ/HfpzmEwUV67HKuFGn2di4XvQ8vgf+LP9CdtQfBRqw8PfsXasduwgpcuzTb5j52FQmh3XmRa4v5WSOoMkN0Z5HWH5RwlAg7Qw/UbhtjcHqiRDlWjhIja8MRKGPF5FKz1oI7Pno1UAQU0ADkbIjdSVWLYthpUac8Bfs4QILiQGeqatGzn9kp/WCKMckvgcwR1j4KnamtVaZfZ9mzXCVacqNHbIBmjiezY0SVm5zQxIqo7ndvYVnJXEjz/y6UMuri3+uXgpn59uuMz5CKdEMgyGiScu/0bfj01b6rvta5dLTzKCcD5zxKE5cLy3mwB4ecOEXnsfOSS0kuzaa+SC4+NeJggwnGd/JDTMl5od4VXGFkXA1NFkFVLpHf2+dkKD18pzLTrifjpuYWbeggeafVGxUlQgUIcJ8576QHPVyrO6ihryPZWU/1T0x+lav1p7AagA0Rxzk4MnKsU0/CM8L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(31686004)(478600001)(6916009)(4326008)(66946007)(66556008)(6486002)(66476007)(966005)(316002)(54906003)(36756003)(31696002)(6666004)(2616005)(26005)(6512007)(53546011)(6506007)(186003)(83380400001)(7416002)(2906002)(8676002)(5660300002)(8936002)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1NYSmp3K0FKbW42TXpHMExyOG83SWdHY0JjektwcFpNZ0hPdmdkaytlVm5X?=
 =?utf-8?B?bk0rWXJ1SEZmcE8vZEVMYmRrQlNmRGhtaWN3K0ExNGNsYW5lWnd6UEI0dGMr?=
 =?utf-8?B?NG1vV0NIUGJlRWF4aTVubDdraldkKzcxL3I3NVlmcU9vU0lXK2tnMXd4YmFL?=
 =?utf-8?B?VmxVM2ZuV3RSMDhySXpYTm9HMzQzdE1KcmVLaXk5SExjY1k2MXhFMnA4UzdP?=
 =?utf-8?B?UldveVV6bzA1YkpQeEVUWkYxN2F2aitncUZGK1k5cmtaL1JnK1BvbFFiTTVW?=
 =?utf-8?B?aGVHSENqeXVBMEFoalVGNFEwOFZBVmpQOG9idWxDKzIrc2svbElnaVVYVjFk?=
 =?utf-8?B?Mmk1bURxSXp3eE5mWlNnRHZwNGJFckZvOFlMNWhHdnIzWWYrY0lMdUhqTVlj?=
 =?utf-8?B?WkFaZ2RCOVpJYU96WThHbTlROC9PeVJVaXh0a3N6aGdwekN0OWQwSGJrWGt4?=
 =?utf-8?B?a01FU2FvMDRRK09zbDZ3dmhtTzFhQjA5T2ljWGRTTEhxS2Jybm1RSXhCbDlF?=
 =?utf-8?B?YjM1aUdiVkFCRTh1RzNkTCtZR09mMkxUVzZNUVRtaW9wa0JYdHVJaXdBaHNK?=
 =?utf-8?B?R2h2QVJrYWdaY2RzTG5KNEI3dkR4Kzc4RFlTczNjY1RzTm5Rd1U4REF4NWF0?=
 =?utf-8?B?Ujc3K0JuaEdnR3VHMHJSa3phVTUzTnJaSkdrM0gzekpOQkhVY0dZT1Jic0Vj?=
 =?utf-8?B?eHg1LzZ0V01BK0gvQWRuTDMrUG9hODJJS0VteGJJWUN0YkhkN1hzQVRTdFF6?=
 =?utf-8?B?YVRzTW8vU3c5TC9rNldhYzFzcjgxR2FnWDcrQ0NDdmJjcTBaQzU1YXc2QjFH?=
 =?utf-8?B?RlpQdDZ0UUpBd2VZOTljTDZzZlhXWmJwcmMyZTNuQitxRVdZRzdiVmFrQUJ0?=
 =?utf-8?B?MndYZE5WMDJsaTZSb1dsT3lWMGhJQndGZU1Cd0xPMHIzaDV3OHF0Z29CMFJa?=
 =?utf-8?B?Sk9CRWtBZjRDa2JneUh4UlkyVldBR3dYakpiczBzT2habWdvZFUvZ1kyTG8x?=
 =?utf-8?B?ZjFzYUZTNnpka2VwUFR5RjN3MjdFMUhONXl1VXk4QmczM254VDkwYS9ieWor?=
 =?utf-8?B?Q1hkczJCYVNWbmlvRlhPdXhtNmczSEVNcXlhNVRIWENXaW9WQ0FQQWtUUVEx?=
 =?utf-8?B?cDl1STZmSXpVU0pQTDVqNmZncTJkS0NyY1FFSjhXZVplcEFGdWdwUDZuSmVH?=
 =?utf-8?B?N1Z1d3haUzVZY3h1cm1nc3FKWjdodUxMZWgyRC9IQUJjRXhtR2tPSVFkcm55?=
 =?utf-8?B?alg0TGg1OVhBWExtcGFlSTE0VVdtekV5WEMxNGMzalJtSGE3N3A4N29naFpM?=
 =?utf-8?B?WFYremxLL2xZSzRzVXR6Y1lFM2VzWGU5U01tME55R0U1K3lhbWdjNEhqMkNS?=
 =?utf-8?B?ZDFBZGs1R0FIYkFUTStXVkJvMVJFaVJyQWxkMEs4dEp6cTZJVlNyMnhPZjFo?=
 =?utf-8?B?cnYwL0syTDMrdm5LU2RSV2hxNVVVSzQvbkFOVzBpL3NrSUlHODJhYWNKcDBK?=
 =?utf-8?B?dFVoZHhzOXBmcVZUYmFrUGNtM3p4NUc2VGhGZWJMdUdDcEZud3VEZ250cTR3?=
 =?utf-8?B?M1pJL1M5Qlg1UjhXRXB3NThld3Uvb2hKaUQyL2Z4bjVhSk10Y2krUk1HeTRn?=
 =?utf-8?B?aXI4WnV3WDFEQUJNNnBVaWFqZGRkSUlwdGlKbGNPR2diSC81S2JsREMzVWZV?=
 =?utf-8?B?QXpHOHRXK1huMVpzS3hWQlArMU5DSTk4Z1dsY29FMWFRMzJscFlOelZzdWhK?=
 =?utf-8?B?OEZFajhPaFdNSUlNamFOTjhJT3kvcGxQNEtuanRsNWY0UTdDT2h1OVp6ejU0?=
 =?utf-8?B?L1J4TWJRZHl5NWFPOFF2cjlBZDRMdlZmWEcwc08yZHNMaUtGNXFvUVdnaitJ?=
 =?utf-8?B?cC9KY2lBMmJZSU9XRitTUDVIeTkzbmRNSVpZTjl4ZFZmNTVFaVpyZEF5dlNh?=
 =?utf-8?B?TTc2aW5DRXFHanBLQkZncGZjbXlPcG01NWxNRVY2cWdiam5QZlR6WnByYzRS?=
 =?utf-8?B?QzhNb1JRUmp5OVBjbXg0aDdPMFpwTWhqQzJqb2VNd0JudXNhMDU4dFRWOGtU?=
 =?utf-8?B?MWhReUtGdEUxOFZaaHlvVEE1NE5wVmdoODhLUHRpVm04U0RPamp2VTFsQkp1?=
 =?utf-8?Q?1OPl89v+2/JAeHBlsTbgY9EsR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c933b0f8-12ba-438d-a5e8-08db51eb3d59
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 06:44:59.4771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yr17QRAmEB0Jg06fgMsVX8QqmZwfnis9kNRUOIIkZiKsin6NbXvejYRIu0EeGEy4huoNIYN4JYtquo54X0o1ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/2023 1:25 PM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 118.9% regression of autonuma-benchmark.numa01.seconds on:
> 
> 
> commit: fc137c0ddab29b591db6a091dc6d7ce20ccb73f2 ("sched/numa: enhance vma scanning logic")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> testcase: autonuma-benchmark
> test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz (Cascade Lake) with 128G memory
> parameters:
> 
> 	iterations: 4x
> 	test: numa02_SMT
> 	cpufreq_governor: performance
> 
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+------------------------------------------------------------------------------------------------+
> | testcase: change | autonuma-benchmark: autonuma-benchmark.numa01.seconds 39.3% regression                         |
> | test machine     | 224 threads 2 sockets (Sapphire Rapids) with 256G memory                                       |
> | test parameters  | cpufreq_governor=performance                                                                   |
> |                  | iterations=4x                                                                                  |
> |                  | test=numa02_SMT                                                                                |
> +------------------+------------------------------------------------------------------------------------------------+
> | testcase: change | autonuma-benchmark: autonuma-benchmark.numa01.seconds 48.9% regression                         |
> | test machine     | 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz (Cascade Lake) with 128G memory |
> | test parameters  | cpufreq_governor=performance                                                                   |
> |                  | debug-setup=no-monitor                                                                         |
> |                  | iterations=4x                                                                                  |
> |                  | test=numa02_SMT                                                                                |
> +------------------+------------------------------------------------------------------------------------------------+
> 
[...]

Hello,

Thanks for the detailed analysis. I have posted a RFC patch to address
this issue [1]. (that patch needs windows = 0 initialized FYI if needs
to be applied).  will be posting RFC V2 soon. Will add your reported-by
to that patchset. But one thing to note is [1] will be bringing back
*some* of the system overhead of vma scanning.

Here are some observations/Clarifications on numa01 test:

- numa01 benchmark improvements I got for numascan improvement patchset
[2] were based on mmtests' numa01, lets call  mmtest_numa01.
(some how this is not run in LKP ?)

- lkp_numa01 = mmtests' numa01_THREAD_ALLOC case mentioned in the
patch[1]

With numa scan enhancement patches there is a huge improvement regarding
system time overhead of vma scanning since we filter out scanning by
tasks which have not accessed VMA. This has benefited mmtest_numa01

However in case of lkp_numa01 we are observing that less PTE updates
happening because of filtering. (we can say a corner case of disjoint
set vma). This has caused regression you have reported.

backup:
----------
lkp_numa01:
3GB allocated memory that is distributed evenly to threads (24MB chunk).
24MB is then bzeroed by each thread 1000 times
mmtest_numa01:
entire 3GB bzeroed by all threads 50 times

[1]. 
https://lore.kernel.org/lkml/cover.1683033105.git.raghavendra.kt@amd.com/

[2] 
https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t

Thanks and Regards
- Raghu
