Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178605E930F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 14:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiIYMZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 08:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIYMZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 08:25:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405221A385
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 05:25:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y3so9046259ejc.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KHgdwogxytYBfvl6f7O6TaPsosrPUz0vkGsWflfZ7FE=;
        b=xPaF8R/f8vZJnEdG8UfR781xrtLud7z8kiI2qWiFlWQ0cJ9qHQy0C3joKmza74nUYp
         hu2hbXyqC69qCoiqoan9Gih5nmzjq1ufdPnfhkyqRNaoRESivTjDOXVBKBFdfDtSI9XQ
         VQC72q/EuJUhRclqfQetQbfj8N0mzE3xDW3WqCsqEw+mbgVI7XAXZmwNwbUW51Z32itm
         lkj4XAOH0f+YaEhQui6E9BylrFh0opReDMcZ4mtcCiJgmwIQeHqJQ4Xb1+LqZbeZ4Rom
         s+vQf1/9ouF4OOTdJ8MEXCCT3nISYbD1eKICDdgH/pniKatltsxDjK1kRSskjhKrpRvo
         ZSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KHgdwogxytYBfvl6f7O6TaPsosrPUz0vkGsWflfZ7FE=;
        b=fgShgLtBqTMNZK8+znZZuqwfTKdkgQXFn6mmwvGABHQqQPv20ULBG9s77J8WS5rfS3
         d8h0/Rbt5n6P2pCc4mnaf3JZnp5ebhJy3+Y4PFtj2B3DmWrUYMDEIoVK/szUx4twTqcR
         AiiXAZiwmudAJUkozKHegWnMb7KdN/+cwLCFu3pFeziV7p2U78hfD4YRiOd1cNwSmyBB
         h838+9CZMDLE1LNHiEBat3z3LpfHP9NXJJ8z2UoeP6MS0WjkoFlOpn6fZaHx+UfKQoxQ
         KIqziYePnNCDSkBAEqRvc4T5wWCEacavfGapYrlV7rlwb8hT0MLT7sXr8ubeuG4BbzmR
         wmYA==
X-Gm-Message-State: ACrzQf09oDi+HGx4VI3A72YqRdJe+BdAWzfttXwJwhJYlt2lxGs7Si/o
        sLdB2QlZUrduaXwcV29MSNX8h8flsOGAcdGvWIv74YX1kYc=
X-Google-Smtp-Source: AMsMyM4Ji2MrA7p71IqVULvFrKzPJlaBoi9hGrZERP/BcseLbb3vO7chovhCyoKmaa/RUmifgBk5UNCSvfYxULlB24E=
X-Received: by 2002:a17:907:c1c:b0:782:9d80:8bbf with SMTP id
 ga28-20020a1709070c1c00b007829d808bbfmr10049608ejc.203.1664108706442; Sun, 25
 Sep 2022 05:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <Yy6d7TjqzUwGQnQa@penguin> <68c63077-848b-45f5-8aca-ed995391f2b6@www.fastmail.com>
 <Yy7tLRcMaKeet9An@mail.local> <Yy8RcC2QHdws26ha@owl.dominikbrodowski.net>
In-Reply-To: <Yy8RcC2QHdws26ha@owl.dominikbrodowski.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 25 Sep 2022 14:24:55 +0200
Message-ID: <CACRpkda8Sdr9B8fXzBOPpmPvFeVjkXDFoA47_pmj-JERJBiDHQ@mail.gmail.com>
Subject: Re: [PATCH] pcmcia: at91_cf: switch to using gpiod API
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 4:19 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:

> From: Dominik Brodowski <linux@dominikbrodowski.net>
> Subject: [PATCH] pcmcia: remove AT91RM9200 Compact Flash driver
>
> As noted by Arnd Bergmann, "we used to have three drivers for the same
> hardware (pcmcia, pata and ide), and only the pcmcia driver remained
> in the tree after drivers/ide/ was removed and pata_at91 did not get
> converted to DT". "There is no dts file in tree that actually declares
> either of them, so chances are that nobody is actually using the CF
> slot on at91 any more."[1]
>
> On this rationale, remove the AT91RM9200 Compact Flash driver, which
> also assists in reaching "the goal of stopping exporting OF-specific
> APIs of gpiolib".[2]
>
> [1] https://lore.kernel.org/lkml/68c63077-848b-45f5-8aca-ed995391f2b6@www.fastmail.com/
> [2] https://lore.kernel.org/lkml/Yy6d7TjqzUwGQnQa@penguin/
>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

If someone actually has an AT91 board with this hardware and
want to be able to use it by converting this driver to device tree,
this is the time to step up.

Yours,
Linus Walleij
