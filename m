Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF56732AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245649AbjFPJBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243117AbjFPJAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:00:39 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D3FB3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:00:37 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75d558c18d0so53382985a.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686906037; x=1689498037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfA2+PKowVWnFmtQcmcI94eXp8KLOiEHUTtNf0iYmNc=;
        b=zk5Q6ZFoM2Wchg5beTouETIegNxWUNkCZR0oHoThZVtlGi7deHzXGsGQj64giSnfIW
         o5N3FUtfhLiLhUNKU7510u9f00olQ1i5qpVUk1eaYdKCTi+Ye5vD5XsV62fnTCDpgc2J
         l160cllw0jXvsMBzqqEPyVn6RINTrWSUBCjoPMTbTSRPyLNZwtH8WnQseXghsR6Mvy+Z
         eZxhQJJeMHA/CJOJ8hjbUPQ7wqK12Z+KwbiwoHkVCYQg3dbSzlcMlu8DAhQ9rJCd+Cf9
         WOuMeg8yTnUUXhjO7lAaLANYUibzszWcd/k1jHj05XvvvRxtoT6KdPGyCRZmsxWyu4sX
         m54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686906037; x=1689498037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfA2+PKowVWnFmtQcmcI94eXp8KLOiEHUTtNf0iYmNc=;
        b=jLBiiWbu75Zc28/9iIU71LkUY58kxK4wYA5ykR2qGG9LbCCaKs24Vl8ysqey/VAsIJ
         eWQ5o1Z7kylcjy+PApYTtn4YTiYH7OvPTuXD7rdljkWI1YjQVlyuuUOERYUk37yekVSq
         s+1zSFrL/2fdqLroZzKy7SJIIz6nDrUsbhFUJCQ8BJEFNB5CUBPjtbSOH5Hs/S0mA7WU
         cU3OxOM5mBoCxdRpeVpwk/12dUFNJzz/4etIhQ9ym3M6Kv3sZdvSKfPeFH9HP6f/7GrG
         ed5Ww+n4H6eL/k8hP4TbbQWygGqG2vZsnc9mp6xdxX9vyF/cYviH7ZMBqxKAtwv1GW3r
         cmaA==
X-Gm-Message-State: AC+VfDytwlvGF13Jnq7KOapEGHHvm7/MRRkAQ1vdENcTD3B2QXigulAW
        Z0JZHG2XwgrNsgik4Mw7H1XAr2uGhWyuOf5Ln1L2cKqSTEGwyull
X-Google-Smtp-Source: ACHHUZ7e+R7mXzqeL8J8PJ/VKESbKvX+0rlaG0kmR8fYR+mOZB0JPcGQ8kdCUOAGldHsfTuqdSPUhoHlYE+drMvV+w0=
X-Received: by 2002:ae9:f447:0:b0:762:148:6d68 with SMTP id
 z7-20020ae9f447000000b0076201486d68mr970467qkl.9.1686906037026; Fri, 16 Jun
 2023 02:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230615132023.13801-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230615132023.13801-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 16 Jun 2023 11:00:26 +0200
Message-ID: <CAMRc=Me1Gy6rpKQ=7LZ3qZG+TdBbpsQ=QGQqZ0G6tJnp1HqtSQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] gpio: aggregator: Incorporate gpio-delay functionality
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 3:51=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The newly appeared gpio-delay module enables external signal delay lines
> that may be connected to the GPIOs. But at the same time it copies the
> GPIO forwarder functionality. Besides that the approach does not scale.
> If we would have another external component, we would need yet another
> driver. That's why I think, and seems others support me, better to
> enable such a functionality inside GPIO aggregator driver.
>
> Patch 1 is a cleanup that may be applied independently on the decision
> about the rest.
>
> Please, test and comment! Alexander, I would appreciate your tag.
>
> In v3:
> - added new patch 3 to prevent device removal from sysfs
> - switched to feature in driver data instead of "compatible" (Geert)
> - applied tags (Geert, Linus)
> - left DT bindings untouched, can be amended later on
>
> In v2:
> - split as a series
> - covered CONFIG_OF_GPIO=3Dn case
> - removed the gpio-delay
> - moved gpio-delay Kconfig help to the comment in the code
> - left udelay() call untouched as recommended by documentation
>
> Andy Shevchenko (5):
>   gpio: aggregator: Remove CONFIG_OF and of_match_ptr() protections
>   gpio: aggregator: Support delay for setting up individual GPIOs
>   gpio: aggregator: Prevent collisions between DT and user device IDs
>   gpio: aggregator: Set up a parser of delay line parameters
>   gpio: delay: Remove duplicative functionality
>
>  drivers/gpio/Kconfig           |   9 --
>  drivers/gpio/Makefile          |   1 -
>  drivers/gpio/gpio-aggregator.c | 113 +++++++++++++++++++++--
>  drivers/gpio/gpio-delay.c      | 164 ---------------------------------
>  4 files changed, 106 insertions(+), 181 deletions(-)
>  delete mode 100644 drivers/gpio/gpio-delay.c
>
> --
> 2.40.0.1.gaa8946217a0b
>

Applied patches 1, 2, 4 and 5. Thanks!

Bart
