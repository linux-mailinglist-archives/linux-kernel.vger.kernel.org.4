Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6041A6C22B1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjCTUbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCTUa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:30:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504CBF776
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:30:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ek18so51766069edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679344235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2+Cqt9Dw1TliJ9hvyF98sgSSViJR0lNIaWyRtxAIhg=;
        b=D1+1UYOHb/z/WfJlZyxQvGrDf3hygcuQOhllbGNlRq8aGEWlDJEZIdV9+srQA0jKwc
         k+mFGcoCkUhU6EHiea6hB+UqH7Ky33fniRXlqKvv88lfxDp0/+dCxSQ2PQ5PtRCMyf46
         HqwxpAx+1nPVskCqmBhzH2lldd0mBkF9t6Jfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2+Cqt9Dw1TliJ9hvyF98sgSSViJR0lNIaWyRtxAIhg=;
        b=vln6Cq15xQfKsZSbXo5q9HT9LGmGxEwPcn93/jQAMXlDbp3XTlEKSjasdF9x/Aor7x
         HdTtLRO/Td0yZjELo2r1YuBQQKs6R9YUHeoPMNz/KhdbV2w2HD0hOnwGRINo8qde5+Cb
         y41aI8KUIxK80cTUIiO3zejdXW1r2RIggFZ4H2McrcCvTJy00G7RmBmuIEye7F7a0iJ9
         Amakd2LiahKl/4XwL+nSD1E/lkM6DU+lv5dTsMFiNQJVYV1GbSvOq6YN78ViusaSj6/M
         i8frQTdBH6uRKzvnC/kfHYxVafhgJ3v/i1WDD0uT8+IjAaeWcmTxM8reOBSjg7jqucXd
         EHTw==
X-Gm-Message-State: AO0yUKUCGm5JIGhRmbzJeq5E4vGNW2XjJ0I6Ls6iel1VjVvWhW/Rp8rf
        RlqE4oV8aK2mKKSpg687A/nUuplp5aDj9xlTzXT3ork4
X-Google-Smtp-Source: AK7set+6C1WGspesegyxSvwVsl9XICGKJF3wPXMkBOLZWIJrQD3pqzOHSNIq3OJgaY49VUOeeOvywA==
X-Received: by 2002:a17:906:4953:b0:877:a9d2:e5e9 with SMTP id f19-20020a170906495300b00877a9d2e5e9mr426064ejt.42.1679344234806;
        Mon, 20 Mar 2023 13:30:34 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id x11-20020a1709064a8b00b009342fe44911sm1926874eju.123.2023.03.20.13.30.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 13:30:34 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id i5so4844734eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:30:34 -0700 (PDT)
X-Received: by 2002:a17:907:375:b0:933:1967:a984 with SMTP id
 rs21-20020a170907037500b009331967a984mr145268ejb.15.1679344234061; Mon, 20
 Mar 2023 13:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
 <20230320180501.GA598084@dev-arch.thelio-3990X> <CAHk-=wgSqpdkeJBb92M37JNTdRQJRnRUApraHKE8uGHTqQuu2Q@mail.gmail.com>
 <4adbed5a-6f73-42ac-b7be-e12c764ae808@roeck-us.net>
In-Reply-To: <4adbed5a-6f73-42ac-b7be-e12c764ae808@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Mar 2023 13:30:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyJREUR1WgfFmie5XVJnBLr1VPVbSibh1+Cq57Bh4Tag@mail.gmail.com>
Message-ID: <CAHk-=wgyJREUR1WgfFmie5XVJnBLr1VPVbSibh1+Cq57Bh4Tag@mail.gmail.com>
Subject: Re: Linux 6.3-rc3
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
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

On Mon, Mar 20, 2023 at 1:05=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> I have noticed that gcc doesn't always warn about uninitialized variables
> in most architectures.

Yeah, I'm getting the feeling that when the gcc people were trying to
make -Wmaybe-uninitialized work better (when moving it into "-Wall"),
they ended up moving a lot of "clearly uninitialized" cases into it.

So then because we disable the "maybe" case (with
-Wno-maybe-uninitialized) because it had too many random false
positives, we end up not seeing the obvious cases either.

              Linus
