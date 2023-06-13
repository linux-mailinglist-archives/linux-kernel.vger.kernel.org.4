Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F089772EFF5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjFMXWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjFMXWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:22:21 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A146A19B5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:22:18 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-25c26394dc3so436344a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686698538; x=1689290538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AKKr34aXdfH9KLsAtN27ND1ZXEqhzt5jyTjuJIbgzFo=;
        b=3tPCqwzup+zu57tlHkVfPcCETx6zlFFvM70D/39IOogXgLw85yqsP9VD8b0qMzyP1M
         j41mSPipubc6jwjmHAiskgNWj3iV1nQI156460FVvDYqZwsyBDZyCHSxmZrQj7DrG46u
         dbHg+w+wV0FhlrLmwQKSlUlZqnQg9FPZmM0KeLdzPVZIAFkZc1KeqHRugyLH3RpxNjK8
         3H888bfvcfSqCkkzz6/RQWDgx7QEzZcvoAwmnCF34Qiu3aZ39aJEormDxBhqo54GZ/68
         ezGTdtwUXMyUUIVYveRG03sBMdPQ+Oi2Mv9rWnHUDzjEXMjF5zC27kTtsOEdh0rn/WIV
         mAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686698538; x=1689290538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKKr34aXdfH9KLsAtN27ND1ZXEqhzt5jyTjuJIbgzFo=;
        b=cLd0WGwYRmJmKnX8vJeU/b0lFiAQfZfjkDNU5i7P/IuHAWiboHBem4ppkrXkZlywqD
         gsqSCKfvF8a3l3XMeniv0M8W9jdVHuJG/n4ETF1LmYE/0QURaw2IW/LQUIQMb46Z4Ybn
         q4S4noDwckELPDIMZmYDikAaWwFQBYOIBeXgF1cPPmTU1WQ0mrbA2A+Pj8piJfS7U8X0
         xd9/Z7aRIj87uEXOZimU1b0pPnNJHgsNkx46u3PydGHwO7IJq05pOtz8mkjw5KZoI9BR
         xxoM7n/e0MvyUTuoxjCwq7Q4Gy2HAPhHOakg8V0LsSxqIHbumWLfQ7tFXCuhKPVjV10i
         m2xg==
X-Gm-Message-State: AC+VfDwjhhC7eXJ9yjeCG6ABS9nQbjG6SZ7oZj36f554i+RUZI9KamWM
        MOluVThX/PHTGYy31EM1TgV3mUab/Ic=
X-Google-Smtp-Source: ACHHUZ4fAfuTYvvgLiI3DUvoyDtnm1xlTqdMh80qWG8kNoV/W8zpSobmWHsRbhZVl7momSmG9eA/lxRiC30=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1188:b0:25c:6cb:f376 with SMTP id
 gk8-20020a17090b118800b0025c06cbf376mr9769pjb.0.1686698538129; Tue, 13 Jun
 2023 16:22:18 -0700 (PDT)
Date:   Tue, 13 Jun 2023 16:21:52 -0700
In-Reply-To: <20230602005859.784190-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230602005859.784190-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <168667299355.1927151.1998349801097712999.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Add "never" option to allow sticky
 disabling of nx_huge_pages
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li RongQing <lirongqing@baidu.com>,
        Yong He <zhuangel570@gmail.com>,
        Robert Hoo <robert.hoo.linux@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Luiz Capitulino <luizcap@amazon.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 17:58:59 -0700, Sean Christopherson wrote:
> Add a "never" option to the nx_huge_pages module param to allow userspace
> to do a one-way hard disabling of the mitigation, and don't create the
> per-VM recovery threads when the mitigation is hard disabled.  Letting
> userspace pinky swear that userspace doesn't want to enable NX mitigation
> (without reloading KVM) allows certain use cases to avoid the latency
> problems associated with spawning a kthread for each VM.
> 
> [...]

Applied to kvm-x86 mmu.  I kept the default as "auto" for now, as that can go on
top and I don't want to introduce that change this late in the cycle.  If no one
beats me to the punch (hint, hint ;-) ), I'll post a patch to make "never" the
default for unaffected hosts so that we can discuss/consider that change for 6.6.

Thanks for the reviews!

[1/1] KVM: x86/mmu: Add "never" option to allow sticky disabling of nx_huge_pages
      https://github.com/kvm-x86/linux/commit/0b210faf3373

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
