Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18B660852
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbjAFUcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjAFUcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:32:17 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E546C6CFF6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 12:32:16 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso4372050wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 12:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ3zXZz2LljiSasIZAvJ1UKbf094Oi8/35IAFVquDVE=;
        b=Mio3w2AFWFcNkDQxBgxZVkuRuR+mBVkkDVY5G0M2MsbOuC1AekXLH3NQDs0w8salZ1
         QlPw8nvJnNkRI/Xj0dSmnBgMjYYZ6I7enj+4jB7tSjgP2Vaj88+vjGqqxaDqAG67wBAF
         E4CNouIkZiPMhhyHTTVNBmUrBl4g0ae2UlWjRJSgTAYMLww2M5PRfZh/PMLBG/uchlYa
         5sa2fd5s81fuKL+sRnjWOj+1+z2S0fO0jM1I/gJN4hwkYa2vrULboqpwgGypaD3UsMVW
         9U/GbDTPp5UWG+zY3AOWu3a5BsrqCPG5l79E53siTJJGBKF2BhsR1BBFKGplJrFD0Byi
         l5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ3zXZz2LljiSasIZAvJ1UKbf094Oi8/35IAFVquDVE=;
        b=5pvd+ulPOzOrb8o0kLJHVKTvEFBFGqFHKIhbhfSXUK8Nn75lpUfG/d7lZ0Qzd5IFro
         Au8CT28wNQXQE92Ln5pdx22o+ZQQ6Pzn6ahrjRs36yuWwRzv2F4bJ0y9izIW13G0J10D
         YGjmg48GKypd5NK+o8Mzn15d58ijr/75730ZTLuVWmGod1rG65vYiVwp2Cksum9AtPnU
         yXf7fWLynaHSWIlI0auwUA+371XEbWdyTSzEK3tGAdLAtWGmGKq+wQPIUYbzfbbapwjc
         BjJ6Ta7PLjtVsp04FRf+/HlO2Kibow+ZxVnXgmpwc+QNiFldN9wzhfu9yV8Tj0cbNQ+L
         1nSg==
X-Gm-Message-State: AFqh2kpCjlvOh2Jyr3SuiMT0uN7bOPPpUkN23dG6G9F2eKi7laUBnctI
        9aoGeKtde3lfgKe+ZHKyfvhulJkYFCyoymHnrQw=
X-Google-Smtp-Source: AMrXdXuvSytCE5NTYBw8zzOa5GKn0EiFMnFtgL3SpAZA9l/GC4JaDIZTJ9gMWJPOuVxKJS4QiErtSr9nvAXyx5E5LPA=
X-Received: by 2002:a05:600c:3503:b0:3cf:8952:2fd2 with SMTP id
 h3-20020a05600c350300b003cf89522fd2mr3614514wmq.9.1673037135319; Fri, 06 Jan
 2023 12:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20221128191616.1261026-1-nphamcs@gmail.com> <20230103045730.2ctv3n2ckzzmdzdx@snowball.t-8ch.de>
In-Reply-To: <20230103045730.2ctv3n2ckzzmdzdx@snowball.t-8ch.de>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 6 Jan 2023 12:32:04 -0800
Message-ID: <CAKEwX=MPxEsCJ8V8vNvMgXJ66Pq7qxnOX6S1sf97dc-oqaJfWQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Implement writeback for zsmalloc
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, linux@weissschuh.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 2, 2023 at 8:57 PM Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> wrot=
e:
>
> Hi,
>
> On Mon, Nov 28, 2022 at 11:16:09AM -0800, Nhat Pham wrote:
> > Unlike other zswap's allocators such as zbud or z3fold, zsmalloc
> > currently lacks the writeback mechanism. This means that when the zswap
> > pool is full, it will simply reject further allocations, and the pages
> > will be written directly to swap.
> >
> > This series of patches implements writeback for zsmalloc. When the zswa=
p
> > pool becomes full, zsmalloc will attempt to evict all the compressed
> > objects in the least-recently used zspages.
>
> Then this part of Documentation/admin-guide/mm/zswap.rst should probably
> also be updated at some point:
>
>     However, zsmalloc does not implement compressed page eviction, so
>     once zswap fills it cannot evict the oldest page, it can only reject
>     new pages.
>
> Thomas

Thanks for pointing this out, Thomas! I'll send a patch to update this.
