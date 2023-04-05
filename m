Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF086D73C5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbjDEFbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDEFbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:31:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9193C0A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 22:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4YXUiNf3Y0O/TW0kPLfMYoLnwoVOYv/xlDYCsZJ8YHGPv23tVmD1IhjVeXGfU95pO7gNfCA9F6x/uXM9Jc8cXM+l0he+9IpTdlPKU6wZ9FKzQEA+HcSUZU3gvGSnBdcE6SdgbEg96smoG0wMRl0qz3ZmIAYOw/HgJws9YABRbDRqn3FTPWdUG1BfccXxW3Kt+Je1Hfb3NVhbdReb52hm4xg39aS+fiW+aSCSeekMmZDI9KRmKPH/2OgrdHv4YNUuWmlaETYh8p6FleCqIACwlvbv2ccqMTNcLoOoEd/f9M1MfY0o0dDLRZu/L+nwIamlXp3r112MzFHSb59snIQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyOup8jBLejKQBzRLeZ2fQqNG1v21Ox1LUSUbRg9OMM=;
 b=kTHnOMMpE+YGdOr0feViIF0PQiJ2CcpZZ11IyxqLY9Z0MNSk0zFn5lTxHckfP5VZhmMNtGvt1mgFkmwSw4/2FSMR9MlLYO/fOi+AB+5dfHarB6wOXqPR4+XdlpeDcNInHVRNYa1C8TnCJ69HUHGRmaNhqnofhmQbVn5IJKGLNOc0NflheZssCO83IGjj9KxemlYQz2rw/VuYpJbPlYyaNS8DPsE0JQDZ24KZVjMeMzukzInarRiPf1H0m9G60bhAFwz8CTbv1gI/jTxBzZnlt9Y2um56hf+s5MVbwd9tR4iczA7kmqXR98aHQoQp3ZYUhLfRBSfZKjv5NuUV0jyJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyOup8jBLejKQBzRLeZ2fQqNG1v21Ox1LUSUbRg9OMM=;
 b=fKOcPjsFlE6qvVyURNZA55PwUaHApwB9y6lI6vKLmewFdY/G0mB0RL6YeOiy+dskbuB1h0GeaVgOugpia2I3++pZtFdtm1MZcmPNT+wYDC4mMjh0617MZTaNjhoG7dKCbZ8dxcYp99qnh1mVgMAnTo7Dqi1YmKjT+eNx1kA6Umk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.41; Wed, 5 Apr 2023 05:31:45 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::de58:ace6:16ba:96eb]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::de58:ace6:16ba:96eb%3]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 05:31:44 +0000
