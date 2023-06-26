Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B29073D787
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjFZGHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFZGG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:06:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A73EB;
        Sun, 25 Jun 2023 23:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btzmZqAIOeiWdhG6Z3x+qLL7WZnqbU97Uuejwyz1JtT0cCRMuWh+azSkmTSO9EnoRwL5WLsMivbDM7W51Ur+HlPFzDPjomvLPaT5DUlJvU8mY8Y7KgWJu3FAF567t9H2im+VM9lZxr+55S7cHHjNmkwswYL5P9rjRB+xLaX0jJerVDvE9bkp9+L4vo5b1yP2tTEdLRXjHu34+a/ALx5OwqrrRuY1mlPmM2TlO9FaHru2JULJbINFzjT9LofwzXvzxU68wrcP7KVJuRZ0iEQ+s4xCGSdfFKXBPbfVaNGZqODZFRbzQX80xCs314CdxKEDCs35/LqrtGpqQbOOUWSNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqfXBbOeYmJB/d1CY+LyH/E1c9KWxXAFBNqHnT3i2Bo=;
 b=Fzq2/BPvZOIh1iFRAvwz5MAPRhydK8pI8Baqh0KJb3yHyx3r5dCcCaYp6+a63Czt5uh0WVViSEzy7RO14B0jyVAvLZ0q2FvYNah56xVybwbiGjfsJmK35N1XcCHQyq6NoKvwpvawawY5qKE1r8IYLHwjnNHaf56c25EzM7xMH/iBdsIcT7+Qs02MtMNDPR2ivYUjGhPsO+9xRqnfsMu7ovzqGllhcH8J1W6ZMLUFXNhKZNmK01AoiOm0XGEMaiNiW2rx0djBAOsVjKC3xrmX1GMQUATmkp9HSGtdspMmhHy5pS5Ayathh5uL1acwtNVFla1SOTVD+78hNdZGE7J1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqfXBbOeYmJB/d1CY+LyH/E1c9KWxXAFBNqHnT3i2Bo=;
 b=2oNoa9rP81SP7CkoycOj5WRv9LBEE3KRRpUvYdCRtddqVvw71hXAdWsf/rFUOcW+PRWij2EooWGJoUycMgg3A11g+Aps0Td85RdCXjpKE8KS/pquv7BZXZUt6xUuAgU4pGL8RMznyGdGvivVHRzEIyX/eq4dMH9Nfr0idF8fu30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 06:06:55 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 06:06:55 +0000
