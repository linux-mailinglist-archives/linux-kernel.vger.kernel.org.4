Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA25675FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjATViL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATViJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:38:09 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0309E29176
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:38:08 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id y25so9934264lfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jwiYC8m/SXFufpuSx2buV2p4E0ygNKxslx+oTKyBdro=;
        b=Vxw8cpeuxEDUD20Qyarvh7pFO8BkkiYniHTS5hzXJTWtVeofrEz4vhOzmloV+w8YMJ
         PvFy9oZy9zFfiZEyok8ujofE8LVJ785Qc/F7Y/3iS44IJAVOpZgiLjJuCgiFlL7eYIE4
         L9WrmIzKz2P9IKYmrVQQrSthLBq1QZo12JKCNYn91iLHxgtnyua5WOKcl7Oow9WlgohG
         yHVqppJOhW/X8X1GhDZPEI/r75fZyUPzQjEkuQTqmdKFLy0R3B7YZP5dgYn1g8lip9pT
         6gFOb4JNKRqAezA+h7IRhIkuchUICUu/UeZA9zy1zHQafhbvjGP4b+UM/zdbHkAoe49C
         nAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwiYC8m/SXFufpuSx2buV2p4E0ygNKxslx+oTKyBdro=;
        b=NimvNxrAbQmp254jbXi05hEm25o9qdGfXeV7zts7kxuNCxTXeZz/fv+wsDgvCCcDCG
         IKvHt7opGSU58iry241xy89ZfUYYvBlgQ+FyMp0Qna0lZewDE3pCev/F8gaW3dLcc4au
         UdNQnyHSWcR1naKfA8YB651C66jZ+bt6d6X1uoSUhDhsT2opiOmKVL/BU78rdAFemiFz
         TlD5ik/vcpoK3NbYzifCZDVnltCK9g0+FP+DGaMsx467U72vFZcP7qf03pDzpKw9Rl5c
         yqph6OdiJ2/+Xw7TZ0OtwwxcuxkSwY5M0I/4K9HHOZS1oyU1r8uDKLKjNbgEoVy8K9uY
         W67w==
X-Gm-Message-State: AFqh2kpxq4uED76BAkBD5JCTaMxoN7NjGvcYj0dkO7dR8EZkiBfe0PWd
        4M5W73jqUytpXTZ3DlyHXVPhU8GrKh8XzQ==
X-Google-Smtp-Source: AMrXdXtbz7lcA+oEszOH9suo7AlAwAnGr73g4ckQh62MJjrODeBXEoG4wtuWMCr5zs/BuO2fX4XPTQ==
X-Received: by 2002:a05:6512:224d:b0:4a4:68b8:9c35 with SMTP id i13-20020a056512224d00b004a468b89c35mr5759608lfu.29.1674250686211;
        Fri, 20 Jan 2023 13:38:06 -0800 (PST)
Received: from localhost.localdomain ([46.147.136.0])
        by smtp.gmail.com with ESMTPSA id g38-20020a0565123ba600b004d2199ea23dsm2476783lfv.0.2023.01.20.13.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 13:38:05 -0800 (PST)
From:   Alexander Pantyukhin <apantykhin@gmail.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     hch@lst.de, linux-kernel@vger.kernel.org,
        Alexander Pantyukhin <apantykhin@gmail.com>
Subject: [PATCH] kib/uuid.c: add check for length for uuid_is_valid
Date:   Sat, 21 Jan 2023 02:38:02 +0500
Message-Id: <20230120213802.2467-1-apantykhin@gmail.com>
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

Add check for length strict equality for uuid is valid

Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
---
 lib/test_uuid.c | 1 +
 lib/uuid.c      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/lib/test_uuid.c b/lib/test_uuid.c
index cd819c397dc7..7a3d258fa695 100644
--- a/lib/test_uuid.c
+++ b/lib/test_uuid.c
@@ -37,6 +37,7 @@ static const char * const test_uuid_wrong_data[] = {
 	"c33f4995-3701-450e-9fbf206a2e98e576 ",	/* no hyphen(s) */
 	"64b4371c-77c1-48f9-8221-29f054XX023b",	/* invalid character(s) */
 	"0cb4ddff-a545-4401-9d06-688af53e",	/* not enough data */
+	"0cb4ddff-a545-4401-9d06-688af53e7f8412" /* too much data */
 };
 
 static unsigned total_tests __initdata;
diff --git a/lib/uuid.c b/lib/uuid.c
index e309b4c5be3d..ca10e2b4334b 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -89,6 +89,9 @@ bool uuid_is_valid(const char *uuid)
 {
 	unsigned int i;
 
+	if (strlen(uuid) != UUID_STRING_LEN)
+		return false;
+
 	for (i = 0; i < UUID_STRING_LEN; i++) {
 		if (i == 8 || i == 13 || i == 18 || i == 23) {
 			if (uuid[i] != '-')
-- 
2.25.1

