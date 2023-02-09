Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345C7690A39
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjBINbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjBINav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:30:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A9E5EBF5;
        Thu,  9 Feb 2023 05:30:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98DEBB82143;
        Thu,  9 Feb 2023 13:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596E2C4333D;
        Thu,  9 Feb 2023 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675949443;
        bh=CUH46wTeOwx9zhTRGAsxA0DLFQlKaikmOpM12h4ppVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slw/hj1S/XeU+KKtyA0HKphJhu31WTvfBhywUH7t1ewc3qDR2XuntztVosWwhOwMO
         KVx3EhSV94TVN4wDk1tgsSdiv1z/6Q8ZiBVyfi/d6fXVBC9skGunDYcdUTpY+olWBl
         9yXFKvVlWl/w1TvfmtBU+qbWBZ+mX8AJTl2U0hw0bUPy91tXW1L6B5Huvl/O2jd1/8
         9ivRtx2HYM9o0aVqS1LVrbHm9Az+F0epLbm5rDUkSfXxWt4BqRyyqco/c3traWvlbQ
         Iqhib/OEire19qpGYAws0JwY5lrnjszJbJeDNdhe4DNwoAKGrVMvsiJ4CG4fL2keWa
         cNEv/uyT70gVw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pQ71H-0001LM-54; Thu, 09 Feb 2023 14:31:23 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v5 12/19] x86/apic: Use irq_domain_create_hierarchy()
Date:   Thu,  9 Feb 2023 14:23:16 +0100
Message-Id: <20230209132323.4599-13-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209132323.4599-1-johan+linaro@kernel.org>
References: <20230209132323.4599-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the irq_domain_create_hierarchy() helper to create the hierarchical
domain, which both serves as documentation and avoids poking at
irqdomain internals.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/x86/platform/uv/uv_irq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index 1a536a187d74..ee21d6a36a80 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -166,10 +166,9 @@ static struct irq_domain *uv_get_irq_domain(void)
 	if (!fn)
 		goto out;
 
-	uv_domain = irq_domain_create_tree(fn, &uv_domain_ops, NULL);
-	if (uv_domain)
-		uv_domain->parent = x86_vector_domain;
-	else
+	uv_domain = irq_domain_create_hierarchy(x86_vector_domain, 0, 0, fn,
+						&uv_domain_ops, NULL);
+	if (!uv_domain)
 		irq_domain_free_fwnode(fn);
 out:
 	mutex_unlock(&uv_lock);
-- 
2.39.1

