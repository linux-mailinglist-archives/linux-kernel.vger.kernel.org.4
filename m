Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751EC7330AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345018AbjFPMDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjFPMDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:03:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151BE2D69
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:03:10 -0700 (PDT)
Date:   Fri, 16 Jun 2023 12:03:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686916988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qslilxqb17Qg1KdD9iaupjHB/4/PR5d5YA9RfgkQbcA=;
        b=iqLKCxJXJ3nP394LZUEqtpH3hQ1wmmD3OyVO/f9zy7x+4cpmYO/n7jy60iOn9pHg6y/cOK
        Y++rnMoKK96KZc9nOT9WyL/FaKC8ud3JFU/6UxdhNYQRnb74tEUxIfWAp686lG/G4h0XLy
        AtRicUMINyfPiXgZEMLTKEDPEsav3wy10yubR1V/4CslCSwkl+6fuauw6MLoBSenLR1jbt
        qhjKJ+0tma4FbtV0Ppg0s5OgFdQo4mBNMIOJyykInlMP8Dyrzbx/2SkcZ2R8W8MtgIZhg+
        6XzPOsuTHn+oCHaqL56Vchj2D+Tmedm05NIdi/WPup1VRJmNGwaZphNGM1PSEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686916988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qslilxqb17Qg1KdD9iaupjHB/4/PR5d5YA9RfgkQbcA=;
        b=NJF665p6u0dRI+g27pJdl9Ng/TnrEhPNhtf/PSkQcE+K8ahAhKaXL34fLI4RJ7ucfScmtk
        01pb/g9J9XuxtMCA==
From:   "irqchip-bot for Jianmin Lv" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-eiointc: Fix irq
 affinity setting during resume
Cc:     yangqiming <yangqiming@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230614115936.5950-6-lvjianmin@loongson.cn>
References: <20230614115936.5950-6-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <168691698801.404.17071829234884391281.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     fb07b8f83441febeb0daf199b5f18c6de9bbab03
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/fb07b8f83441febeb0daf199b5f18c6de9bbab03
Author:        Jianmin Lv <lvjianmin@loongson.cn>
AuthorDate:    Wed, 14 Jun 2023 19:59:36 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 16 Jun 2023 12:59:28 +01:00

irqchip/loongson-eiointc: Fix irq affinity setting during resume

The hierarchy of PCH PIC, PCH PCI MSI and EIONTC is as following:

        PCH PIC ------->|
                        |---->EIOINTC
        PCH PCI MSI --->|

so the irq_data list of irq_desc for IRQs on PCH PIC and PCH PCI MSI
is like this:

irq_desc->irq_data(domain: PCH PIC)->parent_data(domain: EIOINTC)
irq_desc->irq_data(domain: PCH PCI MSI)->parent_data(domain: EIOINTC)

In eiointc_resume(), the irq_data passed into eiointc_set_irq_affinity()
should be matched to EIOINTC domain instead of PCH PIC or PCH PCI MSI
domain, so fix it.

Fixes: a90335c2dfb4 ("irqchip/loongson-eiointc: Add suspend/resume support")

Reported-by: yangqiming <yangqiming@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230614115936.5950-6-lvjianmin@loongson.cn
---
 drivers/irqchip/irq-loongson-eiointc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 71ef19f..a7fcde3 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -314,7 +314,7 @@ static void eiointc_resume(void)
 			desc = irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
 			if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
 				raw_spin_lock(&desc->lock);
-				irq_data = &desc->irq_data;
+				irq_data = irq_domain_get_irq_data(eiointc_priv[i]->eiointc_domain, irq_desc_get_irq(desc));
 				eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
 				raw_spin_unlock(&desc->lock);
 			}
