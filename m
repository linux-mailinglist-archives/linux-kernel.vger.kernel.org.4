Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B045E7C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiIWNpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiIWNpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:45:35 -0400
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2065.outbound.protection.outlook.com [40.107.116.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5DEC840A;
        Fri, 23 Sep 2022 06:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPeVdoTCsPzcj79hLpAB1j8+GLMioZ7ezxU7TA/487OrSH+SG7X1JABPFtrpNOYBw4tyhrpYJ/UTd85Ydb5oO3S6e2wz7iOphVh9eB5E+AHg1WkYoG9Ii5SBJo72lYPBhAsOOvLKA8MDqf1dKMHJvFvKqd4rTErEFPKhFFINjdv+eDicU3xZe8vS+ikmnX5MtZkeDcbufHtOUOqyBi2bpTVbmi+rTo/5FaeBrweoJKB1zE1OdpPOc6jaGt71QRrtXHun0JtLN6/vzR00H7oh6fGmaxMP+FKsZTDbQj3yhvfLFfAwSX+5OBILdjpEnNxyNCaAtLVdzL9GIfjT80JFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEp3Gq5JNAOUQNFlPswYaOFx+3cp+5qf1f3fg90u0Lk=;
 b=UWurf6ORDFXhx09GB2VUz52uJEJQe0FPFXeXBaMy3q1u6BTHECEYI0JQ1ovMfbLROVVY37Lip9/JzrZXIL2I1s8ceeQp2v21WMg4SXfohBbyU19kxqDF55vJpXCgoGjRJUDcnuA2Gf9cs3Y7rf1ee+bViHaXbwa26KV+52eBz1jgo6UpkgqmQhwGcwKERx4NLkPaUUhDFUwwFM3fGxQGeV0gyHPyVdq3LErC8PStgDMyAmmOOXo8j4OXxF/xh3qKieYFBxUCDC+kwW1luumJHgdHiMyb/kpTkn/7EF7f1OchFIhh7P4/NrvxSVnh/2SgnOFG3WK6pGl75hg7FxIwhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEp3Gq5JNAOUQNFlPswYaOFx+3cp+5qf1f3fg90u0Lk=;
 b=Cpct4YeBe623id90eKL9RPb9TTZIvSZWU/G1l/LciDLB1nYdJMj/NmVnv8GDTgmLvo8JtafPuaW4xVFcT2RwQOq8NT8hEX4cQbWzmGvtY22VIXZ0PUrLOqJp4b1iWvn32jUYiF7sWj7kh21uSBOK6D2v74dur5UqBYX7to/u2PNMHZeyFXTC2VZv2kFfno7kegH6NhjywS4mS+jFKwGxx5Isf8NK5GArZnQGxYeS45u1zk1l1cv6r1d7b7XFtRGJTme2nedcwfUBj/FJ4C2WijEJfm4Ao0FAhPnTfCrVksGhDLdlZkTUdRl1Sw2JGKvAUXXz9CP8/f0WMsra2N9JaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5687.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Fri, 23 Sep
 2022 13:45:30 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9%6]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 13:45:28 +0000
Message-ID: <77543974-cd67-3999-103e-6714d04f0e5e@efficios.com>
Date:   Fri, 23 Sep 2022 09:46:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 00/25] RSEQ node id and virtual cpu id extensions
Content-Language: en-US
To:     Chris Kennelly <ckennelly@google.com>
References: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
 <e753568d-599c-d81a-8456-085bbbb0264d@efficios.com>
 <CAEE+ybnLUHjU5-dWcWgcWiq-AM4ocquSbZ=PWiuexEsPB8P5Gw@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>, Peter Oskolkov <posk@posk.io>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "carlos@redhat.com" <carlos@redhat.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
