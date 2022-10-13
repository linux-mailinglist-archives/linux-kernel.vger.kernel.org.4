Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099D35FD44F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 07:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJMFus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 01:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJMFuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 01:50:46 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30181EE8AE;
        Wed, 12 Oct 2022 22:50:45 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h185so701517pgc.10;
        Wed, 12 Oct 2022 22:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzglpC5mbRdLW9j3rb/103BSHrz15C42kGNA5aA2nE0=;
        b=UKSPc/M1Lon+j3O3SOYw9MJ2zanPgvc02TQ5DNxZolQ3mvOy90PA1LQib0AfgFcu5E
         GeY6zE+OP0Xrh9Zir+qY5XHsS0WUT/Onp0ON8sonvbUDhQM+uGxSYc6kATCNHLCc7wJ3
         1GBVX0aB+Xjo6UDP/eqrEQ8tmA2IMicrsV0YinLaFLDAhInv7DiorCC/QTmkM44xruA9
         ofPpkhBVufG0balWVBNZbnK6AAXKQGt3NVQn54oekSXuoXGth0pzyCYb5dyMz9sQ4oEJ
         gx3E2gtIrH5t+oJeZAx6esgwLPy//+CT2KMUSnx8zIxtGcfenfxaWNvFkWzPVK/s8FFy
         Gmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzglpC5mbRdLW9j3rb/103BSHrz15C42kGNA5aA2nE0=;
        b=f9e/I5yz8EQHxPHVjJnNGL7D+QrgSbYH7n3TIZ8xcr6IHblYfqZOi9HMX//qAN9UGf
         hVTicLNBE/D8gUyl/aarKhp7j096q5wCgO7ogjBfV0A7dqL1dcXQKs0tvqfa0hhI2l8K
         uZQGGH9nHSj+5scfKeHJBf1FW+dqe7XArE5HYRrxPLNZUFr82LZr0K669ws5BcGHI8rO
         H8BcLvI3nTKfrneGrvWxfhURv+kq0yG5p1CXq38US1/E0rXWbIYMr7yba6MggAoaU1Yy
         Oow7k3gpx1xZK7eHV5cBky50kir7Gcwkve2+CJpcMbl0czj8cvVhf9fCl/D+2m0SZTX3
         F7Tw==
X-Gm-Message-State: ACrzQf3qPTGv0/XQ5fm91OcG6+ul2xrD59PPYjyRVTh5ztcKeUmOMaBk
        u2S9vAei80rpUtPHJ06qEeYoBEeIOCyNQg==
X-Google-Smtp-Source: AMsMyM7yzkp2mNyivgowhvxnV39yZ0+ISwIQHG8SkCbYC+HjbN4G6d7iiMoRC0YwNpjL9zq/I8mJfw==
X-Received: by 2002:a63:ff1b:0:b0:43c:e4ee:e5e0 with SMTP id k27-20020a63ff1b000000b0043ce4eee5e0mr27532658pgi.540.1665640244405;
        Wed, 12 Oct 2022 22:50:44 -0700 (PDT)
Received: from localhost (ec2-3-6-129-254.ap-south-1.compute.amazonaws.com. [3.6.129.254])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b0017f7bef8cfasm11774337ple.281.2022.10.12.22.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 22:50:44 -0700 (PDT)
From:   pmanank200502@gmail.com
To:     rafael@kernel.org
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manank Patel <pmanank200502@gmail.com>
Subject: [PATCH] ACPI: acpi_pcc.c: Fix unintentional integer overflow
Date:   Thu, 13 Oct 2022 11:19:48 +0530
Message-Id: <20221013054947.1355884-1-pmanank200502@gmail.com>
X-Mailer: git-send-email 2.38.0
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

From: Manank Patel <pmanank200502@gmail.com>

Fixed unintentional u32 overflow by casting it to u64 before multiplication.

Signed-off-by: Manank Patel <pmanank200502@gmail.com>
---
 drivers/acpi/acpi_pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index ee4ce5ba1fb2..b929d2e5c622 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -112,7 +112,7 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
 		 * processor could be much slower to reply. So add an arbitrary
 		 * amount of wait on top of Nominal.
 		 */
-		usecs_lat = PCC_CMD_WAIT_RETRIES_NUM * data->pcc_chan->latency;
+		usecs_lat = PCC_CMD_WAIT_RETRIES_NUM * ((u64) data->pcc_chan->latency);
 		ret = wait_for_completion_timeout(&data->done,
 						  usecs_to_jiffies(usecs_lat));
 		if (ret == 0) {
-- 
2.38.0

