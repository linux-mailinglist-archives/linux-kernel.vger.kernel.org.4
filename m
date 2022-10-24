Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B583E60AFC2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiJXP5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiJXP4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:56:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225669E0EF;
        Mon, 24 Oct 2022 07:51:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j15so6108866wrq.3;
        Mon, 24 Oct 2022 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yJKU+ExsNVkoi0YWDqZM4bb9zmcpHW/L+eJL77nzMo=;
        b=kcv9Q+DGTmLpvKENjUYPRYpWizSHVrOgrm+lnz4MJuEdYVWaq5N0gjzP4o01iAcCSG
         YrsI+MN8HZ956OjH2SbOJJINv3DRIw7PdSgpjpbxCI/odXAG7+BpZBbtmpMqAC4Ff9zb
         /wYIuCxT+Z8UDT0t42DzUnOfgandRkJUTCKQWHIo2RyZHFulWJlCKfmA31croirefIt8
         S3Hp4huGYJxTnvUbkY1x4W2JN7sX1K++VMfdz5ocAp5gE2moYkar/NzKH7dCk4qpe9Jz
         0TibPn17yCIbUmWZjWwOmpISYfRcNFqsCd5nBdU+MbIQNFSJL2o63evumX3YhgfPNCmf
         XOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yJKU+ExsNVkoi0YWDqZM4bb9zmcpHW/L+eJL77nzMo=;
        b=qo4ERZZ6M6Nnc5jcEiNtR/1/ejDN5pIjgjKhpUROQaq6EC8xc2KhXb+7sF090EPcm1
         GmBmeb07C5CB1G4AOvJwGZaijYk3JikoaCEJnvgxnEoDD1H7yPHRKYfIwXHft6mVkDsQ
         xitz/qpGLpjLN0nzMppC7BZLAK5zNrrejUrITFTHn8mIWVjkjBFqnDq3DL1+2EsdgsUI
         KEfkvzMYvfIZxUIp7cpWiX8wWNszZGHfyQ35qE4wkS+SINQMy2qTO8aHo9Er79S5/y3p
         GobumggYov3c6S3tqA5XUXy4w6ZxLkmL/6Xsf1KCFRzjHS0KgQ+//Dy38Yk091a5oZsn
         WbWg==
X-Gm-Message-State: ACrzQf06PcIPX7aoyKFZM0jbEcnAt/Nk0740lyhWAEcK0EPcLdpibXGg
        4ASRYjxdyba4VcrvYw9Q9r4z6cYj50jy/xJx
X-Google-Smtp-Source: AMsMyM5YJA4vDeVWRHAhN/daBb/BroIvZUmIYaT5xU2j8Ed1+mwRu1JA77YbwvqrAdNQOD0uGsO+DQ==
X-Received: by 2002:a5d:5a85:0:b0:236:6c52:bc27 with SMTP id bp5-20020a5d5a85000000b002366c52bc27mr5126054wrb.581.1666618380046;
        Mon, 24 Oct 2022 06:33:00 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bk16-20020a0560001d9000b002366f9bd717sm4017259wrb.45.2022.10.24.06.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:32:59 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: processor_throttling: remove variable count
Date:   Mon, 24 Oct 2022 14:32:58 +0100
Message-Id: <20221024133258.2158083-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable count is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/acpi/processor_throttling.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index a822fe410dda..00d045e5f524 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -50,7 +50,7 @@ static int __acpi_processor_set_throttling(struct acpi_processor *pr,
 
 static int acpi_processor_update_tsd_coord(void)
 {
-	int count, count_target;
+	int count_target;
 	int retval = 0;
 	unsigned int i, j;
 	cpumask_var_t covered_cpus;
@@ -107,7 +107,6 @@ static int acpi_processor_update_tsd_coord(void)
 
 		/* Validate the Domain info */
 		count_target = pdomain->num_processors;
-		count = 1;
 
 		for_each_possible_cpu(j) {
 			if (i == j)
@@ -140,7 +139,6 @@ static int acpi_processor_update_tsd_coord(void)
 
 			cpumask_set_cpu(j, covered_cpus);
 			cpumask_set_cpu(j, pthrottling->shared_cpu_map);
-			count++;
 		}
 		for_each_possible_cpu(j) {
 			if (i == j)
-- 
2.37.3