Message-ID: <639be6a6-929b-e27c-60a8-487b908812ce@amd.com>
Date:   Wed, 5 Apr 2023 11:01:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: nikunj@amd.com
Subject: Re: [PATCH v2 03/11] virt: sev-guest: Add snp_guest_req structure
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-4-nikunj@amd.com>
 <403cacf7-2694-d60d-1079-b8a3efcaebed@amd.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <403cacf7-2694-d60d-1079-b8a3efcaebed@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::7) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 243fce32-246b-4455-0f63-08db35970b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5ea54QXC5jrr8hnby5H8okeF0jpkaX6GC7EBvwNcxF6jygK9ETe6zXPahZ9KNmv669QyLm9R+3ufQAleJAZn6ejyXX7vBbmGLy+UkTqv0+emyeC2rjQExdNtb3ce3BRluTsGplnt7S4cl3/n46S/4hknCel+qxeRxWbzjHHJaJDHLW14pwHVfnZSlhMsfVJKt5LGVaB9Fid9UsFke31ZGydvbGG/1ZI8ZaiHR1TLpxGpDq3YEu2vypGs/Erj6jIz/y+JsQw6qkGMdjn7XtlKMRIZmLlVMn4Q8l15xpSrI4xIEsF7TDGNZ74diQ8a2kzxYIoEa6SXIZ0v4cC9RXKsU95LCXwDf7J/X5FFuMNjoHENykN86oVVd2oVnlVf6G/NGLR4e7pgXfzQ07K0IZJrO5spXzqu658d5gp9PSMHAeAnUavwQ7jzePgORPB2HviMBwJyoHUnns81Ldz+3DtyN6xV5C5UL7mYy/5ombw73yi27o/TbVjC9XP7ZGyZ78F3zj+xGFcGlc9Xk0bChWBP0qLKSfN61FqGjxXv5sENgF3ivR32aAOn1/uLIYXCnrozHWPWHZEQ3oLhxP5XWWbHkAnU7ayxCI+Xy1I9FG354tCCVNgOTbfSr2gdyRQpgtFr7e11f1fsvA3041WMN5LAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199021)(6666004)(38100700002)(41300700001)(66946007)(4326008)(66556008)(36756003)(8676002)(6486002)(66476007)(31696002)(8936002)(5660300002)(478600001)(3450700001)(83380400001)(186003)(2906002)(53546011)(316002)(6506007)(6512007)(26005)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1ArWjNXU0tYMWJJdjdvRjdQME9FcHhidktBaHdsRTJjbGgxMnhPUDhrd25G?=
 =?utf-8?B?c3lqVEhQMEF0QlhjWFZZUGprZkx6b1hFdmgxUU4rc0xzQzZtT3JxN1c4Mk8v?=
 =?utf-8?B?S3F0dDZZdTloSlpZVjV3R2pQalphQVVyaC9qRDBldTEyOGx2Zzc2VHdWTjli?=
 =?utf-8?B?TjVSUGNnTkNwN0VIWFRHSDROVjlzN0Y4YlhSR01ZYjd3U1A4TUhVK0lia0wy?=
 =?utf-8?B?U0M3aStSaVFybTBhK3BxYk1seDcvNTNTS0FiaFpoTDl3UmpveVJXWWpmSmx6?=
 =?utf-8?B?K1h4KzUyMTcvKzY0RzRhSEVxYkY0cWtaTVNlcGhzMVZkejFWQm5qR2JLN1Zl?=
 =?utf-8?B?RVdETzdiT3o5L0xPaDNod3ZaSFJ6bDFFdHpGSFQ5UGRQNmVJUnJrenlWdWRm?=
 =?utf-8?B?ZTVQYllzT2tBYUxLZGNqOGxKT2dxNnZQanlJT0VIMUZPVkp1Q1VLS0N5OUNK?=
 =?utf-8?B?S3cycTMvYVJkZ1ArK0FYdWx2ODFGVzI4TTM4bENGWkxJWDhOVlovU0JUbWw3?=
 =?utf-8?B?elk0eVZFZnN4VW1iaWlaRUYyUWFpRlVtbjRRdHZyUHQxKzE2Mjl2cXZQbDgw?=
 =?utf-8?B?YWRwb3c1WTZCbGlpckw1cFRtNURVQmRQaVF2YlJaWjY0YzduNUE0bTJzQjhT?=
 =?utf-8?B?Y0RaMm9uV1lZVFRhdE1IbFU0L0o1SVJyQjBzQUluV3QvWFV4emJPVEdzRWRW?=
 =?utf-8?B?RmpNK2RieVlPZS9vR1NYbFNXTGhtOWkxYzY2YTBLSlhPZHAzeE1kMjk0VGVI?=
 =?utf-8?B?NkhHTFlrTDNVWGVUWWVUYXVqTk5OMnhJY2UrNDJDNjFyemFyKzJNU20yWGND?=
 =?utf-8?B?NGNWN3FpSzAwd1FGNlFPRVlQRHVsMmFveWQvbmFLRHNOVGp0ZVEyYjlDbVFP?=
 =?utf-8?B?bTBHUlNQSi9BOGJhdk5MUWtnejNPcHQxK1N3eXBucXU5WWNWRmtvdG4wTVdD?=
 =?utf-8?B?TkpIdnZCaDNvUm5Nb1ZaUHZKZGtRQkQ1S3U4QWt4MzFTaC9IZU55VWV2NWVO?=
 =?utf-8?B?VHI5L29QdWtxT3hHcXh3eXUzSXFRU3hBUXRVejhCc2t3b3NEKzE0aVlsTXcv?=
 =?utf-8?B?ZTNtZmo4QWlJdWdNK3RSazE0WUEwOG9CdCtFSm5XL2dGV2dESm5ZSWc1ZE5Z?=
 =?utf-8?B?VFZZblNRZG9HUmdQelpZWnppNXQ5ZU1QOFMrRDNaY08vdTFDN296Y3dWWEtM?=
 =?utf-8?B?TFQxcG9BTVlCK0NENFZMY3NncWk5U1ZCazBQcExubG92UEExOVdYczJST05h?=
 =?utf-8?B?Y1Uybkt2MjNDajk0MEVuTnRPb1l5UUdreldla0MzcnVPL2ZubkJXeDNuSWVG?=
 =?utf-8?B?UFRUbklGdFFrSmdwMmdlWVA2a1AwSVd1Zm9URXJqZDFHSEJDMXR4YzNGb21q?=
 =?utf-8?B?VEJxOTVNdlY1ODR4NXB5T3luaStyL0ozZlJuaWJJSUFUTUJPWkdpYVc3SzlJ?=
 =?utf-8?B?OHRkS2J2c1hUYnhQVzR5RHpEaFFlejVFVG4wNGxORUlHNCtJa1B6d3FFalMr?=
 =?utf-8?B?WG45ZU1ERlNoKzFSYzI5SG5zbXRmNUt0cllReWluMnNKZXY0SURhMWNjZFVK?=
 =?utf-8?B?blk4RHc0U0M5RzI4VWVVb2RITmNLdkV6NWV2U0gxb2J0cm5mZFRFdy9QaE85?=
 =?utf-8?B?cWpJODZWUjUyZ1pnc2VYdXNzcTJkYXpOUEt1Y3ZRdkxxbC90a1UyeDRqUnhT?=
 =?utf-8?B?UjJBVXpoaUt4ZlFEN3ZVVThIL1IzaU9zcFpBQjNlY05kb2lWNlh1dXJsWHFH?=
 =?utf-8?B?dzg3MGdLWis0a1BpSlIzT3haMStaRmNwYWRaYVZ0cEVOck4wcm9Ddi9tb2FJ?=
 =?utf-8?B?aDFaQ0F0T01FK1VEbERQMllZTmZPU0l2Y3poNXk0dDFjTk1HTERTSTZtNmRr?=
 =?utf-8?B?Z05oWHBmd0ltZWdaY0FXeUpvVlBnSmQ5K0M2SkVDRklsa005cW43YzVpcHor?=
 =?utf-8?B?dWU2VFJRZEJJY3VleEVKeVpOOHBvQmR0NjNWTjViRWEwYjNLMEkrbjY2aEJq?=
 =?utf-8?B?K1B5MzNnZjQraXJ3VFF5VjdTNDNVR0ZnaTlreDdWMUtFbnJudnFTQ1RJM0Nh?=
 =?utf-8?B?SmFGUXVxMmZpOFVmL3A0TGJqQzBLZ3lSU1hEaDFEbEpTTmY5K2lNOWdhTDFa?=
 =?utf-8?Q?6z0wcZBhipWvLKUFvcQ2JjrIR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243fce32-246b-4455-0f63-08db35970b0c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 05:31:44.8766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xB8pZ9ALuuefZgSp8O2E8Qvnj5bHVWzKwAQS8yUEq8CM1s4sl26AA7ZTa2FHkUpojkhdFXar2+nd0AZRtKbeRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/2023 1:29 AM, Tom Lendacky wrote:
