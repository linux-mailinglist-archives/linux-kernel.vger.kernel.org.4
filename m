Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FEE664FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjAJXbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjAJXbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:31:10 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2161106;
        Tue, 10 Jan 2023 15:31:04 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 6C9D11243;
        Wed, 11 Jan 2023 00:31:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1673393461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uNyx0haHjJoxKFFueQ3KWf5AQdAhtMwQ9rgeolDKga4=;
        b=lUislzKU+2O3FtXw/nqElV8jsVrZFEfjHW9gCCpvIEFoDXi3OPVdGu6WFFKiqaioox8Upr
        lP7FZ+bfcZubS/ZdSG80/aOU/gEcMF+MvP6WVrzoe52q7fmzBJHlluZOB/yhe6g2Mu21Zn
        wtGE1TMINESOU6YAJ5L0ReqG1YniRbyeZRthV7bTIsJ6KwzLZnvKnfGc8NZnO16QWdPxAi
        kQfBy9xIQQmRGGc0n/uehkYlAGnZKz43Jc3UVXyqbyvHOBW0hw52jO5OcOWbglnaQDmiE1
        TR2pj4gLtpLsuMwiMueH4DUjIsj1P9F92C3Ca1nCQZrjZhDJvcdbRYV/+1V7Ww==
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Peng Fan <peng.fan@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] of: property: fix #nvmem-cell-cells parsing
Date:   Wed, 11 Jan 2023 00:30:56 +0100
Message-Id: <20230110233056.3490942-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
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

Commit 67b8497f005f ("of: property: make #.*-cells optional for simple
props") claims to make the cells-name property optional for simple
properties, but changed the code for the wrong property, i.e. for
DEFINE_SUFFIX_PROP(). Fix that.

Fixes: 67b8497f005f ("of: property: make #.*-cells optional for simple props")
Reported-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Robert Marko <robimarko@gmail.com>
---
 drivers/of/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 8d9ba20a8f90..95b838185b2f 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1202,8 +1202,8 @@ static struct device_node *parse_prop_cells(struct device_node *np,
 	if (strcmp(prop_name, list_name))
 		return NULL;
 
-	if (of_parse_phandle_with_args(np, list_name, cells_name, index,
-				       &sup_args))
+	if (__of_parse_phandle_with_args(np, list_name, cells_name, 0, index,
+					 &sup_args))
 		return NULL;
 
 	return sup_args.np;
@@ -1256,8 +1256,8 @@ static struct device_node *parse_suffix_prop_cells(struct device_node *np,
 	if (strcmp_suffix(prop_name, suffix))
 		return NULL;
 
-	if (__of_parse_phandle_with_args(np, prop_name, cells_name, 0, index,
-					 &sup_args))
+	if (of_parse_phandle_with_args(np, prop_name, cells_name, index,
+				       &sup_args))
 		return NULL;
 
 	return sup_args.np;
-- 
2.30.2

