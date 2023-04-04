Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7094C6D6A6D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbjDDRXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbjDDRXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3C259C5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ew6so133502262edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NUlZD8qt7iqezKSBYAgBX4TFVpDixxexmnqZMgjaKs=;
        b=x7MIVVlfA7qRirbgLCU7xH2NaP2ANpZepGV8SNvAT9DnxIOgQk05DqXgxJokIYc0yr
         TrzH2zk7U4Y8qBlyPMF+fWE+LEz+GCdDQ3oXfMnFz4WgXD17BcuJAbejq3Pw1YI/C7Z7
         q00U/lxPsqteXpcCG89xVgOuM0nv2NBv6clBQqNFfrnQ4k5VCmoPkRJO/uuhqe3X5Kfk
         mn7VdRyb5l0uxAnEUTcsgqBnMs36VtTgcOGwHZNLzOP0QX1l/XgNIiQ18h28Z6NxYvfT
         TFS2phT7YnAD3mtf7LMqTz92IgKt6pGZNVxxOr+lZ5R/pzftLYSDCO2tsEc0VKO1SOus
         aitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NUlZD8qt7iqezKSBYAgBX4TFVpDixxexmnqZMgjaKs=;
        b=gFzpi7ish+M0G9YLI5donTPvhCNgM4273JsIvyhGMwIm2fC1ThtxAMs5pmuE3kIXao
         h+YM5hajNnCIsZe7SpPtnMDMBk0Ues7aZ23cELIOE8R313VigkhPlfnMiDXwlf7RdvHW
         IUURW7fiar+Fw53WW+fF3QQoIee/oe2k7pwTxDfC3ajRjXVfv/c0NZ+N2obXBVtXdch4
         DrPm7yMUII5ZAP9IKbPnV5bOCWZOMD4B30t3z949iM9b7kuxl5xHYDxPb6BWdgn69Qjq
         HBbUkxOs1ltnWyFgcHeSy3+g2Qb2YlEv/fEAUnGwWp3ndC5RF0vmpB1/ua1m6dclxKF6
         y8hQ==
X-Gm-Message-State: AAQBX9fi0jUnlFcjlIbDEetwrjIOoHmvXwkJwfetzNRzGt0nmS7tqcBg
        OLd+VFZB8YGyw2iX2z66MsgeJA==
X-Google-Smtp-Source: AKy350YuviW2rJl9aLPXrOXQJIxjQLwOLL73I6Imlc+ikg/aoXxi0pyVe2H4LdSfr9gW0xvBMHCpgA==
X-Received: by 2002:a17:906:edcf:b0:92a:3709:e872 with SMTP id sb15-20020a170906edcf00b0092a3709e872mr371216ejb.19.1680628961473;
        Tue, 04 Apr 2023 10:22:41 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:40 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 14/40] nvmem: core: handle the absence of expected layouts
Date:   Tue,  4 Apr 2023 18:21:22 +0100
Message-Id: <20230404172148.82422-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

Make nvmem_layout_get() return -EPROBE_DEFER while the expected layout
is not available. This condition cannot be triggered today as nvmem
layout drivers are initialed as part of an early init call, but soon
these drivers will be converted into modules and be initialized with a
standard priority, so the unavailability of the drivers might become a
reality that must be taken care of.

Let's anticipate this by telling the caller the layout might not yet be
available. A probe deferral is requested in this case.

Please note this does not affect any nvmem device not using layouts,
because an early check against the "nvmem-layout" container presence
will return NULL in this case.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b9be1faeb7be..51fd792b8d70 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -755,7 +755,7 @@ EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
 static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
 {
 	struct device_node *layout_np, *np = nvmem->dev.of_node;
-	struct nvmem_layout *l, *layout = NULL;
+	struct nvmem_layout *l, *layout = ERR_PTR(-EPROBE_DEFER);
 
 	layout_np = of_get_child_by_name(np, "nvmem-layout");
 	if (!layout_np)
@@ -938,6 +938,13 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	 * pointer will be NULL and nvmem_layout_put() will be a noop.
 	 */
 	nvmem->layout = config->layout ?: nvmem_layout_get(nvmem);
+	if (IS_ERR(nvmem->layout)) {
+		rval = PTR_ERR(nvmem->layout);
+		nvmem->layout = NULL;
+
+		if (rval == -EPROBE_DEFER)
+			goto err_teardown_compat;
+	}
 
 	if (config->cells) {
 		rval = nvmem_add_cells(nvmem, config->cells, config->ncells);
@@ -970,6 +977,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 err_remove_cells:
 	nvmem_device_remove_all_cells(nvmem);
 	nvmem_layout_put(nvmem->layout);
+err_teardown_compat:
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
 err_put_device:
-- 
2.25.1

