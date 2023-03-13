Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD06B81F8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCMT7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCMT7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:59:34 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0361216AE3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:59:32 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32DE2fHu016496;
        Mon, 13 Mar 2023 12:59:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=o6DjRM6c4egD/qSNAnecBtlX5yyYw5PD7QUl+8vDDnM=;
 b=Uo2LfAzTS4VO8v9mDQrT/XZm6zglfEetJVLlWx3cq+H8DcHUjXyy3yFXZYw81PEPFyjA
 004fOGKHawZ6PYIPgyHY64ctHIJ3XstdjTr6c4YExB9svYprq/2hvwZxedUgtGQdKYNP
 o2KdwycoB2z+eAJtiUAZZpBWbB3jl/EsVuZolbNqu+iLnXUr/NUNxhfYDO5tnAYYsA3G
 QxYU9KCf6XcKQYKjI+Sx5AMoR9jViAiSLAwY/HTWpMwMjUWQCzusbmCKC2lBDtLmpnoO
 FkUlN4x5kliCDkTg2S0AvdqA9ObnUIwlfZN7hYLRrUe8QOGLw4GhpKmp8qPJuBPfTBM4 qg== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by m0089730.ppops.net (PPS) with ESMTPS id 3p8p1jkv8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 12:59:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm/Ksa43bsyfuKcgAU/JyYfH5WNfiFy3egBWBaSKiECKLjb7iza8np70Mr1MafOJwHyd+LF2vmqew6uO+B9iuCs4nbWXErLbml04c6F7itn/g+gn/yB5/PqQSYjYEVnKLao4AHSAJP9fZf69hTsoy+SbwdqXhOVUqU/FLrfvVhRZOqj46O1DbY7vft37fSqIsQWsHhhSGHVqRIsLLkxQVCJ671/UqlSvOFfjWd2szTYNj5Tw8r69Pm4E0fXeokgCE19z1kk20CFVJAqLiecpFVscqTO9K+d2DwJDp4s1fhxaUgL6jjE76SVxb8pN1p/16jXVFGEVEySVeEEalys8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6DjRM6c4egD/qSNAnecBtlX5yyYw5PD7QUl+8vDDnM=;
 b=hnK9dVWvb99AboGApzRRPnRRPGWFLtsela4jzAu3famd4wqWlBWtKa+sBndBD+F3MveBJyDWO6kqVGJszC57lRsDML3qOiIOJos6elJRkoWoA5BrJsqZExrm5fmN0FtUdGIhE+wHK16C8Cy6g1GH6/aFU/nVcVxjsO6richHCiFgxIFv1fW8pJbt3zpzj9jbgvmAV4thjWasanyKMBSlu2e3KihBXOafl/M72gSu9uC8G5IreVampHPA0nS0QdolFfT46IzNJmvhbFLVRmhaN+qBtVUcGEwYFq+rmK22Pma6XL0z7WgoWO5PWJd1P+QR4gQdhPnfcyumQciBEe7vCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by DS0PR15MB6166.namprd15.prod.outlook.com (2603:10b6:8:129::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 19:59:08 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::2bc5:11e2:5c70:387c]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::2bc5:11e2:5c70:387c%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 19:59:08 +0000
Message-ID: <7092a88f-8ad5-1462-4a09-5317b4eb3582@meta.com>
Date:   Mon, 13 Mar 2023 12:59:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] tasks: Extract rcu_users out of union
Content-Language: en-US
From:   Alexei Starovoitov <ast@meta.com>
To:     Oleg Nesterov <oleg@redhat.com>, David Vernet <void@manifault.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, kernel-team@meta.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
References: <20230215233033.889644-1-void@manifault.com>
 <20230216080459.GA5200@redhat.com> <Y+54c0YvXcMIFva4@maniforge>
 <20230217102521.GA27682@redhat.com> <Y/zWPoCjQ6gLSNGU@maniforge>
 <20230307171913.GA4387@maniforge> <20230308182907.GA16406@redhat.com>
 <e8027eca-16ee-2fb2-081a-e54a21821dc0@meta.com>
