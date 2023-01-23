Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3196789DF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjAWVrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjAWVrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:47:08 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEF3359A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:47:08 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 7so10065510pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bNWIhXG5Qs/cS/Kge9YI8j6hmkwjT8WYdLmFW/zVK4w=;
        b=I7B2lxMUcvQhT40X7gb4E9g8d/+2yvoIvQPsuzDkL4AA4cW1bqp6w343ARp6DQfbwT
         HB3U72WxKcK+giXl0xs5676UFA9XgjB12Odip1XalFk/e5vF+mKLP4nOGNRroaNvaIR8
         bQULc65y7O643vmUGcx+yKNipka0DSjwXaUKRpFQQFUEMxNB40VjNcSx4PKmzwB8DVEw
         1tEQqvBnLTQR0eatpxCtHczDL+04sl34/X+XQhYhjCu+HOTafB2jcAMv4xtZ0SeBDdrK
         al/LEtk4+dRBBpVsUDSvLPYOYFIGdYO2xUdpySykEuAp4oqMQ8oqJUiC37vEOaowR6iR
         Lr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNWIhXG5Qs/cS/Kge9YI8j6hmkwjT8WYdLmFW/zVK4w=;
        b=zx2li4hNCuuZMQ4BZNCfrV1Pf0dEmnIdOcB++7H7YjIhH9WOmhLzjUPKVHbddWSXWM
         DlzRWZpW7GWEi+S2sXvoJMwTGADq0s+u7VY+0gFf+mai+yU/BqphWKqmbfC1cvCMfrT3
         fGXJSUAiNJQ/uEFEz86KRD9IkVM3GCN+GGEbMey9REWQLaaUaB74EHj+D4MuBCuAYJ1M
         PX1K65PlFM1bA4TsMaaWC5aGAU0PH/7adMPne6Q7oGz+r7TMGMBYwTbcK67OcheGPbCA
         jAoVnRcH8AkyLGq5D1B/67myDhp92TzGIuTMxnMYtS8p1ZQ0FCVfzbFOfSm1y/pRhAX4
         f1Rg==
X-Gm-Message-State: AFqh2kpOC94UtLddbNYppNQZYq8BrjJ2Ju7M+oehui1AgaQfA4Qjb38Z
        PaLADjsr5sYg9UfT3WUdj9FD0RtOjgopFGLgjYIwS4Oo4Eg=
X-Google-Smtp-Source: AMrXdXvCLUy1D+cqvlpSTKtU8PocxDNbqF6QFj2+8HllzwfzDCIJYpNZr9tmlhT2ybfJ9Z/22mQD7n4/o1qCikRXNcE=
X-Received: by 2002:a05:6a00:3496:b0:576:f9e2:a968 with SMTP id
 cp22-20020a056a00349600b00576f9e2a968mr3320171pfb.84.1674510427720; Mon, 23
 Jan 2023 13:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20230118093832.1945-1-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20230118093832.1945-1-Kuan-Ying.Lee@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 23 Jan 2023 22:46:56 +0100
Message-ID: <CA+fCnZcS-p5nCALg4-96cp+sXNZSvN_u=L+=xK+zaH2rigJMKw@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: infer the requested size by scanning shadow memory
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chinwen.chang@mediatek.com, qun-wei.lin@mediatek.com,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

On Wed, Jan 18, 2023 at 10:39 AM Kuan-Ying Lee
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> We scan the shadow memory to infer the requested size instead of
> printing cache->object_size directly.
>
> This patch will fix the confusing kasan slab-out-of-bounds
> report like below. [1]
> Report shows "cache kmalloc-192 of size 192", but user
> actually kmalloc(184).
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in _find_next_bit+0x143/0x160 lib/find_bit.c:109
> Read of size 8 at addr ffff8880175766b8 by task kworker/1:1/26
> ...
> The buggy address belongs to the object at ffff888017576600
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 184 bytes inside of
>  192-byte region [ffff888017576600, ffff8880175766c0)
> ...
> Memory state around the buggy address:
>  ffff888017576580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff888017576600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff888017576680: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
>                                         ^
>  ffff888017576700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888017576780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
>
> After this patch, slab-out-of-bounds report will show as below.
> ==================================================================
> ...
> The buggy address belongs to the object at ffff888017576600
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 0 bytes right of
>  allocated 184-byte region [ffff888017576600, ffff8880175766b8)
> ...
> ==================================================================
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216457 [1]
>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> ---
> V1 -> V2:
>  - Implement getting allocated size of object for tag-based kasan.
>  - Refine the kasan report.
>  - Check if it is slab-out-of-bounds report type.
>  - Thanks for Andrey and Dmitry suggestion.

Hi Kuan-Ying,

I came up with a few more things to fix while testing your patch and
decided to address them myself. Please check the v3 here:

https://github.com/xairy/linux/commit/012a584a9f11ba08a6051b075f7fd0a0eb54c719

The significant changes are to print "freed" for a slab-use-after-free
and only print the region state for the Generic mode (printing it for
Tag-Based modes doesn't work properly atm, see the comment in the
code). The rest is clean-ups and a few added comments. See the full
list of changes in the commit message.

Please check whether this v3 looks good to you, and then feel free to submit it.

Thank you!
