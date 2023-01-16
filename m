Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DE366B693
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 05:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjAPEVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 23:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjAPEVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 23:21:47 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79C76EA8;
        Sun, 15 Jan 2023 20:21:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gamME+x7gebsJfkm7gW8jA6COx7Xd9i0Qw8d9AcbeSlNMPCRe6OkQfOGDsmP6YSBFHtgXPMdFcHirWQl9J5uUpARSwYkrntaSSxwloToPIRMCXvZjac7GxI6n4e0IeOoijbjK9vGhMsF8n6SNsH8JzMiPUbv1QqEosHt/PVhXlUO7yzgjjCFtDHCoYPpYOz7gbS22XMfdZ54vYO45fiZvMU+dnVsVXM1/i+feNvl+Z+IDHfGwNK5Bqrjx9Okzuu88WGv4tN9HV6xWkPtTaLu+8NZrC/sAPo6DZqGZp7AfH42ITQeSd88kIE8GWDBkZxwtZvvzH0wbyLRbJjdSwTEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuH3PcsgZH+CZmjuGKewGk3kJHTL1KDq7PfOI0Ox8mU=;
 b=TazqxA6lQZ6dBlLiuQmfQcxEcTLqqYCM4cR/p7XH1C3dfQV5OQQOClwZhg57DtlUjEeZKOZtutjIeuislLmL9r+v0gnmM3VLuZi9LkYi95b9GAUCHr5Pi9JXJzaLpMhanHGghTp4Eyos9gwwJT08oLgf5Wj3X8vefJg94O1hHXIjsAihECDIfNpNka/Qr8HYH8C/u2zR9pWU/3MvIbx+1cK4HNyU2Ni51kFiuH2lZVlpU3Fc6wwWKy/O9PBg3BBtDTRjKBgRJHljgUQt49/11SJ0/gvDEJHUtWTY3G2DkXMogAAL5Wk+Dht5wt9V7ExVKwrR4UW8Gechf0NOBT2NEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuH3PcsgZH+CZmjuGKewGk3kJHTL1KDq7PfOI0Ox8mU=;
 b=WSWpKGwWRpOGsr/xh35XTFatuYQTVUTtopM/uHDdVbFvna0uNXtI0WvC97Ae0jQUJh/ZOl/OQQvy/6lTBrYIR1deoFwfZKtYpdnMSVvSiaIaRtylTvAwtql1trDu/LZTbfC2gNnthr6q0sGAXyxY17VLIb1I3FyNFS57XiVbNTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH0PR12MB5386.namprd12.prod.outlook.com (2603:10b6:610:d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 04:21:43 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a0e2:652:d7bd:58f]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a0e2:652:d7bd:58f%4]) with mapi id 15.20.5986.018; Mon, 16 Jan 2023
 04:21:43 +0000
Message-ID: <98570bf8-dd78-3d9c-61da-9ac6b3502fd5@amd.com>
Date:   Mon, 16 Jan 2023 09:51:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 0/4] perf tool: Fix non-".text" symbol resolution for kernel
 modules
Content-Language: en-US
To:     acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        kan.liang@linux.intel.com, peterz@infradead.org,
        mark.rutland@arm.com, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, james.clark@arm.com,
        german.gomez@arm.com, leo.yan@linaro.org, adrian.hunter@intel.com,
        alexey.v.bayduraev@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230110055859.685-1-ravi.bangoria@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230110055859.685-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH0PR12MB5386:EE_
