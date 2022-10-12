Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1115FBECB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 03:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJLBFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 21:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJLBFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 21:05:30 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFF851409
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 18:05:28 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id z20so14802714plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 18:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bR4X1g3CbR8zefRuNAZ27/g76yKRh5y750izJu4gJiU=;
        b=k/oBbb+2oplFe0U0n7gc8hdye+dRix2x8tyWf6AqVd/0mjbuoOumovS6DbzPhnWY75
         +upiKTamB8HMPpq0xHgxaaykwBua09vmUXWjzfg8kSlmHTlhB9B9gWK41YG2ldf1yagY
         VaF28CD3Wr9TV3fG8WU6c2wAmiKzwmXCGrntah6qheQsln45TE/f/uCjixC3ceA5KVSx
         n9JRh7vtOhGXb1Hh9l7JNczczyFrLa0wtdICfpjvImJoY31yeTP3CO6qVgsOtKOIe+kk
         YlN8yJZbku5FyBYFQTaJ5Agp/P2nujAORGFz3cDt59NihOIuX2nkHnu+0fGWcLovrUqm
         cW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bR4X1g3CbR8zefRuNAZ27/g76yKRh5y750izJu4gJiU=;
        b=5mUt3nSxBFUi4HvhxupLNV6QMjsuZWZT7kpGBgA7CTdoPINIKOYL4nkpo2KcXZylzV
         EZhdhBq2M17eXCLwZCLAFZqWaK+oNkRrMZZvYqWRYw7eCVsXa06hm9v6FPllo9ti0vXE
         zRQnIikYD1pHBt2stUxymT1mdNz7FGObNZrsB1e85FAYTd0l2cNocmLa1zxOQRw8srwS
         cToOYfAEPm1q1LffVU/1FllYa77xPrEsFC2gnk2VZcSALTw66U8VKDfDASNeZXEuc7ZC
         X+6RI7juHwQ4axB/hROZL3+PFgpMyxsUi7JJGz3ojo6cKm8Ol14j90r4qt23o80dKh3Y
         btYg==
X-Gm-Message-State: ACrzQf1dQCIPtTfrrBJauEijd+c9L4QK9F3M8LJFx32JVDah7OoWLWBd
        EbR/plcdylyJR46abQC2YmM=
X-Google-Smtp-Source: AMsMyM4/ZQXt08ZnLHvPTCv4edfW6NrrsDVJxjqb1+UzRBhesfv2+lAwA5i6OC4WStJyHcgkoWOfvQ==
X-Received: by 2002:a17:90b:4d05:b0:202:ec78:9d73 with SMTP id mw5-20020a17090b4d0500b00202ec789d73mr2154340pjb.103.1665536728154;
        Tue, 11 Oct 2022 18:05:28 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t195-20020a635fcc000000b004608b721dfesm6034052pgb.38.2022.10.11.18.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 18:05:27 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     andrew@lunn.ch
Cc:     sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next v2] soc: dove: Use generic_handle_domain_irq()
Date:   Wed, 12 Oct 2022 01:05:22 +0000
Message-Id: <20221012010522.334885-1-ye.xingchen@zte.com.cn>
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

Replace generic_handle_irq(irq_find_mapping()) with
generic_handle_domain_irq().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
v1 -> v2
Make the subject line more specific.
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

