Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E975F5B5CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiILOvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiILOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:51:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655941837C;
        Mon, 12 Sep 2022 07:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eudX1NgBfYuXC1Ew8A3KXxrUxylEChJ3GKGk6AQU0gYNwnqzx4/wRj427UHF5cffZn42hqZzMs7ujbDrnbo4b69dY8v5/ERBcisrchaqD1GluMGbI+iu7zVdKDyRWvKvdGNq4UKO7CU3kCU1S4bIZGqk+MX4im77b3KId4fmUolDrWpJdXauICumc96BTxRmUNiqMv3ceN2e2obH0ZFLltCBgWVZKlbmumQwhIPdysNOlZT4UH25n2KzC/fjM8FkL466R3AFb8HK0FNLB72c7hv8nniPPg9U5njCoZ8JoYgS7YqhRToD92WIDXGRpvOw0Z89yAuzRI4vbePnlVe3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rL+gB9oJ9C8JBTENUSkLZIj3xLRwEO8vfP/IAp2brjU=;
 b=Mi8q+Nw60BkV/CBBgHi1YG4eaI1erXA4VRDoKyE9cw/7BHJiKyZuuL2YU5HxaTeTlbY2ew9z+j/xRj0iqD9VL08aVHhjAvAaYGfpAR7VThCFW09Nlp3Mqy8O3GQahXQAI1kpO6EAFBbJCxX3Zh7JeGdmCZcfqfj1Jwaxh1clRlVex4/EXPIw1KUaWGq2RFYWmwZSKlZLDyjYoFqf14bbCB5ZSELTGFHR/1gJ/Ns8fiOjiLpHXQ6ld0+WvJTwZn+n3imd1uyVqv+LO1ml2aY4G1c8+ThtXWHrMuIokjKYNUJiwE5/YCahRUn0i4c3jV1NZtkThTHEcRXCiuBgKFbNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rL+gB9oJ9C8JBTENUSkLZIj3xLRwEO8vfP/IAp2brjU=;
 b=W66+rrK+zy9iIHr9h8eQpaGnCfgI51nzNEbWH5GPF+vRKGslYHc1bHdvB4ofu/lXosRMfd/EjxISfXpvHQvPNvi9xaBp05XmK1Z00AGfYDNR+WFLA67c+YXaob0pbSss1KZnyy6HpvDWNM9bps9ZzxQSm5YxDq3hFpKfQq0LfGmwM9MhDB5lYRbCAJY/d3SOD+DL7bBRJYuVStN+8qq4DsS/cpmJ4DDHaAnZrhOa8VBrWlLFBO7kq/ERXvhSm45XhZk5b7g7XTJBAtyGh39/dKQ4feaEQrNn6jwZ4a5oKWLUUPe0Bo5QsIzXcHturFETTo++aJq6BbxcOhwApWefMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Mon, 12 Sep 2022 14:51:28 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::7090:22ef:abb3:ae9f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::7090:22ef:abb3:ae9f%7]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 14:51:28 +0000
