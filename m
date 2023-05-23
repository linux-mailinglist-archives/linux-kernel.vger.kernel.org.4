Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3C470E0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbjEWPqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237029AbjEWPq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:46:28 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A0F126
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:46:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6042d60b5so26592645e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684856783; x=1687448783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PfRw2ALokx9vLy8rQUgzg1qNBvtdQEE/4htl4GPyFIo=;
        b=nWNoA6Sjt7sar6bT5Wo7aS7Yc7m34FIb/IPgWD81u2XmfxqZy8KlLpQjOWv16/jon5
         r9ollhVW6YH7NfbuUpGGiFI2PoQsBLoeInpaFEAFlbMtNr/hC+EMEAcNhtOpzJEyLd54
         7C+AXOqYLclUAvF/sNsb2Bph/vJoPsj+7wFJnrV9n36DSEjRrJ5DivQ7lCMZJVhG2E+x
         osQRnx+JV6XS7XazzwU6kFsLuDGgV0o3IEblDcwD6iDseVAZKJZb3xcMuuydJ0O53+D/
         1kAnyuwPYstnRQs46f5u26CXhFu20A3z+IeYSdm+azQaZs3NGE6eO/K3Ila8h2n5Gpqw
         TGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684856783; x=1687448783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfRw2ALokx9vLy8rQUgzg1qNBvtdQEE/4htl4GPyFIo=;
        b=D4XUvtloPLKjl2q/JBCf70HeDGaZ+DMeUAGMtyGBHnUeIwTilw2UXjqGGMp1SXjEpo
         v4L4W7+Ls4T0peGpUNutVGQUxPCV2nRtIhIuoFnpdlXuzVTAvs16q6eRmky2Jo/C2xeC
         keiwg3VheIH3z8Cs4HK4JtsRfOM+bFY1iExEB8RYj7560+1xAO0BOLn5a2MO9hkNqAVV
         mBBeQ6cjO20lQQLKSRlyPG22SaAjkA3BY/1TxBLJD5qs5UBlCCEyErml5sOd0xuZuc3Z
         JVVw5oMNqZE4jtagRoBY/oRQK7nXmtELumrSUDiQyaLwo3hyglc5RKDlgBwLCsh0ANTq
         sMrQ==
X-Gm-Message-State: AC+VfDyh29ZCHj0oLyTbk8lFw35WizHBDaY8JJNlX0R9a6PKJQ9vsXI/
        AcPVWl+jBCJ+HNTFn6uqKbVTgg==
X-Google-Smtp-Source: ACHHUZ71Rz/9C0SXOP97Z5WNP/e5538De6w5FC/OjCJcrWWF8rV5viic9V4O3MIuQsYQihYn5e5MXA==
X-Received: by 2002:a1c:e905:0:b0:3f5:fbd0:94ab with SMTP id q5-20020a1ce905000000b003f5fbd094abmr7809138wmc.3.1684856783483;
        Tue, 23 May 2023 08:46:23 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f4-20020a1c6a04000000b003f1978bbcd6sm3374063wmc.3.2023.05.23.08.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 08:46:22 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: codecs: wsa883x: do not set can_multi_write flag
Date:   Tue, 23 May 2023 16:46:04 +0100
Message-Id: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap-sdw does not support multi register writes, so there is
no point in setting this flag. This also leads to incorrect
programming of WSA codecs with regmap_multi_reg_write() call.

This invalid configuration should have been rejected by regmap-sdw.

Fixes: 43b8c7dc85a1 ("ASoC: codecs: add wsa883x amplifier support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index b83b5b0d4bab..2faf66c60703 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -946,7 +946,6 @@ static struct regmap_config wsa883x_regmap_config = {
 	.writeable_reg = wsa883x_writeable_register,
 	.reg_format_endian = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
-	.can_multi_write = true,
 	.use_single_read = true,
 };
 
-- 
2.21.0

