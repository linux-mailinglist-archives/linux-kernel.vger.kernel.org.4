Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A236A6C64
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCAMdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjCAMdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:33:11 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C7593D1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:33:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCWvP1COT6hoZbiEomi5YENNDvX/LQyFhUWolzzC7YdSUshyWVNVvgC1u9+MO86rp7ZDYpu2XdPc+7gNueJo1GtHQuZkswiuPDU2W19KLFhMnRliMbXCa0OmwRBQcP412FOKkXIn+EuwO7BcOD8/pBzj1ot60TjdCBvQ1ImJ6KiDfQZwaQmDFK5lRRAwz064WLmr8DxncVSxpAKJQkF70XjSLrEmZuIfwJyuDwf0xjqpVBfim3pkQvvUtSiyawepglu0sKYlT36VudP415Tzvh/gLg0oZPudhzCI/+lyeYS47LcsIo97e61zBxVI2gN/oPHQEhqxC/OgnEpuyK7ooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RvynnJ+pRuatucLt4XU0jePx8rnj0i9eu2hGAeq+lk=;
 b=R4F44T669D5w6sbxQVcPoFg5k+4hgSTiZf8wG2M4DHhbIzSuBahRcrqTX9uLYkgcWFr6f+pV3dwVebdc+QjlJ5ESSF0IGb8VeguX0gvW7ZJapOFwQIIOTX3OInwD7b1bBF8a7CZ2/LbsbZzQ6NmHjL9fJDx90O3j6u1u3YozlfRukMMRa7E5V7UOD6lIWmnw43JHxhfa87HhHZDLQm7K+FgdZL2k/SznKirEZFUV9b6PSRThaUP99zxLXZMzQMLt4ysIX//MNaN2Oqr4Qfn5T5l8DZuj29XkYNY9F0VD8fNCnLLoa646tvXk3rIHNlq5BabnpuJaNHi+VW18kgOJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RvynnJ+pRuatucLt4XU0jePx8rnj0i9eu2hGAeq+lk=;
 b=zH1OuJM583pen5ZRNcOrvQuAxvskFaEm+oIl9kMXxLDqXd+P8/a48WqMsst6Z7aWHL4Cysy09CI1zfPHtwGLBI4xKpJfdB9DVbPh57+GpYFdLwJ5pvhoFF5wzhgqWP/rq/MrdgmiojiJO/nGKJVPmTqlqujH2DusXLLCxGke+vg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 12:33:07 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc%7]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 12:33:07 +0000
Message-ID: <895b9edb-6df4-7b7c-3b4d-8628a54977cc@amd.com>
Date:   Wed, 1 Mar 2023 18:02:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V3 0/4] sched/numa: Enhance vma scanning
Content-Language: en-US
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
References: <cover.1677557481.git.raghavendra.kt@amd.com>
 <20230228132425.1e18d47bdc4f406220a4a409@linux-foundation.org>
 <bf81bb27-d8cb-d994-e78d-caccc55eaa26@amd.com>
