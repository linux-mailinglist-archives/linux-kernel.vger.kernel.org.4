Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8E262D8BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbiKQLBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239670AbiKQLAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:00:39 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534D92AD9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:59:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeNeapqROKbt1h8TuDgfavImzYyH6y3ykodZh5ZoVb94lP1uo728kAoj3oiHR90H55YTBSE2ljlsdjjk6P4+DnaYtYtcpgNkiGr2d4kH4lRvWO56JDJfd5AF0nBrBfWiU9j4EEIM+3A4eIiB7958TYNnJZGHaKjcanlZwuJ6Icuv9E1a9h0V367Pbuy5cHfnn7yTh2/VKwOemJdGNfQ4lETrvVus65ESRUuos0nm3JkquMqtNaoUtTydY6+GfvAIDna0IsUJHMyN3DqZtRO/xQVh4/7iPWzFhFm7SrMDWVhleO73SNnUpvsZkImtPJY+a23XTlcqiUiSgxtYm9YHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07K5Zu+OZMaPtn/f+3VebdbwJeee577GRuUk0x4LmPM=;
 b=DhwFDIQBTs8fcsgj6dsrzIYZgMmaCDdjDrkcoYQh10wEXzHep1la/FneQclAu0X9H0VhTT9ts76+Sia4gjHe7xtjeGnMoezhLSXMAxg9xcSLSqblCnpi7/IXQBxyfBIogP3YH8XLWnjmba8BzM5AU0AyNEnNK8BFjywTPIwwcsOY+6rcoHgSVw6N4r2Da6R2jo3k0P/Iogyw0+niCOcr3A3oWs+ESFBmQ/j7uR4eudJUGscltSySvAV2L/pc8YsJM2Jn1yYFjv/dif93zFA6L+j3UsmIEc41qr4yO4Tg6hAxb2RQ+mT8lcIZqGa5KhESGtRin9yfuWaoZ7JWMZesfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07K5Zu+OZMaPtn/f+3VebdbwJeee577GRuUk0x4LmPM=;
 b=ZMpnIVoPOo8Au5GSNe+pfhCRrdYs2Gs+vNsdWP/fXaW9Z5g3O4ksk6VF2QoIuQvgb5fbo91Qc/TEs0AlXge2orPtBQ7EoN4uJigphlngIQ9z1YgatEGHIbhfd/iYyJFoqxmMza5mHZLzUZ4BtuZzqyGr0yUviLSyqRkblDYTCvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 10:59:42 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981%9]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 10:59:42 +0000
