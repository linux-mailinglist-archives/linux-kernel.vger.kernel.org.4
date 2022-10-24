Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A1F60AF43
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiJXPkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiJXPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:39:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B3150FBC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHjs3D+wVCWXQVUt20wx4kAuqf+f/hFEiH83ULFqInVVn6JaLDyJWZMClYydY5b8mQXhqItVEh36XQ8f8CeD8JGRSAygZAkKtHZ3ZSbAWb1YSZUQbBTH1t46bJY+X3nlq0gqF0Ft6E+EL01W5ntUQhUKo1LAZrdejSveZJoBdirGDouEEiIHoerfrI8Xfrf48G/eKS2UeFzTCRfW5CPVMzWKI4rzSWgOqU0K6lvyJneNSJdYl5pFkYAGopkj18NGv/7QPSkWnL0PgbFCybwAKn+UyhZZFDoH70US221H+bJd4TKshQWgwJK7iSVIFg5aj6Bm0wVX6RibO/UUUDAQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IzOo4JYAOHo43Jb/wZzw+FiXSYxDJCnfMaiSUbbu8g=;
 b=UWF+8/I9qGaiO+QQMG+O8y5jfougffelnk8Kgdt0wWmlZwgTHft0qKC/PTG/A50cou2ifFSHO8rAolsE+NRve2w0x5bSTFTKPgdKgUXzYcnF2RyPCFZH2hivphy6YVi8zJWgV4hdTXChjKD480B6mw5zaGV4QSuuK2HkxokKsIfnz/99biNh2JSqAi8rHXZSMd6e0aouRytAckd5PG4LrvTsCBu8z8FGYx0APhwkWBZfOsRbj5TnL1N1EwqozO25/pY054q+hT2amKraYqPfeJEDM+bBuPjf5RrzYQshBV3j5BEZPp4uBAGlnzVQQmv8nAIR6ki+cWroT5dFsNptlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IzOo4JYAOHo43Jb/wZzw+FiXSYxDJCnfMaiSUbbu8g=;
 b=mNZgwKb4kN4WwLhDel4BoY3sKV/4nwbwxGNqQIzUIYEMhgJCd8rxoz8cskfDn2IoCsLUKVsj9ff8g87srhaFfkMVTJBwMJ+0jj+hA12tRuPMO52cpRaVa0SehXMJRG3DtmMnAin8GgfSbIWCBIMOXiUrTHdL1xUt24ShBpzwBDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Mon, 24 Oct
 2022 14:22:17 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 14:22:17 +0000
Message-ID: <17e9b20d-fc69-8fed-e6cb-c30fa33aa9e7@amd.com>
Date:   Mon, 24 Oct 2022 09:22:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 4/4] virt/coco/sev-guest: interpret VMM errors from
 guest request
