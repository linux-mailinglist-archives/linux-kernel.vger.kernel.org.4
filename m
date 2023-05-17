Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E54706EAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjEQQvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjEQQu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:50:56 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8CE4ED0;
        Wed, 17 May 2023 09:50:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ab032d9266so11441855ad.0;
        Wed, 17 May 2023 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684342256; x=1686934256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BKjKRvCcUxdSw7sNrgS1vWdqJsRtZVoGJT9S+sDPoy8=;
        b=ekY6uWaYg7UuXpcHLXNscUzl4+iv29+BOwOZbTmGhIA042oVp7uifx+5JGjSTFkKFj
         x9VVBzvZvsS5oH0cxqNW15ukDjLvlwjiEDntKH7GcT660a7SepvwNnPfonMeDafcZpQc
         mygFqrOAqJvbEzop8XwAIm+JUMpXphvt/uIYSl/TM+gb/s+klFaq0eL3f9xjsfrlYxUh
         HAbT0TOMTVqWM3HgAULAZ11pLUikrWBRHrogxM6gA73etz4fHtl2DwBkjCSEXCid6ufJ
         QQ+pxlv0i6Fwp0SFECw5RgSuWdfWIspUfjLfgfL4B4oiJUvWDH0Kd717ltO4xUDi0hvp
         AXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684342256; x=1686934256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKjKRvCcUxdSw7sNrgS1vWdqJsRtZVoGJT9S+sDPoy8=;
        b=S7IhQv0m0oFoMeeKyjj8Bhg5u2iMmSKxNdEEdbCHHmUEg81x/VrgiYyoVuDsqYiDOw
         jGkpKhgBlBi2aw0EslcbgKMlAEecLippDpfzjYXCbY52AcgAETfJ/x6+MrZYW17VrA4W
         emnOxGWC4UJYzVrATNFK8DeLq2zInE+2Y7tGdPRQSvYkzHfhBRFnUNTKBdDTya0ewxmx
         2SuP9PI7bQntlHE1pnyqM4CnCRYfwml7WlCWh6qObCRk7RU3/rCcwm23Sn8d3O9zUHJg
         NH4KmM6oKbkgNW42Z/7rni7wIMykU6Tg7t+0dxqGgyCSJ7osT1PZOx+kbJhdzoHz8DxQ
         iKaw==
X-Gm-Message-State: AC+VfDx7HnmUibQ30Nzkw10DWtpdiwsj2lKWWdGDlzPahqb4aEQjCmGU
        VZQk5jH9GbKmPPGAFllveKAyXbv2nknPtCUUay0=
X-Google-Smtp-Source: ACHHUZ6NK7ZKdEgkgLo1ya5bbPE385Nw25giZ2czxVR9D64Ay6xg/gVUO8F9uH0DE6R4S/TKknivEw==
X-Received: by 2002:a17:902:b695:b0:1ad:edbe:57a8 with SMTP id c21-20020a170902b69500b001adedbe57a8mr17599248pls.50.1684342255625;
        Wed, 17 May 2023 09:50:55 -0700 (PDT)
Received: from localhost.localdomain ([111.201.128.95])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902d50200b001ac7794a7eesm17822744plg.288.2023.05.17.09.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:50:55 -0700 (PDT)
From:   Yeqi Fu <asuk4.q@gmail.com>
To:     ulf.hansson@linaro.org, CLoehle@hyperstone.com
Cc:     Yeqi Fu <asuk4.q@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ivan Orlov <ivan.orlov0322@gmail.com>
Subject: [PATCH] mmc: Fix error checking
Date:   Thu, 18 May 2023 00:46:28 +0800
Message-Id: <20230517164628.365335-1-asuk4.q@gmail.com>
X-Mailer: git-send-email 2.37.2
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

The functions debugfs_create_dir and debugfs_create_file_unsafe return
ERR_PTR if an error occurs, and the appropriate way to verify for errors
is to use the inline function IS_ERR. The patch will substitute the
null-comparison with IS_ERR.

Signed-off-by: Yeqi Fu <asuk4.q@gmail.com>
Suggested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/mmc/core/block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 00c33edb9fb9..507bebc22636 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2908,7 +2908,7 @@ static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
 			debugfs_create_file_unsafe("status", 0400, root,
 						   card,
 						   &mmc_dbg_card_status_fops);
-		if (!md->status_dentry)
+		if (IS_ERR(md->status_dentry))
 			return -EIO;
 	}
 
@@ -2916,7 +2916,7 @@ static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
 		md->ext_csd_dentry =
 			debugfs_create_file("ext_csd", S_IRUSR, root, card,
 					    &mmc_dbg_ext_csd_fops);
-		if (!md->ext_csd_dentry)
+		if (IS_ERR(md->ext_csd_dentry))
 			return -EIO;
 	}
 
-- 
2.37.2

