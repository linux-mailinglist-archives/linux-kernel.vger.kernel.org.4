Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A80639625
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiKZNei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiKZNec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:34:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69D619298
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:31 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FApH4WYqnnPnCwRs252w67TbC7zTXDysxpl2cWjUjB8=;
        b=gLVa7yvsaj2c/WZvbMLTTLm4DXCJ2D0sg1TAaB4Susl6plHC5g6GXlCVvwZcPlbTsn1ZYA
        P4+rhJkc+/uyLpPwjEmFriwPIte83tp6sCGF5Nx8f9hX209co0niKsu5UQg5+SzTwC62GZ
        fp3JOJuFQxa5jkhNo/k87BPwQjM/tdxwxvwNvNYu0HlQAUEP9iad/2TNB+KpMaKgXfI5Mq
        GWsQXQeIcR+XtSvN9+1eJ0Cv8yrPAP/+j3EeuUpL7BfhaiccOsE36cetPXQrPVdjsinqI4
        GTrjNfxR5X1dJetxYAqkuC4mxXuMXM1x07kvofeWPRcRdu7o2qd5WYzJ/uvBnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FApH4WYqnnPnCwRs252w67TbC7zTXDysxpl2cWjUjB8=;
        b=/13bOpW6JOnt9mQ72+josj1uphNkFVP+VZ1AuJeT1ePkP/uz4gp9MlOIp7u3Q2uijNLYts
        jSD2qYfbvHaebyCw==
From:   "irqchip-bot for Wei Yongjun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/wpcm450: Fix memory leak in
 wpcm450_aic_of_init()
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, j.neuschaefer@gmx.net,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221115092532.1704032-1-weiyongjun@huaweicloud.com>
References: <20221115092532.1704032-1-weiyongjun@huaweicloud.com>
MIME-Version: 1.0
Message-ID: <166946966925.4906.3717360312262701265.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     4208d4faf36573a507b5e5de17abe342e9276759
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/4208d4faf36573a507b5e5de17abe342e9276759
Author:        Wei Yongjun <weiyongjun1@huawei.com>
AuthorDate:    Tue, 15 Nov 2022 09:25:32=20
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 13:29:48=20

irqchip/wpcm450: Fix memory leak in wpcm450_aic_of_init()

If of_iomap() failed, 'aic' should be freed before return. Otherwise
there is a memory leak.

Fixes: fead4dd49663 ("irqchip: Add driver for WPCM450 interrupt controller")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221115092532.1704032-1-weiyongjun@huaweiclo=
ud.com
---
 drivers/irqchip/irq-wpcm450-aic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-wpcm450-aic.c b/drivers/irqchip/irq-wpcm450-=
aic.c
index 0dcbeb1..91df62a 100644
--- a/drivers/irqchip/irq-wpcm450-aic.c
+++ b/drivers/irqchip/irq-wpcm450-aic.c
@@ -146,6 +146,7 @@ static int __init wpcm450_aic_of_init(struct device_node =
*node,
 	aic->regs =3D of_iomap(node, 0);
 	if (!aic->regs) {
 		pr_err("Failed to map WPCM450 AIC registers\n");
+		kfree(aic);
 		return -ENOMEM;
 	}
=20
