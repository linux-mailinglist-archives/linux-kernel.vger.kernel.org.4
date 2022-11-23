Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D480636E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKWXtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKWXtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:49:02 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78B28A16D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:49:01 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id q13so144490ild.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7JFW255EPBk3XgoKAwrFF/RCi7p1HqnpoL0o2suN9TM=;
        b=UXpz66Offu6F+6lvEB6xZs7G1T+pM1GkvWQ7Pz8qEyodOVUDfUUQgOsD8zfT1OpjNm
         q2414zaZglwJCKHWEc+YkndFvyVbboZKmJk5rqLc6bwbP6LN9Tz6s2y5XMfvIvfcjFZB
         z9rBoPggoL2O40DTrYhxRXIgUe0wZ9zclCPAmRkQwLLzq3LG511/EQ2Vk2jATygUMhxo
         Z1Zhvgp1D6cybzF9vUxgOsQPwgptha48KZAaZeSq1AkPxvWH4TAKIz0hB5zSNvo/1/0s
         v4d6vZJVYnp83I8x1tPj6DtKCFcoHupd4mxBae6EHLhG3SETvvDIvgJuGM/fIy+jw9/D
         VK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7JFW255EPBk3XgoKAwrFF/RCi7p1HqnpoL0o2suN9TM=;
        b=4OISXPr/PRNxKLfjxA66iYSwOSa7k1CVNGuc46Bl3peo3K0Dg0PqFBXho3IcWNLA95
         YPvPEwteMoeDv9oP8GRL6HGhiA8UgbpoVa2NZy1/M3KyHg5zdRPQ+lseWZKo0KsIkb02
         1r2Qpykm4UCmGJZESbN1izR/D7v3o2LO7arXTOHaZ0LUZ2AZcxcOXrWR5bFgru9gDmZN
         OB29HZC5b0RUiO88RXPXozl4jAsN23JqctXGhLka23iNllE0DTO5j7frRAgNZDKiAqbe
         x/Bo6HKfT8ymQ9kqxhlGChMLyS1KohOomr3xTZ2LIF2CdmwyHTYLwYf046hOtJJvvwbx
         mFvA==
X-Gm-Message-State: ANoB5pmhF43II79iDKIxQIZJouJRMYnSo4VilC4ln5bKpp39LwEYQIUM
        lC9ujzRL4QJtO4VDHquqTSCmj/6bvtAiQ4+UuMENtg==
X-Google-Smtp-Source: AA0mqf4H5Hu6MoVtZ/9VryRm/tLmXKgMiDvJ6XVLoYBHd30pzB9UGhSvKBHQfn7j21NS8opxa42dABr+hsZT6b+k6cw=
X-Received: by 2002:a92:dc8b:0:b0:302:4c01:2d2b with SMTP id
 c11-20020a92dc8b000000b003024c012d2bmr4364530iln.2.1669247341082; Wed, 23 Nov
 2022 15:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20221123231206.274392-1-mizhang@google.com> <Y36qNDBxlOslo7no@google.com>
In-Reply-To: <Y36qNDBxlOslo7no@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Wed, 23 Nov 2022 15:48:50 -0800
Message-ID: <CAL715WKymGc60gLHT9_g+RDs3TgSBCZqdZJD0D3Z=ZrCgH05nA@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: x86/mmu: replace BUG() with KVM_BUG() in shadow mmu
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nagareddy Reddy <nspreddy@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>
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

On Wed, Nov 23, 2022 at 3:18 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Nov 23, 2022, Mingwei Zhang wrote:
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 4736d7849c60..075d31b0db9c 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -955,12 +955,12 @@ static void pte_list_remove(u64 *spte, struct kvm_rmap_head *rmap_head)
> >
> >       if (!rmap_head->val) {
> >               pr_err("%s: %p 0->BUG\n", __func__, spte);
> > -             BUG();
> > +             KVM_BUG();
>
> This won't compile.  KVM_BUG() isn't a direct replacement for BUG(), it's more
> akin to WARN().
>
> And that's why I suggested this be RFC: @kvm needs to be plumbed down here in order
> to use KVM_BUG().  I don't mind that too much, it's just a little unfortunate.

I wonder if using kvm_get_running_vcpu()->kvm is safe here? Assuming
we can, then @kvm plumbing shouldn't be a problem.
