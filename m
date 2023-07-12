Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68E275067D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjGLLnr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 07:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGLLnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:43:45 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D08D1980;
        Wed, 12 Jul 2023 04:43:44 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-57712d00cc1so80686747b3.3;
        Wed, 12 Jul 2023 04:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162223; x=1691754223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFaa1eey2gFBEkQTz4+FvOqjiuJjKAg/tTkqzXxKkMw=;
        b=AxMhJcDjOzPhmC8jTZE4lggCg763BS+rLs49ypbyQLRgnl4CCboi+S0WsrbwE9Zdow
         Y2goESZX6RVk7Gst5+m4eHW+uAczxPq1TKKBMKdbUMqIpgpLgZ/XB043h6UbV1ZeGfS9
         4ZCxAB5p5UgSf2p0QV45oU0rm2ahLesM4JDRWQ/VjWW4RqJidTpDviMnBsVpDC2FDLNV
         OH3YYXOYcgPJaHgBHfElJlKGbqvZ/wi3A8YMjRaAfdqhERenwCyaarkoUS1Czr414Utf
         4jwpY5mIA8UsesEHcakviOoNZZFJmALp4pkVLR/IFimfdq7+F2RZFflQ9oq+y2NWT5V7
         vNIw==
X-Gm-Message-State: ABy/qLZGwMy4vnbL5TCzb6XHfZpnyznicrdE96kBT5aQd4iFw3oEtmcK
        D68b8Xe+sSDHFYJigdOuYFKO16RWvW1EHQ==
X-Google-Smtp-Source: APBJJlGMIyJ2PM9Ugkvat2OdD8kl7nbkrUSZTKe+vV0IuzVh3mUiWX4qcTm1eQ/TYxVFXlAssSuvbg==
X-Received: by 2002:a0d:ce43:0:b0:57a:f72:ebf8 with SMTP id q64-20020a0dce43000000b0057a0f72ebf8mr22549179ywd.28.1689162223181;
        Wed, 12 Jul 2023 04:43:43 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id o123-20020a0dfe81000000b0057069c60799sm1116366ywf.53.2023.07.12.04.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 04:43:42 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-c49777d6e7aso7876166276.1;
        Wed, 12 Jul 2023 04:43:42 -0700 (PDT)
X-Received: by 2002:a25:68ca:0:b0:c85:a84:d87e with SMTP id
 d193-20020a2568ca000000b00c850a84d87emr8445978ybc.10.1689162221895; Wed, 12
 Jul 2023 04:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230712081258.29254-1-frank.li@vivo.com> <20230712081258.29254-21-frank.li@vivo.com>
In-Reply-To: <20230712081258.29254-21-frank.li@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jul 2023 13:43:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWiAnN0a3wKGekvLSR7Gxh2kp-Bvmyb9o8EaxFWK8GC+Q@mail.gmail.com>
Message-ID: <CAMuHMdWiAnN0a3wKGekvLSR7Gxh2kp-Bvmyb9o8EaxFWK8GC+Q@mail.gmail.com>
Subject: Re: [PATCH 21/27] thermal/drivers/rcar_thermal: Convert to platform
 remove callback returning void
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

On Wed, Jul 12, 2023 at 10:23 AM Yangtao Li <frank.li@vivo.com> wrote:
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
