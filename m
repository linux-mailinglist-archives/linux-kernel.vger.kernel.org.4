Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FEC660585
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbjAFRSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjAFRS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:18:27 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2EBC0E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:18:26 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id b192so980549iof.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 09:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bsdimp-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KK/JDhmXS+yoHfXL7PFZZQDeJlqt5IrvsvYG1DuRT/E=;
        b=DQPV4p+3Qh9a36+g92oG4nHrJXnnpOHi59uDVWjNw8RZMlDGq3xgAiD4azt18RVzlo
         JrIFBHAZ0JKFok5xNM18ndkXnEEMe1y+6dIql3DDc5h0IquMyvk41vrBMtfSTg2YxohA
         RjN0wIKjs0fjA41gtO5fzC/gpqQ/raSZP4OYhM2rxhStY7z88WKUqT46FZWu+T5AFE4d
         iyECtqUQi75WlngcwB8cRY+sVpphVcs1L1Pm7dJwO+rcPEt3wNRiP3WdqYTrMnG1gZKZ
         6FB+WjQtb+TqRww/bOmb+sMakn8nXoYaY0Y6gni9oW+2P/EkLPNOmz7Sr9JjLdyumuLc
         dw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KK/JDhmXS+yoHfXL7PFZZQDeJlqt5IrvsvYG1DuRT/E=;
        b=2ZSFW5Mn0jXg2GPgY0pTZ9ROD6CJDJo2L4DYKEXhMAtOAMYW1ygkw/EFdz9QbLEq9i
         N5xW8Kk1WsKQ9rU1Gzmq3bIFIfg+SNsqhxpfWbZjEMjNlk1NMyTokLT/8AlTyVGPtNjO
         tl9Owd9GwpRGyi+FavNML4AZD0/d66N0QrbOYptEn4HaQtV6lVFNKYRBZZ2Dk5vchc/N
         eKHLnht2HfpcrkwJZbb+gY+do5aKJRhWYLnk0YSTTzQj57pATl/8RaYY07EfexGXwJ6g
         7Wg2m9i0U8yW1AeHVZ5CA3rY/j28q+kxnU6Bf0M6Co3WuELXOeTB9kWKXTOOtrBJCYFr
         eEjQ==
X-Gm-Message-State: AFqh2kpkY8e9WUxOe9/qK7sZ+8J/Jc9TTXLr6PcYBUhqyK4gsJcodMNQ
        5p+ehy5RnHUDF5R1AQoRDPzF0qvmhXlB3ZOP
X-Google-Smtp-Source: AMrXdXt5ypOmnc6xtznGePq4JxYZg1fl9WKqZE5QNXkhDtEcgbAcZ9jKARdhqM3zoC5pu2eD0OB48A==
X-Received: by 2002:a05:6602:3785:b0:6ea:6c79:d224 with SMTP id be5-20020a056602378500b006ea6c79d224mr42840172iob.7.1673025506057;
        Fri, 06 Jan 2023 09:18:26 -0800 (PST)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net. [50.253.99.174])
        by smtp.gmail.com with ESMTPSA id i4-20020a023b44000000b00374cd28d842sm460263jaf.104.2023.01.06.09.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 09:18:25 -0800 (PST)
From:   Warner Losh <imp@bsdimp.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Warner Losh <imp@bsdimp.com>
Subject: [PATCH] tools/nolibc: Fix S_ISxxx macros
Date:   Fri,  6 Jan 2023 10:15:43 -0700
Message-Id: <20230106171543.41459-1-imp@bsdimp.com>
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
mask. Mask the mdoe with S_IFMT instead of ecah type to test. Otherwise,
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

