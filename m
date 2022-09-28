Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE7A5EE960
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiI1Wca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiI1Wc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:32:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370ED883E6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:32:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cv6so3451839pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=BkGyvVCgmDZEu5V9VmSFPoM0FCAbYlEq7mrPkuSdEDQ=;
        b=bu85QxF8QZB+kSJKQSO1zhV36mGIgnf8oEAXMwNiep+sJwXIDslPfTTr9ELbX27j3D
         iHWuKAs7L512dP9StHLkdOZIL5xdpIo1udlf34xGedjT7PBXlL+wHmD2z3ujcrr0gjFc
         dTO+NACofreeseYAXQlAFl08fW1K/WnjSPNks9hjrtJs0+kx/n8ZwcmcT/W9pXVRUctL
         pqXo3ssT4HCnFx33V2l45cOG2AjNtRoz6lLTEgWYdXsbAe2EQoeDEOmtGfdEpS1yG0XU
         cs5WV7UOpr6AwBqUxOyQ7g5mt0TyGcLazxc0Vs6yrDsZbnkwzmjfhQiP2mrQhCjLL5N6
         V9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BkGyvVCgmDZEu5V9VmSFPoM0FCAbYlEq7mrPkuSdEDQ=;
        b=fYDdTjpbBv9RPPcWi62GCcNC1lrpz+EXuFuzyYGD7pOmyJz+V+GOKlBQIxffyPKi4C
         Sw51p28I5j02hwNXAgDzeO6y0emdNp9sj0WNcR6atxvgrmPKVukvpWbh+QUzzEpG2S+R
         EBsjtkfde2ilM5gRS+rwxV06vWxrj0+L1RaxGWAcxntYmQ7vsRYg2cxCCm/BUeUKN/GP
         8ue5pNtbtZ94rdaaAGm6nL3dhJZl6OFzSoBPipI/YiXorcld/5IQFTJn+Ro4CbEH1/GP
         Ins3b1Ig3ZJjCWu9aSqEqfmQ5oWlWlIz1eSw/Feq26+fO1q9cd9ylPVURLrq5Vfr8JT/
         ycLg==
X-Gm-Message-State: ACrzQf0y7cpr/tRJ9oGI5e1H5ePlyE2WpET8hk3v+uBPSCPLulVFIiDw
        3r7qVA9bDsaoorGTqL1RSjyZ3EP8ePShlw==
X-Google-Smtp-Source: AMsMyM5b60Sd6Uahlu1saCEy6+JTaKUrnQB5Ntb196j+a9R4Tma9gGJxN4xF6tV8YuaUyz54ts/21w==
X-Received: by 2002:a17:903:32cc:b0:178:41c1:2e41 with SMTP id i12-20020a17090332cc00b0017841c12e41mr216850plr.126.1664404346654;
        Wed, 28 Sep 2022 15:32:26 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7950e000000b00545b91e78d3sm4479903pfp.89.2022.09.28.15.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:32:26 -0700 (PDT)
Date:   Wed, 28 Sep 2022 22:32:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, avagin@gmail.com
Subject: Re: [PATCH v2 4/4] x86/fpu: Correct the legacy state offset and size
 information
Message-ID: <YzTLdnlmkhfTZLqP@google.com>
References: <20220922200034.23759-1-chang.seok.bae@intel.com>
 <20220922200034.23759-5-chang.seok.bae@intel.com>
 <YzS3SXVxJOrC/k5X@google.com>
 <16abaac3-d73f-2d00-f785-a16ec32139f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16abaac3-d73f-2d00-f785-a16ec32139f1@intel.com>
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

On Wed, Sep 28, 2022, Chang S. Bae wrote:
> On 9/28/2022 2:06 PM, Sean Christopherson wrote:
> > On Thu, Sep 22, 2022, Chang S. Bae wrote:
> > > 
> > > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> > > index a3f7045d1f8e..ac2ec5d6e7e4 100644
> > > --- a/arch/x86/kernel/fpu/xstate.c
> > > +++ b/arch/x86/kernel/fpu/xstate.c
> > > @@ -143,8 +143,13 @@ static unsigned int xfeature_get_offset(u64 xcomp_bv, int xfeature)
> > >   	 * offsets.
> > >   	 */
> > >   	if (!cpu_feature_enabled(X86_FEATURE_XCOMPACTED) ||
> > > -	    xfeature <= XFEATURE_SSE)
> > > +	    xfeature <= XFEATURE_SSE) {
> > > +		if (xfeature <= XFEATURE_SSE)
> > > +			pr_warn("The legacy state (%d) is discontiguously located.\n",
> > > +				xfeature);
> > 
> > pr_warn() here isn't warranted.  copy_uabi_to_xstate() calls this with non-extended
> > features,
> 
> I think patch1 makes changes not to call this for legacy features anymore.

Oh, even better!  In that case, drop patch 3 and WARN here, because with that
call site gone, all paths that lead to xfeature_get_offset() avoid calling it
with legacy features.

The comment above this probably needs to be updated too.

I was going to make that suggestion in my original response, but I didn't apply
the series and so didn't see that that last remaining wart was fixed.  Thanks,
and sorry for the runaround!

> > which is perfectly fine since it manually handles MXCSR.  And that helper
> > is directly reachable by userspace, i.e. userspace can spam the pr_warn().
> 
> I don't think I get your point. I assume that helper is __raw_xsave_addr().
> But then I'm missing how it can be directly reached by userspace.

ioctl(KVM_GET_XSAVE) can reach this code, i.e. if there were a bug then userspace
could invoke that ioctl() in a tight loop to spam the kernel log.
