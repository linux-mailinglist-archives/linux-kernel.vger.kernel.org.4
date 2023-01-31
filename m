Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB5682289
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 04:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjAaDIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 22:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjAaDIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 22:08:49 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A64A11B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 19:08:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmcFOjfDnr/9jHDLEHdMAsnzpxWayv6r1+9c2LnVay/wADLDEAJ9UuNXGtJDLzEGU9snKt1BQ4D/EI+ir7dN9Wv/oikiALHy5pLNoDqCt0fgM9reKcu3XDjj50oT/fQfvvVgYUaj3z0M6rbL/dncbmWYU4J4Vk9Tq/w7arJR9EH9D0wXHmkAzCX0k1TDJD2sewXvC+QiD4hR46S4oI2KUe0cyIhwiLVhPr/bUv+00/5fV736bTUOYgekeMYI0Tj9UqSTnpwsWU2kE4fOOokle7+X4UGmlBEeIblKvNdCJ7yh9rBToAmlf5bNDZ/0MxTl+bdZqajXf/Znns6zU1RXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4RN8BD3HQmGQAzs8Q0coCX16A/PpERXJuYKCrzwpRw=;
 b=iSDTbo1ySmgZ4FXRkSQSXsvFXGCtG0+66euJfKPGVx+mzln/3lRUcNJ1Spzts/viFBXGJTglJ22Dn2nKFiwWax8RJZMCuutl0IIwPGCxUQoLnDhyWz+qawZZPr7XQc7WGGje8wE89A56A5r2G6E0svFk8JlSQnwEThytAD3TkUbv0loCwDewrpH949vTkG5TcwZTF8SI+b8CFCScPYpdxAn+DXH3BJN1kQBtdlvoRj594cLozA/lrxmjJ66kUFhc2YQAILeSxOw5oaYxSF9j0at+4te7rzCzk4y3SFKnRPX3aBOFOptsmitfb67FjZB4ZpQGsuFSD8aK+Afb7JWpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4RN8BD3HQmGQAzs8Q0coCX16A/PpERXJuYKCrzwpRw=;
 b=NvK7dcnZXI/6X50c6pfwUS2ONNONgYEKIZ+jK+SOZmhpJs0yo9FglMBT9KFXS/rg4HSo3clW4VIYKDcj3QjGNKHu7fx4foKXVZI1oap9VcylOToIKOH7YIgcAwkP5E3OJmg+Usz1LFdERbWHR0sgRiS1hqbkz5I07IkvMPfUc2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 03:08:46 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::8079:86db:f2e5:7700]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::8079:86db:f2e5:7700%7]) with mapi id 15.20.6043.033; Tue, 31 Jan 2023
 03:08:46 +0000
