Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AAB6870FD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjBAWa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjBAWaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:30:55 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF19567784
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 14:30:52 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id be12so289853edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 14:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5kWx+V0wRwfelWvx8ZnWkLRBQOhWEOCcxh3WzOgUgBw=;
        b=HwpsUeQDh+kHVrtstp3KwmBL2kVLxQ06KXwCjbP3YQR2Qj0HhDrU0if1gxXowZJWPo
         JEOotxRnRmpt297JpSJA/p86ZVgOeul1B+y0kuNEzvQEKtraEIvlnloGjFE06bxYGwSh
         7N6FcJnyH6cm/5TdiyoKc2/PI2dwuwZixTfL9s1DuCrX/mlwLkDxCnq5QjGStpEFq1eC
         /gphcK01OCUkzglFI1y3GQGRZpgCE2zv7ijRXzAsKu2HN5VoawxarHEp5xC9y3sD07Lu
         CiDRvxk4NqOF914VhF73FLV1loDl7TM3LwgyS/hTZQ01g0CgVncQ8prkyo1MwXXUGxHd
         EXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5kWx+V0wRwfelWvx8ZnWkLRBQOhWEOCcxh3WzOgUgBw=;
        b=Ubx3nwwrom+gKHFNbwZHlXCTkUGRqj1V2fnav55Et1Bzdi9g/E4t3LzHGAMBRCsNv4
         j1WqODOlEdpjeKnrvYyXJo6iKGBoWssxScu/YN19+lNSZjK+GF9CcSo6jtMtqUEFBB7p
         Dcc/7vEnVwBAzQVI7yo1uZfsbu+AO11LkbkWNl3iBa2rFQXZV13qMrPN1+fsvMUz3mCv
         eAeNJuJ/QFRFxyltBiXUOkriL+etCAyJI7bQ2WvtG7JD3IUYiO9olZSeYIQWIrUgzVQo
         tqKO+GjLTTHQoyptqvOnPD2jR8GWdM+kcHv7aUfwHUYFi1z4XZPJNKVHi4VywtNMh3/7
         7Uyg==
X-Gm-Message-State: AO0yUKV+ivg4Mxt8OL0y8lOIK1hj3NudVxXAeKxOGSLTghIg+BcNNKb6
        O1LRny3JzIVCj9s7dnwqYHyQGgv6FoSXve0RBB8kQA==
X-Google-Smtp-Source: AK7set/LiX2n16gPIG2He7x9UbmCd6sZ5zmAX/x7W1JhkzPw0D720hmw2lH2gx8T6UdQFfA5emTzePgcc4RBGzRtXXI=
X-Received: by 2002:a50:ab04:0:b0:4a0:b0ed:9ff8 with SMTP id
 s4-20020a50ab04000000b004a0b0ed9ff8mr1208762edc.39.1675290651292; Wed, 01 Feb
 2023 14:30:51 -0800 (PST)
MIME-Version: 1.0
References: <20221221222418.3307832-1-bgardon@google.com> <20221221222418.3307832-14-bgardon@google.com>
 <Y9rY2zE/xIgFbc5Q@google.com>
In-Reply-To: <Y9rY2zE/xIgFbc5Q@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 1 Feb 2023 14:30:39 -0800
Message-ID: <CANgfPd-C774w5M0nvhS-H8vH79LbGjmyDOLau1QqNAncjhLGyg@mail.gmail.com>
Subject: Re: [RFC 13/14] KVM: x86/MMU: Wrap uses of kvm_handle_gfn_range in mmu.c
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Nagareddy Reddy <nspreddy@google.com>
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

On Wed, Feb 1, 2023 at 1:25 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Dec 21, 2022, Ben Gardon wrote:
> > @@ -978,9 +978,13 @@ static void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
> >            slot_rmap_walk_okay(_iter_);                               \
> >            slot_rmap_walk_next(_iter_))
> >
> > -__always_inline bool kvm_handle_gfn_range(struct kvm *kvm,
> > -                                       struct kvm_gfn_range *range,
> > -                                       rmap_handler_t handler)
> > +typedef bool (*rmap_handler_t)(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
> > +                            struct kvm_memory_slot *slot, gfn_t gfn,
> > +                            int level, pte_t pte);
> > +
> > +static __always_inline bool
> > +kvm_handle_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range,
>
> Don't split function returns/attributes from the function declaration.  I don't
> think the rule ended up getting officially documented and enforced, but Linus was
> unequivocal when it came up[*], and I happen to agree with him :-)
>
> Actually, since I'm guessing you got the idea from existing code, can you fold
> in the attached patches to purge the existing cases in mmu.c before those uglies
> get moved around?  Assuming you don't dislike the proposed rename, that is.
>
> [*] https://lore.kernel.org/mm-commits/CAHk-=wjS-Jg7sGMwUPpDsjv392nDOOs0CtUtVkp=S6Q7JzFJRw@mail.gmail.com

Sounds good to me. Added the attached patches to the start of the series.

I didn't love those weird splits in the function def. Happy to see
them cleaned up too.
