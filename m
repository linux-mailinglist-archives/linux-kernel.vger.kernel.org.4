Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190BB661A3C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbjAHV5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbjAHV5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:57:09 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02907662
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 13:57:08 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so7714786wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 13:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pmu+ooljm/HGcSlkAl7hxuicOXpBLsPaLMjXgjubWRw=;
        b=hbFFDMrUQuk+KC+ExU005L22CrNW+1MV0BI63KaiQtchIoe3kQ/wZvXXJaUjFlFZPX
         rcef4uZRtvacGDNzChEkD4iX+A3uGIAB77Eh2h1d4IsaGLzL4RGbaSdstuZAbSETkDyE
         azzyVy6X6xfPOlTQDRRLERNlXF+5/IT1dPqYcwUKZ9WeYx+w3BuGcDaNWPx1TOgvzPle
         3Q8H09oSOu6VEoQZI7Rcty/ynbAR9dSYId6530Iu4LVwDnx1pD+AdiwlaC3XgbhoTGN0
         ef9PbV+xtMAoUaW3A4VsBMBwPXqi6ruV8ZFFSMm1FnhujBLCf6GjWncB7nghKev/Obwc
         bEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pmu+ooljm/HGcSlkAl7hxuicOXpBLsPaLMjXgjubWRw=;
        b=jETMWlFc7cIm2qjNwdtauHJHTVCgEFUURrr0hOg5N9wye4cB9YUxqz3BqxhgPyYgjD
         siTdylSZx0w8yyopiMne9vUQLi5cZm8qpnwhKIbISTDoOLoYgpWQ98EpR5nQncWIHdc1
         QMvyPwu7qA7mTPYV0gluJ9B+rq3vWFhmTwSkTs+Vj856V+ARdFniROMT6skwrAh1WHZu
         atLD0+9t666t278xtWgXfeyeNOcw0lFvvxWt6IsoRdQ8tNlZbbCN2UDHg4hTFDdoUg62
         4PzBvOeGy6CxjquCrxvvDwreNRZ3CTM93t8q/J6Q8p4LsYIqpwEh2piWBBCg+UOhHKOG
         GT0w==
X-Gm-Message-State: AFqh2kpvjHUlHcAqn1sXV3vjOwRUKghQh+ePJ/oUzEzy0KDFKmHzcVor
        Bz6ZiWOX89nML6wU3bo3/7ShiyB9Shs=
X-Google-Smtp-Source: AMrXdXs5lnZunvg0o51m8Ep+zqGRh+l17LS2RQ7MRrEVR4uqwbfPdeLNAhoyyLSfUMarIDJRSw7S8Q==
X-Received: by 2002:a05:600c:3d1b:b0:3d0:6a57:66a5 with SMTP id bh27-20020a05600c3d1b00b003d06a5766a5mr43683098wmb.0.1673215027288;
        Sun, 08 Jan 2023 13:57:07 -0800 (PST)
Received: from localhost.localdomain ([2a10:d582:3bb:0:63f8:f640:f53e:dd47])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b003d99469ece1sm14654071wmo.24.2023.01.08.13.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 13:57:06 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3/7] parport_pc: Let chipset drivers mask ECR bits on writes
Date:   Sun,  8 Jan 2023 21:56:52 +0000
Message-Id: <20230108215656.6433-3-sudipm.mukherjee@gmail.com>
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

Provide an `ecr_writable' parameter to `__parport_pc_probe_port' so that
callers can specify a mask of bits to modify on ECR writes.

To avoid the need for separate bit set and bit clear masks always set
bit 0 whenever a non-zero mask has been set, as all the currently known
cases where a mask is required, that is Oxford Semiconductor devices, do
require this bit to be set.  If further cases are discovered where the
bit is required to be clear, we can update code accordingly, but chances
are very low as the bit is supposed to be read-only[1].

Skip ECR probing, which can be problematic as the Oxford Semiconductor
OX12PCI840 part has been reported to lock up on setting bit 2, whenever
a non-zero mask has been requested by a port subdriver, assuming that
the ECR must be there if the subdriver has requested a specific way to
access it.

References:

