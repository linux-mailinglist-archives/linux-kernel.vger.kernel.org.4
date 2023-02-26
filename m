Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8376A2E09
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjBZEEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjBZEEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:04:02 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E056D11659
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:04:00 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cy6so12841499edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydNEG6i1njPpUhHYW477txuJZoyUfrSlN9+lyZsORZc=;
        b=hKCI8tDvdl2kgPalORYkss42z/GJoxbrfe3A/5gvmIAGDcVYq3bjAc3T1Cgk65q6Nl
         pzDK949pAA3tAIRY/870y/f7xX/8fWCeOQ7z/oRTYDDmjS8HoxYo6yX4bZicQr+H0j9r
         BEpdWOxbdwmjZJwQKBixM24rAYWHhc7+iW4gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydNEG6i1njPpUhHYW477txuJZoyUfrSlN9+lyZsORZc=;
        b=nSWcd7MUZECn2n9yGfE9wHYXCD6PILkzrsyxF0BCZ29/2QUSHyLU8IKg26ZvVua5LU
         adUorlgJ3+iP6rdHm6ruMhmn8Y+DMhGjIJYdjcSz1U1ve5fi2NiECcNLB7jXBmkZde7z
         iqVwxDrBpSY/gdxCOy0Z0MM0xvt7841wgaoZGv7aSvyporX3wRJocR372+3/fC+6rz29
         h5m8mwod7InraQtH2X38UcnVKUkBKQQtQOnXJufPPHBUTSEJVGB/P4YKOLAVGcKUHmOt
         ifxAWRWXVFFw8q32RMFOq3ZvtQVStXG8Ma+WZetRFLxmTk2xLR3Ff11dSuief6AVta/Q
         fzEw==
X-Gm-Message-State: AO0yUKXXLjchcTO+jWhCm6dkLGMR2ZDIPTvJAoxY5rw+u4MAtPkUM6sK
        4G3hGED2dzbSgPSCrvTF+0ueUvm0c+FNhiVq2pCJUQ==
X-Google-Smtp-Source: AK7set/9FNF2KHsxSxEgbMuVlGan4RHFpAwB0Km2egOx/i6v3M/lyLP3XFGHMpn0ilf3yNptNhY+pQ==
X-Received: by 2002:a17:906:518d:b0:8b1:78b6:bbd7 with SMTP id y13-20020a170906518d00b008b178b6bbd7mr35999033ejk.10.1677384239033;
        Sat, 25 Feb 2023 20:03:59 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id g26-20020a170906199a00b008ea8effe947sm1519165ejd.225.2023.02.25.20.03.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 20:03:58 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id ee7so12916554edb.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:03:58 -0800 (PST)
X-Received: by 2002:a17:907:73c6:b0:8f1:fd:50d0 with SMTP id
 es6-20020a17090773c600b008f100fd50d0mr4382163ejc.0.1677384237911; Sat, 25 Feb
 2023 20:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
 <CAHk-=whVN2gKO_7UvMqgG8cetrVs3BCTxQovJvhC5x7AcJDJgQ@mail.gmail.com>
 <CAHk-=wgxWDgLJ-e3uDiYQvmMEqTNYFvDxtHbu4inR=zgBEP11Q@mail.gmail.com>
 <CAHk-=wjFmVL7NiuxL54qLkoabni_yD-oF9=dpDgETtdsiCbhUg@mail.gmail.com> <20230225195727.1b73a356f4f1a79833a31885@linux-foundation.org>
In-Reply-To: <20230225195727.1b73a356f4f1a79833a31885@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Feb 2023 20:03:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpy3yHt0X5Vb97kdvtryj93KVTJs07zLZVJ8zEXH=Q-A@mail.gmail.com>
Message-ID: <CAHk-=whpy3yHt0X5Vb97kdvtryj93KVTJs07zLZVJ8zEXH=Q-A@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.3-rc1
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 7:57=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> Liam sent us a fix yesterday, hopefully this?

Will test right away. It's certainly right in that suspicious area.

                Linus
