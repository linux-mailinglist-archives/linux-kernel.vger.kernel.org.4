Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3616B4700
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjCJOsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjCJOrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:25 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BCE1220BB;
        Fri, 10 Mar 2023 06:47:07 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-176eae36feaso6060434fac.6;
        Fri, 10 Mar 2023 06:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLGw8/N7wbk7qqj38LlwiCbM3yJg3WQAA0qdjYBUqJg=;
        b=N6ZNflhSTg+OqIMFmSpYhlaCmO0BzpK/hvxauoBbskX97ayR7fjetgZ5cCdEJe7aVO
         0SsPb93bYVDtU0SjT7UduzLJHcv+960WzMCGRtGTEAWaqjkSOTSXGH7hY7ZRTlp345zU
         x6b/2yJoggLKPv/Rx72F9DMozML1ioJ+l8r8N5vr8EY6MitIcYG16Ww+uyMvsJlD0KQ9
         f//jcCd1+lrxuxRN2qVWTPzk6lgqH1jabi4fil7/QpdoU24hdV4ACMdqUm7K1XCotkWL
         WsIJebl+3FGEUj4a47ZFAgxC4Yo16ergyjsWpWabtrQdwX+GpyZSEyKl1Ge6EhpLHegu
         +jjA==
X-Gm-Message-State: AO0yUKVFPgz8ElzSld6JYqGLSDKfJSvbDLU/mfwmKSZPTqABtw6XM/e5
        xQIhoXU8xSYG3WX0MpOPhDCcC4t3Yw==
X-Google-Smtp-Source: AK7set+JLaSzGTT9vEtfOqLUFsJK54NUYOi4JW5jGxK9Bs91BwCafDq8lihl1GWavwrijGpdB8JYQg==
X-Received: by 2002:a05:6870:d78d:b0:16e:1984:706f with SMTP id bd13-20020a056870d78d00b0016e1984706fmr15340990oab.8.1678459624682;
        Fri, 10 Mar 2023 06:47:04 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p10-20020a4ae14a000000b00500c1100651sm822519oot.45.2023.03.10.06.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:04 -0800 (PST)
Received: (nullmailer pid 1541371 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:00 -0600
Message-Id: <20230310144700.1541345-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/sparc/kernel/pci_schizo.c | 2 +-
 arch/sparc/kernel/power.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pci_schizo.c b/arch/sparc/kernel/pci_schizo.c
index 421aba00e6b0..23b47f7fdb1d 100644
--- a/arch/sparc/kernel/pci_schizo.c
+++ b/arch/sparc/kernel/pci_schizo.c
@@ -1270,7 +1270,7 @@ static void schizo_pbm_hw_init(struct pci_pbm_info *pbm)
 	    pbm->chip_version >= 0x2)
 		tmp |= 0x3UL << SCHIZO_PCICTRL_PTO_SHIFT;
 
-	if (!of_find_property(pbm->op->dev.of_node, "no-bus-parking", NULL))
+	if (!of_property_read_bool(pbm->op->dev.of_node, "no-bus-parking"))
 		tmp |= SCHIZO_PCICTRL_PARK;
 	else
 		tmp &= ~SCHIZO_PCICTRL_PARK;
diff --git a/arch/sparc/kernel/power.c b/arch/sparc/kernel/power.c
index d941875dd718..8147985a1dc4 100644
--- a/arch/sparc/kernel/power.c
+++ b/arch/sparc/kernel/power.c
@@ -28,7 +28,7 @@ static int has_button_interrupt(unsigned int irq, struct device_node *dp)
 {
 	if (irq == 0xffffffff)
 		return 0;
-	if (!of_find_property(dp, "button", NULL))
+	if (!of_property_read_bool(dp, "button"))
 		return 0;
 
 	return 1;
-- 
2.39.2

