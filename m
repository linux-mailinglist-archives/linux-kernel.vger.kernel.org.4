Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D425D67E2F5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjA0LSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjA0LSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679C5227A1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:01 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t18so4685565wro.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgWqiYoy7iTVqZHJ21rDyJ80SvbTnPhWOGsjkHQz9g4=;
        b=VRUnwgrBI1wnBlm0Y8DRYgSNvYGL3m55l9zS/E/iiVt5sBopxU4Jp/2iL36QivrHsg
         UtyY1+CJgrN8xxUYntQ8VgL2KkVfVyDvpj1jNXAyHTgYYF8ANp55pmvrW57jiSbH/pwE
         48J3hG8Jp2frFpeoMIBOIkgWJ2d/GvDykkxFzM7yGOWeJl1Phdb2Hc3YWfOaWVazqFb7
         EONguCYiHWeF6U10sg8RSLjuNhveET/0PzfX7ceJ1yKIyxmMaY/uNFwr5I2YBx7vpqA0
         YxMkkDtivywNFioof19DM3m32LjcG0FCZJce8IIW2v5tBjv/7IgkoLhw2xmIdpxljo6m
         /guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgWqiYoy7iTVqZHJ21rDyJ80SvbTnPhWOGsjkHQz9g4=;
        b=3UaOeS+SiLXD55eEV58apwFUYCHSZZa2kx3sIrR+VSVu7hg9qhHcEfG8QefgIzqD3u
         pQ28ykt8yxUdRWgwWQm3qtcVKMo7VAcRKOrzkEF5Y1o9MDP84aI0S6fr4ItzdCdLWLG7
         bHV+zV7Vz6ojWKR0jwPrAGEYAoMWIjwQfc2H5ixLdpVUoSsLb9jwDOb2RZk2wTDq+gI7
         waXIIgPTcEe4NCKxKQzMb1WnSE/xobpX756+w3V5OgAsRKQ9KHLfBPvGiHHNidbsC0Jq
         fzxFcBroHkUL4X+xDc30LJ+c99JsVVJWjnV56W07R31S1hWFTsCosMtnOouhVTETGBf3
         FVkA==
X-Gm-Message-State: AFqh2kp23EGuWG9QXwFfgv4j5psgVmCDOEdJTBbKkp3ZvR72QAhke+Qp
        AYuEkEiywlWmUR8MGtk0SOTMJg==
X-Google-Smtp-Source: AMrXdXtn+ey3s1KTW42Gl/dq4np9FUBXcL58ncYXn06oB4oHXAXGqCYGhtS643Zc01gjPE17eAtZhQ==
X-Received: by 2002:a05:6000:22d:b0:2bb:f46f:c136 with SMTP id l13-20020a056000022d00b002bbf46fc136mr30181374wrz.23.1674818279297;
        Fri, 27 Jan 2023 03:17:59 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:17:58 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 14/37] nvmem: core: drop the removal of the cells in nvmem_add_cells()
Date:   Fri, 27 Jan 2023 11:15:42 +0000
Message-Id: <20230127111605.25958-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
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

