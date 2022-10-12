Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EF35FCEFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 01:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJLXjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 19:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJLXjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 19:39:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846E8103241
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 16:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwJKezYCt6fJNlYddgvLSRdzAMuwn5Z4G52xsr6YyaDjdiT9I8y5EQbxN631Oj9aLRrmVg3DW5TpSgur3Sz9+H7SWqQkKx48rw+4esS/+/B89c3ogeT+3JsePwnwA38dtMCsD+f7+/e5IvMbNUAa4w4fYPXg8o7EsyidiNJ3AiufrzmbgVmObQEHEv9pJa4uCzvWLUB3qJDWJln6w/6eTTNSVR8NuuEOVE/lY0ZPEfr7fpMvdYbcw3m1cj43Jd71PJIfKG/6/7IdsUJRAcwednnMuvbadHP7IoPr1VUXJ3ZADe+etMRFKduL0fG2S8Dip6byhwBKE0nhFpJrJpeToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjpX/jIkmQoGoYab1wxpW7y3QgNf4qnQgQdoDPq9XWk=;
 b=FgRsGEoV/TfHMRBmUW85lQBLCDJzwgAPMODA+bfwptheFitD991YQe+PqvTn07fS4QmJ1Ocre5z5VUsEni/Yzd5cGwqaoN8bfTZb3E+1GdGos2XjLUWvMD+O9jLq6RUnx+jcoZuDcOYcx1RJBS6efHWPRsN0eudzkuIkIT5yd6PtM/nMdaWTG/Ye4M/ODNlJLh+Vf4f7yeneL+vmUy/yil0+ANY4INK7lXy0eiBPAdmN7OKJLPRkF64OrTHWkFwqjayUl0exNiUPt0X/7o481n7WxKpUsYYdyflcELN3KPQf2VzOWn08VB+N410wJV6oO7tI+igC4J5QoX0F18xk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjpX/jIkmQoGoYab1wxpW7y3QgNf4qnQgQdoDPq9XWk=;
 b=khzUcHQEtD+ZzRoQcrz2jHBaALzbYaAX8yuR8xwUxa8c6/Ybia5cNncrqKl0HvdvnkDVOttkhRQc7eHQcKeVfJEkJbcGPHI3YfMzyjLDjUEt4oEqEQkXPqGHjncVmpXC9YzaQji3jWHvAdBK448QxFSRXSreNCT3ZBj8nc+FAA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Wed, 12 Oct
 2022 23:39:18 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::b3f1:abb4:f311:5193]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::b3f1:abb4:f311:5193%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 23:39:17 +0000
