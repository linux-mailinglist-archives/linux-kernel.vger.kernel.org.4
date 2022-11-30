Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BE063DAFA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiK3QuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiK3QuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:50:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42C225C6C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669826951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4GWU65UGPx2PYYLAPP9dV1jQGWJIKZZm8yJz9xZ7Xy8=;
        b=Xw4l4cFC98KuvMixCBnxbcXsdZqAqRPylGWlkJGTHAQPKAI8a3yFEPwOXIfxinLSprDF1+
        qJr/2gRZRT+quzf0WEyHLRU3YV914H7ykv/Z0qDsm8CxSlQK+CiqLAz93JL0n+GmNwSc3O
        Fo1mYLDPc6aMXs6yt6i1S4LBBhCzH+4=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-3SMDAUQKPwGt5U0qgSDkyw-1; Wed, 30 Nov 2022 11:49:07 -0500
X-MC-Unique: 3SMDAUQKPwGt5U0qgSDkyw-1
Received: by mail-ua1-f71.google.com with SMTP id p18-20020ab01552000000b003e348b9ba6fso9840377uae.14
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GWU65UGPx2PYYLAPP9dV1jQGWJIKZZm8yJz9xZ7Xy8=;
        b=qN4LLkC0Wa888zQN5ONje8qXqfwQt2nkIjjSrTeLVEbrZ6e1DPUlKFF+HUO/xj+akX
         8z1nWtV+w05erGBvtuOrf3XW0yhEXe9jifW80U6yWhLWThp7ZgwfD07bhQOj9rMQLOp2
         tPKX1vrRjy+H9xFvKnm9Q25l8/V5/7L24r8/NFSe5Pzz8tk6pu2EZqIrGlGbf/IP/a0/
         Et/jQC6aSbrdrka9NMhBh/jXfJybs5mVnnftuUvZdZZQa/fVhr0Vy94yhkWGPBE8WqWX
         ScRhN3o5NLHH61Yw8/DqJygat/TN1qDHwvHQQDN8DCu9uXlTGEvLvn3bH7i6XEirVIb7
         ObKA==
X-Gm-Message-State: ANoB5pnlyFgcQZ2DmidivCpATUQIZ4Mb82DF1dX5KNsSVk0q1RbiE5Je
        FKIWluX7BT3gAhHSTXKyrfscZD6SOvhXoamkx/DsWkzmgOLBwaEiOGW5h2863qDj4oDGCJbDfAh
        2oiexzuEuoMRQm1qZ51mWmw60/xrdS9pHj7GU7Oet
X-Received: by 2002:a05:6102:3fa1:b0:3a6:aae4:cab6 with SMTP id o33-20020a0561023fa100b003a6aae4cab6mr35058689vsv.27.1669826946993;
        Wed, 30 Nov 2022 08:49:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6CJmrVgz4KynPMr0aMGyZtKUelB7RPu7ZB2QsEbqy9W7ktmZzzHonzgeFGeo9KQtZC/QA9Qdxfdf5DgM2eHyI=
X-Received: by 2002:a05:6102:3fa1:b0:3a6:aae4:cab6 with SMTP id
 o33-20020a0561023fa100b003a6aae4cab6mr35058679vsv.27.1669826946725; Wed, 30
 Nov 2022 08:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20221130161946.3254953-1-spm@google.com>
In-Reply-To: <20221130161946.3254953-1-spm@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed, 30 Nov 2022 17:48:51 +0100
Message-ID: <CABgObfby+9JNwrJnjPRp6pty05CqRUfKBA3AB=TNwq4q0KjBTg@mail.gmail.com>
Subject: Re: [PATCH] KVM: Deal with nested sleeps in kvm_vcpu_block()
To:     Space Meyer <spm@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kpsingh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 5:20 PM Space Meyer <spm@google.com> wrote:
> Previously this code assumed nothing would mess with current->state
> between the set_current_state() and schedule(). However the call to
> kvm_vcpu_check_block() in between might end up requiring locks or other
> actions, which would change current->state

This would be a bug (in particular kvm_arch_vcpu_runnable() and
kvm_cpu_has_pending_timer() should not need any lock). Do you
have a specific call stack in mind?

Paolo

>
> Signed-off-by: Space Meyer <spm@google.com>
> ---
>  virt/kvm/kvm_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index fab4d37905785..64e10d73f2a92 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -32,6 +32,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
>  #include <linux/sched/stat.h>
> +#include <linux/wait.h>
>  #include <linux/cpumask.h>
>  #include <linux/smp.h>
>  #include <linux/anon_inodes.h>
> @@ -3426,6 +3427,7 @@ static int kvm_vcpu_check_block(struct kvm_vcpu *vcpu)
>   */
>  bool kvm_vcpu_block(struct kvm_vcpu *vcpu)
>  {
> +       DEFINE_WAIT_FUNC(vcpu_block_wait, woken_wake_function);
>         struct rcuwait *wait = kvm_arch_vcpu_get_wait(vcpu);
>         bool waited = false;
>
> @@ -3437,13 +3439,11 @@ bool kvm_vcpu_block(struct kvm_vcpu *vcpu)
>         preempt_enable();
>
>         for (;;) {
> -               set_current_state(TASK_INTERRUPTIBLE);
> -
>                 if (kvm_vcpu_check_block(vcpu) < 0)
>                         break;
>
>                 waited = true;
> -               schedule();
> +               wait_woken(&vcpu_block_wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
>         }
>
>         preempt_disable();
> --
> 2.38.1.584.g0f3c55d4c2-goog
>

