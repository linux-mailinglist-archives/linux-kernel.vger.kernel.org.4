Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABFD644D04
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiLFUIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiLFUHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:07:55 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB66C13DEE;
        Tue,  6 Dec 2022 12:07:52 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 63FB43B39;
        Tue,  6 Dec 2022 21:07:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1670357270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mvTkfYS/F5bhxjZrXTlkPXrK+rtGefsDiAak505Ve5I=;
        b=opmIFnOxHWQg0pmLwLLkrxg6RJTvYGzaJg6JawH8Qi4UGjW5MBsazUYQrHZW/DXBTnn2tq
        kAPYGcC6FhZA/GYC3fT6VL2tg9SkTyQUXn/FvX95xIzu48RfERGNithitZ5pp6rHYnZ1XO
        dKF/RGFhhjXQpREAv18gyflhb60KHzTe7t4BHMAxK+mLxNdbn2ZRnt26GDqwf1sDpFtLsM
        srt8hj2Nkhpz1iUxL3TL42Tqbkc80+eMrCA5o2H+smHMnJbqoXgdshfa4CRdatudLUz6+o
        IllbFKKUaK3GIj9NbN3MdzDzmU8zmOjQsXEzH4DzumDHh4MAFZ4d/qbTh7axQA==
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
Subject: [PATCH v5 09/21] nvmem: core: fix cell removal on error
Date:   Tue,  6 Dec 2022 21:07:28 +0100
Message-Id: <20221206200740.3567551-10-michael@walle.cc>
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

nvmem_add_cells() could return an error after some cells are already
added to the provider. In this case, the added cells are not removed.
Remove any registered cells if nvmem_add_cells() fails.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v4:
 - new patch

 drivers/nvmem/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 7c76e0e0072e..70c3d0a20d0d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -851,7 +851,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (config->cells) {
 		rval = nvmem_add_cells(nvmem, config->cells, config->ncells);
 		if (rval)
-			goto err_teardown_compat;
+			goto err_remove_cells;
 	}
 
 	rval = nvmem_add_cells_from_table(nvmem);
@@ -868,7 +868,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 err_remove_cells:
 	nvmem_device_remove_all_cells(nvmem);
-err_teardown_compat:
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
 err_device_del:
-- 
2.30.2