Message-ID: <a4a83fd2-b1e6-3dce-6881-8abe71c7e934@amd.com>
Date:   Tue, 31 Jan 2023 08:38:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 03/11] virt: sev-guest: Add snp_guest_req structure
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        thomas.lendacky@amd.com, pgonda@google.com, jroedel@suse.de,
        mingo@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230130120327.977460-1-nikunj@amd.com>
 <20230130120327.977460-4-nikunj@amd.com>
 <CAAH4kHbJEcg9p=mXi2aQZFs1bopZgeqWKiwGWu2V4YsgmwHmmw@mail.gmail.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <CAAH4kHbJEcg9p=mXi2aQZFs1bopZgeqWKiwGWu2V4YsgmwHmmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::16) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|BL1PR12MB5030:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad8712b-b78c-41b6-b296-08db0338774f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gax77G7w7mKOYQrgHCYXofV2ffDNso4hAfCosiKV8B+FWNED/DIQUqYeMu0p7AalHOZtQU22u81CqUol2/LRdbh0ZOZVe74qwwLLqff8pQY0MvUfMC5ExP45g56aJyCj7GK6XxlSeQSbJSuuSs6fTqz9+yFLTL+qXQnchyXGBAXXjG8WU9f9QHpoxdoiy6mP/irKrgJX5FUPJHTAj69Na9bCFQ+amVYd0lWwQedpnfaysot2zJ0jkU/evYP3ZCDA8aAC0cd8v2rjXxAmbA50rddg7T6DoAFZ9SQwWCOSH5MJTmZwq/K39aNXOz4V6t3+3MysgDUFXsZNS2f+J5PVzpFF+iEydn0s+pQfVdsruALjLQukQmODm5u9E+o4ewSf1CP7Hqk/JVQZOCbhpXnLqP7eO2P/UCcXjmYzNPQ01jymjt2UsRH7Tma9wV9sEfcUCM17LS7kwGvratYUTGeRMnj7R+qIegWMnmD9ODuHMvOMR7jXANDN9mLjJGUgzDsRWy21AojX4QZmC0hQlOUmIG+NDMKx+dodKzILznIvqX+aHJbo17UNz399Hs+Q145p58uxMb19lXdUixfXn2RzDUJbpHAqLSg/IYuT/yncujs1eoRSJ7bAZVgYCstGKoxJa3BdGRsNGSLgfg7eAtt6P/BgAJbthx3gcMPt7cuLo7fGZj79FFxVrzuyf0gFLL1UKTCfaarKiQA0U/hHzSfQ8NA+AFJUCU6ZpGBXCeneeoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199018)(8936002)(41300700001)(7416002)(66556008)(5660300002)(83380400001)(38100700002)(66476007)(2616005)(4326008)(31696002)(36756003)(6486002)(6916009)(8676002)(316002)(478600001)(66946007)(186003)(6506007)(26005)(6512007)(6666004)(53546011)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUNXZHNBTTM0SlF1aG10dlpZY1JRNFR6ZDZqZDBNL2Z6Z2pTNXVRYmN0QVB4?=
 =?utf-8?B?Z1NEMVRLTzVqSVRBNGlJblFHWHMwZVpGS1BLL3cxeUh2dzlOSVJWeUJad1lR?=
 =?utf-8?B?T3NIKzFybWl1ODVDN1pWS2JMNDgvSmVPc1p2TEFJenc5M2ZSTFlKb2I4ekdX?=
 =?utf-8?B?MzF1Ymc2L2dSSzlIdnhaNERYVjg0OThpNnVHMWxRWVZCTUFESTYwNDNRaDNs?=
 =?utf-8?B?UGpQaTV6VXpwK0wvMHVuVFNSZDliaFZxT0Rjb1Q4NXhoWFE2SkZ1Ti9WZHhO?=
 =?utf-8?B?M053cnUyM2VrSzY4M3ZWbVEyKzJJYVFnLzc5UUNRMFkzNkNVUVJHUDQ5QXdj?=
 =?utf-8?B?YmxmYUt3a2hMYW1BY1lRUGprRisvTnh6eDVackIzU1Z6Umg5WUpodURmKzds?=
 =?utf-8?B?WU5PbGlXMTVyb1l5cjg3R3lTaW12MnRKSEo1YWc4NHV6VGxBcTlPTzVWUVp2?=
 =?utf-8?B?QjUyanN4a3lEM3p6aXJML3J2Z29wTzZqNUc3b1BIYU1SSWg1Sk00Rng2TUoz?=
 =?utf-8?B?MjJxT3p5di9VcCtNOFJCNWFCb0FKOE5SOEJ6QWlRQVdXVDBrSGN2RnB6czlX?=
 =?utf-8?B?QkF5U2JhL3lWdDJvOTNRSVRpcTVhaTlvaXp6dmlwTG1tNHdpUkIwUHF6N2ph?=
 =?utf-8?B?WllDbVN1L1VQR3BueHg0S0J5VldpS1k1UVArelFzaUtnRDZLb3dhWnYzb3BY?=
 =?utf-8?B?cE40U25lZTFYZXNIbE54cUZRQUMxeXBzSXBQNU9zblJTTHRkWmNhNFVHYW5F?=
 =?utf-8?B?RGNYSEdEWllGYzQ0NWYwSVhUNi82R1BhS2ZEVDRPN3JDZjE3dlFwS3V5cGw4?=
 =?utf-8?B?QkFtd2J3TUY2S3FoKy9nOUVXY1g4SGJIeWZUZWZDK2xFOStYazhtaUVCVzE3?=
 =?utf-8?B?MTQyMmlqRW8yd3NtaVNNZkQ3QUxxS08wVjFYMVFLcDdhaVV0WHYwME9hN3lY?=
 =?utf-8?B?U0JRMjBaK2lxTnY0bG1vVFV5bzN0RWNWd1UwWUdRMnI4SC9rRCsxV0tVNmFB?=
 =?utf-8?B?SW81NjZpeXJOSFRadmZJcWVwS1dXKzZWNnNwUXdiaytSTUlqaGd4UmhFb2pN?=
 =?utf-8?B?c29ZbENiK0RIekVsUFRLMCtIc1FIWVprSG54ZXoyQVBRaS81cm5WVnRlb3U5?=
 =?utf-8?B?Qm5OOTJ5UzNpQnh0MDhWQVdvWHI1WnBJVHltdno3aUFhbkd1bjdQSWRWdC8w?=
 =?utf-8?B?M0twcDNwQmYrdUlOQTYwcXRjS2Vrd0h0QkF6YWJFdGNiYnlFS3IxMGszajI5?=
 =?utf-8?B?UUFwTitNN1prQ0JoZXJDZk45TzZ6dUZCVjhkcVdRMjh3cWdtVXNUOG9hVlZJ?=
 =?utf-8?B?SmRRc1pUZlFhekpRdlViQUdqQ2VTZzRGZnUzYmcybUJCUUxlQS9yV09uYzFl?=
 =?utf-8?B?ZHp3TVduNkdERDFKVXlCV0ZsQy9WTDFKVmpVbE9qSm5NWit6NHQ4L1VtOUU1?=
 =?utf-8?B?elNkWVE3U0xqbVJHcFFXY3NXTUlwSitPandmdE53WG5peEhoaERhbHNHblZ4?=
 =?utf-8?B?aTgrbTlSYXAyZWIrZGVkRGZKTEp1WE9TMkpsYnQ5OVlaOEZyYnB6SFdJUk1p?=
 =?utf-8?B?RDBlT05XT05nQWloWlIrOCt0OHkzcisxM1J5UCs4Ykt3cUI4LzFsR1hVUTJi?=
 =?utf-8?B?MFE0dVNxY0FCQlNQT01DR2doZjFnWENPdjdUci82RjFzQXZGOVAwbXRQV2Iy?=
 =?utf-8?B?S3QzSGJ3L3QwbnBVaUlEUGVRc1NpMUdFWFVvMlpSNllZYnVLa3lJVzdnS0c2?=
 =?utf-8?B?MUp3NjI3RlpaNDVYdER3V0kwQXAyWjZ3NlZMSU1pcGZTS1NQcXY5QkV0THF0?=
 =?utf-8?B?VUw4cDRBMytXSWRRVXJESWtxYng3bjNHdjlDZzBqSzN5SHV2MnltTUJ2dXlq?=
 =?utf-8?B?MGtsVENkNlJ4QlhpR3hXN3BmM3lTWGVONXFLeHNQbWkzUWphMGFQS0lJTUE1?=
 =?utf-8?B?amRRcFJyZlZsVEhZS2htZmNwQVNSdUx0b0Z4RVBrZDFMYlc2M21ZeG1IaG01?=
 =?utf-8?B?bE5MNlk4K2wvYXlsRmlEZFViSlhMUFBoTlhhVFFnakN5WTVDQUZhckt4eStq?=
 =?utf-8?B?T1lTdVFFbmFNNXRoUG96alcyckQweTQzSmFvbXkvdGRta0d3eFlyTmxRMFNr?=
 =?utf-8?Q?t8QVVt7gzW8JXaeAqbixoESrt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad8712b-b78c-41b6-b296-08db0338774f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 03:08:46.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: su18K+MhUuvKj+B9Zy0sBehKtw3cgR93F+MHIPm6KNISWfhpFbrc55FnnEzhwOd5YGXvnT6uqgVWdpVUMuPmqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/01/23 00:15, Dionna Amalie Glaze wrote:
