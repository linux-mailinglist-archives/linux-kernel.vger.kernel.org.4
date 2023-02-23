Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D0D6A110C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBWUKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBWUKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:10:15 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370032ED68
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 12:10:13 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id o6so17842846vsq.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 12:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tb4E/KDAfmO+OWY5M3vwQnCShVGqXeIPzhu+t6ji2TI=;
        b=Buy8GsfJbaC7xe6w4gIMVDaR17FRMpXubc52+8pPyuvFEIOFipuVV1KBEuKEAKh0El
         7DlCtGhjvPy6R3F83LlbXWVkFsviditFGOnyOFNuaCOFkrNwI/obEofFnE7fHFIFAjz5
         TS0RlbZVFOqi87gU5+jO/2VyNSZYlD1MRdH/KauUtlrOFE91xF4O4zPf42C2bpL/k3d4
         f10eOthZsxd161U/wfkLecBG0lA6RlgWgp1Y7V0lS1+X71MKNI7c2knUOng4oSETF3N3
         4wA3dsBYF7sv1XPjiAiCOtvvfYyIrBnGgsjlWHce/SoH5Z12GmZZtRDih8OTERcpCo1Z
         77Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tb4E/KDAfmO+OWY5M3vwQnCShVGqXeIPzhu+t6ji2TI=;
        b=MvnuWFdLGMoltJ9x+49hCSDt3JngqzUNUErjHWUsyA1w0sZ/chw6K6ji86OFx2J7GO
         EQSMX4IuWwQM4qDzXfNDeHwIyj2fh+40LzvuGeOx23imVVAQWIMiWjKjcO7EIrZ8CvBc
         EBNT0oMKfuafGbZb5oJ3ew76GD9AOY5KIQBauH8rSW/PlSnuLZ7iuJKTJJ2ood/2aAzv
         FdZikR1ygvM26sMddcCOACzisp29zkV+zf4SlXKq7YB2Y37CyOMZIpnkautRL8u9QIwm
         h734D5f+PSiebHiGk/HfpwAUtJS+LkoxCg5Vv5byRZx2SuqvmQFs9znxG6VAkifNepjv
         OSlg==
X-Gm-Message-State: AO0yUKUKuArzxvnBkVNyj8UCQwJLmiw8BNOoBvgMxzTYYIg4vHWII6RK
        kho3V+XD6YWCR4TPb9WVc/U5QGvUBuKH1za2ooU/CA==
X-Google-Smtp-Source: AK7set/BdoUj1YfuS8JpwJQ04kHrKoqkmuSB4hZ/qUc3HI+kpJOsmACSu4zfNA2VRxx+6n1Ke4C2BNibi2yxxoTp1zE=
X-Received: by 2002:a05:6102:3181:b0:414:34d3:89a with SMTP id
 c1-20020a056102318100b0041434d3089amr752650vsh.6.1677183012138; Thu, 23 Feb
 2023 12:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20230217041230.2417228-1-yuzhao@google.com> <20230217041230.2417228-6-yuzhao@google.com>
 <Y/elw7CTvVWt0Js6@google.com> <CAOUHufbAKpv95k6rVedstjD_7JzP0RrbOD652gyZh2vbAjGPOg@mail.gmail.com>
 <Y/e6Z+KIl6sYJoRg@google.com> <CAOUHufbwcqx21T=zmvYpnX_Mnd2A0KkPORbtxnJEwKuUKVSPzA@mail.gmail.com>
 <Y/fFWyYPu5Jf0de1@google.com>
In-Reply-To: <Y/fFWyYPu5Jf0de1@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 23 Feb 2023 13:09:33 -0700
Message-ID: <CAOUHufYWktz4SNjL_o_2oZNcJLXserwCot-Prv4UEG9uzn57rg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 5/5] mm: multi-gen LRU: use mmu_notifier_test_clear_young()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <michael@michaellarabel.com>,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-mm@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Feb 23, 2023 at 12:58=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, Feb 23, 2023, Yu Zhao wrote:
> > On Thu, Feb 23, 2023 at 12:11=E2=80=AFPM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > >
> > > On Thu, Feb 23, 2023, Yu Zhao wrote:
> > > > > As alluded to in patch 1, unless batching the walks even if KVM d=
oes _not_ support
> > > > > a lockless walk is somehow _worse_ than using the existing mmu_no=
tifier_clear_flush_young(),
> > > > > I think batching the calls should be conditional only on LRU_GEN_=
SPTE_WALK.  Or
> > > > > if we want to avoid batching when there are no mmu_notifier liste=
ners, probe
> > > > > mmu_notifiers.  But don't call into KVM directly.
> > > >
> > > > I'm not sure I fully understand. Let's present the problem on the M=
M
> > > > side: assuming KVM supports lockless walks, batching can still be
> > > > worse (very unlikely), because GFNs can exhibit no memory locality =
at
> > > > all. So this option allows userspace to disable batching.
> > >
> > > I'm asking the opposite.  Is there a scenario where batching+lock is =
worse than
> > > !batching+lock?  If not, then don't make batching depend on lockless =
walks.
> >
> > Yes, absolutely. batching+lock means we take/release mmu_lock for
> > every single PTE in the entire VA space -- each small batch contains
> > 64 PTEs but the entire batch is the whole KVM.
>
> Who is "we"?

Oops -- shouldn't have used "we".

> I don't see anything in the kernel that triggers walking the whole
> VMA, e.g. lru_gen_look_around() limits the walk to a single PMD.  I feel =
like I'm
> missing something...

walk_mm() -> walk_pud_range() -> walk_pmd_range() -> walk_pte_range()
-> test_spte_young() -> mmu_notifier_test_clear_young().

MGLRU takes two passes: during the first pass, it sweeps entire VA
space on each MM (per MM/KVM); during the second pass, it uses the rmap on =
each
folio (per folio). The look around exploits the (spatial) locality in
the second pass, to get the best out of the expensive per folio rmap
walk.

(The first pass can't handle shared mappings; the second pass can.)
