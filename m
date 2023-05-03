Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274B76F5819
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjECMpJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 May 2023 08:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjECMpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:45:06 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0796F4688;
        Wed,  3 May 2023 05:45:06 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-55a64f0053fso45831587b3.3;
        Wed, 03 May 2023 05:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683117905; x=1685709905;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzS5hST/7dqPMgs9sJNP8+fBwYbZ8e7b2WdD4jUEi3c=;
        b=ef2nOFPb9dwfOENTBcejBQR8wM+d8IXsRzeF139GXOj3D6ICccL9z9+IiuAKnN2Hki
         kQzcnOUmONc/S95qdFLMPDbIPCdeCtw/F7OOP+FcUbhoP8ZlF+WSOMOzZVSPjcfyA9HX
         47udGmGKjnIfKjteDIdgBtpLTAW6HVmcTWAjBb+cX6h1tZHR8kTgwOtaMC4KmblpgmGI
         p9DzRBtW4GqENFYUTuGCaJw/XhtaPVXlWiitkNoPATR9vfpOulfrQnmr5wfz+5f6uCMw
         65Lx7HSaPGzXsVEmsB9BwMIuXT1TVM5XLpc9+qc1HYjycF/NdNJ2jsY6I+C7q/54dLZU
         Pzrg==
X-Gm-Message-State: AC+VfDxqVeRfYH83nPwg6LUGsj5J+qzvI3qT0oaFLfxSbCOvjPM1PBoH
        NTEQP95HbLRyMaXOY6ImivYB5j+o/z1K2g==
X-Google-Smtp-Source: ACHHUZ6TlvmCii8SvA+8xjIzQjWUQz7hdNdJXZjLZcr73jnLr4Upb6RroV+IXm2vjz+Ntk9NlGbxtQ==
X-Received: by 2002:a0d:cacc:0:b0:55a:afce:f652 with SMTP id m195-20020a0dcacc000000b0055aafcef652mr3865184ywd.32.1683117904937;
        Wed, 03 May 2023 05:45:04 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id g140-20020a0ddd92000000b00545a081849esm3133470ywe.46.2023.05.03.05.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 05:45:03 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-b9e66ce80acso2934616276.3;
        Wed, 03 May 2023 05:45:03 -0700 (PDT)
X-Received: by 2002:a25:ca08:0:b0:b9d:9b0b:6aa0 with SMTP id
 a8-20020a25ca08000000b00b9d9b0b6aa0mr15992985ybg.44.1683117903422; Wed, 03
 May 2023 05:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230502170618.55967-1-wsa+renesas@sang-engineering.com>
 <20230502170618.55967-2-wsa+renesas@sang-engineering.com> <CAMuHMdW9OP-C2iN97ntNJ7hjgmtY+=NQ=Hi38kPrd8ZUoafFjw@mail.gmail.com>
 <ZFJWkOzqqLXWReSk@ninjato>
In-Reply-To: <ZFJWkOzqqLXWReSk@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 May 2023 14:44:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV4StnvMaUZtrjbk-dbrm+3ELCKmzhSxd7O29Vt1fnM_A@mail.gmail.com>
Message-ID: <CAMuHMdV4StnvMaUZtrjbk-dbrm+3ELCKmzhSxd7O29Vt1fnM_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: renesas: r8a779a0: Add PWM clock
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, May 3, 2023 at 2:41 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > +       DEF_MOD("pwm",          628,    R8A779A0_CLK_S1D8),
> >
> > Do you mind if I rename this to "pwm0" while applying, to match the docs?
>
> No, feel free. I think it is a bit misleading because the clock is used
> up to pwm4. But if the docs have it that way...

The preliminary R-Car V3U docs _are_ misleading... But it's probably
the best we'd ever get ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