Message-ID: <669cedbc-e127-92ba-2e98-e0460b45bd4d@amd.com>
Date:   Wed, 12 Oct 2022 18:39:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/2] x86/sev: Add KVM commands for instance certs
Content-Language: en-US
To:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20220902000439.875476-1-dionnaglaze@google.com>
From:   "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20220902000439.875476-1-dionnaglaze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:208:23e::33) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 9017267a-db03-473e-8cb7-08daacaafa44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eEQY/kdI5OTiaABpDdaeVCjhu33SbPCsEQJsXOSbd8JuzUTFESEss85dqSxQgjgD4hGA23YCeuWUihs+JCNmmIsysw+t6d8R+C/Dmakj3rB3T5XB7uwp7V3OhfyQ+U3fDPs0PDOvPlYTEiTWaXW4ej4CZ1LITKdvetyqmWhLZoycv+oMeH8wORkJ/rMDQd3jl8Is3FiIcUrdaPP8yQGBXGYIrZkf/kyqeoI6s3sOTLeCpDorU/lcVweiZ0IcEyJuBjj0dkKbcjyfvA731UxTiWypFcK/IUTgUn/ZSw8aaX0mU4bIVOYiMd9UmylHJruoas3z83P3/9kEOw0g7LZYuFFOas7MOj8QQHuth2f9wqfqQ294BjjY6xY+BhLFvnuuQZkOz9Us6A9xRt5iBSfZWHWhLVWqjCVDicd8Owm8pIm5eNMRTnYQpf0XELMQ8RrJKMd185P+/ycEzFXJKGj6rUNqvCTj8CiAbUlXUP+sHgd2ojKkUJdse+6KowGQ/OFLi2hlIeLHYv5j508R0dpPZwnRlgmcBosCLxBSDNdOr1+O32ugkV1wgu5QsezVcyRVyxsPqkFAfcQvAAdp9EA58r8puYICvEiTX7pu+yJyNZ8nqSKezFP5uPd2LYdEdQaBBzJmYkfZjvdaLwAMDIrrkB1IgcmvC6NTTwO7T8IB+LzeaW8EPTxNOixmmugWF5aFU3owKkApjVmxra6myDLE2vLnB9tpQKQP0wMATAMyDfhLdlc9J7LZIn4j8UsKkH/zf1O3gjA/Yb2pjoEMM6VC76lqMBogIqfeJUy3iQVsvmk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199015)(36756003)(31686004)(31696002)(5660300002)(38100700002)(41300700001)(2616005)(186003)(86362001)(2906002)(53546011)(6506007)(6666004)(26005)(6512007)(8676002)(6486002)(478600001)(54906003)(316002)(83380400001)(66946007)(66556008)(66476007)(8936002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXZobzNQSHp5V1V2VDdaRTh4YmZhdktzb2hTWnFGbk1qOGtQMzJTNEJVOXJL?=
 =?utf-8?B?Vi9acGlXeFlNZ0JoVEdaem5yWVd6bDl4QUZtTC9KWkZHaHh4OS82WlQ2SjdB?=
 =?utf-8?B?dWhmQy9jVWVZZi91VmU3dW1YbkZZdHBuRk05d0xsYlErcFdUVUR3WFNKOWVJ?=
 =?utf-8?B?ZGtEOE1rNzcyNHlkY013eUFuWmNzM1JWamduRmg5Vm51ZDBGTEtFeG9DVkdm?=
 =?utf-8?B?aW9iczdPbWlUblIrQ3BZREtkSzNXcXhsZ3VudWRDQnp2ZXJtY0FzNEw4bTEw?=
 =?utf-8?B?SE1BMCtwbFptaHlUQUFTemxrcWdaRjI1eXJMTFZXSUh0R1ZxbGh4ZnpQTUpN?=
 =?utf-8?B?U1VnUEMwRS9KRU1HNUJLamVRek1aOG1UMm9JQVljK2RudERSdE5qdy84akgw?=
 =?utf-8?B?RGJnVmtHWnNWZ01aMkZoek5NeVlXZ2JJUWhYWWJZOG0vWkM0Z0xmU3lyOVZQ?=
 =?utf-8?B?MGZmaHFreGY0UmpFclFlNmFOMW9XTnpNNXBlTzFhZlU3QUp3eUlmN0NiTW8y?=
 =?utf-8?B?Y1BJRElMV0FIdGpyY0x3a2N5Qkt2MzhPZ3lPM2NHaU9ka0dONFJzUEdxc3k5?=
 =?utf-8?B?R0ZEUG1Qc1g3eTNUNjNjL1FWWGthZ2QwMkJvZGpSSUFWSWJVK2NTWWhiVnFs?=
 =?utf-8?B?emo4UE5MOUkvZStVbmQxRzkyaEFTbHZ0RFpGUm9zZmc0SDlNMUIzYk5xWmNr?=
 =?utf-8?B?YWt2SS8xdW5nV3NPR2VPeURjYlhDMmd0c2c4RDl2MWVkUERCUXRUTk05eE5B?=
 =?utf-8?B?RVdSQXYvaEUyTW5CeW13dEJsL3d2Tjh0ZFY3R3BkdVpNYmJPUnZnREY4aDJQ?=
 =?utf-8?B?SnMrUGljb0JCajNhWjg2Z2RoT1oyalZQYUNLNTY2eGJyazdBMmxrcGFVUi9I?=
 =?utf-8?B?cTJpZE5SL0hZMm5Gd3BkbGZGVTN1RTRHU0RTNXJjeHkvbVh4VmVpWlk0NHBw?=
 =?utf-8?B?d1RJeU5kb1p4ZmszeExNUFd0VFRNelZwaEYvemtTYVR4VkFLTGowVXgzdWpM?=
 =?utf-8?B?cXpDZmtnM2Z3R0ZuSkNqQjVQNTVSWU1RVU1ncU1KUVVwdEQxRHZrNVFvb1dT?=
 =?utf-8?B?blhLVVVCUmlGWUhxR1M2WTVuVnRKQ1ZVcXkwYTdKaTF2U3VZcENqZ284YjJN?=
 =?utf-8?B?c2ZCcWRIMUpMTUpvZUgvb0dCdDNXS3p5cVMyOHY3dWEyZVBQd3k3SnFRSFBF?=
 =?utf-8?B?NEoyUG1lQWZiOUlKd0hva05CU3lUaW95cDBlUDErR0xyaHVCcHV3cEtEcWVO?=
 =?utf-8?B?TEUzL3p2ekltbjJua3ppUGJhSmMwU1V6a0VjczlBbmxkNFd3U1Z2TGlSQ2Vr?=
 =?utf-8?B?WDM0TUpuT2pERi9tcy9CVGxTWm4wWWtrRFRKd204djhUZm0yaVBuMFE4UFlu?=
 =?utf-8?B?Q1IxMng0T0hBSHM1aCtCd1F3a29kNWgvNDJONVIrcFFJdWplYjNTLzJ6M0NV?=
 =?utf-8?B?SXVwYTlxNm00a2ZsRi91SWh1aHo1MExvYWlTUWFzMTZxT3VGMkliT1dkTHVl?=
 =?utf-8?B?clIxY2U2eWdCRGhLNWg5N1RPS1U3bSswVm1keE1rSExrQ0NzTXV1eGxKSzZl?=
 =?utf-8?B?eXNIMHRoU1ZPWmdqcHdaZXcwVzVlR2hKNk01dlFKaWRVenVRTGpzeGNHclZh?=
 =?utf-8?B?WlNtTnIyL3FVZ3pQektvdkh2UjkyQzVlc2c4cEw4OVhTengrcWFoVHF1UEFj?=
 =?utf-8?B?eVFtOUdBcWp3VjBKMDFCaURIZDhZaFdTK2ZCSFVpWXJ6TzExQ010TUtVNHky?=
 =?utf-8?B?TG5mZjlxVmN2cGZSRG1mcXN1Q2hUanJwSEpOU1ZaSkNud0d0Q2daTUdZRWww?=
 =?utf-8?B?YlZkbE02dmtuQ0xSRlJ4UUpueFM1LzU2ck8wZDlRZjBXUUYrUUVIbThucTRM?=
 =?utf-8?B?VlljWVN2V1ZIdEEwWjFwTm9WRGRGV2s2MnBqMGVYek5DeWJMTWIxRHlSR3Js?=
 =?utf-8?B?VTRTQWo0ck5CUEhWbmpFS3JDZWtKWVU5aWkvZWRHVUxrYWlGb2J1QWFBNkdu?=
 =?utf-8?B?SXAvT2hoQ21iSm4wRmVUZW5ZNHdZWWpyT1F4NVlUOGd5SWp2SFFYYVlNb1dw?=
 =?utf-8?B?NVZrckdZaDJvK3paWkcyc0VsVGJrVTZUdzZRRXVkN3pHWG1pN0w3NDcvSDFj?=
 =?utf-8?Q?y5Svs+PqzYhadokXpN3ahH/Jn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9017267a-db03-473e-8cb7-08daacaafa44
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 23:39:17.0966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kdOeRpyzbXdKZ1FEYrJ7+Sviv5hxB05nPv+MU9ZJXoVKMXofPgk8PoJ9YpclBFu/Gxa0yFtMo57T2QaRTe0yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dionna,

