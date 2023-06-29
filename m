Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236B174248F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjF2K6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjF2K6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:58:50 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520B4C3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:58:49 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-765a5f7abc6so53844885a.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688036328; x=1690628328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4VnJRF+bvKvFG7e8QSGNJVbP7sD6ShtvV0wC+uPz2w4=;
        b=o+qZW/ID5ykc5l20pWKMRIfquYco820JW+lACiz582Rsj0smJHw5Z3gH65bwUneaXA
         yNqJHtP+M8vGgBhLymuXaUOXZ1UyEfXQ2lp7hMt4szT+h7oko6ubijEU9SlZcazeE678
         zEOmKvdpw9Hth6CA9pDyIqCdNno+GS/7J03Sgblkfs5mhZrsRPy+TkvermqpEXR7WYdD
         82mgiIaB8umzKsR3XxXeg5WMQyy9cmuNEuVDM21wTsA7j2rXLY8twTS6UH4q2a8Krxil
         1tQ6fEKUot0PAbjfskZeyu3UWOshyNFXy+O3e2/yJfAGBSyu/9zQQsJzQ6PmcUjN8p85
         U3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688036328; x=1690628328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VnJRF+bvKvFG7e8QSGNJVbP7sD6ShtvV0wC+uPz2w4=;
        b=gzxGzt5HDZhvFEuuZVJMZ/JbqjyYcrr8NrW6Ptp4ManaTliX65dtFfDzBcOPA9ZaoS
         cnJJFQu6ReL6bSMj66gKGiz6o0l4FrY2Il7YFpqnlyGZxcTUx0DNZ94njj11Hnt8i964
         a5fF5F46JKqRWbVujdn6J3BFlnjtTXSXs6IUfIkwkSVx0bW5LpsfG7fbY5uWesc2/iSE
         Nrtidk4eK49tsAnd06Jem1hOJYn0PMSWULvLRcZDpuo+PRJIx5eq/U40H6KDtvJsEBJK
         xKhB8EYAWrnvWutXGfYrMICDz8MA7IgYSJDKtaOsqcceH8urR2ASfKYnZGzy6psrEYLV
         xy5g==
X-Gm-Message-State: AC+VfDzJCzVZz6C9yuSysXl1Tr4SsifZZ0TLICB44H8FjLRfKhTSySB7
        X5Qq8t3BUvh7iJRH9tWE4rA=
X-Google-Smtp-Source: ACHHUZ5l2fGgSesEkEiyi9CYPVPtoZ/T7+l/KE9QTC0baTm/v3rkXZmUpjQBPEQ9ufeg2STeuhmC+g==
X-Received: by 2002:a05:620a:d89:b0:767:2f4a:e07a with SMTP id q9-20020a05620a0d8900b007672f4ae07amr2027566qkl.68.1688036328270;
        Thu, 29 Jun 2023 03:58:48 -0700 (PDT)
Received: from localhost.localdomain ([58.240.82.166])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a195d00b0025ef39c0f87sm9734017pjh.0.2023.06.29.03.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:58:47 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        ajones@ventanamicro.com, sunilvl@ventanamicro.com,
        heiko.stuebner@vrull.eu, apatel@ventanamicro.com,
        suagrfillet@gmail.com, evan@rivosinc.com, greentime.hu@sifive.com,
        leyfoon.tan@starfivetech.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: BUG_ON() for no cpu nodes in setup_smp
Date:   Thu, 29 Jun 2023 18:58:39 +0800
Message-Id: <20230629105839.1160895-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting with ACPI tables, the tiny devictree created by
EFI Stub doesn't provide cpu nodes.

In setup_smp(), of_parse_and_init_cpus() will bug on !found_boot_cpu
if acpi_disabled. That's unclear, so bug for no cpu nodes before
of_parse_and_init_cpus().

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/kernel/smpboot.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 6ca2b5309aab..243a7b533ad7 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -187,8 +187,13 @@ static void __init of_parse_and_init_cpus(void)
 
 void __init setup_smp(void)
 {
-	if (acpi_disabled)
+	if (acpi_disabled) {
+		/* When booting with ACPI tables, the devictree created by EFI Stub
+		 * doesn't provide cpu nodes. So BUG here for any acpi_disabled.
+		 */
+		BUG_ON(!of_get_next_cpu_node(NULL));
 		of_parse_and_init_cpus();
+	}
 	else
 		acpi_parse_and_init_cpus();
 }
-- 
2.20.1

