Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70B7639623
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKZNee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKZNec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:34:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B751902C
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:31 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SmCYCGm0BvBvyxk+DEsBy+/4EqgLZrxk2j9sfi/hvfE=;
        b=UzfQBnYhZugsSNFGv4d2pyxJo+4c36wdtIv3Ow97wSopEu9aJVS1j5eQwEW8Vj34QAR+Kv
        PvylmQb3QXfTaoIExLYGbEEBhUWKcDgTR6++k8YvS0gEPyuDRPxQOesWtgRuYTp0N+IM9P
        sP7M9ZSd/mVW19gIojr9w3xMCBvhWnp5VUImGwZhZN+tNQwZigw/yPXMGJ42v+bvEEA9IL
        DHehWiWncOvtCQyIgPbDeVgkpDULxqDMiRqPSvwKhbe+f8jthbPxgAE+3p1KveSXhEK/bl
        ls/KKOnAa3fSBSIfstmhWU7p9EtkXQ3B4dzFFrtLqyqniTAdX72la3EXea1a7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SmCYCGm0BvBvyxk+DEsBy+/4EqgLZrxk2j9sfi/hvfE=;
        b=q02x4p5k9tq5hDeBGsIAa+xR+9wDaNrIe74KomOqUIP/tM9fLir/FYdqMy70FMWI796ANT
        UDXNz0ilNNmMaLBA==
From:   "irqchip-bot for Liu Peibao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-liointc: Fix improper
 error handling in liointc_init()
Cc:     Liu Peibao <liupeibao@loongson.cn>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20221104110712.23300-1-liupeibao@loongson.cn>
References: <20221104110712.23300-1-liupeibao@loongson.cn>
MIME-Version: 1.0
Message-ID: <166946966692.4906.8560659273979544805.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     4a60a3cdcf1875c965095eb9e22c3d12bbc5a53d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4a60a3cdcf1875c965095eb9e22c3d12bbc5a53d
Author:        Liu Peibao <liupeibao@loongson.cn>
AuthorDate:    Fri, 04 Nov 2022 19:07:12 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 13:29:57 

irqchip/loongson-liointc: Fix improper error handling in liointc_init()

For cores less than 4, eg, loongson2k1000 with 2 cores, the
of_property_match_string() may return with an error value,
which causes that liointc could not work. At least isr0 is
what should be checked like previous commit b2c4c3969fd7
("irqchip/loongson-liointc: irqchip add 2.0 version") did.

Fixes: 0858ed035a85 ("irqchip/loongson-liointc: Add ACPI init support")
Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221104110712.23300-1-liupeibao@loongson.cn
---
 drivers/irqchip/irq-loongson-liointc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 0da8716..c4584e2 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -207,10 +207,13 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
 					"reg-names", core_reg_names[i]);
 
 			if (index < 0)
-				goto out_iounmap;
+				continue;
 
 			priv->core_isr[i] = of_iomap(node, index);
 		}
+
+		if (!priv->core_isr[0])
+			goto out_iounmap;
 	}
 
 	/* Setup IRQ domain */
