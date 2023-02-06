Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B99A68BA35
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjBFKap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBFK3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:29:41 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A4122016
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id u10so5232823wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APFypbhgMA4X/1jworaycPA1J9HozIEL/Uy35y7MliU=;
        b=pLCIOuT1QT4+iiINXxoVi3FzdpaLVJysS+WX/P1zwOCURfU0/wchM5D7e1sCojQqkn
         HQSyYhXxwQcQmZDNmoK1ydZcLClcX0i/M6MZoByRa0K9+wsAJVFaE4Ntp78+B2eMny9n
         EBHdqOLGckyQJI+O7DbSuX7s+te4HUZSOHx3tretgd1AFMldUXiNecdtjUUnGDMKwbDc
         sUMDtsOhGi7r1Uq/jxWwo7z3nupvLnQsU8/S8e9P7YlWqQc8j5qYytGfbdXeDCIqA/Jq
         6gote0kkB9d5wfAbwztRG67ijYzpVXhmB6Hoi7tJh9jdN9REAICZ+VexkXTWq1PtZXmP
         riSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APFypbhgMA4X/1jworaycPA1J9HozIEL/Uy35y7MliU=;
        b=35cjMOsPk0pvVxkcjU9SJdRszsFdX+VJqGB/nrMIcpFgY/vFsVtiFPAUJ5UfChr6WV
         A2uxnjGklrkR2jXg3eHO0yT4HIirEBBvoJb4LUjw1JSK9y3IdHQRHXbS4cjnh/+wiQ4D
         iMIoMhgZatrMR665Grkvve1t3MepW+FSIMSIAnNUYoc5ckBC+gdVREZODQbL+MOhIzyN
         nK6VVuHbcmiRUIGH7qGTonXGZa2R7PmAvn6cL0LaitLUSZZy38tLbp0Xq6KkdrMwKRL1
         0eMhx2YEyw451YjWrP2Cde4ew2D1U9xNHmCtFT+JY0X8fVIM4588BYB3SAX2ZP9mK80C
         Ru4w==
X-Gm-Message-State: AO0yUKVWJMRtcy/kqE+GwQjCSu/QoXHCJGg4u3UcfM8zNgrPiagpC52Y
        cGDy6pCDZ08UOQxSVau1U8y+0g==
X-Google-Smtp-Source: AK7set+vzDixuVdM95XUPW+DClZuuEwBNE/MXpm0J1eum9J0SjwNkoJ0/BP29JqX6CAAooWrLlE6vg==
X-Received: by 2002:a05:600c:1e87:b0:3dc:353c:8b44 with SMTP id be7-20020a05600c1e8700b003dc353c8b44mr18814295wmb.5.1675679331648;
        Mon, 06 Feb 2023 02:28:51 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:51 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 30/37] nvmem: core: fix nvmem_layout_get_match_data()
Date:   Mon,  6 Feb 2023 10:27:52 +0000
Message-Id: <20230206102759.669838-31-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This function was trying to match wrong OF node (parent device's)
against an of_match_table. It was always returning NULL.

Make it match layout's OF node against layout's of_match_table.

Note: __maybe_unused is needed to avoid:
warning: variable 'layout_np' set but not used [-Wunused-but-set-variable]
(of_match_node() is no-op without CONFIG_OF).

Fixes: 61a093b4a0e0 ("nvmem: core: introduce NVMEM layouts")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 30057b0094a2..38a5728bc65c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -824,9 +824,11 @@ EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
 const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 					struct nvmem_layout *layout)
 {
+	struct device_node __maybe_unused *layout_np;
 	const struct of_device_id *match;
 
-	match = of_match_node(layout->of_match_table, nvmem->dev.of_node);
+	layout_np = of_nvmem_layout_get_container(nvmem);
+	match = of_match_node(layout->of_match_table, layout_np);
 
 	return match ? match->data : NULL;
 }
-- 
2.25.1

