Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173AB5EC6FE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiI0O4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbiI0Ozr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:55:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F9955086
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:54:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2470161A08
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C85C433C1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:54:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IIBQtAmt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664290449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBuwBxhVvQ1c4kDwIA1R6SO4moxBgAxyGrhjZgxk65I=;
        b=IIBQtAmtwYy1lB5S8uK7uJXP0fgYU2FuEi80CQVltXmhiDlWkg0aW6akCXILz7MI9vV6Ge
        1Wx5bSHKu4caahEaA2PYPDza9FbgeEL1k17uxY/ApdEzWosRL0Hu6iIBkJPSIJBLABkqlE
        GT3P2h0/w+vrCCdGJXSKoHySLMt8T4o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ceaa0caa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 27 Sep 2022 14:54:08 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id s192so5050720vkb.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:54:08 -0700 (PDT)
X-Gm-Message-State: ACrzQf1q3nW9zsFDtBR++W8adUxQIjM5WGW0t9d2SNYEKUA4J2QkWNlE
        dqpvwRxn6pQBzEetiTAPM0jb/9kmD0H4C4zMwdM=
X-Google-Smtp-Source: AMsMyM4u0qIidvOAi80LKUBCNPooafVXeU1+xC4Bm8bguCWoVLmIYT7H13Hb0vZRo2WrwaZBhyvrs9gvbwYJV33SBpE=
X-Received: by 2002:a1f:6ecd:0:b0:39e:b8bb:b16d with SMTP id
 j196-20020a1f6ecd000000b0039eb8bbb16dmr11829444vkc.37.1664290447843; Tue, 27
 Sep 2022 07:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220927094039.1563219-1-Jason@zx2c4.com> <20220927095354.1564465-1-Jason@zx2c4.com>
 <202209270724.04D0A68@keescook>
In-Reply-To: <202209270724.04D0A68@keescook>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 27 Sep 2022 16:53:56 +0200
X-Gmail-Original-Message-ID: <CAHmME9ptjydKVKBnYP6BaEnuJVxxzUD9AgmqVsHA1mEMV44cDw@mail.gmail.com>
Message-ID: <CAHmME9ptjydKVKBnYP6BaEnuJVxxzUD9AgmqVsHA1mEMV44cDw@mail.gmail.com>
Subject: Re: [PATCH v2] utsname: contribute changes to RNG
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 4:25 PM Kees Cook <keescook@chromium.org>
wrote:> > +             add_device_randomness(tmp_data,
sizeof(tmp_data));
>
> Does this matter that we're dumping the same same trailing bytes into
> the RNG? (i.e. only min(lenp, table->maxlen) has changed.)
>
> If that's okay (and maybe a comment should be added):
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

It doesn't matter. You can call add_device_randomness() as often as
you want on whatever data you want, and it is never bad.

I mentioned in my Linux Plumbers talk that I'd like to see various
subsystems add whatever they can find, provided it's not a performance
bottleneck. add_device_randomness() is good for things that /could/ be
random, but might not be. Right after my talk, somebody posted this,
which I was happy to see:
https://lore.kernel.org/all/20220915004117.1562703-2-bryan.odonoghue@linaro.org/

There's also this commit from a few months ago that I was quite happy
about: https://lore.kernel.org/all/20220425205442.1347837-1-linus.walleij@linaro.org/

This one here is part of that same general trend. If you have more
ideas on odd drivers or hooks or whatever else where that might be
useful, feel free to submit patches.

Jason
