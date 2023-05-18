Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7897087C1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjERSYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjERSYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:24:38 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF4FE46
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:24:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d11974b45so861216b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684434276; x=1687026276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OpyylvXibv8EvGCfTZdYQmSeri6SL1uyvIVaeAFD11A=;
        b=b7bQt1minZmnr2zvZfdSq58GrwSnQ65PwX096lykRd7/O0puR8TJTSRNNd7ScBPw54
         KuWSMfvdNwr56sicVT8GnxX4oiogZUK/64JPFyZOaPK96J+ixU8lYgWxyhuksUt82k0i
         W+uiHxq3XQSBAXnhtqLkRV3i78JKP0yVTjTeDFStgm0cfP7isTuZ/DJjqEbiUwZQ3JuO
         VJlNyndI3X6dJ/jgWZKJMCK/m6HodC6OduyJ1DKRf5yWE1ZJBPVjBqXfjCvl/C7rnRjd
         MOV8fZR0mvSIvqkzddGCWcMfhosPgwToZv0MJIa4FpSlNNvdaVAH9CDYnr8A4MM8uz9R
         VO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684434276; x=1687026276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpyylvXibv8EvGCfTZdYQmSeri6SL1uyvIVaeAFD11A=;
        b=EOpLIN636/q1SR1eQce8IX0YoK4xXts6dlgrJ3Bem2WDH88TPPfH0u+ikQB0hWvBnj
         EHnfgom9+nhZgotj8M7xIOztUx1wJ/kF9e+o3CQqxZSpL+STyhBUq2h2MdPnylA2CoTg
         RPhe2vmD6hRiE03aQJl+cDpoqi1M2O8vcg1Y2qnDDcA+ZfRXB98Qxzr5WRPABF3uF6pO
         NFAV76yGkuWeF3KZ0B087yhv+0AeDV4jBDu2BqaeySaFMF0jlMrq0iheEZUXt4wV4CZ0
         qCvbx0H/QqL2Jwpk4CXVr9J8o0xZJi9JudZbnj1b01wQlVkP9m+tw3D/bK1mWG45ldSP
         KR1g==
X-Gm-Message-State: AC+VfDz1fK7QuldmQl6aDWkRbq5KcKEqzGJpBdf2djy6U6pantoxh828
        CriFy9FvehlJOXZkb6ZoeqQLmQ==
X-Google-Smtp-Source: ACHHUZ6Z6A+4bVAZNXNGODfZRR6lq7j9dFBxx/w5HM5Lg6JxFeRPILtOQJ7phK1dd8rgICBChCty+Q==
X-Received: by 2002:a05:6a20:7fa7:b0:109:38b4:a21b with SMTP id d39-20020a056a207fa700b0010938b4a21bmr632340pzj.51.1684434276180;
        Thu, 18 May 2023 11:24:36 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id gk13-20020a17090b118d00b0024ffa911e2asm1692421pjb.51.2023.05.18.11.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 11:24:35 -0700 (PDT)
Date:   Thu, 18 May 2023 18:24:31 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Venkatesh Srinivas <venkateshs@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] KVM: SVM: Remove TSS reloading code after VMEXIT
Message-ID: <ZGZtX1MilF9mPLX/@google.com>
References: <20230518170653.704562-1-mizhang@google.com>
 <ZGZkPqC7SK4AdEGV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGZkPqC7SK4AdEGV@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023, Sean Christopherson wrote:
> On Thu, May 18, 2023, Mingwei Zhang wrote:
> > Remove TSS reloading code after VMEXIT since upstream KVM after [1] has
> > already been using VMLOAD to load host segment state (including TSS).
> > Therefore, reload_tss() becomes redundant. Because of that, also remove the
> > relevant data field tss_desc in svm_cpu_data as well as its data structure
> > definition.
> > 
> > [1] commit e79b91bb3c91 ("KVM: SVM: use vmsave/vmload for saving/restoring additionalhost state")
> 
> This should be
> 
> Fixes: e79b91bb3c91 ("KVM: SVM: use vmsave/vmload for saving/restoring additional host state")
> 
> to make it clear that the code could have, and should have, been removed by that
> commit.

Sure, will do in next version.
> 
> Can you also explain what happens with the TSS busy bit?  I'm staring at a comically
> long internal discussion about this patch, I would likely to capture the important
> bits in the changelog.  Doesn't have to be super verbose, e.g. just an explanation
> that makes it abundantly clear reload_tss() is fully redundant.
> 

Oh, the busy bit was not related with the removal. I was confused about
the busy bit being 0 when being loaded by LTR on SVM side. I thought
this was an inconsistency since on VMX side, immediately after VMEXIT,
TR.type == 11 (1011b) which means busy bit (bit 1) is 1 (SDM vol 3
28.5.2).

It turns out it was just my confusion, since busy bit is to prevent
reloading a 'busy' segment, i.e., if LTR reloads a 'busy' segment, it
triggers #GP at host level. To avoid that, KVM clear the bit in
reload_tss() and make it 'available' (that's why the value is 9).
Immediately after being loaded by LTR, the busy bit will be set again.

> > Reported-by: Venkatesh Srinivas <venkateshs@google.com>
> > Suggested-by: Jim Mattson <jmattson@google.com>
> > Tested-by: Mingwei Zhang <mizhang@google.com>
> 
> Heh, you wrote the code and sent the patch, so it darn well better be tested :-)
> There are scenarios where a Tested-by for the _original_ author is warranted, e.g.
> if someone else tweaked and reposted the patch.  But in this case, there's no need.

I see. I can remove the Tested-by.
