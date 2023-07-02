Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756A0745300
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 00:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGBWp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 18:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjGBWp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 18:45:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DEE1BD
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 15:45:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f8735ac3e3so5857401e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 15:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688337953; x=1690929953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rbSGoMaDXuLTUnz0WGxSI7CF/z5suPv717y+50H5ixI=;
        b=StspcepUYcEgcCUtJ4IwnwdxoNsUWnZMTNCThy93R7sGFKyZ/R58wVWcf73ERAPggm
         z9tW8saRzj3UyHj45uq+vqksU4sOENZyv4JHdHWP8FVL/Cfxl769B+p1DdnRQnXR0KNU
         WuwbUyv5Xofh8zkMERcfkj94nWUrYCsQkYsFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688337953; x=1690929953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbSGoMaDXuLTUnz0WGxSI7CF/z5suPv717y+50H5ixI=;
        b=Az9CAlAVkeqoIKJNNzWdYqXDw5G3b67QNGKg81I0LwjYXoYA+zBf1YB5AcQIEEitP2
         ctmygpOA5NfOerR/EZI+Kmrr1EmB0HI1ldYo/+QGUIbv5+WFT0pRrEyPeS+zOeLvemSY
         rjyjM4Hw59KiBXkl3ag55do99F5ZdScWUP4EPKL4mmD3S/hyx0YpSswNK+gk5mJOmXZD
         YYbPDm5+IhO1joGzSk2nKIM/F+ZyxSNIpNTS7Zg32+eiTrlq5wha5/ajlc0XALYZLVHW
         xn6czLcbdxahFM0H+27fTT7l/EzmqFP0m+Fd65e+sCEUFlE7xujXJ0E6tBrgbwfLY72O
         yn6w==
X-Gm-Message-State: ABy/qLaeSkmgyMzQDfImasyxFMWXZ5WqdMMQR6FdOJtDb4JxTSCtFWDX
        C8QswpwTC216AGbaSJaYejzpDp2RiGGQ6aoSQgovTUrn
X-Google-Smtp-Source: APBJJlGiDmRaqy96e+pP5niHFTjQ/eEKPnoLvs3payPPygrSIK4JLoZx4CVKTEYaOf/L7cJtJ3URbQ==
X-Received: by 2002:a05:6512:3b9c:b0:4f8:5960:49a9 with SMTP id g28-20020a0565123b9c00b004f8596049a9mr6962238lfv.23.1688337953542;
        Sun, 02 Jul 2023 15:45:53 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id j17-20020ac25511000000b004fb964d48e6sm2334644lfk.95.2023.07.02.15.45.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 15:45:52 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b69e6cce7dso57496531fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 15:45:51 -0700 (PDT)
X-Received: by 2002:a2e:7d15:0:b0:2b6:9f59:7b3c with SMTP id
 y21-20020a2e7d15000000b002b69f597b3cmr5360404ljc.14.1688337951675; Sun, 02
 Jul 2023 15:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <2023063001-overlying-browse-de1a@gregkh> <0b2aefa4-7407-4936-6604-dedfb1614483@gmx.de>
 <5fd98a09-4792-1433-752d-029ae3545168@gmx.de>
In-Reply-To: <5fd98a09-4792-1433-752d-029ae3545168@gmx.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Jul 2023 15:45:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHs1cL2Fb90NXVhtQsMuu+OLHB4rSDsPVe0ALmbvZXZQ@mail.gmail.com>
Message-ID: <CAHk-=wiHs1cL2Fb90NXVhtQsMuu+OLHB4rSDsPVe0ALmbvZXZQ@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review - hppa argument list too long
To:     Helge Deller <deller@gmx.de>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John David Anglin <dave.anglin@bell.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jul 2023 at 14:33, Helge Deller <deller@gmx.de> wrote:
>
> Actually, your changes seems to trigger...:
>
> root@debian:~# /usr/bin/ls /usr/bin/*
> -bash: /usr/bin/ls: Argument list too long

So this only happens with _fairly_ long argument lists, right? Maybe
your config has a 64kB page size, and normal programs never expand
beyond a single page?

I bet it is because of f313c51d26aa ("execve: expand new process stack
manually ahead of time"), but I don't see exactly why.

But pa-risc is the only architecture with CONFIG_STACK_GROWSUP, and
while I really thought that commit should do the exact same thing as
the old

  #ifdef CONFIG_STACK_GROWSUP

special case, I must clearly have been wrong.

Would you mind just verifying that yes, that commit on mainline is
broken for you, and the previous one works?

               Linus