In-Reply-To: <e8027eca-16ee-2fb2-081a-e54a21821dc0@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::21) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4490:EE_|DS0PR15MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec889bd-d332-47cf-3458-08db23fd6811
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLSEMv58hhsHm+kpolGdlPgTFFYVn28Od3nZcpq5xeEN9O9inOs7wKvjkHgpBtcYDYp7k0LHtegiihVY9zyfx1Uk9rbdk1DC1J6cxh14wc82VOe7Fqe2Z6yB/nZu8cSpHsVBMXS7XaG2uM2+tv9jDQ5wX7wc7ZLIA4Tk/ilpzYAgzHRfSA8BKLvo8K7b28GoZYEk4n33KkdSuzKnOZKxn5KCbxRnMWFEjjpyecl/9jz9na39zAta2hNghxoDm0w4GuYcV3dPObKt71vNRibLjfPWT2ZdGi8FfcbtEmXjVm56yMR0FXW7EflAtjclMgngeXX7WTaL4U//hBFfBFJ403OjFnBkuPInytglg0kNXJXrGy0dHmN53UwdMgZjWqKDs6Nay29Y2lBi2nESe8MTcTuFpH6SUpWuZQ4psbGX1fRp+cOy5kh4luZmhDEDaYf54pEiaK7QcIPDwL1UX+zSI4NeanKA4cPc6j591iGkJmxTyMz66VqTIxTNkS5Shm+P8BG1Brz3TK31Rm0chPDvPh5zMm5VgfWoRSpiQtSC5JjmxD587h9d2NhmTrVa92CAPPBhvh8/u9G2DuyCcAx1/3xLSpDfDUdBjbLun26M+RhXHVwI3wOPYyRHCqkR+I9nJExQ7uY4u0neez9vM+75PQS1bb1/O9/u0ybg/abmF7UTHWNkKziifTLVt0PfvpXxTLhnLUqjWzZRhFR40czVunWEYYTnvqUkjbSMaX0oHzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199018)(2616005)(31686004)(7416002)(186003)(53546011)(6506007)(6512007)(8936002)(83380400001)(6666004)(38100700002)(4744005)(6486002)(5660300002)(66476007)(4326008)(66556008)(2906002)(8676002)(41300700001)(110136005)(36756003)(316002)(478600001)(31696002)(66946007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFBRTUV6dmNiZGN0RGhQZ1dEWHBRWmpDcnhsR2RrKzc3Y21NNFd3V1lYZG00?=
 =?utf-8?B?dXVacDlyQ2ttUU5HRFlrMUZjQ2xXYzBCUm8zRkFsaTVCTFZJajNGUTNBTTQz?=
 =?utf-8?B?VkE5TVVRc1RKek5yank5Z2tUY0M5WFN2aHIrRXhNbXp4MzlVK1hrK2hhbm1x?=
 =?utf-8?B?MlRDL3oveXR1Z0M5c2FkTThxaUJSWmRrMWQ0WGxCWDIrMGs0eUpuangvZzBX?=
 =?utf-8?B?dVJ5UjBXUlVTY2w0Q0FFSHRRTHo1SjdDc040ODQxUXlnalY0V3lWcU14NkpB?=
 =?utf-8?B?VW9pRnlmL0tLMzhVRGRrblJDUDkyWmlQN2djWEx2VmdBZytONkdQQlhJaUZp?=
 =?utf-8?B?WHhaTEFQNnFlRmlKY05lMWs1RFlJWUp6S1lMT3NZMjk2WFR1VXpGWHd1L1Jm?=
 =?utf-8?B?NTU3c2RtODIwdUNDOWVDYVUrWlpINnpnWXBWdEhmOTFpanZJQ2luYnc0Sy9t?=
 =?utf-8?B?QjFnbllWNEZNWEVOQ1hzQS9OTDRRUVF6c0RwZUJWZ09nbDdNRDA5RzR1K0p1?=
 =?utf-8?B?RTI5L1ViazBuTTZVRWZqemlNZ09KSjZVWEZTOFdDVy9WTUFZTzFLUVNmbnM1?=
 =?utf-8?B?YXFuWThDN0JVMHFKWVlrbGtTYmlOWUYrN0dyTDhSY0JpV254WnlzczlEVy8x?=
 =?utf-8?B?UjhyaTFtR3hvT0o4VDNvMlhJcnN5bStvb282SzJRRHdnd2tqcEdpM0phTzhF?=
 =?utf-8?B?Q0FnWEZYdU5tUmJFeUNtNC9PRTc4Vm1ZeWZRV2p2cUxCd2ZCL2REdDR2Rkwx?=
 =?utf-8?B?cytua3RNZlAyMmczTnlkYkZkcXcwTWhrL29FVURZZW1taVhOcUFWeW9RcHNh?=
 =?utf-8?B?RVpiSWJPL1RDYXBQRDNzUmRtT1BuTjh4eVlTNGNUZ01CdHNZSVJKNTl0elF5?=
 =?utf-8?B?MU5CZmJIOGIvSGVzdVZzc0dXWlB4RTFlRldqVnVKekd6clBqbHFxdDBQYmEw?=
 =?utf-8?B?NWd5b3YvdlFCelF6NXlRMHR0TUdNTVIwWCsxcTVxcngvY2F6dk9pSTc0d3Q5?=
 =?utf-8?B?VGQ0V1VxcjVRTzRDdnFUcGQwRVJ2VHVQdVl0d1NsOUNpMWhMYWl5S2REai9M?=
 =?utf-8?B?WTVTVG9xYXdEM0MvSEx5cldZbHFqV01sUnlGY2tNTGgvZ1d1ZXJOc2wyN3pQ?=
 =?utf-8?B?dE9DVnAra21BMUNFdjNnOXFoWHkzYWpJckZYRWFJSUFGWlV0TTFvZ3RpdzRX?=
 =?utf-8?B?MTNXRUUwTWI5RlZqVi9WRDhYaTBHTnZKK0loUkdWVzZIdzc3K2d6K0NubTJ2?=
 =?utf-8?B?OHYxdWg5c2FhVTQzaENheEFrUkVHVGNtUlR6b2ZVZmY5MHY3NWlDZVA3T3ow?=
 =?utf-8?B?YTRJcmxkTTFqbkZXT3NrcmVTUWhpMEZ2TFNFcmJrMGdSMXdEWEZrVHJDdzRD?=
 =?utf-8?B?bUJVUUtaRGlUT1RmQzMxcCtDYTJnMURIZ1pERi9DekhtYkxtTUN6Z2NYMzAx?=
 =?utf-8?B?VG1ZOHR0SVlWamh2M0JVbEFSR280LzE3NDNObmFBL29PMUY1TzZGeGJvRVY0?=
 =?utf-8?B?TVNKa0JLY2wyOFNDZWVzUVBqTmhTeExRd1Ruc3VreTBxWEtaa0UwVVRhdCth?=
 =?utf-8?B?Q250L2Y0RXZBREhoY1RQUmNDMEQrNU5zYjl4N2VFRkZKUzhZYkx4QWU2eWF2?=
 =?utf-8?B?anRVRGhTNjZrUjJsTk1QRXZucXpla0dra0dvZU5DRm45RWR1SnV6ZzZhZjhH?=
 =?utf-8?B?ejZJRzlDL3llZUdMSWhBTHgwZXJGUzlxK0xhU3RTM1lab1dDRkUrWnhtVDlC?=
 =?utf-8?B?R0NlclRnSktibUJHbGJ4UFBGNXkvalFYM3lzcHY0bmswL0FKWTlYbER2bmpN?=
 =?utf-8?B?TVJSZUpldzBZOVNieVM3RVpZbXhRZ25tQzluSnlGbDV6cVpNV2lkVC9hSDBh?=
 =?utf-8?B?Z2twMnhiNWdid2pZNUJFeGFiR2xoUi9xQThRRzZOalJBMHc3QmNGUFd3Z2d4?=
 =?utf-8?B?dDhSNHgrVDRSVUptZHRWd2N1Ykp3eFNJVzJZVVdZczVMU0xIbmZ4VVo1R2tG?=
 =?utf-8?B?dGZ0aWk2M01FY0VYcEpBOFRZTERmd3R5L1F0QjNDaWI4MTdWdnZXMXhUM1ZC?=
 =?utf-8?B?NmJoZFdxNStTYnQxT0dpMFBLL2tFSzBITlc2M1Z0cFlZeEN1WGh6NnJsWXlW?=
 =?utf-8?B?MlhrSWZ3NGgvZTl2cVc2OU9aTkNPOXRLUW9FVGlGRk5jNExoenU3am04V1VS?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec889bd-d332-47cf-3458-08db23fd6811
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 19:59:08.4756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGyqb/lgDw+04uzHKO7bspjSch+LPXpDzaROwGY4a2XLITJLy/au5ekymMCTiIVk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6166
X-Proofpoint-GUID: NFF9SthMsEsQK2YhI21Z_jldm5bhwu48
X-Proofpoint-ORIG-GUID: NFF9SthMsEsQK2YhI21Z_jldm5bhwu48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_09,2023-03-13_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 4:55 PM, Alexei Starovoitov wrote:
> On 3/8/23 10:29 AM, Oleg Nesterov wrote:
>> On 03/07, David Vernet wrote:
>>>
>>> Sending a friendly ping on this now that the merge window has closed and
>>> things have settled down a bit.
>>
>> Well, I can't help to merge this change, I lost my account on
>> kernel.org years ago.
>>
>> Perhaps you need to resend this patch? FWIW, feel free to add
>>
>> Acked-by: Oleg Nesterov <oleg@redhat.com>
> 
> Thanks for the review.
> If everyone is ok with it, we will take this patch into bpf tree.

Applied to bpf-next.