Message-ID: <bb5d73ad-67de-6f73-c131-363178696736@nvidia.com>
Date:   Mon, 12 Sep 2022 15:51:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mmc: sdhci-tegra: Issue CMD and DAT resets together
Content-Language: en-US
To:     Prathamesh Shete <pshete@nvidia.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     anrao@nvidia.com, smangipudi@nvidia.com
References: <20220912132728.18383-1-pshete@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220912132728.18383-1-pshete@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0041.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::29) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b5be7f-2812-4cc1-9378-08da94ce4588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Le1fy+S76SYi/+BZ3RxGttoT2Uq3lKy/+bLcCiXfubNhHPnoSv0AfoBH7Y8jyTPs4pD/NNKbv58/AjblLA33Mbqv2q6EBpULedqqn/uc+qkspPLE4FBqwPefOFkqtrBSgbSA66EL8zPLRXtyVBDaYLEpp+UsifnrGzSmla29m961q4o1mjg+vP2hrfaS5fsLAHoUE0driSWHT1jrp7ltxLh3ej+sTngAnsLbXq5PsdFEbtdVzNHAE7LXrAG3TUpqox54hKfXD+04ASP0uk8Mtjaphw6WI2IwhV5EduaXUyFDq8rxNG9PUs2fUrLslGijHUn0iav8A5lePya+bMX/JUpEWYFRv3jBkpP1wJF7N6Wwh59iFlnujyL+cVrLubT4/xoJKCg3uvftcosDiLFJW4AkV2LOJ1Wvga8xt9L9q6vE/PcBvMKnjpcVS9PD9tNRTMflQTNCTQCUQ6UCVquB8b6p2g7Topc7356EgFmxkaIBtlAFM+d5kpkRd2NKbXpisDw0TDZ0mgbJ1FCdYwChRIVASEKw32ZNXrefVSaoYA+VYpA7qecChgROFKQOPrbEnWAFHqLF60BJYTHQeI/EvT+qyA3hfRBUvkhJB97LXnjL1VXYZgXIN/N7VeTnS8/9p3bOFbpecI8rjBm+2HVdAeVP0HPIlBT+lWC5YUReHiAizWNn+hKeeVJD3NeVcXRstW1TF59qFyqVUsFWwVQawY87XIedV2yAOsp5MWH2cCqGf5tuDcCiPxHsE77MD918dW9ZJX4HGme45br8h5wEnaNar4mAP4qsJNR2no00VlU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(6506007)(53546011)(6512007)(6486002)(478600001)(41300700001)(107886003)(6666004)(2616005)(186003)(38100700002)(66946007)(66556008)(66476007)(316002)(8676002)(4326008)(4744005)(36756003)(31686004)(2906002)(5660300002)(86362001)(31696002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXl1OFBqNHFJNFNqMlM4MGNLV29xMUNJcm9JMThlOTVTcGd5c1N2TCtyMi9q?=
 =?utf-8?B?Y2JLdDlEZHhoQ1pnelR0Z01qWDJwMGhxOFhOQ3RPTUV3ejFVcFhpdzZJQjVV?=
 =?utf-8?B?OTVHRkROelZiNWR1Q0x0eTUweXAxdlRaRGVaYmUvU1I4bEpmdGZOdnRYejZh?=
 =?utf-8?B?eldtTHVTQ0FCcTlnZVFYTDJzNjhVVDZtUWJDbVl6UG55V0grYjJVZUVFZlBV?=
 =?utf-8?B?aHB4RzVmWi9YaXVVMzd3SFRqZHJiVGllZ09PRHQ2Wjg1M1V4N0Y4VGY3VlpW?=
 =?utf-8?B?dWRNZDZUVm5VUDFQM3cxOUJCcGRvSzQ2UWl4L2NzbFBPYVNYYk5OQm1NZFUv?=
 =?utf-8?B?V1p3ZzNqMG9ERkNNOWg5SnRxTDBzSWw4ZFdVNlNiY3NkZk9NeDF2cHkzeUVt?=
 =?utf-8?B?L3RCdHNTVGpuYkRaUnFiUHlXcWYyWlNETUZtcWh1bm1lSWR1czZSNEo2Slln?=
 =?utf-8?B?cUpjek5BV040bDFCc3YvaU1oRTZRMFpkQ1Y4Y0xYVVNreStxSHNxRDdCcXBR?=
 =?utf-8?B?R1BmMklUVm9FODJ2KzZiKzlVbGZRaVRlb3ZieEhodjd4SlcyanpTekhPNzRv?=
 =?utf-8?B?QUJudG5rV3VEUWtKMkNEd3NPUmdnN1o4Qko0OFJXSUlpZ0czRFVVcm1rcSsy?=
 =?utf-8?B?c3F2Z1dHNnRMdzQ4WmhrQWZuSjdxanFkRVhnUVRjcFVielYvbitwK2tyc3FX?=
 =?utf-8?B?eHRHWlVGUXZhU29UVTNoSjl0SGE5TTMxK0dmd1V3Uk4yQitxUXlNNStVR3NV?=
 =?utf-8?B?TXhCcUFMcjM1Z1hrRkhEZDJmZTR1Z2g0eHRXV01hNm1BMlU4blkzRXR4M0pF?=
 =?utf-8?B?UHRkb2ZYVS9ZS1dzbmpLZHdKODgycW05Y3EzbFBnWkVYMW1QZWl5ejVIZjNl?=
 =?utf-8?B?VmxnRWVrVEpOLzROTy8xcVZXUmVuMEtBamJwakkxQUh4c05RTnFROW8vdEhB?=
 =?utf-8?B?elBwRDhCU3RlV3NhM1A3R0YvenBmanAxNnRYN1N2UWJDSG1WNXZkdWo3YmYv?=
 =?utf-8?B?dlRJb3JhN2I5Ykp1RTAxWUduL3NuUFdIbnFrN1NzNlZ1amVneEtJc0FOdkE2?=
 =?utf-8?B?LzFnVk16UnBQSDRHMVVockRuTFAvbFM4bUNhNkRHRmNPZlpmcndUSDhkY2Zo?=
 =?utf-8?B?MCtUYkFsazJCajJhalBudWV5SnVsWDVBc1JmeUw2a00wdTl1aEZQTlgreU5D?=
 =?utf-8?B?eWJlcHpmWWZhaXBwSFdXa0pvUHVSN3c3eXFzaGlQWlhtMk9sbDdHR0d6bWN5?=
 =?utf-8?B?a3UxMDNMSzdFcFJOdjM4ZUY5S1BVWllKcGtqU3JqRHFtbjZQRWFma3dhVEUv?=
 =?utf-8?B?d0c3alpaSUhJYWtYNzdHSm1WVEFJaXJRYmNjU0IyQ2RvbVdCKzJKem9Pc2tv?=
 =?utf-8?B?VGdtdTFjZ3dLU1hWemNIbDVsRWpFMG0zTG9OS1Q3bG42amx3T0Foc0tONmtX?=
 =?utf-8?B?dWtzSTRhMGE3QjAzSDBUL1JETHFuazBnYzJaMi9LcndoQjdrdUdVQXJPaXI4?=
 =?utf-8?B?d2wzaEJjT0lEMkRPcGppeUMvQWxYSUxOcXJLWkN6OUowRFhEdFdDWkFUS0tS?=
 =?utf-8?B?a1o2QzYvZTIrbXF6dTNreWhSdDM3TmNuK1dQcDZWUk1TaDVtVEx4UDQwT1dy?=
 =?utf-8?B?MFNoQktpYTBXMWlpZFR4VCtoWFFwVTc5UXVqcXNSc0lSNEdDY3VaL1NSNnBJ?=
 =?utf-8?B?MzJ6OURWWFpIZkR6cnRFbkc0cStaUzVmcGk5TzJNNHhYbGhoRFN0WURET3VQ?=
 =?utf-8?B?NlVGdzdSTDFLYUErVm9DSWs0Q1NMWHpoeCt5QnBjb2lkMHlRU1VxN0RXdEVU?=
 =?utf-8?B?MkNRV1JqeEtSY1I3OVF4RnZJc3JMbEdnd3BBb0dFbVptVEliQnNyUkpyQy92?=
 =?utf-8?B?dEhaamZvWVpZNkpXMGo4cW5jNlpsaWFZV2ZzT1pCdzdXU0VXQ2l4T1hhaFRt?=
 =?utf-8?B?SWpJMUwzQVg0Qi9oUCtTSHpxemQ1aGlFc0d5WFpWcmVMeFNEeTNtSmNXWldB?=
 =?utf-8?B?WGttMHlZR3hWV3VScXoyWnRqTmRlWjhNWnkvZzdZUVpPSHlyS3p3OCtDN0RX?=
 =?utf-8?B?QUkzdHJiSjcwaVp4N2RNQnoyVGc5ekJkVjJzWE13cVFHaGt4aytudGczQnJx?=
 =?utf-8?B?SU40VnNEV0hpNks0VHozZWU0MGx3UHpjUnhOU3JvdVRjVUIySkdKSUtEWExz?=
 =?utf-8?B?bVRSbUZmc3h1cEpMNXlyMjc1eENtVGIwNENjTFo4UmpPdlVJNDNMVHp5MVJQ?=
 =?utf-8?B?S0ViQkhaMEFKVXVySmo2UlpaK2RnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b5be7f-2812-4cc1-9378-08da94ce4588
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 14:51:28.0067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lGFcSJNwhfwqg5g9gd7zhmixtY4IhdIQjHkJJ6ChxXp2k5QKJxULTVe5fmy3RVDh3G96vSCXe5voBkR30FkRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/09/2022 14:27, Prathamesh Shete wrote:
> In case of error condition to avoid system crash
> Tegra SDMMC controller requires CMD and DAT resets
> issued together.
> 
> This is applicable to Tegar186 and later chips.
> 
> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>


This is a bit confusing ... there is a series with 2 patches and then 
this one. This one does not apply on top of the other 2. However, looks 
somewhat related to patch 1/2 in the series because it is changing the 
same data structure. Probably best to send all 3 in a single series.

Jon

-- 
nvpublic
