Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEC1644F4D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLFXG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLFXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:06:48 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB48133E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:06:47 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id p6so1714082iod.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 15:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sA3sjQAvR4Ek/3QMCJY43+RjUNmHy7Dfxf/9gm5VFbI=;
        b=q41btqjTN1g6wSV5wy5w7l9QcmnucyeGqTsxtmrX2YWMcRgt/fYk0QFjrLrxzU2vp7
         JsBRPiLk9efYzFk6s2RMlNJXpOX75qD7DIPlGSzwdxrYt7N4WpX0yWoHupWPyPnW+xOH
         KI/D9J/z+VReTTW8DekhvghP0PdetFJGOXn0EHlTbgTSVjNeKbIKDBVxUoZFj6qxEYko
         X8kDPJ8gbtIpY4Ikr1sbXXad3d/y7jJl/AA0ngL5b980TVLexb0996TUr8bwrUcy7a2r
         UKASpj2LZKoZjqjwQ/uaabyR+iyCYjyHFtBIFP7cqNJOfTUw9SxMD67jPu5ZaZR9GrpW
         Z9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sA3sjQAvR4Ek/3QMCJY43+RjUNmHy7Dfxf/9gm5VFbI=;
        b=UgdJedOk6svjgArMEPUOB5BoF+nsl1NZhP4KC8z7MJj2itKjjfmFP/bNKULndJ+zmf
         v/1Ki5xbAf/dzthGDhqi1ukmZcSJmyNJ2rXfDuRUgcMlCaOo8r9dJYbCugogbwGX2RqT
         nonnKxrgfmLP8lw37YKvaqJCR8yfdGaErCUk+exqo1eZS1fnsdMphy+oEfzatHqDW5JQ
         O8Ieb7Iw2ACZPCf0A0aeTTPJYA7XJDLaWGkjGAqeKhr9bnXoCc7bE5V8u9knMiMlh75y
         FkGiq3eowCn4whvhMsbwZ4gJ1pfG5MQgSXPRl2mZUqdtw88JqhTpnKzRn/u53bXAa22X
         3eiA==
X-Gm-Message-State: ANoB5pkmzJAvwvRQHEYfRzebuNmZ+zfBsBn+Zj+a01ltTa+V30AVhnT7
        DO0HQDBC3CquC0EAJF/lIZDOnaOS4TnMnz/dxTlK6Q==
X-Google-Smtp-Source: AA0mqf6ObRBvPvhqUmk6bvzlLD4JOKN66H5zhQrulgX8En0X+S1hnoeGOmd6XWCvIYPK5yU7Y8w0/Xz4O9xVQafu40I=
X-Received: by 2002:a6b:fd0e:0:b0:6df:5e6c:f5c7 with SMTP id
 c14-20020a6bfd0e000000b006df5e6cf5c7mr22058218ioi.207.1670368006978; Tue, 06
 Dec 2022 15:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20221129191237.31447-1-mizhang@google.com>
In-Reply-To: <20221129191237.31447-1-mizhang@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Tue, 6 Dec 2022 15:06:36 -0800
Message-ID: <CAL715WLSgB8dUJYXg1LjXq-nA8DbAZSb=ORMO7JzBj8iG=o5JA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/2] Deprecate BUG() in pte_list_remove() in shadow mmu
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
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

gentle ping on this one?

On Tue, Nov 29, 2022 at 11:12 AM Mingwei Zhang <mizhang@google.com> wrote:
>
> Deprecate BUG() in pte_list_remove() in shadow mmu to avoid crashing a
> physical machine. There are several reasons and motivations to do so:
>
> MMU bug is difficult to discover due to various racing conditions and
> corner cases and thus it extremely hard to debug. The situation gets much
> worse when it triggers the shutdown of a host. Host machine crash might
> eliminates everything including the potential clues for debugging.
>
> From cloud computing service perspective, BUG() or BUG_ON() is probably no
> longer appropriate as the host reliability is top priority. Crashing the
> physical machine is almost never a good option as it eliminates innocent
> VMs and cause service outage in a larger scope. Even worse, if attacker can
> reliably triggers this code by diverting the control flow or corrupting the
> memory, then this becomes vm-of-death attack. This is a huge attack vector
> to cloud providers, as the death of one single host machine is not the end
> of the story. Without manual interferences, a failed cloud job may be
> dispatched to other hosts and continue host crashes until all of them are
> dead.
>
> For the above reason, we propose the replacement of BUG() in
> pte_list_remove() with KVM_BUG() to crash just the VM itself.
>
> v3 - v4:
>  - update code to integrate messages into KVM_BUG() [seanjc].
>  - update commit message [seanjc].
>
> v2 -> v3:
>  - plumb @kvm all the way to pte_list_remove() [seanjc, pbonzini]
>  - https://lore.kernel.org/lkml/20221128002043.1555543-1-mizhang@google.com/
>
> v1 -> v2:
>  - compile test the code.
>  - fill KVM_BUG() with kvm_get_running_vcpu()->kvm
>  - https://lore.kernel.org/all/20221124003505.424617-1-mizhang@google.com/
>
> rfc v1:
>  - https://lore.kernel.org/all/20221123231206.274392-1-mizhang@google.com/
>
>
> Mingwei Zhang (2):
>   KVM: x86/mmu: plumb struct kvm all the way to pte_list_remove()
>   KVM: x86/mmu: replace BUG() with KVM_BUG() in shadow mmu
>
>  arch/x86/kvm/mmu/mmu.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
