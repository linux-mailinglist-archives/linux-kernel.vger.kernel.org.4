Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683F268C823
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjBFVAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjBFVAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:00:25 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36042CC51;
        Mon,  6 Feb 2023 13:00:24 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id h24so14452521qta.12;
        Mon, 06 Feb 2023 13:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EqlBysy8FJNLbRPnOSdCrnDfXyMH605RrBL7XoLfL1I=;
        b=WVZe+brCcxRosBl5fgiZTWSc+t3Vgy3dl0WDRhMTKKhdn/pd2F3dLQ3RmQUi2Guy1c
         IrPQN2c/bPCEYAmhyq+05OsmTvQU0v4SQLBmoUrgnM2AHqPr/jjQCAWSbKDkCp0f++Yi
         wJ7vHyY7vNB1XMhNs2NtaPbS80RMJeic/O3MR+Wv7BgEhb8KUqg3cBzt24hV9y42iB65
         8Ckt07jwRIaJTfjsfAwYL4ijpqIyyD2FW+sxMXiT8WwAdpIQ6HVvRDzsyUxjZbJK0lHr
         7vXYVLyeO0iMO95YSHiRHWwq/mz38El32LesgyA5hUnvHHsgZp5r743DjZ9NG3HFoIQf
         Coqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqlBysy8FJNLbRPnOSdCrnDfXyMH605RrBL7XoLfL1I=;
        b=79EiwOerkWb1W3lBd9pLT3c4Q+ko4DYW4KN8Rh6F1AVB7NMBY/V9pJuZ4Dizh4xfM/
         /JgnsM0GrBNKEBk1d9J00+mkq6W207dnDoXL31XRgTTgnkGKGFql2gpV+Bk8qIcOSIfl
         MzkGTLyeDEqrbvcFmOvGgXc+MKn6MDrq5yJ9dNs82nwllomm0Y2Mh/ACSyCZieM7sbTw
         tgRpORSu6JYIN5xFdal5n4kGKsPs6pZjnFrfWIxBK5O/Gcxydxycw9iyIYTK2JZRsH93
         wcNsWkpSLsPqJHmlb/hMl0tKTjP0+FgE7+mLhraKHeHRE7Cg45gY4gD+WLGah4Ue+1hS
         83Uw==
X-Gm-Message-State: AO0yUKXyykUEQ8Xway5oU19yGbRFCd5nSVS/ngemoQFb8weSipv7zoP0
        XIUyEuNbysoHEZHxFVKqT25cXmAXru9pTkdOoTk=
X-Google-Smtp-Source: AK7set82fOJ2IybN6MvzU6d7sO1+Zo4QNErC0SyTIJIUzxM8szLBIfLfQOTvIS7td8/JIgnGEKdn38rwdhZLxPoP++A=
X-Received: by 2002:ac8:5a4a:0:b0:3b9:ceb2:210b with SMTP id
 o10-20020ac85a4a000000b003b9ceb2210bmr134662qta.287.1675717223971; Mon, 06
 Feb 2023 13:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20230206203720.1177718-1-horatiu.vultur@microchip.com>
In-Reply-To: <20230206203720.1177718-1-horatiu.vultur@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Feb 2023 22:59:47 +0200
Message-ID: <CAHp75VcVn2=Xy7P4xgiDKkpOkw+YD1zGwMYARpWV6Eiv0fUakw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ocelot: Fix alt mode for ocelot
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, alexandre.belloni@bootlin.com
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

On Mon, Feb 6, 2023 at 10:37 PM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> In case the driver was trying to set an alternate mode for gpio
> 0 or 32 then the mode was not set correctly. The reason is that
> there is computation error inside the function ocelot_pinmux_set_mux
> because in this case it was trying to shift to left by -1.
> Fix this by actually shifting the function bits and not the position.
>
> Fixes: 4b36082e2e09 ("pinctrl: ocelot: fix pinmuxing for pins after 31")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

...

>         regmap_update_bits(info->map, REG_ALT(0, info, pin->pin),
>                            BIT(p), f << p);
>         regmap_update_bits(info->map, REG_ALT(1, info, pin->pin),
> -                          BIT(p), f << (p - 1));
> +                          BIT(p), (f >> 1) << p);

I'm not sure I understand how this doesn't break anything that has a
bit 0 set in f. Is it not a problem?

-- 
With Best Regards,
Andy Shevchenko
