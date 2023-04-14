Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51F56E1B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDNFLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDNFLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:11:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DA34EF2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL88TowqblXFgwc4esZ2egIZr5737xXecf3Q5HZz4QN6DnuFPbBZio+kuXfEYTV0pZd1c4kTzG3KENR9xapz4KkTiDAaLJIXKgsxbSQoC6UoxTrQFuDKrPS1Ie1lBNbvqMw2YGUUqNwxafESkX13CjGxv0MBb0axl0GJFqW/2Y6aKQnD6pXlZvKCam/nno41a99zxhjSfCg5mhI31QwjfNnilS4+jcq22ssSEmM6Kv3MtoO2YiYjPbUyCheTe57M1z7+NSJ6/HoShStC5PHF7gaoA4AYmmznxOlRCRZ/R1+svSuWI8x5EZL5t6gt+cIBHrhmBWCo6iUP/XHghozUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trmy4QeClJEfAtYNFTj9iNRGJGr0QkoFuiswcjO+LV0=;
 b=eUrgkWfLxvWyzDQXb1S2ItM3M7khmdgoQ9krvu1Hw54pDewMkCyDc4zEqYLy59t880Yiasc6J1HGa7I3tvh8m1TSd76QnunziVnOzWK0KvSQPeHNpOI73gQ2srebxxlD+ElR9dSm4/ed0hZB1vzdo0e3ZAmhWujOIGwaSOZgzTANveni9e1XWGyqRF/uEqRGUqfQ4xQu2LTz3SeEqCVDY3PX69prXanMQUbURkVSYd4NWm+WVeApMMrqwWrUZPcAXHugtcPvl8eNatsJxCq+xkhwsccDvbCQ74lEbdrTlupUnClWPCxYsx5CrDWvL0X6h4BLPNFwU5IM3iBWftFXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trmy4QeClJEfAtYNFTj9iNRGJGr0QkoFuiswcjO+LV0=;
 b=iP1F1SAlLTDAT5m5Sae7FMxkgfC7MGMBzHK8QrzwAs5I2zc42B7ty5CWW7zlpbUqwRYJfXy0+6gaKutbr3q247YJx8mCI7SFnJfVYvmP0j1yJ9/voiQtJs7R2/AyJAFe3EOwRnf0UsUlSW0wNACfdGKfSfRtYEO0MAh1TSVve5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 SA1PR12MB8844.namprd12.prod.outlook.com (2603:10b6:806:378::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Fri, 14 Apr 2023 05:11:07 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04%7]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 05:11:07 +0000
