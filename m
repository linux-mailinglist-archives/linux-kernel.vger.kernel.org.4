Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0D568C0E2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBFPCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjBFPCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:02:44 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF953C644
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:02:43 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4b718cab0e4so158466287b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 07:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E6kD2nBw9wr4ZURcXCv4tl7gixSwW6X6UZTXU1h15hk=;
        b=BvkV62V/N9+uQ4o58Y23DaIf+ksKPFLkGkImeKdcUVpXkDd0ZqBbq0KGQ9oNJG/pZw
         QH7UkruSWvOam0/EZBzX5lE4KQIkeglT08UPSV4u76trqdesRCq3Em9KmEjz4TMiOJ3S
         aHLaB73Y1wPfcJSh7uSRVuiXmNjNWYxx+b3YIZO6Y9+9CYs2DuO3UEOCpdbJvHP1kC7r
         d+8/vTMyyc+9hDJr3HipzTZt+Y5uq5VgUIkfuwhIisNc/3MVyMvfN/NBAAIuKSfuAkk6
         Yo8t2jN54NhOo44O03NuejLKzSXfpdxothOeVtzjnzOJr3siI2aM1B/W22NWIKXETJOw
         9oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6kD2nBw9wr4ZURcXCv4tl7gixSwW6X6UZTXU1h15hk=;
        b=CL+vnCH18jKHFeo9PWafbImO83O/JB3osVltzd3zD7DrdSaUyhVA8uO30gGBXu34OA
         mmulq0Utxyy1sKeBxSHZZ+l1G1Fof+otjmZYF2wZdzh0C1V2FdBhQY2DRaENqpyTr8wi
         MV2tgAOXDkFvduD/pcDl5tdd5zEkzdn9/EGijaqQyOM0mlZRHGtHljlrdZtJDgY5n2+z
         T2JGfSqRXOKoPS0sRinUvTSpg1AwRua5e7W884p+0gPmdiVeJUTHghepMWuKod8VcDmj
         lSq+Ls3meYEGHo+mEPOcfNaI/RTeZMCKpsj0+UdswmW+z7MoJA3KJqNbXWStGRl7oo9y
         7miQ==
X-Gm-Message-State: AO0yUKUuSSadfJg+curz6fNUYjVG8mfHznaOMi11bpvACmH4X3gRdtko
        zuPuwVHKFHCQqel8KQf5lZuaxUNJlT5+wbpkzPLzwQ==
X-Google-Smtp-Source: AK7set9YJFx8Qp3l5WOe15WEwG/edOBQA0wNH8MX6CDDWvCRz82S+qTI9YIbBz8FGY9wQsMjpLFcwbd10Asw4Kfz3OA=
X-Received: by 2002:a0d:cb44:0:b0:527:95bf:db25 with SMTP id
 n65-20020a0dcb44000000b0052795bfdb25mr931922ywd.273.1675695759139; Mon, 06
 Feb 2023 07:02:39 -0800 (PST)
MIME-Version: 1.0
References: <20230206141558.20916-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230206141558.20916-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Feb 2023 16:02:27 +0100
Message-ID: <CACRpkdZaUFiWK_EsQkiKpR7n=VdbW=HnqonZ_GRei6r9Kyg3_Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Restore the pins that used to be
 in Direct IRQ mode
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Jim Minter <jimminter@microsoft.com>
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

On Mon, Feb 6, 2023 at 3:16 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> If the firmware mangled the register contents too much,
> check the saved value for the Direct IRQ mode. If it
> matches, we will restore the pin state.
>
> Reported-by: Jim Minter <jimminter@microsoft.com>
> Fixes: 6989ea4881c8 ("pinctrl: intel: Save and restore pins in "direct IRQ" mode")
> Tested-by: Jim Minter <jimminter@microsoft.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> Jim, this is a bit simplified version than what you tested. But it shouldn't
> be a functional changes. Anyway, it would be nice if you have a chance to give
> this a try.
>
> Linus, I don't expect more to come for this cycle, feel free to apply directly.

OK no problem, does it go into fixes pronto or for next (v6.3)?
I would guess fixes but I never know the difference between urgent
and nourgent fixes...

Yours,
Linus Walleij
