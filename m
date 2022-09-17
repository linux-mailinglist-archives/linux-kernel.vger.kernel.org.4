Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0527B5BB568
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiIQBya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQBy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:54:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BBC14D3D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:54:24 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r23so13315586pgr.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=keTdwxKvPiWSHaxWsk/YUDS9Y6Zxt3ItQiWrzrZOVyI=;
        b=Lr9NP6vv3KGni9Beu4+owg7rEHXKnw+p2SBCamYzVmS36lCX7inSWOfseW9ux90HmV
         RQRN37phIl/9lfUHQirj56g3mb5lzHm4f9i2KYJULzNLgGOCYWE0b2rG0Y8oPI423A1Y
         rbmoWanTNaf5LVmxOvNtvAG3m6abWFUSOkfMprfirsCvPVi6jlwg6HbSJCQNeYaZ4rCw
         Ihge+RGCuIpqLMVsPzuCF3hF8DuP/7MAszty9/9sUEU+cKRrgpYfUoScXjRTQ8oOykxO
         xSQzsmWv5OuczBobVhW390hiRMdBJ12dE2mSs9RgbrnGjE9agA9clLi+SCFQv+pUXx7o
         0ndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=keTdwxKvPiWSHaxWsk/YUDS9Y6Zxt3ItQiWrzrZOVyI=;
        b=v2y8DHAC/kQvoTD0mvAvhw+XrWgaLWkozp2vi0Y1f7XE4xqRkq9WHx6eedWbyAqft5
         KizvVJCx6/7+wRAGqYoo8F+HCrRkEJvEjeXBfwGL/vcFolSXCpeFjJxuSszq85XQgjYE
         uab3KHM3kpjlpqHofOVtg8xnmG9DdmvTm5FDD6qYKKUBr+QgR4EIqj6VXKqGNYtWIOxg
         EmmOhJn0CxNda0jkuq+2e7SZOQ71cxo3SMj6H6zV80aqGD71fD+KMWutGhMPhW/eRqQd
         cTyujywDNu671snL46bM4WitVTQ05I99sgmjQUyCxoyQ3pfdDEELskBZULNO7v/nJOrw
         fi6g==
X-Gm-Message-State: ACrzQf3T1wBVgbZ3L65kwcAgZ1gUvOhwscWFUSWzmTkZlwXr5BbpKtbS
        IT2MLHc3Lk1nCveCfLf6T2YWQX8tQxd9ZA==
X-Google-Smtp-Source: AMsMyM6Rgczh03NnWGM0gdaT9Ivw4BeI32DD+zo8v3BlDSSwkRTLBOHGfk8uhqbAy3kzI4ayHc+HzA==
X-Received: by 2002:a65:5504:0:b0:42a:352d:c79c with SMTP id f4-20020a655504000000b0042a352dc79cmr7298276pgr.58.1663379663474;
        Fri, 16 Sep 2022 18:54:23 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id 75-20020a62174e000000b0054223a0185asm13822068pfx.161.2022.09.16.18.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 18:54:22 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] kernel/irq/manage: check return value of irq_data_get_irq_chip()
Date:   Fri, 16 Sep 2022 18:53:48 -0700
Message-Id: <20220917015348.3831203-1-floridsleeves@gmail.com>
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

Check the return value chip of irq_data_get_irq_chip(), which could be
NULL and result in null pointer dereference if unchecked.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 kernel/irq/manage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 40fe7806cc8c..1f967050338b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -202,6 +202,8 @@ static void irq_validate_effective_affinity(struct irq_data *data)
 
 	if (!cpumask_empty(m))
 		return;
+	if (!chip)
+		return;
 	pr_warn_once("irq_chip %s did not update eff. affinity mask of irq %u\n",
 		     chip->name, data->irq);
 }
-- 
2.25.1

