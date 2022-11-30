Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7960063D9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiK3PoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiK3PoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:44:02 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374A8813A7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:44:01 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so2526847pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWYj4UbsrYDXUaUtXQKpO8k7QJT3I0GKK7JL939o2Zo=;
        b=eRJum9V9Y0mumnu06EnMkpixl+HslTcoicODfZIXTuSbZl62i6TBoab7jgMbPAFUTF
         zONFDMXYxEylJYQrcMy4w8lAh/hTm1ah2Ogumeympxrm9nWCBDZqC+JSPxM663YS9ejS
         7nclR5etp6zU45EaOitk+gOLkUngGEiFsJADcIS1m+dIYdcBufNSAJkgSVvCExayiki/
         eoUj2tq/W64xiZIkOH184tON+3sLGjPJjWnSK/hio3nhrzacdwRXTIpkovIWbz2Wn1Na
         FK6M/JW43IMu4xYm9z9x0s9TG0dZ+f9vHBZSPfgMTDkMayZjq3DD0wIMHnEQPw+O1hpL
         4oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWYj4UbsrYDXUaUtXQKpO8k7QJT3I0GKK7JL939o2Zo=;
        b=QXFtRgG1i+DtYXC9mbkgTKPh5fRmSv1t50nogitpPHJRIVzMwy05po5GQ/xzAXn5uk
         q3FQhkhOVzn+4oaBfohy8RqsNK72+mIjsqtxCX79qEGp8cA6apTMVFe4fQR1hnYha0nJ
         S8OVKLBxvj25hGsoJNJEqzsoMv096T9gHWbPMefoZBTfsiMa9zeua+IPBeX65IKlx2yD
         nJCL8jW6xyNcJvzZZ+xpsNpaRRS/LrRTi0Gzd6fGBQq9E8BzT3N4Nht+0bHqbn5R24J1
         ighfg9HaCYoxTqusVmxnMPuQ4pAGTbXw6aphYp7ImuVqgq/d0Ig8SxRQZjgdXvsiU2hn
         MYug==
X-Gm-Message-State: ANoB5pnRqASiutpqjlRNIIC89YfSjffmPSoRWeXt6fiqAE63eroTtMm7
        DoptcT0bfaRYpZNmlCY5p0CTjQ==
X-Google-Smtp-Source: AA0mqf63gIa/w+lHsFJp+tNec6zte69ZBYugly8GQvQ4WJmSpmGJYACw9oJSdrx0eKLW/9Rdfs1hKg==
X-Received: by 2002:a17:90a:2ec5:b0:217:cdc4:afef with SMTP id h5-20020a17090a2ec500b00217cdc4afefmr72371489pjs.115.1669823040523;
        Wed, 30 Nov 2022 07:44:00 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w33-20020a631621000000b004597e92f99dsm1111708pgl.66.2022.11.30.07.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 07:44:00 -0800 (PST)
Date:   Wed, 30 Nov 2022 15:43:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     liujing <liujing@cmss.chinamobile.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Redundant variable assignments can be merged
Message-ID: <Y4d6PEGv4pvKyJeF@google.com>
References: <20221130115504.4282-1-liujing@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130115504.4282-1-liujing@cmss.chinamobile.com>
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

State what the patch does, not what can be done.  And "redundant" isn't the right
word to describe this.

On Wed, Nov 30, 2022, liujing wrote:
> When reading kvm code, find the 'r' variable declaration
> and then assign the value in kvm_vm_ioctl_get_irqchip and
> kvm_vm_ioctl_set_irqchip function, It can be combined into one sentence.

Why though?  I actually kinda like the existing code.

That said, what about removing the variable entirely?  That'd also avoid the
unnecessary call to kvm_pic_update_irq() in set's error path.

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d2ad383da998..898fce19430a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6011,9 +6011,7 @@ static unsigned long kvm_vm_ioctl_get_nr_mmu_pages(struct kvm *kvm)
 static int kvm_vm_ioctl_get_irqchip(struct kvm *kvm, struct kvm_irqchip *chip)
 {
        struct kvm_pic *pic = kvm->arch.vpic;
-       int r;
 
-       r = 0;
        switch (chip->chip_id) {
        case KVM_IRQCHIP_PIC_MASTER:
                memcpy(&chip->chip.pic, &pic->pics[0],
@@ -6027,18 +6025,15 @@ static int kvm_vm_ioctl_get_irqchip(struct kvm *kvm, struct kvm_irqchip *chip)
                kvm_get_ioapic(kvm, &chip->chip.ioapic);
                break;
        default:
-               r = -EINVAL;
-               break;
+               return -EINVAL;
        }
-       return r;
+       return 0;
 }
 
 static int kvm_vm_ioctl_set_irqchip(struct kvm *kvm, struct kvm_irqchip *chip)
 {
        struct kvm_pic *pic = kvm->arch.vpic;
-       int r;
 
-       r = 0;
        switch (chip->chip_id) {
        case KVM_IRQCHIP_PIC_MASTER:
                spin_lock(&pic->lock);
@@ -6056,11 +6051,10 @@ static int kvm_vm_ioctl_set_irqchip(struct kvm *kvm, struct kvm_irqchip *chip)
                kvm_set_ioapic(kvm, &chip->chip.ioapic);
                break;
        default:
-               r = -EINVAL;
-               break;
+               return -EINVAL;
        }
        kvm_pic_update_irq(pic);
-       return r;
+       return 0;
 }
 
 static int kvm_vm_ioctl_get_pit(struct kvm *kvm, struct kvm_pit_state *ps)

