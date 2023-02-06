Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CFF68BE94
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjBFNpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjBFNov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:44:51 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05B1265BA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h3so2566249wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgWqiYoy7iTVqZHJ21rDyJ80SvbTnPhWOGsjkHQz9g4=;
        b=PPkL9u4sZCnSnIkNubHB3J6EUGYeSot5ohz3PKnJt87QXfJRvUwyyTUcdo2RTzN5/p
         TVH/p7NnTGsbK07S5XIGDTlr5DukYyBOo5XSEPfVTcCKKez7owdB6ZAcOw/8XgPukzHW
         QM7+VE/4olxW4D0PvA8+rUEksKLHc8WFKy9x554fpszgQrUe8gJrKswJLpzhXWSSkuz6
         y+Rxjfj0fxPjx/y+aqEdplfeSdnaynqoemj2bOqcTzlEW7Bz0CJV3BA7CrBdNtN4WaW/
         PLaoiTQD96CZPBBC0q62b3fdG5OLdmiuO/XOYc5ZLiyMVNZs7llqvRzc8tqG2S1qX7+7
         5EdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgWqiYoy7iTVqZHJ21rDyJ80SvbTnPhWOGsjkHQz9g4=;
        b=qV6N84o9sKSz/+ARKwBax/hKXKw2cCDidk9mOvI5zxDbn4OVnYqZXE9hBmhxLGFTz9
         5Oj58+FWSBFKCKaEMPbSVVnNiS0Rn2E/FCAU+f2H5JZRjV4yqqMw2WMHhlcYISUe2Iag
         bWBF0DJ4DcfkOI5P015yJTFt6HX6UfHaxmegpJlN/0Mztm7+rAQD3lRC9wjazmMIRY93
         0pOcPO4eRLZUnyfqcnPFnn/i11ql8YquYZmIIlnsHAEjPRcgS/ltJBCH5Rx+VVojWR6w
         CO6ChG6ZmPwSqdh0wXP+RcwCAZ/04vvZ9f05Zbx5QF0Pj7QnNlQmARtGacMRNPY0+llU
         IB2g==
X-Gm-Message-State: AO0yUKWQyFCgGKkPPvGqwhfSLINy3VHERFl5G4xFNIUDvHuTYjv8eHcR
        k7RSqdcdsxX2Oaq2ZR2WwOk0yQ==
X-Google-Smtp-Source: AK7set8Ae5Oywqh+DdEOeWLncTNeCJsYmHjavWOb/AFEzdjH7u7JJjnfRmOWNjUTt54ypxe5jMbEOA==
X-Received: by 2002:a5d:6b89:0:b0:2bf:ef3b:d072 with SMTP id n9-20020a5d6b89000000b002bfef3bd072mr16782532wrx.0.1675691063825;
        Mon, 06 Feb 2023 05:44:23 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:23 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 14/22] nvmem: core: drop the removal of the cells in nvmem_add_cells()
Date:   Mon,  6 Feb 2023 13:43:48 +0000
Message-Id: <20230206134356.839737-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
References: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
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

