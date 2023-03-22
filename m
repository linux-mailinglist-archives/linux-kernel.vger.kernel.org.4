Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25BA6C4B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjCVNOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCVNOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:14:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952E937B46
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:14:29 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so19632302pjp.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679490869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=baxr/TfV6vb0mZSM+YpIGl9rUZD6xaIa7Gwpdmc5OPs=;
        b=Wmo5wz+2MsyX9LclYzujPJoSIBAygEI83ePf+HLkFRMJ2RmdHCkE2jQpsncyq6UqsA
         UzRJGDjb2Qk4E+1OkmnLaz82UOU8UV7/4/Jzcck9glym1w0WxnR+XvuqU3eT5/oK7V9s
         yQVuL/kcrQX3VjGi67GZ3CbsLdLjuqmJV0XHsQ8TFrcH5QMLo++Z4rCPhS/uUEyxAZio
         CgHbrRvI/43Yu46gUmsZKUp9dv62y74NWUUje/AsgNRZI9pfqhq86vAFsPn9fGxA1Qdz
         A2Ul0hszaOwL73L776o2LuZFhCtUXfhS4p4iyt1lQXosmtC13SGGn9U5tdeoz77e8Mc4
         D32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679490869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=baxr/TfV6vb0mZSM+YpIGl9rUZD6xaIa7Gwpdmc5OPs=;
        b=aMK0ylq/VAmT4zdsKCFL65hGMhNaoObpu1RZ6McLoVOvdOhScvnTD8BuvFjYZ1HRZp
         tyJTc5aKJLVw/L9MiTHx5tMcWUzGXocYaDaIb/2PVfh2upAP6KiL+zrKsuSXkKbHfVCG
         IAxmZKFE7qWTAFICD9ckZ8YkAcfv26Bwvlbz34H4cLwpAWyTY9mBgt6jhciQ2GZP2JRH
         lOmlazIzImpw8cEDACWi/99b3gOEbd+lZFG1c4A57jaXsHXpBtjfDuka7qZzU9RNlAid
         okjoXO7c0WyvyJ6wHdqVJ0qmx97HLJnMkxAWv9wvgsRjN5TT3ek0Se6pTvOyJmXdmmkv
         ykaQ==
X-Gm-Message-State: AO0yUKVt8IakcvlpzvRq5BKT1xFeLeRQs/eshHsxvxmUDK8/utoQGdKw
        utIrNRjPse599AQnWi+N4kA=
X-Google-Smtp-Source: AK7set+pi70MjDAx+ZKG581ampyYxjngbxcTO5dJPbA9C1GBChsou4z1lipYiBryJ0Td8UDuEfmABw==
X-Received: by 2002:a17:90b:1b4b:b0:23f:7666:c8a1 with SMTP id nv11-20020a17090b1b4b00b0023f7666c8a1mr3732804pjb.18.1679490869014;
        Wed, 22 Mar 2023 06:14:29 -0700 (PDT)
Received: from DESKTOP-B5TBVBT.localdomain ([175.117.51.71])
        by smtp.gmail.com with ESMTPSA id u62-20020a17090a51c400b00233afe09177sm13228631pjh.8.2023.03.22.06.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:14:28 -0700 (PDT)
From:   Yohan Joung <jyh429@gmail.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yohan Joung <jyh429@gmail.com>,
        Yohan Joung <yohan.joung@sk.com>
Subject: [PATCH] f2fs: fix align check for npo2
Date:   Wed, 22 Mar 2023 22:14:08 +0900
Message-Id: <20230322131408.1192-1-jyh429@gmail.com>
X-Mailer: git-send-email 2.25.1
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
-- 
2.25.1

