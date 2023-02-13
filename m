Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D676950D6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjBMTlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjBMTkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:40:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D1040F3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:40:44 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:40:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676317243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lVAMOrwVrbSv+yNTTlO7e2785SmsHxvnqHkcZplmmLI=;
        b=EjYw1aCUEVPHqQfo7ZdTrnnwkaqnVQOaHHxONDRF4o1VXGXQBVGjpVrKXuTeX+Bbr+Vb5k
        NqrJP7XB/+KJd5T0lxxmNRnHD8Q6bayaN5ESv9hwuZ+fjTkLT4WnyG8nrbCH2FkfayWhAU
        B/7YVcetXquMGpTl9/+B0J/FKWijdHZ0iS+zqwarWTATa3iQo3ViIyc7dzImUCz6EftAuv
        1/oRu+7YtGuZxW7jq2ghy3aa1rXgRH9mG2u2Hmkz7lz/SS4XQauDJ8NS/BrF+dIF9RBHZm
        rWpJ/wbwh9vB2IfoMXQsIe/mmY+kx91EJzBSn0BRB3qbIkHwPMlIhVwiV6Qj8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676317243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lVAMOrwVrbSv+yNTTlO7e2785SmsHxvnqHkcZplmmLI=;
        b=DhhWQsXS7dmo8CoE8MsCGUHNG7pSGEIrbtGRp5+BhWNpZVESuS5S09/Dlz/j5RkKeq7bEK
        IDDUbu7vzrkmDEAg==
From:   "irqchip-bot for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] x86/uv: Use irq_domain_create_hierarchy()
Cc:     philmd@linaro.org, "Hsin-Yi Wang" <hsinyi@chromium.org>,
        "Mark-PK Tsai" <mark-pk.tsai@mediatek.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230213104302.17307-14-johan+linaro@kernel.org>
References: <20230213104302.17307-14-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <167631724247.4906.13715528722546938555.tip-bot2@tip-bot2>
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

Commit-ID:     a14e7fdd43040a2a5da2cc979063b3c958015aa9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/a14e7fdd43040a2a5da2cc979063b3c958015aa9
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 11:42:55 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 13 Feb 2023 19:31:24=20

x86/uv: Use irq_domain_create_hierarchy()

Use the irq_domain_create_hierarchy() helper to create the hierarchical
domain, which both serves as documentation and avoids poking at
irqdomain internals.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230213104302.17307-14-johan+linaro@kernel.o=
rg
---
 arch/x86/platform/uv/uv_irq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index 1a536a1..ee21d6a 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -166,10 +166,9 @@ static struct irq_domain *uv_get_irq_domain(void)
 	if (!fn)
 		goto out;
=20
-	uv_domain =3D irq_domain_create_tree(fn, &uv_domain_ops, NULL);
-	if (uv_domain)
-		uv_domain->parent =3D x86_vector_domain;
-	else
+	uv_domain =3D irq_domain_create_hierarchy(x86_vector_domain, 0, 0, fn,
+						&uv_domain_ops, NULL);
+	if (!uv_domain)
 		irq_domain_free_fwnode(fn);
 out:
 	mutex_unlock(&uv_lock);
