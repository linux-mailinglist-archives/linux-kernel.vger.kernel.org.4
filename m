Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960D15FE7DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 06:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJNEE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 00:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJNEE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 00:04:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC091A0C36
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 21:04:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y8so3761851pfp.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 21:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=69whWyjyzh0CrmKgjqMMUYf9I0MkOV4bPO2W84F+HI0=;
        b=GPweCxACd3t/5xtzxptPHjQfaOneP4BFPeTan2Yt/UL+5syOZVqP/yy7LqPaZWJ4xu
         EpZ3+9Jy+lNRL5jWAWeJlta7PRPflfSKKcFjYODpLSfr8rH49Cc+HoveavlfXPifThTd
         bY0r6o1zZZXScHjSrHmv3bm26LfGV5nL7OL6YpANVlJMnzA2lLOVvJeFdk5rke5kOB1H
         RkaVVFDmuPkPl0ABLWaJDbfTVjhKXudhfvBXLUgHh7LMyau3CJyCiDlOWiWBrj8dH22k
         V6Gs26UbEYbrmkqD3c/FuJpSmGCVYgfFE8OK+vEHLZyUfyH78RUNjdMNoYygBOQA2dXL
         YlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69whWyjyzh0CrmKgjqMMUYf9I0MkOV4bPO2W84F+HI0=;
        b=ya1Icbu8uXHRoVPRD7wztFvki4Nc6trDC8keYViDy4AFbdBZb78rronRykucGP8M9a
         EhpElfB4mO9k1D/wPFqmPG19NVRdem8F3sQg7C4jyJsCFtdRrb2hH3EsI9+QfO/8deqc
         zhY0Sw8yS5uCxNVV91NvCat1ZvauPgEE3JIqCLIwv3OLHe08ZXDvet/RmvfLbJ14ZJFR
         r6e/vU8sIz8PjqB8chsx/jOYER2o/e0ySElkAkIDU3Ywti7Z3V76gRz5rGmDzPwLZJ/7
         bAujF3eHXu7+EzrLFu5MFhmCPLJJ4uPnJE29TfyKVP2BFgUP7h2vh3CvDAAcg4kgeDlZ
         8awQ==
X-Gm-Message-State: ACrzQf0Vai0qhWM3+947UXvn3DQNtCYiIHKLINnOq+i/bTeUAbeEzESU
        jWXZJHlhqQxQanWsHP5Be7RAzw==
X-Google-Smtp-Source: AMsMyM4fzXvpnFVIWF5pCq2B/HkCfp52hV305FVlJUNnefkIR3qDkBa5FACcH6t8Q01YsxjTqR+7sg==
X-Received: by 2002:aa7:951c:0:b0:562:ca32:3d3f with SMTP id b28-20020aa7951c000000b00562ca323d3fmr2976003pfp.33.1665720262905;
        Thu, 13 Oct 2022 21:04:22 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id t1-20020a17090a448100b001fb1de10a4dsm495733pjg.33.2022.10.13.21.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 21:04:22 -0700 (PDT)
Date:   Fri, 14 Oct 2022 04:04:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     isaku.yamahata@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        isaku.yamahata@gmail.com, Kai Huang <kai.huang@intel.com>,
        Chao Gao <chao.gao@intel.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Huang Ying <ying.huang@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 00/30] KVM: hardware enable/disable reorganize
Message-ID: <Y0jfwi5yo0oMQ5lv@google.com>
References: <cover.1663869838.git.isaku.yamahata@intel.com>
 <Y0da+Sj3BjYnMoh3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0da+Sj3BjYnMoh3@google.com>
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

On Thu, Oct 13, 2022, Sean Christopherson wrote:
> On Thu, Sep 22, 2022, isaku.yamahata@intel.com wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > 
> > This patch series is to implement the suggestion by Sean Christopherson [1]
> > to reorganize enable/disable cpu virtualization feature by replacing
> > the arch-generic current enable/disable logic with PM related hooks. And
> > convert kvm/x86 to use new hooks.
> 
> Thanks for putting this together, actually seeing code is super helpful!
> 
> Unfortunately, after seeing the code, I think my suggestion was a bad one.  At
> the end of this series, there's a rather gross amount of duplicate code between
> x86 and common KVM, and no clear line of sight to improving things.
> 
> Even if we move ARM, s390, and PPC away from the generic hooks, MIPS and RISC-V
> still need the generic implementation, i.e. we'll still have duplicate code.
> 
> Rather than force arch code to implement most/all power management hooks, I think
> we can achieve a similar outcome (let ARM do its own thing, turn s390 and PPC into
> nops) by wrapping the hardware enable/disable (and thus PM code) in a Kconfig,
> e.g. KVM_GENERIC_HARDWARE_ENABLING.
> 
> I'll throw together a rough prototype tomorrow (got partway through and then got
> distracted by other stuff) and hopefully post an RFC series.

Good news and bad news.

Bad news:
The KVM_GENERIC_HARDWARE_ENABLING idea is a bit of a bust.  It works, but it's
little more than a nice-to-have for s390 and PPC.

Good news (from a certain point of view):
The reason that the "generic h/w enabling" doesn't help much is because after sorting
out the myriad issues in KVM initialization, which is even more of a bug-ridden mess
than I initially thought, kvm_init() no longer has _any_ arch hooks.  All the compat
checks and whatnot are handled in x86, so tweaking those for TDX should be easier,
or at the very least, we should have more options.

Sorting everything out is proving to be a nightmare, but I think I have the initial
coding done.  Testing will be fun.  It'll likely be next week before I can post
anything.
