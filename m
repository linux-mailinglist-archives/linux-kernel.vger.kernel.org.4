Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC966606EA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjAFTHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjAFTHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:07:52 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5785F74
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 11:07:51 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-4bf16baa865so34103707b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 11:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5A0t1b8GCaKZoioAehodSZpoVJBMnzQHzgwS+wcGljY=;
        b=c6aSqs9RAgnpQbfs24Hy+BdkBfwEBqdowlV8Kgcqy1p1Xzv+pWEcDyAAgexmWac3OK
         ao8J+ggBkFsQ69q23eXpTlhanR8ko+mxGAdcEnDwW9RaPC3f27lyqx4gXOOadbQrjqfS
         PuS+cGVk79ubhoVzMoSLeLT+8pUy2Ge5R+a8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5A0t1b8GCaKZoioAehodSZpoVJBMnzQHzgwS+wcGljY=;
        b=2r2Ae4hPbz1po//z4qM5fVwRmXW7Fsg3NbIjxcZLTMRIxBknwzwppiVjH/o920rj5k
         d+dOktcklQGoErJKxg5cnSM10KlHmgVbOyWMAtI41LqFN8IoODIc8j919SLcINb18YrF
         4Un0c4NEYeRGNZ2r2AoUganXDeB2/zfhAdFQZdGoNCn2jDAntYeyhg1RsVxcb043mKKd
         4uInp0CnMvCWT7Rb7q71FKJLTSGnSyMydnY7iWbekghk0w7wzGba1swKcVwMkorx+O7J
         7yIg8q736V69m3TQ6JfsXXEnkbpcpPhIpKrLW+PyyhPcv2tw2taXK0VUwGmGdLzf0yp2
         5tkw==
X-Gm-Message-State: AFqh2kpaRt12jlbDhcQfe6FNGihJBQWlrJVbwqNvCCcpPt87cggV/D8O
        d4O2NrSllRxr2J4/RNH5iiejQxaGCBp/RysC
X-Google-Smtp-Source: AMrXdXvDbZvb6WAvXVyCAX0zr3wK3WVkbZoQ8CJZgBSwAD0y7taJTYZpZLvMNNdPwkuWIkWIVwBizA==
X-Received: by 2002:a81:fe0a:0:b0:48b:158e:868 with SMTP id j10-20020a81fe0a000000b0048b158e0868mr28628010ywn.48.1673032070482;
        Fri, 06 Jan 2023 11:07:50 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a408800b006b5cc25535fsm963762qko.99.2023.01.06.11.07.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 11:07:50 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id p17so1586651qvn.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 11:07:49 -0800 (PST)
X-Received: by 2002:a05:6214:1185:b0:4c6:608c:6b2c with SMTP id
 t5-20020a056214118500b004c6608c6b2cmr2620694qvv.130.1673032069668; Fri, 06
 Jan 2023 11:07:49 -0800 (PST)
MIME-Version: 1.0
References: <1f4d159e-5382-3c75-bd5e-42337ecd8c28@omp.ru> <Y7hDGoCbWG2ZYdlV@alley>
In-Reply-To: <Y7hDGoCbWG2ZYdlV@alley>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Jan 2023 11:07:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgCTaDeS9gPf=57rBMCOw6MGmzCHywX=en05=pZaCnjuw@mail.gmail.com>
Message-ID: <CAHk-=wgCTaDeS9gPf=57rBMCOw6MGmzCHywX=en05=pZaCnjuw@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: fix possible NULL pointer deref in vsnprintf()
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Jan 6, 2023 at 7:49 AM Petr Mladek <pmladek@suse.com> wrote:
>
> Adding Kees, Linus, and linux-hardening into Cc. It seems that
> __vsnprintf_internal() does not do this in glibc. I wonder if
> there is a good reason for it.

I do not think that patch is valid.

And I don't like Steven Rostedt's suggestion either.

I think that code *should* take a NULL pointer dereference, exactly
the same way "strlen()" would do if you pass it a NULL pointer and
claim there is room there.

No silly checks for invalid cases.

There's any number of invalid things you can do in the kernel, and we
don't check for those either.

I don't particularly like the "pass NULL to sprintf()" thing at all,
but *if* somebody does, they had better just pass a zero size too.

And doing

        git grep 'sn*printf(NULL'

seems to show that all current users do exactly that.

If somebody wants to check for this, make it a coccinelle script or
something. Not a runtime check for invalid use cases.

               Linus
