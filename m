Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0576E662F6C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbjAISo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbjAISoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:44:14 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48B6B7FA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:44:11 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id tz12so22461701ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 10:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uo5Q4ZB5A1o75Rhc81fI3ExVhw2U3hO1xx/cZ3Jxs4g=;
        b=FVxCSIB2u2Yoi9XgPdM2ZtHYv/lCI3FoYzhCFC0mkcQT4zjpbNZSeLnuOP/eO1vc2t
         +iCv+Bimx87l6Iyx/2gJAng7P5NbwieRxs2PnQJcC4QKi/pVmFCIZ7Srp67eSoEyxttd
         T4Exqdc7lAkulyXEcoHvBIZQhwbfB9iWo3PEvFYDR2q+W9VasI7w63mff657pd+8Mwko
         cIDHuLo+y4WKImRJyGxacMC1znmztyRZc05FNenbDe7SBeBybJN2qTn3JSKvxz+ggn+O
         Xl4c4xvah9fz/glDrjzstjXfsT2YOjqbDxoFBmAJucwHOyEZOsSjy+eRsWpyYilD+qwy
         FwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uo5Q4ZB5A1o75Rhc81fI3ExVhw2U3hO1xx/cZ3Jxs4g=;
        b=M3t6ZyvSJDiIyTfYP5ovpzpde06rYF/90ckHkRFZtZHGgCW2nHxp0St9dILH8VCMV+
         S39dd6JpkOVpiWLZCEAuYtXde0sPNG3CDNcs8LTgozMO6nASYdYhVMa9ROckSv7YVVgF
         jvaDdEQvjAgs+4lQZQdOP6kFpTxeGMVGzut3Y7s23LSWGAF/7OI2bL5TPgiIc29wV2kV
         3eW2LWlJ2e0+hxhfaJWp3DrDxyGh/jnJ46ELPRJzY0unUpLFp7QDz657tf8+5AZgfy7z
         K/QF+HELW4LsjKSHOYO8oYl0geSP4//wPdMGvk+4S9NzyjkY3o9kjCIAeA6etUP2CNdq
         F5uQ==
X-Gm-Message-State: AFqh2kqs3Xx+McWMkaGkozl1YqnDHyyiLcNVlSmD2UKmiyYedF4lTZs5
        3ut7PzSxtvhLt5YaGpHE//YSD6CWdSp3XCxJj3/uhw==
X-Google-Smtp-Source: AMrXdXuK/yDXDmFGtPpMPBJH82Mmdju0OfIDmrdTal+T0L9kEkjbFkEpZ82oxLBUSwRTuYvieocLJlIsiak1PjySPBA=
X-Received: by 2002:a17:906:1cc2:b0:7ad:9ad7:e882 with SMTP id
 i2-20020a1709061cc200b007ad9ad7e882mr6543970ejh.520.1673289850220; Mon, 09
 Jan 2023 10:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20221221222418.3307832-1-bgardon@google.com> <Y7hz8geAGgysptY5@google.com>
In-Reply-To: <Y7hz8geAGgysptY5@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 9 Jan 2023 10:43:58 -0800
Message-ID: <CANgfPd-6-oxtH3cTH8+1KKJx7bnWABjvLVjCrMZ7Hp5Wmy53ZQ@mail.gmail.com>
Subject: Re: [RFC 00/14] KVM: x86/MMU: Formalize the Shadow MMU
To:     David Matlack <dmatlack@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
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

On Fri, Jan 6, 2023 at 11:18 AM David Matlack <dmatlack@google.com> wrote:
>
> On Wed, Dec 21, 2022 at 10:24:04PM +0000, Ben Gardon wrote:
> > This series makes the Shadow MMU a distinct part of the KVM x86 MMU,
> > implemented in separate files, with a defined interface to common code.
>
> Overall I really like the end result.
>
> While looking through I found a few more bits of code that should
> probably be moved into shadow_mmu.c:
>
>  - kvm_mmu_zap_all(): Move the shadow MMU zapping to shadow_mmu.c (the
>    active_mmu_pages loop + commit_zap_page).
>
>  - need_topup(), need_topup_split_caches_or_resched()
>    topup_split_caches() should be static functions in shadow_mmu.c.
>
>  - Split out kvm_mmu_init/uninit_vm() functions for the shadow MMU.
>    Notably, the split caches, active_mmu_pages, zapped_obsolete_pages,
>    and other Shadow MMU-specific stuff can go in shadow_mmu.c.
>
>  - The Shadow MMU parts of walk_shadow_page_lockless_begin/end() should
>    go in shadow_mmu.c. e.g. kvm_shadow_mmu_walk_lockless_begin/end().

Awesome, thank you for pointing these out. I'll work them into a V1.

>
> > Patch 3 is an enormous change, and doing it all at once in a single
> > commit all but guarantees merge conflicts and makes it hard to review. I
> > don't have a good answer to this problem as there's no easy way to move
> > 3.5K lines between files. I tried moving the code bit-by-bit but the
> > intermediate steps added complexity and ultimately the 50+ patches it
> > created didn't seem any easier to review.
> > Doing the big move all at once at least makes it easier to get past when
> > doing Git archeology, and doing it at the beggining of the series allows the
> > rest of the commits to still show up in Git blame.
>
> An alternative would be to rename mmu.c to shadow_mmu.c first and then
> move code in the opposite direction. That would preserve the git-blame
> history for shadow_mmu.c. But by the end of the series mmu.c and
> shadow_mmu.c are both ~3K LOC, so I don't think doing this is really any
> better. Either way, you have to move ~3K LOC.

I tried implementing this refactor both ways and ultimately found this
way to be a lot cleaner. Preserving the git blame for the Shadow MMU
code would be nice, since IMO it's the more complex code, but it got
complicated quickly. The in-between stages of moving around function
definitions to header files, and detangling code to move it back to
mmu.c, was a nightmare. It's relatively easy to move the leaf
functions in the call-tree, but I found moving the upper level
functions was difficult to do bit-by-bit.
If anyone wants to try implementing this commit in a more elegant way,
I'm happy to rebase the rest of the series on  top of it.
As you said, either way we gotta move 3K lines of code.
