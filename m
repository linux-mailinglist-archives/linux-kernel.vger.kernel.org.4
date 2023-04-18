Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD4A6E6B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjDRRmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjDRRmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:42:10 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFA14691
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:42:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a67d2601b3so17502305ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681839725; x=1684431725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sHyjYp6Hjl+6GDv9l+kCEg3GNInbwlyw7HjQ8Eh94JI=;
        b=XrAb43vwMDc65b3HQn6MCi+VmFmdVYtAsimCWPePMYUKZS5Tx6Hluo9tyLwy9Kaj0R
         SGXLBS8Yl/LNp4RmXtLVTeyiEsiv4WQbeNHOxKGmp1EbFy6Sk9TVP6ZSOHQOYmRx8yzJ
         OK5qVWkUT7fkN/YNRLNoRVXeFAJmzFvJtmcVgNSeLo5D8wOlACTiRUDxFWlMwL4aGwmV
         dOA8piybU5NtaSFziNIeBf2KdFKgEeYAWaCAFITn7g2y25ZDQFc6n9se9JFlBbJVBFaq
         3AL9kT4KKvCt9TzBK3iyJ6FnJkEaaMJFw8Evf5qsdfHUHML92PDs7T8kFVuQ6CI/MPPz
         DrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681839725; x=1684431725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHyjYp6Hjl+6GDv9l+kCEg3GNInbwlyw7HjQ8Eh94JI=;
        b=P6+MZSfhV5VzhFZpVvU9DMOF+Ch5uTIwVtthudzJRZyMHtbCWyHWLQooOiVUmiWKXM
         B04M3yNFVJEPgvAcba5H7Sjf8VS0ds1RhjySST60wCgK21YPjdCduZ9M+Bb3Kp2GmIHX
         hZsZaVd93xPodMaac+JT/I1WSD6hzSQ1q1sMIx23kEDvnNgiOAyqLE9wMI04W/JIukQ4
         qofTzXWz3Q9yTFBijHIsnx4u/t4PMspUjd5IUStFXh6lUZr96yHcnDRTTavJRpx62vJ4
         TY8ufnLndZYSHjzll4aFpwfmktPlfdKO9s9WyEpNNDjoL1puy1wfFdavfUUHgItgBPmx
         Gx1Q==
X-Gm-Message-State: AAQBX9fy9J4WPtGjtAd5D2eZscr1RtNWbBwfPJqqIzVZ8Uvrkbwh+GTB
        hLCxZgUW2VyQtRzV5urGeTzwWT7SW8Y=
X-Google-Smtp-Source: AKy350ZrYckzFA5/P3ZMGw/eDtJ2wO64rJ03YAM30EEAXMnHOYF4qIVIa6UTRInFUkoW2lDHVPtmdA==
X-Received: by 2002:a17:902:d2c6:b0:1a6:9d98:e763 with SMTP id n6-20020a170902d2c600b001a69d98e763mr2929403plc.26.1681839725130;
        Tue, 18 Apr 2023 10:42:05 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:e22b:bd7c:4df6:1ae0])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b001a522cd8545sm9880563plb.130.2023.04.18.10.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:42:04 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: allocate node blocks for atomic write block replacement
Date:   Tue, 18 Apr 2023 10:42:01 -0700
Message-ID: <20230418174201.3274634-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

When a node block is missing for atomic write block replacement, we need
to allocate it in advance of the replacement.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c35476b3c075..0e1e29800934 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -217,7 +217,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 
 retry:
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
-	err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE_RA);
+	err = f2fs_get_dnode_of_data(&dn, index, ALLOC_NODE);
 	if (err) {
 		if (err == -ENOMEM) {
 			f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
-- 
2.40.0.634.g4ca3ef3211-goog

