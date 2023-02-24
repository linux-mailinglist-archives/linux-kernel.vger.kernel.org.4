Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760456A1F85
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjBXQWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjBXQWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:22:06 -0500
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276AF64D74
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:22:04 -0800 (PST)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1677255722; bh=5doeosS9EHjVo4INuIYpNqv+kkFiPbeHbMYZHjoGVWM=;
        h=From:To:Cc:Subject:Date;
        b=G8ZShmzQ+zrOvl6A66hdsEM7QQBjCPXjk1zWtDJaDT8gF3BVhGVnR6C3HfcxhjbeJ
         AWCsjd7GvztCq8pMIfE5F5nN/EgBJgRDJfSBHW+ySkqU09iBnihIg6FlbjgFHmwtRN
         aHG1X9lB98Yeds3fsNOurHa40DgtwZ5ptNq7OKfA=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH] soc: apple: rtkit: Crop syslog messages
Date:   Fri, 24 Feb 2023 17:21:59 +0100
Message-Id: <20230224162159.46348-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crop trailing whitespace, null, and newline characters in syslog
messages received from coprocessors. Notably DCP sends its messages
including a trailing newline, so prior to this change we would end up
cluttering the kernel log by repeated newlines at the end of messages.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 drivers/soc/apple/rtkit.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index 35ec35aa500d..639f5134d159 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -409,11 +409,17 @@ static void apple_rtkit_syslog_rx_init(struct apple_rtkit *rtk, u64 msg)
 		rtk->syslog_n_entries, rtk->syslog_msg_size);
 }
 
+static bool should_crop_syslog_char(char c)
+{
+	return c == '\n' || c == '\r' || c == ' ' || c == '\0';
+}
+
 static void apple_rtkit_syslog_rx_log(struct apple_rtkit *rtk, u64 msg)
 {
 	u8 idx = msg & 0xff;
 	char log_context[24];
 	size_t entry_size = 0x20 + rtk->syslog_msg_size;
+	int msglen;
 
 	if (!rtk->syslog_msg_buffer) {
 		dev_warn(
@@ -446,7 +452,13 @@ static void apple_rtkit_syslog_rx_log(struct apple_rtkit *rtk, u64 msg)
 			   rtk->syslog_msg_size);
 
 	log_context[sizeof(log_context) - 1] = 0;
-	rtk->syslog_msg_buffer[rtk->syslog_msg_size - 1] = 0;
+
+	msglen = rtk->syslog_msg_size - 1;
+	while (msglen > 0 &&
+		   should_crop_syslog_char(rtk->syslog_msg_buffer[msglen - 1]))
+		msglen--;
+
+	rtk->syslog_msg_buffer[msglen] = 0;
 	dev_info(rtk->dev, "RTKit: syslog message: %s: %s\n", log_context,
 		 rtk->syslog_msg_buffer);
 
-- 
2.33.0

