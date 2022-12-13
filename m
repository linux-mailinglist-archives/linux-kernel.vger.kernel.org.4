Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3222164AF78
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 06:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbiLMFw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 00:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbiLMFwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:52:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CCC13FBF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:52:24 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gt4so2286895pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYz43EEP96YXjnW4iotxH0VfmmXOm2G/PuMulPbGnfE=;
        b=Z+uNCFHV+jOU2QMCnUiR+XpMPhGEJrsBzL6DbITzu2kPu5EI79ETigReX0cGYMsN9w
         XR0gKLM/LUqjtwBp9HolR4RZWM29MN79XO9ZGCWCubP5XjJakiXa4ElvO708+nXuxnFl
         C3/e1gnVhx8SWI97/URLTQk/kdDDHQM8896H6edXruMYQ4eSIzd510At/jkZ9I1hOXcl
         3qnuuYGjKZsH6l/ZeRXv3XtaZOGgeJNvuPKbt7j/l6g4RO4qPu0IB+foDc4RjGgUT5E3
         gv777X9c8J2ZmCCN8xYo2cNrZzGT9BbMPgj2g7h87PpZQQhJiJFfX30D03yXdUIgpSP6
         gOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYz43EEP96YXjnW4iotxH0VfmmXOm2G/PuMulPbGnfE=;
        b=ISr8UVq8e2RGqbLp3Qdc0/6ss1tPrX4KBlBAThvSGYJjhV2f54LaQxJQ0bznrT39T0
         WTJmjuZ3y7sbuFG16w6tr8n5gj1qIWpsZ181eGhjiqVOdgBCe1FUDtOKWZ/VFFDU/bUP
         6qsB6REQ0CYRx3LlataFIh9La7PhcIx8ZFNPb1tulVZNJpAjlZfFlTT6lVe4t3OFiQ6k
         VSr7pPD5JH3y5SqVBETgd6DXuGOiqQh4IiSS/sm6xGOugCkCrCbyS0qTtVtFLa81kjK4
         jI1lxfAWEasX9ryi2cZgYg7T4qOghRQLDKFjo/8XCvjnZofL8OW2jLAiuDLjlH5UjsD5
         cN7A==
X-Gm-Message-State: ANoB5plb7Kv6kuVqjqmHDF7RJ1uXou3rzfF1l+u37qsNhEz2GJeEG5ma
        w4pbf6w5bXWa7pJzLE8ORzXVLg==
X-Google-Smtp-Source: AA0mqf5CCpcPBM6uT0em5T3Ac7ZQ9vUw5J0cOyRGhvGPhdLhsOeqorWoAlhEtVE6tcLOKMXH1EZimQ==
X-Received: by 2002:a17:902:7893:b0:189:b910:c6d2 with SMTP id q19-20020a170902789300b00189b910c6d2mr149080pll.1.1670910743765;
        Mon, 12 Dec 2022 21:52:23 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id je19-20020a170903265300b00186b3c3e2dasm7421665plb.155.2022.12.12.21.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 21:52:23 -0800 (PST)
Date:   Tue, 13 Dec 2022 05:52:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: X86: Use the common definition - 'GPA_INVALID' for
 X86
Message-ID: <Y5gTFPxUTXDsQb5p@google.com>
References: <20221209023622.274715-1-yu.c.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209023622.274715-1-yu.c.zhang@linux.intel.com>
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

On Fri, Dec 09, 2022, Yu Zhang wrote:
> KVM already has a 'GPA_INVALID' defined as (~(gpa_t)0) in
> kvm_types.h, and it is used by ARM and X86 xen code. We do
> not need a replicated 'INVALID_GPA' for X86 specifically.
> Just replace it with the common one.
> 
> Tested by rebuilding KVM.
> 
> No functional change intended.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 -
>  arch/x86/kvm/hyperv.c           |  2 +-
>  arch/x86/kvm/mmu/paging_tmpl.h  |  6 +--
>  arch/x86/kvm/svm/nested.c       |  4 +-
>  arch/x86/kvm/svm/svm.c          |  4 +-
>  arch/x86/kvm/vmx/nested.c       | 66 ++++++++++++++++-----------------
>  arch/x86/kvm/vmx/sgx.c          |  2 +-
>  arch/x86/kvm/vmx/vmx.c          |  6 +--
>  arch/x86/kvm/x86.c              | 18 ++++-----
>  9 files changed, 54 insertions(+), 56 deletions(-)

What if we rename GPA_INVALID to INVALID_GPA and modify _those_ users?  I have
a slight preference for INVALID_GPA, and we also have INVALID_PAGE.  It'll also
yield a smaller diff.

EVMPTR_INVALID is the counter argument, but that's more of an error code than a
semi-arbitrary value, e.g. there's also EVMPTR_MAP_PENDING.

$ git grep GPA_INVALID | wc -l
17
$ git grep INVALID_GPA | wc -l
55