In-Reply-To: <CAEE+ybnLUHjU5-dWcWgcWiq-AM4ocquSbZ=PWiuexEsPB8P5Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: f7964e4f-d1b3-4123-6300-08da9d69e056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GCmJKKQascMsp8DgZLC8Kt34Ghw3FbetjzpqeJ/Y96F+5i/UWpRnAiRTWqNx4qPLEUjzbgLgfjeEW6P5xNErXsZc7916lA9xlKpotc7ydEqygp7LuBw2HUmHlxELgbSRvdY15itTaq5rkDMMaqT2LVJ1Am5a6MitB7LOqAOl7MMIjx2yLPUxzkCcRmCggtkIMMjpe55uEJwMw8hLCL0JQfXodRnL7gl36T+8OOyywRgmJfVFtBWVO7/VwCWysJSmvvZDy+Qi0wHe9BSEEIbtzZ8NTrtYKwkdRA+qq2u5jrV1F4V2JncYsDLsW7mI1p4jdeq365/HYHro7ccK9gQ5cbE/kxERQBRANSBbxwoUD1xufM2nt8v0tKzPqAo988xisMKSuQxsSO3TQEyADyoJWTRI296onbv+EpUSpyYtRG3b8jpa90gwrqGtR9X2DhXuwRzbmvNnzOv9vMxfgZPg2HmyqeKCdYurLit8KJe+W1S2auRTba1+PY/HQqV+ILvLlppLISzohXPJiITeK23+c6nZxu8gu7JwpyHnx4EOLgaESDjEghnGLwnPRqZVbUnecbWnHOH4G9O9BwLyxJfFjU7BQs0XdI7BxOoPr8xr2Y9ktmoyZ5Hj4Fh4QsJRxyLJE8aMjH0O2trDOV022IPZ78O2HyDgmr8XaQQlVafjJ6PEJN3sPKx4BBXyiL9z8TJhCeMa+tAiyjJRYcvOx6hFTPYCuKpGvg4+yxRKDCm9CLZ5iPXV1pRU8klpNtRMbHNHKDqNV6C4sfITo16SGSjy+RO8+6ICNLUQfobyEZombeX5XS4jpF1U/ZZU8sfW7uwZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(34096005)(366004)(396003)(346002)(376002)(136003)(34036004)(451199015)(6666004)(966005)(41300700001)(498600001)(586005)(38610400001)(6486002)(4326008)(66946007)(36756003)(8676002)(54906003)(6916009)(38100700002)(66556008)(6506007)(53546011)(66476007)(2616005)(31696002)(86362001)(26005)(186003)(6512007)(41320700001)(83380400001)(31686004)(44832011)(5660300002)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T21BV201Z1I2eHc5RE5aQXphaEluZkl6WDBkejVHTGhiMThJYzRUeUFoNjNY?=
 =?utf-8?B?VzVyU2xjL1NINzBVa05EenoweWNMWHVsSzRjQlgrb2lRNWovR0JqZCtnWjY1?=
 =?utf-8?B?WUNtM212Rnk0UER6Q2kwZytScG81aHFkaTZHNXpVcGMrcHZYNzNsQnA0ak51?=
 =?utf-8?B?UnVvbzZxRVVTVy9PamZELzNPV0crUmN0K2VUaFdTdm5lK0ZJZC9mMkk3Mkd0?=
 =?utf-8?B?TENSUVFCdXFyR3JmV0tWWnQ1ZmgxRjNtR1hoS25ObnV6bkYzRWVFTTlqZlZq?=
 =?utf-8?B?cGt2bUdSZzM3VHoxNTB4dWFkT0d5b3hLRE5nQU9BOWd3YnR4QWJMRk5VR2VV?=
 =?utf-8?B?dVdyRTJ3N2w4WkxXa2Y0VkhUeW8vZk9MWmJ3YUJFeWRwZXpUQzJjdmZBaFFl?=
 =?utf-8?B?OFgvZFlOUHk3YUNaR0tLcXRnQkJhRXgrVnpSSDY0ZmpxNmRDN2IrOVBBWEhp?=
 =?utf-8?B?OG5GMDVCWW91MXRSZnFaaGNvYWRJbDhvV0QrTlYrbnIvWi9hd3owQWVPRVM2?=
 =?utf-8?B?WFUvZXZhVzNkKzByNU1ROFBvQ3MwTGV6VWFBaUV3M2JxaVRSSTVXWWxuMEF1?=
 =?utf-8?B?dEp5UXZUTkRjY0JnY1l1S2QranNmVmhOQ0pmWk05ZUZMQ1hlRTVERVJidGl3?=
 =?utf-8?B?VHczNWQzMHIxVWEyRFY0OFRYMTl3ZHRwTHVRRUFWTzBGVG9UL3gxKysrU1pI?=
 =?utf-8?B?ZmxQdU9DK0RvYVNhTS9BRU1TbW9RVGxGOWtpR3dJejZzYWZKOFdXT3gzdDZV?=
 =?utf-8?B?S3pMS29sUmNMcjVFWFF6V3BoOE5EWkJreXFlQWJYNmlpWFJHdm5xYTR4b1Nn?=
 =?utf-8?B?ZWxTdThLeUpNTFAxdzdTdklsREkxRDFiOUd4TEg2T3BRbkFwM0tJNHdMdURV?=
 =?utf-8?B?ZC9GRDNaT1F2ZEJETmQ0UVlqQXNBTkdGVTZRZ0F1S0Q2MW94MENWeUJXL3Mr?=
 =?utf-8?B?QU1lMzdkOVQ1aGNTRFVXU0tHbmdLZkRyN2g2djRFV2h1d09lQ212OGV2M0Ev?=
 =?utf-8?B?RmMyNXhjK1dadVAzOFRBRk1UVk1MdXlSc01ZUThEVWxUTGsyWCtYNzVSWS9I?=
 =?utf-8?B?SjFzNXJHeGtLcTBDeGlDSHhnMnh0bzdaajdNeXQzS3hCc3NhdklnVm5DWm9Z?=
 =?utf-8?B?bXliZEJ1OTdNT1hFYWVuS0lEWHUrdnpiRkdJdEwwYTJDRjhxYXhuM0N6cnVt?=
 =?utf-8?B?c0JqMHZDbktMcUs3TTJzcDVFVEpJSi9IekxmaEUzazkrR1NxWWNIWkxrVXlX?=
 =?utf-8?B?bFdrYVl4cmRLTG1QVHVVUlcvZURWUjVOUlFLUklReHU3UFdLWUNuWVpwemx6?=
 =?utf-8?B?Z3RxY3J4UC9MMVdJaVgrL2lvT3dIZmFibW84SldWMHJwTU9ZTkZpeCszeWNx?=
 =?utf-8?B?QTJROWEvM2tOd2NMTittVFBaME1aYnNiY3dmdERueE43VG9Mc2V1a0FFUGtl?=
 =?utf-8?B?NHFlNlM2bzlmTWtPbkNBeFBGWWJwNUF6L1IwNzlGZWorM0FDdWpWVmhhQlZ5?=
 =?utf-8?B?Z24rNE9MSlA4MldtM1UzSXR3ZWVwM3B0dXcvVy9tZVNTaHk5OTRJWlYrMFpm?=
 =?utf-8?B?VUdla1hTaXBOUjQ0d05oQXgwUVQzVVA3dHEvTmhPZ0dSd2pQRlVPeWpmdERX?=
 =?utf-8?B?QmphclY5YjNrZUdYSDhNU1JjU096THNkQXpFQkpZdDBKazd0d3pROVJaZHhH?=
 =?utf-8?B?VmJiTGxmdDJFeU8wTnRLS2pvMGViRTVrR3hzb3ZaVEJJS0NSRHRFbHNmd1lz?=
 =?utf-8?B?azJ3dG16Y254UWk0QzUzbXFOalRjY1I0U3laYnR0MUNXTmUzZjFFdGtFdmRS?=
 =?utf-8?B?bkVUUWdXL2IyaGFBdVEvckhYUG0rbEtQZGJTc3YyMzIwVHVrTVZ0ZTFwZHhU?=
 =?utf-8?B?dDg3ZmpTZ094NjNQWTB4Ym45bSsvcSs2bFNjYmpBZWYwakVPVVFXaVBaZlN1?=
 =?utf-8?B?eXlEQVA3TXk3SldPVGJuUW5FejkweGRTMVNFTnVaSTBkcnBJdkViNXdiR1Rx?=
 =?utf-8?B?eTA4dWNzb0ZkNVpocXNoM1lxb3FrZkVQM1NNS3RKWTVZcDZWOXNNa2NTQjVj?=
 =?utf-8?B?UTVwWkVMTkpjdnI1YitzZktxQmpZYkNFbVNZbExYUyt1VEx5aDUrTzc5ZE9Z?=
 =?utf-8?B?QUpSdWczQnFRRk55azdCcFdoeXZBQVdUdXMzc0xuc3gwTnRPNGxvNk5yVlVO?=
 =?utf-8?Q?8nVD6XpM0asSJ7vTvjzUzUE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7964e4f-d1b3-4123-6300-08da9d69e056
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 13:45:28.8168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCGZPO4URcidHjTdaaREQJAhrmT+H0vha0KiTQGQAb3ajTTBMWYOL3eMViSQIP4fN43KDRazk37M9dWH93Uq1beggruS+I8ySu3uyUhN3OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5687
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-22 16:10, Chris Kennelly wrote:
> Hi,
> 
> I still need to update the code in TCMalloc to cooperate with the new 
> glibc ABI/convention.  One concern I have is that it looks like I might 
> need to add a extra memory dereference (or two) to get the early 
> initialized offsets provided by glibc folded into the read of the cpu_id 
> field.

