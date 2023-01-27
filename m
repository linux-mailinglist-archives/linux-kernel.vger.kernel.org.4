Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21E967E30B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjA0LTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjA0LS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:57 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD6387362
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:23 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m14so4201424wrg.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkPn4xoX0BLwonOlTuXlD3Roc+kHwzmJD8rg60cQtPs=;
        b=R9HACK1GyT0gOembwAPjqHw04bfjT1xYkH1nNfXQxVXWzbOAas4LJp4raaahehoMro
         ECPgF6pAZLKSRf27tGkMUGaNnPrQ+dIl0mu7I9UrcmZYjaTLTY7hsyOQJ0e3GDn2TRgJ
         d56qmiL3toNR9zbI13S4Hq1/MZ7y7Z6v/M+CEmFfTnXFmagdu36RiNsXeXpYOfUq7+Cg
         HtivHGudL50d3Mb3emNMWlgv9i4EpF3PyOCiHrPrWJZQqbTgTqZQ4FS8/nI7R05PkuDU
         ANCUhQEJdAFkQh9DccOqZ2vhMwaosOdUq1An77bpXYRXgP/6xi3W05kPNDvTBvyXfoFa
         K+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkPn4xoX0BLwonOlTuXlD3Roc+kHwzmJD8rg60cQtPs=;
        b=xRpHGMVogIVWXE1wMNXHJp7TdbxmSmfaygCuRrV6gaeALIJvIhyKA4+oglZcbpIA9J
         qprRt+HhXm7lp5nquLhkBUky7/TU1UKZ3XsIQ9k/Qc8z0uFqCIkpsvSzBraQZLH0EpmB
         guuT9hIWKT3QYIDaxc62XZtMdMEVFSP0/5q+RqU23tUFLzxpy0C38neC2BN135KScYOU
         L8ZUZ6XwcGduYxBeKA5RrO0lttFlBCZ+Tm2peSM7ZAQ4nnBDQ62zBO3kW9UmER0fSeOd
         t2Z4mAJfOHt9q6JhCkfuZNHLrd8tDJdh3YHH6xR1ucciiB6iWZcGTK3XN8/eEt4j8gnu
         gudQ==
X-Gm-Message-State: AO0yUKXfyeC3KcJTDSSv3ZQ1thIZnA0APWAjZ2SsFhQXMYoDluVjYOWy
        U/qnk7m4gB0W/polL22hNgNn1Q==
X-Google-Smtp-Source: AK7set+BErV8xwkj4ilUcy3AnN46O0dXSK6srhmVb0lHFz7qArgS2yWh25EGydUOvpfJqQUuo6ivKg==
X-Received: by 2002:a5d:4ece:0:b0:2bf:d72b:d039 with SMTP id s14-20020a5d4ece000000b002bfd72bd039mr558757wrv.10.1674818300244;
        Fri, 27 Jan 2023 03:18:20 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:19 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 30/37] nvmem: core: fix nvmem_layout_get_match_data()
Date:   Fri, 27 Jan 2023 11:15:58 +0000
Message-Id: <20230127111605.25958-31-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
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

Fixes: f61a093b4a0e ("nvmem: core: introduce NVMEM layouts")
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

