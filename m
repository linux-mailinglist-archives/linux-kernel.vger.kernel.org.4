Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F24750680
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjGLLo1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 07:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGLLoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:44:25 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576221980;
        Wed, 12 Jul 2023 04:44:24 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-57012b2973eso80724067b3.2;
        Wed, 12 Jul 2023 04:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162263; x=1691754263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aF4ThrLAOR5pV4olgrzmKlUGMJqxGnKjvfxu8NIqT5g=;
        b=LDNEP21URBpW+Tn1rG7yA5XgZCB2BVcFxu93lBeV5wSp+WIMafk/KVIMiwydLYhoCb
         xFHIdWyGncwHH5T8UYht+ircQrCTLtb9CYjonAqxquzGDHwGS+g87HILxLMMnG1U23dX
         bWhzSCooItrz8q2ZB8WijHALfvLQxHTl2bMrfFBDtzNPBTfSh1o1XbtVA3y0ThrEPsql
         ecxHdcgLpqaNjO6slQuUZmaZroPCRjv9mGISGPpCIMpwkK/V8amTWJGob0rBcynICRR5
         OT9oGl49IdO9FXOYUf3/SjB+mlr5wdWTeiiJbDM1ArHujvrbZJzEChpzR1VTVJ/XiKcM
         kJ0g==
X-Gm-Message-State: ABy/qLbbDhRPYgo5rfm5HZrztvVuOnVYIizfg5jNzimBL3MhwMJlsxXA
        V/p16ClT2Wjt1isXZdMueBw5nHnXmjwzVA==
X-Google-Smtp-Source: APBJJlFwBSHY+GgvRaTVPogOlXiuAMO7u0aTdjAYWsaAZKUO6tZDdK9ku3H5wMIdKmXifyszwiXqMQ==
X-Received: by 2002:a0d:c342:0:b0:57a:8de9:16a3 with SMTP id f63-20020a0dc342000000b0057a8de916a3mr6973487ywd.8.1689162263272;
        Wed, 12 Jul 2023 04:44:23 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id p186-20020a8174c3000000b00573898fb12bsm1105077ywc.82.2023.07.12.04.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 04:44:22 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-c7a5600d04dso4732400276.3;
        Wed, 12 Jul 2023 04:44:22 -0700 (PDT)
X-Received: by 2002:a25:c343:0:b0:c16:8d80:228b with SMTP id
 t64-20020a25c343000000b00c168d80228bmr15366379ybf.37.1689162262807; Wed, 12
 Jul 2023 04:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230712081258.29254-1-frank.li@vivo.com> <20230712081258.29254-4-frank.li@vivo.com>
In-Reply-To: <20230712081258.29254-4-frank.li@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jul 2023 13:44:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWbA9FxAo3f08rQ6eiOrLJcTxDqEq0BuYK4g_SnpSJYuA@mail.gmail.com>
Message-ID: <CAMuHMdWbA9FxAo3f08rQ6eiOrLJcTxDqEq0BuYK4g_SnpSJYuA@mail.gmail.com>
Subject: Re: [PATCH 04/27] drivers/thermal/rcar_gen3_thermal: Convert to
 platform remove callback returning void
To:     Yangtao Li <frank.li@vivo.com>
Cc:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:16 AM Yangtao Li <frank.li@vivo.com> wrote:
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
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
