Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C0373DAFC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjFZJOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFZJNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:13:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396EBDD;
        Mon, 26 Jun 2023 02:11:40 -0700 (PDT)
Date:   Mon, 26 Jun 2023 09:11:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687770698;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FU1rRT5rRxL9pM8a+1rMbZNJKqtiIhbKRAc/m62/7RQ=;
        b=Gvo5i9Fk9+OdF/voFqD5zQC8rpUGq618/N/fMBccDd4PsTQ5EsicvYzYxBNOLqM3hm2Tqd
        2cdp90KDoqpm54Kii3w5dyAg1qcE7be2kBcpiBENtfLiU1HT4R4hK+GT8qljdU4s/a4Iyp
        YithflBxmJqTfwZlP+/io3OGMqBQ8mR/Fi6wBa0peXH7aqJOx3x7qtDD9KNOCpDwbBqE/a
        O8PPgmbQaNU5ZFbhWvydAijtOkoFKrMOJ20Cnw5mn8mE5U9uqygLqxRGPKlTgx4thej1Vg
        nf2ZuKspqriTeRDgg5tJyyJvPCww6ywZeD6YwQVeyg8ylsB9uTwzOjKZ/2Fd+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687770698;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FU1rRT5rRxL9pM8a+1rMbZNJKqtiIhbKRAc/m62/7RQ=;
        b=YBAFNA0fCNH74x45Xgi0eLoWd5pMJ7Tu98NdhePwv1sOn0MzQeIsjIvSDqntkQNoU/mSIP
        3u8YoDgBEGRxJqCA==
From:   tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/imx-gpt: Use only a single
 name for functions
Cc:     u.kleine-koenig@pengutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230328091514.874724-1-u.kleine-koenig@pengutronix.de>
References: <20230328091514.874724-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Message-ID: <168777069819.404.8166787255260497760.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     95aded1b1c409fb2e902c6bd455068700ac38878
Gitweb:        https://git.kernel.org/tip/95aded1b1c409fb2e902c6bd455068700ac=
38878
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Tue, 28 Mar 2023 11:15:14 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 19 Jun 2023 17:31:56 +02:00

clocksource/drivers/imx-gpt: Use only a single name for functions

When looking at the data structs defining the different behaviours of
the GPT blocks in different SoCs it's not helpful that the same
functions are used with different names.

So drop the cpp defines and use the original names.

This commit was generated using:

	perl -i -e 'my %m; while (<>) { if (/^#define (imx[a-zA-Z0-6_]*)\s(imx[a-zA-=
Z0-6_]*)/) {$m{$1} =3D $2; } else { foreach my $f (keys %m) {s/$f/$m{$f}/; } =
print; } }' drivers/clocksource/timer-imx-gpt.c

This patch has no effect on the generated code.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230328091514.874724-1-u.kleine-koenig@pengu=
tronix.de
---
 drivers/clocksource/timer-imx-gpt.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-=
imx-gpt.c
index ca3e4cb..83cefff 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -93,13 +93,11 @@ static void imx1_gpt_irq_disable(struct imx_timer *imxtm)
 	tmp =3D readl_relaxed(imxtm->base + MXC_TCTL);
 	writel_relaxed(tmp & ~MX1_2_TCTL_IRQEN, imxtm->base + MXC_TCTL);
 }
-#define imx21_gpt_irq_disable imx1_gpt_irq_disable
=20
 static void imx31_gpt_irq_disable(struct imx_timer *imxtm)
 {
 	writel_relaxed(0, imxtm->base + V2_IR);
 }
-#define imx6dl_gpt_irq_disable imx31_gpt_irq_disable
=20
 static void imx1_gpt_irq_enable(struct imx_timer *imxtm)
 {
@@ -108,13 +106,11 @@ static void imx1_gpt_irq_enable(struct imx_timer *imxtm)
 	tmp =3D readl_relaxed(imxtm->base + MXC_TCTL);
 	writel_relaxed(tmp | MX1_2_TCTL_IRQEN, imxtm->base + MXC_TCTL);
 }
-#define imx21_gpt_irq_enable imx1_gpt_irq_enable
=20
 static void imx31_gpt_irq_enable(struct imx_timer *imxtm)
 {
 	writel_relaxed(1<<0, imxtm->base + V2_IR);
 }
-#define imx6dl_gpt_irq_enable imx31_gpt_irq_enable
=20
 static void imx1_gpt_irq_acknowledge(struct imx_timer *imxtm)
 {
@@ -131,7 +127,6 @@ static void imx31_gpt_irq_acknowledge(struct imx_timer *i=
mxtm)
 {
 	writel_relaxed(V2_TSTAT_OF1, imxtm->base + V2_TSTAT);
 }
-#define imx6dl_gpt_irq_acknowledge imx31_gpt_irq_acknowledge
=20
 static void __iomem *sched_clock_reg;
=20
@@ -296,7 +291,6 @@ static void imx1_gpt_setup_tctl(struct imx_timer *imxtm)
 	tctl_val =3D MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
 	writel_relaxed(tctl_val, imxtm->base + MXC_TCTL);
 }
-#define imx21_gpt_setup_tctl imx1_gpt_setup_tctl
=20
 static void imx31_gpt_setup_tctl(struct imx_timer *imxtm)
 {
@@ -343,10 +337,10 @@ static const struct imx_gpt_data imx21_gpt_data =3D {
 	.reg_tstat =3D MX1_2_TSTAT,
 	.reg_tcn =3D MX1_2_TCN,
 	.reg_tcmp =3D MX1_2_TCMP,
-	.gpt_irq_enable =3D imx21_gpt_irq_enable,
-	.gpt_irq_disable =3D imx21_gpt_irq_disable,
+	.gpt_irq_enable =3D imx1_gpt_irq_enable,
+	.gpt_irq_disable =3D imx1_gpt_irq_disable,
 	.gpt_irq_acknowledge =3D imx21_gpt_irq_acknowledge,
-	.gpt_setup_tctl =3D imx21_gpt_setup_tctl,
+	.gpt_setup_tctl =3D imx1_gpt_setup_tctl,
 	.set_next_event =3D mx1_2_set_next_event,
 };
=20
@@ -365,9 +359,9 @@ static const struct imx_gpt_data imx6dl_gpt_data =3D {
 	.reg_tstat =3D V2_TSTAT,
 	.reg_tcn =3D V2_TCN,
 	.reg_tcmp =3D V2_TCMP,
-	.gpt_irq_enable =3D imx6dl_gpt_irq_enable,
-	.gpt_irq_disable =3D imx6dl_gpt_irq_disable,
-	.gpt_irq_acknowledge =3D imx6dl_gpt_irq_acknowledge,
+	.gpt_irq_enable =3D imx31_gpt_irq_enable,
+	.gpt_irq_disable =3D imx31_gpt_irq_disable,
+	.gpt_irq_acknowledge =3D imx31_gpt_irq_acknowledge,
 	.gpt_setup_tctl =3D imx6dl_gpt_setup_tctl,
 	.set_next_event =3D v2_set_next_event,
 };
