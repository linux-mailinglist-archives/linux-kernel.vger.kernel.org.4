Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B39B6C0285
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCSPAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCSPAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:00:08 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0271912055
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 08:00:05 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id h83so4398972iof.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 08:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679238004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWTyC8q9bW9WXhCIYgpFi1ioer+rKbia0nk+iCnDLaE=;
        b=zrPhGgUPuhZTiE1GMvapYi+TQg+461FY2zP7scWaxHqr4Qb1r7FfATm1kn1reyh+/W
         TYoQplNA5mwqe5kwLiXPd7jUn8UMYgpYS5kbBesz2UI0tfScwqigaumWPfeJscJS1t7c
         kNVWqwjAunedLSiTbm0YwDLjtIyvDZpsawRX48gqXlaN4HbWJPlY7eCsJ4u6b15geU89
         pW+3o38oFHsmE42OBAJMDWNvFh1IKne5NrXG3+eSOq7KrKZX7OvANwxyRyjHnuNMfzyG
         JDLsoX0VTvnL+QqGGtVM7DDygme4lzjNeB+qmUuANUoEk+SvCgqjK6Ek4MXaW8u9iF6l
         GR0w==
X-Gm-Message-State: AO0yUKUs12s3vtJrdZ0F5GUVqHb4U2UrCJPsiTHDrZbMxaDaIVeRC6Bo
        t7UZ/N4bjedRnZJEsx1Zcw==
X-Google-Smtp-Source: AK7set+Y1iJKzRGZc9BSQKQB0EEZD5p/DugJm0DBFRNc1/Aez3ovfGKN1LTYRbcO/uIRcg+nZwHtCA==
X-Received: by 2002:a05:6602:2d48:b0:74c:aa8f:1f4c with SMTP id d8-20020a0566022d4800b0074caa8f1f4cmr2975100iow.8.1679238004161;
        Sun, 19 Mar 2023 08:00:04 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c4:7b93:58f2:478b:84fd:941e])
        by smtp.gmail.com with ESMTPSA id w71-20020a025d4a000000b003a2a167e7d9sm2428367jaa.96.2023.03.19.08.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 08:00:03 -0700 (PDT)
Received: (nullmailer pid 66044 invoked by uid 1000);
        Sun, 19 Mar 2023 15:00:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: powermac: Use of_get_cpu_hwid() to read CPU node 'reg'
Date:   Sun, 19 Mar 2023 09:59:31 -0500
Message-Id: <20230319145931.65499-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded reading of CPU nodes' "reg" properties with
of_get_cpu_hwid() dedicated for this purpose.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/platforms/powermac/feature.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 0382d20b5619..dd508c2fcb5a 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -1053,11 +1053,11 @@ core99_reset_cpu(struct device_node *node, long param, long value)
 		return -ENODEV;
 
 	for_each_of_cpu_node(np) {
-		const u32 *num = of_get_property(np, "reg", NULL);
 		const u32 *rst = of_get_property(np, "soft-reset", NULL);
-		if (num == NULL || rst == NULL)
+		if (!rst)
 			continue;
-		if (param == *num) {
+		if (param == of_get_cpu_hwid(np, 0)) {
+			of_node_put(np);
 			reset_io = *rst;
 			break;
 		}
@@ -1499,11 +1499,11 @@ static long g5_reset_cpu(struct device_node *node, long param, long value)
 		return -ENODEV;
 
 	for_each_of_cpu_node(np) {
-		const u32 *num = of_get_property(np, "reg", NULL);
 		const u32 *rst = of_get_property(np, "soft-reset", NULL);
-		if (num == NULL || rst == NULL)
+		if (!rst)
 			continue;
-		if (param == *num) {
+		if (param == of_get_cpu_hwid(np, 0)) {
+			of_node_put(np);
 			reset_io = *rst;
 			break;
 		}
-- 
2.39.2

