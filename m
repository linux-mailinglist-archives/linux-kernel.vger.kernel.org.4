Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7266C644CFD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiLFUIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLFUHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:07:54 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6EA165B6;
        Tue,  6 Dec 2022 12:07:51 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 110A43B37;
        Tue,  6 Dec 2022 21:07:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1670357270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XjEsutPxJcw9ycuwtn1DnBCaMeP1tVgn6MXPS4VZA6I=;
        b=QHHe21qRSQ4K/jwvw4jcKRSJB8BvJsT+adygn6kWzVp2w0U1HAI0N+2uWwdy5XqCOa59Y9
        vTlZZQi5qVkrT/fHfoQa4OPQ+cuiLs5u/ilrxbn5pxtDbkoBRKvsUYPzdBAmib750BBmiM
        un+nXH6ib5oA9WbkeW82amZuCZt7dzk4QuDr5hQ+R2JeN8qvObxdVvHZpDN83IGqRcISDj
        j13yv0ejM+RriBdzQiWl3GWrFJ+o5p3cWP1x7ddUDseKNcLG7McJ8zyaWeBKjtgF361vqD
        3X3ZloyXqjWzlP+T2W/P08VcbpKNkmAPfTtHrPtJbuz08wT0CrbuNuBFAA6DEg==
From:   Michael Walle <michael@walle.cc>
To:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Walle <michael@walle.cc>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v5 08/21] nvmem: core: drop the removal of the cells in nvmem_add_cells()
Date:   Tue,  6 Dec 2022 21:07:27 +0100
Message-Id: <20221206200740.3567551-9-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206200740.3567551-1-michael@walle.cc>
References: <20221206200740.3567551-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If nvmem_add_cells() fails, the whole nvmem_register() will fail
and the cells will then be removed anyway. This is a preparation
to introduce a nvmem_add_one_cell() which can then be used by
nvmem_add_cells().

This is then the same to what nvmem_add_cells_from_table() and
nvmem_add_cells_from_of() do.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v4:
 - none

changes since v3:
 - fix typo, s/prepartion/preparation/

changes since v2:
 - none

changes since v1:
 - none

 drivers/nvmem/core.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 24573e63e5a9..7c76e0e0072e 100644
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
2.30.2

