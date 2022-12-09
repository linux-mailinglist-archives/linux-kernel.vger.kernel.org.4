Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFAF648352
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiLIOFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiLIOFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:05:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496E678686;
        Fri,  9 Dec 2022 06:05:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3185B82880;
        Fri,  9 Dec 2022 14:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE20C433F2;
        Fri,  9 Dec 2022 14:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670594713;
        bh=N1BLDRjjNKEXoxfIcTMF9Q00bHff3r4yykAh+872CX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TtPqP036tkrcpv8Bt8ZY85ddGfPygznR0oI4wrG4ml4cOxlh6GVIgC5zOR8M9UJjh
         Uh9O2pzEW7CpDacllUilQyJnITlv2eyNBoQN1j0hw+49TBfYAoMKTzggSQVSkG7p4b
         T9cehDQjtLS2DQTRdBEy5zRBVLsirgEKLn8emPyVRIS/0zEWbYxJW7lCNfQO/VMoI6
         yAC9rNvM6NGAP2CcipblH0bRWIegOw9ze3sAVakaSO3wSe4iCsZaMOfl6AWoQ7q7kM
         mQU2FNCRbCIjg4YF8g4WPIYIwV36kZ3orKASqrvbFDDlQb15WEizOxfA3appk0sg5R
         hFHPmeEi/25gA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p3e0I-0000RR-9J; Fri, 09 Dec 2022 15:05:30 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 02/19] irqdomain: Drop dead domain-name assignment
Date:   Fri,  9 Dec 2022 15:01:33 +0100
Message-Id: <20221209140150.1453-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221209140150.1453-1-johan+linaro@kernel.org>
References: <20221209140150.1453-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d59f6617eef0 ("genirq: Allow fwnode to carry name
information only") an IRQ domain is always given a name during
allocation (e.g. used for the debugfs entry).

Drop the leftover name assignment when allocating the first IRQ.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 kernel/irq/irqdomain.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index bf67de1733ee..fe9ec53fe7aa 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -593,10 +593,6 @@ int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
 			mutex_unlock(&irq_domain_mutex);
 			return ret;
 		}
-
-		/* If not already assigned, give the domain the chip's name */
-		if (!domain->name && irq_data->chip)
-			domain->name = irq_data->chip->name;
 	}
 
 	domain->mapcount++;
@@ -1118,10 +1114,6 @@ static void irq_domain_insert_irq(int virq)
 
 		domain->mapcount++;
 		irq_domain_set_mapping(domain, data->hwirq, data);
-
-		/* If not already assigned, give the domain the chip's name */
-		if (!domain->name && data->chip)
-			domain->name = data->chip->name;
 	}
 
 	irq_clear_status_flags(virq, IRQ_NOREQUEST);
-- 
2.37.4

