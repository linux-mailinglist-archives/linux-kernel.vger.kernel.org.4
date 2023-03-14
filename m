Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9202D6B98A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjCNPMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjCNPMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:12:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1778DA103D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:12:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v16so14730296wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678806739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nf0FCRqxe9mUuT8bqQbLPIB9gEtjE7LcZZoSf7lbVA4=;
        b=yaRKA4uN2v5L9uIAwLPb7NpQeJAFI+g0ykjKF9UkFJbLBqz86FR0mBmQtDoIrQJgaE
         bqnQzKdC0NX48PPGZmgMacf+0c5ZDjkep2cAUmGSyoo90vbk5ylJqUfSv8PQQ1ICa1+l
         reUBCuaGDebC2aM8f4Lrj9KRacn4vBxcDnusK0ah6+L5IlFR3kD74+Zh/upF2yXB3tJc
         MwYgwYzPfYRDEP9+A+256LOFj99hDhj2Dg75gEYwwRjy2MP7P/mxeuvwG88lugGp1KlC
         XCm/UaOb+66IiN5yNAj2pMwAypnc4RFfbgOO+vTF7UU/dO4oE4io7wXRcBHHc7D11mYr
         6RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678806739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nf0FCRqxe9mUuT8bqQbLPIB9gEtjE7LcZZoSf7lbVA4=;
        b=mq3J/7Z+YxL1rCkmgniXNfjgUBNnmF0Ss9niw5e7PO8ma80SId9U+FewGXh31zTZhN
         MBbwjBkkL/kfMY0i60x5R0IRErCopfaaGLfuAyQB96K3ojyKkPz4L0CgUsH/8la9wT7B
         zDIJ1K+Sc/nAOFH6ntyDaz+Xdihcd2RIXDVCk4LkArdwVLoEyWtbmTPoDVGp7SzRKBXB
         sV8RXXWwolx8Fpv3cKXZEfd0q3qVE9p0/b+qV20UVUjf8jzRDStUJtmP25wCxU/Y+qtL
         oanwSM9jrEVNlLArOfDE5FSGo6EJNMF+WR7OoUHtsHkGAvrH9tcVp2rW7OrYqhJGNo27
         4thw==
X-Gm-Message-State: AO0yUKWMHmCjtK+H/bu7jE6zwAv2tusfTHiM6wfzD6heOXd00oHLk9+O
        emtSom/oiaiSzlo/XnUBBxVSHw==
X-Google-Smtp-Source: AK7set/uSd3//AYqqhhCFEfH0Ok5m+lVZ7EXWmn1DGbTtAc6GBfZFFIssch2KDF07MNh+t+ot+3RdA==
X-Received: by 2002:adf:da44:0:b0:2ce:6f5a:c3b8 with SMTP id r4-20020adfda44000000b002ce6f5ac3b8mr18530977wrl.31.1678806739558;
        Tue, 14 Mar 2023 08:12:19 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a247:8056:be7d:83e:a6a5:4659])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d4f89000000b002c707b336c9sm2320158wru.36.2023.03.14.08.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:12:19 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 3/5] can: tcan4x5x: Check size of mram configuration
Date:   Tue, 14 Mar 2023 16:11:59 +0100
Message-Id: <20230314151201.2317134-4-msp@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314151201.2317134-1-msp@baylibre.com>
References: <20230314151201.2317134-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reduce debugging effort in case the mram is misconfigured, add this
size check of the DT configuration. Currently if the mram configuration
doesn't fit into the available MRAM it just overwrites other areas of
the MRAM.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c         | 16 ++++++++++++++++
 drivers/net/can/m_can/m_can.h         |  1 +
 drivers/net/can/m_can/tcan4x5x-core.c |  5 +++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 8e83d6963d85..8ccf20f093f8 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1886,6 +1886,22 @@ static int register_m_can_dev(struct net_device *dev)
 	return register_candev(dev);
 }
 
+int m_can_check_mram_cfg(struct m_can_classdev *cdev, u32 mram_max_size)
+{
+	u32 total_size;
+
+	total_size = cdev->mcfg[MRAM_TXB].off - cdev->mcfg[MRAM_SIDF].off +
+			cdev->mcfg[MRAM_TXB].num * TXB_ELEMENT_SIZE;
+	if (total_size > mram_max_size) {
+		dev_err(cdev->dev, "Total size of mram config(%u) exceeds mram(%u)\n",
+			total_size, mram_max_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(m_can_check_mram_cfg);
+
 static void m_can_of_parse_mram(struct m_can_classdev *cdev,
 				const u32 *mram_config_vals)
 {
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index a839dc71dc9b..d8150d8128e7 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -101,6 +101,7 @@ int m_can_class_register(struct m_can_classdev *cdev);
 void m_can_class_unregister(struct m_can_classdev *cdev);
 int m_can_class_get_clocks(struct m_can_classdev *cdev);
 int m_can_init_ram(struct m_can_classdev *priv);
+int m_can_check_mram_cfg(struct m_can_classdev *cdev, u32 mram_max_size);
 
 int m_can_class_suspend(struct device *dev);
 int m_can_class_resume(struct device *dev);
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 2342aa011647..e706518176e4 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -80,6 +80,7 @@
 	 TCAN4X5X_MCAN_IR_RF1F)
 
 #define TCAN4X5X_MRAM_START 0x8000
+#define TCAN4X5X_MRAM_SIZE 0x800
 #define TCAN4X5X_MCAN_OFFSET 0x1000
 
 #define TCAN4X5X_CLEAR_ALL_INT 0xffffffff
@@ -307,6 +308,10 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	if (!mcan_class)
 		return -ENOMEM;
 
+	ret = m_can_check_mram_cfg(mcan_class, TCAN4X5X_MRAM_SIZE);
+	if (ret)
+		goto out_m_can_class_free_dev;
+
 	priv = cdev_to_priv(mcan_class);
 
 	priv->power = devm_regulator_get_optional(&spi->dev, "vsup");
-- 
2.39.2