In-Reply-To: <bf81bb27-d8cb-d994-e78d-caccc55eaa26@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::14) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|PH7PR12MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c50b2e3-ea3e-4e9e-78bc-08db1a511c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6kBP2Pl240aPbX9MfgK35ZBuxro638gaq2oYr8t2o2Vk23ght85FYLebFb381pN0yBlMqCk5v/r2AGcCS8vX+P4NXUDwWpQMGtrvK0gyejyG47Cq894IMuEeRAMHUITztR/GAUkZ3RoXbgQs2npf7oLunC9Z/C4NgSB2oufEbRKWvH+G2QJHGEJL0tfTA6EbQOkp0y2UVr4J0kn6EzYkK8wiQpmsSFbfnZYaOKubv4Pro53By816Juufr6htBKdGEfsy4vI02g8gVthnK1/C1mYFjF4yzfW8cH3BqikP6L2t3Hf7Iyi/ej5rtuJ4MPLF5bqXdw7r7lkU0qLqduUAytqg/DQUU8TEoD8nRgWXXD7+pSF5bTAP+AGbrNNkLT4/Woye2uxbc3UHajgy9ivPKd2GUWQAKOg5o/Dype3qmKUqInBWPqrys+z6BzJgqbPAtm8EQxwYnyOx1GqtN1lEb1rod6WB5b5K/z7h9MKSfKRXrNbh2At5GP5WqwqFAUaTmLqmELCQ0E5QgyCIbKCBU/eJGOsnHyLmCcaZ/F/KOhGdwPTA/1XDFUfquw8i+WP7vgLDrRI1TnM/Uf03MunJrgUBBinHenOLlZvVj5hqLt77p0VDb+nHoZ0OpLmWmnzBzc0I4McpHKkuUzXrEj37tG7UfP27+mXjMmmxS/VMZSAC9uKWi/vSR/NFNJC9ABca+xBDrFS2XIuSA3fJQxP2AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199018)(316002)(31686004)(8936002)(5660300002)(31696002)(26005)(66556008)(66476007)(8676002)(66946007)(41300700001)(186003)(4326008)(6916009)(2906002)(83380400001)(54906003)(966005)(6486002)(36756003)(478600001)(6666004)(6506007)(53546011)(6512007)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3YwNFRJWWJZWU1HSWkwYTZjL0M1VnJnVnZuZHN1ZG9UdzBlRDZMdlp6Rk1L?=
 =?utf-8?B?U0FBTk9IVjZBdjFHM1dsTW92S2ptODRleVE2NTRHUk1RNU1zaS8vZG5vYjE2?=
 =?utf-8?B?ZnZIMFJxVkdVVFBrM1I5VmVJRmVvRG9lUnVxeEtEeXVTeEtidGJqL1QyR2lQ?=
 =?utf-8?B?RHFiVWVuQVA0eG02YVBrZU04Wk8xc0swVmlMTFFoZUdMelgxTUR1YmVUTWxt?=
 =?utf-8?B?bmNxTVVtOW9MSlJHdDl1NjVPZmNYUTAxdGVZMDh3UmFHRE45WVBYZVBlMDBz?=
 =?utf-8?B?eFMzMzRzZTgvait6bW1weHFiNDgrcXAvd1pqQVkra3lnRG1uRVBoMlBRVlRu?=
 =?utf-8?B?WFk0ZUJmdVBXYUJveUYvbFErc2lDZXhpMXUzOEZlcjhoRmhOK05TanQwa3VS?=
 =?utf-8?B?TWVZOHYySEhIT2tobXpmWDRiRW5nUXF0aHdaYjM0TFhyN1dWbGxqRWNkeERt?=
 =?utf-8?B?Yk5zZC9LcVhGdkJ5NHNDRHRxaDFiTHQ4SlFRZXhJZDhhbEZsa0VjcUpuT2xa?=
 =?utf-8?B?SnpxZ1p4Kzdwby8vNm82Wm0xdVJPNWwyaTJ3ZVRJMUxPdER6NERmOHNUMVhV?=
 =?utf-8?B?c240c3h3RkxudUEwenV1ZlJTL3RXazBoK3o4ak85ZHhZVis2Sk14MGtqT0hz?=
 =?utf-8?B?M252L1dNT3NqWFJOUzhmTEFKaENIbzFuZzBkMkUzMGlCUnJ3a29uRUU1blBN?=
 =?utf-8?B?NThvT2ZaQjZwM2hJN2Q4Y1V1T0d1ZVppMUF3VzBGZWo2eVBDMTJtZC9VWVNo?=
 =?utf-8?B?U3lNdGFwOGdORC9tM1ZaZms5MGdQV3EwbVhndjRTQTkxV2I4WHBVbTY0WmhL?=
 =?utf-8?B?Z3pEc2YwaW5zWE15WXh0d3B4UFVyMUFjNExsUkw0TjdDT3ZtK3RZUEFRNEJX?=
 =?utf-8?B?cEcram1iSjJsczZpd2pEQ1FlMitxOTRrNTBoQWpKUE5JOWo3S3FOMzBOYnlN?=
 =?utf-8?B?bTU1TlIrOFBtdVREVzFrZnZxYkY5ekRNRWswS3orN3gwZ2IwQjNNYjFGSjlH?=
 =?utf-8?B?RUZXMnNFZ3QzbU5FNFlwVy9yYkhBczIzcjNTbmYrOVU5cVBtQ3A4MUp0anIx?=
 =?utf-8?B?YU9TMGg5ZG9WNjF5Q2VDN0tMeVFlWVZ3a29xWTVDTzk4NjZxYW9qNVIza2ww?=
 =?utf-8?B?SGwvNWYzeS91TmZ5ZlN3Zmw4ZDZMc3RrT0RqY3Y3TkxMWUVDQjRRVitmcXRu?=
 =?utf-8?B?ZHhZNzc0UHk1S1BjSkNSdk8zOTJGdVdhVWZxNUNrdGZVNW9UcnRJR0w0NWdo?=
 =?utf-8?B?QmNJRTJvRGZoK1ZoTlpqTzJ1dDZjQ3gya3RUM2Mrb2ZmbElvS0l2aldNd00x?=
 =?utf-8?B?NmZGMmpCTy83L0VSb2hkWnZvamJxSTVsaXpEVXFnYkxhRFFlZEw3Mi9XODhB?=
 =?utf-8?B?cFhFRXVKVGVNcVZFaFRNZWdBb1A0NlZabUJsbUozQ29COVYvMmROQ3czTTk2?=
 =?utf-8?B?Yk9ueUxGSUVFVVdISWo4UVErQjR4MmMvQ1F1OEZlV2VYSEJ2a05GQ1Qza0o3?=
 =?utf-8?B?Q1N4UWxkOWNOL1RZVjVaN2hCOTNoUWUyOGE1R00wb0luZS9abWVWNE1zeG14?=
 =?utf-8?B?V2JWMFZ4Qi9DZlBLUW14cHZBWXRTRStraDhET1VLL1d2eFV5YjZSdHY3SkZx?=
 =?utf-8?B?NFJ4MG5ydE5JS1N5cTVhZC9FK0RTL1lwSkRXeW5uTE05ZzIvVEVEM0dNWmRx?=
 =?utf-8?B?UjlyVUlVd1VuTjI1ZWorUlZhZy9iR2pseFBEV0tBT2hKeFZLWVNFSVk5b0px?=
 =?utf-8?B?YTJOTSt5WDdJa0ZHb0lXWTRIbmF3WWlzVFIwcUZUMC9IbGNrSWVuL0lSczFY?=
 =?utf-8?B?Yjl5MXppcWRacWRLMUZuOW1QdWE5QUtQaXVmVHJqbDkya2doODdVYkFZWEZF?=
 =?utf-8?B?NmJDcHRySVJJZnNqOTJuUjF3OUxURGlkc0hhOXFRVERjN3htVWVXS0tvOEpn?=
 =?utf-8?B?eXBYRGlXb2g1cnRjd09YRlNORmdxTHZvVVh4d2RoS3RxY2ZaNjEvelNFNDlo?=
 =?utf-8?B?RjdNekZqM2Z3aWFLbWNSa3Y5ampFUllmVDVGdUg5MmJuWGVCVmR1M1lsUFhK?=
 =?utf-8?B?UVVTczhmUUdBN0s3V2t6ZHRHK0kzTGp1RjZXUE1qUm9qSVJBU1BFdnV0YkUx?=
 =?utf-8?Q?78xdqcPB9Rqd/sQZve9UavkIy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c50b2e3-ea3e-4e9e-78bc-08db1a511c2f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:33:07.4665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syBp03x6dhzUAbmO//HbndHLKjscUFlHXTeFxHh51WEGSmLja2h3Enj3pRpvJzlADeSeTyx7FPRDZYJ9ovA08A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/2023 9:46 AM, Raghavendra K T wrote:
> On 3/1/2023 2:54 AM, Andrew Morton wrote:
>> On Tue, 28 Feb 2023 10:20:18 +0530 Raghavendra K T 
>> <raghavendra.kt@amd.com> wrote:
>>
>>>   The patchset proposes one of the enhancements to numa vma scanning
>>> suggested by Mel. This is continuation of [3].
>>>
>>> ...
>>>
>>>   include/linux/mm.h       | 30 +++++++++++++++++++++
>>>   include/linux/mm_types.h |  9 +++++++
>>>   kernel/fork.c            |  2 ++
>>>   kernel/sched/fair.c      | 57 ++++++++++++++++++++++++++++++++++++++++
>>>   mm/memory.c              |  3 +++
>>
>> It's unclear (to me) which tree would normally carry these.
>>
>> But there are significant textual conflicts with the "Per-VMA locks"
>> patchset, and there might be functional issues as well.  So mm.git
>> would be the better choice.
>>
>> Please can you redo and retest against tomorrow's mm-unstable branch
>> (git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm)?  Hopefully the
>> sched developers can take a look and provide feedback.
>>
> 
> Thank you Andrew. Sure will do that.
> 

Thanks again, Sent rebased patches,

Just to record, so that new discussion can happen in new posting

https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t


