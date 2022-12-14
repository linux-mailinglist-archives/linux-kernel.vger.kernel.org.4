Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E082664C5BD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbiLNJUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237895AbiLNJUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:20:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABE421808
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671009559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HoUGAyklYAnx52Tpq8z0T6HC4NEbzOMs2xbzmoR67Zs=;
        b=ieCw8VCFRmoJDzyHpwx9j7WTRa3R2dT6ZlM3UA58FdoT4D77jMZLG6PQvv0fxcqlTAUtKU
        gaXdOudaWbBHMdXgQkW/YFwHb4KYuNtKRuLjfLfkoE00giQJo05lesH71XEdxgQKTCV9jP
        NssKcoH8KqZps2XpI7mD63UOZTtLQdU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-damANZeLMIWB_v-1Avp91A-1; Wed, 14 Dec 2022 04:19:16 -0500
X-MC-Unique: damANZeLMIWB_v-1Avp91A-1
Received: by mail-wr1-f72.google.com with SMTP id e19-20020adfa453000000b0024209415034so3418755wra.18
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HoUGAyklYAnx52Tpq8z0T6HC4NEbzOMs2xbzmoR67Zs=;
        b=ZGWFMSBCzE6nQ5hOVhlK8lxzmtvsGDmMRi7nrB6Ssfd//9CfYf679VwDHVtNvcwrUy
         lp3inMljoGH2kwthBPXvyMmVs6igsQqJycM6dYzhUisN1CKjObUYSs/SgAw/de9u5joz
         3PhahISKxu0bX9QjtnCfAqL3J5VBZZO3xpY5bsNpq1KAkLDgInw/LCJw/4pNDVyYQ6fa
         vAC9EaUsvxTx2H0YDwBVbAQ3bE9l2ul/zCxH0ppHzoVZELEo7nl+hDxtL8raURx2dZot
         O3jr7f6hbN5DtzgWYrXUwrxYGUuw4vhGN9KAyTBYhDGGsVrKESXQeeFaDXd59M2xa34q
         WC5w==
X-Gm-Message-State: ANoB5plYY8VL4RUELpjMURJ8vj1Wb4G8pj8Us96G2j/hLqPAe/ULOJSn
        wlAg6jP4c7ozA/q0My8EHk0HTtgO5c4Bhcq65tEkxTZmXczvS6sCNpMcizORePIZ5Gl5rrMz9v3
        8T97H3V538FixHz6xA2FXoh6i
X-Received: by 2002:a05:600c:21c1:b0:3cf:8833:1841 with SMTP id x1-20020a05600c21c100b003cf88331841mr18404654wmj.39.1671009555474;
        Wed, 14 Dec 2022 01:19:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4ZsxbaSySB91CVjJpj7oHdhC9I/G0p1kdN01fM0L7otn3MVMadRczuW8LH58MNXjShT5aMsg==
X-Received: by 2002:a05:600c:21c1:b0:3cf:8833:1841 with SMTP id x1-20020a05600c21c100b003cf88331841mr18404626wmj.39.1671009555123;
        Wed, 14 Dec 2022 01:19:15 -0800 (PST)
Received: from [192.168.0.5] (ip-109-43-178-56.web.vodafone.de. [109.43.178.56])
        by smtp.gmail.com with ESMTPSA id u6-20020a5d4686000000b002421a8f4fa6sm2191822wrq.92.2022.12.14.01.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 01:19:14 -0800 (PST)
Message-ID: <44816a09-8567-b2be-84ef-ada621d1beb4@redhat.com>
Date:   Wed, 14 Dec 2022 10:19:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 1/9] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20221213165405.2953539-1-scgl@linux.ibm.com>
 <20221213165405.2953539-2-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20221213165405.2953539-2-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2022 17.53, Janis Schoetterl-Glausch wrote:
