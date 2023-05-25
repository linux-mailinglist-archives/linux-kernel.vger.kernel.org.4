Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B7A7110C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjEYQTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239134AbjEYQTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:19:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B21D19A
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:19:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30a8c4afa46so929705f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685031574; x=1687623574;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J792pmgwZYjCthCbVbD0XbMQjnsrFglVru1pdmfLzCs=;
        b=zJAsS/yh7QWEW5Nc0yeCDj0yjn88zziqdrmms8/5ht+HLhZCa3LXSoJh+HetSO87wk
         wjOgV1oiSKCn2rHkKMca8x94TRZNtnnJGdd1ZoSfKgSAYZqCLsBo0UjW13yB0QiSjRuZ
         Q4Si9CsLTDWaXAXG8I+7HKCHzyV/TVRnKcVXTN1f5Mj5sa5MP4CwzZe63mN3Daw21W4s
         nfslYByXyhkI1aISyl/Pvb8OohDYQWga6urfL9PN1uXWW6acHH8CSo9V1wI31nFoKP0I
         UWoHeTx4KM9zwen7bk0UubUE6FQZlSaZiKemJQpZL5LUCVdHBn0AT11vAFLA4a3ZOS2j
         nPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685031574; x=1687623574;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J792pmgwZYjCthCbVbD0XbMQjnsrFglVru1pdmfLzCs=;
        b=Gg/9kca/d72Dc3nf+i8Mfb5lxqzCRzqpU7eT35La7DxpNxhmqnLxQdYcctOxf2Zw9g
         juXF/ETVRbMjqwhzMxYnFYdRPkGy+EG/8dFiw2lBPo5FtbB7ZbMMKJFobnKEgPH8YN74
         ctpCJpHSmFzqgAWgYufCX7PHkovVoT5AtoH4yBB4d96KTc2Sy57EHSjWxHfKsLpG0zSe
         mNEywc+9LD2TY2+U7ivgTn59IC5ff+MUutpqhtQgqV1VjNFMToV4pUwYkMQnDcaY1CcX
         UDR+qacWoPGw/MvcybgNhMmYigQKs60m0Bi/PrJxjz2IxVw4WmzmsRZ5B5XaiiSzr6j+
         RmTg==
X-Gm-Message-State: AC+VfDw2LnW6KczkhC7DvVnDuArbESY01RkWvTanv87hH8NQURQmzyPM
        MRJJW4BFDonHV9oxf9VevTv5pw==
X-Google-Smtp-Source: ACHHUZ6FgPqiKtydERzxbHFcz2iQJVXJ4vGXA/l6lHkTNlloCfY1UYgInQomL7PkcTwGpfIwykQFyw==
X-Received: by 2002:adf:fb09:0:b0:30a:c681:fd2e with SMTP id c9-20020adffb09000000b0030ac681fd2emr1256379wrr.22.1685031574023;
        Thu, 25 May 2023 09:19:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e7-20020a056000194700b00307bc4e39e5sm2240017wry.117.2023.05.25.09.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 09:19:33 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robert Foss <rfoss@kernel.org>,
        Frieder Schrempf <frieder@fris.de>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>, Sam Ravnborg <sam@ravnborg.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
In-Reply-To: <20230503163313.2640898-1-frieder@fris.de>
References: <20230503163313.2640898-1-frieder@fris.de>
Subject: Re: [PATCH v2 0/2] Init flow fixes for Samsung DSIM and TI
 SN65DSI84
Message-Id: <168503157303.1160623.697502626208861584.b4-ty@linaro.org>
Date:   Thu, 25 May 2023 18:19:33 +0200
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

On Wed, 03 May 2023 18:33:05 +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This patchset contains a proposal to fix the initialization flow for
> the display pipeline used on our i.MX8MM Kontron boards:
> 
>   i.MX8MM LCDIF -> i.MX8MM DSIM -> TI SN65DSI84 -> 7" LVDS Panel
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/2] drm: bridge: samsung-dsim: Fix i.MX8M enable flow to meet spec
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0c14d3130654fe459fca3067d2d4317fc607bc71
[2/2] drm/bridge: ti-sn65dsi83: Fix enable/disable flow to meet spec
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=dd9e329af7236e34c566d3705ea32a63069b9b13

-- 
Neil

