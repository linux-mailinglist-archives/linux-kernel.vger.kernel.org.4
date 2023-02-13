Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B02694354
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjBMKoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjBMKn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:43:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DEE17158;
        Mon, 13 Feb 2023 02:43:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 306AFB810AC;
        Mon, 13 Feb 2023 10:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12414C4333D;
        Mon, 13 Feb 2023 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676284997;
        bh=CUH46wTeOwx9zhTRGAsxA0DLFQlKaikmOpM12h4ppVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3wiRa+Pr6BJ8JnisiohjbgJZzKknaFiA/I3ZmrTKFCT/BJ5aX6t6PIYJJaIMWRvC
         R1I9UwqJnssdoJw8nHI0sWXnJOa0p4eJ0umf6XRumYX8orVoFfTVgCmR7LWhRUmegQ
         K9tZYDJQnGrDWsT3jNtRQd0TVlO2gH3cqXAJ8qLJ8zX9s6KP1l46eSPc3nds22nzbc
         jKQPrZAMOEnUegDgcAlYjK+Tj+zpuwZn14k9s0jryTni1MlBQevHIiuap4tyf+G/ST
         lprINV0Hz76ejomhkAD7GD33abBMfh25LVh5o8W6Fzpyk2hQ9lA3Qg5ZMbXBlLQ3H+
         cqhzPGdPSh43A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pRWJc-0004Ws-2a; Mon, 13 Feb 2023 11:44:08 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v6 13/20] x86/uv: Use irq_domain_create_hierarchy()
Date:   Mon, 13 Feb 2023 11:42:55 +0100
Message-Id: <20230213104302.17307-14-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213104302.17307-1-johan+linaro@kernel.org>
References: <20230213104302.17307-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

