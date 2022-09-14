Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F79F5B86A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiINKvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiINKvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:51:00 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF75C62A80
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:50:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y136so14532873pfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Wc6UqN2rBrRPIKRWEZkd/HK/BLX6Fc+iydsV3In6uJs=;
        b=oOrs1LpYB0NxT5AuspZSwCGv3oFKdg6VgFR8OpUnYS8lvjCNyjNb/6jMklnwW1HBGG
         jI/xowxQ77fW1KZdkpQYusZAof47Be5v/T65EGudfxhj6viEnmeUtuyU7h3liWHDO8fE
         lC9lPZZ1gL1c/pG/d08McSFu81TO3OX20KtJu1juI83ho9KOwBhj74EvxOx5tzd9ofwY
         cwm9FABc2VC+ElY//cOiWMCQBVXGAXyigc9SV5QPWg3+AW7sUeHh9/nTxz5nTq+pU+Vv
         Wy4EE34SYw/R4YMCJiD56PdZZharxDBstXYdsBEDc4DM84Rl3fDPFYlpa+TODRsI/wun
         rh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Wc6UqN2rBrRPIKRWEZkd/HK/BLX6Fc+iydsV3In6uJs=;
        b=52bD9L4FhJbIoq3SfU9+jOP/gY+r68j/4sXh5h5SKRixjKpjstjNCffXWOS2SJHqaD
         xbdHJECPVmdEdJ2Mtrh/EhigIkf99OmfsLYWtszntpVOzYiH4e0399PiNp7nTqBgLhAm
         r495fRHIk3pvoAmGLpRPim5HYOoqCR99/sRPFfo35CEN9rBD2yowaFs4rmOIMc69Q/b+
         phgHz+uBRm8YweUCbLoUmqEiEof0yRf4KoPGM47gbuGfasQJPuo3Z+c0XreVFL/Avew/
         0tqrfx9leH/ty6nm2/REG+/S9uZ9hZmCQo3SvocR1CsdbCTFTaCs3mj6kOwwzeHOG2FR
         Si7A==
X-Gm-Message-State: ACgBeo2cYiIPaZQ1FsmT+/yR1N0gvcILRKXoR9dVhqKNAvdZb3e8bd61
        j2r03Rtnb5s3KwFzZeU6HTKIJg==
X-Google-Smtp-Source: AA6agR6IR4Tl5gCLaL9fQ77Ogd5yC58UKWzNowxeQQLx0k6N3fYtgtwq1tRtRPwePR65gLmmmdj8UA==
X-Received: by 2002:a65:6048:0:b0:412:73c7:cca9 with SMTP id a8-20020a656048000000b0041273c7cca9mr32293293pgp.257.1663152654247;
        Wed, 14 Sep 2022 03:50:54 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([2400:8800:1f02:83:4000:0:1:2])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902ec8d00b0016dc2366722sm10537042plg.77.2022.09.14.03.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 03:50:53 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V3 1/6] erofs: use kill_anon_super() to kill super in fscache mode
Date:   Wed, 14 Sep 2022 18:50:36 +0800
Message-Id: <20220914105041.42970-2-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220914105041.42970-1-zhujia.zj@bytedance.com>
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kill_anon_super() instead of generic_shutdown_super() since the
mount() in erofs fscache mode uses get_tree_nodev() and associated
anon bdev needs to be freed.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3173debeaa5a..9716d355a63e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -879,7 +879,7 @@ static void erofs_kill_sb(struct super_block *sb)
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
 
 	if (erofs_is_fscache_mode(sb))
-		generic_shutdown_super(sb);
+		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
 
-- 
2.20.1

