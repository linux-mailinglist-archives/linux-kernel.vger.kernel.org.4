Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1BE62FD3F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbiKRSw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242843AbiKRSvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:51:52 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D188FE70;
        Fri, 18 Nov 2022 10:51:43 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 80B241D74;
        Fri, 18 Nov 2022 19:51:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1668797487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tFfzdfr8EzS4AJ9gGldy9pAy2whydSkmOybewxOFEYc=;
        b=Eq+a7HtQaWB0/wRQb4/yW+wgzbBofmk6fKLAycp/+8kqh7ehXaueb0nGxNq5IqfwkhSQk0
        kaZKXcWec29xnN4kSkCW1yEf2SKIp/aQOj5V6bA4YGvVYCA4NMAW+TUg3V2VHQRBvMpxcx
        9lyqVwo8VQ34MgobRB04SRRM5HHnAdq6yvnw078GZPmE6b3q3AVpp0KJHH1AEBOo/h1cLC
        B51NVknMU3uK5i+DTbflSRsA5I3JSR2eVthNPRxhne/UVXm0aL6ihc9EzzDpuGtlaWtBKB
        cnXI+Lu0wmhcyVkvhipOQVl3fDXDKWqKD3CwNauJstpql4sHiAiIWrH5gv3zxA==
From:   Michael Walle <michael@walle.cc>
To:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 05/18] nvmem: core: move struct nvmem_cell_info to nvmem-provider.h
Date:   Fri, 18 Nov 2022 19:51:05 +0100
Message-Id: <20221118185118.1190044-6-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221118185118.1190044-1-michael@walle.cc>
References: <20221118185118.1190044-1-michael@walle.cc>
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

struct nvmem_cell_info is used to describe a cell. Thus this should
really be in the nvmem-provider's header. There are two (unused) nvmem
access methods which use the nvmem_cell_info to describe the cell to be
accesses. One can argue, that they will create a cell before accessing,
thus they are both a provider and a consumer.

struct nvmem_cell_info will get used more and more by nvmem-providers,
don't force them to also include the consumer header, although they are
not.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v2:
 - none

changes since v1:
 - new patch

 include/linux/nvmem-consumer.h | 10 +---------
 include/linux/nvmem-provider.h | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 980f9c9ac0bc..1f62f7ba71ca 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -18,15 +18,7 @@ struct device_node;
 /* consumer cookie */
 struct nvmem_cell;
 struct nvmem_device;
-
-struct nvmem_cell_info {
-	const char		*name;
-	unsigned int		offset;
-	unsigned int		bytes;
-	unsigned int		bit_offset;
-	unsigned int		nbits;
-	struct device_node	*np;
-};
+struct nvmem_cell_info;
 
 /**
  * struct nvmem_cell_lookup - cell lookup entry
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 8f964b394292..14a32a1bc249 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -14,7 +14,6 @@
 #include <linux/gpio/consumer.h>
 
 struct nvmem_device;
-struct nvmem_cell_info;
 typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 				void *val, size_t bytes);
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
@@ -47,6 +46,24 @@ struct nvmem_keepout {
 	unsigned char value;
 };
 
+/**
+ * struct nvmem_cell_info - NVMEM cell description
+ * @name:	Name.
+ * @offset:	Offset within the NVMEM device.
+ * @bytes:	Length of the cell.
+ * @bit_offset:	Bit offset if cell is smaller than a byte.
+ * @nbits:	Number of bits.
+ * @np:		Optional device_node pointer.
+ */
+struct nvmem_cell_info {
+	const char		*name;
+	unsigned int		offset;
+	unsigned int		bytes;
+	unsigned int		bit_offset;
+	unsigned int		nbits;
+	struct device_node	*np;
+};
+
 /**
  * struct nvmem_config - NVMEM device configuration
  *
-- 
2.30.2

