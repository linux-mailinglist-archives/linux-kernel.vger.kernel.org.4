Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19675FD2C0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 03:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJMBj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 21:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJMBjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 21:39:55 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC08421E05
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 18:39:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i3so604467pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 18:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFXUaVreoF/KTAqhQVKBDjKB07Jaaew8xzMrUq2Z6tc=;
        b=eEMJwZQlkqRrwxnsGL+v9LMcR4Eu7pbCUUKKKUumulWObVRz15Jo9gK4alNq3TNJ5q
         woCoEutJham7Nsj99kEukpzMIIS37Uf+Tf3sQqclZH1pc7zNsx8G/3zI5Ed8mfx7hyMy
         pBkmSVpRHlNFjdnDciH/2vQ420q/t5UDW2//nJxANFR6zrhf1iQ2OTW4bTMmeul/VD2Y
         VPBXIrAGtoYj6Tc936WJLtMRr7m9cinhfUzhTJXalL1j6NhhFp84zkDChNYBxG4P6/sm
         cRmCYApJmamLAkhCQt/gtFJagZmYIUUPYOrqWji+lbZ/O+Za/7n7okAQ7lN7rjVA/poX
         JXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFXUaVreoF/KTAqhQVKBDjKB07Jaaew8xzMrUq2Z6tc=;
        b=Ekl8ONMiViEzIp7Sl0Adp4QIczUT7GvipZBtdCAEhSXPCEC8pFv9rG6XaGwVyqFcDF
         REBxhje+y7VCfqPU2AXKnIDBxw7oCIA+E3SLfY5A3cZ7ax9wZ+zKIdRA9AHQuJ73CfZA
         RKueC7ebZE8crk60dHAWz65BXoqbPsq0OrjrWy84rEMb9edrNUfqWrplFaDn8rl6+rc2
         Nf5NHlfOrsXTbC8wLeBXSvacEYtv/qx82XzjMalLU2ci+M8ROSD7oiYG5p+TtR/4lNny
         hH0FVYcpH7SUEBYkYS1Iuk+4sLu1OWEMB2Q25ZcHVhVpqk2MSiYRB93+d5h361FIPLQl
         FBzg==
X-Gm-Message-State: ACrzQf0LaDuAa8IlX5093zTduA6RAj6vBToVtsWbLVYnZAUXeHbxE6hU
        we3BaJ/CGZQqhWL1mHG1ta8=
X-Google-Smtp-Source: AMsMyM7s52XejASFQ9tf+PO/WSVpGaHoQqoD65KwmSlW3+jBNsJhI+UChj86erbmsJykKBEnK9MfSQ==
X-Received: by 2002:a05:6a00:f03:b0:563:210a:5ffb with SMTP id cr3-20020a056a000f0300b00563210a5ffbmr23479380pfb.70.1665625192593;
        Wed, 12 Oct 2022 18:39:52 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id pf15-20020a17090b1d8f00b00200a85fa777sm2073137pjb.1.2022.10.12.18.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 18:39:51 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     andrew@lunn.ch
Cc:     sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH linux-next v4] soc: dove: Use generic_handle_domain_irq()
Date:   Thu, 13 Oct 2022 01:39:46 +0000
Message-Id: <20221013013946.349018-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace generic_handle_irq((irq_find_mapping()) with
generic_handle_domain_irq().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v3 -> v4
fix the mistake on subject line and add a '(' for generic_handle_irq(). 
 drivers/soc/dove/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index ffc5311c0ed8..308fe45231b4 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -243,7 +243,7 @@ static void pmu_irq_handler(struct irq_desc *desc)
 		stat &= ~(1 << hwirq);
 		done &= ~(1 << hwirq);
 
-		generic_handle_irq(irq_find_mapping(domain, hwirq));
+		generic_handle_domain_irq(domain, hwirq);
 	}
 
 	/*
-- 
2.25.1

