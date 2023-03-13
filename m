Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C3C6B720E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCMJIC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 05:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCMJHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:07:45 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0A01F480;
        Mon, 13 Mar 2023 02:05:38 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id y10so12415505qtj.2;
        Mon, 13 Mar 2023 02:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678698337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKyTtkBc3vhH0cNio/ELGF+bwr3W/1y9c0sgHfHKMEo=;
        b=HhW4fv6ZXvYBTJ6AGZBCTFiFF9FWoelMQ7xdWlN5nyo+aZJGB9r/Any8H9INPuf29m
         28SiXM86cVsLJea4/AMKo8zpTaM/Ty8X+4pEh82bpXtt7kkY52jtOjpCDxm7GdZXxJ00
         FzGwnoZUGQXVmt99iWMyT3gY7zYO0SoQ2M2FgNHwm2MDnCGtcXA16Lm6ihufXjqNLleL
         cCMGds80zIAfIaCJfhhm7Aj2G8qMTtoM/b0S+PHFPn7aQvAHm/PE+9s0zXs5F0cyH4sK
         VdAy0K6aRdI5bizk87UDsKC+NSDEH0GaTHbESZYWy3tql68uXYjJsNeLEBfo9G7po7Tz
         WN9Q==
X-Gm-Message-State: AO0yUKV7efvX66PAbF55ht/tuGul/ctPt6XAo7HWAhYo/cfLDhoRB/Du
        +1JxTSYYn7tudK0wdfgmaI8nCHuhm5HbdQ==
X-Google-Smtp-Source: AK7set9Vc/bCfMIp7y+k42AvCq5XarJGXvB393t/nmVM2SXc6J+lplGl/cHI/86K4GC+mbJKxhyfdA==
X-Received: by 2002:ac8:5904:0:b0:3bf:bbaf:5c82 with SMTP id 4-20020ac85904000000b003bfbbaf5c82mr17775124qty.21.1678698337638;
        Mon, 13 Mar 2023 02:05:37 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id 74-20020a37054d000000b007456c75edbbsm3422295qkf.129.2023.03.13.02.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 02:05:36 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id e71so2569609ybc.0;
        Mon, 13 Mar 2023 02:05:36 -0700 (PDT)
X-Received: by 2002:a05:6902:208:b0:acd:7374:f154 with SMTP id
 j8-20020a056902020800b00acd7374f154mr20748438ybs.7.1678698336364; Mon, 13 Mar
 2023 02:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de> <20230312161512.2715500-24-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230312161512.2715500-24-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Mar 2023 10:05:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWrn45DEG4yHqiEMsR4G5460rxBu5d5-OEMg_7TUWOfFA@mail.gmail.com>
Message-ID: <CAMuHMdWrn45DEG4yHqiEMsR4G5460rxBu5d5-OEMg_7TUWOfFA@mail.gmail.com>
Subject: Re: [PATCH 23/30] clk: renesas: Convert to platform remove callback
 returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 5:15 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
