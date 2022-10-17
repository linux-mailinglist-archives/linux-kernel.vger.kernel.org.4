Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A54E60158B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiJQRjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJQRj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:39:29 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA16B58
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:39:27 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 8so7113512qka.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eYQnNuzPH5otwHixLKGA5pU9WSpffRse/AQU9HdTYVQ=;
        b=d6IowyY7mh5hKwLJr5qUScdSmGGNcC2EpjIygtRBa3rVPiro8XaVrV2d/Ll5LWV7yS
         rtgBUFsD45Jffn0qUj+i2TfdePWbDhanmkWN+z6rdoRt1UULY3vozGJMTMmIzEDqT6Em
         +MpFSKLkx68ZIL+YSLCyTNKU4wHKWa76h19YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYQnNuzPH5otwHixLKGA5pU9WSpffRse/AQU9HdTYVQ=;
        b=eSqLyNw7SYkoKczEvoszEkLXRJECyXBw83y7ac/Gp8bRcstqVLEG8NVeM+WIrAFrIQ
         xFSNb9VkOpKEJDoEyViicJlfHe3VlPNlXZtxWJLXoyGoKBWth627k35p8ClJgxRjKYWz
         8f3KYd/LFWUro7RMnfNP06j2tu1a8Ap+PeLdadqAIQV8ouQzmBg5q5iWMgTnpf4Q3mqz
         UFuYchr0WELR3gWbHpWbCW6YqTtmQZtNrDEbWChYwWkkUWIGppIr+DS2epiHPuFxyGlh
         w/MHDutKOWjuVW1hBjAc4qr4uMsmbVSjG3f840xMMHFak0kbQoC5rS+/9JKbPXXaqRwS
         aGuQ==
X-Gm-Message-State: ACrzQf1f6WP5xsJONFH/XnNJ/bRNoAKlWIswRcue6Nxm+6Sl1CYJt2Bo
        5xrnQg1w4I+XeZixPZtVeV2ygztvETHVDw==
X-Google-Smtp-Source: AMsMyM7jAGNzQG8R9aXXImLx6Av3DaCjp6VdGrxtyJb4BFgtWGZSWxtDBKTqXGVJN48ciZZm1yDVUA==
X-Received: by 2002:a37:4646:0:b0:6e4:ed82:a3ac with SMTP id t67-20020a374646000000b006e4ed82a3acmr8438863qka.57.1666028366426;
        Mon, 17 Oct 2022 10:39:26 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id g8-20020ac87f48000000b0035cf31005e2sm250358qtk.73.2022.10.17.10.39.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 10:39:25 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id r3so14111390yba.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:39:25 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr10802840ybu.310.1666028365094; Mon, 17
 Oct 2022 10:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj6y5fipM2A5kEuOO9qm5PBzUY=-m9viEahhtxT09KR_g@mail.gmail.com>
 <20221017123434.GA1062543@roeck-us.net>
In-Reply-To: <20221017123434.GA1062543@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Oct 2022 10:39:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9o1x43Me0kRZAwN-DmZzUgJzUhA2_v+Uo0Aq04hB_=A@mail.gmail.com>
Message-ID: <CAHk-=wh9o1x43Me0kRZAwN-DmZzUgJzUhA2_v+Uo0Aq04hB_=A@mail.gmail.com>
Subject: Re: Linux 6.1-rc1
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Hector Martin <marcan@marcan.st>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Guo Ren <guoren@linux.alibaba.com>,
        Jakub Kicinski <kuba@kernel.org>
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

On Mon, Oct 17, 2022 at 5:35 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build results:
>         total: 152 pass: 152 fail: 0
> Qemu test results:
>         total: 490 pass: 420 fail: 70

Strange. You claim zero build failures, but then:

> Build failures
>
> Building riscv:defconfig ... failed

so I think your stats may be wrong somehow ;)

> mips, sparc64
> -------------
>
> All big endian mips tests fail to reset after boot. The problem is
> caused by commit 72a95859728a ("mfd: syscon: Remove repetition of the
> regmap_get_val_endian()").

Bah. I had already archived that whole thread as "sorted out", but
yeah, the revert clearly never made it to me for rc1.

But it should be in the regmap queue (Lee/Andy?), so it is hopefully
just a temporary thing.

In fact, it looks like all the failures have known fixes. So here's
hoping that your list will be a whole lot cleaner by rc2.

Knock wood.

Thanks,
           Linus
