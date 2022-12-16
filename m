Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD7B64F4CA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiLPXKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiLPXJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:09:49 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BC272610;
        Fri, 16 Dec 2022 15:09:47 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id h26so128219qtu.2;
        Fri, 16 Dec 2022 15:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vegG20gk25+T6XBaIrE5g3xcbsYjjWiBuzRZ3BiRMhg=;
        b=hTtlGn5Z88jIg4MDGLOBdsmPvZRZ69YLFOI8b7PxRoYJOWABWocgDG2zEsE6Zt6Q7u
         F5+l9kWyYNZN8UlHm9fQkB1RhyPM0SfySuXAZcVB+4EGvdr3jQMEBej9FaoNtmDGmCtt
         7DlclyIVFt6jmyJK31XXLsNdpXYJEgqF0kMDwMnCiaCKqopVkvEAL2QQphAopqJjf6/u
         /FwrN+I7qjsQLUd1uwjwt0vG6Mb3V3sfGoSS9QcnhK6pNfbbyBejPLVM6/vBCYqCtHhT
         s5AaG+YkAyH0y0FxkQgTEyvPEj1YyuVt05/E3PJvlPc+3aPirlZvwDc3NPtgkMZWvGfS
         jDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vegG20gk25+T6XBaIrE5g3xcbsYjjWiBuzRZ3BiRMhg=;
        b=33dysJLZy/BQye9nJmLI/bNMfUB9u6CWEBss2ToMFRq52gCu5buwaFemw+jNd4KQyE
         mDyhnkilxYmye+J5iIiFzbtIH7zFm6Ei68yKD5NWLeIDUOon0zy9Ed1Qulx7n3thS3ZF
         FAwoGmmdWF0214NOb0pIvOjMWOh+cYceujEozqPCaUz6FSkhT1NYX7pupJo5ntUC/I90
         zVMaR7JmJMLt3eAhtBUmCmkCeRalEy2izKIZ0FPOZFecTaH/TYwiPYZzsb1MRfea8PBb
         sOUSSatmCiHCwtnamjhCto3HgqXr3rS0Sy9I3kMp3WZUqdi27BIlk3Ddhpt3fnisJCjK
         6Trw==
X-Gm-Message-State: ANoB5pkbKYn58vCLoqC7ehM0pf3dblDkY7OEpDxIxdLlNyKfwbeR1Tki
        UQ1K8bfeG3Tijgdizyearu4MlGpEu8Aexw==
X-Google-Smtp-Source: AA0mqf4ajQJrGkghoc08nCABkO9sRZU/2GcYQxlwsWo2Vvr1NANQ6VMJhJOTCjBzQFapTTkCaFUg1g==
X-Received: by 2002:a05:622a:5a13:b0:3a8:102c:9be4 with SMTP id fy19-20020a05622a5a1300b003a8102c9be4mr38486882qtb.9.1671232186365;
        Fri, 16 Dec 2022 15:09:46 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o70-20020a374149000000b006e702033b15sm2360386qka.66.2022.12.16.15.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:09:45 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Doug Berger <opendmb@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-mips@vger.kernel.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 1/2] irqchip/irq-brcmstb-l2: Set IRQ_LEVEL for level triggered interrupts
Date:   Fri, 16 Dec 2022 15:09:33 -0800
Message-Id: <20221216230934.2478345-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221216230934.2478345-1-f.fainelli@gmail.com>
References: <20221216230934.2478345-1-f.fainelli@gmail.com>
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

When support for the level triggered interrupt controller flavor was
added with c0ca7262088e, we forgot to update the flags to be set to
contain IRQ_LEVEL. While the flow handler is correct, the output from
/proc/interrupts does not show such interrupts as being level triggered
when they are, correct that.

Fixes: c0ca7262088e ("irqchip/brcmstb-l2: Add support for the BCM7271 L2 controller")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-brcmstb-l2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index e4efc08ac594..091b0fe7e324 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -161,6 +161,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 					  *init_params)
 {
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
+	unsigned int set = 0;
 	struct brcmstb_l2_intc_data *data;
 	struct irq_chip_type *ct;
 	int ret;
@@ -208,9 +209,12 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
 		flags |= IRQ_GC_BE_IO;
 
+	if (init_params->handler == handle_level_irq)
+		set |= IRQ_LEVEL;
+
 	/* Allocate a single Generic IRQ chip for this node */
 	ret = irq_alloc_domain_generic_chips(data->domain, 32, 1,
-			np->full_name, init_params->handler, clr, 0, flags);
+			np->full_name, init_params->handler, clr, set, flags);
 	if (ret) {
 		pr_err("failed to allocate generic irq chip\n");
 		goto out_free_domain;
-- 
2.34.1

