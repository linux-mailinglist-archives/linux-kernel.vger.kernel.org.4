Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489F86378A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKXMK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKXMKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:10:24 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFF1748D9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:10:23 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q21so1103550iod.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WsnqhIo8OuDtSYALlQhH/obeAFS+XPS7ahZHr0d+yKU=;
        b=YjfJcqXwBHOuVL7wse2ZKsQ5JtVewfVDDfpPUV3ubL2ABHvwcOsMfh/HD/aiEg6gBB
         XX/wR1/utF+we2u4WcBAMai6wjIAhlDokhsEktAsEKxDjH4nIrxXjHdbODGOHBoWnqqk
         Cq2an3iNEkj2a9KY8cKh4PvmX1XJ5yuCdmHkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsnqhIo8OuDtSYALlQhH/obeAFS+XPS7ahZHr0d+yKU=;
        b=a9Eqot7oyCWKy4Gj7J+G8UL2L2U0M42BaIFQ+WBWgDFFE9SDIvUWysADI5D5yJOEOe
         neI75hovX/cmB0hKbyvREI24CR0EXmgZ1z3P56mLe/bMxxUiV9sN4SaJcSXbcfwIvpZr
         vti4UDJCwhxd6T6WwuJQzMEovMvLxNZtmbs9jmibZd5wN1CCCURZymppj1DP1ovZLCvH
         t/iFyRBq85pFwSoEy9CQW5v7NbyDkEXeZ/q9aPHFRG5KS5w9SISaPIgndTauzRje7PZA
         KWaZOVjsF5obyqz/VHpbUsdAYHQ3KC15g9mU8bePyHGyF86xJecNAWeyrJ2q8o8ymxPZ
         DWoA==
X-Gm-Message-State: ANoB5plJBr8PJfTbp5Cs5POEoCACgm6dQyczeFMswCcRJJ2j1PnIjavC
        DerNCuJkutjJ90CyICvUiw+8g79p/9dHxw==
X-Google-Smtp-Source: AA0mqf4YcZ2ZnzDi8WzHGisiYe3YM7mV/76HkKKrHAi34aTVaPttu1fDIiJ2Dw2ErHsoaupPwYn80Q==
X-Received: by 2002:a5e:c00b:0:b0:6dc:3c87:cc53 with SMTP id u11-20020a5ec00b000000b006dc3c87cc53mr5807489iol.30.1669291823076;
        Thu, 24 Nov 2022 04:10:23 -0800 (PST)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id p9-20020a92da49000000b00300d3c0e33dsm393079ilq.4.2022.11.24.04.10.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 04:10:22 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id d123so1093311iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:10:22 -0800 (PST)
X-Received: by 2002:a02:c897:0:b0:374:100a:b0c7 with SMTP id
 m23-20020a02c897000000b00374100ab0c7mr6338879jao.185.1669291821369; Thu, 24
 Nov 2022 04:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20221123-serial-clk-v2-0-9c03ce8940d8@chromium.org>
 <20221123-serial-clk-v2-2-9c03ce8940d8@chromium.org> <140187ba-7d2c-8b7b-e172-7350eed458be@kernel.org>
In-Reply-To: <140187ba-7d2c-8b7b-e172-7350eed458be@kernel.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 24 Nov 2022 13:10:10 +0100
X-Gmail-Original-Message-ID: <CANiDSCvq54Xr7OECNuo230XhNbtY1Pgr8GA+ajreEZGYGucq9Q@mail.gmail.com>
Message-ID: <CANiDSCvq54Xr7OECNuo230XhNbtY1Pgr8GA+ajreEZGYGucq9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] earlycon: Let users set the clock frequency
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 at 12:19, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> Hi,
>
> On 24. 11. 22, 11:02, Ricardo Ribalda wrote:
> ...
> > --- a/drivers/tty/serial/earlycon.c
> > +++ b/drivers/tty/serial/earlycon.c
> > @@ -120,9 +120,15 @@ static int __init parse_options(struct earlycon_device *device, char *options)
> >       }
> >
> >       if (options) {
> > +             char *uartclk;
> > +
> >               if (kstrtouint(options, 0, &device->baud) < 0)
> >                       pr_warn("[%s] unsupported earlycon baud rate option\n",
> >                               options);
>
> IMO this won't work if there is a comma in options (i.e. your new
> clkrate param). kstrtouint will return -EINVAL in that case.
>
> > +             uartclk = strchr(options, ',');
> > +             if (uartclk && kstrtouint(uartclk, 0, &port->uartclk) < 0)
>
> You are giving ",number" to kstrtouint, right? That won't work either ;).


The fun thing is that it worked because it fell back to the acpi
parameters :). Will send a v3

Thanks!
>
> regards,
> --
> js
>


-- 
Ricardo Ribalda