> On 3/26/23 09:46, Nikunj A Dadhania wrote:
>> Add a snp_guest_req structure to simplify the function arguments. The
>> structure will be used to call the SNP Guest message request API
>> instead of passing a long list of parameters.
>>
>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
>> ---
>>   drivers/virt/coco/sev-guest/sev-guest.c | 87 ++++++++++++++-----------
>>   drivers/virt/coco/sev-guest/sev-guest.h | 19 ++++++
>>   2 files changed, 68 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
>> index 6ae197b57644..ec93dee330f2 100644
>> --- a/drivers/virt/coco/sev-guest/sev-guest.c
>> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
>> @@ -60,16 +60,6 @@ static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
>>       return 0;
>>   }
>>   -static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
>> -{
>> -    char zero_key[VMPCK_KEY_LEN] = {0};
>> -
>> -    if (snp_dev->vmpck)
>> -        return !memcmp(snp_dev->vmpck, zero_key, VMPCK_KEY_LEN);
>> -
>> -    return true;
>> -}
>> -
> 
> This change seems separate from the changes for snp_guest_req.

Sure, will create a separate patch.

> 
>>   /*
>>    * If an error is received from the host or AMD Secure Processor (ASP) there
>>    * are two options. Either retry the exact same encrypted request or discontinue
>> @@ -198,8 +188,9 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
>>       struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
>>       struct aesgcm_ctx *ctx = snp_dev->ctx;
>>   -    dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
>> -        resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
>> +    pr_debug("response [seqno %lld type %d version %d sz %d]\n",
>> +         resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version,
>> +         resp_hdr->msg_sz);
> 
> Again, not related to the purpose of this patch.

The idea was to get rid of dev_dbg for the movement, will do in a separate patch.

> 
>>         /* Verify that the sequence counter is incremented by 1 */
>>       if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
>> @@ -221,34 +212,34 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
>>       return dec_payload(ctx, resp, payload, resp_hdr->msg_sz);
>>   }
>>   -static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
>> -            void *payload, size_t sz)
>> +static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno,
>> +               struct snp_guest_req *req, u8 __vmpck_id)
> 
> Can the vmpck_id be part of the snp_guest_req structure?

