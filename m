Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9F565F334
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbjAERyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjAERyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:54:05 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB11564C4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:54:04 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9so23334996pll.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 09:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cki/PxKhTRHGR7jPZFPgJ3ufeXyR+R3NkPyw2otVHc0=;
        b=KzlujmWKGL0ktFX9aJ5d0aKf9Uir0j84bC0WPArdD5JHfVndwQw8Xt2ZHC40eEAx30
         F+1oI5N3nlSVD3eH1bahWIW2Za0bGawdPCVoi4oraC9F/rABXkMrs3EVsmyK2TFt+rG3
         UII9yxA6hImSc+vTi8yxfFJ1E1I6cIEwKyeSA1y6fAynwXWdMMbaCxtU9AZnfwDYoupr
         gTPHLmw6A+sYoG78XpIi1Bi3N1vUKdCGJ2VnmFgOg0/Au9SW239r5VKLf7o80DSranUf
         l+XNbSzqj3WptvkvdLk59PH1gEzXyRdyq6df7Hy516jyiLi+LNo5fmWN5/NHxpJWYbnT
         XChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cki/PxKhTRHGR7jPZFPgJ3ufeXyR+R3NkPyw2otVHc0=;
        b=NVj5QhHtrs8RhbFJ0mubP+yuUZ9zt0CADQMANgt5MJ8ajPehBbaPJf9+GxbiQuWFMU
         vQmmJF5H84iz2w9zxeqGy7mDs4ETWJ92jsjWQ1Y0Jcu1yuu+81umjGPvmPWULRwPG0+L
         1bJkuUMiX6CM1IpTdl1cG4b+L2Pwrvr+/8cAVP6KS2KSU45olr+FdrFwxOTw/vRFkOuI
         ybJeymylhwAVWUMOnETkQn90n6jsiwI4wXaso+fxjlpWY7rbliCILY2NdoDd+11OTTFn
         relRIE89B986k8XKj5OtAij9mTEtFAMquvIcilqnaguV7Ux7AoLA1yL+evHx/fyTIbwc
         q3Sw==
X-Gm-Message-State: AFqh2krH9z6WjkQ7s7npoaRqBwByxslpyC8HAxCjnGW8ZWCVlQbRE2eA
        zX3kyta6GaqitimvTkyKT9blyQ==
X-Google-Smtp-Source: AMrXdXv19Ic4XIQPBb0kJZbG2hoj1COypIyVT70px3soIaHgUUwGTy4rSjVuAulrdSg44dUGw51wBw==
X-Received: by 2002:a17:902:f1c5:b0:189:3a04:4466 with SMTP id e5-20020a170902f1c500b001893a044466mr289415plc.2.1672941243498;
        Thu, 05 Jan 2023 09:54:03 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709026f1000b00192dcd1b0e5sm5676409plk.265.2023.01.05.09.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:54:03 -0800 (PST)
Date:   Thu, 5 Jan 2023 17:53:59 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, kvm@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH 26/27] KVM: x86/mmu: Add page-track API to query if a gfn
 is valid
Message-ID: <Y7cOt5R/wK2Y1fg5@google.com>
References: <20221223005739.1295925-1-seanjc@google.com>
 <20221223005739.1295925-27-seanjc@google.com>
 <Y6v287BFez8tU43e@yzhao56-desk.sh.intel.com>
 <Y7SbxcdYa7LKR43f@google.com>
 <Y7ZAEsQbNbWKngGi@yzhao56-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7ZAEsQbNbWKngGi@yzhao56-desk.sh.intel.com>
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

On Thu, Jan 05, 2023, Yan Zhao wrote:
> On Tue, Jan 03, 2023 at 09:19:01PM +0000, Sean Christopherson wrote:
> > On Wed, Dec 28, 2022, Yan Zhao wrote:
> > > On Fri, Dec 23, 2022 at 12:57:38AM +0000, Sean Christopherson wrote:
> > > > +bool kvm_page_track_is_valid_gfn(struct kvm *kvm, gfn_t gfn)
> > > > +{
> > > > +	bool ret;
> > > > +	int idx;
> > > > +
> > > > +	idx = srcu_read_lock(&kvm->srcu);
> > > > +	ret = kvm_is_visible_gfn(kvm, gfn);
> > > > +	srcu_read_unlock(&kvm->srcu, idx);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(kvm_page_track_is_valid_gfn);
> > > This implementation is only to check whether a GFN is within a visible
> > > kvm memslot. So, why this helper function is named kvm_page_track_xxx()?
> > > Don't think it's anything related to page track, and not all of its callers
> > > in KVMGT are for page tracking.
> > 
> > KVMGT is the only user of kvm_page_track_is_valid_gfn().  kvm_is_visible_gfn()
> > has other users, just not in x86.  And long term, my goal is to allow building
> > KVM x86 without any exports.  Killing off KVM's "internal" (for vendor modules)
> > exports for select Kconfigs is easy enough, add adding a dedicated page-track API
> > solves the KVMGT angle.
> Understand!
> But personally, I don't like merging this API into page-track API as
> it obviously has nothing to do with page-track stuffs, and KVMGT also calls it for
> non-page-track purpuse.

100% agreed, but as discussed in the other patch[*], IMO the real issue is that
KVMGT is abusing KVM APIs to check the validity of GFNs that are ultimately mapped
via VFIO.  Once that issue is fixed, kvm_page_track_is_valid_gfn() can go away
entirely.  I view this as a short/medium term hack-a-fix to limit and encapsulate
KVM's API surface that is "needed" by KVMGT.

[*] https://lore.kernel.org/all/Y7cLkLUMCy+XLRwm@google.com
