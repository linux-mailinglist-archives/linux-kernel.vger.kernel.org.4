Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6F6690A2F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjBINbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBINar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:30:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3125A901;
        Thu,  9 Feb 2023 05:30:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B901CB82130;
        Thu,  9 Feb 2023 13:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF381C43443;
        Thu,  9 Feb 2023 13:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675949442;
        bh=/tiungLfitFlSrlnkn8ELqW8HMOoeWc08EIHOdGt7VA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kNUJPPGiLLrkXQ7Lc7KLWcNPIwf6YxkF+AjzZksfbfktoP2qeVtUh6bdWj/JsgCGk
         IuMGLGxWE+YmDJzztXFF1K/jXBzj2fLnoJBl372+kNML0FeheTA/twBYfynl+UW31m
         y5uKw2SQPdKBYGv+Z3ZjuW0abhbEJHXbZEmNA4m4O7mkCR1TXzf/TLnNRwVmYI3n9E
         mmLwPPGfUYX5ZiM72NuqXoUW9OuuVj11EskLUvkGL4czFr4MqAsOdt8ZXzAlJvqTHp
         uvAQ8EHFwT9Fch1BwQYUz0I8zdzppnGTQxV4hRfAve+gpepM7V6OCBAOzgn79dj4X1
         cHA9F7W2qCLXw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pQ71G-0001L0-Pm; Thu, 09 Feb 2023 14:31:22 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v5 08/19] irqdomain: Drop dead domain-name assignment
Date:   Thu,  9 Feb 2023 14:23:12 +0100
Message-Id: <20230209132323.4599-9-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209132323.4599-1-johan+linaro@kernel.org>
References: <20230209132323.4599-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 28d74549414b..3d635b8bb465 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -598,10 +598,6 @@ static int irq_domain_associate_locked(struct irq_domain *domain, unsigned int v
 			irq_data->hwirq = 0;
 			return ret;
 		}
-
-		/* If not already assigned, give the domain the chip's name */
-		if (!domain->name && irq_data->chip)
-			domain->name = irq_data->chip->name;
 	}
 
 	domain->mapcount++;
@@ -1155,10 +1151,6 @@ static void irq_domain_insert_irq(int virq)
 
 		domain->mapcount++;
 		irq_domain_set_mapping(domain, data->hwirq, data);
-
-		/* If not already assigned, give the domain the chip's name */
-		if (!domain->name && data->chip)
-			domain->name = data->chip->name;
 	}
 
 	irq_clear_status_flags(virq, IRQ_NOREQUEST);
-- 
2.39.1