Content-Language: en-US
To:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20221021165943.1968044-1-dionnaglaze@google.com>
 <20221021165943.1968044-5-dionnaglaze@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221021165943.1968044-5-dionnaglaze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:610:75::35) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c206f05-8686-40e9-de65-08dab5cb276b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLwg5SM5tUm2SziOYDf9DL5ff3skK8WfCwCpNDUuLPjO19p8NsYL4lv0EIv4uMu4AcN0mpNHDyUQJS7s8xH2wnrZnjzWbcSeMnkueKmmumJgqHI0yxBauA6MQ3jnwnWh700S29KwMxkL44IUyYUKcoMAdrDW7dSZYrml5oK2oMDcy0YAWvI2ewDwE0pESyWiO4S003QJdEzLi7B+gQVCbukQnxn9dqCfGnLouIRxGrb222TiKrcHIpRlKFZo8VwLPDWlzry3px8Gk7K5uqou9sQT7zpWNK7dLsyvW/ST5lxiDKNMyiVDGEhAd6Cq3Yas4cMyE+I/897CUJeUaPTvNE2thSW/9kxG/2Ps53lPgxvLmjnWjsOhG/oS4K30OaNb8/D8rIJTwd2YAX3rOVV0Jc+ExVjK9B20d2kqXiRaWTUZwK2TTZ6cdrt8cwqTXTRdWLmwnBqDBj8QKmYcthAU2cJxetjUHacIf+pXPllxT7C6mcnQzjhS/w9hKd53iOtka5vdsMvLzDTD80PWWzadsWuo+KUgS7AvDjwOGFICcNaDgNapXCFRI5lQwQefWKdu6bLaVZcn0d1t/iyzC/fHppS+09c3aOLL8QectQf71PqPCIX1GXa2+6jqvp4DgbXWKHSTXmO76mUzu8bg3gfSfd5gip6GoMXQlN5AAFHFCTd+Ww3XdQDfKwseOTbCxoVirrZZHAJTxJmXC0/UiwUgWIXTDg+jIKTAgR53oFEPom4fWlNgUfDVGmn+F94MYLzfbi//mBgqyKCTKgipDAZUIVFYpUs9uR94nWKAKZfkRpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199015)(83380400001)(86362001)(31696002)(186003)(38100700002)(8936002)(5660300002)(2906002)(66476007)(4326008)(8676002)(66556008)(41300700001)(6666004)(6506007)(54906003)(2616005)(26005)(316002)(53546011)(66946007)(6486002)(6512007)(478600001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmxPcDdjQnNDSUFSbWk5K29RdURvamR5TlpLTnFXZVBBU2NKclRETDM5Q0pM?=
 =?utf-8?B?NUpkYTlzTGFjVmRUL1BRZmlYQ2dRdit2dEJPN0N2SFdPSFlUYmUvelRpb1BL?=
 =?utf-8?B?ekd5V25yanZlNHMxakZhK0NtVVRMck1hVjluKytHV081eGRYRFV4NVJFLzls?=
 =?utf-8?B?MHltV3hrbmhTMnJPL3pTZ2NKSzhKNFIxeXpNNHpYcWh6cEgrR0E4ZFJ4WlY5?=
 =?utf-8?B?cG1CSkhyWlFmUTF0eXBZZ0hEQVI4QkNZQW80L2xlclRQUmErRHlIWXp4NGZ0?=
 =?utf-8?B?dXI4S0RWd2ZzOXlNVkdBZExUcEtzMUQwS2FIT2hoc0RHQ0FybW1PcisrczBR?=
 =?utf-8?B?bk9IRGJjZlN0OTU2bklrelJhZnVERnlOc0ltc3VncWNXV25qb0NRWXVBZ1dU?=
 =?utf-8?B?QjAzcnB3ZkJxd21iSi96L0RhQ3QxSHE1SlpkL2liaS9aR3VSOHFDQ0d6dTRT?=
 =?utf-8?B?UFE0Q2RTS1hsYkdPc0cxY1BkVmNlQ2hqZU5qVjQ2ZG1KOUE2VlNpS0xjNVNY?=
 =?utf-8?B?aVBwSHRmQ1JVVTUyTHZiRjBUaFVMak94Yk9UQ2piVUlvTGpsc3IxMTNOZFpI?=
 =?utf-8?B?b0xlbDRNT0g1dDdQeGI1QjZsaUxmOHJXNlJDVnJFWkhRVVpQMi93TXFCUzM3?=
 =?utf-8?B?dlV4bWVod0l4MDZ6cDNtYmt5T3V4Mis1c0NLdVNEUUI3L1RPak5RNVNjNm5N?=
 =?utf-8?B?YlR4a2ZnN1JpM2k0T2VhOUJpVnd0SG80YlJsYXZ0Mml0YTROYzFCOXcwOFln?=
 =?utf-8?B?eXZiZXM4SElxWEZOZmw1eW15bjRoMXRJb2g0K1ljRVRBR1B6cUcvYm5GdTJv?=
 =?utf-8?B?Z0E5UE9ycEY0SHBGVzM4MURZUFpMM1dLUUJuMkYxSlJpZHBSTW9xYmYwaUZ2?=
 =?utf-8?B?ZloyaWQ3QnUwRkhVaHpOejRQZlVtM1E4NzdmRG9kSHpwazFWS1BGZnIrVnkr?=
 =?utf-8?B?Umw4Tmt3bDQxWWlYMWVxTFp3RytGNWM3dnR4bmRydm5XV0t2SE9PSE50Tmhx?=
 =?utf-8?B?NGtnOEhyRUIraG5hR0t5akU4bUYzYndmMjNzMC9hVDMzVTErSElJTTFMSHBJ?=
 =?utf-8?B?ekFWZmZyUk1EU3p5UXVSQWVta0pxU3pYTnUwd01vMGhXdDVGMHBPejNIMXcy?=
 =?utf-8?B?ZUlPWm1yWUxYSXhQRk5aeUNVM3ZaM1Vpc3o0VTRnanlpdW5wMGFHRXFCc29h?=
 =?utf-8?B?cTVGdEZBcFBucDNZVmJGcEIzdlF6VnB3a29xcW9uYlRZbHpObi83Y1FJVDRi?=
 =?utf-8?B?MlhmNDMzVUJvazJQWm56c1E4czZrUWc4dXllZUxPOGlPcmoyWjJhVDhXT05p?=
 =?utf-8?B?VEkwaDVJV1U2UnptWnppQjdpUTZxZ1ViaVo2djh6cmxmdzQrd1JJMktxREk5?=
 =?utf-8?B?c3ZuSjhJdVlmemcrbGhlUWs5blRhQUJHMXR3a0lFcyt3eEdzY2NyWmZDN3hI?=
 =?utf-8?B?ZlJhZ09MNWVLRXZESEZDQ2Y0V09sMXJnU2NwZWduNnM4Mi9QK0dDMUJSQ2pV?=
 =?utf-8?B?R0R6S1VBVStEc2ZkMjFKN0ViOC95bWljYmhSM3piamtiWkRxSURrdndiYlF0?=
 =?utf-8?B?Q2I3THlvK0Rib3czcCtzRnFRY2xoYS96MitSTzM4YmxUVFMwYlVOcG4zN3Uy?=
 =?utf-8?B?MWkwK0x0cUYyNEJKWkkveEdFVnpKL2NhL08wQ05sTWlSaDhwWFRRNlZpWDY2?=
 =?utf-8?B?VU5DYnVqUktNNEtSTnR2NFFxQWpTRnhEWlhQVnRJQlRBNU9FUVBGRVo4Y2c4?=
 =?utf-8?B?U1l0eDJuZE9veVEwRVZZUTFPN2daRDFVc2d5aTFETmY5UUpCM0JHWjZtOGlC?=
 =?utf-8?B?b1ljOXBPeXRIaFhZYS9VK0JHb21VSnRXZ3NUMmdYTlp3aUxBM1Y0b2p6RjVH?=
 =?utf-8?B?NWpsbGVmeld4WFVwZlV1OTNoUGx5MDd1NnAzcEw0ZE1TTC82UHdXUWI2Ym1K?=
 =?utf-8?B?S1dtYmNXVTlQZ2w3L1dOTW4xaFNoYm9KSm1SMDhYaTliUzFERmJJYk5nLytw?=
 =?utf-8?B?QnhVVEF2TjF0cnk0M09FUW5adXl6UDQrS2dnNnMxY3BZeWtycGxlUElQeHBQ?=
 =?utf-8?B?MHdvelRTTHN0L2JVSCtwaXZSWDdIMGJoQzBYTHk4eVg4Q3dLVkN4VXZpaWk2?=
 =?utf-8?Q?OjJCj/jl5HaZh4kHbHB0XbsqY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c206f05-8686-40e9-de65-08dab5cb276b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 14:22:17.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FvGjpRcEWA+iJ+CJWYQARp/ZOcN+RcP2Y3jX7nRLXgF1goOQSRPuA+kECi5XEQDTBhk0J/8SVBKP9KBdicKHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 11:59, Dionna Glaze wrote:
