Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092AE7120CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbjEZHWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjEZHWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:22:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF55F9B
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:22:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30aa1eb95a0so322272f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685085733; x=1687677733;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4R8gq4VV9FH7vEiMGGKmwIH253z5jV5ue8L2RgLn9w=;
        b=ydqGwHwpA29vslczQHBZDgtmWGPCzgojPE1SKs+AT+Cku2M5Xiwvfq1P02PbVG4nTX
         LbAbKiD2R6uz+URZlcyKqwFisrCWrHKgAzVrpuiAiQuA9Tk62QjO4WWquYkiOArV8e8G
         uVg3Dc9MpMNp+Afvl+e+5kH8i05zgB355Ph+yRlZSmRbAwvqupMBGGJv/dpMPQJ6g/HV
         qGufaqUlHDomcBdQturnisi/kfLQwbGV1GZHYy5BTbz6laG8yDoJz+lJh4/yFdYZbqUH
         DxpvrUkYnHEYQO16QesjVJzwu8S+pJO37WlbJorJoW/43Suj1vf7Ev+sKayw3JGkv8l/
         NKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685085733; x=1687677733;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4R8gq4VV9FH7vEiMGGKmwIH253z5jV5ue8L2RgLn9w=;
        b=DHC0TKpsweS8xWOBhg/bnJ2jfMuHnmAz4Y9tFblzq2Y4R2RlUFnkP54gBl9n0/EnYS
         9Xsj9q4NuACSQojYSsCkGCBrt5onWJAzy1rZvGDf3UiDUJFThh7TVJsMIj2vdsgdaBRX
         16Woagri6nzIIuI6VTTZ1xEzQuqx1BvQ2JRZ36XGbbFv33HWt+PFPjV9dG+H3m3Ss49f
         7IjYZMwE/sSbkajjIzK8MTshMKXXvU5RhHZUJF8+u3pG3Rt9G9lUoLsK/y3dXV1yMJbs
         36TpCadpJw31qjvnOfkXnEZG8grW+ePP5BY39+NsD+KUg1fEBLvwwsAs396rbQowI46p
         HYLg==
X-Gm-Message-State: AC+VfDztNg6l+QkG8/ustGAcmxVauSgATk6ch2ULVVpYxj9wG3fRTGeE
        nEudEX7JjR4eXysgAJNaKy7W2nDPXh1oU/+Z2ESIaA==
X-Google-Smtp-Source: ACHHUZ67r+CPazD5B3hbLYQQG45/vUi5DI/DCFLbpAsyxlkY5IOAPh4kl1wSTYJpIFlNJzN3AJ0n1Q==
X-Received: by 2002:adf:e30c:0:b0:306:45ff:b527 with SMTP id b12-20020adfe30c000000b0030645ffb527mr612405wrj.45.1685085733323;
        Fri, 26 May 2023 00:22:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r6-20020adff706000000b0030903371ef9sm4115935wrp.22.2023.05.26.00.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 00:22:12 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org, Adam Ford <aford173@gmail.com>
Cc:     aford@beaconembedded.com, Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230518230626.404068-1-aford173@gmail.com>
References: <20230518230626.404068-1-aford173@gmail.com>
Subject: Re: [PATCH V7 0/6] drm: bridge: samsung-dsim: Support variable
 clocking
Message-Id: <168508573242.1449766.4668062755722232780.b4-ty@linaro.org>
Date:   Fri, 26 May 2023 09:22:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 18 May 2023 18:06:20 -0500, Adam Ford wrote:
> This series fixes the blanking pack size and the PMS calculation.  It then
> adds support to allows the DSIM to dynamically DPHY clocks, and support
> non-burst mode while allowing the removal of the hard-coded clock values
> for the PLL for imx8m mini/nano/plus, and it allows the removal of the
> burst-clock device tree entry when burst-mode isn't supported by connected
> devices like an HDMI brige.  In that event, the HS clock is set to the
> value requested by the bridge chip.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/6] drm: bridge: samsung-dsim: fix blanking packet size calculation
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=a617b33f7e513f25becf843bc97f8f1658c16337
[2/6] drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=54f1a83c72250b182fa7722b0c5f6eb5e769598d
[3/6] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=33d8d14c83bf67aa0d262961a6fda9c40f3c1052
[4/6] drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=171b3b1e0f8b8c894f2388e1cf765a56f831ee5e
[5/6] drm: bridge: samsung-dsim: Dynamically configure DPHY timing
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=89691775f5735fca9dc40e119edcbb52a25b9612
[6/6] drm: bridge: samsung-dsim: Support non-burst mode
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=bb0e13b9e223b218c9f242f8d340a332b4381042

-- 
Neil

