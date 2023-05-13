Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8BD701427
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 05:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjEMDU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 23:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEMDUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 23:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01514C25
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 20:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63C866158A
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 03:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95E3C4339E
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683948023;
        bh=h35C6Fa/IubA/XIiPYtnT6mbZ75B3FvGWhFUVnOz2GQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IX7VQb4ZkpccT3E76GzFc/0tXdUCOe78ssKsBYSYGxQO5bP/Yl84RFTNsZ2eWtpgd
         IqXZEsozMsn9ZuKuDPD1hYFLuBX1m/oTJeGW5SoKrhEpF8HUYZHk+z8uKO0u8XWSNc
         4H4HG7zKN6Dlz979hHV8DYaeqBRulFMZxI0oRxYj5RuKLR1nVv7zGJEN0kEWl3hd+g
         QnStBmtdWEhAax5N9wKbcwpovcPpB5+F3EUfM37oGAevEBOwNCeyczz1NfdZGE6thj
         W1qZZsOvOBHyKjyEM0qqBDMp04TcWiZwQ3WZsZtC7PFZaCu3fkuscvDzeDjH36cmnh
         VuBxIYOTyZy4Q==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-50db91640d3so8237378a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 20:20:23 -0700 (PDT)
X-Gm-Message-State: AC+VfDwCFNrl8+HsS0oU2NIAQU1BfP5L4PeTVLNjSaPKMpjo4HlpV4L/
        p9pT6VH8gYcA6r+EvjC45UaXx1QslB7RYTHZN7o=
X-Google-Smtp-Source: ACHHUZ4diPanHZpH2zYp9Gi2nqVAvyLu7w1ym7rYDer4nc9PWyq7B2iX9aNWfy8GyxzB0v4O2HSGIeDkNWXrdMU3RAA=
X-Received: by 2002:a17:907:3e27:b0:965:b517:89a4 with SMTP id
 hp39-20020a1709073e2700b00965b51789a4mr23191186ejc.56.1683948022061; Fri, 12
 May 2023 20:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230509104127.1997562-1-chenhuacai@loongson.cn> <20230512165309.896e063a9398639250eab264@linux-foundation.org>
In-Reply-To: <20230512165309.896e063a9398639250eab264@linux-foundation.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 13 May 2023 11:20:10 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7zbc4hH=YJ9pZdT4jZC8=UUXewq6nbDVUjsAHp-bXWAg@mail.gmail.com>
Message-ID: <CAAhV-H7zbc4hH=YJ9pZdT4jZC8=UUXewq6nbDVUjsAHp-bXWAg@mail.gmail.com>
Subject: Re: [PATCH RFC] kthread: Unify kernel_thread() and user_mode_thread()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

On Sat, May 13, 2023 at 7:53=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue,  9 May 2023 18:41:27 +0800 Huacai Chen <chenhuacai@loongson.cn> w=
rote:
>
> > Commit 343f4c49f2438d8 ("kthread: Don't allocate kthread_struct for ini=
t
> > and umh") introduces a new function user_mode_thread() for init and umh=
.
> > But the name is a bit confusing because init and umh are indeed kernel
> > threads at creation time, the real difference is "they will become user
> > processes". So let's unify the kernel_thread() and user_mode_thread() t=
o
> > kernel_thread() again, and add a new 'user' parameter for init and umh.
> >
> > ...
> >
> >  5 files changed, 9 insertions(+), 26 deletions(-)
> >
>
> Less code is nice.
>
> > -extern pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned l=
ong flags);
> > +                         unsigned long flags, int user);
>
> `bool user'?
OK, I will do that in the next version if the whole patch is acceptable.

Huacai
>
>
