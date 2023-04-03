Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1F06D511A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjDCTJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDCTJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:09:55 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4988D2720
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 12:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCcJ/Dkog2Th+OV6zw04g1LcSIedOg8OSstUS40MMpU8draBsmpwG8ukMrpAe8+iG2N9uN98v3n9HM8xeJwXDTVaXpSPmCuZVq2k910klGXsJo5D1mYre4a1vZ8SiLWXr7tRnaSK0NeZjITSYkzGBv12yUmT4E0CNTh9VG/bKTry3eY8W0sDAcAZhHa85Rzoz9fc9JRUF0Gh4R+CWBHu9Ft9enW815fk+a9KEwZXgOOwfQgdYAzexANzkI8FXID/YfQVk9AAsG9dm1cuJXNKfrFhjSctczf79zyb8hthVCIng3At3IEDvGw76Clnu3B/OvvFx0dF3bKEmz9CYLj/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gprkeOGwJxBi4jDMYDpPoeqYgk8z1y1BwcmVS6TnpFY=;
 b=OhChA+5stJH4v85DOhzjr7HrZELtxiqdVtp/PO7vr2leBieCG229QWVyHQFyuNEHJmLMNWtpNHbVDH+AJ2vPYWwoNfw0Zsgm9XZa/JbOJJT7KcpzxPXfvU76JGfo2vXQeOI+rAo+8Rz1QUuGgPwF7hY18NasFu1/iynlcCu/XsPt1yc/KCRc9DeiGhzj5kxpM0l9NLBI/p34Qh8I1q8EWcBdTaxGqWoKucNT6bPK1/H5KYQdte4OrxXXgWzzg+ClLd76a75ZwlURQOVCQyse+vBnNXGtyaegxHC7FGarjMX0LatXNDv3ZZs2jssNFeZVGGZObPrd5hs34uvbN74eCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gprkeOGwJxBi4jDMYDpPoeqYgk8z1y1BwcmVS6TnpFY=;
 b=w6bx/LFQCSAq6oNy2sYIXNjpBwJd+oBV+akB6GRjjYydNXZkaPzXEanL/38akTcGSn73kS5PBX0l6ih2Cr/9OTrL65MnjvArj9+p1BMNtY8+CvERswlYhOoP5PmAet64GzdiGX0DEMQHINDu+3MHd6Q2wBtEMYl6SH+AIzEfmLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 19:09:50 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 19:09:50 +0000
