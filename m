Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10445F7EA0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiJGUXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJGUXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:23:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F400D9AFF5;
        Fri,  7 Oct 2022 13:23:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so4903515wmr.1;
        Fri, 07 Oct 2022 13:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N4kEDyMI5UqC9ruVvmCcki1BdeOTW3NtjCIMHC3n+Jg=;
        b=Dtu4pTRs03tYHwEXfWsls4vcDbX2kF2YLFQXzp9UFGWcai2XfQqci6d2tNVUZwl6xD
         azA5HQvB+G8u/RfN8kPHfH6y0VlDklPDTd4eVCeCqu/1kK6x6t1I6B9fKYdZO8HvihxR
         kQ8Zf6QiW4TsoAElwkpr2S/FdZNX65olf6ULu3i5dK9t4qC9nOXwdPKHa77xQHEq1lWy
         CI5qr8Bau4z0eFh16/8zNPKf96etRbqvHGTkhCy0aPAs8cGDaa3Dk0ZhP6Bp/sbFZAdn
         lyasOa/K6eVTa8X0UIcQvr/J7w2rvEC1VJnNuaz+VHLj5pqVVITI3PdPBxKDsivUWJmH
         pLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4kEDyMI5UqC9ruVvmCcki1BdeOTW3NtjCIMHC3n+Jg=;
        b=LWNCZhpBnS08LACkwCGcfb19tzsWE55fUgyW8/qNpLMXVoMkxfMG21oyZwpl2NIHbg
         WELlerFsofRdETzUl+NWkXGStAQljyvFou9NeE0b9mLTGEFe2lgnGPsRJjpzzzjpQyhp
         Iq+ZS7P8iGg2jl4jBT62TtH7BIiorfiEfOlaSYzWu2Zzs054hxkmKYMN/PWVySq/1IBS
         8SpfI1hpn0ek9ufQkSM3Lrk3I6pVt0k0cYO+2hD+sLLHaPr8icR8N34C7VjyzN/ufpE/
         wiYLt8tM2S2YL9lhzlccY5FggO5oOa9QzkGGmqTSRQs1ck/yTc8pRW+UB70KMmYzfm2L
         Cylw==
X-Gm-Message-State: ACrzQf1eQ/XOXj/KHNco12xMwetOKf3Zb0gY6TX6Xho5xraKs6qXykS+
        TiPwTBLn3/7Dx8MXl98GmMA=
X-Google-Smtp-Source: AMsMyM7FOf1VWcxEIUUoCJsxtPAhOvtPxcgbzPEoWCDXoB8cgyQj/iZHvPe5+m/QMYSmDjAAGCIoog==
X-Received: by 2002:a05:600c:229a:b0:3c0:130d:320d with SMTP id 26-20020a05600c229a00b003c0130d320dmr9394670wmf.51.1665174219391;
        Fri, 07 Oct 2022 13:23:39 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000008700b00228daaa84aesm2843561wrx.25.2022.10.07.13.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 13:23:38 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: Kconfig: Fix spelling mistake "throught" -> "through"
Date:   Fri,  7 Oct 2022 21:23:38 +0100
Message-Id: <20221007202338.2755731-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a Kconfig description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/msm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 4e0cbd682725..3c9dfdb0b328 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -155,7 +155,7 @@ config DRM_MSM_HDMI
 	  Compile in support for the HDMI output MSM DRM driver. It can
 	  be a primary or a secondary display on device. Note that this is used
 	  only for the direct HDMI output. If the device outputs HDMI data
-	  throught some kind of DSI-to-HDMI bridge, this option can be disabled.
+	  through some kind of DSI-to-HDMI bridge, this option can be disabled.
 
 config DRM_MSM_HDMI_HDCP
 	bool "Enable HDMI HDCP support in MSM DRM driver"
-- 
2.37.3

