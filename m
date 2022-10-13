Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E5C5FD1CD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 02:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiJMAtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 20:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiJMAta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 20:49:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA038578B9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 17:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kil8tDaMXi0qgo94dtVDF4CW/SpnSsmnnD/UlcArY+mLOrPWiu3+uNbJYjmx8gEkc3eJ7IwOu4WVMQ2FSdyVqwgLEyE+XHJhIdl0swva+ntGwUVvMEgtS0E4ZzL9EV3n+zTBdQcXNLvqxyVoz+UXcYexeChl3L29NH7ObPC29hB0+fCM+0PVqRjvim3SC254XhKdD7xhK9yPg5vlDFFoGl3Pj9le89pMQnm5vaU+g0Tu4Ei+JSQHU7axFWK/wjaH9bm1R4Rpf3+a0wUa3jBUk3bQubGYsdWcWtfLjs/ZTL+j34key4JAi9Jtz+6y2S5FZvxDKJV5UFHolMDHUDoIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UOKzKsMPIMYKr1VvJPinJH4KhuyD3d6I+cjNWvkVLo=;
 b=a86dqFvwDiYQTLWA0+kLJDnozvd5xQ1WM+cJUvn1beN/hRjExLrxxPFTcH6HZ6r2gy4ajgIAHTG6QJNBUVCu2Oo9Zshhld+zNiQArrDzAP+X2nosaDDKM1hYgYA+dLNhr9FcEWfu2VWrfbawEQg0fxLmiuInRLBNQMZGs59Pi1qNj91g6b9gCoWt9IDCv+4mZg/7f6RUcBS4JXuM0a1aVEt9mt7fTNccD+1+ggPtyLNYrh8Y6F01ShpUJtHSuV9IrSLlpn+SnRzjOnBQX7bN4j4OGQ1kyWwztpxIZPZxmTugzgx+C/PDwVrulrqEyUl139TRxdbLoUtYE/Fb7/dT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UOKzKsMPIMYKr1VvJPinJH4KhuyD3d6I+cjNWvkVLo=;
 b=wyp216vv27AYvHycxw/WiIaz1ef5HEUrfFtgJU4C56PE5Mam2k32698lS4qS1kkRy4hfEz5XmzBc2twAmLXCRbAN0JMKZxw/1otTPncPgqceflgGP6GtnFAM513927pihWwUWZncf5FqqipgDXtTU8a9W4FhSi8SGb9mgHXSeYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 00:42:14 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::b3f1:abb4:f311:5193]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::b3f1:abb4:f311:5193%4]) with mapi id 15.20.5709.021; Thu, 13 Oct 2022
 00:42:14 +0000
Message-ID: <554407c3-197b-0e52-fc92-9c383a37175b@amd.com>
Date:   Wed, 12 Oct 2022 19:42:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/2] x86/sev: Add KVM commands for instance certs
Content-Language: en-US
From:   "Kalra, Ashish" <ashish.kalra@amd.com>
To:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20220902000439.875476-1-dionnaglaze@google.com>
 <669cedbc-e127-92ba-2e98-e0460b45bd4d@amd.com>