If you have a concrete example of this, I'd be happy to help and perhaps 
we can improve your usage pattern.

> 
> I think I can avoid this by using %gs to point to the address of the 
> cpu_id field itself (which I think could be used to select between vCPUs 
> or not*), but %gs is a global piece of state that all of the libraries 
> in the program need to cooperate on.

I think what we are all looking for here is a scheme that would allow us 
the fastest per-vcpu data structure accesses possible from userspace.

I think we could do something similar to what is done in the Linux 
kernel for that, but in userspace. Here are some random ideas I have on 
this topic:

We could introduce a new prctl(2) PT_{SET,GET}_GS_MODE on x86-64. This 
would take as arguments the indexing mode and offset multiplier we want 
to be applied to the GS segment selector on return to userspace:

enum gs_index_mode {
	GS_INDEX_MODE_MM_VCPU,
};

struct prctl_set_gs_mode {
	enum gs_index_mode index_mode;
	u64 stride;
};

For a memory space which has this gs mode set, the return to userspace 
code would populate the GS segment selector register with:

   stride * current->mm_vcpu_id

The "stride" would be the virtual address space size allowed for 
per-vcpu-data. This could be decided by the libc, with a tunable 
allowing to increase/decrease this size. Another libc tunable could 
disable populating the GS segment selector altogether (e.g. for 
compatibility with applications like Wine which AFAIK use it).

With this in place, I hope we could then do per-vcpu data access by 
simply prefixing memory access instructions with a %%gs: segment 
selector prefix.

Thoughts ?

Thanks,

Mathieu


> 
> Thanks,
> Chris
> 
> * TCMalloc is already paying a load+pointer arithmetic to select between 
> cpu_id versus vcpu_id, so this would actually make things a little bit 
> faster.
> 
> On Thu, Sep 22, 2022 at 3:21 PM Mathieu Desnoyers 
> <mathieu.desnoyers@efficios.com <mailto:mathieu.desnoyers@efficios.com>> 
> wrote:
> 
>     Hi Chris,
> 
>     Sorry it looks like I forgot to CC you on this series. If you can give
>     it a spin with tcmalloc I would be very much interested in the result.
> 
>     Thanks,
> 
>     Mathieu
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
