Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B672F5FE49F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJMV7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJMV7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:59:12 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2083.outbound.protection.outlook.com [40.107.96.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56076B1DE5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeJp8GTzxnXqWf76sP9ZZEtLgJbVluudDNagIjt5YGCaQ9BYTL+mglBp4KnxZ8kyzM8HZu9qzPD8lyRT8dp0/BVWeClAjS4J6DDCFtTtwOsz1KRH7SbGPVYJiIyE3I+gM+hPySF3kaePZTpAOB6xCV1AGyohbE8XkwRdHax4lqHJ8E9cl6tgb3PyyV0ii6+EZ2/BGInqI0ncvmDd69ZKz0UCFz1gxbC3B0Vk6RZY0lUAmI15hcmZSB9TzqDGGONSmE/uUILnXoWcBtmXkrcoUi3gpuuv2N5yBjj/QflRt2CmPRrorXNPz3fVUxfNVrC2jzJumYRQW7hAMHGhTUVN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgkHpmwNPOWbKa/RtwBVJdGDzjGVtc2u8USwPi/SXW8=;
 b=RFeN5yQNmxc8sVXn0kCQekjGoyovWvgY5ChgbHeB12Ce4S4C7JGanvRFnXfhLJLYGpm9D2eH3uOmsbbR+xfaurz7T9TmDEZnU6oDgFXgOAtqjk+ElbnbBjHn1py0/h1n8OBMYKIhMZC1tT3xpQBQbbbmzqEryZQ3x7AB02vX6QEBVY35mKN6agYfbWK0eVBXd5WNVR36Xxg3E8kMOG7x+q9Q1/zjx7qEzgkXjRnOK/YHLNF/JLb6+avpBe43okhDvXKaRfkGtHF1iTNZH0W8dXWC5tVMdFSS53oXXoKH5dnRsakfor8OqHZRg8AS15/L8A+EmDiigiRgx6d1oXqpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgkHpmwNPOWbKa/RtwBVJdGDzjGVtc2u8USwPi/SXW8=;
 b=e15EalxW4Dm32jLfyqKuTrkN8+2hn0mICSRpFiGBYViWVHxUSFbnZo3m+LsGTZ7kiFjtjZCc44voGozccJRk/7a/qk783ayRaNY+hBbCds+dhqjSnyDhT8ceV02wQd2e4ZGTjgTc4Bs2n2PR9xp0dUGREJpkTqd7Xr0PLUnbFDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Thu, 13 Oct
 2022 21:59:09 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::269b:c6f1:7b3d:f193]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::269b:c6f1:7b3d:f193%3]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 21:59:09 +0000
Message-ID: <ba5b3553-370f-3114-b920-5efe9b40ab0f@amd.com>
Date:   Thu, 13 Oct 2022 16:59:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] virt/coco/sev-guest: interpret VMM errors from guest
 request