Sure, that should be possible.

> 
>>   {
>> -    struct snp_guest_msg *req = snp_dev->request;
>> -    struct snp_guest_msg_hdr *hdr = &req->hdr;
>> +    struct snp_guest_msg *msg = snp_dev->request;
>> +    struct snp_guest_msg_hdr *hdr = &msg->hdr;
>>   -    memset(req, 0, sizeof(*req));
>> +    memset(msg, 0, sizeof(*msg));
>>         hdr->algo = SNP_AEAD_AES_256_GCM;
>>       hdr->hdr_version = MSG_HDR_VER;
>>       hdr->hdr_sz = sizeof(*hdr);
>> -    hdr->msg_type = type;
>> -    hdr->msg_version = version;
>> +    hdr->msg_type = req->msg_type;
>> +    hdr->msg_version = req->msg_version;
>>       hdr->msg_seqno = seqno;
>> -    hdr->msg_vmpck = vmpck_id;
>> -    hdr->msg_sz = sz;
>> +    hdr->msg_vmpck = __vmpck_id;
>> +    hdr->msg_sz = req->req_sz;
>>         /* Verify the sequence number is non-zero */
>>       if (!hdr->msg_seqno)
>>           return -ENOSR;
>>   -    dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
>> +    pr_debug("request [seqno %lld type %d version %d sz %d]\n",
> 
> Unrelated change.

Will move to a separate patch.

> 
>>           hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
>>   -    return __enc_payload(snp_dev->ctx, req, payload, sz);
>> +    return __enc_payload(snp_dev->ctx, msg, req->req_buf, req->req_sz);
>>   }
>>   -static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, __u64 *fw_err)
>> +static int __handle_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req)
>>   {
>>       unsigned long err = 0xff, override_err = 0;
>>       unsigned long req_start = jiffies;
>> @@ -262,7 +253,7 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>>        * sequence number must be incremented or the VMPCK must be deleted to
>>        * prevent reuse of the IV.
>>        */
>> -    rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
>> +    rc = snp_issue_guest_request(req->exit_code, &snp_dev->input, &err);
>>       switch (rc) {
>>       case -ENOSPC:
>>           /*
>> @@ -273,7 +264,7 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>>            * IV reuse.
>>            */
>>           override_npages = snp_dev->input.data_npages;
>> -        exit_code    = SVM_VMGEXIT_GUEST_REQUEST;
>> +        req->exit_code    = SVM_VMGEXIT_GUEST_REQUEST;
>>             /*
>>            * Override the error to inform callers the given extended
>> @@ -314,8 +305,8 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>>        */
>>       snp_inc_msg_seqno(snp_dev);
>>   -    if (fw_err)
>> -        *fw_err = override_err ?: err;
>> +    if (req->fw_err)
>> +        *req->fw_err = override_err ?: err;
>>         if (override_npages)
>>           snp_dev->input.data_npages = override_npages;
>> @@ -332,13 +323,14 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>>       return rc;
>>   }
>>   -static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
>> -                u8 type, void *req_buf, size_t req_sz, void *resp_buf,
>> -                u32 resp_sz, __u64 *fw_err)
>> +static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req)
>>   {
>>       u64 seqno;
>>       int rc;
>>   +    if (!snp_dev || !req)
>> +        return -ENODEV;
> 
> This seems unrelated, at least the check for snp_dev. And looking at the only caller, a guest request is always provided. So this seems unnecessary - at least at this point in the series.

Right, not necessary here, but will be needed when sev-guest driver calls this after the movement to sev.c. Otherwise, I will need to add this in the movement patch 5/11.

> 
>> +
>>       /* Get message sequence and verify that its a non-zero */
>>       seqno = snp_get_msg_seqno(snp_dev);
>>       if (!seqno)
>> @@ -347,21 +339,22 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>>       memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
>>         /* Encrypt the userspace provided payload */
>> -    rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
>> +    rc = enc_payload(snp_dev, seqno, req, vmpck_id);
>>       if (rc)
>>           return rc;
>>   -    rc = __handle_guest_request(snp_dev, exit_code, fw_err);
>> +    rc = __handle_guest_request(snp_dev, req);
>>       if (rc) {
>> -        if (rc == -EIO && *fw_err == SNP_GUEST_REQ_INVALID_LEN)
>> +        if (rc == -EIO && *req->fw_err == SNP_GUEST_REQ_INVALID_LEN)
>>               return rc;
>>   -        dev_alert(snp_dev->dev, "Detected error from ASP request. rc: %d, fw_err: %llu\n", rc, *fw_err);
>> +        dev_alert(snp_dev->dev, "Detected error from ASP request. rc: %d, fw_err: %llu\n",
>> +              rc, *req->fw_err);
>>           snp_disable_vmpck(snp_dev);
>>           return rc;
>>       }
>>   -    rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
>> +    rc = verify_and_dec_payload(snp_dev, req->resp_buf, req->resp_sz);
> 
> Can't you just pass req here?

Yes, can do that.

> 
>>       if (rc) {
>>           dev_alert(snp_dev->dev, "Detected unexpected decode failure from ASP. rc: %d\n", rc);
>>           snp_disable_vmpck(snp_dev);
>> @@ -371,6 +364,24 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>>       return 0;
>>   }
>>   +
>> +static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, u8 msg_version,
>> +                u8 msg_type, void *req_buf, size_t req_sz, void *resp_buf,
>> +                u32 resp_sz, __u64 *fw_err)
>> +{
>> +    struct snp_guest_req guest_req = {
>> +        .msg_version = msg_version,
>> +        .msg_type = msg_type,
>> +        .req_buf = req_buf,
>> +        .req_sz = req_sz,
>> +        .resp_buf = resp_buf,
>> +        .resp_sz = resp_sz,
>> +        .fw_err = fw_err,
>> +        .exit_code = exit_code,
>> +    };
> 
> Add a blank line here.

Sure.

Regards
Nikunj

