Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5F2636823
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbiKWSDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239370AbiKWSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:22 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E9197358;
        Wed, 23 Nov 2022 10:02:21 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id AACAA31FF;
        Wed, 23 Nov 2022 19:02:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669226539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XAy6w8gmcdBCGB2WqwHd4YD9OIJ2+H3z5Lml3ZnuA1g=;
        b=Jk8A2EV9KEcSNasbByjuQt4+++GQ/KW67C5/I+Tf74dT/Y9tJd0oBWBzVfadSmgmsDjArL
        AwzGAodXnZxJGtF/OXmHxDbXMVcO2nlIfqe+EGYtKNX5MUpeUR9FjTiqx3hnu+lG0D6IpL
        z3Pu8ymOvfx9YDxHRfql5QvX8DH3r2dTAD0TLg+NFpRNEbvvULeFZQPUDaHtPy6g4KRywO
        2pLEPltOCEFDDv108Kdxli/pBN+sIAuvezSL5OsBqQ9u0Ld2A9pSqTBNmJIUIta5ofYhZg
        6aqrcvjZlb6tUa25OXK9vii2aF+Ptl+J9YuYCRii3iSsJ0FvMHRhc3XiunlkVw==
From:   Michael Walle <michael@walle.cc>
To:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 03/20] of: property: make #.*-cells optional for simple props
Date:   Wed, 23 Nov 2022 19:01:34 +0100
Message-Id: <20221123180151.2160033-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221123180151.2160033-1-michael@walle.cc>
References: <20221123180151.2160033-1-michael@walle.cc>
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

Sometimes, future bindings for phandles will get additional arguments.
Thus the target node of the phandle will need a new #.*-cells property.
To be backwards compatible, this needs to be optional.

Prepare the DEFINE_SIMPLE_PROPS() to handle the cells name as optional.

Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
changes since v3:
 - new patch

 drivers/of/property.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 967f79b59016..9773bfeaed9f 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1254,8 +1254,8 @@ static struct device_node *parse_suffix_prop_cells(struct device_node *np,
 	if (strcmp_suffix(prop_name, suffix))
 		return NULL;
 
-	if (of_parse_phandle_with_args(np, prop_name, cells_name, index,
-				       &sup_args))
+	if (__of_parse_phandle_with_args(np, prop_name, cells_name, 0, index,
+					 &sup_args))
 		return NULL;
 
 	return sup_args.np;
-- 
2.30.2

