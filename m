Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE35BB290
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiIPS6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiIPS6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:58:33 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61454B8A7D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:58:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fv3so21960561pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=PlHo0xyLGdLqEdXMFRBU/X5JCw5pNM4+UDTsxBu4468=;
        b=VQ4dg1YxvysrbEiXhKx3kUTs2ResK/Th4k8uStRpIrcw2YAdDz9ysKkDpvgXkG0qO6
         SnMlQ0DIXcmNDrboi37sHDEB6Q7YgrhnOF50oQfgdZP08LmsRpQFgCpzw6JExAZ8z4RD
         nneOHDQzMuxP1bQCRFBFXmHV6dV11KLkkn4WaN0fnr6JL1xaqe6x6j6GNcwNjw4n7gT2
         oKF9HjxH1PdqsnFozSFKCAERUptQEbIm2cqJbmlekO7IkSaj+D8o358ABvRn2GknYqIt
         ekpM+Yml78Ul2hZD5mberY0lSz+zQ71PmkiOV39m46DU3+Dio+M682zm0ULFWxVms6bm
         FSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=PlHo0xyLGdLqEdXMFRBU/X5JCw5pNM4+UDTsxBu4468=;
        b=HK064SN6y1ffdl4BZ66bAX/i8Iaqdt7himzcYk4PxHd8aVQw1yYYEJk/Ksgg8lCqQe
         T0dVSJ+ZcHE9iU/EJAlc/byEbeX/hsLYytx+WI3iQhoTcZq6OYqKE/qH5MibTZsNkLlF
         KxALMFTmuXVGDa0ufVhPu7mSgZxDUSJ9LhKFOYHYs18t+EF9PgAfYSBarlHe8HJhbgJy
         q8BafO9/CXDTmGQhZZ/sjz2N+8uJR9xzxrG7wtuoZB6I34rAKLGoRF0CZBOAK6+7lN0g
         gyN2XHYE9dng1UwqTZAVCBUOpoWgRiaWpQ1XVQGFaJAZ8PZ/qHnycrWdAKUrwi7XjXbf
         HLkQ==
X-Gm-Message-State: ACrzQf1f6lMH48KRu8dctuSKH1MO7EKO19hc/ci4eS0cbY38pCGyQEpz
        +rbW9RYD0D1W55UE5Qe4ZQD9ZhtqeGG4vg==
X-Google-Smtp-Source: AMsMyM48WpsycIcHQPeZT1Ca5HCtL2TPyz+mMky2ox1cpnkMjfe8ZFxaLJnR5wRxEwsKoUnS+UEM2Q==
X-Received: by 2002:a17:903:2406:b0:174:f1c8:76bc with SMTP id e6-20020a170903240600b00174f1c876bcmr1230326plo.168.1663354710804;
        Fri, 16 Sep 2022 11:58:30 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902da8300b001714e7608fdsm15374333plx.256.2022.09.16.11.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:58:30 -0700 (PDT)
Date:   Fri, 16 Sep 2022 18:58:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH 16/19] KVM: x86: Explicitly track all possibilities for
 APIC map's logical modes
Message-ID: <YyTHUi3BXrOo4OpU@google.com>
References: <20220831003506.4117148-1-seanjc@google.com>
 <20220831003506.4117148-17-seanjc@google.com>
 <8d3569a8b2d1563eb3ff665118ffc5c8d7e1e2f2.camel@redhat.com>
 <Yw+Sz+5rB+QNP2Z9@google.com>
 <510a641f6393ff11c00277df58c1d2a7b6e9a696.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <510a641f6393ff11c00277df58c1d2a7b6e9a696.camel@redhat.com>
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

On Wed, Aug 31, 2022, Maxim Levitsky wrote:
> On Wed, 2022-08-31 at 16:56 +0000, Sean Christopherson wrote:
> > On Wed, Aug 31, 2022, Maxim Levitsky wrote:
> > > > @@ -993,7 +1011,7 @@ static bool kvm_apic_is_broadcast_dest(struct kvm *kvm, struct kvm_lapic **src,
> > > >  {
> > > >  	if (kvm->arch.x2apic_broadcast_quirk_disabled) {
> > > >  		if ((irq->dest_id == APIC_BROADCAST &&
> > > > -				map->mode != KVM_APIC_MODE_X2APIC))
> > > > +		     map->logical_mode != KVM_APIC_MODE_X2APIC))
> > > >  			return true;
> > > >  		if (irq->dest_id == X2APIC_BROADCAST)
> > > >  			return true;
> > > 
> > > To be honest I would put that patch first, and then do all the other patches,
> > > this way you would avoid all of the hacks they do and removed here.
> > 
> > I did it this way so that I could test this patch for correctness.  Without the
> > bug fixes in place it's not really possible to verify this patch is 100% correct.
> > 
> > I completely agree that it would be a lot easier to read/understand/review if
> > this came first, but I'd rather not sacrifice the ability to easily test this patch.
> > 
> 
> I am not 100% sure about this, but I won't argue about it, let it be.

Whelp, so much for my argument.  I'm going to bite the bullet and move this patch
first so that the fix for logical x2APIC mode[*] doesn't need to pile on the hacks.

[*] https://lore.kernel.org/all/YyTF7SsMjm+pClqh@google.com
