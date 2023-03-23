Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91666C6098
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCWHYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjCWHYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:24:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2471CDBE8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:23:58 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so1189448pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679556237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buAA0gQONMWjkOKf6MOi67XvxnQyV7zOZpCFmaXgVLI=;
        b=BwyezKzNUfJO24XJVuCeWKjJ6IRxjZ5OOcKf8Yd902IfLfzLsna/DcHVVSTAbNhKrc
         pfvcZdbY4N0rWsUWviK4dJtIzMnBKTJR+gdbIyTsg9RxsNxzQM+mond4mqGZBbPx0jN4
         /2vdACU86PD3yHB4FUwCJj5Chni2Qtp9LvQQUF/zhCTJnvxsAUeDAr+MHnuwGFT6cx3v
         OqO8tJs3nd1/05RDD2+FOWJBaJYBVshaWdA7b85efOn9i38Ef6dqbvCSAY0KgWoA1nVh
         lyS/V+wK+dk4twEqJECyiDr3XgGzcngjcSHOYSI6Xz41a31PgE9+NQboqvUMzQBEZQSw
         Pk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679556237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buAA0gQONMWjkOKf6MOi67XvxnQyV7zOZpCFmaXgVLI=;
        b=ptJy5TeB7U359NPsbO9YrymtYkbp6DkMiDOYQDz2m4nKYyOCxO0itbrc1+8b01RG2Z
         7f64svVM1Ahv5kljOScJFVpZ7YCEZTUrqla+bifApZzsRny4/vCqqu0h6GSbuLsYzrdw
         mGKSMeCiygcRKgL8juDxGdfk2t36TYNj3bDeAjIxAk3tBhV0Rzjy0MJiVcfkFJXdBLxd
         3QddrJgzCzPxmGK6X1lAajJNNAwPbB6V0au/AoEhpO9CEjwqSo816k/MapC1KhuiiJfu
         WRgVQ2x2YtSuNbngL5FfPKdTN+tbgQz9hsLr7Khy89Z8bgipDDcyx9HzssKaQ5Z9pa/x
         RceA==
X-Gm-Message-State: AO0yUKVYqLlJxdlP28H5whIlG8yuxg9hOT7t9O0lmgK4Y2kKZaNbniCy
        h3Mwu/hHyJXVYQpG7XACP6Zj6r1ysWZu3TNX
X-Google-Smtp-Source: AK7set9SOXtJImuAOa1KTCi+7H6Igv15mIZLquTlrWTwPzp4jAwGniT1wHdZ3xUmfpJkH70sHH0irw==
X-Received: by 2002:a17:903:42c3:b0:19e:dc0e:1269 with SMTP id jy3-20020a17090342c300b0019edc0e1269mr4723439plb.7.1679556237546;
        Thu, 23 Mar 2023 00:23:57 -0700 (PDT)
Received: from DESKTOP-B5TBVBT.localdomain ([175.117.51.71])
        by smtp.gmail.com with ESMTPSA id je1-20020a170903264100b001a1ddd224desm5235691plb.89.2023.03.23.00.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 00:23:56 -0700 (PDT)
From:   Yohan Joung <jyh429@gmail.com>
To:     lkp@intel.com
Cc:     chao@kernel.org, jaegeuk@kernel.org, jyh429@gmail.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        Yohan Joung <yohan.joung@sk.com>
Subject: [PATCH] f2fs: fix align check for npo2
Date:   Thu, 23 Mar 2023 16:23:38 +0900
Message-Id: <20230323072338.175-1-jyh429@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202303231039.GKLRE8O5-lkp@intel.com>
References: <202303231039.GKLRE8O5-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix alignment check to be correct in npo2 as well

Signed-off-by: Yohan Joung <yohan.joung@sk.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 055e70e77aa2..46458085a8d0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1858,7 +1858,7 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 		sector = SECTOR_FROM_BLOCK(blkstart);
 		nr_sects = SECTOR_FROM_BLOCK(blklen);
 
-		if (sector & (bdev_zone_sectors(bdev) - 1) ||
+		if (sector % bdev_zone_sectors(bdev) ||
 				nr_sects != bdev_zone_sectors(bdev)) {
 			f2fs_err(sbi, "(%d) %s: Unaligned zone reset attempted (block %x + %x)",
 				 devi, sbi->s_ndevs ? FDEV(devi).path : "",

base-commit: d15180a8d1d72c7bddcb700d2c9ffdab7d2b9481
-- 
2.25.1

