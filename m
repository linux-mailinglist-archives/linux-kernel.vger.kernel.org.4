Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E046F5B37
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjECPco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjECPcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:32:42 -0400
Received: from harvie.cz (harvie.cz [77.87.242.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 580E45271;
        Wed,  3 May 2023 08:32:40 -0700 (PDT)
Received: from anemophobia.amit.cz (unknown [31.30.84.130])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by harvie.cz (Postfix) with ESMTPSA id 9F8EA1800F6;
        Wed,  3 May 2023 17:32:37 +0200 (CEST)
From:   Tomas Mudrunka <tomas.mudrunka@gmail.com>
To:     tomas.mudrunka@gmail.com
Cc:     dmitry.torokhov@gmail.com, jeff@labundy.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] Fix freeze in lm8333 i2c keyboard driver
Date:   Wed,  3 May 2023 17:32:31 +0200
Message-Id: <20230503153231.1136114-1-tomas.mudrunka@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CAH2-hcJYVpBNwnMS6qUp4=MW8kSryDAz7G5cNA8R00QabC9bjg@mail.gmail.com>
References: <CAH2-hcJYVpBNwnMS6qUp4=MW8kSryDAz7G5cNA8R00QabC9bjg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_PASS,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LM8333 uses gpio interrupt line which is triggered by falling edge.
When button is pressed before driver is loaded,
driver will miss the edge and never respond again.
To fix this we run the interrupt handler before registering IRQ
to clear the interrupt via i2c command.

Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
---
 drivers/input/keyboard/lm8333.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
index 7457c3220..52108c370 100644
--- a/drivers/input/keyboard/lm8333.c
+++ b/drivers/input/keyboard/lm8333.c
@@ -178,6 +178,8 @@ static int lm8333_probe(struct i2c_client *client)
 			dev_warn(&client->dev, "Unable to set active time\n");
 	}
 
+	lm8333_irq_thread(client->irq, lm8333);
+
 	err = request_threaded_irq(client->irq, NULL, lm8333_irq_thread,
 				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				   "lm8333", lm8333);
-- 
2.40.1
