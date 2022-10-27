Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF960F679
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbiJ0LsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiJ0LsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:48:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADB55851F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:48:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bp11so1718359wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R42RojmRq4zRc2qoWo071bNzbgLKUBvyZz6AeJFc7EU=;
        b=wBunsa6VUQ0hJ5y0LmUYP6d+PBiC5O2xuJ2H6K0dQS8BmCLaCNDUfCmNCfJgF2y4Jt
         3f4DqIWhRIQ5oNVHNjxtpRd93D87SybKiZUEZBNlDBJTkxKDJloEUEUkwxoscwRHLlPS
         oalspQgNVXJlOSQ1F2pOoc6GqzfGUI2dlLBNAdY2ZN+tYPbfq4xTS5QCGYDo6J1pU9ha
         surevtxCRRsIUEa2tbNLA8lWl2pZUc8aiqPiGB9LmR2F8sAd2IZcJPiyd7zfvBsa6NLU
         uV3/8vu5rG6E7d95NoGM1ZXP0DUNVQ724i48YARqttPT4rFgjmt3dm5Hk/Y1ay9YCHtk
         rjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R42RojmRq4zRc2qoWo071bNzbgLKUBvyZz6AeJFc7EU=;
        b=sOiOALz/XYsBBmHX9w++s8lijVjex5+1QCSWJF+uf5eQt6NIXG5d+7cuefOfVFMuDp
         0Dw4lYY/xPUKvWcSSwVEeF/9tU/lhI6n3bG3viX3qETkEOJDVcJgy1+lA5BRTJTe3hX3
         BRmO2VCdRMV8oq4y6HAyQLJmJwg9sKY6+mc8pBCrws6CC0Ayb5FPaqFUnk6PD+eH0NSx
         eayB2IYdpEqM5aBtfblUvWPl5xiyYh5SFFnRmHcx7k5z7tlHy5fIStHk3NpEPif5jTpO
         DRyf044RFyA2OEZAvavW9SnC1oaSbGlZ+A6BV7G7rL1Ne5gfCfvPE34/Fa3R99DJhRn0
         6KjQ==
X-Gm-Message-State: ACrzQf3/hljk9AjVb+REckRBCGWYL/k/zj3hCPxOxW+2VDreV7kwQqwW
        x66L3EQ+tmT9aJIctxooddzuLQ==
X-Google-Smtp-Source: AMsMyM44o5az+ftHI1eUglivxRIwCzyx+vdVtkBbLWHRpfg4EtEfocLMTKpLwOLTgeoa+mzvwNPYIw==
X-Received: by 2002:a5d:52cd:0:b0:236:57d0:8245 with SMTP id r13-20020a5d52cd000000b0023657d08245mr19746347wrv.152.1666871293206;
        Thu, 27 Oct 2022 04:48:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b003c6f8d30e40sm4965699wmq.31.2022.10.27.04.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 04:48:12 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Pin-yen Lin <treapking@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Robert Foss <robert.foss@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221027032149.2739912-1-treapking@chromium.org>
References: <20221027032149.2739912-1-treapking@chromium.org>
Subject: Re: [PATCH] drm/bridge: it6505: Fix return value check for pm_runtime_get_sync
Message-Id: <166687129194.255790.5379007139658764602.b4-ty@linaro.org>
Date:   Thu, 27 Oct 2022 13:48:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Oct 2022 11:21:49 +0800, Pin-yen Lin wrote:
> `pm_runtime_get_sync` may return 1 on success. Fix the `if` statement
> here to make the code less confusing, even though additional calls to
> `it6505_poweron` doesn't break anything when it's already powered.
> 
> This was reported by Dan Carpenter <dan.carpenter@oracle.com> in
> https://lore.kernel.org/all/Y1fMCs6VnxbDcB41@kili/
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: it6505: Fix return value check for pm_runtime_get_sync
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3e4a21a29dd924995f1135cd50e8b7e0d023729c

-- 
Neil
