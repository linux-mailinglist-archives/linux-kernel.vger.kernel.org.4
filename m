Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1690268FCCF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjBICGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjBICGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:06:43 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A92825B90
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:06:42 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id b16so478304ljr.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 18:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0m8ClOBeLQBsFwYLC8fvKLy64TPmQMW0ZakgoVvvjGc=;
        b=CbyN7eeNvfvF8O6Ed8EfIbWYfhz0RmbKIfdZ7jY2FB3bljqDCNusmPKMAye5stuTxr
         ZuobiulOFVfKgXWBBBaykoOb2SzSeIMtwuvAtGqpZCYNb0e2d2ZvmmaVjE9S4jvKXyK3
         9LThIKPRA0lQnKxvqJWRT13+1QvUAtlheOgYfAAdH2WZxMpV+yofoQ8glvIs2fowncmy
         YLw+lg9ofOoFNNR86xfeFj1dxzPCP0a5+yTSxo0J++1HOc/7ZUFQtaloIZMmOYm+FWWi
         Vi9CNP3z25u7TQ1zfeinZwgz8evuZaCJj7fMefbw7WQpSfiZKLQ5SzR+Og8CPAkpYHrZ
         joMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0m8ClOBeLQBsFwYLC8fvKLy64TPmQMW0ZakgoVvvjGc=;
        b=WqNUxxSnVp1bop7g+J5K0/Abd5jOfgqcJja4cKekl1b1BD2gcnwxzIOoIoJXtkqlBj
         j9UJjqdqaOpe4kSyZNWse1Wr23YOYhwhRUy0PJDcvVxHBxeIPufz1kXQZgqyvdn54J8d
         GlzTwpn/OfMBdRzd0psySWTptbE19BHA2SMh9KPnPBYHGqJB4w5OXDLrFetiHrzFcwEq
         SnqKFuvqko2THBM7EAcLC2XvKanS0nYm9poPFf3saS+qp+dUaIEin1dKBCDXlLkfAeHS
         zSHBIL1UaAoD5H+nefqOG+pseDcFKkY0yjdFjSrsRigMxblLfPeJ5ZCqTsm3r8SM2cFW
         e6Nw==
X-Gm-Message-State: AO0yUKX8NYJA26f+hTiS7HQMlx9ueBFZw6QxXMy8QlTfSQmMXAbecJiN
        3/fBe0QhWJ3GQ/CWhafiAyiTaqnBKUUR3XfnrDs=
X-Google-Smtp-Source: AK7set/cX7oRU8Ph9dAePM9HoAKAnJRDkcfe5HXpDbEQvp9aX0nYdqzeiWQckb7xZIcd2O46Wrn7X9AvpDztrm+wecE=
X-Received: by 2002:a2e:90d3:0:b0:293:2fe9:6ab1 with SMTP id
 o19-20020a2e90d3000000b002932fe96ab1mr80868ljg.24.1675908400403; Wed, 08 Feb
 2023 18:06:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675851111.git.chenfeiyang@loongson.cn> <b9bbf73286238bb4657d855c9d50983aa17953e2.1675851111.git.chenfeiyang@loongson.cn>
 <e09b458a-32bf-46aa-b509-a383e34d4888@app.fastmail.com>
In-Reply-To: <e09b458a-32bf-46aa-b509-a383e34d4888@app.fastmail.com>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Thu, 9 Feb 2023 10:06:28 +0800
Message-ID: <CACWXhKmQGhSS6u7Jm=JuG7wiUBExNrmZMez50eWN=1u+voOuwA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] tools/nolibc: Add statx() and make stat() rely on
 statx() when available
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2023 at 18:39, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Feb 8, 2023, at 11:17, chris.chenfeiyang@gmail.com wrote:
> > From: Feiyang Chen <chenfeiyang@loongson.cn>
> >
> > loongarch and riscv32 only have statx(). arc, hexagon, nios2 and
> > openrisc have statx() and stat64() but not stat() or newstat().
> > Add statx() and make stat() rely on statx() to make them happy.
>
> > +#ifdef __NR_statx
> > +static __attribute__((unused))
> > +int sys_stat(const char *path, struct stat *buf)
> > +{
>
> The actual #ifdef check here does what I had suggested first, using
> statx() for all architectures, rather than what you describe in the
> changelog. I think you should keep the check from the first version,
> testing for __NR_stat/__NR_newfstatat and keep the changelog text
> here. Also please add something about the possibility of using statx()
> everywhere in the future.
>

Hi, Arnd,

OK, I will keep the check from the first version and mention that we
may use statx() everywhere.

Thanks,
Feiyang

>       Arnd
