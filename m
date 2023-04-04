Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1FA6D5FAB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjDDLzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbjDDLzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:55:14 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569D046B6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:54:40 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-545e907790fso492985697b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 04:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680609279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z3aoxpvrOqiKeOQufTqMhp/8jleC9vMuaVjw9g7IwB0=;
        b=xTLZHr2CnFbljt+E3jjuwZNEOvIuj57YLi68MUTC56Ao0mf+PGauG1q8aQJNN9lB7S
         IhzvQjjGMj+0tsUe7uR0IbEirJs/PJv2W6741AJlJahG9qDJAn29C7QDr+e8fqS817pt
         XJkc0Sb/WDgOvKK9S7S6SBOsz5qAqqaoTC9wt7wIjU5KNdRvDmKQgypxWBP+ZIlPriQH
         6rYQi5NMfZDS+IDQp+VC9cKP9J94z6HrHpL7yzvbXIXxJ2Vq2EgHve7F3x+TQxcqcavp
         FBEHhU3nHa59R0HLXK2P73m5Yqp6MOjbZLEDC++zEZpf5CLH6pZIGC6ptFF411PCqxOJ
         61gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680609279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3aoxpvrOqiKeOQufTqMhp/8jleC9vMuaVjw9g7IwB0=;
        b=UbsYtwe53jbNXpwjlDGzyCbBhoKlB80bFPZBRuL1zfAWeFZiA3daS4y4oNk8Zv8457
         pUIXa1D1vk++qyz/LdQQjF6KpT0O7MwK6OZ/wUl4AxD/WlgqkTahGckN65jM3u6EPs3i
         +hr5F7wyl3KYhQQHfDXWNxDe4BP1XcA8lzekqsj0uvIONH+jGmUWZgaiO9TijnTqxgkt
         aJgynpoewDs8rXV61chjbPK+fn6rX5/+ymfkgmb5rOyFeK+MReDe0w3QbyWti9DBXwv9
         lru0sxMFuhGlTI9BRz2iCxp7YRWVrx6vzUMe8ihy6Z0PIQHPDPlKq+r1MrURy0J0dsMD
         BN8Q==
X-Gm-Message-State: AAQBX9d5a6B2FF5GgxADiEveqj2hr7ZqmYfyxtxtrxaqDhsKgrh4P0/p
        A+IbRlPdqLP1PLH1wjQQs1WTi3ksJYtvtBIeOABdtQ==
X-Google-Smtp-Source: AKy350YR+NZ+mV7VuRCSCDwJeX9A6f11Py3U+/bsti4FZGk7p9htWsIniPqHRarp6O43TDHEhIwmNmWA9y/nrJ59BaQ=
X-Received: by 2002:a81:ac0d:0:b0:52b:fd10:4809 with SMTP id
 k13-20020a81ac0d000000b0052bfd104809mr1369798ywh.0.1680609279367; Tue, 04 Apr
 2023 04:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230401200327.16800-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230401200327.16800-1-gregkh@linuxfoundation.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Apr 2023 13:54:03 +0200
Message-ID: <CAPDyKFq3VUVM2-ATNykGyutMoNDO3EkbT2foZBQjxzKr7cTnFg@mail.gmail.com>
Subject: Re: [RESEND PATCH] memstick: fix memory leak if card device is never registered
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kay Sievers <kay.sievers@vrfy.org>, stable <stable@kernel.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Apr 2023 at 22:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling dev_set_name() memory is allocated for the name for the
> struct device.  Once that structure device is registered, or attempted
> to be registerd, with the driver core, the driver core will handle
> cleaning up that memory when the device is removed from the system.
>
> Unfortunatly for the memstick code, there is an error path that causes
> the struct device to never be registered, and so the memory allocated in
> dev_set_name will be leaked.  Fix that leak by manually freeing it right
> before the memory for the device is freed.
>
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Alex Dubov <oakad@yahoo.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Kay Sievers <kay.sievers@vrfy.org>
> Cc: linux-mmc@vger.kernel.org
> Fixes: 0252c3b4f018 ("memstick: struct device - replace bus_id with dev_name(),
> Cc: stable <stable@kernel.org>
> Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Co-developed-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

Applied for fixes and by adding Mirsad's sob tag (according to the
other thread [1]), thanks!

Kind regards
Uffe

[1]
https://lore.kernel.org/lkml/c059f486-98a6-aecd-c135-c033612e6b4f@alu.unizg.hr/


> ---
> RESEND as the first version had a corrupted message id and never made it
> to the mailing lists or lore.kernel.org
>
>  drivers/memstick/core/memstick.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index bf7667845459..bbfaf6536903 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -410,6 +410,7 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
>         return card;
>  err_out:
>         host->card = old_card;
> +       kfree_const(card->dev.kobj.name);
>         kfree(card);
>         return NULL;
>  }
> @@ -468,8 +469,10 @@ static void memstick_check(struct work_struct *work)
>                                 put_device(&card->dev);
>                                 host->card = NULL;
>                         }
> -               } else
> +               } else {
> +                       kfree_const(card->dev.kobj.name);
>                         kfree(card);
> +               }
>         }
>
>  out_power_off:
> --
> 2.40.0
>
