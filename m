Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749EB72A23E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjFISba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjFISb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:31:27 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B08035A3;
        Fri,  9 Jun 2023 11:31:26 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-33e5054ba6fso8890485ab.0;
        Fri, 09 Jun 2023 11:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335485; x=1688927485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBgb9qh78ul22lTen3bNkTv5w8c6tZwoVzvuQBQLYYo=;
        b=EdMUrxbRRnNgFhtbppf0b9TC1fWwOXV7z4PI/81RO/NFRF22Pq7HXwmkFcO7thPBre
         rIcIWry1XUDvh6yffsMRx8UvMSp3xpI2u7J1JHcpRN7Ykt1NOqaPcmtgEi7VtCGsjfUx
         B+jJjTdoerMDExaZqAg3MaxoLj7slwdpU7/vAFmqzXDCKCHNXVbMxgU+vPqpdFWzj3a0
         Fn4p5XdYudyn67VWd+PN/dfFuRNcxKk6XiNJ5JFJslLQ7X3ZvGMB5fqMcCebd8Vl5q5Y
         KdP4bCXV2gYUgykffZX5BE0iPhQ3qwO7GgAS8b8CUStTaA7YDalJJWCT+Bl5n7akg/wn
         32fg==
X-Gm-Message-State: AC+VfDzWiGxlWQzo6I1Mhd9HhFuY/WQ1Xj2KkTTvkntLaRWbBluoOXVw
        cXj1ZyWZzC3/hS+I4/muUQ==
X-Google-Smtp-Source: ACHHUZ5gDT89Oq0favPV6ld1NepU+kJNtymKnlHA5cFHax9M1Emu/pO9ymPRbgYmioX0BY9euQDJHw==
X-Received: by 2002:a92:cb49:0:b0:328:39a6:ed13 with SMTP id f9-20020a92cb49000000b0032839a6ed13mr2302251ilq.4.1686335485541;
        Fri, 09 Jun 2023 11:31:25 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h1-20020a0566380f8100b00411baa5ec5asm1073244jal.154.2023.06.09.11.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:31:24 -0700 (PDT)
Received: (nullmailer pid 1765745 invoked by uid 1000);
        Fri, 09 Jun 2023 18:31:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: pmac32: Use of_property_read_reg() to parse "reg"
Date:   Fri,  9 Jun 2023 12:31:11 -0600
Message-Id: <20230609183111.1765507-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the recently added of_property_read_reg() helper to get the
untranslated "reg" address value.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/cpufreq/pmac32-cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index ec75e79659ac..f53635ba16c1 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -378,10 +378,9 @@ static int pmac_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 static u32 read_gpio(struct device_node *np)
 {
-	const u32 *reg = of_get_property(np, "reg", NULL);
-	u32 offset;
+	u64 offset;
 
-	if (reg == NULL)
+	if (of_property_read_reg(np, 0, &offset, NULL) < 0)
 		return 0;
 	/* That works for all keylargos but shall be fixed properly
 	 * some day... The problem is that it seems we can't rely
-- 
2.39.2