>> +static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req)
>>  {
>>         unsigned long err;
>>         u64 seqno;
>>         int rc;
>>
>> +       if (!snp_dev || !req)
>> +               return -ENODEV;
>> +
>>         /* Get message sequence and verify that its a non-zero */
>>         seqno = snp_get_msg_seqno(snp_dev);
>>         if (!seqno)
>> @@ -261,7 +253,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>>         memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
>>
>>         /* Encrypt the userspace provided payload */
>> -       rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
>> +       rc = enc_payload(snp_dev, seqno, req, vmpck_id);
>>         if (rc)
>>                 return rc;
>>
>> @@ -271,7 +263,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>>          * sequence number must be incremented or the VMPCK must be deleted to
>>          * prevent reuse of the IV.
>>          */
>> -       rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
>> +       rc = snp_issue_guest_request(req->exit_code, &snp_dev->input, &err);
>>
>>         /*
>>          * If the extended guest request fails due to having too small of a
>> @@ -279,11 +271,11 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>>          * extended data request in order to increment the sequence number
>>          * and thus avoid IV reuse.
>>          */
>> -       if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
>> +       if (req->exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
>>             err == SNP_GUEST_REQ_INVALID_LEN) {
>>                 const unsigned int certs_npages = snp_dev->input.data_npages;
>>
>> -               exit_code = SVM_VMGEXIT_GUEST_REQUEST;
>> +               req->exit_code = SVM_VMGEXIT_GUEST_REQUEST;
>>
>>                 /*
>>                  * If this call to the firmware succeeds, the sequence number can
>> @@ -293,7 +285,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>>                  * of the VMPCK and the error code being propagated back to the
>>                  * user as an ioctl() return code.
>>                  */
>> -               rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
>> +               rc = snp_issue_guest_request(req->exit_code, &snp_dev->input, &err);
>>
> 
> This is going to have a merge conflict with "[PATCH v13 1/4]
> virt/coco/sev-guest: Add throttling awareness", which is an important
> fix to ensure hosts are allowed to throttle guest requests and guests
> are able to retry instead of disabling the vmpck. I think that set of
> patches, or at least the first patch, is going to be going in before
> this series. Please be aware.

Yes, I am aware of the series. I can rebase my patches once that goes in.

Regards
Nikunj
