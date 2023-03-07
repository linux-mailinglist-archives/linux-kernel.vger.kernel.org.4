Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E62E6AF35C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbjCGTED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCGTDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:03:32 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A72BD4FB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:49:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h3-20020a25d003000000b00a1a201a745aso15191847ybg.22
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 10:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678214964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i4l+z8dxC6FwBWTTdD6vm7lmaVH1fdhpvQWMtCJJJTg=;
        b=pgA+qJCRpGKYwP1/DluHxy7PHWVYw4qRQW0VWpuVE6dJdsSylk+SeVw4u/P/Jc522u
         iNCffuZxlrdGIsbKU5NAZq3WWDqW66OqXb5MfNovTq6g8Itz+9XR0pUnXBZRCmyNXL3V
         bdn0wPkod0OItE6/B0oZACNk2ijf49WMMcweOmDJtTS4QslrWalndD3VK3oHl53AST58
         noL9YOB24is1fqM50mIdy3qwQ2pYhS5F8GtH0//FSr+CiCteRBAAZ0ZDf624d5F7lvMF
         tQR1wGm4EG3L7SPFzG++T5kp65GdwLNIuSGC9Wq2SROjhBcO/cH9lgEVDSYohI25muVx
         rLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4l+z8dxC6FwBWTTdD6vm7lmaVH1fdhpvQWMtCJJJTg=;
        b=i0zjqAczJbKeX3aktOzh0zpSPYB0xs55IwX9VPv1MFBmtP7d4bZNesJ1PL4FjMZDYj
         Y3Kgb8RF5VjVvzFN3YetcjxW4SlmWAYDQg+B3FP9RBaW15ncYA2b8m+lN165lR42Wgyn
         QEEPf4NN/4N/blsBnaV8AYYpedVysVO+OhvcSdjbjdM7s2Qm+BlrdCAdRnM1KD0iEtgU
         fsXxTyakkpTJw424GWvS55BcHYHvMzthwlXr3McjrvlGW99mOL9WcSLyccKVWaRGCLuQ
         spbn3jVgXJaLGXWXvpi5zDgSi0hIZS1bJyflbizlHTug3xZr60WsmMCmGs9yNCinBKFM
         p1JA==
X-Gm-Message-State: AO0yUKXp29FfPy0JxyJIcu8pdAbmTTj4jJKtxcH8zMWQFpekCVLjycHG
        BiOCvz1+DhybgphxvjPWVvoJjh1MeVc=
X-Google-Smtp-Source: AK7set/NWAg8xdGFj8VA9sFcQdnpct7pJMc0kT8W/MVHNjSKtOv5NRNFEeoH4WcLXJ4acxdiFZavmxReRVc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:b206:0:b0:8bd:4ab5:18f4 with SMTP id
 i6-20020a25b206000000b008bd4ab518f4mr12227961ybj.6.1678214963986; Tue, 07 Mar
 2023 10:49:23 -0800 (PST)
Date:   Tue, 7 Mar 2023 10:49:22 -0800
In-Reply-To: <20230306215450.GFZAZhKnr6zMCeeDNd@fat_crate.local>
Mime-Version: 1.0
References: <Y/5oBKi6vjZe83ac@zn.tnic> <20230228222416.61484-1-itazur@amazon.com>
 <Y/6FIeJ5KCOfKEPN@zn.tnic> <ZAZYKe4L8jhMG4An@google.com> <20230306214419.GDZAZes941k+4NPgDL@fat_crate.local>
 <25249e7d-4fd9-e1c1-8efb-31750740ec27@redhat.com> <20230306215450.GFZAZhKnr6zMCeeDNd@fat_crate.local>
Message-ID: <ZAeHMgp9U7giJpHs@google.com>
Subject: Re: [PATCH 0/2] KVM: x86: Propagate AMD-specific IBRS bits to guests
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Takahiro Itazuri <itazur@amazon.com>,
        dave.hansen@linux.intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org, zulinx86@gmail.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023, Borislav Petkov wrote:
> On Mon, Mar 06, 2023 at 10:47:18PM +0100, Paolo Bonzini wrote:
> > It's very rare that KVM can provide a CPUID feature if the kernel has
> > masked it,
> 
> I'm talking about pure hw feature bits which don't need any enablement.
> Like AVX512 insns subset support or something else which the hw does
> without the need for the kernel.
> 
> Those should be KVM-only if baremetal doesn't use them.

I don't see what such a rule buys us beyond complexity and, IMO, unnecessary
maintenance burden.  As Paolo pointed out, when there's an existing word, the
only "cost" is the existence of the #define.  The bit is still present in the
capabilities, and KVM relies on this!  And as mentioned in the tangent about
reworking cpufeatures[*], I get a _lot_ of value out of cpufeatures.h being fully
populated for known bits (in defined words).

Forcing KVM to #define bits in reverse_cpuid.h just because the kernel doesn't
need the macro will inevitably lead to confusion for KVM developers, both when
writing new code and when reading existing code.

[*] https://lore.kernel.org/all/Y8nhtjFcsB63UsmQ@google.com
