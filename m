Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285DA699A33
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjBPQfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBPQfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:35:17 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935061B574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:35:15 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r18so1978850wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YvjzzplOyYWEsKigVOczYa0vP8bscsvw+TTYRzm8kTA=;
        b=ZoTA6ZJXVLKPbFha4y+xPdeteo9LtJCJyQpII736FkH/gzol2AFDWafQWxmS9u6AQc
         fkV48+8oJPFcsO5/lv3tcQrpHmY3p3XbDHxlawKTj9AF0bPHF5tYBMZhvo5IaAjdXoIE
         FZYywLNHjXt2xmFY+llQF4SaB1lLvzFns8jBCfMbPc23GNLa4/N+YhZe8trEFASZmSCH
         ZrSPNq4HCzR6EGqllpNqCxMDqSHboZtftaCrpf5K8F8vsoIXOe021c+TicDIvYKCC7d1
         YsDsJYSutiT/EHUDO3VELGOsdm2mFSFGo0McaL12CvzxGfXxLG3TGAKCHt3IrPHgn4Ko
         5MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvjzzplOyYWEsKigVOczYa0vP8bscsvw+TTYRzm8kTA=;
        b=ujBwtw4HUB2Tn5+fpAQAREZ1emtp/sHCZizqhnoVBxK9NKt77yLHQQxbfCfGLEV2hR
         CFG3z7jmXzT5e5pwyeRGtNZq9nj3sWfILpy/0LimlazpbhVnUc4gERBVfJ4zgZDehhbt
         JD1hVrmOS71+9ORWAiHTRdKoZDgLHkd+Gv3rlGT7kqeONQiQYP9mF0UvmzNQI2/z6ZVF
         giM+jfUSt9MwMmCoDctRizjEXPytw1OSgujkTqKArH3ZH8dwJmmN6bKIf21PrRImLt3y
         cdRizLeoqIkpjV70XT4RUGUN247Y++cbh5XE50fjpoPaOUFGnZNVQuKAmRddY+Pl4FAH
         8dHQ==
X-Gm-Message-State: AO0yUKXJQXa/AIqX5NZVXuXeQCFhHaOEwZOgLeGXbLZVWDptWgYIMHcP
        sY6TK2iVI21MnKO12Gxz9uTsh4+BOauZkcjXjtdBwA==
X-Google-Smtp-Source: AK7set+mxzqP+2cX9xGG+98a7W1aFhcKpWtSQRoANqVGk5nbllqVo0cocFoUDZ94JXpln7JDwQwk8FwQ2GeMPClgJuc=
X-Received: by 2002:a05:600c:46d0:b0:3dd:67c6:8c58 with SMTP id
 q16-20020a05600c46d000b003dd67c68c58mr353816wmo.51.1676565313986; Thu, 16 Feb
 2023 08:35:13 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvZqytp3gMnC4-no9EB=Jnzqmu44i8JQo6apiZat-xxPg@mail.gmail.com>
In-Reply-To: <CA+G9fYvZqytp3gMnC4-no9EB=Jnzqmu44i8JQo6apiZat-xxPg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Feb 2023 17:34:33 +0100
Message-ID: <CAG_fn=V3a-kLkjE252V4ncHWDR0YhMby7nd1P6RNQA4aPf+fRw@mail.gmail.com>
Subject: Re: next: x86_64: kunit test crashed and kernel panic
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        kunit-dev@googlegroups.com, lkft-triage@lists.linaro.org,
        regressions@lists.linux.dev, Marco Elver <elver@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
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

On Thu, Feb 16, 2023 at 1:13 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Following kernel panic noticed while running KUNIT testing on qemu-x86_64
> with KASAN enabled kernel.
>
> CONFIG_KASAN=y
> CONFIG_KUNIT=y
> CONFIG_KUNIT_ALL_TESTS=y
>

This is reproducible for me locally, taking a look...


> <4>[   38.796558]  ? kmalloc_memmove_negative_size+0xeb/0x1f0
> <4>[   38.797376]  ? __pfx_kmalloc_memmove_negative_size+0x10/0x10

Most certainly kmalloc_memmove_negative_size() is related.
Looks like we fail to intercept the call to memmove() in this test,
passing -2 to the actual __memmove().
