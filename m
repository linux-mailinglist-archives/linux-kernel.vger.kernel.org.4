Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9002D5BC2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 07:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiISF6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 01:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiISF6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 01:58:48 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0732214D0F;
        Sun, 18 Sep 2022 22:58:46 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id w8so45233949lft.12;
        Sun, 18 Sep 2022 22:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ni02zw4irR7547wvk8ueICRHE7W6ZrXNiuACEEPrD9w=;
        b=RfKsAyYU/tXl0cY5pUB14f2kRYHTJ8MKNajNVaT5gJWej1ukhUhjmxWeQziY0upxLJ
         Fe8jiKQJyKMp9mZ7Xm3CcZgXBjvzSPyt6PVSxKFxOeyR7ZXaZiHZhw2bXu3DGkcHcf9K
         xnP30f39cq+V6M8tiwWswPhTYCtATe4vZa7SZVm5yncaUbuGqedY7W40cMoURUmdjnX7
         w13Kn6SLyWfMq85pW+/D7vkbZXt5GLala3yu9JJ/Yg6PvqFWjvjeoJ6tqZFTG84dTuaS
         9f04twogCMglgMTVNLhPTpobdkmWmpAJLi7N2lt0iNYxfOJxIk00Z5wSYs7fjBV5aCfF
         w8uw==
X-Gm-Message-State: ACrzQf04el+cd+/5EbGTGzrQQ2TurPfdcnL/Mhyewb28oSZxmWgcXL90
        pRAPdzMmTrixenQSXcoz89EjzdHkP/mjWm0e
X-Google-Smtp-Source: AMsMyM4b6hO0q1BA4gr2BUdFxFV8w5MekpEo+ZipfzaVkhynQA0y7FA+9O3clhvi9QOzWkeRYcLslQ==
X-Received: by 2002:a05:6512:3e23:b0:498:fbf1:c480 with SMTP id i35-20020a0565123e2300b00498fbf1c480mr6092633lfv.473.1663567124204;
        Sun, 18 Sep 2022 22:58:44 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id be33-20020a05651c172100b0026c12b9b329sm3866008ljb.70.2022.09.18.22.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 22:58:43 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id f9so44524796lfr.3;
        Sun, 18 Sep 2022 22:58:42 -0700 (PDT)
X-Received: by 2002:a05:6512:3b0b:b0:49a:d44b:428 with SMTP id
 f11-20020a0565123b0b00b0049ad44b0428mr6045590lfv.0.1663567122742; Sun, 18 Sep
 2022 22:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220918140829.443722-1-git@vladimir.panteleev.md> <aabb7c21-9a80-696e-6a38-29de57e025ba@roeck-us.net>
In-Reply-To: <aabb7c21-9a80-696e-6a38-29de57e025ba@roeck-us.net>
From:   Vladimir Panteleev <git@vladimir.panteleev.md>
Date:   Mon, 19 Sep 2022 05:58:26 +0000
X-Gmail-Original-Message-ID: <CAHhfkvw_U_uF1UFcLTBUsw=_YoM_7pi3tw3KCovTT6PZTnH0ig@mail.gmail.com>
Message-ID: <CAHhfkvw_U_uF1UFcLTBUsw=_YoM_7pi3tw3KCovTT6PZTnH0ig@mail.gmail.com>
Subject: Re: [PATCH] watchdog: sp5100_tco: Add "action" module parameter
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sept 2022 at 04:17, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 9/18/22 07:08, Vladimir Panteleev wrote:
> > +MODULE_PARM_DESC(action, "Action taken when watchdog expires, 0 to reset, 1 to poweroff (default="
> > +              __MODULE_STRING(WATCHDOG_ACTION) ")");
> > +
>
> Other module parameters are not visible. I do not see the benefit of
> having this one visible.

My bad

> > -#define SP5100_WDT_ACTION_RESET              BIT(2)
> > +#define SP5100_WDT_ACTION            BIT(2)
>
> I do not see the point of renaming this define.

The bit is just called "action" ("WatchDogAction") in the technical
documentation. I figure that the original author chose to name the
define "ACTION_RESET" instead of just "ACTION" because the original
implementation only ever cleared this bit, therefore only setting the
action to "reset". Now that this is no longer true, calling it simply
"action" to match the spec seemed more appropriate. What do you think?

Thanks!
- Vladimir
