Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2460B6DBB5E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjDHOCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjDHOCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:02:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CFFFF01
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 07:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 212FD61595
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 14:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59ED7C4339C;
        Sat,  8 Apr 2023 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680962548;
        bh=JyNl4ARckRodp1O8pkh/0UW7Q6hGHn4B98FxtpuA1Dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aAFWvUzOXYu18nPeredW7o6B3Fa9NCeR9t0aWYkUFruuCfIl5mv2wOOjnSZO/9JBU
         JTo0nEZEu+tEXfY1BlYSXhYMcRpEWqBP41/oxdrve1dAan2Chh+iWSLfefRQTElU16
         5DXmVRnUbdT+7Uv94BjavuD/SPD7LQJ8oEQkNT6FKd6buxiEgluzPfosVMesHSTxKb
         qXhQc+kXEHpWf+wOyz57N246mb/Eb3IGlr4NKUHIANRKeY1VVmEAU/spRniEFZjsVx
         wvzgkvrKJor8awTg+FyGOu1fB2o/OtwO65EdEK+yxGANxvBaMoQe5w5+V9/WHqNHzc
         Go1R6+MbULNXw==
Received: by pali.im (Postfix)
        id 010B52047; Sat,  8 Apr 2023 16:02:25 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/13] powerpc/85xx: mpc85xx_{ds/rdb} replace BUG_ON() by WARN_ON()
Date:   Sat,  8 Apr 2023 16:01:12 +0200
Message-Id: <20230408140122.25293-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230408140122.25293-1-pali@kernel.org>
References: <20230408140122.25293-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

No need to BUG() in case mpic_alloc() fails. Use WARN_ON().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  | 4 +++-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index c6016915264c..98cca1102e0b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -62,7 +62,9 @@ void __init mpc85xx_ds_pic_init(void)
 
 	mpic = mpic_alloc(NULL, 0, flags, 0, 256, " OpenPIC  ");
 
-	BUG_ON(mpic == NULL);
+	if (WARN_ON(!mpic))
+		return;
+
 	mpic_init(mpic);
 
 #ifdef CONFIG_PPC_I8259
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index c7ce8a79992d..a802053b37b3 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -39,7 +39,9 @@ void __init mpc85xx_rdb_pic_init(void)
 
 	mpic = mpic_alloc(NULL, 0, flags, 0, 256, " OpenPIC  ");
 
-	BUG_ON(mpic == NULL);
+	if (WARN_ON(!mpic))
+		return;
+
 	mpic_init(mpic);
 }
 
-- 
2.20.1

