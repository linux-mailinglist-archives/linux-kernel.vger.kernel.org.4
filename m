Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCF3735278
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjFSKfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjFSKfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:35:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2CE10C1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:34:50 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-77e2f4498d3so129555639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687170889; x=1689762889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEmM/V4+LRa0kJZh4f+xjV4QTwqbIyjR3fdgLv3MIdE=;
        b=T8Vm4JE0OXW4Wu0I9mdsWjamFF0v8jXcXuBXpSwUROwypdVnojHt5cSd+PDKpy0oRl
         AMVzbT+Zv3pGOwyVlZG2ogCLL9Xqh1urz0ao5gcyPnu++hMwYHsPs3WwwTugWPOV9wYU
         e5CSB6CW4LYRad1YrSyLl+gfg7sR0hDr5pm+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687170889; x=1689762889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEmM/V4+LRa0kJZh4f+xjV4QTwqbIyjR3fdgLv3MIdE=;
        b=Orj1+gb8SlsPFzmxmAZbU9GzreAfg+lpcsG46yRkzbqMOYCnFRj8cng4+a+8424ngC
         c2alE6bMztEzLECUvYKgdXm/BdwoAuTPZyNzkwXfLiCgPTiB7nta4SKas+Ot9MmvQ8D2
         1Rx1KMYY3K7PLdXa6P1yxQMBjD7ionySp/5HNxNFuuFJUPn3c1BMKUDCsr/JP1T84CFD
         g+kel28M9BdKYowahbaIcLX/NC3A5eo+v5zb8K2tWodwagDHQtJZszhkg10Yrcss7gF3
         kVsyQlwNHbg+BXRBcL52SD+zR/0odXWnt3O6sw59lqD0ggpeTyJ4dydRBwXRFaFHIWsw
         aQzQ==
X-Gm-Message-State: AC+VfDy/k1ms1yIVPtXuN4TnzsLK/CGDJG1zR/Fym+lOl4uQphOF2Fvl
        DCbqgGAvMWfuGnic+O1OFG0xXjGRHAuZpv7FSciT8A==
X-Google-Smtp-Source: ACHHUZ7CjK1UTl4cF9cT44K+6zsehcrX/62w1gBoyTVLt2wejjPyPEQ559F6OyzPrpIJTcOeENrDZA==
X-Received: by 2002:a05:6602:2215:b0:77d:b5ac:deb4 with SMTP id n21-20020a056602221500b0077db5acdeb4mr8207805ion.1.1687170889749;
        Mon, 19 Jun 2023 03:34:49 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id e20-20020a056638021400b0042679649701sm314550jaq.151.2023.06.19.03.34.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 03:34:49 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-77e2f4498d3so129554239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:34:49 -0700 (PDT)
X-Received: by 2002:a5e:8f0a:0:b0:77e:25dd:93be with SMTP id
 c10-20020a5e8f0a000000b0077e25dd93bemr8379722iok.14.1687170887982; Mon, 19
 Jun 2023 03:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230619112253.v2.1.I13f060c10549ef181603e921291bdea95f83033c@changeid>
 <35f6212e-69f8-432f-a5c8-99ed5c844f11@moroto.mountain> <CAC=S1njwxLfw7LcnXkgY7pbiFaqvNQVyAzHVhK9+nYJC63d=Zw@mail.gmail.com>
 <32fa8c0e-26f4-4ee4-889a-4037530c128d@kadam.mountain> <658d32f2-a71b-4dc2-bff9-649fadf41889@kadam.mountain>
In-Reply-To: <658d32f2-a71b-4dc2-bff9-649fadf41889@kadam.mountain>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 19 Jun 2023 18:34:11 +0800
X-Gmail-Original-Message-ID: <CAC=S1njbLadG+JP38pOrek8RFHYC+En_YXDPaYEbErn8OxFH7g@mail.gmail.com>
Message-ID: <CAC=S1njbLadG+JP38pOrek8RFHYC+En_YXDPaYEbErn8OxFH7g@mail.gmail.com>
Subject: Re: [PATCH v2] clk: Fix memory leak in devm_clk_notifier_register()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 5:57=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
> The other reason to include stack traces is so that if someone else
> runs into the same bug they can find your patch by googling their stack
> trace.
>
> Normal users aren't going to be running kmemleak.  And people doing
> testing work for companies are hopefully going to pull this fix in via
> the stable tree so they'll get this patch automatically that way so
> they won't see it either.
>
> But if the stack trace is like a NULL dereference bug, then users
> absolutely do notice that kind of thing.  You should always include
> those kind of stack traces.

If that's the case, I can leave a retrospective trace record here:

unreferenced object 0xffffff80c4e34a00 (size 256):
  comm "swapper/0", pid 1, jiffies 4294667967 (age 288.740s)
  hex dump (first 32 bytes):
    00 4a e3 c4 80 ff ff ff 00 4a e3 c4 80 ff ff ff  .J.......J......
    1c 2a 7a ae d8 ff ff ff a0 b0 af af d8 ff ff ff  .*z.............
  backtrace:
    [<000000007d72e65c>] __kmem_cache_alloc_node+0x198/0x240
    [<00000000dfce47ef>] __kmalloc_node_track_caller+0x6c/0x1b8
    [<00000000b6c409fe>] __devres_alloc_node+0x60/0x104
    [<0000000081112baf>] devm_clk_notifier_register+0x44/0xc8
    [<0000000070bfe318>] devm_mtk_clk_mux_notifier_register+0x60/0x74
    [<000000000242235f>] clk_mt8188_reg_mfg_mux_notifier+0x84/0xb4
    [<00000000f67ce424>] clk_mt8188_topck_probe+0x1b8/0x2e4
    [<0000000006eef8cd>] platform_probe+0x12c/0x17c
    [<00000000eacf783c>] really_probe+0x1f0/0x4d8
    [<00000000f321a3f0>] __driver_probe_device+0x160/0x230
    [<00000000bbeed898>] driver_probe_device+0x6c/0x148
    [<000000007d5af62b>] __driver_attach+0x164/0x20c
    [<00000000c5c25e77>] bus_for_each_dev+0xf4/0x144
    [<00000000e2c0100f>] driver_attach+0x50/0x60
    [<00000000cc421ec0>] bus_add_driver+0x2a8/0x458
    [<000000007814168a>] driver_register+0x16c/0x29c

It's up to the maintainers for the next step and I'll follow the call.

Regards,
Fei
