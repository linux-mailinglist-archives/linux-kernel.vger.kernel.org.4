Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81E360D3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiJYSjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiJYSiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:38:50 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95919F5CF4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:38:49 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w29so1087095qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d3/ajG1if7U9lpHeEq0VQg2LAejly/YXG+RD6rpH05k=;
        b=Leyl1TyaJfKEGwSWe9jhSyTnBKyurqEHumz1kQpomWDtTphqP9qaS6rcYBtD+B7Esl
         XokWQSvOMRIjAAPiDpReUHUYc/0fN+7TBjEa12IKkRexMhY/aHvpJShL4GofYZ8TK0jv
         Wey7dg1KDwhBw/zyRrMHZZFO2k43zNqzRn5R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3/ajG1if7U9lpHeEq0VQg2LAejly/YXG+RD6rpH05k=;
        b=kFFHA6jyxmtHTL/laFzVA1oKjtHZrCTOm58cH1ndx5vh/+C7+uSZsbBUUzprYMi6gB
         i71/uQ0FuQL91+EQDifcCdBO+Jv67OR/H+08kietLX9MM5aOHOv58t9fRP/Ky2qb5Nza
         6oylFol+0l27Q+B8wVCNIBT5Bab8HVr1+4QHN+0hQaRFR1A0Xkt92HrIkTF973skDQQE
         sV1TC4nCtB5pj388vx7xOvB7fURZEsnApT/aKTlJj+AT/BHiRN5nNbuSY6TRs64Ce016
         jqDKVWD4zNj4rNJx8dGEibPoxFDIJXsT2md+MO1SNpZJADQVGa6mkZmgv5pnD81DmXKe
         JGjA==
X-Gm-Message-State: ACrzQf3ZulUCHsAvnAkcKB75SUY1pbMZOL0HRNq8SFyEjULovmw3kL61
        KBMQpTU7I3hQL1vj8vksqonLCgK0I0LYeg==
X-Google-Smtp-Source: AMsMyM7lH39yDj5y3newqxiub5Wiof5vI+0xnYf2gcaCBQTY16pifSPl7vRG6ZGmA0ucBScdLisS/w==
X-Received: by 2002:ac8:5ac7:0:b0:39c:c198:e6fd with SMTP id d7-20020ac85ac7000000b0039cc198e6fdmr33548773qtd.220.1666723128458;
        Tue, 25 Oct 2022 11:38:48 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id o5-20020ac86985000000b0035cd6a4ba3csm1960599qtq.39.2022.10.25.11.38.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 11:38:47 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 185so5258722ybc.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:38:47 -0700 (PDT)
X-Received: by 2002:a25:5389:0:b0:6bc:f12c:5d36 with SMTP id
 h131-20020a255389000000b006bcf12c5d36mr34747684ybb.184.1666723127168; Tue, 25
 Oct 2022 11:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221020032024.1804535-1-yury.norov@gmail.com>
 <20221020032024.1804535-2-yury.norov@gmail.com> <CAHk-=whij5pwOkG5HhMRzrvc4BTzhgj9h=wHo=tMVGasKE+p1w@mail.gmail.com>
 <Y1gY18JGz4zKw+gW@yury-laptop> <Y1gqTM19oLeN59Kl@shell.armlinux.org.uk>
In-Reply-To: <Y1gqTM19oLeN59Kl@shell.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Oct 2022 11:38:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wht2pdAoG97kbFqCyOzi1C714x-BY92pvtMcmtGCfUasw@mail.gmail.com>
Message-ID: <CAHk-=wht2pdAoG97kbFqCyOzi1C714x-BY92pvtMcmtGCfUasw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bitmap: add sanity check function for find_bit()
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:26 AM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> However, we still support ARMv5 and ARMv4, both of which _trap_ every
> unaligned access, which will make a findbit call with an unaligned
> pointer using word loads painfully expensive. This is the main reason
> we haven't used word loads in the findbit ops.

The findbit ops really shouldn't be a special case, and bitmaps can
never be unaligned.

Just look at what 'test_bit()' does: the non-constant non-instrumented
version ends up as generic_test_bit(), which uses a "const volatile
unsigned long *" access to do the bitmap load.

So there is absolutely no way that bitmaps can ever be unaligned,
because that would trap.

And test_bit() is a lot more fundamental than one of the "find bits" functions.

Have we had bugs in this area before? Sure. People have used "unsigned
int" for flags and mised the bitmap ops on it, and it has worked on
x86.

But then it fails *miserably* on big-endian machines and on machines
that require more alignment (and even on x86 we have KASAN failures
etc these days and obviously without casts it will warn), so we've
hopefully fixed all those cases up long long ago.

So I really think it's pointless to worry about alignment for
"find_bit()" and friends, when much more fundamental bitop functions
don't worry about it.

               Linus