On 9/1/2022 7:04 PM, Dionna Glaze wrote:
> The /dev/sev device has the ability to store host-wide certificates for
> the key used by the AMD-SP for SEV-SNP attestation report signing,
> but for hosts that want to specify additional certificates that are
> specific to the image launched in a VM, we need a different way to
> communicate those certificates.
> 
> This patch adds two new KVM ioctl commands: KVM_SEV_SNP_{GET,SET}_CERTS
> 
> The certificates that are set with this command are expected to follow
> the same format as the host certificates, but that format is opaque
> to the kernel.
> 
> The new behavior for custom certificates is that the extended guest
> request command will now return the overridden certificates if they
> were installed for the instance. The error condition for a too small
> data buffer is changed to return the overridden certificate data size
> if there is an overridden certificate set installed.
> 
> Setting a 0 length certificate returns the system state to only return
> the host certificates on an extended guest request.
> 
> We also increase the SEV_FW_BLOB_MAX_SIZE another 4K page to allow
> space for an extra certificate.
> 
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> 
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> ---
>   arch/x86/kvm/svm/sev.c   | 111 ++++++++++++++++++++++++++++++++++++++-
>   arch/x86/kvm/svm/svm.h   |   1 +
>   include/linux/psp-sev.h  |   2 +-
>   include/uapi/linux/kvm.h |  12 +++++
>   4 files changed, 123 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index a35cd9f33f16..f1d846081213 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1636,6 +1636,7 @@ static void *snp_context_create(struct kvm *kvm, struct kvm_sev_cmd *argp)
>   		goto e_free;
>   
>   	sev->snp_certs_data = certs_data;
> +	sev->snp_certs_len = 0;
>   
>   	return context;
>   
> @@ -1940,6 +1941,86 @@ static int snp_launch_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
>   	return ret;
>   }
>   
> +static int snp_get_instance_certs(struct kvm *kvm, struct kvm_sev_cmd *argp)
> +{
> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> +	struct kvm_sev_snp_get_certs params;
> +
> +	if (!sev_snp_guest(kvm))
> +		return -ENOTTY;
> +
> +	if (!sev->snp_context)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data,
> +			   sizeof(params)))
> +		return -EFAULT;
> +
> +	/* No instance certs set. */
> +	if (!sev->snp_certs_len)
> +		return -ENOENT;
> +
> +	if (params.certs_len < sev->snp_certs_len) {
> +		/* Output buffer too small. Return the required size. */
> +		params.certs_len = sev->snp_certs_len;
> +
> +		if (copy_to_user((void __user *)(uintptr_t)argp->data, &params,
> +				 sizeof(params)))
> +			return -EFAULT;
> +
> +		return -EINVAL;
> +	}
> +
> +	if (copy_to_user((void __user *)(uintptr_t)params.certs_uaddr,
> +			 sev->snp_certs_data, sev->snp_certs_len))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int snp_set_instance_certs(struct kvm *kvm, struct kvm_sev_cmd *argp)
> +{
> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> +	struct kvm_sev_snp_set_certs params;
> +	void *new_certs = NULL, *to_certs = sev->snp_certs_data;
> +	unsigned long length = SEV_FW_BLOB_MAX_SIZE;
> +
> +	if (!sev_snp_guest(kvm))
> +		return -ENOTTY;
> +
> +	if (!sev->snp_context)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data,
> +			   sizeof(params)))
> +		return -EFAULT;
> +
> +	if (params.certs_len > SEV_FW_BLOB_MAX_SIZE)
> +		return -EINVAL;
> +
> +	/*
> +	 * Setting a length of 0 is the same as "uninstalling" instance-
> +	 * specific certificates.
> +	 */
> +	if (params.certs_len == 0) {
> +		sev->snp_certs_len = 0;
> +		return 0;
> +	}
> +
> +	/* Page-align the length */
> +	length = (params.certs_len + PAGE_SIZE - 1) & PAGE_MASK;

