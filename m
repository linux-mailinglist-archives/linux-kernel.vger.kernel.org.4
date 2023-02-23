Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852AB6A10ED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjBWT6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBWT6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:58:22 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF6A59434
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:58:21 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x63-20020a17090a6c4500b00237731465feso617201pjj.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lATDuswOZbF3zLZuGn25g5w5EeOK39dFmfATzQI6x48=;
        b=WjkAmKeEgiP2hEXlbY746mkX3ZhOMGDC4P9c79ltVgkK2cIemHwqXcH6WrYyLHRdQF
         TPDAxjgYxRcgOZ9Cw42YNQatNy0fLX/b4SjlpRmVjocgTwZ+/NHLb7um96NikQlj0ehi
         z61VCGlKVn6yqKg+7X6pk7a0r38wnJVjrHrAZelDuyus9u6bCJc1ucQYnC0gwEUNfBwL
         13s742XTOtNhDMUSovA7LDI9gfjrAbYLiDVYULHMN2GVGPzYnZOpwz34E6zS9Nxlczcd
         dm/+tCl7gL4ogIAyiGwzVItI4JYWQw4a5Yck0h70zIDUUba1T72R6HIZu+LfmJQ/sl0T
         Hf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lATDuswOZbF3zLZuGn25g5w5EeOK39dFmfATzQI6x48=;
        b=ewHAKnyhy4AKi2P5soK40ChdzEU5TYn9oRzV8XQvLCZ6r5fNgFVH8xoJZVqi8Iplbz
         vx9tTye6FCYpsYIH3nNXdKYbuoe9ipEQs19uctIGrBNSmZOWoOmEtE2gPRJp01PP6kUh
         jH3xIQ8BRte0HUymoluz98Dbpu8yj/LzxIu1o2iVvoUbONpuYNAK3uY92s9fz1J6ql6c
         ixKDEcj6ZnOsZJOb4Bf5ADw9IO9cGiCeSyeUf+/5l9MsdAwfEmn7DhNiis8F70eIQVwN
         dizpQ46xRVPJqHsG2baiQvFWU96Ogn5w8WVjQeyZrLujB5E/YxVQ29t6z39G2/V0/cYp
         tKQA==
X-Gm-Message-State: AO0yUKVA4kbnlJtUbd9UrAPHXmL8UOjQ2iCBuyKXcEMkmxLMDk/Den28
        k23d2ze3n+WIyosfOq7RTMy1MLnXSCc=
X-Google-Smtp-Source: AK7set/ODb8D8144x2HqvMvJqO9rb7VbrC4eAbsdwQguwGwUJ87CVxuU31/KcwKltggxqLDvzZUouJLJe5k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:1993:0:b0:5a8:bdd2:f99c with SMTP id
 141-20020a621993000000b005a8bdd2f99cmr1974028pfz.1.1677182300738; Thu, 23 Feb
 2023 11:58:20 -0800 (PST)
Date:   Thu, 23 Feb 2023 11:58:19 -0800
In-Reply-To: <CAOUHufbwcqx21T=zmvYpnX_Mnd2A0KkPORbtxnJEwKuUKVSPzA@mail.gmail.com>
Mime-Version: 1.0
References: <20230217041230.2417228-1-yuzhao@google.com> <20230217041230.2417228-6-yuzhao@google.com>
 <Y/elw7CTvVWt0Js6@google.com> <CAOUHufbAKpv95k6rVedstjD_7JzP0RrbOD652gyZh2vbAjGPOg@mail.gmail.com>
 <Y/e6Z+KIl6sYJoRg@google.com> <CAOUHufbwcqx21T=zmvYpnX_Mnd2A0KkPORbtxnJEwKuUKVSPzA@mail.gmail.com>
Message-ID: <Y/fFWyYPu5Jf0de1@google.com>
Subject: Re: [PATCH mm-unstable v1 5/5] mm: multi-gen LRU: use mmu_notifier_test_clear_young()
From:   Sean Christopherson <seanjc@google.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <michael@michaellarabel.com>,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-mm@google.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023, Yu Zhao wrote:
> On Thu, Feb 23, 2023 at 12:11=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Thu, Feb 23, 2023, Yu Zhao wrote:
> > > > As alluded to in patch 1, unless batching the walks even if KVM doe=
s _not_ support
> > > > a lockless walk is somehow _worse_ than using the existing mmu_noti=
fier_clear_flush_young(),
> > > > I think batching the calls should be conditional only on LRU_GEN_SP=
TE_WALK.  Or
> > > > if we want to avoid batching when there are no mmu_notifier listene=
rs, probe
> > > > mmu_notifiers.  But don't call into KVM directly.
> > >
> > > I'm not sure I fully understand. Let's present the problem on the MM
> > > side: assuming KVM supports lockless walks, batching can still be
> > > worse (very unlikely), because GFNs can exhibit no memory locality at
> > > all. So this option allows userspace to disable batching.
> >
> > I'm asking the opposite.  Is there a scenario where batching+lock is wo=
rse than
> > !batching+lock?  If not, then don't make batching depend on lockless wa=
lks.
>=20
> Yes, absolutely. batching+lock means we take/release mmu_lock for
> every single PTE in the entire VA space -- each small batch contains
> 64 PTEs but the entire batch is the whole KVM.

Who is "we"?  I don't see anything in the kernel that triggers walking the =
whole
VMA, e.g. lru_gen_look_around() limits the walk to a single PMD.  I feel li=
ke I'm
missing something...
