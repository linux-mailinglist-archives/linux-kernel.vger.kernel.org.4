Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9963666058D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjAFRVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjAFRVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:21:18 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA357D1F5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:21:17 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id r72so1004805iod.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 09:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bsdimp-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dnx4N+OQn0QuEKmvfhqG2BPeqQB9ohu9oSWGkfmaPyU=;
        b=Fn8EiHIfDBw/66XdydZpN1Ps6E9bXL/8/A/WalBjrZcSXiTor5KyLIqZHoOsYiunux
         ktDm/mln44prujXc5jF0fMeGeY6tymaOYXXDaEQ7lM21Z56vHPkIR2zaQ76O5JQFLbvP
         2fT+oilVGb/o25go8u1Mmet2/JtQXVg4CFw+wZV5l8h8J8gXyQgPiJ9WSpGP1YqhNFhq
         bM4lZ7gdFCg2Jv3q5V2hHxjzX2Tp9379IHFT9gwfxHO7iPjYHZPz4TTLxDBRoMhlvEcu
         YHFXPcnz0IbniDXDr6sfRS+adfn/1bfokAPkSU12KPAEsRxlvNsbrEfPKHD6mmIv5w8D
         PVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnx4N+OQn0QuEKmvfhqG2BPeqQB9ohu9oSWGkfmaPyU=;
        b=yuR8oFrpabFH4YV9/arfZNAotJGK87V0TnsM6LNgW7v34H7jXRZzCk0FgbklIqP2/S
         QyiFUtGREjdboYk4angc0lXpaumbYh53oyQgX0dyDDA732jRFfL/dQqBD1VjrLsKEWmi
         VkEcszDogWsbtmzMu+77foOFwHNO4ljfDowkqu1kR8HrKSE1xhTerN8kTWWFBieZOFY2
         wdnabdnm+mUI6Cb1xrWxdVMxCIyVqDPPWmGe2k2x9zayvplTuHxe1NiBeOWnM2mrKqpp
         NjRoCW3J5cRlD+u3A9K3IBYKM5LxiCItsG5x8GUw6aXIc4aPklTNsnO5eT8OtMy934XY
         BHeA==
X-Gm-Message-State: AFqh2kraDtPXsM8qAzfdreOeay85yGCxAil4CHUV9y8dHbUrtAN2k1Ej
        GTPMq6lwH62u4itPh3OxBdZBwg==
X-Google-Smtp-Source: AMrXdXtDquIc11hr+NAGdsZDPAnC27KArduGyR1b8XQtRsaoginAvmdmyC55X/rPIAZb/XfzfeM4iQ==
X-Received: by 2002:a05:6602:124b:b0:6e2:d3f9:56d with SMTP id o11-20020a056602124b00b006e2d3f9056dmr43272805iou.0.1673025676792;
        Fri, 06 Jan 2023 09:21:16 -0800 (PST)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net. [50.253.99.174])
        by smtp.gmail.com with ESMTPSA id k1-20020a0566022d8100b006e4e8ad6b2bsm499289iow.36.2023.01.06.09.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 09:21:16 -0800 (PST)
From:   Warner Losh <imp@bsdimp.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2] tools/nolibc: Fix S_ISxxx macros
Date:   Fri,  6 Jan 2023 10:18:34 -0700
Message-Id: <20230106171834.41532-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mode field has the type encoded as an value in a field, not as a bit
mask. Mask the mode with S_IFMT instead of each type to test. Otherwise,
false positives are possible: eg S_ISDIR will return true for block
devices because S_IFDIR = 0040000 and S_IFBLK = 0060000 since mode is
masked with S_IFDIR instead of S_IFMT. These macros now match the
similar definitions in tools/include/uapi/linux/stat.h.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 tools/include/nolibc/types.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 959997034e55..7770328dcef7 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -26,13 +26,13 @@
 #define S_IFSOCK       0140000
 #define S_IFMT         0170000
 
-#define S_ISDIR(mode)  (((mode) & S_IFDIR)  == S_IFDIR)
-#define S_ISCHR(mode)  (((mode) & S_IFCHR)  == S_IFCHR)
-#define S_ISBLK(mode)  (((mode) & S_IFBLK)  == S_IFBLK)
-#define S_ISREG(mode)  (((mode) & S_IFREG)  == S_IFREG)
-#define S_ISFIFO(mode) (((mode) & S_IFIFO)  == S_IFIFO)
-#define S_ISLNK(mode)  (((mode) & S_IFLNK)  == S_IFLNK)
-#define S_ISSOCK(mode) (((mode) & S_IFSOCK) == S_IFSOCK)
+#define S_ISDIR(mode)  (((mode) & S_IFMT) == S_IFDIR)
+#define S_ISCHR(mode)  (((mode) & S_IFMT) == S_IFCHR)
+#define S_ISBLK(mode)  (((mode) & S_IFMT) == S_IFBLK)
+#define S_ISREG(mode)  (((mode) & S_IFMT) == S_IFREG)
+#define S_ISFIFO(mode) (((mode) & S_IFMT) == S_IFIFO)
+#define S_ISLNK(mode)  (((mode) & S_IFMT) == S_IFLNK)
+#define S_ISSOCK(mode) (((mode) & S_IFMT) == S_IFSOCK)
 
 /* dirent types */
 #define DT_UNKNOWN     0x0
-- 
2.33.1

