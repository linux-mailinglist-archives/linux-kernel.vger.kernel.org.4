Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7726D606810
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJTSSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJTSSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:18:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B07E1E8B88
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:18:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so410357pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+D88zAQmUjUUnV7neTR8OZUejbee9w/pcibOo1Ecx3I=;
        b=RX6sDdyqulsiJ2eQHToA0GFzp10LDvWUvDx6IRf6EVR6AhdRpkEZ3C31uxBaXKyyyL
         onnd+rFlG4Ma9HSCQswC3oq3YKCKZKPcjkgDLQknH6vCFOQZEpF00SWuWUAmVh9ecDkO
         xPebucm2bga0DWiXH2PSC48b08kPlqhNemK1u+HxXw9Oc9LpY7I1L4H/ON9E1A2pIEcG
         koEoZcXSi91k1KD4bTMcEYzypRTsAsx3px1kX4YXAxk2pU4N+T8wmotqYMhLqeoui/cF
         wlGYJ5Kqs1e2RNyGNgGsxj5H7DFFt3XQ7e7W8ogISNtTvZJtTu3GcFaLIrEBrWhj90Aa
         dF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+D88zAQmUjUUnV7neTR8OZUejbee9w/pcibOo1Ecx3I=;
        b=V/eNozAr4hpm2WbbVLo0jNbXCMGC4MAvq6JWCwhAosmt/+fvKQQ73Fw9LmxZP0OuzJ
         IdGbxLqYwnHe3zcMR9iJ4CgEahBsS1CoQF3ZANEUFKyeY5ORVYvFxaJebQYYJphGO/rF
         u7TBDMeTB8pJ8dsP/CwEt2hrSvxc6+2JWWb2jHOe96HqDebld/IChQa2Vak3a7utyumd
         3IlKvmmacH6AUpEALRtPDdEfsxm/bxXp32mQmnRknz6CR3+9NuSc1iLX7x7ceTmHH9wd
         rVtc6MpOeUBgUzglogz1ZNIAceK8xl3ueC7Tx/1VMIPiJxfHTfpCKDVnA4BzN2+zu8Tk
         L98A==
X-Gm-Message-State: ACrzQf2kQIJWYYCerf1zqjhGVRdydlu7HAK4gY27cVxU99utViniByb7
        MLBoZqmV6kUkBeT3Rnzh8M8=
X-Google-Smtp-Source: AMsMyM6QCBdQPq88BTvJLBXTt62lRRB5nHqBuuw/kDUI0aQQnyQfxrhgzxy//6AAVLzHRlPEdlLgbA==
X-Received: by 2002:a17:90b:350d:b0:20d:5438:f59a with SMTP id ls13-20020a17090b350d00b0020d5438f59amr16915677pjb.41.1666289902465;
        Thu, 20 Oct 2022 11:18:22 -0700 (PDT)
Received: from biggie.. ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b001745662d568sm13240581plg.278.2022.10.20.11.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:18:21 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/staging/pi433: Change data type of bit_rate to be u32
Date:   Thu, 20 Oct 2022 23:48:15 +0530
Message-Id: <20221020181815.31245-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A TODO asks to convert the bit_rate variable to be a u32 so that bit 
rates up to 300kbps can be supported as per the spec.

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
Please note that this patch is only compile tested.

 drivers/staging/pi433/TODO       | 2 --
 drivers/staging/pi433/pi433_if.h | 4 ++--
 drivers/staging/pi433/rf69.c     | 2 +-
 drivers/staging/pi433/rf69.h     | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/pi433/TODO b/drivers/staging/pi433/TODO
index 5cf3fd99d521..8530bbe61d70 100644
--- a/drivers/staging/pi433/TODO
+++ b/drivers/staging/pi433/TODO
@@ -1,5 +1,3 @@
 * currently the code introduces new IOCTLs. I'm afraid this is a bad idea.
   -> Replace this with another interface, hints are welcome!
 * Some missing data (marked with ###) needs to be added in the documentation
-* Change (struct pi433_tx_cfg)->bit_rate to be a u32 so that we can support
-    bit rates up to 300kbps per the spec.
diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index 25ee0b77a32c..c958dcfa9f96 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -51,7 +51,7 @@ enum option_on_off {
 #define PI433_TX_CFG_IOCTL_NR	0
 struct pi433_tx_cfg {
 	__u32			frequency;
-	__u16			bit_rate;
+	__u32			bit_rate;
 	__u32			dev_frequency;
 	enum modulation		modulation;
 	enum mod_shaping	mod_shaping;
@@ -99,7 +99,7 @@ struct pi433_tx_cfg {
 #define PI433_RX_CFG_IOCTL_NR	1
 struct pi433_rx_cfg {
 	__u32			frequency;
-	__u16			bit_rate;
+	__u32			bit_rate;
 	__u32			dev_frequency;
 
 	enum modulation		modulation;
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 8c7fab6a46bb..7e754a3aef5f 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -185,7 +185,7 @@ int rf69_set_modulation_shaping(struct spi_device *spi,
 	}
 }
 
-int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate)
+int rf69_set_bit_rate(struct spi_device *spi, u32 bit_rate)
 {
 	int retval;
 	u32 bit_rate_reg;
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 78fa0b8bab8b..46a1fb2d5329 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -24,7 +24,7 @@ int rf69_set_data_mode(struct spi_device *spi, u8 data_mode);
 int rf69_set_modulation(struct spi_device *spi, enum modulation modulation);
 int rf69_set_modulation_shaping(struct spi_device *spi,
 				enum mod_shaping mod_shaping);
-int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate);
+int rf69_set_bit_rate(struct spi_device *spi, u32 bit_rate);
 int rf69_set_deviation(struct spi_device *spi, u32 deviation);
 int rf69_set_frequency(struct spi_device *spi, u32 frequency);
 int rf69_enable_amplifier(struct spi_device *spi, u8 amplifier_mask);
-- 
2.34.1

