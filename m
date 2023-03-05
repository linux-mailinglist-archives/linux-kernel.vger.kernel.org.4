Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462B66AB1CE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 20:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCETCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 14:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjCETCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 14:02:12 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC323FF38
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 11:02:11 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p20so7921574plw.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 11:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678042930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U+mp5zRHSHyALc5ydPblr+WN4ZpYMT8cP0ReLdHKSAc=;
        b=XgfRQ/MeNdL1kZXDrdC321CjJ2vCCoSEes/6GX83xRjLAJItC9gdFzCIIurqoUTkDk
         YxZgEw7d7gMkja853czfBYNZJum0Mv84ntSHjJtz0P9iHjXDcWNPXWYdNorNaVQKpP37
         3j6hQSDAlFT+wLmU92SgazG4Y2MEM+wNJe6S0/3rjUYAKtA7qDRO+ZHjhVTBohWg17JV
         5bg2VWGJ434eofY1fKyg+2RMnMuqRnhLRrfkYd916Dx5vUoGlkHF9kqEK+kuVLsE9K/4
         +pq4Hwv8x/kRHnb6iPgsLPu2SO+e9jH8mfBr/IB5WInwFwtvDboplo9wDM1kblvpsQTD
         BiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678042930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+mp5zRHSHyALc5ydPblr+WN4ZpYMT8cP0ReLdHKSAc=;
        b=1l+CguIE1vkCDUKUJ2GA8+1DzZJ+fx0YIBpHplFzJOHu+Cf4N4VjR0mrlIMEy2lVJb
         F9QGeMzitelHaEzZ89BtRQfo1PVYhBv3BxH1aQfPbDhta2/iH9UOFZqpJg1lWuUv2pe4
         PiwbBTXRunvtZl18Ek4mmVwFjgi81Vjrf2H7GDgi32a/o9xac5hxGrEpvCyBTvd6lpw6
         vv8zG0f4bq2ckPjMXtICv3rBB/Ci4rTHfaHF3WQZwnwXPM8EHFdCfOB+JiSAV4wCEG0h
         wOtzqpWe3ALCOEeqbyqIrys+kJe1RrWVKSjojmu95r7kGtXyAYDc720IeaDG2CNj0jLd
         cFuw==
X-Gm-Message-State: AO0yUKXDg/ipoOtyTk9J1ET58Dofg4LyGhMH4vZN7VlWshdhoYDiScI3
        vXlhyJv45NdWAQ2Z9lsUrA852oCFTt8QXQ==
X-Google-Smtp-Source: AK7set/FK4OzW0Z9Kvl/61MoI09lNDsxtQyIhTgbvA3xbOVB5MB8DcbYtmazXMAwm/eHDIM0Kw9+eg==
X-Received: by 2002:a17:902:b489:b0:19e:29ce:697f with SMTP id y9-20020a170902b48900b0019e29ce697fmr8524340plr.41.1678042930224;
        Sun, 05 Mar 2023 11:02:10 -0800 (PST)
Received: from localhost.localdomain ([122.50.220.43])
        by smtp.googlemail.com with ESMTPSA id p10-20020a170902e74a00b0019a8b057359sm5039078plf.130.2023.03.05.11.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 11:02:09 -0800 (PST)
From:   Santosh Mahto <eisantosh95@gmail.com>
Cc:     eisantosh95@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: android: ashmem.c: Declared file operation with const keyword
Date:   Mon,  6 Mar 2023 00:30:57 +0530
Message-Id: <20230305190057.17482-1-eisantosh95@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl script.

Signed-off-by: Santosh Mahto <eisantosh95@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index c05a214191da..f9cfa15b785f 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
 
 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	static struct file_operations vmfile_fops;
+	static const struct file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
 
-- 
2.25.1