Message-ID: <68df3063-3fa2-9332-1705-631716589450@amd.com>
Date:   Thu, 17 Nov 2022 16:29:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] perf: Fix sys_perf_event_open() race against self
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, nslusarek@gmx.net,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220520183806.GV2578@worktop.programming.kicks-ass.net>
 <700710fc-1ac1-1b39-0e63-eb86adb4b984@amd.com> <Y3Vkmvi2vib7fwHn@zn.tnic>
 <7bf54a3f-07f7-5471-f6c2-88d3d9bc7a5e@amd.com> <Y3YPjo5wdKGVw7c5@zn.tnic>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Y3YPjo5wdKGVw7c5@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c52d88-7846-45d9-17ab-08dac88ad462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: asCASyBgrZhEOkcCJdTZGW8YA6hCihjtDgkpfj1v6Yr2u149fYQxazz4bIl1FQj/AtkmPcnaRr9LoZxZbbGEw2mI4eyIwzagJYJpsFAsqQv15HmzeK6v6ndoaa/pj88hnorAz7WkdS62xuOkg9OkFX8aIS/r+FrHH0UDd/92yYbdBWZlp1dCoN1S4UzXBKFAVc1z1+6SWpQyZv1t7N07xo2IR8e+/VpP970zwc/UCJ/KjVliUDSgwCHjLq1jrZg3RybLx1G062Pg2nTvxS/+T4jq2lA2Fqz+PHeJrUwTC5oizuxSJ5TIeSva9bA0zu3cZfRN0YE3tx0mUb7GWd32tP2UziLovtScQ+maM47xDQjnWRhF6LtWyUpuXh8LdFobdHYPDoSZYXHJfuvnSRCBhABftltqKw9epaLeJlKbLUAR46zgZqgM3b1R4gooHYMg4WBVe4RwbTNdki4P8aShn4sd9TWJRfz6J09oh62oVEMCMjioPRVNWjEN8+iFNWu3AfC/yZ8IsSc2EDzuCnyCoqCVUiRNHlaw8dqrz/CL/WeiWSvVPxoLN6v9sJpdDzvVgKZGAzbk8bku0QMefXeVYRMvUUg3bKKGG4jMXmA3QjS2B3m0V1E7AE/THJ9lO2gReQ/udT8rqzKnJE3WqYKXJpQ821DLlfpm6ztRW71En8u5sMT5nACHD0PCPlgdsYf2HNPNBka4tpJXOp6h2D+CGlyyXD4VzclPN1hT9vYo6l4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(8676002)(66556008)(66946007)(66476007)(36756003)(4744005)(44832011)(41300700001)(4326008)(5660300002)(8936002)(54906003)(2616005)(6486002)(186003)(26005)(6666004)(6512007)(53546011)(6506007)(6916009)(316002)(31696002)(86362001)(478600001)(38100700002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmdYT2lsMElaOW5lSUhEeWxGRDVBTndMTnljRXo5bEpiR0tZOFJwYk1YM0ZW?=
 =?utf-8?B?Wi9pY3dMR2dhNitGdjVnTlh1UStHbWpPd1VTeklqRkhrNlRoaCs0UHZyanJm?=
 =?utf-8?B?aEYrSlBvcFpubUZHeHE4SEsvc2NKVHhXYXpyTzQrS3dqOFAwYktGK1NiRXFJ?=
 =?utf-8?B?RUtxK1kwQ0c0bHJqUWtWL2Nodk02dlk3NXZiTU5HMVBNTnpXemhCR2hQKzdM?=
 =?utf-8?B?WDJ5Uy91UGtjSGJpSEJyV2RsQUNab0l2QU5OY3cwTVh1RXorMUJGT2x3d0NF?=
 =?utf-8?B?MjkxZVVWRkNQMnNick84aFphMmdrK1MxbEtZTUczUjRZOFRZNnhNVWJ6K3dv?=
 =?utf-8?B?WDFMSEFTVUlveVA1WEtZYjVrcmJBS3pVcDF5ZTBObEZOQVp1MjVUR0lDYW42?=
 =?utf-8?B?eml6VG5sV0JDQjVsNDNIakdUTXNEK1hBdGUrc2FGOTZJTHdCVFl3d0NEL25B?=
 =?utf-8?B?Nm5YWE51clQrd2tFYWllQU4wemhtZkw5QTlLV0hneHhQQUVQb3Znam5oZlRk?=
 =?utf-8?B?aDc1d0xGZkhaeUFuSlpTZTI2OXIyaDJXem4yT1k5QXZGZTZlcHBnb05sMVJQ?=
 =?utf-8?B?SXpDWVl1aUZXVytTZDgreFZCN2VIUnNTYVBQWG40c2Vkb2Q0YVBRNzU3OHIw?=
 =?utf-8?B?MDM1dHNOaG1TSXFhb096UXdveDlGT0xreE9aZWoyR3cycThOeTlKaHBUbkFT?=
 =?utf-8?B?Y0pPc1JFbFVwNEVqOTQvSGRLSk00Rm5xRzJ1eHZxNC9zMjIxMFZ6VGM1QjU4?=
 =?utf-8?B?bnhOL1h1STBIZUZsZ3YyY2o4MzNSRDJ3RjNXOW53Q3Z0NGdCRzhNNjVObGNV?=
 =?utf-8?B?bVl0NEFSdU1HMTBSRXByVUlTeFp1S2s0dnd1c3V5QmRyQlhwV0phdlE1Umh3?=
 =?utf-8?B?ZGQ1MXF1dmVFbXg3WUlhcXA5ZlRUYkM4YkxMcTNVVThEOXlYd0NYLzA1R3Y0?=
 =?utf-8?B?ZnJGc3dWMFFPZU9xa1lxOUdyY3FzOFNnU1lad0tvSElvaXViMER4RkhPd2V0?=
 =?utf-8?B?VEI4YTBWelhJNkZmM1dBY0Rzcjloc21ZWVAxTDdxZXFjVlAzRmtwMlAvOWhN?=
 =?utf-8?B?SCs1ZE1UUUMvZVk2TVlyRnNRbVRwYUpHUGlsNE5NbUhMQ1VMd1lvU0ppK0ZK?=
 =?utf-8?B?RFRwU09jaW54WHM3amdiSCszQlZ2d0s0dm56RFIzVTAvc2JOazRYOExObUtn?=
 =?utf-8?B?T2JhU1JVSloyaWFORC9ZMUtlVVk2UVZ0SGhJY0ZwZm9tRStXNWJSNEZiaUxo?=
 =?utf-8?B?eGtoZHBBeFpGTktnWlZEMzFzUEcrc0hyQnRmc2Z6OWJBekhRVEkvUWtNOUFr?=
 =?utf-8?B?Y1h6ZUtScVUrdm9LMFZjTzhCZXcwR0xJcG5rOTdNMjdmdGhHRjIydG9BUjQ4?=
 =?utf-8?B?dE40T2NOZ0JiekF4R3J5SmswbGJYZ3V5MnByK2JIQy9xaThVUENwK0pOa2ZJ?=
 =?utf-8?B?V0hPRGN0WktsWkVEbUlCWXBvdGFYVlYvSTFMOFd4Q3JQS3plYWpOdlVEVlc5?=
 =?utf-8?B?dUdrbTh4ZEhWdWVUVFJZMzBGUUFSRi96UzNzODdhK0ozblZTS0pVZWNjWWQv?=
 =?utf-8?B?Q2N2YXFmeTBMQ090RnhSNUwvU2tTaHpNYnBNVkJCK1JJV09uNDhUMk55QjFU?=
 =?utf-8?B?alBrYy9VZlM2U1FKVWxEbnpWTlFKd1pvYkluNzgwbFUzbHU5RVR4cllmMnhs?=
 =?utf-8?B?dXBCQTJlVEhOWlV5MFN2MTN5T2tzZURzNy9CK2xiLytKdWhJdHpNeGJlaEFU?=
 =?utf-8?B?Tlkyd3BFMzBNeEJxTFJBQlFTREl6clpiM2lOWDJTK0dLR1ZyQTdPTUkxZ0dr?=
 =?utf-8?B?UTRqY2hVd2xhbThjZVRtOWV5b09keE9Xb1Jlcmgya3psWjN5Q1BVb01DV1Ux?=
 =?utf-8?B?RzczMlBjQVZnK3NTUjVUMWt0M0lNaFFpdVV4VkpIOFA4ZUFhWUN4eDJPUWpV?=
 =?utf-8?B?bnN3RGJERVFjRUFMdGlLNGRTcGRaVkEvVWYyQk13aG1MWUNMYjlRbjk0aWpC?=
 =?utf-8?B?Z3o0aHZsV2d0aUcyOHNDNnJXYUcrdE1EcGo5UjdkV05uVU5jSWg4ZTl3UTgw?=
 =?utf-8?B?N214OWErRVNmaUp6OU5jT2t0NVJVRnRFUXNlVWZFNUswZ1MvN2Y1TjhKSXJK?=
 =?utf-8?Q?9cJjOktMexy9GQZ2iAWnLQZFd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c52d88-7846-45d9-17ab-08dac88ad462
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 10:59:42.3723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zh/CijR9+RlPXB2spwpsCx68Jhhmaa7Q9sK/6PGVff9gc4iL+dsOgJBMjVIIAB5zAIlc0eFiyGuvRTlmxqQNvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-Nov-22 4:10 PM, Borislav Petkov wrote:
> On Thu, Nov 17, 2022 at 04:03:54PM +0530, Ravi Bangoria wrote:
>> The issue was because of multiple event contexts involved. However,
>> it's no longer the case with reworked event context.
> 
> I got that but it wouldn't hurt to have this test regardless, no?
> 
> More testing is pretty much always better...

I do agree that more tests are always better. Though, this simple program
was to test a _specific race condition_ which no longer exists in kernel.
So even if we add it, what would it test?

Thanks,
Ravi
