Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED83574428F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjF3SzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjF3Sy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:54:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E073C18
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:54:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-991f956fb5aso243618966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688151294; x=1690743294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TNDdxm2uRBanyTPDPNPrPhakFGMtbZ0lo57cu0b88BM=;
        b=TNggm6bHMP4atZhQ+ioXsL1qmmri8OLjdoLgvmJJan5q9l7H02/6zQHP5r7nYWVkuV
         KAIbQTUZPRF9NtiJn1eW3+h0DLyvJFKevKHx76R6dp8pzfxz4QKMF+sbI04NXRZHDhGc
         7bONuGmijwn7chkj6o2ufyCw2HrCk+gA+PzG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688151294; x=1690743294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNDdxm2uRBanyTPDPNPrPhakFGMtbZ0lo57cu0b88BM=;
        b=ePocjnK6Hayz8YQYN33EsmXZSnOnXDD9UymWmhjxbNfKg9dTrktZPbZ8zGCrB1xPOL
         D/8dgR3ZdzltPesFL9JoLoU/iLp+GR7jVCK/SOKcoxTDh13zZZdjhzyKxwVxSEa8hxBN
         b1HltgoO1mt4sqlAsqs2sn3ihS0qKd2H9+xPgveTwx80U4ULbFOWY6vfzm8IkKCZJ9is
         Vr/dlfDyfxZ5tVPKSVlSDZegaPo6BV/ujxft///Wbuxff/dAq2p/Wx7Dr1S5Z94vhsxu
         RilxOAiYOrVBzvfBqEeTgEXrSwnKpOXolTK6TRhLcENGbN5RfZxGBlxjPaBM9DQzsfns
         LQZw==
X-Gm-Message-State: ABy/qLamEXYuo2MJuJjsNHjMhlGpNxIYJI291LmBOEiueUPac69VvArz
        9YEZveoO4qMnMqRR2ZVG4lmU0k6dxlIXs3PEP9GrcLvQ
X-Google-Smtp-Source: APBJJlEICROppBDPYSVm0KZ3QWl+K9fJ6r8nTemk6KB5efh6cCbrKlAtRFXxZUbtUD9GyWPVKbqmlw==
X-Received: by 2002:a17:906:f9d7:b0:988:9621:d855 with SMTP id lj23-20020a170906f9d700b009889621d855mr2257005ejb.61.1688151294538;
        Fri, 30 Jun 2023 11:54:54 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090617c400b0099297c99314sm2794276eje.113.2023.06.30.11.54.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 11:54:54 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51d810010deso2223437a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:54:53 -0700 (PDT)
X-Received: by 2002:a50:ee05:0:b0:51d:d4dd:a0e1 with SMTP id
 g5-20020a50ee05000000b0051dd4dda0e1mr1971858eds.15.1688151293677; Fri, 30 Jun
 2023 11:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgqQCAtA4cVev0g3A6RCD16s1p-_TAUeVkGE0_yS2ehyA@mail.gmail.com>
 <mhng-784b868b-bc5c-44b4-ae82-3929f67ac5dc@palmer-ri-x1c9a>
In-Reply-To: <mhng-784b868b-bc5c-44b4-ae82-3929f67ac5dc@palmer-ri-x1c9a>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jun 2023 11:54:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzdoWP5TRA=p=monXZmzo1Wd-gH8GRpcEUKh74nmDgZQ@mail.gmail.com>
Message-ID: <CAHk-=whzdoWP5TRA=p=monXZmzo1Wd-gH8GRpcEUKh74nmDgZQ@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 6.5 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 at 11:47, Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> Awesome, thanks.  I poke around the git merge resolution stuff, but I'm
> never 100% sure so I usually just look at the resulting output files and
> then just paste in whatever git says as a heads up ;)

Yup. It's one reason I really prefer to do merges myself - I just have
done *so* many of them over the years (and did them long before git
made them much easier) that I can usually do them in my sleep.

Which obviously doesn't mean I then necessarily always get them right,
but I tend to have a higher success rate just because I'm so used to
them.

Regardless, I like seeing the heads-up for merge conflicts in the pull
requests, if for no other reason than the fact that it sets my
expectations for what I'm going to see.

For example, sometimes it means that I decide I'll just go make a cup
of coffee before tackling the merge at all... Not for something this
trivial, but you get the idea.

                Linus