> User space can use the MEM_OP ioctl to make storage key checked reads
> and writes to the guest, however, it has no way of performing atomic,
> key checked, accesses to the guest.
> Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
> mode. For now, support this mode for absolute accesses only.
> 
> This mode can be use, for example, to set the device-state-change
> indicator and the adapter-local-summary indicator atomically.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   include/uapi/linux/kvm.h |   7 +++
>   arch/s390/kvm/gaccess.h  |   3 ++
>   arch/s390/kvm/gaccess.c  | 102 +++++++++++++++++++++++++++++++++++++++
>   arch/s390/kvm/kvm-s390.c |  39 ++++++++++++++-
>   4 files changed, 149 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 0d5d4419139a..f106db1af5ee 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -588,6 +588,8 @@ struct kvm_s390_mem_op {
>   		struct {
>   			__u8 ar;	/* the access register number */
>   			__u8 key;	/* access key, ignored if flag unset */
> +			__u8 pad1[6];	/* ignored */
> +			__u64 old_addr;	/* ignored if flag unset */
>   		};
>   		__u32 sida_offset; /* offset into the sida */
>   		__u8 reserved[32]; /* ignored */
> @@ -604,6 +606,11 @@ struct kvm_s390_mem_op {
>   #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
>   #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
>   #define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
> +#define KVM_S390_MEMOP_F_CMPXCHG		(1ULL << 3)
> +/* flags specifying extension support */
> +#define KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG 0x2
> +/* Non program exception return codes (pgm codes are 16 bit) */
> +#define KVM_S390_MEMOP_R_NO_XCHG		(1 << 16)
>   
>   /* for KVM_INTERRUPT */
>   struct kvm_interrupt {
> diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
> index 9408d6cc8e2c..92a3b9fb31ec 100644
> --- a/arch/s390/kvm/gaccess.h
> +++ b/arch/s390/kvm/gaccess.h
> @@ -206,6 +206,9 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
>   int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
>   		      void *data, unsigned long len, enum gacc_mode mode);
>   
> +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
> +			       __uint128_t *old, __uint128_t new, u8 access_key);
> +
>   /**
>    * write_guest_with_key - copy data from kernel space to guest space
>    * @vcpu: virtual cpu
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 0243b6e38d36..6165e761a637 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -1161,6 +1161,108 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
>   	return rc;
>   }
>   
> +/**
> + * cmpxchg_guest_abs_with_key() - Perform cmpxchg on guest absolute address.
> + * @kvm: Virtual machine instance.
> + * @gpa: Absolute guest address of the location to be changed.
> + * @len: Operand length of the cmpxchg, required: 1 <= len <= 16. Providing a
> + *       non power of two will result in failure.
> + * @old_addr: Pointer to old value. If the location at @gpa contains this value, the
> + *         exchange will succeed. After calling cmpxchg_guest_abs_with_key() *@old
> + *         contains the value at @gpa before the attempt to exchange the value.
> + * @new: The value to place at @gpa.
> + * @access_key: The access key to use for the guest access.
> + *
> + * Atomically exchange the value at @gpa by @new, if it contains *@old.
> + * Honors storage keys.
> + *
> + * Return: * 0: successful exchange
> + *         * 1: exchange unsuccessful
> + *         * a program interruption code indicating the reason cmpxchg could
> + *           not be attempted
> + *         * -EINVAL: address misaligned or len not power of two
> + *         * -EAGAIN: transient failure (len 1 or 2)
> + *         * -EOPNOTSUPP: read-only memslot (should never occur)
> + */
> +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
> +			       __uint128_t *old_addr, __uint128_t new,
> +			       u8 access_key)
> +{
> +	gfn_t gfn = gpa >> PAGE_SHIFT;
> +	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
> +	bool writable;
> +	hva_t hva;
> +	int ret;
> +
> +	if (!IS_ALIGNED(gpa, len))
> +		return -EINVAL;
> +
> +	hva = gfn_to_hva_memslot_prot(slot, gfn, &writable);
> +	if (kvm_is_error_hva(hva))
> +		return PGM_ADDRESSING;
> +	/*
> +	 * Check if it's a read-only memslot, even though that cannot occur
> +	 * since those are unsupported.
> +	 * Don't try to actually handle that case.
> +	 */
> +	if (!writable)
> +		return -EOPNOTSUPP;
> +
> +	hva += offset_in_page(gpa);
> +	switch (len) {
> +	case 1: {
> +		u8 old;
> +
> +		ret = cmpxchg_user_key((u8 *)hva, &old, *old_addr, new, access_key);
> +		ret = ret < 0 ? ret : old != *old_addr;
> +		*old_addr = old;
> +		break;
> +	}
> +	case 2: {
> +		u16 old;
> +
> +		ret = cmpxchg_user_key((u16 *)hva, &old, *old_addr, new, access_key);
> +		ret = ret < 0 ? ret : old != *old_addr;
> +		*old_addr = old;
> +		break;
> +	}
> +	case 4: {
> +		u32 old;
> +
> +		ret = cmpxchg_user_key((u32 *)hva, &old, *old_addr, new, access_key);
> +		ret = ret < 0 ? ret : old != *old_addr;
> +		*old_addr = old;
> +		break;
> +	}
> +	case 8: {
> +		u64 old;
> +
> +		ret = cmpxchg_user_key((u64 *)hva, &old, *old_addr, new, access_key);
> +		ret = ret < 0 ? ret : old != *old_addr;
> +		*old_addr = old;
> +		break;
> +	}
> +	case 16: {
> +		__uint128_t old;
> +
> +		ret = cmpxchg_user_key((__uint128_t *)hva, &old, *old_addr, new, access_key);
> +		ret = ret < 0 ? ret : old != *old_addr;
> +		*old_addr = old;
> +		break;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +	mark_page_dirty_in_slot(kvm, slot, gfn);
> +	/*
> +	 * Assume that the fault is caused by protection, either key protection
> +	 * or user page write protection.
> +	 */
> +	if (ret == -EFAULT)
> +		ret = PGM_PROTECTION;
> +	return ret;
> +}
> +
>   /**
>    * guest_translate_address_with_key - translate guest logical into guest absolute address
>    * @vcpu: virtual cpu
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 45d4b8182b07..47bcf2cb4345 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -576,7 +576,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_S390_VCPU_RESETS:
>   	case KVM_CAP_SET_GUEST_DEBUG:
>   	case KVM_CAP_S390_DIAG318:
> -	case KVM_CAP_S390_MEM_OP_EXTENSION:
>   		r = 1;
>   		break;
>   	case KVM_CAP_SET_GUEST_DEBUG2:
> @@ -590,6 +589,14 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_S390_MEM_OP:
>   		r = MEM_OP_MAX_SIZE;
>   		break;
> +	case KVM_CAP_S390_MEM_OP_EXTENSION:
> +		/*
> +		 * Flag bits indicating which extensions are supported.
> +		 * The first extension doesn't use a flag, but pretend it does,
> +		 * this way that can be changed in the future.
> +		 */
> +		r = KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG | 1;
> +		break;
>   	case KVM_CAP_NR_VCPUS:
>   	case KVM_CAP_MAX_VCPUS:
>   	case KVM_CAP_MAX_VCPU_ID:
> @@ -2714,12 +2721,19 @@ static bool access_key_invalid(u8 access_key)
>   static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   {
>   	void __user *uaddr = (void __user *)mop->buf;
> +	void __user *old_addr = (void __user *)mop->old_addr;
> +	union {
> +		__uint128_t quad;
> +		char raw[sizeof(__uint128_t)];
> +	} old = { .quad = 0}, new = { .quad = 0 };
> +	unsigned int off_in_quad = sizeof(new) - mop->size;
>   	u64 supported_flags;
>   	void *tmpbuf = NULL;
>   	int r, srcu_idx;
>   
>   	supported_flags = KVM_S390_MEMOP_F_SKEY_PROTECTION
> -			  | KVM_S390_MEMOP_F_CHECK_ONLY;
> +			  | KVM_S390_MEMOP_F_CHECK_ONLY
> +			  | KVM_S390_MEMOP_F_CMPXCHG;
>   	if (mop->flags & ~supported_flags || !mop->size)
>   		return -EINVAL;
>   	if (mop->size > MEM_OP_MAX_SIZE)
> @@ -2741,6 +2755,19 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   	} else {
>   		mop->key = 0;
>   	}
> +	if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
> +		/*
> +		 * This validates off_in_quad. Checking that size is a power
> +		 * of two is not necessary, as cmpxchg_guest_abs_with_key
> +		 * takes care of that
> +		 */
> +		if (mop->size > sizeof(new))
> +			return -EINVAL;

I'd maybe add a check for mop->op == KVM_S390_MEMOP_ABSOLUTE_WRITE here, 
since calling the _READ function with the F_CMPXCHG flag set does not make 
too much sense.

Anyway, patch looks good to me, so with or without that additional check:
Reviewed-by: Thomas Huth <thuth@redhat.com>

> +		if (copy_from_user(&new.raw[off_in_quad], uaddr, mop->size))
> +			return -EFAULT;
> +		if (copy_from_user(&old.raw[off_in_quad], old_addr, mop->size))
> +			return -EFAULT;
> +	}
>   	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
>   		tmpbuf = vmalloc(mop->size);
>   		if (!tmpbuf)
> @@ -2771,6 +2798,14 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   	case KVM_S390_MEMOP_ABSOLUTE_WRITE: {
>   		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
>   			r = check_gpa_range(kvm, mop->gaddr, mop->size, GACC_STORE, mop->key);
> +		} else if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
> +			r = cmpxchg_guest_abs_with_key(kvm, mop->gaddr, mop->size,
> +						       &old.quad, new.quad, mop->key);
> +			if (r == 1) {
> +				r = KVM_S390_MEMOP_R_NO_XCHG;
> +				if (copy_to_user(old_addr, &old.raw[off_in_quad], mop->size))
> +					r = -EFAULT;
> +			}
>   		} else {
>   			if (copy_from_user(tmpbuf, uaddr, mop->size)) {
>   				r = -EFAULT;