In-Reply-To: <669cedbc-e127-92ba-2e98-e0460b45bd4d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:610:74::29) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ebf129-ebf2-462f-409a-08daacb3c59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KSuTPwLojJu0wm0J85LdBYd7vz9fqVb/5U1Tx0HUBb2dGRCyLFgLrGMRT4p032xyMZbFW82DGPkpIaNj/Elckffxw89l9zviT96lpozPIEk3xo1IBNoYO7IS1QwolAgjCOc58yegUBpLeGg5fE2S9djIW9w3lltH6ByCuS4ATfYkCRShGrejdBMu643N4KT8u5rO7FeoyTKlLpaC1SbDYJCSk7XL00g2+ZEUHdQUwvUsTQ7we19K+/8WNXbvVzZIhM/pJFAmiIkt0GTLek8ZRogVprmWG8yc0EYXKF/+oVzUFpJ+iJ37mHYHWBl86AT6gjgGYLQCxEWXSFCigV1pEO1+xJjmxr221fG0cX/f9DaxlcxHdCC2NlDgFS5BFC9aiYzBZ5ehhyYy8mRv6uLRKb5IR5h5ljIoAUGRTByBazfkpvBRTcj6YsNvbkCKCDlru++VoCEn3i9msSV3tHMV0CRXtnzQyOlS4hz0nYgSroM3GlzekyebWMOILHbKzXwQx2uc9ZDFhOAOJiWUclIUJmqnR9khLANhXIf8vlLPj09Qqi9rV1I91iI7l83i7XypXu86vTDu9BuW1uTjd7Q9OvsNRXPWA/CCXNYvuU80kxIzi1LJy3+24eISIozuSm4YYJaakKUZTwT9PxOl9JCXKpvjTRg1FoztQKpFXxpb73CWz0VZi5uudk2rrlMQ6J56FnKvNijRlZ6PxD6yO0EoX8DNtcH58FAUR0uh7aopOYwrVgIDd6OYfYz+HtcW/Jsryyksxm/nSB7YDidxVdKFKuK1uTBGU1eoxUnOySkQKmQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199015)(478600001)(6486002)(86362001)(54906003)(41300700001)(38100700002)(83380400001)(36756003)(31696002)(66476007)(66556008)(66946007)(4326008)(8676002)(6506007)(26005)(53546011)(316002)(31686004)(186003)(6666004)(2616005)(2906002)(8936002)(6512007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGM1TEdES3U3aVpGQzMzOG1UbWovMW8zbGxYSHN5b0xaNnlhaDFIYzJ3R2xu?=
 =?utf-8?B?ODZMUzFJOFdla0plNURMRldaRUZvbTVsd0ZUQzdRNUpEVktFWFBocElVZmJS?=
 =?utf-8?B?a1dBd3FpUk5vb0xiM2hUL1VIYXRROGJTd2RrM2wyYjN4Um00bGd3VTRDUkkz?=
 =?utf-8?B?d1dlMWNVelVxbVV1d3BPVFNsbUZ1eCtvN0NhUUIreFFKRDlqMDdQVlU2SEd6?=
 =?utf-8?B?dUpqZ0NqSHpabk85azFpeFlwVHBwU0lKTEhGUGdVUnVoTlF2Y3UwVFptRDRu?=
 =?utf-8?B?NlM0Nzh4emxrOCtwdTFWa3BIZHpUaExHK3hpQzVrSHp5bDU1aUFOdjNQTUtE?=
 =?utf-8?B?TzN2dHp6K3BjQVlURG5hcHpQcFA0ZkRoRmJHRHl1SUZUNk5kZTBYUVRYOUVK?=
 =?utf-8?B?YkphM1Vaa3ZsQkFCdGRYREtnbmcwSVdZWFQwcFQ3TDdsUDV5WE1IeFJORktp?=
 =?utf-8?B?NFl1cEkrSGZiRFlWbkNkQmNnbTBSa2pFaUFUZHZydTdTbEhxRWcwaWIvWmdZ?=
 =?utf-8?B?cGs0REpBcXl0UVRyWWxaRGpwZjJQZG9YWUtSN2ZMVTN3OHFmdFpWY2JPRjE3?=
 =?utf-8?B?QWFxSGRoNktnL2YyR0V3SXBGdHYzV2FPbkZGYW5OQW5kNTF4d09ZQVlPMVQy?=
 =?utf-8?B?dWpkMjVuc2svdFQzSTdzMXhmMGZoUit1dy94YXRNNGhVMHkwN3cxcitjRXJW?=
 =?utf-8?B?VGRMd3RHSnZJL2JPWGN3WjQ5N0h3OWcwU3dNdGxCQU5CNjZtV3ZNWk84bnJ2?=
 =?utf-8?B?aEUwUmNMSjNudmJYUjhMTTNTYVByZWVTZmlldGc3aDNtQ2pudnV1RG9DSDNJ?=
 =?utf-8?B?V1hYU1RPRU14ZHZkTndOaW1hMnZCUzdvSzdlamdNb0F1VGxxbFNBNUF6bVJO?=
 =?utf-8?B?MXluZ2YrQXR2bVRvWTl1c2hkRjFrOWpZM2podW5pcjFKa0oxdUdZVDRQVnVU?=
 =?utf-8?B?bmhzczhBT2J6aVFZbnEyYnRxWjNhalFlQVp1UUd4ZkY0YUVzM21yeHlKUWV0?=
 =?utf-8?B?aS9pSGlhaC90ZUlUWUNrYWxMcHV1WVBNeGdvalo2Zm9EUW9iQURCOVVMamoz?=
 =?utf-8?B?ZXl1T08vK0YvTWFubXN4KzU2T3IwRHRPaUNlQ3lZcFJzdXFyWkE0d0VuYUlV?=
 =?utf-8?B?Q09UOS9zTlg5cy8wT3F5dXB6WTE4bTIzTW5vVS81UXRXS2JjL3gvNU9BK04y?=
 =?utf-8?B?VnlqczVxSFVqSTFIUVVUS2k5TWlkZ080UzNGYVREMWRsQis3SU9PVlZ1MXZq?=
 =?utf-8?B?T0ltOTM1Vkk5QVlmTWFXTWw0QU9YcDc5ckxGUjNOSGlSTGpUR01QaHJOV0gy?=
 =?utf-8?B?c3lMdUxjYmx4TU5HdU5GeFNrZDJUL3VYNkNFNFR0V3ZocDgvRkRVekE2VHJq?=
 =?utf-8?B?UHJUbDlBamFGVGRFYkg4VkVnUTVsS0dyeDFpSnRVdUJlYzRpWGlZbkN3aUR5?=
 =?utf-8?B?NmxENVV5NU9DcUNmN2h2MHpKeHRMUG4wMkw3NWFpTnpWdWpBV25LNVdGWUt5?=
 =?utf-8?B?TWJvWHdiMENsOHQyQWducHJPbVRzeU9TRkk2M3M4eGQwUEgvNG9lTnpoYVF5?=
 =?utf-8?B?Vy9OYm04Nm44RElISzdlc3lxaHdVZ0pvY0ZBNldwUGdXck13UksrUTJacVg3?=
 =?utf-8?B?WHZWcUZJUmZOMTQzZmI5QXEyQ2RuTGdnV0M2UUtlUW9FdjNTbWZ2WHhTZzFX?=
 =?utf-8?B?UWRaZUp0TjhyZ1VpRzlBYWJOOUlRMEMvRFg0SFA5djdwSW1MQlg4U3UwaXBH?=
 =?utf-8?B?SnhhUkZxVGJWSC8yU2luSzVkS1R2bS83ZGtKWi9sWG44ZCtxOUZUZUJZdlYy?=
 =?utf-8?B?ZlBwNXVOSzVMSmxYR0lMZkxGaUQ4M09qWEJPcGorRlV1SDZBdGczNXllbnpW?=
 =?utf-8?B?YkxrOXVFS05kVGFoQU9JNExrL1BCcVJOdS9vSXdua0NuVzQ1TE94TE5zY1pQ?=
 =?utf-8?B?OXhYdlBMajdKVFp6VUc2dFljbXFHUkFvMnJoVHIzWUY5Ky8zSXdJWkhnV3l3?=
 =?utf-8?B?Vi9PNWM3N0FNWkM0dUZ0VWlOM1Z1RWgwSXVrNGNqWFlyWXZMVHdSOHZoU0Fj?=
 =?utf-8?B?MVFTVnBYSWJweTBGclJzd2ZEYzR3M2RhTHU1QjhIZjB6bStQcUxkSGR5L1ZB?=
 =?utf-8?Q?a5D1sIGVv2RJrun2dy0t1ie2X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ebf129-ebf2-462f-409a-08daacb3c59a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 00:42:14.1784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5W5g/SU5nUvmSlBsoE/8XwS49BJmhOT6c2Gl3cxee2jTpPvkcq7G3goLY5nxQVgbhyT7ruN0RuHXEl0qnrkiLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2022 6:39 PM, Kalra, Ashish wrote:
> Hello Dionna,
> 
> On 9/1/2022 7:04 PM, Dionna Glaze wrote:
>> The /dev/sev device has the ability to store host-wide certificates for
>> the key used by the AMD-SP for SEV-SNP attestation report signing,
>> but for hosts that want to specify additional certificates that are
>> specific to the image launched in a VM, we need a different way to
>> communicate those certificates.
>>
>> This patch adds two new KVM ioctl commands: KVM_SEV_SNP_{GET,SET}_CERTS
>>
>> The certificates that are set with this command are expected to follow
>> the same format as the host certificates, but that format is opaque
>> to the kernel.
>>
>> The new behavior for custom certificates is that the extended guest
>> request command will now return the overridden certificates if they
>> were installed for the instance. The error condition for a too small
>> data buffer is changed to return the overridden certificate data size
>> if there is an overridden certificate set installed.
>>
>> Setting a 0 length certificate returns the system state to only return
>> the host certificates on an extended guest request.
>>
>> We also increase the SEV_FW_BLOB_MAX_SIZE another 4K page to allow
>> space for an extra certificate.
>>
>> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>
>> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
>> ---
>>   arch/x86/kvm/svm/sev.c   | 111 ++++++++++++++++++++++++++++++++++++++-
>>   arch/x86/kvm/svm/svm.h   |   1 +
>>   include/linux/psp-sev.h  |   2 +-
>>   include/uapi/linux/kvm.h |  12 +++++
>>   4 files changed, 123 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index a35cd9f33f16..f1d846081213 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -1636,6 +1636,7 @@ static void *snp_context_create(struct kvm *kvm, 
>> struct kvm_sev_cmd *argp)
>>           goto e_free;
>>       sev->snp_certs_data = certs_data;
>> +    sev->snp_certs_len = 0;
>>       return context;
>> @@ -1940,6 +1941,86 @@ static int snp_launch_finish(struct kvm *kvm, 
>> struct kvm_sev_cmd *argp)
>>       return ret;
>>   }
>> +static int snp_get_instance_certs(struct kvm *kvm, struct kvm_sev_cmd 
>> *argp)
>> +{
>> +    struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
>> +    struct kvm_sev_snp_get_certs params;
>> +
>> +    if (!sev_snp_guest(kvm))
>> +        return -ENOTTY;
>> +
>> +    if (!sev->snp_context)
>> +        return -EINVAL;
>> +
>> +    if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data,
>> +               sizeof(params)))
>> +        return -EFAULT;
>> +
>> +    /* No instance certs set. */
>> +    if (!sev->snp_certs_len)
>> +        return -ENOENT;
>> +
>> +    if (params.certs_len < sev->snp_certs_len) {
>> +        /* Output buffer too small. Return the required size. */
>> +        params.certs_len = sev->snp_certs_len;
>> +
>> +        if (copy_to_user((void __user *)(uintptr_t)argp->data, &params,
>> +                 sizeof(params)))
>> +            return -EFAULT;
>> +
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (copy_to_user((void __user *)(uintptr_t)params.certs_uaddr,
>> +             sev->snp_certs_data, sev->snp_certs_len))
>> +        return -EFAULT;
>> +
>> +    return 0;
>> +}
>> +
>> +static int snp_set_instance_certs(struct kvm *kvm, struct kvm_sev_cmd 
>> *argp)
>> +{
>> +    struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
>> +    struct kvm_sev_snp_set_certs params;
>> +    void *new_certs = NULL, *to_certs = sev->snp_certs_data;
>> +    unsigned long length = SEV_FW_BLOB_MAX_SIZE;
>> +
>> +    if (!sev_snp_guest(kvm))
>> +        return -ENOTTY;
>> +
>> +    if (!sev->snp_context)
>> +        return -EINVAL;
>> +
>> +    if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data,
>> +               sizeof(params)))
>> +        return -EFAULT;
>> +
>> +    if (params.certs_len > SEV_FW_BLOB_MAX_SIZE)
>> +        return -EINVAL;
>> +
>> +    /*
>> +     * Setting a length of 0 is the same as "uninstalling" instance-
>> +     * specific certificates.
>> +     */
>> +    if (params.certs_len == 0) {
>> +        sev->snp_certs_len = 0;
>> +        return 0;
>> +    }
>> +
>> +    /* Page-align the length */
>> +    length = (params.certs_len + PAGE_SIZE - 1) & PAGE_MASK;
> 
> Probably can use PAGE_ALIGN() here.
> 
>> +
>> +    if (copy_from_user(to_certs,
>> +               (void __user *)(uintptr_t)params.certs_uaddr,
>> +               params.certs_len)) {
>> +        return -EFAULT;
>> +    }
>> +
>> +    sev->snp_certs_len = length;
>> +
>> +    return 0;
>> +}
>> +
>>   int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
>>   {
>>       struct kvm_sev_cmd sev_cmd;
>> @@ -2038,6 +2119,12 @@ int svm_mem_enc_op(struct kvm *kvm, void __user 
>> *argp)
>>       case KVM_SEV_SNP_LAUNCH_FINISH:
>>           r = snp_launch_finish(kvm, &sev_cmd);
>>           break;
>> +    case KVM_SEV_SNP_GET_CERTS:
>> +        r = snp_get_instance_certs(kvm, &sev_cmd);
>> +        break;
>> +    case KVM_SEV_SNP_SET_CERTS:
>> +        r = snp_set_instance_certs(kvm, &sev_cmd);
>> +        break;
>>       default:
>>           r = -EINVAL;
>>           goto out;
>> @@ -3361,8 +3448,28 @@ static void snp_handle_ext_guest_request(struct 
>> vcpu_svm *svm, gpa_t req_gpa, gp
>>       if (rc)
>>           goto unlock;
>> -    rc = snp_guest_ext_guest_request(&req, (unsigned 
>> long)sev->snp_certs_data,
>> -                     &data_npages, &err);
>> +    /*
>> +     * If the VMM has overridden the certs, then we change the error 
>> message
>> +     * if the size is inappropriate for the override. Otherwise we use a
>> +     * regular guest request and copy back the instance certs.
>> +     */
>> +    if (sev->snp_certs_len) {
>> +        if ((data_npages << PAGE_SHIFT) < sev->snp_certs_len) {
>> +            rc = -EINVAL;
>> +            err = SNP_GUEST_REQ_INVALID_LEN;
>> +            goto datalen;
>> +        }
>> +        rc = sev_issue_cmd(kvm, SEV_CMD_SNP_GUEST_REQUEST, &req,
>> +                   (int *)&err);

Though, one thing i don't understand is that why do we need to issue
the SNP_GUEST_REQUEST to FW if we are going to return the VMM
overriden certs back to the guest ?

Thanks,
Ashish

>> +    } else {
>> +        rc = snp_guest_ext_guest_request(
>> +            &req, (unsigned long)sev->snp_certs_data, &data_npages,
>> +            &err);
>> +    }
>> +datalen:
>> +    if (sev->snp_certs_len)
>> +        data_npages = sev->snp_certs_len >> PAGE_SHIFT;
>> +
>>       if (rc) {
>>           /*
>>            * If buffer length is small then return the expected
>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>> index e68b3aab57d6..9030a295cdf5 100644
>> --- a/arch/x86/kvm/svm/svm.h
>> +++ b/arch/x86/kvm/svm/svm.h
>> @@ -93,6 +93,7 @@ struct kvm_sev_info {
>>       void *snp_context;      /* SNP guest context page */
>>       struct srcu_struct psc_srcu;
>>       void *snp_certs_data;
>> +    unsigned int snp_certs_len; /* Size of instance override for 
>> certs */
>>       struct mutex guest_req_lock;
>>       u64 sev_features;    /* Features set at VMSA creation */
>> diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
>> index 859bbbcd5fa3..3d1811ffd9af 100644
>> --- a/include/linux/psp-sev.h
>> +++ b/include/linux/psp-sev.h
>> @@ -24,7 +24,7 @@
>>   #define __psp_pa(x)    __pa(x)
>>   #endif
>> -#define SEV_FW_BLOB_MAX_SIZE    0x4000    /* 16KB */
>> +#define SEV_FW_BLOB_MAX_SIZE    0x5000    /* 20KB */
>>   /**
>>    * SEV platform state
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index db9eb36da3ec..d47b36dc681d 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1717,6 +1717,8 @@ enum sev_cmd_id {
>>       KVM_SEV_SNP_LAUNCH_START,
>>       KVM_SEV_SNP_LAUNCH_UPDATE,
>>       KVM_SEV_SNP_LAUNCH_FINISH,
>> +    KVM_SEV_SNP_GET_CERTS,
>> +    KVM_SEV_SNP_SET_CERTS,
>>       KVM_SEV_NR_MAX,
>>   };
>> @@ -1864,6 +1866,16 @@ struct kvm_sev_snp_launch_finish {
>>       __u8 pad[6];
>>   };
>> +struct kvm_sev_snp_get_certs {
>> +    __u64 certs_uaddr;
>> +    __u64 certs_len;
>> +};
>> +
>> +struct kvm_sev_snp_set_certs {
>> +    __u64 certs_uaddr;
>> +    __u64 certs_len;
>> +};
>> +
>>   #define KVM_DEV_ASSIGN_ENABLE_IOMMU    (1 << 0)
>>   #define KVM_DEV_ASSIGN_PCI_2_3        (1 << 1)
>>   #define KVM_DEV_ASSIGN_MASK_INTX    (1 << 2)
>>
> 
> Otherwise, patch looks good to me.
> 
> Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>
> 
> Thanks,
> Ashish
