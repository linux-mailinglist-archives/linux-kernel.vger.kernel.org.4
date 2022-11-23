Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D342F63553B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbiKWJPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbiKWJP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:15:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308B110613A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669194872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UvEl3fDoKyc28+1/KYocb8VdTUoV1lUU4X5wm9R8a5I=;
        b=Iuz8q11cTjukjkag51CuuozgXPgefN6Pe7g+17EinkbtR3WpANX1kMJTr89uF9PWxgEaY3
        hVIDb/oR56B+FORW4pRiP2Jt6owX8KQx0quujYAULVTFt0UmuxOz5QWNkhGxLR9BoEaL1y
        y5A+yf20LPLUoszyG4te1kF5XoE3qMU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-543-R7L6OwrlPjOz-R7B0g4AxQ-1; Wed, 23 Nov 2022 04:14:30 -0500
X-MC-Unique: R7L6OwrlPjOz-R7B0g4AxQ-1
Received: by mail-wm1-f70.google.com with SMTP id b47-20020a05600c4aaf00b003d031aeb1b6so746492wmp.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvEl3fDoKyc28+1/KYocb8VdTUoV1lUU4X5wm9R8a5I=;
        b=UY71pc9nHhgVNNIyAAHsAyaUz8haL9D9kkVMaC9Lrgt+woVIqzd1DOLNapP+1hMD9U
         uvsboIQ02/MrbfZAuT44fN34N7nnTuS1E6kf4pqNx7O8uHqSotXesk2WTM2LbuNN4M91
         9wDOIWxml1xmosIWEAXR+Yfby+dpwn90LQsNxsPnrFMl9uaXmTvyI7bMBOntV7pPWwii
         gUUDNXB+liYEFBF1YlzxOxNZyCXZ60NgrhPL/84/+RwTyBZmvITzuzzvwwSOJS5ke9LC
         FqHM3XMc6sBw6F/sGIyV7V89aziLsoqRls3Jtn3q0fw7+6UKO3yZyxUQ/5+sfGR6XHSa
         fC2w==
X-Gm-Message-State: ANoB5pl5i/AqFsXBlQ/eh0ou/1GDMoJ4Xl0BbXIfleb9iesuGdf63lee
        ZOkx0PA0apGm8VNwpJk7bVK/SiKPM2Kg4IZIfZeV5ndtKEHg7pMJc9/quVa6p1dNYaRXrbcjWUw
        nzZ5yWx9U8PjMaakw2akQPVxf
X-Received: by 2002:a5d:6ac7:0:b0:241:bf95:c9a2 with SMTP id u7-20020a5d6ac7000000b00241bf95c9a2mr14122125wrw.387.1669194869292;
        Wed, 23 Nov 2022 01:14:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5MbHICR3Vo7tZWlDRW+kpPz2bfMNB9rm1UeiE7Bw09D38KnYbwhuerQkfLvPUQegukdeU0MA==
X-Received: by 2002:a5d:6ac7:0:b0:241:bf95:c9a2 with SMTP id u7-20020a5d6ac7000000b00241bf95c9a2mr14122101wrw.387.1669194868937;
        Wed, 23 Nov 2022 01:14:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id z3-20020a5d4c83000000b00241e4bff85asm3407560wrs.100.2022.11.23.01.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 01:14:28 -0800 (PST)
Message-ID: <5899e17f-f048-d248-e5ac-be6cd5a8b7a4@redhat.com>
Date:   Wed, 23 Nov 2022 10:14:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] KVM: s390: vsie: Fix the initialization of the epoch
 extension (epdx) field
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "Collin L. Walling" <walling@linux.ibm.com>,
        Jason J Herne <jjherne@linux.ibm.com>
References: <20221123090833.292938-1-thuth@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221123090833.292938-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.22 10:08, Thomas Huth wrote:
> We recently experienced some weird huge time jumps in nested guests when
> rebooting them in certain cases. After adding some debug code to the epoch
> handling in vsie.c (thanks to David Hildenbrand for the idea!), it was
> obvious that the "epdx" field (the multi-epoch extension) did not get set
> to 0xff in case the "epoch" field was negative.
> Seems like the code misses to copy the value from the epdx field from
> the guest to the shadow control block. By doing so, the weird time
> jumps are gone in our scenarios.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2140899
> Fixes: 8fa1696ea781 ("KVM: s390: Multiple Epoch Facility support")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   arch/s390/kvm/vsie.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 94138f8f0c1c..ace2541ababd 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -546,8 +546,10 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_CEI))
>   		scb_s->eca |= scb_o->eca & ECA_CEI;
>   	/* Epoch Extension */
> -	if (test_kvm_facility(vcpu->kvm, 139))
> +	if (test_kvm_facility(vcpu->kvm, 139)) {
>   		scb_s->ecd |= scb_o->ecd & ECD_MEF;
> +		scb_s->epdx = scb_o->epdx;
> +	}
>   
>   	/* etoken */
>   	if (test_kvm_facility(vcpu->kvm, 156))

Nice,

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

