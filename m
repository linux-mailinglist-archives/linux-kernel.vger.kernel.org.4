Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9926DB05C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjDGQOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjDGQOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:14:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE4D11D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 09:14:32 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so43697159pjz.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680884071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=va/SV6E2+ud/jti2qYlNsmAiizf5dXOpYvfXoBKZhWU=;
        b=tmQXIDq93SdrLxctIy/NUHVgpSL3ppxF6Ir29BQVL+Y/2ykQd1PhMENFj/gK1ITS4G
         GQf6+EbQmFyPoESHGoEv5rNkjE6yMGY3Ymaa5FUAlEsGsiulTy8Wlxv1Sc+/6KIiSJoc
         6J36gjmUQyqjS/GRf66ztU9QQ57ZHnf32oMyFfA84vVNVKdY/ciU5Lt/zhn2bIDJpiBM
         /qKZlWuFtx4Ku61jRrS/Aiq4+dSiy10bbzgA6ZfbBNLITeuXw6S+R1VOrW7x2E/dYcSw
         unVoyGLyRhfd5sK2XJdz5nILht8f3XT93DGk+ibup971sApa9/WEpJ8nsyMKo6iRZVg3
         s+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680884071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=va/SV6E2+ud/jti2qYlNsmAiizf5dXOpYvfXoBKZhWU=;
        b=ciPnE83eBSXIQmiQMj/ZzKtP5l+1XsS3Z5cG7GugIa8rBZl2zQjyp8snL9C7loNks+
         yT+FjQhqpPhjUru/9IT6SG9gXrWkWNtoxasWUK+6msdN19loDRbPT4GDk3u4OHzdTSS5
         Ht5A6g/Z+XPYLkJFTdKjUsQy/MrsbMWSaQpqjSelJba3BlVaktxVYuWlj9H6O7/LrVlj
         58pxLFUowUoUmqcqkSvNdF4WkSljB5h7rIEVRr9kzVV4qr2zOMFt1/lc7+1FIn/07+md
         iOgXbrOHBwzACDodLNfYRcbNNzsHqfXRFTZkJOMEyK21Dmiar1lmhLnkWslIc+/c7pST
         aMMg==
X-Gm-Message-State: AAQBX9c6jdQHUmNwVfVEXqTi4GN6EJ2htj5oEOJ2S2+r0aXr+MvU39g1
        y/ZowMXhFP1mnzEWI1hIjVEzDw==
X-Google-Smtp-Source: AKy350atjMY/kis0Ii/ZkRXNjB42cq9O4CbNOs67ggofFXNiFSoQApkLnrEZ46mrdLQ/A52BxMeDrw==
X-Received: by 2002:a17:902:ec8b:b0:1a2:940c:e452 with SMTP id x11-20020a170902ec8b00b001a2940ce452mr2779756plg.9.1680884071643;
        Fri, 07 Apr 2023 09:14:31 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:f97d:e249:15ae:2498])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902ed8b00b001a1ea1d6d65sm3112165plj.272.2023.04.07.09.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:14:31 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     iuliana.prodan@nxp.com, andersson@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: imx_dsp_rproc: Fix kernel test robot sparse warning
Date:   Fri,  7 Apr 2023 10:14:29 -0600
Message-Id: <20230407161429.3973177-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the kernel test robot warning reported here:

https://lore.kernel.org/bpf/642f916b.pPIKZ%2Fl%2F%2Fbw8tvIH%25lkp@intel.com/T/

Fixes: 408ec1ff0caa ("remoteproc: imx_dsp_rproc: Add custom memory copy implementation for i.MX DSP Cores")
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---

Iuliana - please thest this on your side

---
 drivers/remoteproc/imx_dsp_rproc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 21759d9e5b7b..c805cb83cacc 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -750,12 +750,12 @@ static void imx_dsp_rproc_kick(struct rproc *rproc, int vqid)
  * The IRAM is part of the HiFi DSP.
  * According to hw specs only 32-bits writes are allowed.
  */
-static int imx_dsp_rproc_memcpy(void *dest, const void *src, size_t size)
+static int imx_dsp_rproc_memcpy(void *dst, const void *src, size_t size)
 {
+	void __iomem *dest = (void __iomem *)dst;
 	const u8 *src_byte = src;
 	const u32 *source = src;
 	u32 affected_mask;
-	u32 *dst = dest;
 	int i, q, r;
 	u32 tmp;
 
@@ -768,7 +768,7 @@ static int imx_dsp_rproc_memcpy(void *dest, const void *src, size_t size)
 
 	/* copy data in units of 32 bits at a time */
 	for (i = 0; i < q; i++)
-		writel(source[i], &dst[i]);
+		writel(source[i], dest + i * 4);
 
 	if (r) {
 		affected_mask = GENMASK(8 * r, 0);
@@ -799,8 +799,8 @@ static int imx_dsp_rproc_memcpy(void *dest, const void *src, size_t size)
  */
 static int imx_dsp_rproc_memset(void *addr, u8 value, size_t size)
 {
+	void __iomem *tmp_dst = (void __iomem *)addr;
 	u32 tmp_val = value;
-	u32 *tmp_dst = addr;
 	u32 affected_mask;
 	int q, r;
 	u32 tmp;
-- 
2.25.1

