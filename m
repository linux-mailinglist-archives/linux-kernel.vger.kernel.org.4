Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176FD6CA097
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjC0Jzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjC0JzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:55:25 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11754C2E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:55:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d17so8046173wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679910918;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIHP0oW2lg3pGPju/AqnuKxyIsHSSY/Z0nA6zc4eppc=;
        b=V9vLGJETFgVtCugeotELemVVEydjS4hd7yKWCs3ojx/qptfh/w3WJKNI3Wdl+ovCyJ
         ZB+EkW2XXQtJcjAI91g+HUq+J60M7yiQe9f8yiv7da0brdVBa4gdAoPtB1RPNNJd6kIw
         drMQ+IKURDAckY5Bo7rFc8vUq7joctFMR7l6Q8+yqPlzcBf2RULCva3334UqMJ8WXuVz
         50FkRDLvgtYKR0sceLvSlCa2OBaQyFc0W4NB3vAe4cOM5aprom42lcjmrxSnBNsXlygB
         bfFNfIQUEx8CMbOdjXBekWKeNOlujZDdKpm8apg0CBksa66nJJssg0h3/k/xtRS16qd+
         dv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679910918;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIHP0oW2lg3pGPju/AqnuKxyIsHSSY/Z0nA6zc4eppc=;
        b=J0uVaugrkaMRKskhvSF/R3G0vpMQsO53boRvJjwHDQ8M215gRznrLLaykr5PIkE9cV
         ByMFJ0e/tqmmp2KPR0kDsdoxFPIQaDf+ncLP4wiYS6cO6/ggGFrfzB5sgiPpKHKzw+xp
         Dhd7gXwjM3dzCEqvt699Y6F62zJCt9PBvC8o+yPCh8h9eCO0s1CRCqdodiaz+AF5EXhA
         v+0vznS6T6y8t0unuiAaXfnybOH5bf21w9iNDy03VS/0OOO7FGovlx9xoPrdyPvYFI7d
         2k389az4gkc4Dinf7EcpRJwdtSRRAjd1fxWpAcDadTMlaoO6RQ6u/7x0wb5+GTS0srMN
         sTDQ==
X-Gm-Message-State: AAQBX9c/7FJxOLe0ywZbJ91QlZpE41oQJzD9R5HgHmFKV4XP6LZig2b/
        MzzT4YbOQAaFP2+QbEq3IIsbzQ==
X-Google-Smtp-Source: AKy350bzh0+0wXuQx3da6/OOn6R3Fa9WVL4Lm3349lo5eHuojuEVC20BzSmdBT4O+sIdKypDH4aaUQ==
X-Received: by 2002:adf:fe03:0:b0:2d7:c9d1:65eb with SMTP id n3-20020adffe03000000b002d7c9d165ebmr7756235wrr.36.1679910918510;
        Mon, 27 Mar 2023 02:55:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id b13-20020adff90d000000b002c54c92e125sm24684308wrr.46.2023.03.27.02.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 02:55:18 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Robert Foss <rfoss@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kenneth.hung@ite.corp-partner.google.com,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
In-Reply-To: <20230327044804.3657551-1-hsinyi@chromium.org>
References: <20230327044804.3657551-1-hsinyi@chromium.org>
Subject: Re: [PATCH] drm/bridge: it6505: Add range and selector_reg
Message-Id: <167991091749.404707.7868239484319275542.b4-ty@linaro.org>
Date:   Mon, 27 Mar 2023 11:55:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 27 Mar 2023 12:48:05 +0800, Hsin-Yi Wang wrote:
> There are 2 banks on it6505, and when writing to different bank,
> REG_BANK_SEL needs to be set to the targeted bank. The current code set
> this additionally, which causes a race condition when a process is
> writing bank 0 registers while another process set the bank to 1. Set
> ranges in regmap config so the regmap API would handle the bank changes.
> 
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: it6505: Add range and selector_reg
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=1a2dbf0303e8793444a57a2eec0c6b29523657d9

-- 
Neil

