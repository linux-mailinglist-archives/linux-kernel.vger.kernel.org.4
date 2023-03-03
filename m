Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF7B6AA2F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 22:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjCCVwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 16:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjCCVum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 16:50:42 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223CC2712;
        Fri,  3 Mar 2023 13:46:44 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|hussein@unixcat.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D0AE3880E3E;
        Fri,  3 Mar 2023 21:45:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5A65B88101F;
        Fri,  3 Mar 2023 21:45:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677879933; a=rsa-sha256;
        cv=none;
        b=MEGxXBHUnxusvezEG69tROrDKDyqKvgEZdl1jXELcQk9v1sc4+/MduaVF6wnHdAxIeJyqx
        A7U0LAaH4pD0ij1+jhL0aixFmLmTnkABP3WHngMIh/RUWZzxi0hxFtC0FyV42hZKTh8UX2
        y+sfFLiVJzi4k1PPlN5mu7LzI1Udq800wF0UtMZAJGxqO2SLH/xHN66fbSCtEQYv7WvmJr
        +F/127Otw6r0lul0uTu+zGb5cXMswDGkp22RGvf+A6+y/wg2PnskKDYfBDMu5cvyUZByKk
        GfTb8fpgn9fvGtqCiwHToS4c+y8DTcmf91Af94JAlWaHHEtGuoeMxEVxUi5kgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677879933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=u+9GNR2JIWiMQyC7QKqhP3pgacqFjUfe90nVtUf476g=;
        b=CUBNET4t3cRwCazTcnBPrSHso18jBObrz1NQlAjdF7uTA5uLkd0vIFg24pfnxG7EIow6ri
        rR6VGv00EF+knI8sbyqWdC0tP0sSZe0M4P6Mj4edb26lWEhOwcqzH5SyfPqOuaJiQLFpQ8
        56n2djtNTt3OmhsUCUb+KUtPSHHgrpSBNWxDMkiDRraDXOeZWcIPSDVeO+qrZgc4jD2RGv
        +OGoEvX9TtBdXYTYeaX9JZPIpZQMamM0XUMDv/rwoP316PkzwqN7jg2SA1OdZcDAkh77tO
        owShcZebq7hx29wz/MUJKPrnW4nAdilJinLhwKznPExRnQYz+iv6bI7DdxJR+w==
ARC-Authentication-Results: i=1;
        rspamd-fd4f5fb8c-t7qck;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=hussein@unixcat.org
X-Sender-Id: dreamhost|x-authsender|hussein@unixcat.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|hussein@unixcat.org
X-MailChannels-Auth-Id: dreamhost
X-Turn-Chemical: 4fa4edc10520b167_1677879933636_439526163
X-MC-Loop-Signature: 1677879933636:854917284
X-MC-Ingress-Time: 1677879933636
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.33.161 (trex/6.7.2);
        Fri, 03 Mar 2023 21:45:33 +0000
Received: from localhost (unknown [175.144.191.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hussein@unixcat.org)
        by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4PT1jm4YpPzqw;
        Fri,  3 Mar 2023 13:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unixcat.org;
        s=dreamhost; t=1677879933;
        bh=u+9GNR2JIWiMQyC7QKqhP3pgacqFjUfe90nVtUf476g=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=qkRGTl7whr+bfZYrsZNtXxHdxZjfkSwhoBAtn4qzOK41rF9h6beGnlGtG3BUL+xyV
         SznlIC47+lpYNbcdAa6nj/svz34+i+upnR1//JSBCcgbPfVDJrzQ2LnkjlO0JVyAmZ
         dHvXfoqleB6VTajRRArX4Jk/aoZMP+Z27MiSSxWg=
From:   Nur Hussein <hussein@unixcat.org>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nur Hussein <hussein@unixcat.org>
Subject: [PATCH] Error checking for spi_setup during probe function added to rtc-m41t94 driver
Date:   Sat,  4 Mar 2023 05:45:26 +0800
Message-Id: <20230303214526.1831504-1-hussein@unixcat.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The m41t94_probe() function calls spi_setup() but does not check for an
error upon return. I have added this check, and returns the error and
sets the error message via dev_error to "spi_setup failed".

Signed-off-by: Nur Hussein <hussein@unixcat.org>
---
 drivers/rtc/rtc-m41t94.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-m41t94.c b/drivers/rtc/rtc-m41t94.c
index 6803b0273302..4bdee2336228 100644
--- a/drivers/rtc/rtc-m41t94.c
+++ b/drivers/rtc/rtc-m41t94.c
@@ -112,7 +112,12 @@ static int m41t94_probe(struct spi_device *spi)
 	int res;
 
 	spi->bits_per_word = 8;
-	spi_setup(spi);
+
+	res = spi_setup(spi);
+	if (res < 0) {
+		dev_err(&spi->dev, "spi setup failed.\n");
+		return res;
+	}
 
 	res = spi_w8r8(spi, M41T94_REG_SECONDS);
 	if (res < 0) {
-- 
2.34.1

