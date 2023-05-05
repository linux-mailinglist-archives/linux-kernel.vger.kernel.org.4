Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003476F8A46
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjEEUkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEEUkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:40:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A952D49FE
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 13:40:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24df6bbf765so2048491a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 13:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683319205; x=1685911205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGFXeU2dXaRo8clMCkR8c/hfrCLvrLrfrAcbGat2bS8=;
        b=gM0mLhZPPogTqDhH2p1bvP3RMMjdphDn/Ubq+8G64h4i2qq7VyxacwfPbtU+trWfKU
         U7gTntgoYJnK0Th0YsMLnQFnRLwRle6BHJYf9oxow1BmL14BDo+u9P0ZiNigKd3cRj/P
         uJpIpOx5Mv2xA32aqLN6X8fjC+LabvrS4mt2mpMYMeEnhZaPHdphaz4LbzSEXIiMoOG0
         GHMZ9uKkL+h0BauzZ0vBeJF/R79NsUchwPmDsX/fSIu+hWBN/68zg5TKJmn5j/hlUJUR
         9qEi/QfcJy0yyve6CDIg7gFaZvjW+DmLiuytY1TkGxjQgf8tH1W5aUYRtnPca2XVR0xs
         9U1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683319205; x=1685911205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGFXeU2dXaRo8clMCkR8c/hfrCLvrLrfrAcbGat2bS8=;
        b=V9CLM7K8QEIjOPJ+rL5wrBQhmNQ4YGR4y3qqeRrSB4YH/u+f2N5sq8rwIISnNM1FFH
         MCuoJB8MkY0XmqkEMlJsSJiHpbJr8uLLCE5yBJTgbzSwHkWhNhx/WjRVIir6CK9BTQtW
         bMQ6DP2aa6+qhKrhh+N9+GsGn5TpMmtgkQvb2bSvPh5hIwcSy3V5HcmimoL6t5ZHNS3b
         YhKOcwljOjvauZOojek9Ghm/2fEytkDg8p213jBS0nCvf61JbnYTUZhR31NyCrCh1zZB
         1sz/4FTJxivGW09X/U6eeGu+2QNJMUp+q6ltISLZkuinJsPa1cWduSMmmbDka3+9ExC6
         6yvw==
X-Gm-Message-State: AC+VfDyzZbCe60WUeo0Q7vvnyMJooLbE7bHqLNI7FMjDdo4/EPcCIAV1
        xB3hgtki0DxkcMcOwynCS5k6cYLmiIk=
X-Google-Smtp-Source: ACHHUZ6dB/vPtTYWg7uhHznNlXJ0K2YkXLUMaIa/tmbVDicNbO1mh6N+YwG2esq5hI9+qVRtISfWng==
X-Received: by 2002:a17:90a:b281:b0:24e:1dcd:4e73 with SMTP id c1-20020a17090ab28100b0024e1dcd4e73mr3000560pjr.0.1683319204509;
        Fri, 05 May 2023 13:40:04 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:4c39:b490:cecf:cb9c])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090ad34e00b0024e3d26f644sm6057166pjx.3.2023.05.05.13.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 13:40:04 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: close unused open zones while mounting
Date:   Fri,  5 May 2023 13:40:00 -0700
Message-ID: <20230505204000.3604748-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
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

Zoned UFS allows only 6 open zones at the same time, so we need to take
care of the count of open zones while mounting.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/segment.c | 53 +++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6db410f1bb8c..43d537d29b52 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4810,40 +4810,49 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 			break;
 	}
 
-	/*
-	 * If last valid block is beyond the write pointer, report the
-	 * inconsistency. This inconsistency does not cause write error
-	 * because the zone will not be selected for write operation until
-	 * it get discarded. Just report it.
-	 */
-	if (last_valid_block >= wp_block) {
-		f2fs_notice(sbi, "Valid block beyond write pointer: "
-			    "valid block[0x%x,0x%x] wp[0x%x,0x%x]",
-			    GET_SEGNO(sbi, last_valid_block),
-			    GET_BLKOFF_FROM_SEG0(sbi, last_valid_block),
-			    wp_segno, wp_blkoff);
+	// The write pointer matches with the valid blocks
+	if (last_valid_block + 1 == wp_block)
 		return 0;
-	}
 
-	/*
-	 * If there is no valid block in the zone and if write pointer is
-	 * not at zone start, reset the write pointer.
-	 */
-	if (last_valid_block + 1 == zone_block && zone->wp != zone->start) {
+	if (last_valid_block + 1 == zone_block) {
+		/*
+		 * If there is no valid block in the zone and if write pointer
+		 * is not at zone start, reset the write pointer.
+		 */
 		f2fs_notice(sbi,
 			    "Zone without valid block has non-zero write "
 			    "pointer. Reset the write pointer: wp[0x%x,0x%x]",
 			    wp_segno, wp_blkoff);
 		ret = __f2fs_issue_discard_zone(sbi, fdev->bdev, zone_block,
 					zone->len >> log_sectors_per_block);
-		if (ret) {
+		if (ret)
 			f2fs_err(sbi, "Discard zone failed: %s (errno=%d)",
 				 fdev->path, ret);
-			return ret;
-		}
+
+		return ret;
 	}
 
-	return 0;
+	/*
+	 * If there are valid blocks and the write pointer doesn't
+	 * match with them, we need to report the inconsistency and
+	 * fill the zone till the end to close the zone. This inconsistency
+	 * does not cause write error because the zone will not be selected
+	 * for write operation until it get discarded.
+	 */
+	f2fs_notice(sbi, "Valid blocks are not aligned with write pointer: "
+		    "valid block[0x%x,0x%x] wp[0x%x,0x%x]",
+		    GET_SEGNO(sbi, last_valid_block),
+		    GET_BLKOFF_FROM_SEG0(sbi, last_valid_block),
+		    wp_segno, wp_blkoff);
+
+	ret = blkdev_issue_zeroout(fdev->bdev, zone->wp,
+				zone->len - (zone->wp - zone->start),
+				GFP_NOFS, 0);
+	if (ret)
+		f2fs_err(sbi, "Fill up zone failed: %s (errno=%d)",
+			 fdev->path, ret);
+
+	return ret;
 }
 
 static struct f2fs_dev_info *get_target_zoned_dev(struct f2fs_sb_info *sbi,
-- 
2.40.1.521.gf1e218fcd8-goog

