Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABF46635D1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbjAIXri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238272AbjAIXrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:47:21 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0F72BEB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:45:57 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4d19b2686a9so6934217b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 15:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v2+KX7du7whicN+PS9fU23ysrGOmXoF+0M7DLlUtPuI=;
        b=ZgXn18vNNIICztMBawwC/7R15H4RvIurJtsuiESatewLzdxVJ22qGKGLsYNSGMZ/1J
         kqJLhrCdHZfEqLtaEJm+rwlCpUoN72QGA5WVuZ8lata0hrkjF1Aaiw83E2DGTR1TLzPf
         nNoYt+MXL0z4WrfBV20/KqlOYo8TDx8tKu1JfbOPASVmZzAhUuBLvK+64mgWSBD+BbW3
         ROGwxnI+BsBHpTm0li51OCl/YPPJ7hHh9rpDw68lVJt5LxQOI3tQoU8Js5bzfBdgqGPB
         L2rct/g75bwCkbvS3IGeYwyWqqDw2S7JPd7q5lIniApGK+jI1ovfHWIhIO5+udTgqATx
         hrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2+KX7du7whicN+PS9fU23ysrGOmXoF+0M7DLlUtPuI=;
        b=AywDeCRWq4Q7Ba9KGtDkEThpsMopQfdhZQSc8kuwsjVXbhds0wDirrDzV37I9Ha3CL
         U68q/gu8ZwnDrCCGuvPzI2EdLyt0jMZpjcUNPwt+uttDHfwPy1OuAcSYvJlzXo6W0Wnc
         5va3eeUJE9GbtdPBWG82HHkEHKX5ROEdJzjdxQquvLL4tntmaUZ+HReY3EMq+uhF8Bd6
         RUTJociexnrkQZsCRhxbEVIouEghU1lSdj1gJuIiV/MKXLDQ+aPYG/qYLQOk9kdXu8mz
         +i7JJwrCXEe2A321GPf4r3+ZJY1wJGiaduTji/AVqjuXyWhdj7ucpJxVx0A4WqwZ0ky9
         ejEQ==
X-Gm-Message-State: AFqh2kruNdh+NQ8bvKClOCFjNYKXeYLa/CjzIUbaFTwgRj0sGLku08Sf
        S7bBV4260dPwcGauUuOV3LxA79wk8OqGxK2Gu2pPaQ==
X-Google-Smtp-Source: AMrXdXtiOGtj7wxlgeBUlNrKN/Gt85LVD0b/yBSFIPRATuoaFVxXPi/DrmaKnwECCcPeNhPtU69RvhrNET3mcgBYxKQ=
X-Received: by 2002:a0d:fc84:0:b0:3df:6a50:40ec with SMTP id
 m126-20020a0dfc84000000b003df6a5040ecmr2231052ywf.340.1673307956007; Mon, 09
 Jan 2023 15:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20230109215347.3119271-1-rananta@google.com> <20230109215347.3119271-4-rananta@google.com>
 <Y7ymEiU1ZC/gzs9s@google.com>
In-Reply-To: <Y7ymEiU1ZC/gzs9s@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Mon, 9 Jan 2023 15:45:30 -0800
Message-ID: <CALzav=cqPv5coe3iei9wMHR_W-PbQWDpaFKzGeUL36Fz0NcB_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] KVM: Define kvm_flush_remote_tlbs_range
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Oliver Upton <oupton@google.com>, Marc Zyngier <maz@kernel.org>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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

On Mon, Jan 9, 2023 at 3:41 PM David Matlack <dmatlack@google.com> wrote:
>
> On Mon, Jan 09, 2023 at 09:53:44PM +0000, Raghavendra Rao Ananta wrote:
> > +{
> > +     kvm_flush_remote_tlbs(kvm);
> > +}
>
> FYI I also proposed a common kvm_flush_remote_tlbs() in my Common MMU
> series [1].
>
> Could I interest you in grabbing patches 29-33 from that series, which
> has the same end result (common kvm_flush_remote_tlbs_range()) but also
> hooks up the KVM/x86 range-based flushing, and folding them into this
> series?
>
> [1] https://lore.kernel.org/kvm/20221208193857.4090582-33-dmatlack@google.com/

(Also they make kvm_arch_flush_remote_tlbs_memslot() common so you
don't need the ARM-specific implementation in patch 4.)

>
> >  #endif
> >
> >  static void kvm_flush_shadow_all(struct kvm *kvm)
> > @@ -637,7 +642,7 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
> >       }
> >
> >       if (range->flush_on_ret && ret)
> > -             kvm_flush_remote_tlbs(kvm);
> > +             kvm_flush_remote_tlbs_range(kvm, range->start, range->end - 1);
> >
> >       if (locked) {
> >               KVM_MMU_UNLOCK(kvm);
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
