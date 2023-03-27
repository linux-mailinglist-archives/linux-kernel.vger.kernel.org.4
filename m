Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412EB6CA5B6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjC0NZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjC0NYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:24:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E0D358A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679923411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ui34VP0V+QC6wWMG4ZdbC0pVVInhui/1SjnIEjUUE7Q=;
        b=h7jcINu4l+kFvzs3y0iNs1ZywrdEes87FzOsTa1eeunBDOcNiqmVyXrgRvNL/UAUl/X3wT
        x6kCuVHSi9T7151Celo1sdjcXser/rLtxIL2znHVKBXYzMxZQS+fZRXuYLfYMavbha4u35
        8kGLERX483uWDCT+SwZ7ky2+so0O0sc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-mwOjdXVVP_GTuZ7s8fzxPg-1; Mon, 27 Mar 2023 09:23:30 -0400
X-MC-Unique: mwOjdXVVP_GTuZ7s8fzxPg-1
Received: by mail-qk1-f199.google.com with SMTP id 66-20020a370345000000b00746886b1593so3957252qkd.14
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679923409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ui34VP0V+QC6wWMG4ZdbC0pVVInhui/1SjnIEjUUE7Q=;
        b=nIBhM+nJXs7zgu1ByKUBcEaOlVIQFnETHJ1LcRHJ8+gGgghaHNYI4PE8f2M/09lvCm
         Y0o69TCWmQTPiT0+xuBmnJIcwyO/NTHGeMMH0Qhn+GjoFJ6xneLPRkxqPXSldF7jfwf0
         /kKrEd6E030WVjLilCMnEyw8eMBuXzhIyib9u8Zd0pQIUbnYFnUUchAPE1etDqA9hfVB
         MI4Rh06MnwCTb/chSaQS1ch8JpZ7JJV0gE1FmiLRbc/sHhHZeLd69MdZAkbgpM8k6ZmY
         PYLogj9A2vRf51oPxlbBlyXx2No0U+M1noFemzHPgX1Sc0/48pfB/dMJloSDdjyWGX/G
         D0Gw==
X-Gm-Message-State: AO0yUKWmovebLj4BbHGHaiz5rZpww9fLWc+4DPmlmQut7BOd8lWxZz8R
        odn9JRrVFjHNa1IrezkZTwlf/Y4NXnrtCCP/8fh3oZsLejkorV7q/8jqDSpB2QSSYVw4d8EfImH
        PO7oU+oLQNPc/yQLpqz5+nMdr6CqWB6ZS
X-Received: by 2002:a05:622a:40a:b0:3db:7f42:ab0f with SMTP id n10-20020a05622a040a00b003db7f42ab0fmr19454884qtx.67.1679923409754;
        Mon, 27 Mar 2023 06:23:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set+TKrzjeDXUF1w6E7KXi6Z2D3VUgzjcBgQe8o1XtRAeXO/pT5DBPtMKGbooPmazbkCED5aifw==
X-Received: by 2002:a05:622a:40a:b0:3db:7f42:ab0f with SMTP id n10-20020a05622a040a00b003db7f42ab0fmr19454839qtx.67.1679923409444;
        Mon, 27 Mar 2023 06:23:29 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j23-20020ac86657000000b003e0c29112b6sm10606129qtp.7.2023.03.27.06.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:23:29 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     song@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] md/raid5: remove unused working_disks variable
Date:   Mon, 27 Mar 2023 09:23:24 -0400
Message-Id: <20230327132324.1769595-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/md/raid5.c:7719:6: error: variable 'working_disks'
  set but not used [-Werror,-Wunused-but-set-variable]
        int working_disks = 0;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: remove brances
---
 drivers/md/raid5.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7b820b81d8c2..812a12e3e41a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7716,7 +7716,6 @@ static void raid5_set_io_opt(struct r5conf *conf)
 static int raid5_run(struct mddev *mddev)
 {
 	struct r5conf *conf;
-	int working_disks = 0;
 	int dirty_parity_disks = 0;
 	struct md_rdev *rdev;
 	struct md_rdev *journal_dev = NULL;
@@ -7912,10 +7911,8 @@ static int raid5_run(struct mddev *mddev)
 			pr_warn("md: cannot handle concurrent replacement and reshape.\n");
 			goto abort;
 		}
-		if (test_bit(In_sync, &rdev->flags)) {
-			working_disks++;
+		if (test_bit(In_sync, &rdev->flags))
 			continue;
-		}
 		/* This disc is not fully in-sync.  However if it
 		 * just stored parity (beyond the recovery_offset),
 		 * when we don't need to be concerned about the
-- 
2.27.0

