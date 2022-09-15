Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02305BA123
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 21:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIOTI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 15:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiIOTIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 15:08:22 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDE5857D3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 12:08:21 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g23so9823668qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=V+nu0Mnx9w8PWr9j2bzDveVOduNia2P/PPn8+xHhcd4=;
        b=TO2BE68U+tP04b1bnYfJJCXlNf4kELGPJS8LP8DPHxwVWH74k/pl5hyCfRQKjF5rBF
         G6cR5wTLeDrbILIUDIBs4CjZf8idHw7EmVGnmS6nTptwuF3GvsssOyew7bpSCCYLA++y
         8Lc782o5GYFl206c1sdwiVVfNV2k+MEdpoPBVPjnHNnNvZyCdsOJqjQ8RMDWMeuvDLs8
         na0FI9n8IhaTO1gn2YXXUIzUg3b98l26c6m79OXmRwXq8rjDZ84ks+gKQhljFhc5C1q4
         VA2WEtndM8r8xUxCqVYziEBFI8JvUzDC+r4JGELTGgQU1seTkT1Jd+xXXS+2CkUyggs+
         jTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=V+nu0Mnx9w8PWr9j2bzDveVOduNia2P/PPn8+xHhcd4=;
        b=ofXMjdJGJq3R9lAtSJ57gt5wTCjIr4NTB9reGsoOvj5KIzpWgp97S+YWvK4cf9+tBk
         7bPVMTgruXh/y2O+CNkCQTmjUje53OEaDu1ApB26tSoCFlDxsuHO9egYnzcL3VJ6bxjz
         G+/2M//0Xo6pWC2xspmaUrQiD8DrRK9dP1BDIuntap5eiTAAdiWwtW0GE/aAcaYZJVHJ
         wxf5OsTIwj/3W7ngsP2D9ECAf2XJ6BbCArO44E5K0tc0GSgZ5vd5DMdN+56kenXDUig4
         cT4H8Av3DCIj3HtSNmXlboaSGCYLs/Y+lEPsaR06j+2/c8COTLVD1cLVNVBvZsm0xukm
         9ZOw==
X-Gm-Message-State: ACrzQf3MZG6GDESTvIVTs1Xqu2h8sMveFtbtDop7Opsu9RAn38eDfTtZ
        ZrgChF6JN6CipdKenPXFm5w=
X-Google-Smtp-Source: AMsMyM7g0VOwbnviLzfwvnQcTkVzfJ9cXYUVngU9L0514DNalQYlfiRG/2GUJODK3K2GfMCZm30yyw==
X-Received: by 2002:a05:622a:1ca:b0:35b:ad5a:478e with SMTP id t10-20020a05622a01ca00b0035bad5a478emr1257058qtw.325.1663268900502;
        Thu, 15 Sep 2022 12:08:20 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i18-20020a05620a249200b006b5e296452csm4677975qkn.54.2022.09.15.12.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 12:08:19 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, Liang He <windhl@126.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] soc: bcm: brcmstb: biuctrl: Avoid double of_node_put()
Date:   Thu, 15 Sep 2022 12:08:09 -0700
Message-Id: <20220915190811.2576914-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Commit 9a073d4fbb18 ("soc: bcm: brcmstb: biuctrl: Add missing
of_node_put()") added what was thought to be a missing of_node_put() but
now causes a double of_node_put() to be called, once from
setup_hifcpubiuctrl_regs() and another time from brcmstb_biuctrl_init().

Ensure that setup_hifcpubiuctrl_regs() is not calling of_node_put()
since it is not obvious it does that on one of its parameters.

Fixes: 9a073d4fbb18 ("soc: bcm: brcmstb: biuctrl: Add missing of_node_put()")
Reported-by: Jim Quinlan <jim2101024@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Change-Id: I1c405c36c2f06c8b8c0f684143b7a52db7e809f0
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index 1467bbd59690..e1d7b4543248 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -288,7 +288,6 @@ static int __init setup_hifcpubiuctrl_regs(struct device_node *np)
 	if (BRCM_ID(family_id) == 0x7260 && BRCM_REV(family_id) == 0)
 		cpubiuctrl_regs = b53_cpubiuctrl_no_wb_regs;
 out:
-	of_node_put(np);
 	return ret;
 }
 
-- 
2.25.1

