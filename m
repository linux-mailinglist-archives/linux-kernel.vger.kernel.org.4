Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133FD6235F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiKIVjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKIVjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:39:36 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA59529342
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:39:34 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id o8so165105qvw.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vsuxWWcLBTsKK8/tKqd6R9Q9SBeixSSI7f1tIJOfP3Q=;
        b=W7nJiSHStUafbm8wEUI0XvsruUyQ63k69u3kaAuU2Ej1IR8KHrcOVBNI7CsCTNA5kb
         DKI0z6tPEdE4UyxnX6xKBHkCUiWsmqSlQANTGRxoNyLcrGx0+Sr7311DiwsIv/wfYqse
         OCvh3V2m7rIxAC6P1iPynkfNees+Tz2IP3DKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsuxWWcLBTsKK8/tKqd6R9Q9SBeixSSI7f1tIJOfP3Q=;
        b=D8Y5IIwE/JEn6rW7W6QRYzrqgsS0cpbvuG0XsA7rPHAaU2E/3vYKdqFSl2et6/ZMgl
         DTVzgCd2w3MHiOIHEZ7Qd5NnZ/u8srYkRTMm9rEH4Qhk9iDsZ3RvtpcT5ztrAxI/RguB
         XhWZuN9FeUYsOnDnNXGLWY4zhl+SyKo8C4pULe+Ml4etXDU+PdJYJBcP51HUDplI9R1v
         ZNMOf46QtT6ZKRwI83ALZDUpUL4R+Gjlposko5kQ8RFOhlpPeTc6ruJ+JVnZJspOPndR
         RY/YdDd8glMzqKempiklNb8YyL0byGsYjI4Xt5ODDg5n6ckWoEhzjaDvm4n7qa83g5NT
         5vxQ==
X-Gm-Message-State: ACrzQf1sBNVYnL8uRGkxwh/AaTG1wOOptanoI/KHpMECFrvQd6uoLzAf
        p/cf/AtKztfPyagdcfuh5vsd5YxGUqTa6g==
X-Google-Smtp-Source: AMsMyM5g/rASehT79m84tbL3ndksLW/W9bLgICoecjHphJZbxhdVoReAwa1RZWsFosJNPZ+mfUisDg==
X-Received: by 2002:ad4:5e87:0:b0:4bc:b03:e37 with SMTP id jl7-20020ad45e87000000b004bc0b030e37mr47354834qvb.127.1668029973574;
        Wed, 09 Nov 2022 13:39:33 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id bk4-20020a05620a1a0400b006eea461177csm11901549qkb.29.2022.11.09.13.39.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 13:39:30 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-36cbcda2157so174448257b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:39:29 -0800 (PST)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr60778035ywr.58.1668029968753; Wed, 09
 Nov 2022 13:39:28 -0800 (PST)
MIME-Version: 1.0
References: <K5M3LR.3O50LSSSY5L3@crapouillou.net>
In-Reply-To: <K5M3LR.3O50LSSSY5L3@crapouillou.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Nov 2022 13:39:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjBqwJk9RgfoBuM00T49M7uQiLnOvLST7L6v5rhS7fkDA@mail.gmail.com>
Message-ID: <CAHk-=wjBqwJk9RgfoBuM00T49M7uQiLnOvLST7L6v5rhS7fkDA@mail.gmail.com>
Subject: Re: Deprecating and removing SLOB
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     vbabka@suse.cz, 42.hyeyoo@gmail.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, cl@linux.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, rientjes@google.com, rkovhaev@gmail.com,
        roman.gushchin@linux.dev, willy@infradead.org
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

On Wed, Nov 9, 2022 at 12:56 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> It worked fine on some boards, but on others it had about a 25% chance
> of booting, and 75% chance of hanging at boot. I tried printk-debugging
> it, and was coming to the conclusion that it's memory corruption of
> some sort.
>
> Then I switched to SLUB and all the problems are gone. Same with SLAB.
>
> So while I can't say for sure that SLOB is broken (it might be
> triggering a bug somewhere else), I am highly suspicious that it is.

I have this distinct memory of having seen other reports like this,
but my google-fu is not strong enough to back that up.

There definitely has been recurring noise about SLOB issues. There's a
reason people have wanted to remove it for years and years.

             Linus
