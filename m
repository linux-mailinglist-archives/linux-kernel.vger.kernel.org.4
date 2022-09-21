Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D605E5510
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 23:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiIUVQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 17:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiIUVQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 17:16:43 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57EDA00D9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 14:16:42 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id u69so7191628pgd.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 14:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=sh4nf/tEmUd1miKJn6/kAcl9Wj3E8kd7WVZbt4jNU8o=;
        b=ogBoxO3LrxwqQQ7SRIVuERoVZE6Gdagy1dx3mdn2ut0gBZE9tATELfzGad5xs2nkXy
         iOis2gAR0XFaycsbSWI7J84SkuLJXjevcZwhGG+l06YQ215B0SJ4oHKY3LiMVPwdNE6e
         8tnQgmJkM1gaEGfkkJfJiL1eOBW4HMp219Dh6GKkU0c3ltuwMqkhLiaxgRd7nHYkrLyG
         SFeJUscRP74uqSPopi6C6W7kl8FHwpp2AHzCcRG758pCQLNNRYFYaPNO72HR9ntReZ2v
         2GnHQX3jnhG2RMgsUI5S5rQD3k+GMsGiUGcpEp0wRWFIu78f9dNdgxsN1SnHTVVOu/Uf
         DhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sh4nf/tEmUd1miKJn6/kAcl9Wj3E8kd7WVZbt4jNU8o=;
        b=LVOZLjnX3yZhypkcLAv+xCnadsWxEmHmPV7jI3JQukbT1zLs9JosYQAYCfaDJq3Jcd
         B/V9RxWrC3TXzTrb1b53fisxq5bGllrCpO8zIGnyX6f8NI6g9wcPkCaP53n640V7hozb
         h93juYfWre0WyCZu6IH9MGI7S0WNN4e6IkInNNV48nemhRv2ASgdpc/gcFhEct+J0G1E
         6g7MSHTSMoYEJX063k+ClKEKiye+/iN68cyatZfQGRHbF3zrz1N+Bht1e1gaIOCFZDk/
         K8V4AgfqcvtVOkK8++IZElZJpFCq7JScKgt1tADPnYl5vmV4WumIG1+e/GJewTvi1KRi
         Hzew==
X-Gm-Message-State: ACrzQf0hVkzOUe2rT6hXcBBphYxf4LJWM2MRV2844POJe2hmz4ZkTvrz
        2gBbfv/UxoKLD11ypB+X4dxbRQ==
X-Google-Smtp-Source: AMsMyM7gUWK7/YOwc4h5OK29M6VGYSvbsUATTBbOxYuD/sb6e6iIXhXseR+CdxxwL9TdRz+8Zk5pUA==
X-Received: by 2002:a63:581d:0:b0:42b:399:f15a with SMTP id m29-20020a63581d000000b0042b0399f15amr106401pgb.337.1663795002163;
        Wed, 21 Sep 2022 14:16:42 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id n2-20020a634d42000000b0042a55fb60bbsm2337315pgl.28.2022.09.21.14.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 14:16:41 -0700 (PDT)
Date:   Wed, 21 Sep 2022 21:16:38 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 14/39] KVM: nSVM: Keep track of Hyper-V
 hv_vm_id/hv_vp_id
Message-ID: <Yyt/Nrh4aoLrNt11@google.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
 <20220921152436.3673454-15-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921152436.3673454-15-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022, Vitaly Kuznetsov wrote:
> Similar to nSVM, KVM needs to know L2's VM_ID/VP_ID and Partition
> assist page address to handle L2 TLB flush requests.
> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/svm/hyperv.h | 16 ++++++++++++++++
>  arch/x86/kvm/svm/nested.c |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/hyperv.h b/arch/x86/kvm/svm/hyperv.h
> index 7d6d97968fb9..8cf702fed7e5 100644
> --- a/arch/x86/kvm/svm/hyperv.h
> +++ b/arch/x86/kvm/svm/hyperv.h
> @@ -9,6 +9,7 @@
>  #include <asm/mshyperv.h>
>  
>  #include "../hyperv.h"
> +#include "svm.h"
>  
>  /*
>   * Hyper-V uses the software reserved 32 bytes in VMCB
> @@ -32,4 +33,19 @@ struct hv_enlightenments {
>   */
>  #define VMCB_HV_NESTED_ENLIGHTENMENTS VMCB_SW
>  
> +static inline void nested_svm_hv_update_vm_vp_ids(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	struct hv_enlightenments *hve =
> +		(struct hv_enlightenments *)svm->nested.ctl.reserved_sw;

Eww :-)

I posted a small series to fix the casting[*], and as noted in the cover letter it's
going to conflict mightily.  Ignoring merge order for the moment, looking at the
series as a whole, if the Hyper-V definitions are moved to hyperv-tlfs.h, then I'm
tempted to say there's no need for svm/hyperv.h.

There should never be users of this stuff outside of svm/nested.c, and IMO there's
not enough stuff to warrant a separate set of files.  nested_svm_hv_update_vp_assist()
isn't SVM specific and fits better alongside kvm_hv_get_assist_page().

That leaves three functions and ~40 lines of code, which can easily go directly
into svm/nested.c.

I'm definitely not dead set against having hyperv.{ch}, but unless there's a high
probability of SVM+Hyper-V getting to eVMCS levels of enlightenment, my vote is
to put these helpers in svm/nested.c and move then if/when we do end up accumulating
more SVM+Hyper-V code.
  
As for merge order, I don't think there's a need for this series to take a
dependency on the cleanup, especially if these helpers land in nested.c.  Fixing
up the casting and s/hv_enlightenments/hv_vmcb_enlightenments is straightforward.

[*] https://lore.kernel.org/all/20220921201607.3156750-1-seanjc@google.com
