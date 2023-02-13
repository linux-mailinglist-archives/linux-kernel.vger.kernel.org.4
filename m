Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5869434F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjBMKoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjBMKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:43:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058B915C8D;
        Mon, 13 Feb 2023 02:43:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF61060F98;
        Mon, 13 Feb 2023 10:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB2FC4332B;
        Mon, 13 Feb 2023 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676284996;
        bh=G4mWOCUvHTQGYHmRB/UF8iuUGYF8As5e5KSKQ7KrbSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mb6wAn9sS0BB0Lc0j8fJ8Llr8LMqVWwH45Mnld0oVxfCYtZp9AhC7Dg0QMRGdeJX9
         OyD9xwcd/1AzVZ9ncIO3G9GPog38JvWjGVKy6A518HqRvDjVrnTNWMtcdZlRQmGk95
         fO/498pm8f4c78JyTtOslRhcKhXjltIjkLb8xKg1ZGq0MBzQ5fAhOPgEcuS1AE4uZz
         XVcgyFPSIdVUKQnHmht1StsuuB+OuZQmTceP+q+a6KfDKvI2cA8pizZJySIRgWX9WC
         YxqBePIAw/PCuyiaYlDoJmqcxsB18uoVStLnWvMRXOQAByyvzzzayNawyp835Rjs8N
         aGNLy4qLC0gfw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pRWJb-0004Wf-NK; Mon, 13 Feb 2023 11:44:07 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v6 09/20] irqdomain: Drop dead domain-name assignment
Date:   Mon, 13 Feb 2023 11:42:51 +0100
Message-Id: <20230213104302.17307-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213104302.17307-1-johan+linaro@kernel.org>
References: <20230213104302.17307-1-johan+linaro@kernel.org>
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
index f2247186f71d..9bba31de6928 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -619,10 +619,6 @@ static int irq_domain_associate_locked(struct irq_domain *domain, unsigned int v
 			irq_data->hwirq = 0;
 			return ret;
 		}
-
-		/* If not already assigned, give the domain the chip's name */
-		if (!domain->name && irq_data->chip)
-			domain->name = irq_data->chip->name;
 	}
 
 	domain->mapcount++;
@@ -1182,10 +1178,6 @@ static void irq_domain_insert_irq(int virq)
 
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

