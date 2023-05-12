Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EF870127B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbjELXaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbjELXab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:30:31 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1D3358A
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:30:26 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-52857fc23b1so9890066a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683934226; x=1686526226;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/QFGmFTNFWTz/qL0ytwDs6C7o76RN6Kb8g1Op6SXqE=;
        b=RAX2/ENILv9p9Rqr0mBXOdbAaA6rFYqN3VcLYSzz4ai1XaZdS4XCB2rUavinsOjgna
         8zQE0X8GDlMXyD3AQA7jdkhawiti9RiWaBLfZYxb3kY/33dwGN1VJp0uUZnaT1klqqpn
         SmyHP4CB//45m+Yvt93TOjXUvCaUH00QfVfFmcyBXwYrgTUsdLKo9h2k8aDifl2eiA4t
         gV2jMx9z+0Y0YiGUV444TUgvNpYxIcRVyJDierddl7bQe7oFgo34XVVnux5QAwfw+DkZ
         8fR3IqeZ37pMnB0sWM6bhK5nN2+yB6vRbncI/vC0/daBn95hSe12sGv9ph3SEXCVvWeO
         fLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683934226; x=1686526226;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/QFGmFTNFWTz/qL0ytwDs6C7o76RN6Kb8g1Op6SXqE=;
        b=L5Ib0sYfQy9ZhuOlAzFDCsC/BA2gpEtMwe/0WPsalOr/Nq0+J015UDMb4akwxAxJXC
         c0ZvAOKko2JEB3T9DSYIXmkK366qYjsDWNRYdH2qBT9/jz7GtUj5//9OIvOJAbMLaQsd
         xQ168xDvBV+mHTh1Wk6MN6TIlaedisnN5hUXt3pjmRS4Niri3MvU3+Kcs2G4s6tGQ7cV
         8I4NJSVISrCROUimllJCKMs+cpaViIf2woVBq7QLNo2dF+Ee/wtBMrGhWJ0y99il+uic
         NWHP7aIP55hpLlUu66bSdkppfe/ULeo01S6tM4A/4QEJfJca6gt9iyan4X2ntbIdPiw3
         LT7A==
X-Gm-Message-State: AC+VfDyHmctYj5fvZvTaISogpjhY5QoFzsfdP1zD/PxdTEvqhVv7rT83
        vm1HlwsLTeKrwf9x8V1/oERyWbYcQ/w=
X-Google-Smtp-Source: ACHHUZ56CHgNKxromyGnk2MJ4PmHsYY+UgcnX3d8oUez/B0nBcLFZiz4BJJ7thMCKQLZxtMzaVMQ3TQM8BM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:151:0:b0:52c:6149:f6be with SMTP id
 78-20020a630151000000b0052c6149f6bemr7423404pgb.4.1683934226402; Fri, 12 May
 2023 16:30:26 -0700 (PDT)
Date:   Fri, 12 May 2023 16:30:25 -0700
In-Reply-To: <ZF7KbsCXBQHnOv7g@google.com>
Mime-Version: 1.0
References: <20230511235917.639770-1-seanjc@google.com> <20230511235917.639770-5-seanjc@google.com>
 <ZF7KbsCXBQHnOv7g@google.com>
Message-ID: <ZF7MES4qEKd8T6OW@google.com>
Subject: Re: [PATCH 4/9] KVM: x86/mmu: Rename MMU_WARN_ON() to KVM_MMU_WARN_ON()
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>
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

On Fri, May 12, 2023, David Matlack wrote:
> On Thu, May 11, 2023 at 04:59:12PM -0700, Sean Christopherson wrote:
> > Rename MMU_WARN_ON() to make it super obvious that the assertions are
> > all about KVM's MMU, not the primary MMU.
> 
> I think adding KVM is a step in the right direction but I have 2
> remaining problems with KVM_MMU_WARN_ON():
> 
>  - Reminds me of VM_WARN_ON(), which toggles between WARN_ON() and
>    BUG_ON(), whereas KVM_MMU_WARN_ON() toggles between no-op and
>    WARN_ON().

No, VM_WARN_ON() bounces between WARN_ON() and nop, just like KVM_MMU_WARN_ON().
There's an extra bit of magic that adds a static assert that the code is valid
(which I can/should/will add), but the runtime behavior is a nop.

  #define VM_WARN_ON(cond) (void)WARN_ON(cond)
  #else
  #define VM_WARN_ON(cond) BUILD_BUG_ON_INVALID(cond)

/*
 * BUILD_BUG_ON_INVALID() permits the compiler to check the validity of the
 * expression but avoids the generation of any code, even if that expression
 * has side-effects.
 */
#define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))

>  - It's not obvious from the name that it's a no-op most of the time.
> 
> Naming is hard so I might just make things worse by trying but...
> 
> How about KVM_MMU_PROVE(condition). That directly pairs it with the new
> CONFIG_KVM_PROVE_MMU(), makes it sufficiently different from
> VM_WARN_ON() and WARN_ON() that readers will not make assumptions about
> what's happening under the hood. Also "PROVE" sounds like a high bar
> which conveys this might not always be enabled.

It inverts the checks though.  Contexting switching between "WARN_ON" and "ASSERT"
is hard enough, I don't want to add a third flavor.

> That also will allow us to convert this to a WARN_ON_ONCE() (my
> suggestion on the other patch) without having to make the name any
> longer.
