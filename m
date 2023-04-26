Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5496EFDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbjDZW6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbjDZW6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:58:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C5535B6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 15:57:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f8fcad732so128595327b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 15:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682549878; x=1685141878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JXazE9kznOdLCB9IeWlM55cXnSgWMuYpYcAW4/dwtc8=;
        b=lnqIcCm010Tlqy2bg4sivFq6oYIiNkB3yshTFdOJoFm+HqZrUaHKuHIHLDJT4UgpVs
         W6TcIkf3vwwSATn8a7/OYjeas8snENrzIDQipjL/Mo7zl46Cnkp9UOpWVcsc5PQkzeNW
         7VK0v0TUwmYIwZqob98Tf+hioDA+xicFw7HyIcc8y1nqZ7Axtuj1x/FMNRszDJaIol4Y
         ZilTZLhixn1wiTlhJkN2so7Zu08a+CuaIWx9TJdXhdt7gL3FVd5+EB5rd8nWLjZURsQm
         94OPss2dXdHYUum5vpaklCkVDeHBlhNJgLSf8RkqKFiByJvwewvRXaL3By9vJrTC5uUu
         McMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682549878; x=1685141878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXazE9kznOdLCB9IeWlM55cXnSgWMuYpYcAW4/dwtc8=;
        b=UV6m44qOFVr/IimQTz7Gnc41rxykQTfLDci3b4qol5DCENLgCFnF5ZHI4qN/zgoqig
         1KAtNoO1o5svXU6LeCl9ekJIWUaN+urfNhSevvgDglGOEZpl0VCxZTd4MvIVH2O0VELa
         1JtHXppzlTUJr2DIDAX/fbAhbPbTWFKw3VMS7okRYDxeo965nKFUnuuH7Or6Fvp7vDIk
         i+7yzcYYAhi825KVuJo4LCdtr62Cb3jimdJ8UHJ1mHWRC93QiV9XAJIoGuZ4fepWw5Dv
         4x0CnfPri1PnkS2zEBSILkhZthgsvonEbxDTXyVrlSMfONHI5nsZGgLkbvyyHCd+MjpQ
         EumA==
X-Gm-Message-State: AAQBX9eCrInYnY4mBkid0rdjQtG1sbyl457pYenoEmJfPwVgdlHsTz5F
        ddgNcWV1iC5GHQrtLVmoGyTwjBweJV8=
X-Google-Smtp-Source: AKy350YrwnCmeOGJE8g1QPZJYanEcWEZPdP6IoP6s2Nltq+2YKtIhHZigpbemZCUfeoGrwRJYpYSJ8PyIh8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ef06:0:b0:54d:3afc:d503 with SMTP id
 o6-20020a81ef06000000b0054d3afcd503mr11139415ywm.8.1682549878047; Wed, 26 Apr
 2023 15:57:58 -0700 (PDT)
Date:   Wed, 26 Apr 2023 15:57:45 -0700
In-Reply-To: <20230426220323.3079789-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230426220323.3079789-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <168254947739.3087722.95836523643262635.b4-ty@google.com>
Subject: Re: [PATCH v3] KVM: x86: Preserve TDP MMU roots until they are
 explicitly invalidated
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2023 15:03:23 -0700, Sean Christopherson wrote:
> Preserve TDP MMU roots until they are explicitly invalidated by gifting
> the TDP MMU itself a reference to a root when it is allocated.  Keeping a
> reference in the TDP MMU fixes a flaw where the TDP MMU exhibits terrible
> performance, and can potentially even soft-hang a vCPU, if a vCPU
> frequently unloads its roots, e.g. when KVM is emulating SMI+RSM.
> 
> When KVM emulates something that invalidates _all_ TLB entries, e.g. SMI
> and RSM, KVM unloads all of the vCPUs roots (KVM keeps a small per-vCPU
> cache of previous roots).  Unloading roots is a simple way to ensure KVM
> flushes and synchronizes all roots for the vCPU, as KVM flushes and syncs
> when allocating a "new" root (from the vCPU's perspective).
> 
> [...]

Applied to kvm-x86 mmu to replace v2.  Same spiel as v2: pushed immediately to get
testing in -next, will squash trivialities as needed.

[1/1] KVM: x86: Preserve TDP MMU roots until they are explicitly invalidated
      https://github.com/kvm-x86/linux/commit/edbdb43fc96b

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