Message-ID: <e99be091-8671-0ffd-ee87-1952d8302e43@amd.com>
Date:   Fri, 14 Apr 2023 10:40:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: nikunj@amd.com
Subject: Re: [PATCH v2 08/11] x86/sev: Add Secure TSC support for SNP guests
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        thomas.lendacky@amd.com, dionnaglaze@google.com, seanjc@google.com,
        pbonzini@redhat.com, michael.roth@amd.com, ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-9-nikunj@amd.com>
 <CAMkAt6rqsg6=Sx6Fqnf7KNOUB9YPMU6TUriZYZXbXQTvcoKzNw@mail.gmail.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <CAMkAt6rqsg6=Sx6Fqnf7KNOUB9YPMU6TUriZYZXbXQTvcoKzNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0200.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::11) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|SA1PR12MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: 381e38e7-8cbb-4f7d-b62a-08db3ca6a716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAT2StpA6T4x4+2SaR4uyCJFrok32dO8LYnn+TvedBdPiW6Qtfm1Bn5KbgL0EplJttYCq7KIuM54liH5IOkE307KH+9U5nSguGHcIh5hBXxNnowdaPSh8GhoE7BVo0eDOlB9mi912FEwK6nTgIrq3hhVQ0SSDFOMPseSG8vnZf7F/nmtcfnK/9t/dWiMNc2IEjZKMqhaUDvPQDVEB6+D17ovRwcMTfm1j5WYZ9QZ4nuCWVcm4fjT/etxPwCpOLX6P02OvcQ7QE2V2nrQAgB3DrOB75vBk0vvIfSuPOTTYacG6ZCL4KlpLUKDgiviCWxygvMHpFzio729nncsICWfsHegc5UWqOknnHaP/uo1NyVFX/OXgECJSvUHPh9ZUdlrIa5YHzWBVfLYmJPMI9NTsotlbwe1LqBb1GgzbXALwkm+MhoO9PwpISV/E+CVNjqHMlRafzsYk39W1fKNHAch3qNA1/Qyj1tea9fn2He95tV2gWiPwwSvgDQeNZXPYCZ31+nOWFppjcPudoYzCYfmrQsnAZvtHuzI8DpVfL3tHB1B3YocpQfsurB3xC478NrsFpQGEq6Lk8vH9jUswTyl33nDM0xV9YZbB/K3Q7lPKO3t4zz8enc+WyMusYsa8p448OYT6YGE6k92cT5z20Tn/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(53546011)(26005)(31686004)(6512007)(6506007)(186003)(2616005)(966005)(6486002)(6666004)(5660300002)(41300700001)(316002)(8676002)(8936002)(38100700002)(478600001)(31696002)(4326008)(66946007)(36756003)(66476007)(66556008)(6916009)(2906002)(3450700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nys3d2lxd2FGdTR5bk1sNnFvUzd6RE9WT3dzQ1Yrdy9EeXR0Q08wdFdsR1FF?=
 =?utf-8?B?YXhXSjhyd3EwUWRYaC9NbURDcDlNNHBiUlJlOGhRdVNSZkRRSUZrY3JlbFhh?=
 =?utf-8?B?NXdHbjFHelk2Q1pXOVhQMnF0TXMyS3UrcFRqNmN2a1ExcVhGWi9NNnFMMDVE?=
 =?utf-8?B?d3BIVzN5WDlSWVNtYzdZNWxua2lCQnBkaTF2TW50aWFLMEtZanU2Z2tWQzVv?=
 =?utf-8?B?ZUllakRyODZ6c09RYUVoVms0YUZnN3pUOXNWc09vMTlTUDFlRkNxQ3F5eWo4?=
 =?utf-8?B?Y0pWTVcrSUdVUGpJdXc5WngxdklYMmVPbnFNUzBPUjVIamtWaUhyc2doK2o5?=
 =?utf-8?B?U2dUajBhbDdIczRGL29qUUxrZ3MwYXlKS3o4Y29ra2pyV1NuMDNMNmZaeTEv?=
 =?utf-8?B?VU1GTDI5RjNpQUp0RFB3aks3UnB0cGJsa2ZGYllzS1Z3ZHFjWWJjZ3NSQ0Mr?=
 =?utf-8?B?Wkg5bEU0Q3RpUDEwUTdxeDZUWjZrd1dRa3YxNVo4OXNXcHVwTW1Ua01mMlFW?=
 =?utf-8?B?dmhMREFQNTBJa0Uva1NqdXZwNXhHRmhvdG0xVFJGMnJhQWZYQ0VRT2lNTkpv?=
 =?utf-8?B?SlBjalB2bzBSd25JU3BqTTJGaUxDYXZVeXFNc1NnSkRQT3RKdW94ZDJuODhj?=
 =?utf-8?B?b0txdkVHK1JrbVV6QW1JMkVORmZsREs4TWlIQ3JWYUY4TzFCbWpmb2VmU2pO?=
 =?utf-8?B?ME1QTnBIdnJ5VnpQQUxnZGlmUk0wUUticWZXaHBoeUxqbkJ1ZGJlYjZMQlpE?=
 =?utf-8?B?aHlreHF0dDdibHJkU29zeHpjbmlLbkg4dGxIY2tqdVU4WVY0RjY1amRxSVlh?=
 =?utf-8?B?SU03dFN1TXlGelJ0TXk0VDI0RHI5OWxnZzliSWNuRXNNVkVZcy9ycUZtelY5?=
 =?utf-8?B?WXZnT252d0ZLRTltTjZsT1VMVWkzT0xwTDdHT3Z4MzYyYXJTMnNHdCtxaklQ?=
 =?utf-8?B?Uk5uNS85aktQNDFmUUhoNngwTjJtNlFsais2dkczUXJHN0tUdTM2NXM2OWNH?=
 =?utf-8?B?K3FqRWhMcVhFZU1lUGFlSytUZFhyRkRQQ0lXMUlJQnhQNWNLRXVKYWptU3c5?=
 =?utf-8?B?Z1BoUzBXbksrVWhnU2ZzNkRybmhSejlLTjc4YVRFWEswZmNicG43Snk3MC94?=
 =?utf-8?B?WEFVVHk1QjgvSnVnUEl6VC9oamZsc3dVa256VTB3VkdaTGJqVTdvekVrc0t2?=
 =?utf-8?B?RkRvRWFzeGdnY3VoL3doMmxBTlBDN2JpUkx2WklKekJrbGhFSzN4Y2dmd1lX?=
 =?utf-8?B?Q0RJbFhLMzZOS2dBamNhUy9sMGl6azRYMmZsajFGV1dMOHdDM2wzdnd2STR0?=
 =?utf-8?B?cW4vaCtqa2Rqa1V0dHJyUy94YUdSSGk1N2F3bFdPZ2x1cHQyRzJldnlWS3V5?=
 =?utf-8?B?UUFLd2VXbUdITnVNdGVVdUxzV3YvRVZlelJMcFc1bjc5bU5rVVQ5SXJTR3Ix?=
 =?utf-8?B?UXZ0UjVRZDlidGRBcDNlM1NaQ3BiSHBvSlg2SWF2UEZNMTYxY3BvWWl6a2ZQ?=
 =?utf-8?B?aUxwK3VYK3Nrd0lkSHlLUzZHWWs5UzdiVXI5UnUxc1BHb0Fxa3d4cGlUeHRr?=
 =?utf-8?B?a3Z5MVJGOURmOXM5R3UwQUxoRkM5NThBeUVjSlg2U25VMG9aUVhvQ21nSXAr?=
 =?utf-8?B?VEVla2hJT2lJZ0FyWjVPMENwaGtoWnpRTnNaSnBpVFFDbFJMdFVvMFFOUHBL?=
 =?utf-8?B?SWJnYjZSRjlnQXhIbDlKMXdMOVJUdHlrT2dpRkdtc0w1REgrQkdYWGM5Rmsx?=
 =?utf-8?B?ak9lOVFKZTRkcDl4SkVQRmRNUTE2TzE4d2tjSXdDc2tIcmw4ZGladFhyakdv?=
 =?utf-8?B?UEFxTlMrSEFrSlNvVmdSbUtWalQxZGdhNWZURE5uLzNLbk1RWURVc2E0N0U0?=
 =?utf-8?B?ak1HbEVkSEJvcDg0dmhLMVIzbTV3VDNjcVBLcXJxUzRUTmNxZFpBdG12OFBv?=
 =?utf-8?B?QStkRUlKRjVkVFI3cXJyTGhQZzdKUFBlenhGbHk3RUFUM3dqZkxybVhuMTBG?=
 =?utf-8?B?amJ3bDFiU1pJM2JCSGh4d0V6RDFMZVZHaGt4eHl4OFpkN0Z4UTB1ZFY3d0pM?=
 =?utf-8?B?ekdkSTVyclhaM2Q2TGxpSEhDb3UzdUFWcjU0RERsOGp4ZStQTjJrTnQ3bFMr?=
 =?utf-8?Q?zYoxBnGutyEzZheRolXkCfMSG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381e38e7-8cbb-4f7d-b62a-08db3ca6a716
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 05:11:07.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9LlrIqrsLy3omZWZUQEd9ELXkyNPlwnRT776AUpsWDOKOMlWcE8bTJXEMTRiPslL6ErvefRwTLR4/SYJaWhFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8844
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/2023 10:44 PM, Peter Gonda wrote:
>> +
>>  /* #VC handler runtime per-CPU data */
>>  struct sev_es_runtime_data {
>>         struct ghcb ghcb_page;
>> @@ -1107,7 +1111,7 @@ static void *alloc_shared_pages(size_t sz)
>>         return page_address(page);
>>  }
>>
>> -static int snp_setup_psp_messaging(struct sev_guest_platform_data *pdata)
>> +static int __init snp_setup_psp_messaging(struct sev_guest_platform_data *pdata)
>>  {
>>         u64 gpa;
>>         int ret;
>> @@ -1406,6 +1410,80 @@ bool snp_assign_vmpck(struct snp_guest_dev *dev, int vmpck_id)
>>  }
>>  EXPORT_SYMBOL_GPL(snp_assign_vmpck);
>>
>> +static int __init snp_get_tsc_info(void)
>> +{
>> +       u8 buf[SNP_TSC_INFO_REQ_SZ + AUTHTAG_LEN];
>> +       struct snp_tsc_info_resp tsc_resp = {0};
>> +       struct snp_tsc_info_req tsc_req;
>> +       struct snp_guest_req req;
>> +       struct snp_guest_dev dev;
>> +       int rc, resp_len;
>> +
>> +       /*
>> +        * The intermediate response buffer is used while decrypting the
>> +        * response payload. Make sure that it has enough space to cover the
>> +        * authtag.
>> +        */
>> +       resp_len = sizeof(tsc_resp) + AUTHTAG_LEN;
>> +       if (sizeof(buf) < resp_len)
>> +               return -EINVAL;
>> +
>> +       /* Zero the tsc_info_req */
>> +       memzero_explicit(&tsc_req, sizeof(tsc_req));
>> +       memzero_explicit(&req, sizeof(req));
> 
> Whats the guidance on when we should use memzero_explicit() vs just
> something like: `snp_tsc_info_resp tsc_resp = {0};`?

Going over the history of memzero_explicit, it seems it was introduce to 
explicitly zero sensitive information before the variable goes out of scope. 
GCC was optimizing out the memset in these cases:

d4c5efdb9777 ("random: add and use memzero_explicit() for clearing data")

https://bugzilla.kernel.org/show_bug.cgi?id=82041

With the above detail, IMHO, we do not need the memzero_explicit() for both case.

> 
>> +
>> +       dev.pdata = platform_data;
>> +       if (!snp_assign_vmpck(&dev, 0))
>> +               return -EINVAL;
>> +
>> +       req.msg_version = MSG_HDR_VER;
>> +       req.msg_type = SNP_MSG_TSC_INFO_REQ;
>> +       req.req_buf = &tsc_req;
>> +       req.req_sz = sizeof(tsc_req);
>> +       req.resp_buf = buf;
>> +       req.resp_sz = resp_len;
>> +       req.fw_err = NULL;
> 
> Why do we not want the FW error code?

I will add the FW error code.

Regards
Nikunj

