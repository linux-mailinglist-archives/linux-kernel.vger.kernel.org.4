Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99F064F01B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 18:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiLPRNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 12:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiLPRNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 12:13:00 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B566F486
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 09:12:59 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id m4so2947508pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 09:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HuDbHiC4wUMVj9QO97VUpzw7NXrq4bdUCfaP1cTSs0U=;
        b=WcOcOJw5+G8O4M68UYnLFzUz3S99KUX6f5ZH/Nf8CaU6u8BtfWjRzmbyb5Fb0N+kVm
         6esJ6YnepFU9jGqIj972QkgTwBu3E3LmF6cmjkHRctEr30bI50C3iAk8InUfJ2270hR8
         D8/qa//Wu10zvybrwVMsw9Tu9AlD6h+GHDlHlOL0ag/8BRMiTKVf6Y0M3pdsNpIVR/i4
         2rbkDGikJPYWQi+hgDJgbJhRRpQXXVYObmjkpGZgm30vTOvFu8d1Kl+n07pcNsYyjs+X
         fb/jFoWeCpOA6adoXNbqc3zRHJguHv6O20rIJvLl8+Dr6bwL/KBPbfwkEvbMiHeDI46p
         +CIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuDbHiC4wUMVj9QO97VUpzw7NXrq4bdUCfaP1cTSs0U=;
        b=3nRKm44BLg//Jhf4aMDNjCiAxdAUakbNmTISdQaE7NskKgygd1XjwlYp2FqKcDiiZc
         zT5xjKY5L3CmJrko1JXrTRbLmcXdYgPjElbXwa5hfeeksrsiH1jowCQFpp0EcX+b4kUQ
         6gtLwS5Qg05fXWV+5yY5uAmpNByrXG2yXlaHyTLA42eFPS23icl2LwjqEM3bAwPaLBfU
         l+9t/Nd7cpykcj/qq1HE+MIb+CX3Ot9VYD461YbXOi6rkycYNdp7sJ5bLjfucNq8HNcu
         Dqs8XnTapOcRMSb/QqA+D3mIoZPlYWo8FaayjHntaovF5ZAVRvMO/6mO0CbZO52Q9kEW
         BQYQ==
X-Gm-Message-State: AFqh2kqHnRhv+Yaaur4AADZf4oFQuYrj4xErlez/u8bMiLWlBuqI81nA
        xhUBGWjIbQ6dobLhIaer0U+9vA==
X-Google-Smtp-Source: AMrXdXtSx3HWa2OwLDpVxSDrwtppmU5ZjjUlo2AW/Pr+SGauyUDXatDO/Ws8iFne7Nq0LT3Wx5ufQA==
X-Received: by 2002:a17:902:680c:b0:189:a3de:ea2d with SMTP id h12-20020a170902680c00b00189a3deea2dmr652654plk.2.1671210779284;
        Fri, 16 Dec 2022 09:12:59 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id ja5-20020a170902efc500b001873aa85e1fsm1848933plb.305.2022.12.16.09.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:12:57 -0800 (PST)
Date:   Fri, 16 Dec 2022 17:12:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] KVM: x86: add KVM_CAP_DEVICE_CTRL
Message-ID: <Y5ynFUdZXpN5HP7F@google.com>
References: <20221215115207.14784-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215115207.14784-1-wei.w.wang@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022, Wei Wang wrote:
> KVM_CAP_DEVICE_CTRL allows userspace to create emulated device in KVM.
> For example, userspace VFIO implementation needs to create a kvm_device
> (i.e. KVM_DEV_TYPE_VFIO) on x86. So add the cap to allow userspace for
> such use cases.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  arch/x86/kvm/x86.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 69227f77b201..1cdc4469652c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4410,6 +4410,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_VAPIC:
>  	case KVM_CAP_ENABLE_CAP:
>  	case KVM_CAP_VM_DISABLE_NX_HUGE_PAGES:
> +	case KVM_CAP_DEVICE_CTRL:

Rather than hardcode this in x86, I think it would be better to add an #ifdef'd
version in the generic check.  E.g. if MIPS or RISC-V ever gains KVM_VFIO support
then they'll need to enumerate KVM_CAP_DEVICE_CTRL too, and odds are we'll forget
to to do.

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 13e88297f999..f70b9cea95d9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4525,6 +4525,10 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
        case KVM_CAP_BINARY_STATS_FD:
        case KVM_CAP_SYSTEM_EVENT_DATA:
                return 1;
+#ifdef CONFIG_KVM_VFIO
+       case KVM_CAP_DEVICE_CTRL:
+               return 1;
+#endif
        default:
                break;
        }

The other potentially bad idea would be to detect the presence of a device_ops and
delete all of the arch hooks, e.g. 

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 9c5573bc4614..190e9c3b10a7 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -212,7 +212,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
                r = vgic_present;
                break;
        case KVM_CAP_IOEVENTFD:
-       case KVM_CAP_DEVICE_CTRL:
        case KVM_CAP_USER_MEMORY:
        case KVM_CAP_SYNC_MMU:
        case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 04494a4fb37a..21f9fbe96f6a 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -541,7 +541,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
        case KVM_CAP_ENABLE_CAP:
        case KVM_CAP_ONE_REG:
        case KVM_CAP_IOEVENTFD:
-       case KVM_CAP_DEVICE_CTRL:
        case KVM_CAP_IMMEDIATE_EXIT:
        case KVM_CAP_SET_GUEST_DEBUG:
                r = 1;
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index 65a964d7e70d..6efe93b282e1 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -57,7 +57,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 
        switch (ext) {
        case KVM_CAP_IOEVENTFD:
-       case KVM_CAP_DEVICE_CTRL:
        case KVM_CAP_USER_MEMORY:
        case KVM_CAP_SYNC_MMU:
        case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e4890e04b210..191d220b6a30 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -567,7 +567,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
        case KVM_CAP_ENABLE_CAP:
        case KVM_CAP_S390_CSS_SUPPORT:
        case KVM_CAP_IOEVENTFD:
-       case KVM_CAP_DEVICE_CTRL:
        case KVM_CAP_S390_IRQCHIP:
        case KVM_CAP_VM_ATTRIBUTES:
        case KVM_CAP_MP_STATE:
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 13e88297f999..99e3da9ce42d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4525,6 +4525,15 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
        case KVM_CAP_BINARY_STATS_FD:
        case KVM_CAP_SYSTEM_EVENT_DATA:
                return 1;
+       case KVM_CAP_DEVICE_CTRL: {
+               int i;
+
+               for (i = 0; i < ARRAY_SIZE(kvm_device_ops_table); ++) {
+                       if (kvm_device_ops_table[i])
+                               return 1;
+               }
+               return 0;
+       }
        default:
                break;
        }



