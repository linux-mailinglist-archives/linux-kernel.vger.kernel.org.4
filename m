Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC8D5B9AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiIOMjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIOMix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:38:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87BB80498
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:38:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c11so30661830wrp.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cF5Zvj+Kzci/ADALngKgDuePH0r1ubNxIDC6FLO5nXI=;
        b=xRntcD65ImZt0Qvcy5pgORY8i31L4sVZXe4AvYM+9j8OpHdQxrbHMOiDRsipUHWcCd
         l5AhGGwxRmY+PMQ9DE8rpupkzkthHuG83aHtPMhws4f4NK/xi5uMFP5XOoKW3DFoLC8f
         kz//kloxDtoXlbLKruVBhpBrOJ/0is+k0tZMz6kH2JfWaPWy3awtygdjC+J1Mk5PNpdm
         uxFOVftD1ukCEMga7GQc2mQ1u39oOCHPSCe2O9L/4vvacTP/+ma2gRwko/OzE+TkBscy
         gcOOeMdO1eCw+/p85RqzmwAo3uJB4qwBShSGAW58mIB6Qc8OcqZ7N8NND00Ty9i/Pec8
         /uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cF5Zvj+Kzci/ADALngKgDuePH0r1ubNxIDC6FLO5nXI=;
        b=ywYOzCq1XfGO7iUHWUkja5xoSwqih3q++NQv/b4PY2XgGAc1Z6y8VlQj1CWmD0X+B1
         F0SjwW6ZlbryJPqzVL/Qw4c85L1wgRmLrI4QRuyF+JVE2ge11WX6XgzD2WIwm9PJJazh
         qYOBP0Z7u8reg+NL/jmPa96X2xUNUxeNHmoW6EpF0+G9lRfNQySIGP84d3owOgNoJytN
         assQukGsa1LU6V3EB9UwUnYKQVEoP5xH5XAkV7xeFI8qr6W8Z7ZbcjDkyQNQfQaGWIYz
         6dd/b4Vk/88MWYTRax4+J12pGd9mMNuGeMovM3EfHUdQyQRJlyoKMG0WKGKL0pVsIvEP
         t6Vw==
X-Gm-Message-State: ACgBeo3+RLOQPrxvZXFiatOlc5GYg3dGQKGSJkwFSyUrJQ8zzDzf6rnv
        TIbRV7hz99ZUxoqUGWixzD8pYQ==
X-Google-Smtp-Source: AA6agR6BXpa+AHGkWqlwHEYogbX1by5tJVRtrI+F2Bpc7XdH5DCzlDtGbU/IgmNpyapi98wEYpw7aQ==
X-Received: by 2002:a05:6000:1a8a:b0:22a:43ef:94f0 with SMTP id f10-20020a0560001a8a00b0022a43ef94f0mr17546728wry.279.1663245531516;
        Thu, 15 Sep 2022 05:38:51 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id bg13-20020a05600c3c8d00b003a5f4fccd4asm3112559wmb.35.2022.09.15.05.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:38:50 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/9] ASoC: qdsp6: audioreach: remove unused connection_list
Date:   Thu, 15 Sep 2022 13:38:30 +0100
Message-Id: <20220915123837.11591-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220915123837.11591-1-srinivas.kandagatla@linaro.org>
References: <20220915123837.11591-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused connection_list parameter.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 3ee8bfcd0121..36779ad1952d 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -595,7 +595,6 @@ struct audioreach_graph_info {
 	int id;
 	uint32_t num_sub_graphs;
 	struct list_head sg_list;
-	struct list_head connection_list;
 };
 
 struct audioreach_sub_graph {
-- 
2.21.0

