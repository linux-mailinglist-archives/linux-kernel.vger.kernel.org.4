Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310A55B4D94
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiIKKpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiIKKpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:45:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B8E1A80D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:45:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r17so13948094ejy.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=gV8fTFzQ9QuQyibPPmknRwrm0cpQSXvIjVeP1F06DNg=;
        b=aImQoD96l+vLllY9AvIKt8nI7o1w2Xb1S/g5l2fnTZpf/IClk/HYfJHkooHJduJ4aS
         PqcOeCg3uxkzfIiXkKHpqnTHrDa4nIpq58taNErtoerFWwxbsC5YVzKla3DuoYnAFpIm
         6aGkpvnkjfCLHI6lLlO8bY9I9U/IhObgpWZDXe1h1dfARwg9Rh3Ph4tdpx7a72QoPKBD
         Ixcdoh8ef3Bq3W1B7INUWF+WJyAUt3Af9aKab7974EB/AP+VnbXZozfLyx8BjjObuAS+
         YR+W+Il+uwOwq11+GWXQOW6lW5H6DPObc8Y1rsRNAw2KHsOUBsOqBLCzMIx774fTlymS
         NkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gV8fTFzQ9QuQyibPPmknRwrm0cpQSXvIjVeP1F06DNg=;
        b=IywmMzXWpIjpbZ+zwBGUwkR3dvJGjSA7xJ1mp8cGmqOUhX9pvotcCdAPz1tKj+utDp
         UFMffU2Jq+0ilcWvUqTHLkx97FcpYozsd95qoIp5ITtTxgu4R9wkq9CWxwHoXkWuRQvj
         SXX9ecnYvj003AzpVjwTS5vSb9vyOwpKSJNwjQJ7Uxj+jODEEt2P+u2pFuM7YTr/Z/0b
         wBL0F+QevyOlC989YDZgAXhvvs/TuTIMeD7UveZ39czK9fr4TByS0WnmYkf98SAgySOv
         AlOkBqSwLeM13sH8HUqkn9r1UP8peY46xAIN8TH3uMbr4NOePDCrOjiJRhBikbMU7FFG
         cYPg==
X-Gm-Message-State: ACgBeo0E7xVQDkiKkjUz/sMgxhajgh53pwBlzoW+p/wLVw1uqP95DRib
        K9lG1ACmUvmKwmyHLYERiuA=
X-Google-Smtp-Source: AA6agR5BK/qFkqEBuGgyTzpznO75iyQspsKyruoPLrI1zWNPN2qwzD3ptUBP6HykL+aZg5DbJ2HMjg==
X-Received: by 2002:a17:906:730d:b0:73d:c8a1:a6ae with SMTP id di13-20020a170906730d00b0073dc8a1a6aemr15738297ejc.540.1662893131309;
        Sun, 11 Sep 2022 03:45:31 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id t8-20020a170906268800b0073dde7c1767sm2810121ejc.175.2022.09.11.03.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 03:45:31 -0700 (PDT)
Date:   Sun, 11 Sep 2022 12:45:29 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] staging: vt6655: Cleanup and rename function
 MACvSetLoopbackMode
Message-ID: <02ce61620e13eb7fd24833e59a288f52bf5b9730.1662890990.git.philipp.g.hortmann@gmail.com>
References: <cover.1662890990.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662890990.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function MACvSetLoopbackMode to vt6655_mac_set_loopback_mode and
byLoopbackMode to loopback_mode to avoid CamelCase which is not accepted
by checkpatch.pl. Remove unnecessary declaration of function and made
function static. Change declaration of loopback_mode to shorten code and
remove unnecessary line break.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.c | 17 ++++++++---------
 drivers/staging/vt6655/mac.h |  2 --
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index d056df1220d3..567bc38ecfa9 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -13,7 +13,7 @@
  *      vt6655_mac_is_reg_bits_off - Test if All test Bits Off
  *      vt6655_mac_set_short_retry_limit - Set 802.11 Short Retry limit
  *      MACvSetLongRetryLimit - Set 802.11 Long Retry limit
- *      MACvSetLoopbackMode - Set MAC Loopback Mode
+ *      vt6655_mac_set_loopback_mode - Set MAC Loopback Mode
  *      MACvSaveContext - Save Context of MAC Registers
  *      MACvRestoreContext - Restore Context of MAC Registers
  *      MACbSoftwareReset - Software Reset MAC
@@ -152,21 +152,20 @@ void MACvSetLongRetryLimit(struct vnt_private *priv,
  * Parameters:
  *  In:
  *      io_base        - Base Address for MAC
- *      byLoopbackMode  - Loopback Mode
+ *      loopback_mode  - Loopback Mode
  *  Out:
  *      none
  *
  * Return Value: none
  *
  */
-void MACvSetLoopbackMode(struct vnt_private *priv, unsigned char byLoopbackMode)
+static void vt6655_mac_set_loopback_mode(struct vnt_private *priv, u8 loopback_mode)
 {
 	void __iomem *io_base = priv->port_offset;
 
-	byLoopbackMode <<= 6;
+	loopback_mode <<= 6;
 	/* set TCR */
-	iowrite8((ioread8(io_base + MAC_REG_TEST) & 0x3f) | byLoopbackMode,
-		 io_base + MAC_REG_TEST);
+	iowrite8((ioread8(io_base + MAC_REG_TEST) & 0x3f) | loopback_mode, io_base + MAC_REG_TEST);
 }
 
 /*
@@ -476,13 +475,13 @@ bool MACbShutdown(struct vnt_private *priv)
 	void __iomem *io_base = priv->port_offset;
 	/* disable MAC IMR */
 	iowrite32(0, io_base + MAC_REG_IMR);
-	MACvSetLoopbackMode(priv, MAC_LB_INTERNAL);
+	vt6655_mac_set_loopback_mode(priv, MAC_LB_INTERNAL);
 	/* stop the adapter */
 	if (!MACbSafeStop(priv)) {
-		MACvSetLoopbackMode(priv, MAC_LB_NONE);
+		vt6655_mac_set_loopback_mode(priv, MAC_LB_NONE);
 		return false;
 	}
-	MACvSetLoopbackMode(priv, MAC_LB_NONE);
+	vt6655_mac_set_loopback_mode(priv, MAC_LB_NONE);
 	return true;
 }
 
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index a70e75ff78cd..f7d00a251677 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -553,8 +553,6 @@ void vt6655_mac_set_short_retry_limit(struct vnt_private *priv, unsigned char re
 
 void MACvSetLongRetryLimit(struct vnt_private *priv, unsigned char byRetryLimit);
 
-void MACvSetLoopbackMode(struct vnt_private *priv, unsigned char byLoopbackMode);
-
 void MACvSaveContext(struct vnt_private *priv, unsigned char *cxt_buf);
 void MACvRestoreContext(struct vnt_private *priv, unsigned char *cxt_buf);
 
-- 
2.37.3

