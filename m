Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF86E68BA21
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjBFK3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjBFK2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:34 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19AD1F90F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:32 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id u10so5232218wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgWqiYoy7iTVqZHJ21rDyJ80SvbTnPhWOGsjkHQz9g4=;
        b=lOgUCVCaqxODdj7tEr6IKs0wSFLSUJHKj/ZaTYqNh6vopq7DlAw54+J3DDqkOzsiVm
         7eGQRGHSTi92g6vZa9EuFoxMJiH9Q44cnyEQ9ZBRG14MUd3WnS8xAgdgRJnjy/3jV3jf
         7R8aIt2IxJb1gN9uBelcLGVJ5XxObArKF7IZ/BWprbE4CWfqpucAlfPPeWpb4cApBxOF
         JoBEze0h9g0KhMPeYPR0jBV6f960jaEPLCImi0905U9Y2uF6e+YLzSDYeuliD05LpkCb
         ckedOyxOEvR88dPoEi80JbyFsw84Jg/t5waeR1YZDXhEun9Q1T/5Eg+/dXU7gz1FiV1J
         gVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgWqiYoy7iTVqZHJ21rDyJ80SvbTnPhWOGsjkHQz9g4=;
        b=30kYIhT1t3PkRqY0isM0NAAefBmH5e05EJjhOOXzSouM4MseHxFvlWWosCw50gUlJ3
         wVlyQb6H2kJaK/KD39Cho9WaxJ924F055MVMONDI+aXPoJVZ4rxEqSyJKkWMoFIHxe0Q
         WCLXJsB6sGYMHD1UbAsdukAVjiZWshNYQOozpeAE/l46uXPCXzCbwLvma7/8PP3Q7AjJ
         gFrwuZMwk7/p+r9PImWhf1qkhiCHrlTayE13yC4rTC5p4q2YhlgW0bJUCKr3b7QGZbzx
         lMOKdFDybJ6rt8hPTPARBCq3U0I9wJAR1BIqq/6ayTCEImxV0Kn+g6Pkh1TiBwtxqDnr
         GjJQ==
X-Gm-Message-State: AO0yUKVcC6MSGNHeB8Gse9wPgG5s5pqMv+MkFv4hluNvKHj+Pv7cWEl4
        preZzA8ExxXph48DObmr3jAsaQ==
X-Google-Smtp-Source: AK7set/a8CAAE/8yx5qiwWDYyjEXEdS3iypgT62qS9oDUUzu8kmty84wC3MigpS9tTCYHSjbYW+SlQ==
X-Received: by 2002:a05:600c:245:b0:3db:887:8c8c with SMTP id 5-20020a05600c024500b003db08878c8cmr17652380wmj.27.1675679311137;
        Mon, 06 Feb 2023 02:28:31 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:30 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 14/37] nvmem: core: drop the removal of the cells in nvmem_add_cells()
Date:   Mon,  6 Feb 2023 10:27:36 +0000
Message-Id: <20230206102759.669838-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

If nvmem_add_cells() fails, the whole nvmem_register() will fail
and the cells will then be removed anyway. This is a preparation
to introduce a nvmem_add_one_cell() which can then be used by
nvmem_add_cells().

This is then the same to what nvmem_add_cells_from_table() and
nvmem_add_cells_from_of() do.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 30567dd51fba..98ae70695f36 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -515,7 +515,7 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 		    int ncells)
 {
 	struct nvmem_cell_entry **cells;
-	int i, rval;
+	int i, rval = 0;
 
 	cells = kcalloc(ncells, sizeof(*cells), GFP_KERNEL);
 	if (!cells)
@@ -525,28 +525,22 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 		cells[i] = kzalloc(sizeof(**cells), GFP_KERNEL);
 		if (!cells[i]) {
 			rval = -ENOMEM;
-			goto err;
+			goto out;
 		}
 
 		rval = nvmem_cell_info_to_nvmem_cell_entry(nvmem, &info[i], cells[i]);
 		if (rval) {
 			kfree(cells[i]);
-			goto err;
+			goto out;
 		}
 
 		nvmem_cell_entry_add(cells[i]);
 	}
 
+out:
 	/* remove tmp array */
 	kfree(cells);
 
-	return 0;
-err:
-	while (i--)
-		nvmem_cell_entry_drop(cells[i]);
-
-	kfree(cells);
-
 	return rval;
 }
 
-- 
2.25.1

