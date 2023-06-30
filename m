Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502747437F7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjF3JMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjF3JM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:12:27 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C6419A9;
        Fri, 30 Jun 2023 02:12:26 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76243a787a7so160583685a.2;
        Fri, 30 Jun 2023 02:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688116345; x=1690708345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U3OWZLRqQetLfHFTZ6u2aD/brChhWjcBWjpONtMlo+U=;
        b=rcQTeJvpZZp1qbWeLdHWxHQjGqPDEeIjSG9m7lPJi5p7GcbsJ6OuT25dXD7yLXYVyW
         FEvxLNXGcjNzs9wGg966eGYT1Np6XujBE0T+19mM7A+vFAEwWj3KdgBqSYS9CCNywz6P
         T5k3sFl6Ddw5GxAfl4CRmUk7qj+49N9S++xy0wlpo/8pOL4Ijsh1cQ1ITMU/sICXGL4U
         K4IsyxAoHYsBGZrve00QqaUed2SJQr5XxRzflER825KlReNcJCmwYA/4wOGQX7s0h6af
         e2vFWnLAymgLJTidp/L/e4JYxRMfFBEupxdaW1v8qF0y7FBpK2fUTyG3UeVcPt8aUohJ
         wX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688116345; x=1690708345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3OWZLRqQetLfHFTZ6u2aD/brChhWjcBWjpONtMlo+U=;
        b=gGU7WWz2f4q2cDzc7nDFazZhE1YGvJHymfgRe95nvpMZ1uOOI3eiSawWqpuynmnhJo
         pbmLy8jH5Fp2HeZDHLbkJaUUy47epci8fizFuVBAy+0Fux9DIVYdcpsP9WW+nbVaeB0W
         b+bGC4/rrt6J+qI3TVULMh+CHybwchkAVha52l1K4Yc/ffWQORyS3Zscz7VZQzFmYEIt
         r0VCZ+m9rYW+v16PbvwGnRy7m5cdrb6byJkwnGc5xic3s0naw093QxoD/0fg/Y+LQRls
         31GuaEsVpNCIE1WDeAi6bUX+I4p+2MVSsNG1xKO+iO7Ymt9ink9JjReJPXF/EllF8cFp
         feYA==
X-Gm-Message-State: ABy/qLYDGFeT6wk754J192v+kC35l628oDnwgNeBG7SJB1fEmPXIWTaB
        eVDJ6xCkdoyrgp85nuMMheY=
X-Google-Smtp-Source: APBJJlHZn5r9p482U+9xyW1VLH4SJyeU5BHnQV5UimmvwVEWE/N/0MEDiXwtMEUXOjhsSn+fzyTolg==
X-Received: by 2002:a05:6214:3015:b0:635:db66:ae00 with SMTP id ke21-20020a056214301500b00635db66ae00mr2242418qvb.45.1688116345351;
        Fri, 30 Jun 2023 02:12:25 -0700 (PDT)
Received: from chcpu17.cse.ust.hk (fc3kcs10.cse.ust.hk. [143.89.191.124])
        by smtp.googlemail.com with ESMTPSA id df11-20020a056214080b00b006210e0365f7sm7700775qvb.69.2023.06.30.02.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 02:12:24 -0700 (PDT)
From:   Yiyuan Guo <yguoaz@gmail.com>
To:     code@tyhicks.com
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yguoaz@gmail.com
Subject: [PATCH] ecryptfs: keystore: Fix a buffer overrun in write_tag_66_packet()
Date:   Fri, 30 Jun 2023 17:11:55 +0800
Message-Id: <20230630091155.373667-1-yguoaz@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The encrypted key of a TAG 66 Packet includes 1 byte cipher code and 2
byte checksum, but the allocation size `data_len` ignores the extra 3
bytes. Fix the allocation size to avoid buffer overrun.

Signed-off-by: Yiyuan Guo <yguoaz@gmail.com>
---
 fs/ecryptfs/keystore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 2452d6fd7062..5cab0b800a03 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -302,7 +302,7 @@ write_tag_66_packet(char *signature, u8 cipher_code,
 	 *         | File Encryption Key Size | 1 or 2 bytes |
 	 *         | File Encryption Key      | arbitrary    |
 	 */
-	data_len = (5 + ECRYPTFS_SIG_SIZE_HEX + crypt_stat->key_size);
+	data_len = (5 + ECRYPTFS_SIG_SIZE_HEX + crypt_stat->key_size + 3);
 	*packet = kmalloc(data_len, GFP_KERNEL);
 	message = *packet;
 	if (!message) {
-- 
2.25.1

