Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44156538D1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiLUWkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiLUWkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:40:39 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B684E17
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:40:38 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id f28so62137qkh.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G3OCVo6XS4rgsws68hkJPdhb81JtRDiKMnu7YKNLQzk=;
        b=odoDsIvPGhL96Eox+D5J0o7CS/3CRll/jZTp2F3vnHSPlAa59jsnzplJny3BSRtLNy
         4/jrtkG18GyEVmDAxNywuKIibsLDR9O2Mp80KC6eaTMxYMhn5V5ngy1GbKCyz1DVM3jJ
         /f8+VyQzMVhGbqp1jXgHCCMrL8DY3RKxWwdqhyXeXXmTXiaT7ZsJ+ehlYsktpKPN5iEn
         5bARy0nTYFwQwNvQ0aFY3JOIdUs3qSJafT6LoOuS//VRfB9ziYYPWSXxrY2waAW7MqJ8
         gH9OiQGmmDG1uI1+yEskGGfUjpiWltjd4UhVIK4bNcFWMpUOO0qHEg5H77C25K1tY63R
         gj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3OCVo6XS4rgsws68hkJPdhb81JtRDiKMnu7YKNLQzk=;
        b=NR+uAnB/xbRPHrHODwagURvkAHwk66Nh5TmWkicLAEQJIsIhAdk69B8g4Zbz4zbUQ4
         N0Pk6oTYV2GCofCgU1W1gIOjOU+Pu51bdzqZkXguMBLrUy1mQkBdH8Ylxp7Pvs0UC/l9
         c0XBbyQvVduXzEz3XGAIdbrYS8heYBPCB86ZXX5Pw54NOJZkqbC0fURrYZSJnaezpajw
         yQUMPkQTny6etg02H8LWK98EVAflacGQCMNkLSatyXdGMrz136eqNyiTmhSKmSKc4sTG
         C498G1YtuTau1CzgZdrl5x/5g3BmnR5ctOjgoUzR3FhXEDapPxClYjBSa5HPGtWqNOI9
         ADvw==
X-Gm-Message-State: AFqh2kq3WhSSQsINP2p+ymz3IQg0aD1yMqfDQhdH3xatdXrVK3lRHmUJ
        t60lXUPij4/oTwu9rW4R2QBD1itnns+c894G+z+Waf/eyLaSCg==
X-Google-Smtp-Source: AMrXdXsab27EY166Z/yRqBcLT+6ht48O0XgjuA38LmGtQ69fPcRRwlbLxz+Yi6rBlBc3V8tYF0n0DnasvySES3CLSig=
X-Received: by 2002:a37:ad13:0:b0:6f1:187c:8f79 with SMTP id
 f19-20020a37ad13000000b006f1187c8f79mr103583qkm.593.1671662437443; Wed, 21
 Dec 2022 14:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20221221222418.3307832-1-bgardon@google.com> <20221221222418.3307832-4-bgardon@google.com>
In-Reply-To: <20221221222418.3307832-4-bgardon@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 21 Dec 2022 14:40:26 -0800
Message-ID: <CANgfPd9d=rDxS2BeMRfXt1co1hPFJbDtF7vMe1r-XpTpOsYhNA@mail.gmail.com>
Subject: Re: [RFC 03/14] KVM: x86/MMU: Move the Shadow MMU implementation to shadow_mmu.c
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Nagareddy Reddy <nspreddy@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Dec 21, 2022 at 2:24 PM Ben Gardon <bgardon@google.com> wrote:
>
> Cut and paste the implementation of the Shadow MMU to shadow_mmu.(c|h).
> This is a monsterously large commit, moving ~3500 lines. With such a
> large move, there's no way to make it easy. Do the move in one massive
> step to simplify dealing with merge conflicts and to make the git
> history a little easier to dig through. Several cleanup commits follow
> this one rather than preceed it so that their git history will remain
> easy to see.
>
> No functional change intended.
>
> Signed-off-by: Ben Gardon <bgardon@google.com>

Woops, I guess this message bounced because the patch was just too long.
I can try to split it in two if folks would prefer, or just send a
list of the functions / definitions moved.

> ---
>  arch/x86/kvm/debugfs.c          |    1 +
>  arch/x86/kvm/mmu/mmu.c          | 4526 ++++---------------------------
>  arch/x86/kvm/mmu/mmu_internal.h |    4 +-
>  arch/x86/kvm/mmu/shadow_mmu.c   | 3408 +++++++++++++++++++++++
>  arch/x86/kvm/mmu/shadow_mmu.h   |  145 +
>  5 files changed, 4086 insertions(+), 3998 deletions(-)
>

...

> --
> 2.39.0.314.g84b9a713c41-goog
>
