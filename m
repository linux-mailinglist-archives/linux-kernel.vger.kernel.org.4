Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF18647A6C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 01:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLIABy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 19:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLIABe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 19:01:34 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13B27E826
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:01:32 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id o18-20020a17090aac1200b00219ca917708so5040114pjq.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 16:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQDyBGxn9oKQSJ36TPeV1tHejbsNuk0Tq6opu8KMS6M=;
        b=IK8pFTQ9Da+S6XfZpBCwS7QwzDhrgOtVaCNneEWExLRG6q2EIyoU5fkBUbDsvHATtm
         w/M/MsAolhZDO9FfCOEX06Jab6ZnlXgr0H05QBI8QHwdgVJHeDSYHUHm6AMA2+RRE2Ie
         o7LMqwm7uVctLIRtkhrDj2Ev8jmN+SRvGGkdNmZsSiHUgv3T7GIy+STj1TZG/Pcm4Ga8
         rSrr9fePXQSvWaV3FWnLDChRELY1rucQSSC18HEdYo6ML20Vvr0MuS6dkmysfWLHd9jq
         v0oDWp42wRaAopN7NDFU3IDLwn748F//vU6L3nYw7TzxMOpkk66ydwoy2dfZBfo5l5ag
         FaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQDyBGxn9oKQSJ36TPeV1tHejbsNuk0Tq6opu8KMS6M=;
        b=ipvNgzTi1xXJA8xdb8emp7ID+ceT1/YNsAwZBidkDW+O8VF+WKMIsAZ3pb0ETWdOgc
         ACWkuCUt04VwGjDCP6UWCMbBuxabUZ4i9RoP9kw1jvz+Qh4x0YdJd/gduFKL7qY1OMLm
         fv0qNmh8/4uGFx9+0Viygnl4VbId/Nmf5UtxN0DXWkjcWNsEzhWsGH7+xeCBVfl7sTty
         IdYoMzPXldUgqdmBALNUvEPIXBRNU0Jxw47/gCBTQ9kGeZ1Jo2zEiOG7IYFZjUpUBzGC
         d4F0Ey6oUmMWdl7gLu2Wf8Y/bO6rs0d6sU7jJ7nFwzyRIX9Z+gZu7pHbLlQOQsIqv8QK
         067A==
X-Gm-Message-State: ANoB5pld8QWzXKsT71cNHhU0ee9+Ru5qnB1Y3ZFoVh1vmU+BAcOSFogC
        XfzuPIrBdX2Q31GEoWtU5xyz2fYhph3JqWcz
X-Google-Smtp-Source: AA0mqf4C2tKlCGFo4SmAI7JfZJdzuBEKd/k+DmEm1fAyjHNHwsiwektdLVgXsUj8efcNjXROQq822Wr7kD2q3ilL
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a63:110d:0:b0:46e:bcc1:28df with SMTP
 id g13-20020a63110d000000b0046ebcc128dfmr68453251pgl.187.1670544092360; Thu,
 08 Dec 2022 16:01:32 -0800 (PST)
Date:   Fri,  9 Dec 2022 00:01:30 +0000
In-Reply-To: <b49d953a-61f0-e466-90d2-713e25dff770@linux.intel.com>
Mime-Version: 1.0
References: <b49d953a-61f0-e466-90d2-713e25dff770@linux.intel.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221209000130.1380904-1-vannapurve@google.com>
Subject: [PATCH v10 062/108] KVM: x86/tdp_mmu: implement MapGPA hypercall for TDX
From:   Vishal Annapurve <vannapurve@google.com>
To:     binbin.wu@linux.intel.com
Cc:     dmatlack@google.com, erdemaktas@google.com,
        isaku.yamahata@gmail.com, isaku.yamahata@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, sagis@google.com, seanjc@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +int __kvm_mmu_map_gpa(struct kvm *kvm, gfn_t *startp, gfn_t end,
> +		      bool map_private)
> +{
> +	gfn_t start = *startp;
> +	int attr;
> +	int ret;
> +
> +	if (!kvm_gfn_shared_mask(kvm))
> +		return -EOPNOTSUPP;
> +
> +	attr = map_private ? KVM_MEM_ATTR_PRIVATE : KVM_MEM_ATTR_SHARED;
> +	start = start & ~kvm_gfn_shared_mask(kvm);
> +	end = end & ~kvm_gfn_shared_mask(kvm);
> +
> +	/*
> +	 * To make the following kvm_vm_set_mem_attr() success within spinlock
> +	 * without memory allocation.
> +	 */
> +	ret = kvm_vm_reserve_mem_attr(kvm, start, end);
> +	if (ret)
> +		return ret;
> +
> +	write_lock(&kvm-> mmu_lock);
> +	if (is_tdp_mmu_enabled(kvm)) {
> +		gfn_t s = start;
> +
> +		ret = kvm_tdp_mmu_map_gpa(kvm, &s, end, map_private);
> +		if (!ret) {
> +			KVM_BUG_ON(kvm_vm_set_mem_attr(kvm, attr, start, end), kvm);

This will result in no exits to userspace during memory conversion requests from
guests. And as a result, userspace will not be able to explicitly back/unback
shared/private memory during conversions leading to double allocation of memory.

Is this an intended behavior for memory conversion with TDX VMs as per earlier
discussion?

> +		} else if (ret == -EAGAIN) {
> +			KVM_BUG_ON(kvm_vm_set_mem_attr(kvm, attr, start, s), kvm);
> +			start = s;
> +		}
> +	} else {
> +		ret = -EOPNOTSUPP;
> +	}
> +	write_unlock(&kvm-> mmu_lock);
> +
> +	if (ret == -EAGAIN) {
> +		if (map_private)
