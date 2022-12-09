Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7055648368
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiLIOG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiLIOFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:05:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA967720A;
        Fri,  9 Dec 2022 06:05:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7090ACE289D;
        Fri,  9 Dec 2022 14:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025F3C43332;
        Fri,  9 Dec 2022 14:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670594714;
        bh=6gyDnOh8vPJma4ZvWV3odrUEiz4K7dnpkJYUU+2k8Ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ek8MZqQKLsJ2LM5eTC6LlMFwRDP9T77FoT9Unw5x0i8TZozYTJDlgE5dX9OYlJHLc
         fBVnwf6BIAwxVgSKs3qB/zWQdbukgQ/7haodw9cswsTecqC3DzFYWhW7tLKLKmnx9X
         eswae/iOsywzrd85JzubZr0kZ2YR0QLa86l8DW2Fgr3oKPcaT0cGd+5ySQy+4cPl8V
         o5tUk3iMxqfJtiQRguut9wsTvQ7ELUH1Nrw57f+xm8cUaNkekwQy+iHBJ22/vGAcaX
         +Hd1y9+od+wFDSIvXyPVRJHyaAESxqMRuf8lViOsI6sWcSWVTr/V1cqaedM+7FkvKv
         DfQIUSAXNMN0A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p3e0J-0000Rv-8T; Fri, 09 Dec 2022 15:05:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 12/19] x86/apic: Use irq_domain_create_hierarchy()
Date:   Fri,  9 Dec 2022 15:01:43 +0100
Message-Id: <20221209140150.1453-13-johan+linaro@kernel.org>
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

Use the irq_domain_create_hierarchy() helper to create the hierarchical
domain, which both serves as documentation and avoids poking at
irqdomain internals.

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
2.37.4

