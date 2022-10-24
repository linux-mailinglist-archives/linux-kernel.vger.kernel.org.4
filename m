Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F9B609C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiJXILK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiJXILI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:11:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3F83B454
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:11:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v27so5938518eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F0c713oCt9k4k6/+uY2uM123jIigsSx0BNjtESa37L8=;
        b=fM18OWIp12aMWehgSQYFRFmpa7L+2WOuR3JJPfsWwM8qbqkMEJASujJMMEo4p0/H5C
         Ju0vOpraZuqjINV7dUKIKl+o9UPdCzUKzPxVirGwJSXn7srJgyPVYAV93i0tQWv8ohaL
         6qGtw3QZkaKJvVPe/26GQPuUFgpK4HZhb4PqGxrT4j2DG7426bTgIeRPPlc/0Lmibxb0
         VnuU8MlzCM9+Im/VEDOdGvYOzMdK+d63Q/CFvBdzHM4oqBXugTjv8Y4n3KDbNLY2ywoF
         3PhFO/Y9RNzxDD8lO0fFscdEnUzQCkpDK4QcrfBn4DawxCE0EApN9ZV6z6w60Yg9vMlV
         eKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0c713oCt9k4k6/+uY2uM123jIigsSx0BNjtESa37L8=;
        b=fWvt8Q5nIrP5hg8S7+CRlpUasBxg29wxVQVVO9hueKhdhYbX6lHLskhzeSUHxQ6Uci
         WaDccdJUxgGgwwBf2jtDPlj/Ea2U+u3SpgHmBWG+6Y6kIOYZ3CKk1wbGKx5lzq2vymw2
         bnkV3OuKq+rTZ3NDiSvlz+8h143MKY3mlfm7BmvtcvoYWjGPnrdvF8CDHlo+STCX5bKT
         97lrsuV4XJ6DeESzLXyTcLwIgQ1VgwftXquB/ghz741zxBjqpexw6Om08/LadFEfxwcD
         00/f8uNknH7bgNDyBvdyGfG8rLH63pn4MNRy4AXBe4Uti/sZAHIkHf8NUxFqZFvCChFk
         jWEw==
X-Gm-Message-State: ACrzQf1XbU8wfukvu9wAYT5xgAg7dGzUoUlzt5EXWRfGjtss4II9G24+
        FCjs5zKkvXoxfBSSe5DRL3Kos1VvwlUnmAV5zYeO0g==
X-Google-Smtp-Source: AMsMyM4Do78psp3kB2kgopIMTwbjzFM6ZbxCwerNjX0u3iCmgE06NkkT74Ndn4Y4JMEeUX4twWV0BterbnP1x5GKtQg=
X-Received: by 2002:a17:906:7193:b0:78d:b87e:6aa5 with SMTP id
 h19-20020a170906719300b0078db87e6aa5mr26617842ejk.580.1666599065645; Mon, 24
 Oct 2022 01:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221013110411.1674359-1-treapking@chromium.org>
In-Reply-To: <20221013110411.1674359-1-treapking@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 24 Oct 2022 10:10:54 +0200
Message-ID: <CAG3jFyv_-5rg2youVtKg7WGvvc5PMqaJMCmidMwmXf6Sgucm3g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Clean up it6505 driver and improve synchronization
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Allen Chen <allen.chen@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 at 13:04, Pin-yen Lin <treapking@chromium.org> wrote:
>
> The main purpose of this series is to improve the synchronizations of
> it6505 driver. The first two patches are required for the third one, but
> they alone can be clean ups to the driver.
>
> Changes in v2:
> - Remove redundant spaces in it6505_detect
> - Read sink count in it6505_irq_hpd
> - Add the empty line back
>
> Pin-yen Lin (3):
>   drm/bridge: it6505: Initialize AUX channel in it6505_i2c_probe
>   drm/bridge: it6505: Setup links in it6505_irq_hpd
>   drm/bridge: it6505: Improve synchronization between extcon subsystem
>
>  drivers/gpu/drm/bridge/ite-it6505.c | 106 +++++++++++++---------------
>  1 file changed, 51 insertions(+), 55 deletions(-)
>
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>

Applied to drm-misc-next.
