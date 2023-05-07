Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8608F6F9A99
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 19:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjEGRcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 13:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjEGRcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 13:32:04 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF1593E5;
        Sun,  7 May 2023 10:31:59 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QDs183w6jz9snM;
        Sun,  7 May 2023 19:31:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1683480716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUNWYjPvRY3lglH0hDFmfodPM+n7chzcxW6kg3/6LfI=;
        b=KTFFxryD5VQyhohjZxWvZwi1w/B0DoIXUkkKbJ6vjc9uwiEh979A+SLyMJngN+kKVTE+ua
        axtNj5xpOKbtSMczys/eoYxbKDKmkuRl+0ICqL0MKM6zKZPMmenYd7+GMu/4WXUfHamNxX
        bgq5WgIl0n3MqjTsNua5qIxBEkbALNkK24QA2a3DlWPsZ1Fi7+qg3Aog1MqdaTd/S13Cdv
        HL5JRXO1F5a3fU/OtCTOwaNXngJhfG6oRs9GcjSiN213iThAHMrqMRZhDIHIpRrlYJxJKI
        G9e/BqJb25xn2hIjtvT6ua8WTTfAFU3IvCkyHD9r6+2QcAoxDcsCg77eGdbccA==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     pavel@ucw.cz, quic_fenglinw@quicinc.com, lee@kernel.org
Cc:     trix@redhat.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH 1/2] leds: flash: leds-qcom-flash: add PMI8998 support
Date:   Sun,  7 May 2023 19:29:40 +0200
Message-Id: <20230507172941.364852-2-me@dylanvanassche.be>
In-Reply-To: <20230507172941.364852-1-me@dylanvanassche.be>
References: <20230507172941.364852-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add subtype for the Qualcomm PMI8998 PMIC to support it besides the
PM8150 PMIC which has the same registers. Adjust the driver to recognize
both PMIC subtypes as a 3 channel LED driver.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 drivers/leds/flash/leds-qcom-flash.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
index 90a24fa25a49..16045b5d89b1 100644
--- a/drivers/leds/flash/leds-qcom-flash.c
+++ b/drivers/leds/flash/leds-qcom-flash.c
@@ -18,7 +18,8 @@
 #define FLASH_TYPE_VAL			0x18
 
 #define FLASH_SUBTYPE_REG		0x05
-#define FLASH_SUBTYPE_3CH_VAL		0x04
+#define FLASH_SUBTYPE_3CH_PM8150_VAL	0x04
+#define FLASH_SUBTYPE_3CH_PMI8998_VAL	0x03
 #define FLASH_SUBTYPE_4CH_VAL		0x07
 
 #define FLASH_STS_3CH_OTST1		BIT(0)
@@ -682,7 +683,7 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
 		return rc;
 	}
 
-	if (val == FLASH_SUBTYPE_3CH_VAL) {
+	if (val == FLASH_SUBTYPE_3CH_PM8150_VAL || val == FLASH_SUBTYPE_3CH_PMI8998_VAL) {
 		flash_data->hw_type = QCOM_MVFLASH_3CH;
 		flash_data->max_channels = 3;
 		regs = mvflash_3ch_regs;
-- 
2.40.1

