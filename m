Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01240663B88
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbjAJIo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbjAJIoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:44:08 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE764D4B6;
        Tue, 10 Jan 2023 00:44:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbcwPSPFTgQ9VY48fyAcuQnyys7rNihqFS3vaAhzwMKjs8l+xkY7hp1geZAmGoEJjTDHPnt+ufWW1Ll55YVTyxl+isyjyH+dZUV6OEX+/J7k4sERwTeioskNKdLbljM04JpUplTD+lUaKOjFdj/WXni/QHrEj1G2/N8NJzcCynKG07YOotHXbYM5d06pwFJcPBlo6mSbKlQNQDBzjA8YtprmcUeLfcmn6Zq+16IokBwqh8jTlGIyCilihctHzH2oiZtnUU2dhuBqdAWyzI6nNNt44SQsHABIIttqHc/chwZOASggrXPz6+J9om8RTLxf7iUn400r+0088swvZKE+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4++ZQaDw9bbRuMsmcLm+tknDMPOm+u1j0hFd22yVWcI=;
 b=DvPHW/Wl8ANk08xEukM7yVNtygKUJGySrNZIE7eWzqS2yhg2nGZSagS7iWwZu+kTBcrmfpVVdRZlbpNMhqc48reXRuN0TG4rDkUgFKxqEJ06K8HCj5FasLFHbCvJuZgM9iYJTNP0bhu+QkYDhMGbn0HMa51tve9XrR+yQkHPIQzsnuBxRID3v03CihKBiYIqKHmVXKHSS+B6NziHY5sYJFS6GRcJg6KQ2UoYQ/xS9GfUW8mQYFwM7woiO+WgpgBl7Rz9SLTDDuQ4Ei5mjRX1F6PWBZH9hDV9/+q2NaJQ8/5/SVC9igSwcJdjpMyKTboHjdE4gMWuqN9DCvXDPRWJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4++ZQaDw9bbRuMsmcLm+tknDMPOm+u1j0hFd22yVWcI=;
 b=cdcc7zxJQ3lzfNi4aSo0/2G/DEp0YTBtZv/g+itB9MFQVZg0YgyGTu5+BAQPrypAIoyrP6rTx5fvRgL4Z1WByETArS2rdjA8lxqlrjyMx35DasVBXfooxbheDC3UPQ+3OEzpFJjSkoLP0cBCyIfX+xwdnd+wMj6npUeVBMwabI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 08:44:00 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a0e2:652:d7bd:58f]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a0e2:652:d7bd:58f%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 08:44:00 +0000
Message-ID: <760acfd9-26a0-e028-bc29-004be0b2620c@amd.com>
Date:   Tue, 10 Jan 2023 14:13:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC 0/4] perf tool: Fix non-".text" symbol resolution for kernel
 modules
To:     Adrian Hunter <adrian.hunter@intel.com>, acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        kan.liang@linux.intel.com, peterz@infradead.org,
        mark.rutland@arm.com, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, james.clark@arm.com,
        german.gomez@arm.com, leo.yan@linaro.org,
        alexey.v.bayduraev@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230110055859.685-1-ravi.bangoria@amd.com>
 <86f43058-a51a-42c7-4d75-564f0e8eef04@intel.com>