> The GHCB specification states that the upper 32 bits of exitinfo2 are
> for the VMM's error codes. The sev-guest ABI has already locked in
> that the fw_err status of the input will be 64 bits, and that
> BIT_ULL(32) means that the extended guest request's data buffer was too
> small, so we have to keep that ABI.
> 
> We can still interpret the upper 32 bits of exitinfo2 for the user
> anyway in case the request gets throttled. For safety, since the
> encryption algorithm in GHCBv2 is AES_GCM, we cannot return to user
> space without having completed the request with the current sequence
> number. If we were to return and the guest were to make another request
> but with different message contents, then that would be IV reuse.
> 
> When throttled, the driver will reschedule itself and then try
> again. The ioctl may block indefinitely, but that has always been the
> case when deferring these requests to the host.
> 
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 32 ++++++++++++++++++++-----
>   include/uapi/linux/sev-guest.h          | 18 ++++++++++++--
>   2 files changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 0508c2f46f6b..7abf4c3daa6d 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -305,9 +305,12 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
>   				u32 resp_sz, __u64 *exitinfo2)
>   {
> +	unsigned int vmm_err;
>   	u64 seqno;
>   	int rc;
>   
> +	might_resched();
> +
>   	/* Get message sequence and verify that its a non-zero */
>   	seqno = snp_get_msg_seqno(snp_dev);
>   	if (!seqno)
> @@ -320,9 +323,26 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   	if (rc)
>   		return rc;
>   
> +retry:
>   	/* Call firmware to process the request */
>   	rc = snp_issue_guest_request(exit_code, &snp_dev->input, exitinfo2);
>   
> +	vmm_err = *exitinfo2 >> SNP_GUEST_VMM_ERR_SHIFT;
> +	/*
> +	 * The host may return EBUSY if the request has been throttled.
> +	 * We retry in the driver to avoid returning and reusing the message
> +	 * sequence number on a different message.
> +	 */
> +	if (vmm_err == SNP_GUEST_VMM_ERR_BUSY) {
> +		cond_resched();

I would think there should be some form of delay here. Otherwise, it is 
likely that the request could be re-issued almost immediately, which may 
make the hypervisor think even more requests are being issued and try to 
rate limit the guest even more.

Thanks,
Tom

> +		goto retry;
> +	}
> +
> +	if (vmm_err && vmm_err != SNP_GUEST_VMM_ERR_INVALID_LEN) {
> +		pr_err("sev-guest: host returned unknown error code: %d\n",
> +		       vmm_err);
> +		return -EINVAL;
> +	}
>   	if (rc)
>   		return rc;
>   
> @@ -375,7 +395,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>   
>   	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
>   				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
> -				  resp_len, &arg->fw_err);
> +				  resp_len, &arg->exitinfo2);
>   	if (rc)
>   		goto e_free;
>   
> @@ -415,7 +435,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
>   
>   	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
>   				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
> -				  &arg->fw_err);
> +				  &arg->exitinfo2);
>   	if (rc)
>   		return rc;
>   
> @@ -477,10 +497,10 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   	snp_dev->input.data_npages = npages;
>   	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
>   				   SNP_MSG_REPORT_REQ, &req.data,
> -				   sizeof(req.data), resp->data, resp_len, &arg->fw_err);
> +				   sizeof(req.data), resp->data, resp_len, &arg->exitinfo2);
>   
>   	/* If certs length is invalid then copy the returned length */
> -	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
> +	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
>   		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
>   
>   		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
> @@ -515,7 +535,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>   	if (copy_from_user(&input, argp, sizeof(input)))
>   		return -EFAULT;
>   
> -	input.fw_err = 0xff;
> +	input.exitinfo2 = SEV_RET_NO_FW_CALL;
>   
>   	/* Message version must be non-zero */
>   	if (!input.msg_version)
> @@ -546,7 +566,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>   
>   	mutex_unlock(&snp_cmd_mutex);
>   
> -	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
> +	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
>   		return -EFAULT;
>   
>   	return ret;
> diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
> index 256aaeff7e65..8e4144aa78c9 100644
> --- a/include/uapi/linux/sev-guest.h
> +++ b/include/uapi/linux/sev-guest.h
> @@ -52,8 +52,15 @@ struct snp_guest_request_ioctl {
>   	__u64 req_data;
>   	__u64 resp_data;
>   
> -	/* firmware error code on failure (see psp-sev.h) */
> -	__u64 fw_err;
> +	/* bits[63:32]: VMM error code, bits[31:0] firmware error code (see psp-sev.h) */
> +	union {
> +		__u64 exitinfo2;
> +		__u64 fw_err; /* Name deprecated in favor of others */
> +		struct {
> +			__u32 fw_error;
> +			__u32 vmm_error;
> +		};
> +	};
>   };
>   
>   struct snp_ext_report_req {
> @@ -77,4 +84,11 @@ struct snp_ext_report_req {
>   /* Get SNP extended report as defined in the GHCB specification version 2. */
>   #define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_guest_request_ioctl)
>   
> +/* Guest message request EXIT_INFO_2 constants */
> +#define SNP_GUEST_FW_ERR_MASK		GENMASK_ULL(31, 0)
> +#define SNP_GUEST_VMM_ERR_SHIFT		32
> +
> +#define SNP_GUEST_VMM_ERR_INVALID_LEN	1
> +#define SNP_GUEST_VMM_ERR_BUSY		2
> +
>   #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