Probably can use PAGE_ALIGN() here.

> +
> +	if (copy_from_user(to_certs,
> +			   (void __user *)(uintptr_t)params.certs_uaddr,
> +			   params.certs_len)) {
> +		return -EFAULT;
> +	}
> +
> +	sev->snp_certs_len = length;
> +
> +	return 0;
> +}
> +
>   int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
>   {
>   	struct kvm_sev_cmd sev_cmd;
> @@ -2038,6 +2119,12 @@ int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
>   	case KVM_SEV_SNP_LAUNCH_FINISH:
>   		r = snp_launch_finish(kvm, &sev_cmd);
>   		break;
> +	case KVM_SEV_SNP_GET_CERTS:
> +		r = snp_get_instance_certs(kvm, &sev_cmd);
> +		break;
> +	case KVM_SEV_SNP_SET_CERTS:
> +		r = snp_set_instance_certs(kvm, &sev_cmd);
> +		break;
>   	default:
>   		r = -EINVAL;
>   		goto out;
> @@ -3361,8 +3448,28 @@ static void snp_handle_ext_guest_request(struct vcpu_svm *svm, gpa_t req_gpa, gp
>   	if (rc)
>   		goto unlock;
>   
> -	rc = snp_guest_ext_guest_request(&req, (unsigned long)sev->snp_certs_data,
> -					 &data_npages, &err);
> +	/*
> +	 * If the VMM has overridden the certs, then we change the error message
> +	 * if the size is inappropriate for the override. Otherwise we use a
> +	 * regular guest request and copy back the instance certs.
> +	 */
> +	if (sev->snp_certs_len) {
> +		if ((data_npages << PAGE_SHIFT) < sev->snp_certs_len) {
> +			rc = -EINVAL;
> +			err = SNP_GUEST_REQ_INVALID_LEN;
> +			goto datalen;
> +		}
> +		rc = sev_issue_cmd(kvm, SEV_CMD_SNP_GUEST_REQUEST, &req,
> +				   (int *)&err);
> +	} else {
> +		rc = snp_guest_ext_guest_request(
> +			&req, (unsigned long)sev->snp_certs_data, &data_npages,
> +			&err);
> +	}
> +datalen:
> +	if (sev->snp_certs_len)
> +		data_npages = sev->snp_certs_len >> PAGE_SHIFT;
> +
>   	if (rc) {
>   		/*
>   		 * If buffer length is small then return the expected
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index e68b3aab57d6..9030a295cdf5 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -93,6 +93,7 @@ struct kvm_sev_info {
>   	void *snp_context;      /* SNP guest context page */
>   	struct srcu_struct psc_srcu;
>   	void *snp_certs_data;
> +	unsigned int snp_certs_len; /* Size of instance override for certs */
>   	struct mutex guest_req_lock;
>   
>   	u64 sev_features;	/* Features set at VMSA creation */
> diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
> index 859bbbcd5fa3..3d1811ffd9af 100644
> --- a/include/linux/psp-sev.h
> +++ b/include/linux/psp-sev.h
> @@ -24,7 +24,7 @@
>   #define __psp_pa(x)	__pa(x)
>   #endif
>   
> -#define SEV_FW_BLOB_MAX_SIZE	0x4000	/* 16KB */
> +#define SEV_FW_BLOB_MAX_SIZE	0x5000	/* 20KB */
>   
>   /**
>    * SEV platform state
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index db9eb36da3ec..d47b36dc681d 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1717,6 +1717,8 @@ enum sev_cmd_id {
>   	KVM_SEV_SNP_LAUNCH_START,
>   	KVM_SEV_SNP_LAUNCH_UPDATE,
>   	KVM_SEV_SNP_LAUNCH_FINISH,
> +	KVM_SEV_SNP_GET_CERTS,
> +	KVM_SEV_SNP_SET_CERTS,
>   
>   	KVM_SEV_NR_MAX,
>   };
> @@ -1864,6 +1866,16 @@ struct kvm_sev_snp_launch_finish {
>   	__u8 pad[6];
>   };
>   
> +struct kvm_sev_snp_get_certs {
> +	__u64 certs_uaddr;
> +	__u64 certs_len;
> +};
> +
> +struct kvm_sev_snp_set_certs {
> +	__u64 certs_uaddr;
> +	__u64 certs_len;
> +};
> +
>   #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
>   #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
>   #define KVM_DEV_ASSIGN_MASK_INTX	(1 << 2)
> 

Otherwise, patch looks good to me.

Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>

Thanks,
Ashish
