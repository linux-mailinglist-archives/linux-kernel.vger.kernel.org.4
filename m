Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D6F6B3D28
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCJLD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJLDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:03:52 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D57AB0B93
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:03:51 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y11so5178074plg.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678446231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XleH2qRgkAjKfAnH5lQK+hOVQ6pdsI7iaFiOV1K3KNM=;
        b=XiDRYO83T5IVLmCtEQZzT/BbHCGItwcuH07SlSFOmcpngXMzlga/wCh7ysxNP/A/YE
         mcmmyycGgxwXys5FmYygNt+dHSwtRvgQCTBpLCDkhKmgMk9zL43qMYMTK8ghH9WC3Pto
         pwsC0jhjGGJ8w8mjTBLpZIgDEkjF4nvpIhLfKyYUMCJVbZ6Kj7LMbhOBSSJFvZcd+w9A
         4/yzqWqpiav55hJxJEbgCWoLuygmsYjU25r+HK78EDFbURJC8sEEhsPiu3cYyar5h60s
         2tZPNiCKcwM6l9e8egZz5PlLwmKjvdkEdPlChyQklWegJw3SkLY7kFR+DZNDgrThPcwZ
         hl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678446231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XleH2qRgkAjKfAnH5lQK+hOVQ6pdsI7iaFiOV1K3KNM=;
        b=HGDRRDqU9k1uP4+6Q+MLMRW2oNXglqimomKhqPsTqMtWXLoluMAl05K07wAsvwHaG8
         9o2nn10NoblgWFhQols8ssiptxZj/LICLYn8PAxo+rhYe1feWe3ibCk9/yqZk+ly7o/p
         v8gq/2muBI9gHwG5bhy4Gkswiy64pwkbJWF62OAY629zi0o947RK7/nxKepkX4BmIYuW
         qWLuEp1wRdBl8bV0aNGXENE04EeZm0y2PPjmYUFheyanx636OjNhpvBIp3BdkbgZyc7Z
         +RxiHTxxpjr+JCVRPEEeqaaEnhNrzXSFLOhAJBxRqaBW1PXIZTOXPcGBcY2oxgm6vMti
         ZDIA==
X-Gm-Message-State: AO0yUKVM39bvDgnkaT3nusp/SsUo/FIg6ADZGUngRAKayAG3ZR0MAM3D
        Axxace3qZHPPktYvStpAzRA=
X-Google-Smtp-Source: AK7set865FCFoop9BrawhZE2HX6WtNHrkBhZoeCOU2feBTrWr6GfrudljpNqhP6XTj11I6XM2ExoYQ==
X-Received: by 2002:a05:6a20:6909:b0:b0:3329:c395 with SMTP id q9-20020a056a20690900b000b03329c395mr2409010pzj.30.1678446231342;
        Fri, 10 Mar 2023 03:03:51 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id n7-20020aa78a47000000b005d3fdf7515esm1171477pfa.81.2023.03.10.03.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 03:03:51 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH] riscv: Kconfig: enable SCHED_MC kconfig
Date:   Fri, 10 Mar 2023 19:03:36 +0800
Message-Id: <20230310110336.970985-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
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

RISC-V now builds the sched domain based on the simple possible map.

Enable SCHED_MC to make the building based on cpu_coregroup_mask()
which also takes care of the NUMA and cores with LLC.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c5e42cc37604..5b9fdc1a619a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -320,6 +320,14 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config SCHED_MC
+	bool "Multi-core scheduler support"
+	depends on SMP
+	help
+	  Multi-core scheduler support improves the CPU scheduler's decision
+	  making when dealing with multi-core CPU chips at a cost of slightly
+	  increased overhead in some places. If unsure say N here.
+
 config NR_CPUS
 	int "Maximum number of CPUs (2-512)"
 	depends on SMP
-- 
2.20.1

