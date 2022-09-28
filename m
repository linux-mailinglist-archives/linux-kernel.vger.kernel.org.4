Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22775EE3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiI1Rza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiI1RzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:55:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B104B65257
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:55:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d82so13158723pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=dSz1xOE/tkJshPgmjGIaZNjAW27JRpctiPLB5h3YCZQ=;
        b=KcCdZSFR6ydnZnR9L+rO6UjK56nefpKQllRU+XxACZggSlA1fSXLya1/T9h6IrXLpd
         MgfmiY/Vndit+fccORLB8jZ/s8c12Z0oP9t6VEyEG+4OPENoYYHLrfoUPXBbjfvDOIAU
         IUAtwtHPrcIdQLLDnAeCAOH+azh73mtvblLkjg3aSOUPURwX2YnzRafE4jQIIZmujP6L
         mv/6Q1MGrrlXLgPrvRMWiHRB60z3rdwrtxUGLzMsXOaq5X1FeqEa/cEi2VMx/8M/oA5T
         2oLNM7L6tepCnglZ0PZnA5ZCSoQsjbhJZoox4NWsZ1n+gQGQltIJbVAJAtV7aqug5G1q
         ImAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=dSz1xOE/tkJshPgmjGIaZNjAW27JRpctiPLB5h3YCZQ=;
        b=awBeyc0PgMz0CSIv98yS8k39pPxugi+QC1z/tgIZ8uhD16BjAqu6AUhufPtlylF+h3
         V7oRvmlC1IP3fEj4wk0HyaZVb+hslStApu+Ax0Zm2EgUnDaOkLxTCJLkmbMlzZzvC3mz
         vZOPWB0nwcOLr4ODtPlumjSv+93WRbm0D0PtbaFL2AOV/86ZTLxza1Y3+xsTXNaSkSRR
         brvnQB8l6q8NKkq40fGe2bIiB+Ta2rEYtETQhnNWY3Xf5OmAtM+EX5adOwwlpyBupDVp
         JmxSq5ae8jPVxqMeSD9JojQDv8co9ItHCdOtedMVT8pDywkT6CkrecZaFprgysINhwu0
         nnHA==
X-Gm-Message-State: ACrzQf0SNYclb5qSahoBPH1AEZi1+uaVxsRHNJ91ZZnpva5EnooQ+EA5
        iqe77Pl8H07rRvq2ukJD/gGBEOlwXn4/5g==
X-Google-Smtp-Source: AMsMyM6UGIipX+U76wA7hwUHGW+K2H+CQidLPVP65hpTOX/Zp68R4hL9oWmUyvHyEOYzxhn0L0SxTg==
X-Received: by 2002:a05:6a00:1ad3:b0:548:962b:4c53 with SMTP id f19-20020a056a001ad300b00548962b4c53mr35480254pfv.59.1664387722025;
        Wed, 28 Sep 2022 10:55:22 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f76-20020a62384f000000b00537b6bfab7fsm4326134pfa.177.2022.09.28.10.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 10:55:21 -0700 (PDT)
Date:   Wed, 28 Sep 2022 17:55:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: disable on 32-bit unless CONFIG_BROKEN
Message-ID: <YzSKhUEg3L1eMKOR@google.com>
References: <20220926165112.603078-1-pbonzini@redhat.com>
 <YzMt24/14n1BVdnI@google.com>
 <ed74c9a9d6a0d2fd2ad8bd98214ad36e97c243a0.camel@redhat.com>
 <15291c3f-d55c-a206-9261-253a1a33dce1@redhat.com>
 <YzRycXDnWgMDgbD7@google.com>
 <ad97d0671774a873175c71c6435763a33569f669.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad97d0671774a873175c71c6435763a33569f669.camel@redhat.com>
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

On Wed, Sep 28, 2022, Maxim Levitsky wrote:
> On Wed, 2022-09-28 at 16:12 +0000, Sean Christopherson wrote:
> > On Wed, Sep 28, 2022, Paolo Bonzini wrote:
> > > On 9/28/22 09:10, Maxim Levitsky wrote:
> > > > I also think that outside KVM developers nobody should be using KVM on 32 bit host.
> > > > 
> > > > However for_developement_  I think that 32 bit KVM support is very useful, as it
> > > > allows to smoke test the support for 32 bit nested hypervisors, which I do once in a while,
> > > > and can even probably be useful to some users (e.g running some legacy stuff in a VM,
> > > > which includes a hypervisor, especially to run really legacy OSes / custom bare metal software,
> > > > using an old hypervisor) - or in other words, 32 bit nested KVM is mostly useless, but
> > > > other 32 bit nested hypervisors can be useful.
> > > > 
> > > > Yes, I can always use an older 32 bit kernel in a guest with KVM support, but as long
> > > > as current kernel works, it is useful to use the same kernel on host and guest.
> > > 
> > > Yeah, I would use older 32 bit kernels just like I use RHEL4 to test PIT
> > > reinjection. :)  But really the ultimate solution to this would be to
> > > improve kvm-unit-tests so that we can compile vmx.c and svm.c for 32-bit.
> > 
> > Agreed.  I too use 32-bit KVM to validate KVM's handling of 32-bit L1 hypervisors,
> > but the maintenance cost is painfully high.
> > 
> 
> But is it actually? I test it routinely and it it does work quite well IMHO.
> I don't remember that there were that much breakage lately in this area.

Oh, I didn't mean that it actually requires a lot of attention in terms of bug
fixes, what I meant by "maintenance cost" is the cost of testing that all the
flavors of 32-bit KVM actually work.  That can be automated to some extent, but
there's a non-trivial cost to maintaining all that automation.

> As far as my opinion goes I do volunteer to test this code more often,
> and I do not want to see the 32 bit KVM support be removed *yet*.

Yeah, I 100% agree that it shouldn't be removed until we have equivalent test
coverage.  But I do think it should an "off-by-default" sort of thing.  Maybe
BROKEN is the wrong dependency though?  E.g. would EXPERT be a better option?
