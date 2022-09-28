Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D5B5EEA49
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbiI1XpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbiI1XpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:45:08 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5358FB33B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:45:06 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id cy15-20020a056830698f00b0065c530585afso1457538otb.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ESo7dYY6GfSDr+r4KK+gGMltslb0uxWselTUsHs3b/I=;
        b=oItvueHC9rGpEb1pjDREbzHBF4FsxPszjkSVzhJXqpPU49y/K5jjrfmA7oddFNQfmP
         sR629g48JwNN9T6R8G660mC9vUqTrrGYcg30Wdo+KgVe2AEYXxT0AqJRF6IxQCT7U3wz
         HN8BVD0i673m0Llrhm1mnVpn5n0b9H+HvrBP+p43/3wVnBLIluaF6JazpmqonSDZmMSx
         rcazm5CE45xgvNTlQGaHPuiick8amlxtoYzCvslzqE8f/L9VW5Mi7TziUCMHaDlzKyj+
         LnLxsGsboagft/aX9Aanz8y41bPYUD6i/5aiU+zhx4vN6qQjNMp+6HtDmMytNC2gdTlu
         GM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ESo7dYY6GfSDr+r4KK+gGMltslb0uxWselTUsHs3b/I=;
        b=sacKV7422VyDRkzfoLPsvSuKKCbSpo8f7cLsyqc0JxPYb9VQgXbEJZdBOJHoKEeZjQ
         hLJQHPaACrMC9v5X6+KEzXRj9FFHl1hIeLJG/5DAdRUG8xpb/UId3yR0wHWnmQjrDYfW
         dt+I17l8UWHMypt4P2j8B99JscwZmVuTA1VChVe2OEXPjROgEjHNap7CqkQkWCtrdLKE
         exUk1oLAQartmeZ+tsD3WW/hbKpvNlINIBR8nx3guVFPPh6zzXIsPZSQLUnLN3joB2UU
         Umsm1H8bcDL3HJJNqJjHACa9sBdxheuzeBAdjsck6m6elc6EuxU/z9hth9NUgtA1KsY7
         USEA==
X-Gm-Message-State: ACrzQf1gv0wNqM/r25HZnlwHaJNpR4nmAcBJPVGF7MotKxb2N9ppU04h
        j+YfthWKiMhVba6kts/e0Hk+1pnLv4Rtu+MdukbGbiz/CME=
X-Google-Smtp-Source: AMsMyM5BEgYUYkwCxhv/sZA35LzbvEoRuf+YYFHT4kB7vvwY9taFoIle4rOgzDexyQJ331I5KruMLo+4Blr6HuHoaCo=
X-Received: by 2002:a9d:6296:0:b0:656:761:28bc with SMTP id
 x22-20020a9d6296000000b00656076128bcmr172073otk.14.1664408705832; Wed, 28 Sep
 2022 16:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220928233652.783504-1-seanjc@google.com> <20220928233652.783504-8-seanjc@google.com>
In-Reply-To: <20220928233652.783504-8-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 28 Sep 2022 16:44:53 -0700
Message-ID: <CALMp9eTysg_AdBi3BsbMzj4uKjsHLOOa1B3x+j8=CH=Lvzr8jQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] Revert "KVM: selftests: Fix nested SVM tests when
 built with clang"
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Jones <andrew.jones@linux.dev>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Oliver Upton <oliver.upton@linux.dev>
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

On Wed, Sep 28, 2022 at 4:37 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Revert back to using memset() in generic_svm_setup() now that KVM
> selftests override memset() and friends specifically to prevent the
> compiler from generating fancy code and/or linking to the libc
> implementation.
>
> This reverts commit ed290e1c20da19fa100a3e0f421aa31b65984960.
>
> Suggested-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
I love it!

Reviewed-by: Jim Mattson <jmattson@google.com>