[1] "Extended Capabilities Port Protocol and ISA Interface Standard",
    Microsoft Corporation, Revision: 1.14, July 14, 1993, Table 14
    "Extended Control Register"

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_pc.c | 46 +++++++++++++++++++++++-------------
 include/linux/parport_pc.h   |  3 +++
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 9daaaaa305e6..ad49fd356c7b 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -106,15 +106,22 @@ static int pnp_registered_parport;
 static void frob_econtrol(struct parport *pb, unsigned char m,
 			   unsigned char v)
 {
+	const struct parport_pc_private *priv = pb->physport->private_data;
+	unsigned char ecr_writable = priv->ecr_writable;
 	unsigned char ectr = 0;
+	unsigned char new;
 
 	if (m != 0xff)
 		ectr = inb(ECONTROL(pb));
 
-	pr_debug("frob_econtrol(%02x,%02x): %02x -> %02x\n",
-		 m, v, ectr, (ectr & ~m) ^ v);
+	new = (ectr & ~m) ^ v;
+	if (ecr_writable)
+		/* All known users of the ECR mask require bit 0 to be set. */
+		new = (new & ecr_writable) | 1;
 
-	outb((ectr & ~m) ^ v, ECONTROL(pb));
+	pr_debug("frob_econtrol(%02x,%02x): %02x -> %02x\n", m, v, ectr, new);
+
+	outb(new, ECONTROL(pb));
 }
 
 static inline void frob_set_mode(struct parport *p, int mode)
@@ -1479,21 +1486,24 @@ static int parport_ECR_present(struct parport *pb)
 	struct parport_pc_private *priv = pb->private_data;
 	unsigned char r = 0xc;
 
-	outb(r, CONTROL(pb));
-	if ((inb(ECONTROL(pb)) & 0x3) == (r & 0x3)) {
-		outb(r ^ 0x2, CONTROL(pb)); /* Toggle bit 1 */
+	if (!priv->ecr_writable) {
+		outb(r, CONTROL(pb));
+		if ((inb(ECONTROL(pb)) & 0x3) == (r & 0x3)) {
+			outb(r ^ 0x2, CONTROL(pb)); /* Toggle bit 1 */
 
-		r = inb(CONTROL(pb));
-		if ((inb(ECONTROL(pb)) & 0x2) == (r & 0x2))
-			goto no_reg; /* Sure that no ECR register exists */
-	}
+			r = inb(CONTROL(pb));
+			if ((inb(ECONTROL(pb)) & 0x2) == (r & 0x2))
+				/* Sure that no ECR register exists */
+				goto no_reg;
+		}
 
-	if ((inb(ECONTROL(pb)) & 0x3) != 0x1)
-		goto no_reg;
+		if ((inb(ECONTROL(pb)) & 0x3) != 0x1)
+			goto no_reg;
 
-	ECR_WRITE(pb, 0x34);
-	if (inb(ECONTROL(pb)) != 0x35)
-		goto no_reg;
+		ECR_WRITE(pb, 0x34);
+		if (inb(ECONTROL(pb)) != 0x35)
+			goto no_reg;
+	}
 
 	priv->ecr = 1;
 	outb(0xc, CONTROL(pb));
@@ -2005,7 +2015,8 @@ static struct parport *__parport_pc_probe_port(unsigned long int base,
 					       int irq, int dma,
 					       struct device *dev,
 					       int irqflags,
-					       unsigned int mode_mask)
+					       unsigned int mode_mask,
+					       unsigned char ecr_writable)
 {
 	struct parport_pc_private *priv;
 	struct parport_operations *ops;
@@ -2054,6 +2065,7 @@ static struct parport *__parport_pc_probe_port(unsigned long int base,
 	priv->ctr = 0xc;
 	priv->ctr_writable = ~0x10;
 	priv->ecr = 0;
+	priv->ecr_writable = ecr_writable;
 	priv->fifo_depth = 0;
 	priv->dma_buf = NULL;
 	priv->dma_handle = 0;
@@ -2256,7 +2268,7 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 				      int irqflags)
 {
 	return __parport_pc_probe_port(base, base_hi, irq, dma,
-				       dev, irqflags, 0);
+				       dev, irqflags, 0, 0);
 }
 EXPORT_SYMBOL(parport_pc_probe_port);
 
diff --git a/include/linux/parport_pc.h b/include/linux/parport_pc.h
index 3d6fc576d6a1..f1ec5c10c3b3 100644
--- a/include/linux/parport_pc.h
+++ b/include/linux/parport_pc.h
@@ -26,6 +26,9 @@ struct parport_pc_private {
 	/* Whether or not there's an ECR. */
 	int ecr;
 
+	/* Bitmask of writable ECR bits. */
+	unsigned char ecr_writable;
+
 	/* Number of PWords that FIFO will hold. */
 	int fifo_depth;
 
-- 
2.30.2

