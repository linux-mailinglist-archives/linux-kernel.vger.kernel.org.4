Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6498A661A3D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbjAHV5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236219AbjAHV5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:57:09 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2285B7677
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 13:57:08 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so5241699wms.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 13:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuHjicZYsZv1YxafD0PitIxhFzu7w+N5/HlaM8PLcI4=;
        b=ldezYofxF0jJjJeJC1RD3qkb4zEl0FmqQ0EzLX/Nkhv7NxXSNNuTeZx31gd9ZYfA9t
         YXnoXkg4aiNaDbUAOFjZ2a166mwOtET4tc5l0zf9nl97m3RqWI9/NqTjxyJNMWoXdiC1
         G7d07sdLjN0QUk221voWKI1iZntHD7Yr1vj+jnnIvKGQPu4jBRnp0DW/uxYzMpKjlvWB
         pzCRMO0Zu1Ok0opQ8rJFJoVkih8W51eiuzIzpn3RFUc9297YdFG1oUh0f8AKtXi1+CrO
         clVWqODs4HTpr+0d+eyFk+EofoizImSSPjhwnyCZE6yWu/ge9KhR90Jd1vQwRwmGeape
         tKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuHjicZYsZv1YxafD0PitIxhFzu7w+N5/HlaM8PLcI4=;
        b=DZaL1Nev9UCpC1a6zfgIKI67l7ery4TOMascHT6TEKKo99B18ZveVP/K0fYFQ8S6b6
         /yKj58+9slVW6hXFW6abvbOJORZuNUGi3wpBuBPkcoBdbvRkvJ7mQEsJjYytb7ug1jR4
         mwQ1AAy6i3QYd11/IeKjdacEHaiyT+jdZ2xkeHzuogr30Kh2Jr7U3ZFWJ83LcImjfnpB
         B3F0Uod6lJUBPW6dZ72LIzOhQy3VCgX634IrzyaQwYYLuF2x99wRWRU+wjO3Qi9yDuKc
         rNyX3S8RT7LgoTucwhP+8QFS827QwJIxAtCFm99+6ZgauuxG1tRmDXwBxo7NCm6/GNeh
         cS/w==
X-Gm-Message-State: AFqh2kp3HXOg1FNvboGbeq7A9YzD6FO9Zkz4KaSs3Wq9mT2ibiq560rY
        F9ip0+1aR5nrZuSzS5ipYXs=
X-Google-Smtp-Source: AMrXdXuyeB4jSufFVM5scVcgOEYkoxwRcSLrEoOsGcvVjsGMEA4yJqyWfb8tL1y2EfrJNwQdQFZ31A==
X-Received: by 2002:a05:600c:2247:b0:3d3:4b1a:6ff9 with SMTP id a7-20020a05600c224700b003d34b1a6ff9mr45128622wmm.26.1673215026538;
        Sun, 08 Jan 2023 13:57:06 -0800 (PST)
Received: from localhost.localdomain ([2a10:d582:3bb:0:63f8:f640:f53e:dd47])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b003d99469ece1sm14654071wmo.24.2023.01.08.13.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 13:57:06 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/7] parport_pc: Let chipset drivers mask unsupported modes
Date:   Sun,  8 Jan 2023 21:56:51 +0000
Message-Id: <20230108215656.6433-2-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230108215656.6433-1-sudipm.mukherjee@gmail.com>
References: <20230108215656.6433-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej W. Rozycki" <macro@orcam.me.uk>

Rename `parport_pc_probe_port' to `__parport_pc_probe_port' and add a
`mode_mask' parameter so that callers can specify a mask of unsupported
modes to exclude even if mode probing seems to indicate otherwise.  Add
a `parport_pc_probe_port' wrapper with an implicit mask of 0 for the
current callers to use.

No functional change at this point, but the configuration of data write
handlers is now no longer intertwined with determination and reporting
of available modes.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_pc.c | 45 ++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index de7afbea96cd..9daaaaa305e6 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2000,11 +2000,12 @@ static int parport_dma_probe(struct parport *p)
 static LIST_HEAD(ports_list);
 static DEFINE_SPINLOCK(ports_lock);
 
-struct parport *parport_pc_probe_port(unsigned long int base,
-				      unsigned long int base_hi,
-				      int irq, int dma,
-				      struct device *dev,
-				      int irqflags)
+static struct parport *__parport_pc_probe_port(unsigned long int base,
+					       unsigned long int base_hi,
+					       int irq, int dma,
+					       struct device *dev,
+					       int irqflags,
+					       unsigned int mode_mask)
 {
 	struct parport_pc_private *priv;
 	struct parport_operations *ops;
@@ -2116,18 +2117,28 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 	    p->dma != PARPORT_DMA_NOFIFO &&
 	    priv->fifo_depth > 0 && p->irq != PARPORT_IRQ_NONE) {
 		p->modes |= PARPORT_MODE_ECP | PARPORT_MODE_COMPAT;
+		if (p->dma != PARPORT_DMA_NONE)
+			p->modes |= PARPORT_MODE_DMA;
+	} else
+		/* We can't use the DMA channel after all. */
+		p->dma = PARPORT_DMA_NONE;
+#endif /* Allowed to use FIFO/DMA */
+
+	p->modes &= ~mode_mask;
+
+#ifdef CONFIG_PARPORT_PC_FIFO
+	if ((p->modes & PARPORT_MODE_COMPAT) != 0)
 		p->ops->compat_write_data = parport_pc_compat_write_block_pio;
 #ifdef CONFIG_PARPORT_1284
+	if ((p->modes & PARPORT_MODE_ECP) != 0)
 		p->ops->ecp_write_data = parport_pc_ecp_write_block_pio;
-#endif /* IEEE 1284 support */
-		if (p->dma != PARPORT_DMA_NONE) {
+#endif
+	if ((p->modes & (PARPORT_MODE_ECP | PARPORT_MODE_COMPAT)) != 0) {
+		if ((p->modes & PARPORT_MODE_DMA) != 0)
 			pr_cont(", dma %d", p->dma);
-			p->modes |= PARPORT_MODE_DMA;
-		} else
+		else
 			pr_cont(", using FIFO");
-	} else
-		/* We can't use the DMA channel after all. */
-		p->dma = PARPORT_DMA_NONE;
+	}
 #endif /* Allowed to use FIFO/DMA */
 
 	pr_cont(" [");
@@ -2237,6 +2248,16 @@ do {									\
 		platform_device_unregister(pdev);
 	return NULL;
 }
+
+struct parport *parport_pc_probe_port(unsigned long int base,
+				      unsigned long int base_hi,
+				      int irq, int dma,
+				      struct device *dev,
+				      int irqflags)
+{
+	return __parport_pc_probe_port(base, base_hi, irq, dma,
+				       dev, irqflags, 0);
+}
 EXPORT_SYMBOL(parport_pc_probe_port);
 
 void parport_pc_unregister_port(struct parport *p)
-- 
2.30.2

