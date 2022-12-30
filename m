Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3396593A8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 01:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbiL3AOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 19:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiL3AOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 19:14:15 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C11313D55
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 16:14:14 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so11800098wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 16:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CyWkmbfdqtlGY0rwiPi83ReuiFdfPg46opu9XRadU/A=;
        b=fx1KlIHvSJVrk+xOsmnVPA/zQYrSCik2VK7jM1MLNetCvtb0PMBJoxnN4K7WaEPHYm
         RmQtIPkhbP7znLcHv+Bx1P3+eLQferowU5K4tmabYE92hVnI6h+JreQYRA1dfMDxa9/V
         ynPmjtCetnrzNAult8OuvHXEyb4Mj61P+dH59JHTDhSt1M10Jto5VFxbVpBelOqy+zEC
         tmevg7STdGd7H8YP7rsvw1PPiXhm3LWy2CQ572VvDffZdUbs2/qwqpkO0N0m3/OjfbL4
         OjZcH8UApH52C35bV8W2kMnL43QqL3DtIX05vNjvJpELrCRuX6Ba0c0GxfO+12HWk8i2
         m6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyWkmbfdqtlGY0rwiPi83ReuiFdfPg46opu9XRadU/A=;
        b=aGj64q5xySfNndsJOfiqtCjWL5WpvCfm6zQ2AWcTa7eIsYFV1a54I6N1Vs99yzf1by
         emUDB0L/AdgIk85wFvqK94B/8c1QoapVAVkdmof8lbbtmFi2h0Nz+ttJ0TTwdqywC60y
         aWXPgigCFrlLRj8lSnTc3aCbgpOmPKng/J+/fU7EEZ8IRTb229QMboD2DUziXED1rAF1
         HnqTiplpISPbdugsCYfk9tWyeQHj6PJwD5nww5dhBx1gPQLQQ/cTenCcJ/5qrrfOvQV7
         dASh8Bcwz+jt+4kAdDTSd0z03Ir0+eXE6LQc6r6Gg64SX+pzCH4iqk5r7siQuqa/ch2D
         YDZw==
X-Gm-Message-State: AFqh2kqW66NAYVg1pPBnXVN2WuDUy8iqN+izWsiYWlMlpEC41oPqMj1t
        ibXvsJk61DCB1aUwCLHH2CTF0Q==
X-Google-Smtp-Source: AMrXdXsCR9WaEyXWhmaMjZSkWwIeN8p6D0UlvvOz5lUl68Pm6PMfgdeoCO0yZz/NixYos/Vf5qDnpA==
X-Received: by 2002:a05:600c:a10:b0:3d2:2904:dfe9 with SMTP id z16-20020a05600c0a1000b003d22904dfe9mr24824442wmp.21.1672359252962;
        Thu, 29 Dec 2022 16:14:12 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:a1a7:f1c1:a2d2:514c])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b003d99a39b846sm5072994wmq.5.2022.12.29.16.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 16:14:12 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     peter.ujfalusi@gmail.com, nm@ti.com, ssantosh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        grygorii.strashko@ti.com, khilman@baylibre.com,
        glaroque@baylibre.com, mkorpershoek@baylibre.com,
        nfrayer@baylibre.com
Subject: [PATCH v2] soc: ti: k3-ringacc: Add try_module_get() to k3_dmaring_request_dual_ring()
Date:   Fri, 30 Dec 2022 01:14:04 +0100
Message-Id: <20221230001404.10902-1-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the k3 ring accelerator driver has been modified to add module build
support, try_module_get() and module_put() have been added to update the
module refcnt. One code path has not been updated and it has introduced
an issue where the refcnt is decremented by module_put() in
k3_ringacc_ring_free() without being incremented previously.
Adding try_module_get() to k3_dmaring_request_dual_ring() ensures the
refcnt is kept up to date.

Fixes: c07f216a8b72 ("soc: ti: k3-ringacc: Allow the driver to be built as module")
Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
v1->v2:
Added the Fixes and Reviewed-by tags

 drivers/soc/ti/k3-ringacc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index e01e4d815230a..8f131368a7586 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -406,6 +406,11 @@ static int k3_dmaring_request_dual_ring(struct k3_ringacc *ringacc, int fwd_id,
 
 	mutex_lock(&ringacc->req_lock);
 
+	if (!try_module_get(ringacc->dev->driver->owner)) {
+		ret = -EINVAL;
+		goto err_module_get;
+	}
+
 	if (test_bit(fwd_id, ringacc->rings_inuse)) {
 		ret = -EBUSY;
 		goto error;
@@ -421,6 +426,8 @@ static int k3_dmaring_request_dual_ring(struct k3_ringacc *ringacc, int fwd_id,
 	return 0;
 
 error:
+	module_put(ringacc->dev->driver->owner);
+err_module_get:
 	mutex_unlock(&ringacc->req_lock);
 	return ret;
 }
-- 
2.25.1

