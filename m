Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEB76D78E7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbjDEJx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjDEJxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:53:23 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD43A189
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 02:53:22 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id f14so12668991oiw.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 02:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680688402;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WuDlPtdV6uZPprhEWy55rkbTExa0n5XzD3AAQzNgbNI=;
        b=n7ssrNKq2c4+V5onYW0XrsAqYt4idodYcAdodhHTFj71uyPyjRvSXPQdSyA8ujPXNa
         8vfh5WObSL/S+IDEb+Zm+NysaXju1Wpr+MGuhKbKxY8I7W0egA8oxjH4UBA2I0XmKIhn
         sc+SbwcY9E13DrNAO/UhpNMV0EWQzKBeV8PjH+l6ugeLplxZNikKXNBZnK4FMvj7AYLP
         ujXXcLYDWpeGK1pHgx6vlDrnjOvC/rRGrRObk2Gia0Q1qWN6GV1Tcq4wDfWrehIBIwZ2
         yHHwKChXVLwhIyJR1yBm2e7ZVd6ISmX4Lb4zMxvk3+QGawPMvyU0WDigeDnLgu91mC8o
         cx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680688402;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WuDlPtdV6uZPprhEWy55rkbTExa0n5XzD3AAQzNgbNI=;
        b=fzGI9FDw6MuaFPeZwTjMRf0xbHQ/XOdZUx8Up9nW7Ouaw5llkmY0X7WS+UsyKoHqTz
         a3QnY+G3kKXGKzFLisLBTAzV7noG9Ryajcx2oziZbLs6i5UzHp94W3KqCkKd9XeNAW41
         OtdYdmTK62Di+xyBxtsDp30la78WNbe0kMQxY0UB+gw4vUcrwcdO7qfeiNvbkqALsWDY
         0aaELqGwV5/MYpDG59MuO904dAJNkFehAa74FV/vUhXmL3bquoVrL6AElsghGIvFAEay
         nX6DP9WeL9q9G3GbtK4n/QV1ZkvGGTa2BZhVzI2bXzcqgv1Yzr69pXxFquCWsiY4fqtJ
         SYdQ==
X-Gm-Message-State: AAQBX9d5ChMm2/tES4YyQeBuS9+9C59FkWAnG335CLHlpqd1kxLlOlwv
        YvCLlEoJTs00xqpmP2LkkumPiFt1eWdRVdA9TxY=
X-Google-Smtp-Source: AKy350at0qi+gpxZcqbRtHAlo1ZUSktJb6ZZW/Z3S0rZiClUaDm09Ngt/a8aMoEJKRDJCDyM/zFbYtXvVlboatFVoR8=
X-Received: by 2002:a05:6808:2198:b0:389:8dad:7832 with SMTP id
 be24-20020a056808219800b003898dad7832mr1770491oib.8.1680688401807; Wed, 05
 Apr 2023 02:53:21 -0700 (PDT)
MIME-Version: 1.0
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Wed, 5 Apr 2023 11:53:10 +0200
Message-ID: <CAPJMGm4GaSjD6bdqMwCr2EVZGenWzT-nCCf3BMRaD1TSfAabpA@mail.gmail.com>
Subject: iio: ad7192: Pending IRQ on SDO/RDY causing retrigger of interrupt
 handler and missing every sample
To:     alexandru.tachici@analog.com, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link: https://lore.kernel.org/all/20210906065630.16325-3-alexandru.tachici@analog.com/

This commit broke the driver functionality, i.e. cat in_voltage1_raw
triggers a correct sampling sequence only the first time, then it
always returns the first sampled value.

Following the sequence of ad_sigma_delta_single_conversion() within
ad_sigma_delta.c, this is due to:

- IRQ resend mechanism is always enabled for ARM cores
(CONFIG_HARDIRQS_SW_RESEND)
- Edge IRQs are always made pending when a corresponding event
happens, even after disable_irq(). This is intentional and designed to
prevent missing signal edges.
- Level IRQs are not impacted by IRQ resend (i.e. IRQ_PENDING is
always cleared).
- SPI communication causes the IRQ to be set pending (even if
corresponding interrupt is disabled)
- The second time ad_sigma_delta_single_conversion() is called,
enable_irq() will trigger the interrupt immediately, even if RDY line
is high.
- In turn, this causes the call
wait_for_completion_interruptible_timeout() to exit immediately, with
RDY line still high.
- Right after the SPI register read, the MODE register is written with
AD_SD_MODE_IDLE, and pending conversion is stopped. Hence DATA
register is never updated.

I would suggest to revert this commit or set the flag with
IRQF_TRIGGER_LOW instead of IRQF_TRIGGER_FALLING, but I am not sure
about the problem solved by this commit and how to replicate it.
Another option would be to keep IRQ flags within bindings only.

As a side note, AD7192 datasheet says that the falling edge on SDO
line _can_ be used as an interrupt to processor, but it also states
that the _level_ on SDO/RDY line indicates the sample is ready. What
happens on SDO/RDY interrupt line before the ADC conversion is
triggered should be ignored.

This bug should be easy to reproduce on ADI demo boards with impacted
kernel versions, just by manually reading any input channel from
sysfs.

Fabrizio Lamarque
