Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BEC5EF03D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiI2IVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiI2IU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:20:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA1F1138D0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:20:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b23so791147pfp.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=oLacvrmMc7XWx51TtRRIZ78owPQV0/EOHAQ7fO1xE+c=;
        b=ipxy3g7SLmxTZgjcdsRv5o7DRaCKPFx8s1A7DCFXFhxlqDhUzsyOC615/RBwnba3Ml
         NiA2CBxF0MYt34/DERRsIsmyNqGuuaUxSYFB44dTmTCFvq1eqCgHXIqoauYbudX+dCTz
         OqnYBPXIa2D/tqmjzCy9rkLAibWRYno3ChPhefPGA22DUsBIJ9ovz5D3nWHmT0zSUQdq
         36hg71Ddla/6RORzbDjkKN8+GN7ksuEzp6wZC5S94v1G6TjL4ZjpqGXq/ALfM17dzC5r
         jeZK+65KX/eR8vBvWSQw6P5Z0USmJ2XWbtQ7taYB753FydH+/Vd0OMakKTy3I67yYWLD
         uTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=oLacvrmMc7XWx51TtRRIZ78owPQV0/EOHAQ7fO1xE+c=;
        b=YLc/GKjZf3cdnU9hEhCAaHLlWE8z96tooVNClFoFDE1C91Y99TTMUahgqqXzyyA0GI
         VhrF7/CzIdcKxiczMsS+cZNrlXw4fl5vwA6VSpAg/DF3IfTTrz7lv1y+SS30iHYd9mjM
         ySTrz6OZXMsv7boum0pZPdiwAMyPIbN8DE4Yz6hVz9OJs1+pgkHW6z5upEN+bkfUYkOu
         2RTrsJzjfW3VLyoB73xLQabE1vkKiZsiA08Z1ixVcNXXyxzF4BTV6C7b2ybeJOh8GnnD
         VoFo0+eJAkTj6nRroqt3VahP38ai+uYfqwfEdCbOepBwWk3o325wEm+MgrVDjyTYL9oi
         wrzQ==
X-Gm-Message-State: ACrzQf2SK3xD3BMQdxI54ByRwHJ1bDTRuSr7IIXOElK/2VDgCjzYG6iT
        nqzFyJULgyi1utkJ7urDgF4=
X-Google-Smtp-Source: AMsMyM4hcvfnBMBNQsdXSLcD7fvAvMFeCJMwcZ0M5GpVa1k7lB1uTWWiLs/w0/wFRBJAkiUfMOytkA==
X-Received: by 2002:a62:2985:0:b0:544:77d4:f43b with SMTP id p127-20020a622985000000b0054477d4f43bmr2128909pfp.9.1664439655416;
        Thu, 29 Sep 2022 01:20:55 -0700 (PDT)
Received: from localhost.localdomain ([218.188.148.16])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902a38900b0017b65174c9esm581186pla.59.2022.09.29.01.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 01:20:54 -0700 (PDT)
From:   Genjian <zhanggenjian123@gmail.com>
X-Google-Original-From: Genjian <zhanggenjian@kylinos.cn>
To:     agk@redhat.com, snitzer@kernel.org
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        zhanggenjian123@gmail.com, Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH] dm: Remove unnecessary assignment statements in alloc_dev().
Date:   Thu, 29 Sep 2022 16:20:36 +0800
Message-Id: <20220929082036.913110-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Genjian Zhang <zhanggenjian@kylinos.cn>

Since there are related allocation and  assignment operations before this,
the two are already equal, so this assignment statement is not needed.

Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 drivers/md/dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 60549b65c799..b4a2cb5333fc 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2065,7 +2065,6 @@ static struct mapped_device *alloc_dev(int minor)
 	md->disk->minors = 1;
 	md->disk->flags |= GENHD_FL_NO_PART;
 	md->disk->fops = &dm_blk_dops;
-	md->disk->queue = md->queue;
 	md->disk->private_data = md;
 	sprintf(md->disk->disk_name, "dm-%d", minor);
 
-- 
2.25.1

