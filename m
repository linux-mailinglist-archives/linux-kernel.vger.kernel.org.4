Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7394F6449F7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiLFRJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbiLFRJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:09:27 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512AD2DAB4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:09:26 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ay40so4955002wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MxiX4xJAqzGvUOJG6dGIAYeA5k9jqvSgVNBvDNesWok=;
        b=FiKrRdnnu/Odmt1R/n1t39q5QwfZ5qIN6HA/spKh8UBYUbEp5m/PwauwlbcWDq1/fg
         f0iPgJiKeXpm+mpqMGW/CqBsUUeReZBncLjcD0EmMFPEcW0rRDCRI9Tz1gFi6IDwC1Ad
         L0Is4iHJySgrY9kwT1voN3pvDjihcKoCcYJdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxiX4xJAqzGvUOJG6dGIAYeA5k9jqvSgVNBvDNesWok=;
        b=FLgGOOCzZxNMzZJ0PUeaI4OIGMoHw443YeSKZcn6j580IQKIjMUSz8lSKURTDKrEOj
         SgMl9+Zj+H+TfAUlXWtx0PkEh2VZcCjoZ0WuRArCEobTYeDwIqR/hW8XnlJoRvzgbUml
         /mOICwCVqZppNDNUUXSQzZMpyyWKsbt9POJ0Fh6tQpbQwPMxz6D5BuDyL5R5zX/VbO1R
         KJLGffAEIqJfYr268uBjOHY2dqVraBG2qH6uq1rXqkMmwQsavNpMWzwbLi+4pIBMC0+H
         CYFr5KIa4NAZ/fWWY9RuiftwD8ranypzWmhUeu6DkBXxTW1xZh181maAResn0zkXooav
         c7gw==
X-Gm-Message-State: ANoB5pkZOCXkywGS0R/8TgVkt6jVwGaswN41ksJOLSCWuxBy53IuRAO7
        SCDdVN2PQML74iM85G+bEqh9cEw/SIx6ok+a
X-Google-Smtp-Source: AA0mqf4DltLaz1pwxrItnzlotskGlZXAARr9Z1Mh1JJ47kLxeld0dwEQidVU2Rzg4oOrUFw3e6jHSQ==
X-Received: by 2002:a1c:7715:0:b0:3cf:d18d:3bfe with SMTP id t21-20020a1c7715000000b003cfd18d3bfemr66187328wmi.203.1670346564509;
        Tue, 06 Dec 2022 09:09:24 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-82-54-95-136.retail.telecomitalia.it. [82.54.95.136])
        by smtp.gmail.com with ESMTPSA id e4-20020adff344000000b00236488f62d6sm17655402wrp.79.2022.12.06.09.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:09:24 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        Scott Branden <sbranden@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: BCM63xx: remove useless goto statement
Date:   Tue,  6 Dec 2022 18:09:13 +0100
Message-Id: <20221206170913.3316205-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Between the 'goto out' statement and the 'out' label there are no other
statements, so it is useless to check the return value of the
bcm63xx_pmb_power_on_cpu() function. Then, let's remove the statements
that are unnecessarily executed.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/mach-bcm/bcm63xx_smp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-bcm/bcm63xx_smp.c b/arch/arm/mach-bcm/bcm63xx_smp.c
index 641e1f8fcf5e..18d0ffc621aa 100644
--- a/arch/arm/mach-bcm/bcm63xx_smp.c
+++ b/arch/arm/mach-bcm/bcm63xx_smp.c
@@ -142,8 +142,7 @@ static int bcm63138_smp_boot_secondary(unsigned int cpu,
 	 */
 	ret = bcm63xx_pmb_power_on_cpu(dn);
 	of_node_put(dn);
-	if (ret)
-		goto out;
+
 out:
 	iounmap(bootlut_base);
 
-- 
2.32.0

