Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D3366C01E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjAPNuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjAPNun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:50:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864272006B;
        Mon, 16 Jan 2023 05:50:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D1360F95;
        Mon, 16 Jan 2023 13:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8F2C433D2;
        Mon, 16 Jan 2023 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673877040;
        bh=WOLEYv/LC2uRo2oOqpCuxx1j2Jg09eJ+FL+Ym0vCxkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7gB9oP1nlNtzHy6VDK5Mbnw+MZRfv/CQ8NrAx76e1s+PSpferOR5tbrxFiNltPDM
         q/SPDI4AS+XNO2gPWB3FhMzrH8Qu+BYh1uFsbEJgepXZSN+bZJlj2yenpb/jMPjwYu
         6N8WmfT35dhIpIjYZ4KL8rRz9IcYi5B48B/6tIKHfji6F7lJgEKWKDn602u09PaPwf
         usbjHvcXLR4HR2KAPJs5YFSc4CMLZo6HPRiPb5wyhRSRJRmYiMPyMMaXWGdrN2KJ1I
         ZRUdzuf11uKMNvgetNjirHXPM4Qv6ZgYhEZ8Fzi1zCbadCy/xsieBkDWhoc6OARX+P
         23K36jP0fbovA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pHPt5-0003um-Ku; Mon, 16 Jan 2023 14:50:59 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v4 02/19] irqdomain: Drop dead domain-name assignment
Date:   Mon, 16 Jan 2023 14:50:27 +0100
Message-Id: <20230116135044.14998-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230116135044.14998-1-johan+linaro@kernel.org>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
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

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
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
2.38.2