X-MS-Office365-Filtering-Correlation-Id: 154ac5e2-ae4c-4b68-f11b-08daf7792c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04SjXobykxJORNLurpVGLyAcBK6AesC+rvC7+zq5q3SKUeICxrypfkdd9nS9iLN7sTPRFtT4RiJt9GPD8+hf8HcbOMQkWcxcXFxDNqfgzaQvAtRb1MqLIuS0FPASOejfbyEfxiR09C5yqO9w74x95phzu9FWjO51glx8/UGlZB4HfkeoKZtkY94WnhRKJDy4TDFw7pD//T7r9oz/L2beBuzT+qNzCPQJhyZYQws89ark1sBZj6wlZu7H1k1QSBYVchcNSwyUZE3IwuG9XsOjNpdx3EEZn7IySP2xs+lsrk/qIpSPGYScAxi4nPgAomOP08LVMAaxuv62SHNl/sgrQ7d/IkCtDt8xxah0iyB69TdcJto8J4DFeOPKJVwO/BJlxmpWSQKLZJfO14aMyWS7yHTHeAmODNhtTXn1gW3mh1kePELY9DtPVo57fd9orjSpW5KEa2TGItcLSTRtI+w5sjigMF4TT7hQUQhUjPPR8dkpaG9iLLgs8E1mwCga8GQ001e6wK1Ud5AVOhEKCCKgSDivpyXWfU5cxGqRi4CdI3esLny2ncwlJbBLpJjzQAX74Zogujjw+rLM9xa9mqOs+MDk5Rsm8Yjx8LjXpMMT/V6b0qigzFjVCM6f0Wy5Q9sB0UkLvG9W5JoJyJRYmjMs/swuELR4h7ntgRfYsQiXLmJU4unXWMA38y8dEVH9SLkxJuGbB1O7YnEz9hvLwQ2g7eGHY++hiQ5mPzOPqloGdSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199015)(86362001)(8676002)(38100700002)(31696002)(4744005)(5660300002)(7416002)(2906002)(8936002)(44832011)(6916009)(66946007)(66476007)(4326008)(66556008)(41300700001)(6512007)(6506007)(186003)(26005)(2616005)(53546011)(6666004)(316002)(478600001)(6486002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlJjbVN2VU0xWk5raU5IMUlSZE9wYnV4MERaYmovUEJlQVhWZ294cWFuZjBv?=
 =?utf-8?B?RTg3QjlPbHZyVHcvbExqZUtjWCtNKzR6QmxVVVZROE83SWJMY3RjQ0dlbjNz?=
 =?utf-8?B?Y1ZFUWpUcDgyOHZISFJsM2NSamFHM3JaSmcrOTBNb3RZRmJERlBIek9TY2ZE?=
 =?utf-8?B?Y0FFQSs4WG1aSVZBM2grOTBsYlRKQmZGKzE1dHFvSkh0R0JIYWgwK3paamlL?=
 =?utf-8?B?ZExJMm9EL2RHVWc5cHY4aDhuUG51MmNhV25pUUwyRWFLVTRPc2FadnE5ajhy?=
 =?utf-8?B?VlpsV3hQV3VsbXVPWmcvbk41T2pmdkZmS2ZYeE4xSFRERmxaejdlM1JjbzRl?=
 =?utf-8?B?a2Rqbk4wMTV4TXdqOWJGYU4yVE1KWTVkZzkrdDlIVnY1WnVPaUFBa1FDeVdr?=
 =?utf-8?B?Nnh3emNHWS92U1VZVnVMekFORzhwaVpJdFNQYXYzVnhNdWhUYnpoc1FxRERF?=
 =?utf-8?B?a1A0OU9jMWUxam9uYXlCYVI5dlQvS1Z5NHhNdUg0NUhVd0x2UTZNcVFodFRY?=
 =?utf-8?B?RTFWQUorbEg4VmNxc2VuVlRVM0tKZTdmUlJZN2RXWGdDNWdRZXVCTVE4TWxn?=
 =?utf-8?B?S29qdjA5RW5oMHg4aUR4RjBWdWNGNXlXdEdaYW5wMTFOYUlTK2hQeFBwaCtF?=
 =?utf-8?B?NWhoUmxQRTJLWHpFTHlhdW8xVHdlMVZsZHVlU2EreW1uVFRSd0RTRURaS20x?=
 =?utf-8?B?aG52dVVhdWFsUStmR0FaVzFXU1BORDhnWDF5dUhrTjY3UTBORERjNG9BTlBO?=
 =?utf-8?B?SzQ0U1psK1JNcXpMMXY3UFZlajF4djFycjB4V0ViQ2YzanVTelRvbENrQTE4?=
 =?utf-8?B?cGp6UFZVbzNYK1hWeXppUEt5dXlOd2prOE1mcTQzdHZpalJicGtRZU9YeDBT?=
 =?utf-8?B?RXRRTm4yZDdMUDBpTnF4a0cwcTJic05JSnZ0dm9mZFFndEhXOGVVL0piellm?=
 =?utf-8?B?bm1wZmQzUlBTeGtvWjNhdGorUlBRbDFyQzdlR0JsTnlENTRrbktUTTRFUlRC?=
 =?utf-8?B?K0o2N3g0cmE5bFdvSWM0YUp0UHBZWGM2SlJSbjhzbWN6VUI3aHhpSEJyV1FN?=
 =?utf-8?B?ZDBuZXZxMWhuUW5CazJvcGxPQ1VVK3B3VHpSR2N2VHlSNTNkL3d4dWhleTN0?=
 =?utf-8?B?V0h2d1kwSjY4dWpueHlaZlY0OU5kV2dYMWRsUUZESXE1SzJJaVg4VWx4SThM?=
 =?utf-8?B?Y3VmUTdlQ1dPMmlFMDZLeFBJWXVtb2t1aSs5amFHV2Z5b1VkVHNYemhSOTJ1?=
 =?utf-8?B?SjlSR0kwNFlkVXkySDV4MDIyZDlqTStBb1RsSTlOY1NRbW5XQk9Ham1GTGVw?=
 =?utf-8?B?bGkxYlZuMHZDK0VNcjk4SWVOUllxZWovV0dIQkdkSXRYQ2ZLbGpOVmdobHBj?=
 =?utf-8?B?THZ1TnlnOEFXTURmQmY1SStvbGg3cHZibExGOWc2czRnMmsyak55ZUZ5NGJS?=
 =?utf-8?B?TTJoNGI0NUJISDJ1NVc2MXhMOUk5aG5uYXBYaDRSMUh1WjNTZDFHcm1WVmpH?=
 =?utf-8?B?alJRRVdUU1FRUm9kTytvV0JkKzg2UW9BeGlyTldlOU9PZVNyQlFyV0Vaekxr?=
 =?utf-8?B?ZmFpeUpTakwyZE1selZHWGc4a0J6SGpJQVFZekd3TjA1U2p5QU1BZkhtMFgw?=
 =?utf-8?B?c2p1bENDV053TloyTG1DdXFvdFBiT29YeCs0QmhDeWlTdWlpL0dTdGtZbFRD?=
 =?utf-8?B?M0diOHh1Qkx3MUllZ2RMZjdVRDYra2VVbHdscDlZTkJVRElXZytOK1ZpMFZK?=
 =?utf-8?B?cy9iRUhRa0J5MXgyWFRSTjhUWktmSXZOTThDd0t4WC9mWng4QklvTzUrNXYy?=
 =?utf-8?B?dGJrb3JZQzFKeGxVTno4RWwvdW1WWXNnbzJHbHZGcWN1ZWZSU1Rkd0VONWEr?=
 =?utf-8?B?OW5NS3daT2R4TDlJdnlaT2s2TDFWajVwRThmWkRZeGlqVXdCTTJSSjBFakI1?=
 =?utf-8?B?ekZwR3YveThTdGd5Zll0MjZPV0liT0VPM3VZbTFqc0I3QlI2bzIyOEtCM2lF?=
 =?utf-8?B?SkVzZU9kMmU0dWJyay96bG5nOXlsWTI5NXZsWGFNTWFXb2xDUnZmRDcvdTJV?=
 =?utf-8?B?RzdjNFNac3ZLbW5FUlR4Z2s4eUVzSlM2M0pzeDBkUnZ6aENoRzBjWEZmbDNG?=
 =?utf-8?Q?afYy+s/dlkPY23NpVfXXX9zRl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154ac5e2-ae4c-4b68-f11b-08daf7792c00
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 04:21:43.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5PXVoK+2E7ZpuToL1hRe5c34owInQD7qwA4u1FfKxTlht7YMPVsQxBKLmEcJlG01Ui0/vStdORPwxO2DfJjqDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 10-Jan-23 11:28 AM, Ravi Bangoria wrote:
> Kernel module elf contains executable code in non-".text" sections as
> well, for ex: ".noinstr.text". Plus, kernel module's memory layout
> differs from it's binary layout because .ko elf does not contain
> program header table.
> 
> Perf tries to solve it by creating special maps for allocated (SHF_ALLOC)
> elf sections, but perf uses elf addresses for map address range and thus
> these special maps remains unused because no real ip falls into their
> address range.
> 
> Solve this by preparing section specific special maps using addresses
> provided by sysfs /sys/module/.../sections/. Also save these details in
> PERF_RECORD_KMOD_SEC_MAP format in perf.data which can be consumed at
> perf-report time.

Do you guys feel this is worth to fix and I shall continue? Or --kcore /
--kallsyms workarounds are sufficient?

Thanks,
Ravi
