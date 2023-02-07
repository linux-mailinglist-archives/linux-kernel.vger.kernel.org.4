Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C03568D17E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBGIes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBGIeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:34:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2EF13C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675758834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aje4RdzF0Q+1EGZpi8bjbDR7Z7zWGOlp8M/MHmqcL8I=;
        b=Ytevb3zts3RWyZxTWunmlODZXy0dpKPGhWSdFEs2a2rU/g5LSZpyQPAFLDTux4MwaVUWj4
        L/eLWyRfNmKvlfoBXuefCsQY3JKyUPVD7ClNBSUcVUhOHpdQhQNcGRulJhMQgKOopAJXMC
        UCo1KsK5aURD+1mV/2KD1cND5BLIJmk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-272-cMbwZ0zxNfSi5sx11D5grw-1; Tue, 07 Feb 2023 03:33:53 -0500
X-MC-Unique: cMbwZ0zxNfSi5sx11D5grw-1
Received: by mail-ed1-f72.google.com with SMTP id g25-20020aa7c859000000b004a3fe4cbb0cso9437812edt.17
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 00:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aje4RdzF0Q+1EGZpi8bjbDR7Z7zWGOlp8M/MHmqcL8I=;
        b=ZwvKtizx6cqXT4uwwVb3+D0DJc+tolF3U7hsyieAPC3c57JJ9dlpURKZmy7HlWGTmK
         kZtUgJ7k3a1/5zC/sg7inb6hUNN5Y6gWhOMBoyDtDMwifMFBmftDgUOU5DhIfhYJKSMc
         4GHUz7Rtc2UE9U5lO3UKkPHcNU7U20jvNffF+mqgGmERDvJvjABjBXZad7J6VgEhrkUz
         e/USRC77TMZj73jNlhPmm8oIpE+1/wSuNex+DpuO2HT8//4ILp2Whs1jf8J3QyvGJjgk
         3LR93qUWyTPaRaMHVJD9SWsZKVE10V80Mk7dU4ahNmYmPpm47MVeM/bI2uLKQF7m/9my
         w7tg==
X-Gm-Message-State: AO0yUKVtg0qaYa8+zH7K/aH1OlS7srOgJSbqxKSqdIPFbUOkdLVgnnBU
        v5hRTYi0SoRCtNq64MxqkLVwKZngR9EuGpxiCeZF4jqDtWiTGl07QQ0TPDKhKV+Mwz2fNis+AUf
        WZXcK2Qm/+umergAcrtdU8Lfj
X-Received: by 2002:a50:cddc:0:b0:4a2:73bb:304b with SMTP id h28-20020a50cddc000000b004a273bb304bmr2521677edj.4.1675758831952;
        Tue, 07 Feb 2023 00:33:51 -0800 (PST)
X-Google-Smtp-Source: AK7set+2jeJzPFuAEiychAHoDMvoCLlBTqDbTBF2tPEKgxtQ8/oVa5171ZwQQHW6FB4YIWZakGWb3A==
X-Received: by 2002:a50:cddc:0:b0:4a2:73bb:304b with SMTP id h28-20020a50cddc000000b004a273bb304bmr2521668edj.4.1675758831798;
        Tue, 07 Feb 2023 00:33:51 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id zm9-20020a170906994900b008aa2c0c738bsm300300ejb.214.2023.02.07.00.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 00:33:50 -0800 (PST)
Date:   Tue, 7 Feb 2023 09:33:50 +0100
From:   Igor Mammedov <imammedo@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2 2/3] KVM: SVM: Modify AVIC GATag to support max
 number of 512 vCPUs
Message-ID: <20230207093350.5db155ca@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230207002156.521736-3-seanjc@google.com>
References: <20230207002156.521736-1-seanjc@google.com>
        <20230207002156.521736-3-seanjc@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Feb 2023 00:21:55 +0000
Sean Christopherson <seanjc@google.com> wrote:

> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Define AVIC_VCPU_ID_MASK based on AVIC_PHYSICAL_MAX_INDEX, i.e. the mask
> that effectively controls the largest guest physical APIC ID supported by
> x2AVIC, instead of hardcoding the number of bits to 8 (and the number of
> VM bits to 24).

Is there any particular reason not to tie it to max supported by KVM
KVM_MAX_VCPU_IDS?

Another question:
 will guest fail to start when configured with more than 512 vCPUs
 or it will start broken?

> 
> The AVIC GATag is programmed into the AMD IOMMU IRTE to provide a
> reference back to KVM in case the IOMMU cannot inject an interrupt into a
> non-running vCPU.  In such a case, the IOMMU notifies software by creating
> a GALog entry with the corresponded GATag, and KVM then uses the GATag to
> find the correct VM+vCPU to kick.  Dropping bit 8 from the GATag results
> in kicking the wrong vCPU when targeting vCPUs with x2APIC ID > 255.
> 
> Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
> Cc: stable@vger.kernel.org
> Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index ca684979e90d..326341a22153 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -27,19 +27,29 @@
>  #include "irq.h"
>  #include "svm.h"
>  
> -/* AVIC GATAG is encoded using VM and VCPU IDs */
> -#define AVIC_VCPU_ID_BITS		8
> -#define AVIC_VCPU_ID_MASK		((1 << AVIC_VCPU_ID_BITS) - 1)
> +/*
> + * Encode the arbitrary VM ID and the vCPU's default APIC ID, i.e the vCPU ID,
> + * into the GATag so that KVM can retrieve the correct vCPU from a GALog entry
> + * if an interrupt can't be delivered, e.g. because the vCPU isn't running.
> + *
> + * For the vCPU ID, use however many bits are currently allowed for the max
> + * guest physical APIC ID (limited by the size of the physical ID table), and
> + * use whatever bits remain to assign arbitrary AVIC IDs to VMs.  Note, the
> + * size of the GATag is defined by hardware (32 bits), but is an opaque value
> + * as far as hardware is concerned.
> + */
> +#define AVIC_VCPU_ID_MASK		AVIC_PHYSICAL_MAX_INDEX_MASK
>  
> -#define AVIC_VM_ID_BITS			24
> -#define AVIC_VM_ID_NR			(1 << AVIC_VM_ID_BITS)
> -#define AVIC_VM_ID_MASK			((1 << AVIC_VM_ID_BITS) - 1)
> +#define AVIC_VM_ID_SHIFT		HWEIGHT32(AVIC_PHYSICAL_MAX_INDEX_MASK)
> +#define AVIC_VM_ID_MASK			(GENMASK(31, AVIC_VM_ID_SHIFT) >> AVIC_VM_ID_SHIFT)
>  
> -#define AVIC_GATAG(x, y)		(((x & AVIC_VM_ID_MASK) << AVIC_VCPU_ID_BITS) | \
> +#define AVIC_GATAG(x, y)		(((x & AVIC_VM_ID_MASK) << AVIC_VM_ID_SHIFT) | \
>  						(y & AVIC_VCPU_ID_MASK))
> -#define AVIC_GATAG_TO_VMID(x)		((x >> AVIC_VCPU_ID_BITS) & AVIC_VM_ID_MASK)
> +#define AVIC_GATAG_TO_VMID(x)		((x >> AVIC_VM_ID_SHIFT) & AVIC_VM_ID_MASK)
>  #define AVIC_GATAG_TO_VCPUID(x)		(x & AVIC_VCPU_ID_MASK)
>  
> +static_assert(AVIC_GATAG(AVIC_VM_ID_MASK, AVIC_VCPU_ID_MASK) == -1u);
> +
>  static bool force_avic;
>  module_param_unsafe(force_avic, bool, 0444);
>  

