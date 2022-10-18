Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C91A6026E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiJRIaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiJRI3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:29:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAFE630E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:29:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a26so30424757ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8IByHaHtnVLqDqCobgtQW0YAS3jK6ArSiZSVSG022Ng=;
        b=kjLX0HvVbZn5XMaSukgq2uBmzJ9GGugFPSCWoBZQi1oEXTl54W5Vgp12I0Qm6zq5hi
         lgZiY/nKUp6q/c5iJWk6HCpy1t+YIleB7uGl12qdybg5F0R6BPLNZmWYwniIlyl800Ky
         WgVwAzcaEWCc4HCqKVrZYA0HKjf+1pxvz85PgwClmsA2kporgsRwnhz6Ab4hbGG/+wrG
         SO8E7GPg5ZsmUU6WQwQvm47v6le2N1VerB274Wn7THn5ZkCz6dNwe1TtZOYoMrDN9rrn
         VrwSqx+NJEca0+YZsJAwdiTkykTP6dem/xrUcx8bsEK3jZXnEZd5PWTFdJQgSkkJzPp/
         zy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8IByHaHtnVLqDqCobgtQW0YAS3jK6ArSiZSVSG022Ng=;
        b=2MecflIEuxuL3HEY1CCAwwqzWka6e7OA4VlgpB8q810SIb0CfDSDhdhF785iiQ/k3i
         WWJWat2liMRWJRtKCQbu4mwk+nKKXyKmyQw3A+/Bh46MsoU0RC7xeM/I/SaD0wx95XbE
         4RglESUmJoQ+lasR+SYIvvCkIyNb5t98RCpjKSf5nhlZpz8YNybXtLGmBR7QTFHYFk/K
         JJhzVX9uSPYqxl8qlg83921sXbj2FZqcfFuFbWwPvDKAK9k67hA52qypQxoBnYYSJbZU
         PVFQUbeRNcjErD0H6AjuFrKBBHNv6X6NMFS2QUla+01dY49yP2B0Rsp1UVFN00riYTaT
         1FUg==
X-Gm-Message-State: ACrzQf2Mx019l2suix6nQ49EAufF7UY73VZ3hKePxCXI0/2qh94dthcR
        1n+gPqT7zayHZ9a0vzgFngx5LNac+18gMsdUEytuGg==
X-Google-Smtp-Source: AMsMyM7fG+F2r9yDirnal4Fn7D3BtLBivEvw4ZY1xlJvCIyKxCcfqNytkaA6t1nEGhqmDhOD9vtXqDw/V5KCXgpC2hE=
X-Received: by 2002:a17:907:7606:b0:78e:61d:757e with SMTP id
 jx6-20020a170907760600b0078e061d757emr1367406ejc.690.1666081764467; Tue, 18
 Oct 2022 01:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221017170600.88480-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221017170600.88480-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Oct 2022 10:29:13 +0200
Message-ID: <CACRpkdbNkPG5KsB47jByseDh=nOt+J2eE_nh5EJqRLAPDp8v8A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: exar: Allow IO port access
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Gray <william.gray@linaro.org>
Cc:     Qingtao Cao <qingtao.cao.au@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 7:05 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> It's possible that PCI device can provide an IO port resource for
> the device. regmap MMIO currently uses MMIO by default. With an
> additional flag we enable support for IO port accesses.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks clever to me!
Acked-by: Linus Walleij <linus.walleij@linaro.org>
I would let William have a look at it as well, as he's worked extensively
with port-mapped I/O.

Yours,
Linus Walleij
