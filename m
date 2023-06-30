Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C99743F07
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjF3PhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjF3PhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:37:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E06B4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:37:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5734d919156so19217927b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688139428; x=1690731428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2bdagaR5N1qIFZFzXqIi1uWqn/bfAiw0c0oO57kq+nk=;
        b=uXJ9O6qfWdldgDsjuntnftMM7qQJfvFQeahSqQ1ggMIEOuduwnzqedr89fbQSwyX3y
         69liEDrUS89Mna80gPnZj9SSWOxAXWQ+AXL+3EpJDL5bi1yWAGYi0dJxql4YZx7q+rHo
         kPwDS7Zc1fuMZ6eJ8gzVvmdfHx/U5edBjcuSC2K/3aCu1tMTMFP7CuLH9LfXT/gZd4wM
         cVNuNiAjZoK8uEWnnjwV6qvCsxJOiY06W+8AytXoa8q1N7XdnkvDLNlzj38wkClMWZnM
         zo5+GIMafrtJOQCoHaSghQo76lX4ae7GXByj8elgsIvYBEp7ljkzDcRkbdW0cTfXc+qr
         EeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688139428; x=1690731428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bdagaR5N1qIFZFzXqIi1uWqn/bfAiw0c0oO57kq+nk=;
        b=Tch7qIQ0HvMhYR4BDUw+y43aw2EH73x5iEVaSGJ8KJxLGZgRRc/UdMtNcTYgdmpxqV
         FDbfiYJ8tWpxvEYvvHR0bRegeaOLc5b43wbeEsgC5PsRLSczI57V5DzGE/VsHaX/+M2A
         iddubiP7Ay0Dx8wEB/qnq8X0/5bB3/jDScrtaOq0HrABgUlgu1FOd+5HRqIPYuBNAvkY
         vhEaZ6vgJQJTdawDlmpYu1zA02iLK532hfNeK3hd6/dYBMUIWrVdHb3T/in5HOqd8bSd
         su9DkVbrdutKqXe29ALR/aEeEe54dOdx89DjAYF6gBWlmXKc8iyws/LUmLBkd4yXvYCT
         ZkGg==
X-Gm-Message-State: ABy/qLYTCS25hEXxILPCE9GTcyOHNgIUUWN8J2keLloa1y1OitUb5YAS
        eDTZc2Cnv2Tb7zVTEl7/xbjTpLzD9Ts=
X-Google-Smtp-Source: APBJJlH/uQWpr30lhFP7FUBhm2MxHCzEed19skQiSf4QGVih73ZchxcUBLHXypB7iNCVn2LK3aQlcjxDBd4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:8d52:0:b0:56d:2abf:f0c with SMTP id
 w18-20020a818d52000000b0056d2abf0f0cmr25114ywj.10.1688139428278; Fri, 30 Jun
 2023 08:37:08 -0700 (PDT)
Date:   Fri, 30 Jun 2023 08:37:06 -0700
In-Reply-To: <20230630050157.kurgzdcpjngs6w4k@yy-desk-7060>
Mime-Version: 1.0
References: <20230628071217.71126-1-ishiir@g.ecc.u-tokyo.ac.jp>
 <ZJxTTZzZnfbyMVIH@google.com> <ZJ0w5pKk/41Zv26i@yzhao56-desk.sh.intel.com>
 <ZJ3FyLUYrlr6+HLw@google.com> <ZJ3p5wBwyQZ+aQOV@google.com> <20230630050157.kurgzdcpjngs6w4k@yy-desk-7060>
Message-ID: <ZJ72omPGZcdjjWbo@google.com>
Subject: Re: [PATCH] KVM: nVMX: Prevent vmlaunch with EPTP pointing outside
 assigned memory area
From:   Sean Christopherson <seanjc@google.com>
To:     Yuan Yao <yuan.yao@linux.intel.com>
Cc:     Yan Zhao <yan.y.zhao@intel.com>,
        Reima Ishii <ishiir@g.ecc.u-tokyo.ac.jp>,
        shina@ecc.u-tokyo.ac.jp, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuan.yao@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023, Yuan Yao wrote:
> On Thu, Jun 29, 2023 at 01:30:31PM -0700, Sean Christopherson wrote:
> > @@ -3834,8 +3822,8 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
> >  			if (!(pdptrs[i] & PT_PRESENT_MASK))
> >  				continue;
> >
> > -			if (mmu_check_root(vcpu, pdptrs[i] >> PAGE_SHIFT))
> > -				return 1;
> > +			if (kvm_vcpu_is_visible_gfn(vcpu, pdptrs[i] >> PAGE_SHIFT))
> > +				pdptrs[i] = 0;
> 
> Hi Sean,
> 
> Should this be "!kvm_vcpu_is_visible_gfn(vcpu, pdptrs[i] >> PAGE_SHIFT)" and

Yep, typo that inverted the check.  Thanks for saving me some debug time!

> turn the pae_root[i] to dummy root yet ?

No, zeroing the PDPTR is sufficient.  Unlike CR3, which is always "present", PDPTRs
have a present bit and so KVM can communicate to hardware that the entry isn't
valid simply by clearing the PDPTPR.
