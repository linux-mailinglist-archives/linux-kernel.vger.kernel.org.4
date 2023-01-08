Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9365661A40
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjAHV5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbjAHV5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:57:11 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE04C767B
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 13:57:09 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso879769wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 13:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkvkO0ggi/mdrA5jtRFDVlYd+gaJ5/Kv6++Mtwxlna0=;
        b=UN5P/yaV2TfnhdDTe4qhIY8cgRyeNXREfjzV5AkC8g1HT8k4At0S2eySfYLFYFjbh3
         3857J8xEYMC5ET5kqdryIIIEqlmrrFep2krg23yYAVL6Vb3ClGKY4TrbyzHrcavR1UQk
         xkcPw97WyBX2PDCfmTv0g+jlltZrqKkj/fh/r0BCfGFG6BRPQAIMBkDfJ98HSBVmTyOS
         DG776UbRUBIbRVpsWcYlYR0AYnD+WKxg6p7pF87Ib+A4TV1gEs49jaYeHMcM8kEMdEzs
         6hVpAgmYw+37w1orj7eBLKzw10kZ+g98XiYIbDLGijbue6j+5WJy7E+B+1+IkuEqa4nz
         6DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkvkO0ggi/mdrA5jtRFDVlYd+gaJ5/Kv6++Mtwxlna0=;
        b=dGhPk2ccnUQ3pD2e34B8eERGPCV1aBum6tQtWxnnUPooKvPxqyteih+/Np2M/moUF/
         N52TIEyr9YGSrA8j6RVe0FEXlAdM30IXddFwlsRHMvQ0A0rNQlAG2HoTYzq+NWGNNbQT
         kfrnNV4WuvewvmIkIokFRTzOW4Zay53Vvyv3jPd4YTiUphgWyNSIy9Jdvsx9ollanGzs
         K8a5HIgEDeCddknrwIgr6Vj/b34YGwjLRt26QgmrAq9eni5Z8x/UYGE4d4yOxG8J8705
         GYaDW10+VBE8lpMWxDLKeEDRkIujRqKZtXcIyll6RnGKjbzsFQ+5JbygiBMeDwvwmxCi
         WclQ==
X-Gm-Message-State: AFqh2kpDWtpBBzWzjx1Q2NLvzWFsgLkGG/COhDVILkmANX9VZZskYPFX
        7AXmfuqOnMMqHEoVHpKD5fQ=
X-Google-Smtp-Source: AMrXdXssaf/0Yt2WCueicOBdYZ7lW3vVJlMML+M6/LwwgrR8qJDwT9mj5wqf6rVW0nvLc3RzWX2Dbg==
X-Received: by 2002:a05:600c:4f02:b0:3d9:f217:6f6b with SMTP id l2-20020a05600c4f0200b003d9f2176f6bmr94043wmq.33.1673215028533;
        Sun, 08 Jan 2023 13:57:08 -0800 (PST)
Received: from localhost.localdomain ([2a10:d582:3bb:0:63f8:f640:f53e:dd47])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b003d99469ece1sm14654071wmo.24.2023.01.08.13.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 13:57:08 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 5/7] parport_pc: Add an ECR mask field for PCI devices
Date:   Sun,  8 Jan 2023 21:56:54 +0000
Message-Id: <20230108215656.6433-5-sudipm.mukherjee@gmail.com>
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

Add a bitmask field specifying writable ECR bits for PCI devices and
apply it via `__parport_pc_probe_port'.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_pc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 2928f36e05ff..d7e64f6dfe90 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2662,6 +2662,10 @@ static struct parport_pc_pci {
 	/* Bit field of parport modes to exclude. */
 	unsigned int mode_mask;
 
+	/* If non-zero, sets the bitmask of writable ECR bits.  In that
+	 * case additionally bit 0 will be forcibly set on writes. */
+	unsigned char ecr_writable;
+
 	/* If set, this is called immediately after pci_enable_device.
 	 * If it returns non-zero, no probing will take place and the
 	 * ports will not be used. */
@@ -2868,7 +2872,8 @@ static int parport_pc_pci_probe(struct pci_dev *dev,
 			__parport_pc_probe_port(io_lo, io_hi, irq,
 						PARPORT_DMA_NONE, &dev->dev,
 						IRQF_SHARED,
-						cards[i].mode_mask, 0);
+						cards[i].mode_mask,
+						cards[i].ecr_writable);
 		if (data->ports[count])
 			count++;
 	}
-- 
2.30.2

