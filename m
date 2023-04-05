Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9552E6D7454
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbjDEGUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDEGUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:20:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F124F30CD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 23:20:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJyxz9WluDNK/4N4Ah5HCRpqK3IbQHcv+rkM1X6tomIFrCvCnNqsv6g10goEsiGqMdDVVn7qirIKpIsc45euzU/dgxmY89LUPIWD3cWRD9Tiff56Tgi0pZGu6UYOcJeJZ7G+Bz6oTuinTCQv8sl6j17wPsG4NI0NOwrT4HHKWN0V2wMdi8CcldMdkkwJLOxT27j7W4ABqp/iWUxMIK7mCUKqy5RIYdATR0kZxqw2S1tvGaVxl+FMEgc3OTX8nlDXdGu2bwQZZ5oba2K6JN5Y7cjkhC7zIFmtL3JT5anHiciXI6Dg6wk5uOcMlqJANpkDA1degQhFZGau4YKKcS/Jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVIvhNrNPal+cAVwRA6Kg8WOopEKhe0m1hV4TVOtYjM=;
 b=DTj1f0kF6SRIeyOwRevpF1BY4Q9BOeSwX1NNDpGOB1oeSVxAkRlifBs3oyqwWPvM6VY6G9Fgb031pD4yg+zJOgbaDoG/UFDjD9pPC/D6RvUhzR8+2iKVXryiE7TGIT91bFo8U4ZXrEzpFg7I6CS3WOEFhJW8iMk7jVrKXMziw5EwK/gFqMlJsX3YVi0TYbiDgoFSPFbS/n2b+xyUmFkEn92WGc4XYalztezEnvRqtKeEo5VidYSPjL1ziOxL24suiU/HNS/v7gcZPyCpPV8vmI8T7PO9uG8Brxf6iO8AyVF2SZRo+0VVAUzM1KTf14o7usWkoaPTlBe08lPZLfHjaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVIvhNrNPal+cAVwRA6Kg8WOopEKhe0m1hV4TVOtYjM=;
 b=jd05rZsnWr5IGnCQOmGCOT9todj+1tcHy8msv8SMD7hXqin5u2LjyB/GFRBA7kR/D3rZbDtjRerbKBZYDzs2/+6fQ/Cql1eUlq6boOtxumGqzTWPOmSDotCMMV+t8R1sl8teIImosPa6p0pHf99ZmWlzrARyUhHS+2qQNC6Ya10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 06:20:03 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::de58:ace6:16ba:96eb]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::de58:ace6:16ba:96eb%3]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 06:20:03 +0000
