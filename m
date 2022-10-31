Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D298613D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJaSqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiJaSqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:46:11 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBF312610
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:46:11 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id e15so4074063qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wbqXepqBr/d+nZhEtmIQjbOd1ibdPmbwm+prkMG2b7c=;
        b=Jz8Ca0enSFe+lKvvMsvmPfLX3BuPDuiZYUhK6rGyjOoNtKx4TsFn5pBucUpsWlRlPv
         Tl77uj0agyiPA6Si89dXmpdFFbXsvj2QHwMSMvIsDWLRDizVEsZwjuiGQpGuyU5XPhmA
         Xu5z5a4RW69o6+/cYgBo5949XF+YCTw1ZCUR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbqXepqBr/d+nZhEtmIQjbOd1ibdPmbwm+prkMG2b7c=;
        b=A45GHOyVj/cPmKDQUkSLyuC5PQYJ1boD4M6HM+rRk0ujxkg7nRM6g+x6rLX0A91XoZ
         npbermv68gevar/HNUFWonD4eIp147Qw/ZOib6Cf5FS47X1UW/TBiMP9dycN4tfdEbIe
         4WDyw0nNaPTW8tbCZbJRsChufcrY8Lr0aHV+pjhTBOPHxAedgo5q6gmhfF0YRh0OC8I7
         8F6RvMrUXRfPVUgBsyVeDDqQU1p323Fh+LlBrx0O86CRNoIA5PjpxBXHJMX8CJL4FuGK
         RhzOzhwOwl4EVf0nBOGZELJCxbB9621u8/uWT70pOVjWfAxpNjgbImHCbhRtbJjW3xM8
         R65w==
X-Gm-Message-State: ACrzQf31u4IdpXwdyXIYKNUgl0SsesWwShHNwy8TpdFtlTzeAYlrdnEz
        i5WmpjC48ZcnKy7SMjHk1wcEWHfmkRATFg==
X-Google-Smtp-Source: AMsMyM6ervroAlXZNN2os7X+dpLh5gOr6YzG3arZRMuqWvTrFcL0PnyejRBanPtnYcfDNfM2PMYazg==
X-Received: by 2002:ac8:7f94:0:b0:39c:dd8f:59f3 with SMTP id z20-20020ac87f94000000b0039cdd8f59f3mr11767532qtj.46.1667241969977;
        Mon, 31 Oct 2022 11:46:09 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id n6-20020a05622a040600b003a51e6b6c95sm2826622qtx.14.2022.10.31.11.46.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 11:46:09 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-3691e040abaso116232787b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:46:09 -0700 (PDT)
X-Received: by 2002:a81:555:0:b0:36b:2d71:5861 with SMTP id
 82-20020a810555000000b0036b2d715861mr14455647ywf.340.1667241969081; Mon, 31
 Oct 2022 11:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221031175256.2813280-1-jannh@google.com> <Y2APCmYNjYOYLf8G@ZenIV>
In-Reply-To: <Y2APCmYNjYOYLf8G@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Oct 2022 11:45:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=eaYiBf5JMQRS53=y17N7gvZNhn+kYGZj=2R=8Pc_4Q@mail.gmail.com>
Message-ID: <CAHk-=wi=eaYiBf5JMQRS53=y17N7gvZNhn+kYGZj=2R=8Pc_4Q@mail.gmail.com>
Subject: Re: [PATCH v2] fs: use acquire ordering in __fget_light()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jann Horn <jannh@google.com>, Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:08 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Looks sane, but looking at the definition of atomic_read_acquire...  ouch.

The compiler should sort all that out and the mess shouldn't affect
any code generation.

But I also wouldn't mind somebody fixing things up, because I do agree
that checking whether 'atomic_t' is a native word size is kind of
pointless and probably just makes our build times unnecessarily
longer.

                Linus
