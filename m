Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197D36F14FF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345477AbjD1KJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345883AbjD1KJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:09:37 -0400
Received: from harvie.cz (harvie.cz [77.87.242.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 809BC40F8;
        Fri, 28 Apr 2023 03:09:36 -0700 (PDT)
Received: from anemophobia.amit.cz (unknown [31.30.84.130])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by harvie.cz (Postfix) with ESMTPSA id 418B618027D;
        Fri, 28 Apr 2023 12:09:34 +0200 (CEST)
From:   Tomas Mudrunka <tomas.mudrunka@gmail.com>
To:     jeff@labundy.com
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, tomas.mudrunka@gmail.com
Subject: [PATCH v3] Fix freeze in lm8333 i2c keyboard driver
Date:   Fri, 28 Apr 2023 12:09:25 +0200
Message-Id: <20230428100925.809527-1-tomas.mudrunka@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZEnErxfnSn2JOpvm@nixie71>
References: <ZEnErxfnSn2JOpvm@nixie71>
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
To fix this we run the interrupt handler after registering IRQ
to clear the interrupt via i2c command.

Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
---
 drivers/input/keyboard/lm8333.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
index 7457c3220..9a810ca00 100644
--- a/drivers/input/keyboard/lm8333.c
+++ b/drivers/input/keyboard/lm8333.c
@@ -184,6 +184,8 @@ static int lm8333_probe(struct i2c_client *client)
 	if (err)
 		goto free_mem;
 
+	lm8333_irq_thread(client->irq, (void *) lm8333);
+
 	err = input_register_device(input);
 	if (err)
 		goto free_irq;
-- 
2.40.0
