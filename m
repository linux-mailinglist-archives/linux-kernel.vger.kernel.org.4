Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2074A6971DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjBNXek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjBNXeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:34:37 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC4130E90
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:34:35 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gd1so5812837pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48thYLKBHK3Dz7aYi+ob8EdMN1A5iezy1Q0AVsszte8=;
        b=Jn/v41TrSgPi7e6JR9bOENXFzhjgLtpC2WLsnLwNjTW2sA+9kmuoLM1lFDzBGeJrxU
         QS5/MJsMtiR1g6oDcEwRP40IExUIYh9rqMGhye9XxKjX8cWpNFtYCJXWrbTzECRzC9QY
         hP9K2FhnVeWtagHz3/MhR4vQN6SV0o0tNZj1Oh+DKIIZmrY8smcrIfxUlW2cwIgvu5pv
         6lONBp53gmw0hZUKyR5Er/HruRiIhjJZk5bS3nkXwDe2n4XD/iBFH4TP2zhLxAN5Zcfm
         axGca2beR+bZrCa09YrfKHnHMM/erjZhqStBRfsDE1j9ltSpmIlYbNNa84dhif6gDJbT
         Ur2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48thYLKBHK3Dz7aYi+ob8EdMN1A5iezy1Q0AVsszte8=;
        b=okqmVH2gI+ELuUHgcxOVk4cJ9gZQzDPhvx0S/VlhMbOat34dbZM34mn2LOKFyhVD5I
         wprF0f6odoqy6GWiwhdUnNYUGUHJHl2GrVFC29Tq8NlQyKp7lJelU9aKjLerFQa6I5Tz
         ARRXOV2pKzYoP1LSiPpvfQ+LwXI0QA8OWN3qlONDolZDi9iZCTPdwk9167DNmSbHSJ44
         CsmhfJtTUQcnah7Jml6bYhlC+UQPKjnjPGhiF/1yp7V84POtrqKrY/ldosKC2KcDK/we
         1OaeGF1EYEclzCRocrJsjdDJoGDy1ocwz1Ndf+eqsgSGI2GipWF8W2dAPXOU9veQjhgD
         ZVKQ==
X-Gm-Message-State: AO0yUKVYbleYYbyrJ/z6GL0GPrnqies4HZXZvcVIGHaKpChea2mEiAhY
        G/15bYeT0JkFmtJxu2PG2U9YrbwrYABlcw==
X-Google-Smtp-Source: AK7set9J0o/k+q+LqmlDnLvl6JXhdjpU7GwKbLxhJj0CWsSB8aVXZPThklfApiP6i4PsSc4kiu5oBg==
X-Received: by 2002:a17:902:fb10:b0:19a:a5c4:afe9 with SMTP id le16-20020a170902fb1000b0019aa5c4afe9mr357460plb.31.1676417674730;
        Tue, 14 Feb 2023 15:34:34 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001963a178dfcsm9434801pln.244.2023.02.14.15.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:34:33 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
        Sudeep Holla <sudeep.holla@arm.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH 1/3] irqchip/gic-v3: Use switch/case statements in gic_cpu_pm_notifier
Date:   Tue, 14 Feb 2023 15:34:24 -0800
Message-Id: <20230214233426.2994501-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214233426.2994501-1-f.fainelli@gmail.com>
References: <20230214233426.2994501-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change, but facilitates adding new states in subsequent
changes.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-gic-v3.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index bb57ab8bff6a..b60fadb7eb44 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1374,14 +1374,20 @@ static int gic_retrigger(struct irq_data *data)
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
 {
-	if (cmd == CPU_PM_EXIT) {
+	switch (cmd) {
+	case CPU_PM_ENTER:
+		if (gic_dist_security_disabled()) {
+			gic_write_grpen1(0);
+			gic_enable_redist(false);
+		}
+		break;
+	case CPU_PM_EXIT:
 		if (gic_dist_security_disabled())
 			gic_enable_redist(true);
 		gic_cpu_sys_reg_init();
-	} else if (cmd == CPU_PM_ENTER && gic_dist_security_disabled()) {
-		gic_write_grpen1(0);
-		gic_enable_redist(false);
+		break;
 	}
+
 	return NOTIFY_OK;
 }
 
-- 
2.34.1

