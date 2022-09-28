Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1665EE24C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiI1Qvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiI1Qvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:51:42 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4A8E9525;
        Wed, 28 Sep 2022 09:51:41 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id x13so1418134qvn.4;
        Wed, 28 Sep 2022 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mbxRn007Ip2c/fdHqU/bp/LXy4PPcd8ySvUFUqzEX6s=;
        b=KDSVQ1oMBKRLgWEH0InLjPc/aLqNu0zJv9KCeb8pdE0nGiSRyuKb+9DE+EiYJnbcj/
         5W1QoMNbFR8fVhpkgXjoUmwOHLLwmX0oCbXvktWasxGC3jQReTgauOcAnmNu6PeNALaT
         UqcmXt9f/k5KyHbejcWPZGCuaX758i59+J3Ih/oqrzRUSd40tW8vWxku8ZEFNkA5tVAf
         LlbTu/3PjEkZlVfhoqC/toTBWPSvXO4D+eLotlQz+TXjWh/O8HKOj+XbHQ6/PsZ7mkeh
         kbW1JxtOwjFtbNfwAa5yVKWxeFkEXKz56IXX77UAuUH5jPopvluRUhwSGTqgneWCsw8d
         ug9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mbxRn007Ip2c/fdHqU/bp/LXy4PPcd8ySvUFUqzEX6s=;
        b=NQ8k83/U315P7XE81G6UFgRmRMaxTWtR6TUYfEZt08N8//8Tts80K0FGya5KSakk5c
         16ha7Qyg9+TGoqWfrKUnhHWEqtTkE+Pil3DL4InbWSpyree5fFZDAv4WSkJphSDqoG2m
         ppsyMHUBW2Vr68AMKkYNeIOfoHwMp7klX/SFlekFlOQsFh9pP2+RgHrWBkXtrNgbn1yw
         RSFlblpVgCtbG+V9T1444h4Vm9W3uNnZzqd9a3fvqWq7E/Nswj4VpzoBhRoyaSkwRTjC
         wuSnUFW3GsNebvkbIuzSh+0nzUsrQgRymHovwKKLIxOynS9GWAlrYcDBZm8STOsMu10+
         seNA==
X-Gm-Message-State: ACrzQf01/Bbx8QJs5KepS5+Di+rOlSMn27zA/p/imKYDHo9jwoiAKV5I
        43+jL527ePER1CSuEHLGeDALaBM94REvof6K49cIor6R8EQ=
X-Google-Smtp-Source: AMsMyM7wXSmHKlE03PtWvNbyVtg+Z/ygdLMTLfA2/MG8cnEF6SrXoChIYY1ksHA/b/6JHXHhXq/pPCj/E7DaDVv2w6I=
X-Received: by 2002:a05:6214:c63:b0:4ad:6b45:8235 with SMTP id
 t3-20020a0562140c6300b004ad6b458235mr26846114qvj.48.1664383900664; Wed, 28
 Sep 2022 09:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220928164114.48339-1-olivier.moysan@foss.st.com> <20220928164114.48339-2-olivier.moysan@foss.st.com>
In-Reply-To: <20220928164114.48339-2-olivier.moysan@foss.st.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Sep 2022 19:51:04 +0300
Message-ID: <CAHp75Vf1rJRVK5Emuwk4863DTb9JjTswJefJM-1oX+2gQvLMRg@mail.gmail.com>
Subject: Re: [PATCH 1/8] iio: adc: stm32-adc: fix channel sampling time init
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        nuno.sa@analog.com, Paul Cercueil <paul@crapouillou.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Yannick Brosseau <yannick.brosseau@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
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

On Wed, Sep 28, 2022 at 7:42 PM Olivier Moysan
<olivier.moysan@foss.st.com> wrote:
>
> Fix channel init for ADC generic channel bindings.
> In generic channel initialization, stm32_adc_smpr_init() is called
> to initialize channel sampling time. The "st,min-sample-time-ns"
> property is an optional property. If it is not defined,
> stm32_adc_smpr_init() is currently skipped. However stm32_adc_smpr_init()
> must always be called, to force a minimum sampling time for
> the internal channels, as the minimum sampling time is known.
> Make stm32_adc_smpr_init() call unconditional.

What is the text width here? It's okay to use Up to ~72 (or slightly
more) as a limit and format accordingly.

> Fixes: 796e5d0b1e9b ("iio: adc: stm32-adc: use generic binding for sample-time")
>
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

Tag blocks mustn't have the blank lines.

-- 
With Best Regards,
Andy Shevchenko