Content-Language: en-US
To:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20221013160040.2858732-1-dionnaglaze@google.com>
 <20221013160040.2858732-3-dionnaglaze@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221013160040.2858732-3-dionnaglaze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:610:59::38) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b99fc6-0473-42a2-d743-08daad6627c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJa35ezlLZq+t51yptcLOKgLZCN0yNDRVQ4TKi8F8noC4FcW/jLmsOWpmcPv/u2sUZIQ6WxEHIKs+NRUuensUmzNUzCcvy7Qo50jbXRfTyFUgvVBuYi+kxrR+psUrxC/SdCdqksP1WmkMq0RVKlQcTP4kAtZd7xDA8QTlL9Zg9w9nR2LRbubpz/Vbx6BxU1GDZIVNZ/WdIbqdRAN768IQUCGysavb3uEGLBXS/UWAnecoxyuPjlDpDojB+/WOU3gygxRfm/rfMXc+m3gYlJU4lQYhmm3zCZjsbuFr1/R4gz6UHKys47TlXitnTSZzB8+ZzE8M6rJaipz/sxrkJdtbGQI/GRSzgfrRykoyAepuTUuARcqleotl7Gao9Ed7uInQW0QG3/V961jRRTbUQSl0YICMrddoQ0cPB8TGQGJR2zPLuL0aGp8+vnmeuoXXj9AUGsQnSEKscWkmN9a8S1FCTlUU4/zgirpCHe5mtQWPouBqwXKCL17k+7dO8Dnyk4bB92439Tw/Hmvh6DNZYsAwpVev7levoyhQSNmvxJ4iGl39iBj553sTvKmiq5qwpvZ9eJWbFAwQ9sEBe27+FEt3pUUZUdCSvKHXzp7Q9RoRH1laYdddOL03nFCcKMDIQx/LnvR1gkTtRRqIqd4M9Yh3IwvnDV8LKw/fbIFBWv66A2DvxLSW/2MLpjAiEnOZIi0wCOsyFxEBRvtJB496ycnIJcLqcW+i9Jz2KES5p3+HYrHsnqKb9hjM5u4h/4XpplhXethCsCc3WRsZz4VvgO+umbTYGXTiOfihPbqE+pK8gk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(316002)(54906003)(8936002)(2906002)(26005)(186003)(5660300002)(2616005)(8676002)(6512007)(4326008)(38100700002)(66476007)(66946007)(6506007)(53546011)(36756003)(66556008)(41300700001)(31696002)(6486002)(31686004)(83380400001)(86362001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tnl5UTBKaDRSVitaZVV0QUVsaVU2K2twUTViZXVjSEEzeDZDSDZoVXFZS0l4?=
 =?utf-8?B?czg0UVNXUGdVTFh0cnZxUTNHSzVOd1F5Z21zZkVLd3Fid2s5dWRtbkJ0dnVJ?=
 =?utf-8?B?WUpFYWpXaDZOZ293d01VdDhQdlIrOFBiOGtlSVBWQ1gwMlFrNnNMS1RxZTFW?=
 =?utf-8?B?S2ljclVCbitoWk90aHVBNTNzSmdsMGJTYzY3TG9UWFFpMlR5VnQ3d2ZFS2VR?=
 =?utf-8?B?NzFETDNESmtEbk1iQVZSWitVeE5UdFdRRGlMWUt5UWZ1eE9YMkp4VkJWMktQ?=
 =?utf-8?B?cExESkNyYXZjTytMbG51WGZMUlBrbXlVQ0lTbEhWcXpPRXpNVG01UmQ1VnNJ?=
 =?utf-8?B?ald0MWVGSkRpbVhkbkl4RFQxQmg5b1BTVHlnaHdtb3hzb3RIakxyZHRuTkh3?=
 =?utf-8?B?STBqUHhwMGpWMkRkNmI1RWV4cEhmK2dOa2pwTkxhN1doWDhoRmtOMFhkYkNv?=
 =?utf-8?B?NS9PRjhiMWRZQnM5dUlCQ2JDNURGMWgxZTZrUXhoV3BKWVNCZlJKUGhCczNB?=
 =?utf-8?B?VnVralJOTEIxMCsvVXgzems0U3R3TlhSYitIeXhrS2NzeXdSSXZpSG81OWpi?=
 =?utf-8?B?bFNaRENsZ0dnMUg5Y2hNTzdvenZzT2U4UTRnMCtYQ3hrRUtnM3pNalV2d1pi?=
 =?utf-8?B?cndtdUJ6UVVwR0FFS0NaVnlvVUNkbzBOdTNnVHN1dElveVZ3MFQzbG83Ui9v?=
 =?utf-8?B?UENHY045d0t0UXpuR0hmWHVDNnJ2NnZkWlFLY3RBTENKZDFpWTdoNTAxcmJn?=
 =?utf-8?B?ZytTT0tUczdLaUJVMzR5clhzQ2dEVFBENmlXd2g3cWZHb2FyVFpYYkJRZy96?=
 =?utf-8?B?Z3dpQUR5VUl0enRDTXpUSWkzb3pabG1ubWRCRExUUU04OFZIMnJsL2VUYVZP?=
 =?utf-8?B?cVVKaFBZWjFtRk0wU3hRZjN1dVE4ZWVjTWx4aFRNRlVrYzY4K0VlVUxJblhW?=
 =?utf-8?B?a21YWXE1RjYxOHBQVlJCbjhySGx5emU4Y0F3N09NQ1J2MUdWOUczM0NtQTF1?=
 =?utf-8?B?MFpnTWFUdzFFRmZDVTdLUnRmak9kREczM1k1dVdzSWdTbm1DNmJUUEoyamMy?=
 =?utf-8?B?Q2gxYVJ5ZzV4cDhjeTM3NFd4bXRBRWozZ211TzdQU01Id3htLzcrSlpQSDVx?=
 =?utf-8?B?bnN1SGxlaE5XMTdoelBvMFJuZjREdElxZlZ0NHZrS0xMZE1yQ0wyOEhDUks2?=
 =?utf-8?B?VmxwVjJHOVBwT2ZsSFdaK25Bd2NTbjl0RE1EWCtLT2lzSmhrbkZFdTQvaVpx?=
 =?utf-8?B?bUx4NzhHOWpweEt6ZUtlTDJFUXU0Y2o0ZUUwMEQ1aWs1Sjg3ems0dmVkc2Jr?=
 =?utf-8?B?YWRLMUw3T1FpWkhieWVxMGpoc2Z1VmhzeG92Wlkva292NFBLOGl2dy93TzBO?=
 =?utf-8?B?VjdVQUp4UVY3SUorRkloU1VWa1hCa0poTDdua3F5SmZSU3FINWFxZFZhbnJ3?=
 =?utf-8?B?cis2ekc2bktKQ2JLUXFNMFhxNXR5WG9KbG0yU3NoR0x3azFjcWd2UnpwaC8z?=
 =?utf-8?B?OGx1amJsQW11Ty9YQUJrT0U3SHFmSHJxdngxSWFXS0dCRzV3RE0zb0hRc2tQ?=
 =?utf-8?B?eXd2eDNNOTd6aC9iYW5SenRKMnY4K3hyanpmdWhEcEgwcU5zdVVvZ1VBNHIx?=
 =?utf-8?B?aWc3ZXVha1lhRUtiMk5YcW01VlpUYzBRSnBWKytlenJJMjIzQ2xjKzY4WWsv?=
 =?utf-8?B?dTdGSWxXeW94ZTF6cnZ4a3FqNXFOeFluNDhMekhhcW4zY0MrQUZlQStKVCt6?=
 =?utf-8?B?YlFDV3RPRlRTUVFLd2RCVklFeERtTWJPUUVtdnNGUFppQmFEaU93SzFmODlr?=
 =?utf-8?B?OEpuMytVemFxY3NONzZieHl5Z3dCd0ZlL0hvbDk4dFZKVkJzRHpoTHRwUnpl?=
 =?utf-8?B?RE84dHJEcDM4UkJlOTJNcS91T0x5eTBRUjdtZ2RQeTMzVzQ3M1BjRDk5Y1Vw?=
 =?utf-8?B?c1djN0RuRGVGOHVPa0lLMk13eEMrQ1F6SkJueXpiV3RnZnJTSitRNHBtcElE?=
 =?utf-8?B?WTRubGtsNVZPczdBS2Zqdmlwdmh5bzI0djZJZGR2aDlSSkorUnY2ZllHRDhH?=
 =?utf-8?B?Z2IxOEtKUXhKYi9wNktzOW9CemJHWGwzc3VVL0pTalo3SGxWSEM4a1dKUi9z?=
 =?utf-8?Q?Agvq9h/mp8ykgQMoiBkOba4ny?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b99fc6-0473-42a2-d743-08daad6627c8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 21:59:09.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfH5qTp5Sy99O6cwgeIBmHYSgdExLoPMsj0QJdydj3TNcfTbxMxM69q9fnGVAulcbr82xtBSq8Ofn019mJJeRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 11:00, Dionna Glaze wrote:
> The GHCB specification states that the upper 32 bits of exitinfo2 are
> for the VMM's error codes. The sev-guest ABI has already locked in

I will have to update the GHCB specification for SNP Guest Request and SNP 
Extended Guest Request for this change. I believe that there isn't an 
impact from a backwards compatibility since software should be checking 
for specific values for success or the need for additional memory.

Adding a (new) return code will result in an error return for older 
software, which is ok.

> that the fw_err status of the input will be 64 bits, and that
> BIT_ULL(32) means that the extended guest request's data buffer was too
> small, so we have to keep that ABI. This patch deprecates the fw_err
> field name in the request to exitinfo2.
> 
> We can still interpret the upper 32 bits of exitinfo2 for the user
> anyway in case the request gets throttled. That makes the interface more
> user-friendly.
> 
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 34 +++++++++++++++++--------
>   include/uapi/linux/sev-guest.h          | 17 +++++++++++--
>   2 files changed, 38 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index f422f9c58ba7..8bc435cbd7e3 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -303,9 +303,10 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
>   
>   static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
>   				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
> -				u32 resp_sz, __u64 *fw_err)
> +				u32 resp_sz, __u64 *exitinfo2)
>   {
> -	unsigned long err;
> +	unsigned long _exitinfo2 = 0;
> +	unsigned int vmm_err;
>   	u64 seqno;
>   	int rc;
>   
> @@ -322,9 +323,20 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   		return rc;
>   
>   	/* Call firmware to process the request */
> -	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> -	if (fw_err)
> -		*fw_err = err;
> +	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &_exitinfo2);
> +	if (exitinfo2)
> +		*exitinfo2 = _exitinfo2;
> +
> +	vmm_err = _exitinfo2 >> SNP_GUEST_VMM_ERR_SHIFT;
> +	/* The host may return EBUSY if the request has been throttled. */
> +	if (vmm_err == SNP_GUEST_VMM_ERR_BUSY)
> +		return -EAGAIN;
> +
> +	if (vmm_err && vmm_err != SNP_GUEST_VMM_ERR_INVALID_LEN) {
> +		pr_err("sev-guest: host returned unknown error code: %d\n",
> +		       vmm_err);
> +		return -EINVAL;
> +	}
>   
>   	if (rc)
>   		return rc;
> @@ -378,7 +390,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>   
>   	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
>   				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
> -				  resp_len, &arg->fw_err);
> +				  resp_len, &arg->exitinfo2);
>   	if (rc)
>   		goto e_free;
>   
> @@ -418,7 +430,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
>   
>   	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
>   				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
> -				  &arg->fw_err);
> +				  &arg->exitinfo2);
>   	if (rc)
>   		return rc;
>   
> @@ -480,10 +492,10 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
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
> @@ -518,7 +530,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>   	if (copy_from_user(&input, argp, sizeof(input)))
>   		return -EFAULT;
>   
> -	input.fw_err = 0xff;
> +	input.exitinfo2 = 0xff;
>   
>   	/* Message version must be non-zero */
>   	if (!input.msg_version)
> @@ -549,7 +561,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>   
>   	mutex_unlock(&snp_cmd_mutex);
>   
> -	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
> +	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
>   		return -EFAULT;
>   
>   	return ret;
> diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
> index 256aaeff7e65..0654a652e4dc 100644
> --- a/include/uapi/linux/sev-guest.h
> +++ b/include/uapi/linux/sev-guest.h
> @@ -12,6 +12,7 @@
>   #ifndef __UAPI_LINUX_SEV_GUEST_H_
>   #define __UAPI_LINUX_SEV_GUEST_H_
>   
> +#include <linux/errno.h>
>   #include <linux/types.h>
>   
>   struct snp_report_req {
> @@ -52,8 +53,15 @@ struct snp_guest_request_ioctl {
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
> @@ -77,4 +85,9 @@ struct snp_ext_report_req {
>   /* Get SNP extended report as defined in the GHCB specification version 2. */
>   #define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_guest_request_ioctl)
>   
> +
> +#define SNP_GUEST_VMM_ERR_SHIFT		32
> +#define SNP_GUEST_VMM_ERR_INVALID_LEN	1
> +#define SNP_GUEST_VMM_ERR_BUSY		EBUSY

The GHCB spec has to be OS agnostic, so in the specification I would be 
adding a value of 16 so that this matches. Not sure we don't want to just 
use 2. We might be able to say the VMM error codes will follow the POSIX 
standard, but then the currently defined value of 1 doesn't quite match an 
EPERM.

Thoughts?

Thanks,
Tom


> +
>   #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