Content-Language: en-US
In-Reply-To: <86f43058-a51a-42c7-4d75-564f0e8eef04@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::27) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: b60b400f-f9e4-49b7-3322-08daf2e6d1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2cHvLq7KY+8Exo42FdiA5SLEWPc951rReE8roIdSZ3/ITwZScpVJAAaxgEq5YppB7nragK9QcqOm7CSHzJaXeA/+WJdvge5/qveCyJqVPbsZZVuhXwCfTBCTuIX6GlQf0VmZ3gtmoVsadLz1UCdxPhEgQ3y0ydXzdIGBmxZJyRTwiyE+dVnmkVI1dpcHhHJL+N5T9/JnkNhe9GHi1gE2poSUbQwmARLzIO4YMXkiOFmJzt1MLomOox/0JGgirdCmwEp/yZVYauH66jggPUCmoyTfB8x1HkytotY2EDECFWt5EZC2BwpuqBF0BWz/4IHqotPGkPdZehROeO/mvafBgrR6JRvuke2SN7jlMkg9S1tY74OqPLZXpAT621N4/kdbEc5uKNXaQGrLpQv/lh1l44ZZxMDMJF1/CVEU5BFYDz7wj4b6xtlii3/Z/HzgP7vGOxaM7ux0J+FvkIpcp7vQpNRz9EN0iKhiNcWThKKodPX8zBU/VfbmFIh2jR8oCCwGgf7LaQNowdeBrmRaq940NqkaeORcfm93I8E4NJnkQQRiVHUPpvb0Hlu2uBbfxVi7GtwIKJmo8NKHAeGecreMmUd1PfC62QCsoNE/SGIMiDBUdCsvmeicg7rRJjHeQyWg9KlEbLdUg+jNdRCPPuSOmLkBqoeC0VqfDNU0XvPHVaERRSYNplV1Amz9K9b6VJAa9xvaI0JKoCi4wk8fmezXrbBeo4ORCvybLTqQrB6s0pU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(7416002)(5660300002)(316002)(44832011)(26005)(6512007)(186003)(478600001)(6486002)(2616005)(31696002)(41300700001)(66946007)(4326008)(66556008)(66476007)(8676002)(8936002)(86362001)(36756003)(6666004)(53546011)(31686004)(6506007)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXdSUnJwNFc4b1VwV3pOTHJmT1hmc2ZNZUJ4OEN1TVk1ZVAxN3RvWnhadjdC?=
 =?utf-8?B?N2g2TlZKdDQ5WDRlMlBYLzJqU0ZlakpwMXhtV3RsTjMzOEhCM3JlK0pxNlVJ?=
 =?utf-8?B?bEgxc2YyNjFCVTJvWkQyUjVuQzJTNzdwVzhYWGljU0E3MDBScXcvOXA0WFRx?=
 =?utf-8?B?WVkrUjJLdndsM3FVUG5PVElnc3hrbFpFVGE2UW5pV2t3ell1akRpbkVia3pU?=
 =?utf-8?B?N2RBWnY0RmpSd2hpV2VjcHJMWjlyUjhseEFmenNTYU9MNkV2Um13WlJMMjlH?=
 =?utf-8?B?R0lydFJjdmcwd05jb1NWN0x6clFCQm54Q1hqVlUxdldEQWRUc0RPdjNVNkJG?=
 =?utf-8?B?Tm56OWMvVEY5bzBTY01uVWlCTjB4Ui83VVV1UWVCLzVhYmFDaVRXd0pYazE0?=
 =?utf-8?B?Y3BvZ1VVWDVrTS80aERVWDVobW1TYzg2Sk85OStSOFdTTnBUUndKeWFPdlBt?=
 =?utf-8?B?OW5zMGllSVN1RUM2YXNUT3hZYVUwNklDSHNaeEFhbGVFUlYyRlE0NzdOV0hI?=
 =?utf-8?B?bGthaVl5SFloUGpBNVM2S0t4TmdqUlpwOHRyMXJ4YjhZNXNCZ01MQnQ3V2Yy?=
 =?utf-8?B?V2JaNnhiZFU4Z1EyeU5OeE9na0tzWVRtaTVrcUExSkl1OElEaFFkNjV5Uit2?=
 =?utf-8?B?a1NjWVlvYUJEbklwL2dFTU5QSHFsU1A4ZjVZQ1oram5LUzY2Z2M5azVWc0hW?=
 =?utf-8?B?MzBrNUMwSml2SzNyZUQ0c1ZmZGt3R2hFRWJjSnZQUXdSemFZVWI0STZrTWd5?=
 =?utf-8?B?OTNlanhETHN0L2o1TE1pa0JzaUJleDEyblJ6VzBFZlA2c0hZSWxFNDVTK1Bk?=
 =?utf-8?B?Z2FIQ0NNM3FtLzRFV1pNYVAxR05oVGZnOFlQYmJxMHhPZERYY2RJNmFBTVds?=
 =?utf-8?B?UG05M1Jpc2M5aW1PNEM1a3Z6RFNXaW9ZZS9lZ3paaGRsaTZndzQ1YlVueERu?=
 =?utf-8?B?dUpyMHlWVzgzWFVialZmMi9ocVIyVWx0eWRYSy96cTJCNGVkdTV4Q09PTDFw?=
 =?utf-8?B?MHFaNnBacklTSXBwbmprZFpNSHdxMWtjK3pUWWdqc1lJaFpDa1l0cE9KUUMv?=
 =?utf-8?B?K25DMWVKc3RWNWJncXBaazB4L3dlN1o3MURrOGRacCtNUlFsZkV2WG9pQmt1?=
 =?utf-8?B?ZjZMdTV2aWNqckN2NFZvSlladTJPNllJdXpyb3U5VUtEQ2cxR0xDWUZBMVI5?=
 =?utf-8?B?WktsM1ZMUVVUanF5elo3akxENUtOejdmaTNTSGlmeE9ROXRWS3RCU2pJSU1m?=
 =?utf-8?B?MHRVUHJxZ0JndTZOU1Y5SWFKVG42ZjRpaC8xZUNVNkYralpTUloxd04zeUFG?=
 =?utf-8?B?NW1Yb1ZwT2c1NUgyTTFYUHRCeklHR1g2dTlOUDI4VUx3VUpxK28xTUN1Zmtn?=
 =?utf-8?B?QXpTQytlanQyODJLWUs2alEybWpoMTAvNU9UMUZWZU9KUXdsVTZCTEdhY2gw?=
 =?utf-8?B?YjJzUWQxbVR5N3V0N3JPNElBYWFGNC9LcGpYeHJjeTVVMzQxOEJZdkt4dURo?=
 =?utf-8?B?TkZnOUNUN25kaXg2YmNMZmxIbHA5UVc1cXdKQ0gxaFk1U1hEVVJiclMvUHBX?=
 =?utf-8?B?VS8vOWhUTGlicmM0ZEwxWmVyMEZJQUd2VCtPT3lFVkovR29YclJuRVdmU0g4?=
 =?utf-8?B?Wkc4QnRJOWp0S0gzWEpoN3M1di9IZTRIMkR2ZUhJZFNTWFMwdHo1T3NTU2R1?=
 =?utf-8?B?R2gwSnVNd2lyRXdCZ0o1UlFJcm5GODA2S2NDY2lHSkE4Sk5uZWJsNW5wUHRi?=
 =?utf-8?B?ek5BeENxY0dMRlpwWUV2Q0FPdDl4ZDVHQlRzeVhaN0lmS0VCdUUzZWNKUkZs?=
 =?utf-8?B?S0xjU0l4WHJSbUlOczg5bWVncDJUcE05S0lOd29DSnc4R3U5d0Zlc0Zncncr?=
 =?utf-8?B?Wms5M3lKazJldkpNZE5QS2NOVmwzUXVhUnRuQUw5NDVXREN3anRHb1VlQWdC?=
 =?utf-8?B?R1oxRnFCVnFRdnhBUXlIY2paT0dsaVhlMzlweTVGckUzVzRoSVRwMEtPWUJr?=
 =?utf-8?B?dXhaK0JhMFpOSFUyWjAzcm5RUUpURE1TaWd3RjIxZDB4aWE0a0c1dGJ1cjJ6?=
 =?utf-8?B?QUJEZk9hcUxoV0hJaDJLd01xaVdPYmh4RVFxWSs0ZWdITHJlejJRdTVoS1Vy?=
 =?utf-8?Q?7QS63oW8q6mlYuzrk/DcS5Jep?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60b400f-f9e4-49b7-3322-08daf2e6d1dc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 08:44:00.7208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSIVbL/vbUwJWTCUApG0cYuky3syDjxCxjfi7Y1inGDnyjisisBx+0jcN12z1/kx96zfDF6oeGmjDLQY8zRnjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 10-Jan-23 12:05 PM, Adrian Hunter wrote:
> On 10/01/23 07:58, Ravi Bangoria wrote:
>> Kernel module elf contains executable code in non-".text" sections as
>> well, for ex: ".noinstr.text". Plus, kernel module's memory layout
>> differs from it's binary layout because .ko elf does not contain
>> program header table.
> 
> Have you looked at using perf record --kcore option.

Nice! We can also use --kallsyms with perf report and it resolves symbols
fine.

But what about normal perf record/report? Why I'm enforcing on normal perf-
record/report is because, generally user don't specify these options, esp if
he has root privileges, he expects symbol-resolution should just work fine.
But when he sees inconsistency in symbol-resolution of the same kernel module,
he will be clueless of what's missing. This patchset is trying to solve it,
although I too feel adding section specific maps to perf.data is overkill as
--kcore or --kallsyms can also resolve those symbols.

Thanks for your feedback,
Ravi
