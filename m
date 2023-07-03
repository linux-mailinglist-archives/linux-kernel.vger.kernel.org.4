Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DA27461C9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGCSI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjGCSI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:08:56 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5152E71
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:08:45 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-c4dd86f5d78so2763654276.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688407725; x=1690999725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjP+t63cmXLZ73zOjZVRIKi8PaFjf6acXyVJzs/mz5o=;
        b=35oM3+4s76Gmu0eP07vWHgS6Rk1tmz7OxtUeUPJT2hC5YGbhWy3+elQhg6NwyPjOgC
         M5zGqi2lKBWN4PdxjaMCXIIyyVAmd+jOB8Cyi2Ra59jlhyS1r2WxTzJaGA+WlAFGKg7x
         UAN6LJSmzeDRQvjEALRuAl699XjFjFLbfZ4vVLR5K+3GGUenIRNYaJhyQ0g/oQuHu6jN
         7b7Io6rtkhGFBOyeFVv0UpwjuK3CM3KJZFW5M0FVXmWcD6eRcW0JbeDlDssgckP6Ht3O
         ygvptCGOnz2qiBH7Wb7KL+uCmr3fzfEIK0VI707ZQLPwzcjlupIU/DlzVVNDLPHuwFkt
         z/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688407725; x=1690999725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjP+t63cmXLZ73zOjZVRIKi8PaFjf6acXyVJzs/mz5o=;
        b=iZw7nzOqnKlmqQWJLM+9CREPO1DEkDn4zhYlPtHiCf+81A88TEmtxUy6aAlLzaiT5i
         ln4A7sN+nzjkZGaqsBb4OHc6NThWnUf/qkx37Mw+dXmt3vKvyirEGMm5kuH9rQM7iFy+
         5UP7NJZh2RVtvBbmEZ6mOBNrOyKi8Ng6/Jdsjl03ByRLDdSQqGe0YOMxKFdLWKSwWxK4
         fjNcYViU6A8Mh7TT8egNxKhOVVYF8e1Z9BRsiltqohkoqD4wSXX0zs7hIatkJUlfH1bo
         qOq2kp2lAcFoGCqADkCwnjTSrmEXIzut4LCmGFl4ghjf9btlj7u0lclpKzAKNZ9cCncR
         kBlw==
X-Gm-Message-State: ABy/qLaSpZnu/wA1moqwoTYmQ2DnjpdFlrf1Uec3mcEhY7jaKNZAXF0H
        nbV6Jga4Xhfi6jrAp/Lqu0IbdLf9Hb4tbPgq0fXjeA==
X-Google-Smtp-Source: APBJJlHqFAXrJx6IysDJ2T6WOUSv+vPO3CrUXTDQ+klQimcwHP1PCpSvjaq7m7khAiRcDXbb9/iNwUyOESsL1qgRn9o=
X-Received: by 2002:a25:1003:0:b0:c3a:8530:c8a9 with SMTP id
 3-20020a251003000000b00c3a8530c8a9mr12592615ybq.11.1688407724626; Mon, 03 Jul
 2023 11:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com> <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info>
In-Reply-To: <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 3 Jul 2023 11:08:33 -0700
Message-ID: <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
Subject: Re: Fwd: Memory corruption in multithreaded user space program while
 calling fork
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Young <jacobly.alt@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 2:53=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 02.07.23 14:27, Bagas Sanjaya wrote:
> > I notice a regression report on Bugzilla [1]. Quoting from it:
> >
> >> After upgrading to kernel version 6.4.0 from 6.3.9, I noticed frequent=
 but random crashes in a user space program.  After a lot of reduction, I h=
ave come up with the following reproducer program:
> > [...]
> >> After tuning the various parameters for my computer, exit code 2, whic=
h indicates that memory corruption was detected, occurs approximately 99% o=
f the time.  Exit code 1, which occurs approximately 1% of the time, means =
it ran out of statically-allocated memory before reproducing the issue, and=
 increasing the memory usage any more only leads to diminishing returns.  T=
here is also something like a 0.1% chance that it segfaults due to memory c=
orruption elsewhere than in the statically-allocated buffer.
> >>
> >> With this reproducer in hand, I was able to perform the following bise=
ction:
> > [...]
> >
> > See Bugzilla for the full thread.
>
> Additional details from
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217624#c5 :
>
> ```
> I can confirm that v6.4 with 0bff0aaea03e2a3ed6bfa302155cca8a432a1829
> reverted no longer causes any memory corruption with either my
> reproducer or the original program.
> ```
>
> FWIW: 0bff0aaea03 ("x86/mm: try VMA lock-based page fault handling
> first") [merged for v6.4-rc1, authored by Suren Baghdasaryan [already CCe=
d]]
>
> That's the same commit that causes build problems with go:
>
> https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.o=
rg/

Thanks! I'll investigate this later today. After discussing with
Andrew, we would like to disable CONFIG_PER_VMA_LOCK by default until
the issue is fixed. I'll post a patch shortly.

>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot introduced: 0bff0aaea03e2a3
