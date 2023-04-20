Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA436E9DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 23:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjDTVfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 17:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjDTVfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 17:35:18 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181074EFE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 14:35:12 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-555e853d3c5so1372917b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 14:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682026511; x=1684618511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAtKlPyaz0Y+z5eMdqbBW5ll6BSj5ZVTotD7NM9VGk0=;
        b=Dy3leCS5rDy01cDHqMD4Uj1hUhy6eZr8hxZCg+4JrB81Bu7FSbg7cw5+7E2asxryLO
         V+UZC9+sn3C4Xmd/QVPOwIipIqNaX9fYU7jH6LEYiVqr2VOiPljubc8E/b7X2lSvp2S5
         HGnmY8inJmS0E26WdHgi4/OJqihy97eQD+xGXk10/t/SYsF/1tb1I9zduDYIodDhmOoG
         EcIPDVIiG0U7u2hegtpBScFG/9kZEawylL5mqZqz05AMjz6GdWUTFSvugSu5glBq3fPg
         VAlSJrj5qm7BStvLTnVeNh/qdZnljEcex9g1uAQdb9Vf3mbM/GaJ0a0NOBOWATrd9X6C
         Uyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682026511; x=1684618511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAtKlPyaz0Y+z5eMdqbBW5ll6BSj5ZVTotD7NM9VGk0=;
        b=KHmnwjw1vKqjP1FLB4JVxAEJuIWJlTnNZHmxgvKHD4q9CzaBWPlV5zpk/vifPE7Xa4
         jtjmhwkAc5D5XFLGHH2vOVkI4mAkS7RLcS7XUGAgKX0NGQGHHdJH60aDjM7s6NvEFPQe
         01HiusvRU6E5lCT7MyTdG1L9fyXt/ON1GqOOniMuxg+v2HuKvBX21e7qdEhhiBIS4bvd
         XphSoCe/MaZ9gh2Yg7pGCCQHac6YphukMT1voGXBrTnAAosvD9TOi+bN73jk6xs73e0s
         SztkTPWnTQK0KwxDbyfQy4wgIhAu46YhDHmzL9t7qsg1/xpiIeadmlsNrdUWvjZQSB+5
         wm3A==
X-Gm-Message-State: AAQBX9cwuGTeszWuQsrhfFiYJJ8M0UcIyfDyVRwdSUfJ29dJa33rbghP
        FrQ9BU5y/I/1Z0xupChZWylS5aJMGd9mSyKRn+arww==
X-Google-Smtp-Source: AKy350ZGWOD0etCrOpfPd0P/3YE+0h12xfhLtjMUG/x+xKcQBPBvMpR1EZqIo26T/6Qc7ObkPpIB8pMP/nCcrWWUb+A=
X-Received: by 2002:a25:5387:0:b0:b95:2132:7252 with SMTP id
 h129-20020a255387000000b00b9521327252mr316633ybb.57.1682026511106; Thu, 20
 Apr 2023 14:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <ZEGh4mliGHvyWIvo@google.com>
In-Reply-To: <ZEGh4mliGHvyWIvo@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 20 Apr 2023 14:35:00 -0700
Message-ID: <CAJuCfpEGBquOjEBFD87DEHqWc0TZ8TkLHRh6RAjR=1wFPbMNHw@mail.gmail.com>
Subject: Re: Using page-fault handler in binder
To:     Carlos Llamas <cmllamas@google.com>
Cc:     linux-mm@kvack.org, tkjos@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com
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

On Thu, Apr 20, 2023 at 1:34=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> Hi,
>
> I'm trying to remove the current page handling in binder and switch to
> using ->fault() and other mm/ infrastructure. See, we currently allocate
> and insert pages manually into vmas, so dropping this boilerplate code
> seems like a great idea to me. Before starting on this though, I could
> use some pointers on some of the implementation details.
>
> In binder the messages are not buffered. What happens is that a server
> task mmaps a region and then allows clients to write their user data
> directly into this _remote_ vma. This is currently achieved by caching
> pointers to every page allocated in the server's region.
>
> Instead of caching page pointers, I believe binder could make use of
> get_user_pages_remote() and trigger a page fault as needed. Basically,
> implement something similar to access_remote_vm() but that instead does
> a copy_from_user(). However, I don't see many in-tree users of these
> routines, so I wonder if I'm overlooking something in this approach?

Sounds doable but there might be GUP details I'm missing...

>
> One more reason for the page caching in binder is being able to free
> pages from the shrinker's callback. Unused pages are added to an LRU
> list and we manually zap/free them when they are reclaimed. It is not
> evident to me how can binder mark a range within the vma region as
> reclaimable?

I think you would have to release the individual pages using
put_page(). Also note that get_user_pages_remote() is being
deprecated, see:
https://elixir.bootlin.com/linux/latest/source/mm/gup.c#L2171

>
> Any pointers are appreciated!
>
> --
> Carlos Llamas
