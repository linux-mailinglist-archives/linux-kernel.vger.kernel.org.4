Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8285C746324
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjGCTAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjGCTAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:00:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD60B90
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:00:29 -0700 (PDT)
Date:   Mon, 03 Jul 2023 19:00:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688410827;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCB5T/gy1GB3F/sOlhbXr9bhn6QO/yicK1iojSEVVxA=;
        b=j1VyHdoBvUSxxunqe9vbEuvFeJWWVH6T2OUncwOC9xTnMx9/GRlrzIQBQYxZyVgYmCaQpp
        qXBrRJeo0t3B12E2NOkPFg9q1pwLXwLkG+6f0JOvG41MD3FdR2BOCiB1EPUvkxfS7PgYqa
        jsuJGoHBJK7FNr9bgDfCU1StHLS0j7mxKtnbgSq55Zofv82R8Q/A3kP1i1EUtms7QqXuZd
        I/XjTr0Sb59brkBli+71IAOaAzkMDFRXgnMHwI4jwBzjDwG4NEO0zB8wu3H76QET7CfCNW
        1ZZ3n4UEKMfnu8FHvxPj/MWZKWDcMFdzrWn1cW+Qbj/iAJVcKPiDfv1k50qJXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688410827;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCB5T/gy1GB3F/sOlhbXr9bhn6QO/yicK1iojSEVVxA=;
        b=PsIOfO+CLGxUo0ZYczLGK11FbB5xUFkVVa/ctiGKPst1SGHqM/0qVsykzyd7l+Q5ScBetR
        Gon1+IxHhvPM2NDA==
From:   "irqchip-bot for Sebastian Reichel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic-v3: Enable Rockchip 3588001
 erratum workaround for RK3588S
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230703164129.193991-1-sebastian.reichel@collabora.com>
References: <20230703164129.193991-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Message-ID: <168841082652.404.9728132604301003133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     567f67acac94e7bbc4cb4b71ff9773555d02609a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/567f67acac94e7bbc4cb4b71ff9773555d02609a
Author:        Sebastian Reichel <sebastian.reichel@collabora.com>
AuthorDate:    Mon, 03 Jul 2023 18:41:29 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 03 Jul 2023 19:48:04 +01:00

irqchip/gic-v3: Enable Rockchip 3588001 erratum workaround for RK3588S

Commit a8707f553884 ("irqchip/gic-v3: Add Rockchip 3588001 erratum
workaround") mentioned RK3588S (the slimmed down variant of RK3588)
being affected, but did not check for its compatible value. Thus the
quirk is not applied on RK3588S. Since the GIC ITS node got added to the
upstream DT, boards using RK3588S are no longer booting without this
quirk being applied.

Fixes: 06cdac8e8407 ("arm64: dts: rockchip: add GIC ITS support to rk3588")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230703164129.193991-1-sebastian.reichel@collabora.com
---
 drivers/irqchip/irq-gic-v3-its.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5365bc3..e0c2b10 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4744,7 +4744,8 @@ static bool __maybe_unused its_enable_rk3588001(void *data)
 {
 	struct its_node *its = data;
 
-	if (!of_machine_is_compatible("rockchip,rk3588"))
+	if (!of_machine_is_compatible("rockchip,rk3588") &&
+	    !of_machine_is_compatible("rockchip,rk3588s"))
 		return false;
 
 	its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
