Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2704F66A241
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjAMSlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjAMSlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:41:45 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9743D1DA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:41:42 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jn22so24264923plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=godItNTiu1hFRNSRzyHDiQ09s/Iir0TYSKsoCsWjnBI=;
        b=ETvBwnoWQjAy4YvByjEGST2SfwtwOTHrXBkGCH7CY6CS5ocaYNVmsxWzl03UwSz2vl
         x3+YtwG7slgYRTPbz7quPAROdVldSPr1rg8X1IIdhN4n9G1uHeKtc47dPm+kAYJkPw3/
         kfkgfQzlVLeF9ptQAC+MyzOyCvW28G+mN0j7yVqDXuMtSAYzpwMUfS+AeQO6WXsuJ3So
         cVwE1PVqO4EJIW81fT4RocCow5Iwk5FO85cu18YG/g0KwtMkMYxLQBqTzd5cG27Jnv3+
         u0HagV3CDWxT8onavImXo6uH0GaE1U50G5ghTh6KRwvyRfoYIjhim2uPN4VsNuF/V4Wc
         oy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=godItNTiu1hFRNSRzyHDiQ09s/Iir0TYSKsoCsWjnBI=;
        b=v2979Y92Xa4gvwCcso6hcUkxPS97Zg1pzZXeKOd5eqU5Y+t6lgsdRG25/hhBuIAPGN
         6Db70vBIWTQLb1vnIX49H08IVgqVsij97ew8jopfFjn0OXFsomvy7LimQLcMyW2QB+gD
         OOJaMIGjWvYtvrnb+r6cb3P5HLb/Ep16zw6c8RHdWM3fTSX4s8XT1AFDuT6D3Tf83o1d
         bmf/VTz/jVjqShtv2Oxhvl82mUecsP9n7OdyylZj4dol8ERZV0ly5Auj6ddudonqlaKj
         alhYNHp0hTEyIbKEZIB5RlTIy9I3/fVI+nU0Dk7yZmfw2Vs6Cl8alsmFrMYBypuLXFfC
         omEg==
X-Gm-Message-State: AFqh2kpJzu5+HTsrYL1b4wp57X/b47YO8NoRfePHZpIeVeQ2ju5IJXXL
        7Sgl5nLonQWzNwpTjzndf3Youw==
X-Google-Smtp-Source: AMrXdXvRij7in5oNpdpmDfXW61gvt60eWr/Gx1OLt9EPk0FAutZuxDCB4HdkixgaoHQ2ouBVgm2OKQ==
X-Received: by 2002:a17:90a:d148:b0:229:1e87:365f with SMTP id t8-20020a17090ad14800b002291e87365fmr495333pjw.2.1673635301522;
        Fri, 13 Jan 2023 10:41:41 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090ad71700b0022910fa4d1csm2619706pju.46.2023.01.13.10.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:41:41 -0800 (PST)
Date:   Fri, 13 Jan 2023 18:41:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Orr <marcorr@google.com>, Ben Gardon <bgardon@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>
Subject: Re: [PATCH 0/6] KVM: x86: x2APIC reserved bits/regs fixes
Message-ID: <Y8Gl4ZI3HsFGlALe@google.com>
References: <20230107011025.565472-1-seanjc@google.com>
 <674ac894-12a2-c15f-72c5-878558a8005d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674ac894-12a2-c15f-72c5-878558a8005d@redhat.com>
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

On Fri, Jan 13, 2023, Paolo Bonzini wrote:
> On 1/7/23 02:10, Sean Christopherson wrote:
> > Fixes for edge cases where KVM mishandles reserved bits/regs checks when
> > the vCPU is in x2APIC mode.
> > 
> > The first two patches were previously posted[*], but both patches were
> > broken (as posted against upstream), hence I took full credit for doing
> > the work and changed Marc to a reporter.
> > 
> > The VMX APICv fixes are for bugs found when writing tests.  *sigh*
> > I didn't Cc those to stable as the odds of breaking something when touching
> > the MSR bitmaps seemed higher than someone caring about a 10 year old bug.
> > 
> > AMD x2AVIC support may or may not suffer similar interception bugs, but I
> > don't have hardware to test and this already snowballed further than
> > expected...
> > 
> > [*] https://lore.kernel.org/kvm/20220525173933.1611076-1-venkateshs@chromium.org
> 
> Looks good; please feel free to start gathering this in your tree for 6.3.

Thanks!

> Next week I'll go through Ben's series as well as Aaron's "Clean up the
> supported xfeatures" and others.
> 
> Let me know if you would like me to queue anything of these instead, and
> please remember to set up the tree in linux-next. :)

Ya, next week is going to be dedicated to sorting out maintenance mechanics.
