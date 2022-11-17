Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490DC62DD1E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbiKQNrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240352AbiKQNrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:47:09 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3F072986
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:47:07 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id b131so1890689yba.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBgn5FfavxoeQ10DPy6H31rWSKaucrVJq2p8zFcWxKg=;
        b=c8vO+LU/6D7WLpwp+xS+e7pSpjTJYsFE5wxwezmF8/RoKcKqrJZQ3VUZ5fF8CX/jbY
         ttUyIILBf0O5GwhZQwIkilveYui+lHb0dbfqNUNZzbmPHb1rcoT1FN4FFAtiP1dwKGMZ
         qU6ihrbZ3JwUSqNkqWHFdB6KB2vQRS3kATGkd0C4ulV0w648oN/YsD+VUcTc4IYv/x0L
         Wjw1cayxL8M/C3T/otTw1cN1x59Be6qTUc6tTki6nc1Gi007tmIokpieU8VkR9s1QpzS
         JwzpriJG08ep2sN9Zy/y66xkG4JqlcdcHdc3yHTFssABRtUZrdNsGYKYaDPvTjDt/fZd
         8mMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBgn5FfavxoeQ10DPy6H31rWSKaucrVJq2p8zFcWxKg=;
        b=rTJhKpDLFtTdpZO67KcY7sh5Y81+hnS4OozY5dJ5jK+eri5r2YHfmsY6nAcVpEF0th
         Pfv5PgTwanKaBrD55yDOMmygopjc1cV5fFGZnOIzirUR6yxxsytVtRe9G5/DFk0DcxIR
         YxMNGiDf8cKBoTcATewusIP/Z7AAW7pstZhex3JShAe1wcH85opy1NX6cF0hnPFV1jKf
         Q3ghbTg1a3bpaUt3b+XqEoIgToCU9kO3CL1cWXE2A1O8kFaW7IucJnNCwWXcc62gM0sI
         MeTnozE0PDS0ZPNJhzZeXZu1rMuExJz91VClaKSE9ck4RXVxxD9AMe12sCCIOVQd/WS5
         IvAg==
X-Gm-Message-State: ANoB5pmeDHyHmTplYy48pLKNpBRkYCrTkW3Gcl41seF5LdBFB2ptKPBg
        7rSelMMp5azzC6UEG1Ir3xcJ6yPnoZSjHU2vxEqGoA==
X-Google-Smtp-Source: AA0mqf5DA2St0Zb3VPFdfrjrKJWXQbBpURxq8lktGKo5RRNI3h3NDvIgMgHA8sWN0gARZLOBu4Ye2QdYcMogA+UjaPg=
X-Received: by 2002:a25:8390:0:b0:6de:5b33:4a29 with SMTP id
 t16-20020a258390000000b006de5b334a29mr2076908ybk.485.1668692825505; Thu, 17
 Nov 2022 05:47:05 -0800 (PST)
MIME-Version: 1.0
References: <Y3VEL0P0M3uSCxdk@sol.localdomain>
In-Reply-To: <Y3VEL0P0M3uSCxdk@sol.localdomain>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 17 Nov 2022 14:46:29 +0100
Message-ID: <CAG_fn=XwRo71wqyo-zvZxzE021tY52KKE0j_GmYUjpZeAZa7dA@mail.gmail.com>
Subject: Re: KMSAN broken with lockdep again?
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, Nov 16, 2022 at 9:12 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Hi,
>
> I'm trying v6.1-rc5 with CONFIG_KMSAN, but the kernel continuously spams
> "BUG: KMSAN: uninit-value in __init_waitqueue_head".
>
> I tracked it down to lockdep (CONFIG_PROVE_LOCKING=3Dy).  The problem goe=
s away if
> I disable that.
>
> I don't see any obvious use of uninitialized memory in __init_waitqueue_h=
ead().
>
> The compiler I'm using is tip-of-tree clang (LLVM commit 4155be339ba80fef=
).
>
> Is this a known issue?
>
> - Eric

Thanks for flagging this!

The reason behind that is that under lockdep we're accessing the
contents of wq_head->lock->dep_map, which KMSAN considers
uninitialized.
The initialization of dep_map happens inside kernel/locking/lockdep.c,
for which KMSAN is deliberately disabled, because lockep used to
deadlock in the past.

As far as I can tell, removing `KMSAN_SANITIZE_lockdep.o :=3D n` does
not actually break anything now (although the kernel becomes quite
slow with both lockdep and KMSAN). Let me experiment a bit and send a
patch.
If this won't work out, we'll need an explicit call to
kmsan_unpoison_memory() somewhere in lockdep_init_map_type() to
suppress these reports.


--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
