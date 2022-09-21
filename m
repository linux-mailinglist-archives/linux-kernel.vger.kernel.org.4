Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3BA5E56C3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 01:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIUXcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 19:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIUXcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 19:32:32 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4070A59A5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:32:29 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l7-20020a056830154700b0065563d564dfso5110521otp.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SqzcULGafomcPfL0238nMURblSS0a/kOzo9VibmLWz0=;
        b=nHW7hBkMCvhOQcKutMmPzSfS5wSHoQgRVQsiLawYD3+JHh3e9hlw89NKuU4b8n65TM
         J7W8snejUmJ+MiAkdhXsuak1+kifyvYepHdet3km65zK5ao+LxznJG4tqLDoe+1lhD3N
         9MHDZUTzMwh+aLn+yHFtHkpIu1tjRx3aiV+H+FayIccpvCnNxNOzAPchV+BgoH8dsz+e
         suXjjvM2GIpCmJR+lfWpA94D9a43Y6Wc6K3RRugQ1PoGP8qWsbL6eMFdJgY+jUjQUcJy
         iMK1xwSDPGi2aA8qarBUDEjMbE+njuusNNz5BjxFBcedJbbjfHW9r9Xot3SVP4yIBWWv
         fXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SqzcULGafomcPfL0238nMURblSS0a/kOzo9VibmLWz0=;
        b=CIOR4SxbJsgtRrPReuf78IQwiPc0XfgoOGc9BFUD5E/WU2NEXmPNXGyV4csk+3Z6oB
         4yTG0V+Lyz4D8rsFBJ/VMSN4kCbs+cKKbU9d1qaPckTedffH0TR4Ga5qQsHzIQL00cdT
         RwtpnbRjZoQEOnxjk0vVxEffzhksKGaqku8NKSqq3bdURv1HsS3m6FiU2i3Ggrm7zYFI
         ldbqlCloaL1adA7ZDDrRrKkYnXF2uDJF5FZ5bwIRRcqv9Eeaq0b0vxQoZ+ihVS58MJut
         EG2M7xua3YHiRKb/koBbfmBGfmlY60i+1AzCo2L1NmTfCqdTwnSA4cQHW4gFeDpX81ui
         eivA==
X-Gm-Message-State: ACrzQf1byhobQ8787VLWwLVY0Wf0OSZgjpcFNv/nI2EnePohL3yw/hCl
        kuyy6VBXHLXLuPrgeF/0/hFgEi9UjTEAEmY3epgfJw==
X-Google-Smtp-Source: AMsMyM4P4tSeGfFSdj2TFSMxnw3Pnb6Rkdj16/B2lEqqPJivMxbm2W/5/M+6fyNGUhAY4IKj9Lzm2wbXRju7Q1alP5M=
X-Received: by 2002:a9d:6296:0:b0:656:761:28bc with SMTP id
 x22-20020a9d6296000000b00656076128bcmr318414otk.14.1663803148668; Wed, 21 Sep
 2022 16:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220921231151.2321058-1-vipinsh@google.com>
In-Reply-To: <20220921231151.2321058-1-vipinsh@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 21 Sep 2022 16:32:17 -0700
Message-ID: <CALMp9eQ8Rr-rSjXiZ_4O0mA=k3kk=hYrfB_NTszu=9DFOwNUaQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Fix hyperv_features test failure when
 built on Clang
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Sep 21, 2022 at 4:11 PM Vipin Sharma <vipinsh@google.com> wrote:
>
> hyperv_features test fails when built on Clang. It throws error:
>
>          Failed guest assert: !hcall->ud_expected || res == hcall->expect at
>          x86_64/hyperv_features.c:90
>
> On GCC, EAX is set to 0 before the hypercall whereas in Clang it is not,
> this causes EAX to have garbage value when hypercall is returned in Clang
> binary.
>
> Fix by executing the guest assertion only when ud_expected is false.
>
> Fixes: cc5851c6be86 ("KVM: selftests: Use exception fixup for #UD/#GP Hyper-V MSR/hcall tests")
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
>
> ---
>  tools/testing/selftests/kvm/x86_64/hyperv_features.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

In case Sean doesn't point it out, be wary of starting a shortlog with
"Fix." You may later regret it.

Also, I think the "clang" part is a red herring. You are fixing a
latent bug in the code.

Reviewed-by: Jim Mattson <jmattson@google.com>
