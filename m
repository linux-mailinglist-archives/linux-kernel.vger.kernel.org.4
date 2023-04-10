Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB6E6DCE1A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDJXao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDJXal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:30:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE2D26AC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 16:30:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c1e4b7e63so118682667b3.20
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 16:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681169437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEJjGhEklh175OeP8/Q76NV27eAb8+1mk5/dnEHppbY=;
        b=FsuXazcrHJKZvu6g1nSDIuc3/gmgb4O7h/UZ3ppdemgARatJqjZUYAyQ7ArpDcQjGg
         NNksngyx5safom93YGHnZ4pHfIdvagOTlwG4e6mPTdqA0m/I0/j5XO4g7RC/yDXqUUnE
         0kjgYDaAtcYR2UnK8LAYL4ueJjpjL+vmDuetHHIkGmUvzU5np9agexCj8KgH5xtyRJeI
         FyqIkXZtem2//4UMqGFNuqp0CNKcQ9ZL1bFMk4hx5pUdYkb8i+8Z88/cg75hfZAtHBlG
         8wpSWZnhFB907WN/1gf7dSSmW89DpoYb4f1pI94YGNd9pvs3aIqLJHpBOUNElFegdCXf
         Jb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681169437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NEJjGhEklh175OeP8/Q76NV27eAb8+1mk5/dnEHppbY=;
        b=WOi2Q5MMYxdO4+i/OvoQEZGyaM6eGKXPfh6lrbNoiVWZviHghyXznekAoBOFI9NDXk
         GM5ERp4+G4nmWMgxsyP44oX5X6jFJJofbwxfrFVIXcnwjIVzyP6kVdIAAQX+664gHdGi
         LUVU6vH3LlX/abllMvIIbxMon1FfJ4sZREjl3kjgyu4C+dfk9OVOa06hZPQS7TNHOESl
         cMhbMIRiLvxXf67pBvtSabq4XrsEAeWJvCsOygAe7coCyzyoRVtoNVECV0Ji/5BcBNeJ
         /YjOAFI4WT9wbIwfsptAliTZ/7p9oxqebjCk34R7Phwh6q7vuJDV5cnaNtl0aiEEwvYD
         UvOg==
X-Gm-Message-State: AAQBX9d1LZhfluqjWJc389SUAqzXH+wF7vamK/aSTqMsFvKfbqJFt6O9
        dW0FtfXu6ckpWR4hwhLJnx0q4v+sCS0=
X-Google-Smtp-Source: AKy350aTFgm3kLlfiqX/31P/rtLap6T3RPMivnN0w+GwPDldj9gU7Bx0Rw1DYwrMVkwIJ/cdQaYc3ikaDJI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c905:0:b0:b77:81f:42dc with SMTP id
 z5-20020a25c905000000b00b77081f42dcmr8185978ybf.1.1681169437488; Mon, 10 Apr
 2023 16:30:37 -0700 (PDT)
Date:   Mon, 10 Apr 2023 16:30:33 -0700
In-Reply-To: <20230405003133.419177-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230405003133.419177-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <168116506851.1036283.16135858065837035509.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: x86: More cleanups for Hyper-V range flushing
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Apr 2023 17:31:31 -0700, Sean Christopherson wrote:
> More cleanups of the code related to Hyper-V's range-based TLB flushing.
> David's series got most of the names, but there are a few more that can
> be converted (patch 1).  On top of that, having Hyper-V fill its struct
> provides a decent improvement to code generation, and IMO yields a better
> API (patch 2).
> 
> Sean Christopherson (2):
>   KVM: x86: Rename Hyper-V remote TLB hooks to match established scheme
>   KVM: x86/mmu: Move filling of Hyper-V's TLB range struct into Hyper-V
>     code
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[1/2] KVM: x86: Rename Hyper-V remote TLB hooks to match established scheme
      https://github.com/kvm-x86/linux/commit/8a1300ff9518
[2/2] KVM: x86/mmu: Move filling of Hyper-V's TLB range struct into Hyper-V code
      https://github.com/kvm-x86/linux/commit/9ed3bf411226

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