Message-ID: <d483f539-afd7-8268-5fad-10d9a4489a37@amd.com>
Date:   Mon, 26 Jun 2023 11:36:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC] perf record: Use PERF_RECORD_LOST for synthesizing samples
 from read_format->lost
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        peterz@infradead.org, adrian.hunter@intel.com, kan.liang@intel.com,
        eranian@google.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230623082031.1402-1-ravi.bangoria@amd.com>
 <CAM9d7ciP7hj+u70qxMLE67Hm0uUJfC1rjnW-jDXSLmVYpef_eg@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7ciP7hj+u70qxMLE67Hm0uUJfC1rjnW-jDXSLmVYpef_eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a47b2a-5b21-4984-6ded-08db760b8aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dI6f6RuoIs1RRrr6Q3fsUP2r9A5G5N7siwVYcMz9qnheyxwaeLWIcyqbDXyMrf2/W71FFVrSvN1oHO6MU2ympqz+4R2eJPrpfxBGs6r4/gfzKm9eoKMWpQ2v+2fnv/GdStQ+UJCmr8WhotyT6hUS5fROz1nNsOL/6l5ezWCrHls5V0l+AtDrsjcXn7mhZZW4NU8Ydlk8f8fJ7atCdsBZgsrHRU2lh1yXESqy3JLP0nuRvmWRmNjd95u2iuh1KOG4shO4385e8AimKsLdG5iz2/ixmxyw0RoaK71LAcGtDzKy2FyEF5Cda1HRygY3y4zhbtuI3ZYbusbNLuTU2R5/ZI7LBdqCgVwhPQVGGyxTZD6J7ighINFqGB3SBISSekXdOFBDJ4Vmr2wjEIt/UrPuqVOUwilKhoqsWfVls9Ewj0cHISq/LC1F9Sw/iobvyWYCGSUWYhDgUTMErKdtSBTFqLEh0ZocP+Vq0mDluS+CkACAnuuS3+uYpRyn6rJxIGzh8BVqpa0dS9C80VT8g1r1rCNw2jfsIU5GKBrVATJjBZRFts6OhftiH9eKsBCLNvrNihvV2Dhfe0roIEomkN78enZJP7a+JNaIsuBKFjkhmGfkxQjbn9qFl1Tq9YXbKB2F7m3Qurkwjqihqi2P46jnCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199021)(31686004)(36756003)(5660300002)(44832011)(7416002)(316002)(86362001)(66476007)(6916009)(8936002)(8676002)(4326008)(41300700001)(31696002)(66556008)(38100700002)(66946007)(6486002)(26005)(6512007)(53546011)(6506007)(2906002)(186003)(478600001)(6666004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjF4dExNaGFOM1JwRHVnTlZMaVBHdGhTMlFnNm5nSlFRRzRUSFp1b3dxRGRB?=
 =?utf-8?B?ZXFINlN2NzdzTjJGdjdoYU1pMmd6ZjN2cUFBTGdtVVV5blpDdU5jWU9zZlVy?=
 =?utf-8?B?NGZWdks5bExUMXNXWWZTWVo0U0xNTGd4VHpxUWVpKyt6VzhwR2UreTgxbFJX?=
 =?utf-8?B?aWpwdjBTN1I1dGc5eGtobHdoLzd4cS9IWkN4eDEyNGgzZFdoaVAwRVBCTE01?=
 =?utf-8?B?bFBKais5NkxTSWJGV1ZhSG5ZdE9SSGhQanZnT0FkcWdYaGtmcWNUakpnL3pz?=
 =?utf-8?B?NmRlZlcxdGJUUTNiemYvaWFRcFFMQkRwQVFHS0QxZnh6eVo2YmkzQlFsY3Bl?=
 =?utf-8?B?bnZJMFp0eDh0MC9FdUNCVlhlRGlZTWljYnQ4SG9Zd1pQekRabWhoWEtwd3By?=
 =?utf-8?B?dWg3R0ZNUHJzOVVpS3RCaXNCUzE0V1c4K2pZN2RmSDlwSlJucGh0YURIM2s4?=
 =?utf-8?B?dzJaTjlxWVRVbVNBcnBqamxUWEdPQWY0aWFKNW94ZzNoaGZybnZzUW50eFgv?=
 =?utf-8?B?OWt2MVhWOTBNRXpDeHQ2S0NIZzh6YlNhR2FrYndOTU5pYW01bHpHc1Voc2Nh?=
 =?utf-8?B?Q3FudE5keUg3VGFiUVZHQVF4bFJSS2ZZOVVweXZ2TFNyQTZzYzNLN29hY1Jw?=
 =?utf-8?B?dks1NnRNTk5WTnhySUs2aDhUK1BkTUQ0Mk5yMEIzLzJwMm5BSDZUL0F2WTVq?=
 =?utf-8?B?c0ZiMGZ3THo4dlozd3lYWXR1MnU2ZHVVbWQwMnVMeWgwMVd5SjlidW1XcTFu?=
 =?utf-8?B?SmUrYmdmWFMyTlYwclJhcThzK0lrNUk1R2dQME9WUW51T0xHM3dKU0tRMVVZ?=
 =?utf-8?B?YUU3dzZMckRSRFFJdExvajVhdzZMaEl3cjVKcjgvTXVSS3l2OFdoYUovN3Uy?=
 =?utf-8?B?YWw4OVpuVUtDa0JFcmlYd0pUUk9LT1d1SEhtZjZZSlZ0dnp0ajl6RmEwREdo?=
 =?utf-8?B?dk1DcE1nbnNqOVlVRVpqZzNObUEySmhDWXlHNDkvSThuM1lhU25kNWRtT3F4?=
 =?utf-8?B?ODZac3VFcGlEUGQ3cE1OcXA3S2VYM1plNVJDVnVicm9tQWdiUjNDTjVNNW4x?=
 =?utf-8?B?eEx4cXVDc2RldE9UNG5EWjlONG1xa0ZrSWVVZTJzcnAxeDhCWGwvakVYRHB1?=
 =?utf-8?B?VTdGTkg4TGg4NEYveDhCQU1EVUFIcGZCVW43WDUyTkxVaG4vSUxpZVlOaVB6?=
 =?utf-8?B?T2xZWGkyUkpQekgrbEtEc3VxL0lzQkRMMGYzbXJBWmdWdnZrU04yWXFhNjBw?=
 =?utf-8?B?WnorM0kxckY3dXUwWnVIRnB1ZllpelNXeVNya0JuZnRQajVzVkUybTlQaDJK?=
 =?utf-8?B?b1MwQjZ6NGFuMENONUNJdUhKY2g5TjZDSVNoaW1VVHNpK0l4S1J3eGlrOHlU?=
 =?utf-8?B?OTNrUHk4TWYrMWZYYTZBdis1c2FES1J6RmhmYXhwV3Z1bWFvREhwUWpCZ2NU?=
 =?utf-8?B?S0NjYzZUVm1MOGx0UDBvcXQ0MjhXbHhsaGozOGFVeElDQjR0RVIyTVZ3bzND?=
 =?utf-8?B?Mmo3SmVpTjY0ZEt2c0hxTVJZRzhQSDlBNEZUOEZCL3VLWGlXVWFHd0ZxQ1Rt?=
 =?utf-8?B?QXRJTXEwTUUrc0RQNTI3Q09RSzJQK0h2Qzk1aGF6ejVhL3ZqWUptVDB0L290?=
 =?utf-8?B?QnNrU21qU3g2QWw1Zi9pUWRwemZwb3d5S2x6UFlhS2tSOXU4Z0tKM2xSN3lp?=
 =?utf-8?B?bitXZ21RL1hvNEJzdlNvV3ZIa2hYT21tRlNCL2ZsUEJLeXJMTzIwZzNLaTlJ?=
 =?utf-8?B?eWswVFRZaVhTeGdEc0ZXVk5LZHFyamlUQm14cy81WElkVk00UThERXdOSEZz?=
 =?utf-8?B?eDhsbGtGVE0rek5tek5iVlZKcUlKWFJvQlNFVHprOGg0T0tmc0s4ZWE4UDZN?=
 =?utf-8?B?YUR1SVg5MEVBaDFwSFY0S2ZmN0YwS1EwTzI1Y3U5ZC9sOUZTM1dJNEVxR1Ew?=
 =?utf-8?B?emJRa1ViTEtwYzRoa3pReVhheTB2RXFLRFJVWXFRY2thUXVYZlJBdHFJcHdN?=
 =?utf-8?B?OVVjZFpiVlluQ1lZUG1DQmxIZy9ITFc1cEpSWkp2d3p0WkEzaG5VbFBRd3hE?=
 =?utf-8?B?YzdSeE1QNUErM3QzMC9FUHdOWFd5WFVmd3phNUFSakEySWhrelJEc1FYdnU1?=
 =?utf-8?Q?YqRxEApFIhpIRIQAi2Pm/9Ism?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a47b2a-5b21-4984-6ded-08db760b8aaf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 06:06:55.0185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Is9KYtoEI7TfxRc0ws8sdqgG5h6iRSRTERmSzzS/WzGqTwJ2QQ/h+FSQmkd4x5XGGFo9QadNVK0n80lWNSfwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-Jun-23 11:25 AM, Namhyung Kim wrote:
> Hi Ravi,
> 
> On Fri, Jun 23, 2023 at 1:21 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> Currently perf synthesizes PERF_RECORD_LOST_SAMPLES samples for values
>> returned by read_format->lost. IIUC, PERF_RECORD_LOST_SAMPLES is used
>> only when hw provides corrupted samples and thus kernel has to drop
>> those. OTOH, PERF_RECORD_LOST is used when kernel has valid samples but
>> it fails to push them to ring-buffer because ring-buffer is already full.
>>
>> So I feel PERF_RECORD_LOST is more appropriate for synthesizing samples
>> from read_format->lost.
> 
> The problem of PERF_RECORD_LOST is that it counts non-sample
> records too.  It just counts every lost records and put the number
> when it can find a space in the ring buffer later.  We don't know
> which one is lost and how many of it.
> 
> Some users want to get the accurate number of samples even if it's
> not recorded in the ring buffer.  Using PERF_RECORD_LOST can be
> confusing since the kernel will return inaccurate data in terms of the
> number of lost samples.  So I chose PERF_RECORD_LOST_SAMPLES
> to return the accurate number for each event.

Ok. Thanks for the clarification.

Ravi
