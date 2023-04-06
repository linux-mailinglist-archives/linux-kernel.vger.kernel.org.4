Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212EC6D8D91
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 04:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjDFCkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 22:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDFCkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 22:40:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CF7121
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 19:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CE116421F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74350C433A7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680748811;
        bh=LkwP71SP/70ZN7M7Tv0EhvcohUjcinoOGkY82vHCOIo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MTM6vfcXqjdgV9GdqsYJUtrE4BqMldYTjp7lpRIMw4s00ZdAmL8ieghHZMw5ZsteZ
         axdWzcrxpeaSAPJ01Y9RjHvUWfdGDMlRKP8DrYisI9ce8HIBE+rf9iFO5f7HSViFDO
         FitcbcvmEzDIdhBok/zX/6gaUJExy+GMQDidhcABEW9nFWXZbIXC/RAX6ouigQUN/J
         EBApsb0loXxcBYx9es0E9qmjMHPzxgY1cPO06J3b3gZ35UveohjY5tfTR+F5Ht+g0j
         a7gpjiYFnsBfQibKonJbnTgPU3C3Aa689O9QEVkI5dQJVtdiTlUlxIHdU1D5Ub5OLv
         UvAsZAhEEVPbQ==
Received: by mail-ed1-f51.google.com with SMTP id t10so145729444edd.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 19:40:11 -0700 (PDT)
X-Gm-Message-State: AAQBX9fE1AG8O8ywgIMH7+3Asq/mrqjJ22KWbGMCU9DELi2ERP4lgNEv
        9ZzTxcenAxs8o7f3DtwRPj3vy/IWZENgyeJUxdg=
X-Google-Smtp-Source: AKy350aWeiHvNj8ZW9kSwuOqRDOkYxlEWFxyXAsuIiEnuRY8aPMiLWJ+5aUOybtMjd4vaa+r9GEyeboXqzRhZFPjj8Y=
X-Received: by 2002:a17:906:2b49:b0:939:e928:5323 with SMTP id
 b9-20020a1709062b4900b00939e9285323mr4893999ejg.54.1680748809602; Wed, 05 Apr
 2023 19:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230404163741.2762165-1-leobras@redhat.com>
In-Reply-To: <20230404163741.2762165-1-leobras@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 6 Apr 2023 10:39:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTBm7_krSFjfSjD62pbfcaUOrfUhXzoHUD1-DKQ_SCLhA@mail.gmail.com>
Message-ID: <CAJF2gTTBm7_krSFjfSjD62pbfcaUOrfUhXzoHUD1-DKQ_SCLhA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/6] Deduplicating RISCV cmpxchg.h macros
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Leonardo,

It's a good point for cleaning up.

On Wed, Apr 5, 2023 at 12:37=E2=80=AFAM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> While studying riscv's cmpxchg.h file, I got really interested in
> understanding how RISCV asm implemented the different versions of
> {cmp,}xchg.
>
> When I understood the pattern, it made sense for me to remove the
> duplications and create macros to make it easier to understand what exact=
ly
> changes between the versions: Instruction sufixes & barriers.
>
> I split those changes in 3 levels for each cmpxchg and xchg, resulting a
But how about merging 3 levels into one? (I mean one for cmpxchg and
one for xchg, resulting in 2 patches.)

> total of 6 patches. I did this so it becomes easier to review and remove
> the last levels if desired, but I have no issue squashing them if it's
> better.
>
> Please provide comments.
>
> Thanks!
> Leo
>
> Changes since v2:
> - Fixed  macros that depend on having a local variable with a magic name
> - Previous cast to (long) is now only applied on 4-bytes cmpxchg
>
> Changes since v1:
> - Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build error
>
>
> Leonardo Bras (6):
>   riscv/cmpxchg: Deduplicate cmpxchg() asm functions
>   riscv/cmpxchg: Deduplicate cmpxchg() macros
>   riscv/cmpxchg: Deduplicate arch_cmpxchg() macros
>   riscv/cmpxchg: Deduplicate xchg() asm functions
>   riscv/cmpxchg: Deduplicate xchg() macros
>   riscv/cmpxchg: Deduplicate arch_xchg() macros
>
>  arch/riscv/include/asm/cmpxchg.h | 319 +++++++------------------------
>  1 file changed, 67 insertions(+), 252 deletions(-)
>
> --
> 2.40.0
>


--=20
Best Regards
 Guo Ren
