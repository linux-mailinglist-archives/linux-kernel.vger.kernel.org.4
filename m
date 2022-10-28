Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B95A61148E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiJ1O2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJ1O1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:27:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE283C8DE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:27:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so6742398wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8uTjmTgDl9cTXcnHuhRfW69h3WUIxNN9Nt33f9aCM0=;
        b=D/SpFYlC8Zu22pLXMx8S5Hjj44Wb2SrY8FW39yaXE1r0q/velZ4e8giEx9PDdqWUHu
         4uQRJapO6PZLUizXWzsyCPzfCLF5zLMIxy0Bl/7XQfEjf3XhX7nHekgo6pSbND287SaI
         qKt5gONOcCup05S2AcNwRBz0Vb+LHcuqV16Cfzm/HBuKiSlh/7b2nI5mDBfiRYkeXKJk
         BzSq6aWfsnu0F5nfS8jHbe/nCIJn2CsxKPMf2ygBVrVSdhHXRPlvjVmuUZbpFRzim5Ho
         yqUhVwPkGJDWy0dmeXet9add0Dd+iZ46MnpY9qZf/VYVCicSlsGQBdeO56Uh8SOszlrJ
         G9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8uTjmTgDl9cTXcnHuhRfW69h3WUIxNN9Nt33f9aCM0=;
        b=jzGeQ7NAw1PgIic0wxhHJn95QSZbeWVnwuBVTKwFarDOv3mCnjudPne5QKknICvpMv
         9OqbbTahhktbbMMSr8W6DLkFe2MVSufSF2oxlH5NBASREaQ74UNPkH1/IFKHXeO9P770
         ORlE8ukttaaE7RRnygyFW4xbLMZJWVjsw75DsLKb3rj6VQHrzmW6UB+0YU2bVQPAP0rG
         rHgg0lpiS7Yjnkhpbr/RpCr33oI39BlJaXdE5ugk5tmgp77gMn4kPa4muBuGiB1P3Wsi
         2SFQ7lZB+QA0omqNB+Y9L+MLYIYBqUDuRSvK92GDMdWyIxhNfBdPQ6cozEHgT6a30tq+
         ILSw==
X-Gm-Message-State: ACrzQf06ohlDPHOe5smeutzQwFST1mKRCQb9qVsaWyxj1wr1x1d0cCUD
        YB6kebhokxIsz2xicxpuymFGTA==
X-Google-Smtp-Source: AMsMyM4Vqq56LjT96b5RxTO8K2G/AAPSN5OZztLKI98rBQ3IhiMBcvfgKfMgJw5xI/SJ8ZMEhDThYg==
X-Received: by 2002:a05:600c:3b1d:b0:3c6:ff0d:6a60 with SMTP id m29-20020a05600c3b1d00b003c6ff0d6a60mr9712623wms.183.1666967260275;
        Fri, 28 Oct 2022 07:27:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b003c6c76b43a1sm4179717wmc.13.2022.10.28.07.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 07:27:39 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kernel@pengutronix.de
In-Reply-To: <20221026125246.3188260-1-a.fatoum@pengutronix.de>
References: <20221026125246.3188260-1-a.fatoum@pengutronix.de>
Subject: Re: [PATCH v2] drm: bridge: adv7511: use dev_err_probe in probe function
Message-Id: <166696725937.855825.511703215271737930.b4-ty@linaro.org>
Date:   Fri, 28 Oct 2022 16:27:39 +0200
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

On Wed, 26 Oct 2022 14:52:46 +0200, Ahmad Fatoum wrote:
> adv7511 probe may need to be attempted multiple times before no
> -EPROBE_DEFER is returned. Currently, every such probe results in
> an error message:
> 
> [    4.534229] adv7511 1-003d: failed to find dsi host
> [    4.580288] adv7511 1-003d: failed to find dsi host
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm: bridge: adv7511: use dev_err_probe in probe function
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=2a865248399a13bb2b2bcc50297069a7521de258

-- 
Neil