Message-ID: <66416f22-5ae7-7d57-b2d1-8510da00c78a@amd.com>
Date:   Wed, 5 Apr 2023 11:48:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: nikunj@amd.com
Subject: Re: [PATCH v2 04/11] virt: sev-guest: Add simplified helper to assign
 vmpck
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-5-nikunj@amd.com>
 <47f0e94b-e392-ec25-c0df-6754c673e44a@amd.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <47f0e94b-e392-ec25-c0df-6754c673e44a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::16) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 49079cae-9002-4f3d-b002-08db359dcace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DfHWwK+jWLBiBWGV4Jkoiivy9MMLQyuWopZj+0IDl13KY7507qAhiODAsrt3zQ0KEHuVWGB+AtL6W4VVHRO08+UgHRBNQjqQB0mesuTGFRm792SaviQMGGwSC9okHGRHNhalR7Q9jUcYtHvxmC3JazDlNFWXU2aW4loTbZDuA7fxdO/RPOmUF9PT+yw91/SPDy+8E0gPWZzWGSk+yMa0ddfSdyLH/gTJqkfWFky7SQ0zM+aIei0wiP61SEU4KYkcjveUNxvOECUHtwBqka3HNDY6JGHbBuAreM4N26bpYml0/RUsLSPS/PGggHdnU5xNfzKq6Cs6yYKTqwaJwGecTmgF1BWMfZaI2IApuxnqtkQGczZA9JZWPgxVrNC1EatWxGJx7JyELrErX04q2c8ntlGHZcgW4cubvfkYdl3Rjcu15ofi8OYpSEYW71JMghg4QePA49auBSWIIvLSXxnbkVeDTRjgziOtPMdxXi8rrAwkAyApuzdFzmFwg54iJ6303uTeeEEGxKxqqh10VnRqfvj06MIG3a3kreTbgu5yKSyaKPxxr1SVDEz44a8MkRaGhxhPLu3oZIESwDSvK70o1UNreUBn3kmaQBKj4umBmvvyNuOxGPKEUwlyQSqUbaPi0E3SvbKasbXqGtl2wMab/rtNKdv+9S2kMUToQ5XiswM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199021)(31696002)(38100700002)(36756003)(6486002)(4326008)(2616005)(6506007)(6512007)(26005)(53546011)(186003)(8676002)(6666004)(5660300002)(66946007)(8936002)(2906002)(478600001)(31686004)(3450700001)(316002)(41300700001)(66476007)(66556008)(83380400001)(17423001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE5pcmhod1dKMlhySnhHN2Y2KzJ4MTF0Mys4VUYrQjFhV1hES2FuQ3lMQyti?=
 =?utf-8?B?dzhHd0FRSE5XSVRSSUs2U1p1YXNWVDNqaVZLOWZlWVBIUGsvbGVXd3lWTlAx?=
 =?utf-8?B?Y1NyQ3g3b1k0VkovNDlIR1cwY3ZHUnFrUVM2bzNpWHZIMmpEUlNvN3F0UTgw?=
 =?utf-8?B?cjBWaHd2amVlNTcyaWZsKzc5dHBvSTV5MWtyVjhObVZqWnU1VmpURU4xdFBq?=
 =?utf-8?B?dWZ0SEtLLzZ4bU1oYVBnQXlMLzU1L0F1WWpkN3dwcHhoTEFxVitjQzdjNFND?=
 =?utf-8?B?SzdLYnNYOVo4d3F0MkNrSGlEcS85RU5ld3B5QWIzRGs3WEo3R0tqRjJZVHp1?=
 =?utf-8?B?eWxMRHM1SnhtYUZtc1dSZjdkUVRCUTRldHlCR2FzRGZQNUV5NktxWnlSS2hU?=
 =?utf-8?B?cTRxRnd2TXhCa2dtZlc3T2RBVEs1a3pyL3hXOTg0Umt1VDF6MkFGdHdMb09a?=
 =?utf-8?B?UXFJcGk5UFRwUkdYRHQ5Y2c5aWw1MkxWeGN4NlFUd0Y1djhQb1BOSG1pMExm?=
 =?utf-8?B?aS90Tk9vWWJVaHNab1pPSC9aUE9aOXBTdEtNeklGSWhJN3RINzVUTXYwSDBY?=
 =?utf-8?B?b3ZPQmVyVzRla3JhMzJpMlpKTmoxYXgwdWt6djJ2MTlZQ3hONUgzbTJ1ZkNO?=
 =?utf-8?B?ZzBQK1JrTjU3WThMTDg1V01aUzkzZDJzamZOSjR5UkdYaDNWYzBJbmRHV0JR?=
 =?utf-8?B?SEFjK3ZhNTJ6OWhaRkl6Z0daR2luTlY0alFIb2RkMnd1bHE5d1J0b0NudHVj?=
 =?utf-8?B?MWwxem93dElybWN0ajJZNXB0SUJrZnhidFkxVDByMm5WeHVwcytUUmFhMXhL?=
 =?utf-8?B?alhuei9DV2JjL3JyMnR2aDlLSm1RbnByK1ljMDR4S1Jjdks3aklPaGZUd2Qx?=
 =?utf-8?B?RmV3SnJGV3c4MW4wNFd5R29UT0p4SWh6VnAvZVVxVEFLSW94ZFVmZzVXR3Nw?=
 =?utf-8?B?SG14QSsxNXB2VnZnVGFDVkIrSDhmRFkwTWVMWHQybjN2b3dJYzd3aHJQYjJR?=
 =?utf-8?B?bWtkK2hRLzl1dlBTalRUemV5a1lJb0RSTS84M20rWlhxdmg2WGlaWDJ3dDFP?=
 =?utf-8?B?RjZWeHZFajBzYWJoWk9xeGx3TmpNODlMZG5uT1drSW5QMjV4K3VZRGJqYVQv?=
 =?utf-8?B?MHdpYUkrS204WC9GRnJDQi9ZZVM5bWRlc0wvMEFxcGI1NXAyb0lINjI3anZQ?=
 =?utf-8?B?MGpDT1VVeXBmN245VG1OSURpSHk3LzFsYkVZQURHd0dEQkxNRUV1eG03TGsx?=
 =?utf-8?B?RngvYlM3ZTBFVC9TbDE2Y1FlK1lYSUpVOUo5NXhESEVsVjIrc2psN2tpaVlr?=
 =?utf-8?B?WHFHTy96S1pBR3k0YkhaYTZYa2NuTEYyWjlOMk5xN29OQ3NUYmxLVDhhSnJJ?=
 =?utf-8?B?MVFob2VKVzFOUDg5UWlrSThFcUlvekZTOUFwNHZiVUFPTnllSFZqMWtLUkox?=
 =?utf-8?B?MFNJZGF1UkNuQy9VM1RRSHJ4ODVsWU9OdUoxQmNyU0RVdVg4b3RJZkNYWi82?=
 =?utf-8?B?WFc2Y2tjelNXS3RIOVZESnlwb2RhRFVwOGVFcStkNVcydEk4RVlGTGhJcmYv?=
 =?utf-8?B?N29uMnRZQWs5c3RzeDNIYjB6RmdCamhtRTVmYkNvTVdET2JzSXcrL1pnajFH?=
 =?utf-8?B?RXlvMW8zb3QxcHVHdyt2K3h0NjJ4V3A0THhyS205NGZGK3BLVkpOL203TmZa?=
 =?utf-8?B?Z1VHdTVGaWxKTXNsWjZHcS9EZEd0V3AweU9naUJnY3NpdmNvV1dMdlJjbVl5?=
 =?utf-8?B?aHhPZXYycGZEQzU2VWhJSlRkTXR4NXhBNzUvNjNkRjhYSGE1RWJ3OXkvSWRR?=
 =?utf-8?B?eEEvZmcvUkhGN25jSFZ5UmZYZlRNaEhjVFFKa0p0a01SRlBUZ2RKd2Z0TFdY?=
 =?utf-8?B?SWVQNEVPenJ3RVNhemxHUUV5bGJaS3RrOTFmNnpmcFZOKzV5WDV5ejBnSXN5?=
 =?utf-8?B?U0VsTTNta2gyZFdtaVI1MVBYendCREFES0orL3pJUDZReGVDcytURmlTd1RC?=
 =?utf-8?B?clIrMEZXTWpvcllxYk1KbWpyK214OWZoN2M2SStwVnROTDF4b1JVVmdaSklW?=
 =?utf-8?B?bDJsSEZCZ3k2N3JMYjhNeFNicEZLWWpYdTVza0N0eDZ3OXdpUlQ5bE1pdFkv?=
 =?utf-8?Q?D5W1Gdystg1rtstsOFjgNF+nT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49079cae-9002-4f3d-b002-08db359dcace
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 06:20:03.5255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNpGJkYkvoUVPriu4nDTRBDaKHSKgrzeU7FZcPXEgCs2CC12fB5+FiS0qhjc7YCDBY6Rc0g+4WAum0bvxIWa+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/2023 1:56 AM, Tom Lendacky wrote:
> On 3/26/23 09:46, Nikunj A Dadhania wrote:
>> Simplify get_vmpck and prepare it to be used as an API. Update the
>> snp_guest_dev structure in snp_assign_vmpck(). Added vmpck_id to the
>> snp_guest_dev structure which can be used in SNP guest request API and
>> will remove direct use of vmpck_id command line parameter.
> 
> This needs to say more about why you're doing this. The first two 
> sentences need more explanation as they don't really stand on their own.
> How about the this:

Add vmpck_id to snp_guest_dev struct instead of directly using vmpck_id 
command line parameter. Each SNP guest has four VMPCK, which the firmware 
generates and provides to the guest in a special secrets page. Each VMPCK 
has a sequence number. Simplify assignment of key and sequence number 
instead of using a switch case.

> The last sentence talks about removing direct use of vmpck_id, so you 
> should probably do that in this patch since it seems to be the real 
> reason for all this.

I did change all places using vmpck_id to snp_dev->vmpck_id. This is the 
only place the command line parameter is being used.

+       if (!snp_assign_vmpck(snp_dev, vmpck_id)) {

Regards
Nikunj

> 
> Thanks,
> Tom
> 
>>
>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
>> ---
>>   drivers/virt/coco/sev-guest/sev-guest.c | 41 ++++++++-----------------
>>   1 file changed, 12 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
>> index ec93dee330f2..4901ebc8fa1a 100644
>> --- a/drivers/virt/coco/sev-guest/sev-guest.c
>> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
>> @@ -45,6 +45,7 @@ struct snp_guest_dev {
>>       struct snp_req_data input;
>>       u32 *os_area_msg_seqno;
>>       u8 *vmpck;
>> +    u8 vmpck_id;
>>   };
>>     static u32 vmpck_id;
>> @@ -80,7 +81,7 @@ static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
>>   static void snp_disable_vmpck(struct snp_guest_dev *snp_dev)
>>   {
>>       dev_alert(snp_dev->dev, "Disabling vmpck_id %d to prevent IV reuse.\n",
>> -          vmpck_id);
>> +          snp_dev->vmpck_id);
>>       memzero_explicit(snp_dev->vmpck, VMPCK_KEY_LEN);
>>       snp_dev->vmpck = NULL;
>>   }
>> @@ -339,7 +340,7 @@ static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_gues
>>       memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
>>         /* Encrypt the userspace provided payload */
>> -    rc = enc_payload(snp_dev, seqno, req, vmpck_id);
>> +    rc = enc_payload(snp_dev, seqno, req, snp_dev->vmpck_id);
>>       if (rc)
>>           return rc;
>>   @@ -364,7 +365,6 @@ static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_gues
>>       return 0;
>>   }
>>   -
>>   static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, u8 msg_version,
>>                   u8 msg_type, void *req_buf, size_t req_sz, void *resp_buf,
>>                   u32 resp_sz, __u64 *fw_err)
>> @@ -625,32 +625,16 @@ static const struct file_operations snp_guest_fops = {
>>       .unlocked_ioctl = snp_guest_ioctl,
>>   };
>>   -static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno)
>> +bool snp_assign_vmpck(struct snp_guest_dev *dev, int vmpck_id)
>>   {
>> -    u8 *key = NULL;
>> +    if (WARN_ON(vmpck_id > 3))
>> +        return false;
>>   -    switch (id) {
>> -    case 0:
>> -        *seqno = &layout->os_area.msg_seqno_0;
>> -        key = layout->vmpck0;
>> -        break;
>> -    case 1:
>> -        *seqno = &layout->os_area.msg_seqno_1;
>> -        key = layout->vmpck1;
>> -        break;
>> -    case 2:
>> -        *seqno = &layout->os_area.msg_seqno_2;
>> -        key = layout->vmpck2;
>> -        break;
>> -    case 3:
>> -        *seqno = &layout->os_area.msg_seqno_3;
>> -        key = layout->vmpck3;
>> -        break;
>> -    default:
>> -        break;
>> -    }
>> +    dev->vmpck_id = vmpck_id;
>> +    dev->vmpck = dev->layout->vmpck0 + vmpck_id * VMPCK_KEY_LEN;
>> +    dev->os_area_msg_seqno = &dev->layout->os_area.msg_seqno_0 + vmpck_id;
>>   -    return key;
>> +    return true;
>>   }
>>     static int __init sev_guest_probe(struct platform_device *pdev)
>> @@ -682,8 +666,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>>           goto e_unmap;
>>         ret = -EINVAL;
>> -    snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
>> -    if (!snp_dev->vmpck) {
>> +    snp_dev->layout = layout;
>> +    if (!snp_assign_vmpck(snp_dev, vmpck_id)) {
>>           dev_err(dev, "invalid vmpck id %d\n", vmpck_id);
>>           goto e_unmap;
>>       }
>> @@ -697,7 +681,6 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>>       mutex_init(&snp_dev->cmd_mutex);
>>       platform_set_drvdata(pdev, snp_dev);
>>       snp_dev->dev = dev;
>> -    snp_dev->layout = layout;
>>         /* Allocate the shared page used for the request and response message. */
>>       snp_dev->request = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));