Message-ID: <aad853e5-2c82-c26d-da3f-f201ba1125a6@amd.com>
Date:   Mon, 3 Apr 2023 14:09:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 01/11] virt: sev-guest: Use AES GCM crypto library
Content-Language: en-US
To:     Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-2-nikunj@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230326144701.3039598-2-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::15) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CY5PR12MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0812c3-4134-45d3-541d-08db3476ffca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ovnKmkcMW5B7SA6qGq/1UEaZ6KDKb4bznNxkABRy7GD6a+TxHg53uZzTsDVasU+cKcmx2O+y9D2keJpdI6UOjtaN+0d7TsUEIRSFGlYbTG/wRhFv/bZc9eXpCJq3mrym6D4GzLOoa4G0IfH2GyswPXVNCDZp8VnWM0Uu2s0iORF3YglhlOYQCATHFhSFWAJrY1QfgzsH4+87C/lhn/dfJI1RGuWhGdh0SgPwhgFlYkQC6Z9FiXi5iQ2SchzhEiX/ngNrN9TkB4rprnP/k5UJcMeP5R2CTkkxyLDch+tMy+zP3DypE9NVuM1G6+BJt6mMKi4Ox7XQprrspOafH+tSbvqxGnYqm+GxziV5GW77+T4G8lkZH6uGq9nk/nP14ObxZcObxnHCrdml4b4JNOtbirKOtG3B1eRXnZuqZCv0JeKyYZajxjZ5UzO8jC5KsZLoMYI87OL7InE+839KWaM2KhDw+8QdRDbrV5laBNGj7GBoXHdfD4p8rgogiHQLGNhgubmt53Z5VKblEevxqNqsUkTqe7s5PlNbJZVkMYDBFWLNcWEGn2L/3oOQlXU7q+2E05KsrbwglzkhTYTQ1reo/oqjjkHNpCEzF8ld0oEd78ZcMctWHNeac1TGeNe3ev+YpGwtL3rg2pppy/nMiEBs3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(41300700001)(38100700002)(8676002)(66556008)(66476007)(66946007)(8936002)(5660300002)(316002)(31686004)(4326008)(478600001)(31696002)(2906002)(30864003)(83380400001)(86362001)(186003)(966005)(2616005)(36756003)(6486002)(6506007)(6512007)(26005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVpUWC9WK1djL1c1eWdvdVRodjR3aW05YzRpNFZrRC83TlRwSmdLV2xHQjdm?=
 =?utf-8?B?RFBrRk5BaXJ4M3A3UDV4OXpuRUIzbWp2ZFpaUHg3c0htYlEvaWdpTnRuVktY?=
 =?utf-8?B?NjNDWWxUbzNaNmx0TkhvL21IVUxSeTk5THMyaDV6TGx6VzQrejZpNUFURVpn?=
 =?utf-8?B?ZjhpcVB3SHZkdlhCWXFQcTFkWldVb0JQanhXS0tZZ3dTL2RiY2ZKQzY1NXdn?=
 =?utf-8?B?eHNpTmFYcGhnN3ZEOTVZWm9sUVQ2VUZxZ1pTTzNwKzVxYk1mNnVtckx6ZDIw?=
 =?utf-8?B?TUVQMWg3d2ZEMWNtWkFRV3NmN1VtVlNQRnZUS29QR3NZZ3NMbE5oNmJWNkNu?=
 =?utf-8?B?UTJ4Q3M5MncrZCtGUG1iRzl0WkpwSWxGTW9hL2E2QUs5aW9Cc2N2SmRRNU5t?=
 =?utf-8?B?ZFFKTzZ6THRmd0tCb0pLcWJpcStGSXFuQWhhNVdwbnhCUXkvZ3IvOFhLMlIy?=
 =?utf-8?B?THRZUG82K1QyVXR2L3lnMEV1UzliN002ZXpWK0M2bW9jSFA0QU5zVUZCckUw?=
 =?utf-8?B?UUxtcHBnZTUwcXdMS2c3MWJQdW8vL3FSMlhKMWZRRkhPUGZXc0ZBeEVFRDFD?=
 =?utf-8?B?WWl2Q0czRGs1dVUyckRqUE9iQ1VrbGRPTndhVndvMkN1d0VXOFhBR1VlNXV3?=
 =?utf-8?B?WFJPYUdZZ0MxU3M0T1dodFBYVTFMOGR2bFh3NXAra0RkdEx3aEl1OEhOcUlM?=
 =?utf-8?B?bUVMVUdkVGIwdWdieHM3VHp2dHNIcjI2ZTNFU2ZBNG9CcEZsYjkrbHlzOFkv?=
 =?utf-8?B?RXhjM0gxVHNuekNiRFkveHpOczNHeXV0c3lqTHBIQ0luN0pQcDNVc2o3MkVQ?=
 =?utf-8?B?ZTR4b2lKOTFFU2c0L1lnU0x1cHphSk05SC9kRlNNS0Q5SmhBVEZPSDBUSGVU?=
 =?utf-8?B?SnViTDhadjRKdHF6cnBHOHI4VHdwd1lUTzRPeXY1Ymw3b2lqeUlqRUR4c1p3?=
 =?utf-8?B?M3lYS0o1WE9RYThrZGNGblByaVd5bzh3OVBVVXlwR05Hd1NkTG0weVM3TStn?=
 =?utf-8?B?MTNsY3lLQi9aMk1uK0ljS3drTEJ0dEhXZWc0OVMyNldMNlBPOGNUYWVLR2hJ?=
 =?utf-8?B?SE8yOG01eVlnaEF3WDljL2dxODd4VjNhOWFsVEdmSHlld2x1NnBST3FINjlU?=
 =?utf-8?B?NDNLci9mU2k5eU85ZlgzWDQ1cGxQYVh0MEtOelFCQklNSVVnNCtNWW9mL2s0?=
 =?utf-8?B?MTRhdUdnQ2tKRmxFOXg0QWh4bWtWWEN2NGllVStrLzE5T2pvdytVWHFtY3ZF?=
 =?utf-8?B?dk9OZ05SMUJxM1F1TDYvQ1JKcUNPQ0ZFQnFnL2RrSEJlL0tOVzhWbi9WTWhO?=
 =?utf-8?B?cUpjNTZLdGZKSHVGWTFXSVZQMGN3WjV3SlI3cyt5NWtoQUp4a2pRRStRT3Rv?=
 =?utf-8?B?WnllMWdLNlM4WGZET0RwaWpqb1pEQ1gxOEFaZHZUOWNSMUJSSWFDQ1U4ZVk2?=
 =?utf-8?B?dDVjMzBBaCtLQ0pOMTdILzlZTUVYbUJqZFFUL0RpQnRZcmZrWng5ZmwwOFZz?=
 =?utf-8?B?b1NITDZKaVpWdTlVUlF2NnRPb0dDdC9Rc0xKTHZSWnVxMWpLV0xTUGxNT0dU?=
 =?utf-8?B?ZjJ5NU5qMHRxUXdEblVKWVM5bW1TbjJ0M25nYTdDcXRscnN4TFBLZUUyVmVv?=
 =?utf-8?B?RzRScEEvbWJiYUd5WEYvQmtOWjlydGlvNDRxTkxlb2xpWkM2aWhMTy9nSHZT?=
 =?utf-8?B?TzZaQVp1UDdxclJ3bzBaeWYrVXk4Tm5rbUtyNVJTQUNzOWRDeDJQNWttVjFV?=
 =?utf-8?B?TjY5RmdYQWNMbit1cXNhNVF1cmE3N0lZSnlrKytXeHo2Y09VUkJid0l2S1Rp?=
 =?utf-8?B?Wi9zMm9VTHc0Zkh2YVJHSmFKNy9iNndra01OSnhjMXVqQ3M2OEhyWWJqR0tR?=
 =?utf-8?B?YWtmenNLL293MUo5UXRrczd0OHBTVTdhbW10QVhTNVdqUndobkNBbGR3ZjJZ?=
 =?utf-8?B?aEdiWTFGUnVwdUlIZ25LOHpKbTRSOGw3bFJvekVUcEEvMkQ3UkJ2bVk0cUdx?=
 =?utf-8?B?cXRuZzZCR0lXdG1STTdOWkRKV3VSa0tORHoyL3lzMHFIaFRkVytUWkV5Z0dx?=
 =?utf-8?B?MWVEOGdqZGduN3dzNnlvZ1dlWEFGZFpOM2Vud3R1WXVlTXJxSkticUx0ek5p?=
 =?utf-8?Q?Bhtndbrmyz1yDKq/Uo+LRAWnH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0812c3-4134-45d3-541d-08db3476ffca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 19:09:50.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZdoVx3zRWj7WLTwRHYM/6/7Ibqsc7iyUViTW4hRBAcO3TH4E4+OzMrUWOj0gSjHj5FHF5jNsMeuNtr/ApOI/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/23 09:46, Nikunj A Dadhania wrote:
> SEV-SNP guests with SecureTSC enabled need to send a TSC_INFO SNP
> Guest message to the AMD security processor before the smpboot phase
> starts. Details from the TSC_INFO response have to be programmed in
> the VMSA before the secondary CPUs are brought up.
> 
> Start using the AES GCM library implementation as the crypto API is not
> available yet this early.

This isn't quite true, yet. You should add that the encryption code will 
be moved out of sev-guest to support Secure TSC, but to make the diffs 
easier to review, convert the Crypto API usage over to AES GCM library 
usage before moving it.

Thanks,
Tom

> 
> Link: https://lore.kernel.org/all/20221103192259.2229-1-ardb@kernel.org
> CC: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> ---
>   drivers/virt/coco/sev-guest/Kconfig     |   3 +-
>   drivers/virt/coco/sev-guest/sev-guest.c | 172 +++++++-----------------
>   drivers/virt/coco/sev-guest/sev-guest.h |   3 +
>   3 files changed, 53 insertions(+), 125 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
> index f9db0799ae67..bcc760bfb468 100644
> --- a/drivers/virt/coco/sev-guest/Kconfig
> +++ b/drivers/virt/coco/sev-guest/Kconfig
> @@ -2,8 +2,7 @@ config SEV_GUEST
>   	tristate "AMD SEV Guest driver"
>   	default m
>   	depends on AMD_MEM_ENCRYPT
> -	select CRYPTO_AEAD2
> -	select CRYPTO_GCM
> +	select CRYPTO_LIB_AESGCM
>   	help
>   	  SEV-SNP firmware provides the guest a mechanism to communicate with
>   	  the PSP without risk from a malicious hypervisor who wishes to read,
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 46f1a8d558b0..57af908bafba 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -16,8 +16,7 @@
>   #include <linux/miscdevice.h>
>   #include <linux/set_memory.h>
>   #include <linux/fs.h>
> -#include <crypto/aead.h>
> -#include <linux/scatterlist.h>
> +#include <crypto/gcm.h>
>   #include <linux/psp-sev.h>
>   #include <uapi/linux/sev-guest.h>
>   #include <uapi/linux/psp-sev.h>
> @@ -28,24 +27,16 @@
>   #include "sev-guest.h"
>   
>   #define DEVICE_NAME	"sev-guest"
> -#define AAD_LEN		48
> -#define MSG_HDR_VER	1
>   
>   #define SNP_REQ_MAX_RETRY_DURATION	(60*HZ)
>   #define SNP_REQ_RETRY_DELAY		(2*HZ)
>   
> -struct snp_guest_crypto {
> -	struct crypto_aead *tfm;
> -	u8 *iv, *authtag;
> -	int iv_len, a_len;
> -};
> -
>   struct snp_guest_dev {
>   	struct device *dev;
>   	struct miscdevice misc;
>   
>   	void *certs_data;
> -	struct snp_guest_crypto *crypto;
> +	struct aesgcm_ctx *ctx;
>   	struct snp_guest_msg *request, *response;
>   	struct snp_secrets_page_layout *layout;
>   	struct snp_req_data input;
> @@ -60,6 +51,15 @@ MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.
>   /* Mutex to serialize the shared buffer access and command handling. */
>   static DEFINE_MUTEX(snp_cmd_mutex);
>   
> +static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
> +{
> +	if (snp_dev && snp_dev->ctx)
> +		return snp_dev->ctx->authsize;
> +
> +	WARN_ONCE(1, "Unable to get crypto authsize\n");
> +	return 0;
> +}
> +
>   static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
>   {
>   	char zero_key[VMPCK_KEY_LEN] = {0};
> @@ -144,132 +144,59 @@ static inline struct snp_guest_dev *to_snp_dev(struct file *file)
>   	return container_of(dev, struct snp_guest_dev, misc);
>   }
>   
> -static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, u8 *key, size_t keylen)
> +static struct aesgcm_ctx *snp_init_crypto(u8 *key, size_t keylen)
>   {
> -	struct snp_guest_crypto *crypto;
> +	struct aesgcm_ctx *ctx;
>   
> -	crypto = kzalloc(sizeof(*crypto), GFP_KERNEL_ACCOUNT);
> -	if (!crypto)
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
> +	if (!ctx)
>   		return NULL;
>   
> -	crypto->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
> -	if (IS_ERR(crypto->tfm))
> -		goto e_free;
> -
> -	if (crypto_aead_setkey(crypto->tfm, key, keylen))
> -		goto e_free_crypto;
> -
> -	crypto->iv_len = crypto_aead_ivsize(crypto->tfm);
> -	crypto->iv = kmalloc(crypto->iv_len, GFP_KERNEL_ACCOUNT);
> -	if (!crypto->iv)
> -		goto e_free_crypto;
> -
> -	if (crypto_aead_authsize(crypto->tfm) > MAX_AUTHTAG_LEN) {
> -		if (crypto_aead_setauthsize(crypto->tfm, MAX_AUTHTAG_LEN)) {
> -			dev_err(snp_dev->dev, "failed to set authsize to %d\n", MAX_AUTHTAG_LEN);
> -			goto e_free_iv;
> -		}
> +	if (aesgcm_expandkey(ctx, key, keylen, AUTHTAG_LEN)) {
> +		pr_err("SNP: crypto init failed\n");
> +		kfree(ctx);
> +		return NULL;
>   	}
>   
> -	crypto->a_len = crypto_aead_authsize(crypto->tfm);
> -	crypto->authtag = kmalloc(crypto->a_len, GFP_KERNEL_ACCOUNT);
> -	if (!crypto->authtag)
> -		goto e_free_iv;
> -
> -	return crypto;
> -
> -e_free_iv:
> -	kfree(crypto->iv);
> -e_free_crypto:
> -	crypto_free_aead(crypto->tfm);
> -e_free:
> -	kfree(crypto);
> -
> -	return NULL;
> +	return ctx;
>   }
>   
> -static void deinit_crypto(struct snp_guest_crypto *crypto)
> -{
> -	crypto_free_aead(crypto->tfm);
> -	kfree(crypto->iv);
> -	kfree(crypto->authtag);
> -	kfree(crypto);
> -}
> -
> -static int enc_dec_message(struct snp_guest_crypto *crypto, struct snp_guest_msg *msg,
> -			   u8 *src_buf, u8 *dst_buf, size_t len, bool enc)
> -{
> -	struct snp_guest_msg_hdr *hdr = &msg->hdr;
> -	struct scatterlist src[3], dst[3];
> -	DECLARE_CRYPTO_WAIT(wait);
> -	struct aead_request *req;
> -	int ret;
> -
> -	req = aead_request_alloc(crypto->tfm, GFP_KERNEL);
> -	if (!req)
> -		return -ENOMEM;
> -
> -	/*
> -	 * AEAD memory operations:
> -	 * +------ AAD -------+------- DATA -----+---- AUTHTAG----+
> -	 * |  msg header      |  plaintext       |  hdr->authtag  |
> -	 * | bytes 30h - 5Fh  |    or            |                |
> -	 * |                  |   cipher         |                |
> -	 * +------------------+------------------+----------------+
> -	 */
> -	sg_init_table(src, 3);
> -	sg_set_buf(&src[0], &hdr->algo, AAD_LEN);
> -	sg_set_buf(&src[1], src_buf, hdr->msg_sz);
> -	sg_set_buf(&src[2], hdr->authtag, crypto->a_len);
> -
> -	sg_init_table(dst, 3);
> -	sg_set_buf(&dst[0], &hdr->algo, AAD_LEN);
> -	sg_set_buf(&dst[1], dst_buf, hdr->msg_sz);
> -	sg_set_buf(&dst[2], hdr->authtag, crypto->a_len);
> -
> -	aead_request_set_ad(req, AAD_LEN);
> -	aead_request_set_tfm(req, crypto->tfm);
> -	aead_request_set_callback(req, 0, crypto_req_done, &wait);
> -
> -	aead_request_set_crypt(req, src, dst, len, crypto->iv);
> -	ret = crypto_wait_req(enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req), &wait);
> -
> -	aead_request_free(req);
> -	return ret;
> -}
> -
> -static int __enc_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
> +static int __enc_payload(struct aesgcm_ctx *ctx, struct snp_guest_msg *msg,
>   			 void *plaintext, size_t len)
>   {
> -	struct snp_guest_crypto *crypto = snp_dev->crypto;
>   	struct snp_guest_msg_hdr *hdr = &msg->hdr;
> +	u8 iv[GCM_AES_IV_SIZE] = {};
>   
> -	memset(crypto->iv, 0, crypto->iv_len);
> -	memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
> +	if (WARN_ON((hdr->msg_sz + ctx->authsize) > sizeof(msg->payload)))
> +		return -EBADMSG;
>   
> -	return enc_dec_message(crypto, msg, plaintext, msg->payload, len, true);
> +	memcpy(iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
> +	aesgcm_encrypt(ctx, msg->payload, plaintext, len, &hdr->algo, AAD_LEN,
> +		       iv, hdr->authtag);
> +	return 0;
>   }
>   
> -static int dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
> +static int dec_payload(struct aesgcm_ctx *ctx, struct snp_guest_msg *msg,
>   		       void *plaintext, size_t len)
>   {
> -	struct snp_guest_crypto *crypto = snp_dev->crypto;
>   	struct snp_guest_msg_hdr *hdr = &msg->hdr;
> +	u8 iv[GCM_AES_IV_SIZE] = {};
>   
> -	/* Build IV with response buffer sequence number */
> -	memset(crypto->iv, 0, crypto->iv_len);
> -	memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
> -
> -	return enc_dec_message(crypto, msg, msg->payload, plaintext, len, false);
> +	memcpy(iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
> +	if (aesgcm_decrypt(ctx, plaintext, msg->payload, len, &hdr->algo,
> +			   AAD_LEN, iv, hdr->authtag))
> +		return 0;
> +	else
> +		return -EBADMSG;
>   }
>   
>   static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
>   {
> -	struct snp_guest_crypto *crypto = snp_dev->crypto;
>   	struct snp_guest_msg *resp = snp_dev->response;
>   	struct snp_guest_msg *req = snp_dev->request;
>   	struct snp_guest_msg_hdr *req_hdr = &req->hdr;
>   	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
> +	struct aesgcm_ctx *ctx = snp_dev->ctx;
>   
>   	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
>   		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
> @@ -287,11 +214,11 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
>   	 * If the message size is greater than our buffer length then return
>   	 * an error.
>   	 */
> -	if (unlikely((resp_hdr->msg_sz + crypto->a_len) > sz))
> +	if (unlikely((resp_hdr->msg_sz + ctx->authsize) > sz))
>   		return -EBADMSG;
>   
>   	/* Decrypt the payload */
> -	return dec_payload(snp_dev, resp, payload, resp_hdr->msg_sz + crypto->a_len);
> +	return dec_payload(ctx, resp, payload, resp_hdr->msg_sz);
>   }
>   
>   static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
> @@ -318,7 +245,7 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
>   	dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
>   		hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
>   
> -	return __enc_payload(snp_dev, req, payload, sz);
> +	return __enc_payload(snp_dev->ctx, req, payload, sz);
>   }
>   
>   static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, __u64 *fw_err)
> @@ -446,7 +373,6 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   
>   static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
>   {
> -	struct snp_guest_crypto *crypto = snp_dev->crypto;
>   	struct snp_report_resp *resp;
>   	struct snp_report_req req;
>   	int rc, resp_len;
> @@ -464,7 +390,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>   	 * response payload. Make sure that it has enough space to cover the
>   	 * authtag.
>   	 */
> -	resp_len = sizeof(resp->data) + crypto->a_len;
> +	resp_len = sizeof(resp->data) + get_ctx_authsize(snp_dev);
>   	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
>   	if (!resp)
>   		return -ENOMEM;
> @@ -485,7 +411,6 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>   
>   static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
>   {
> -	struct snp_guest_crypto *crypto = snp_dev->crypto;
>   	struct snp_derived_key_resp resp = {0};
>   	struct snp_derived_key_req req;
>   	int rc, resp_len;
> @@ -502,7 +427,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
>   	 * response payload. Make sure that it has enough space to cover the
>   	 * authtag.
>   	 */
> -	resp_len = sizeof(resp.data) + crypto->a_len;
> +	resp_len = sizeof(resp.data) + get_ctx_authsize(snp_dev);
>   	if (sizeof(buf) < resp_len)
>   		return -ENOMEM;
>   
> @@ -527,7 +452,6 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
>   
>   static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
>   {
> -	struct snp_guest_crypto *crypto = snp_dev->crypto;
>   	struct snp_ext_report_req req;
>   	struct snp_report_resp *resp;
>   	int ret, npages = 0, resp_len;
> @@ -565,7 +489,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   	 * response payload. Make sure that it has enough space to cover the
>   	 * authtag.
>   	 */
> -	resp_len = sizeof(resp->data) + crypto->a_len;
> +	resp_len = sizeof(resp->data) + get_ctx_authsize(snp_dev);
>   	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
>   	if (!resp)
>   		return -ENOMEM;
> @@ -777,8 +701,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>   		goto e_free_response;
>   
>   	ret = -EIO;
> -	snp_dev->crypto = init_crypto(snp_dev, snp_dev->vmpck, VMPCK_KEY_LEN);
> -	if (!snp_dev->crypto)
> +	snp_dev->ctx = snp_init_crypto(snp_dev->vmpck, VMPCK_KEY_LEN);
> +	if (!snp_dev->ctx)
>   		goto e_free_cert_data;
>   
>   	misc = &snp_dev->misc;
> @@ -793,11 +717,13 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>   
>   	ret =  misc_register(misc);
>   	if (ret)
> -		goto e_free_cert_data;
> +		goto e_free_ctx;
>   
>   	dev_info(dev, "Initialized SEV guest driver (using vmpck_id %d)\n", vmpck_id);
>   	return 0;
>   
> +e_free_ctx:
> +	kfree(snp_dev->ctx);
>   e_free_cert_data:
>   	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
>   e_free_response:
> @@ -816,7 +742,7 @@ static int __exit sev_guest_remove(struct platform_device *pdev)
>   	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
>   	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
>   	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
> -	deinit_crypto(snp_dev->crypto);
> +	kfree(snp_dev->ctx);
>   	misc_deregister(&snp_dev->misc);
>   
>   	return 0;
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.h b/drivers/virt/coco/sev-guest/sev-guest.h
> index 21bda26fdb95..ceb798a404d6 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.h
> +++ b/drivers/virt/coco/sev-guest/sev-guest.h
> @@ -13,6 +13,9 @@
>   #include <linux/types.h>
>   
>   #define MAX_AUTHTAG_LEN		32
> +#define AUTHTAG_LEN		16
> +#define AAD_LEN			48
> +#define MSG_HDR_VER		1
>   
>   /* See SNP spec SNP_GUEST_REQUEST section for the structure */
>   enum msg_type {
