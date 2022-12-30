Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE38658876
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 02:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiL2Bov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 20:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiL2Bos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 20:44:48 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359372DD8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 17:44:48 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id d10so11525412pgm.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 17:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPAYQwDWE9OMZ/U/cOHoYvo1QQGJp7a/uZzvsCRbps0=;
        b=nFcHKhnkpBC8BREMcxP6tbEj+TD9ajmkyJeQtRZZQ/8zkzT5/QZOU78DQ21N+GzqYH
         CQXOJTtSFRibm/v+SzFg61MduaSpd+9kBPFEwfxmRkSMyd8Uw+jyIdBrkCCr/3WNhkD9
         5e6g8pY/n6Towtipvc5j8LuWaEuVoX4/0heST9kOcWC30YYNCB/oo1hUg+DJYMuFBlxx
         8lNsSEjSkC4nDBGRC8Mnqjjl6gNx+i4XRQHMKta54ZX+TSftPH3BgAH8gzvmpny1Z347
         1qjn6qbwDMQ0FyiyZPn3E7Tqjy1vCRF+3L3ijw3jKeXuHOl4nopIbpcJa8nB+8djRSta
         E0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPAYQwDWE9OMZ/U/cOHoYvo1QQGJp7a/uZzvsCRbps0=;
        b=f0lFdSY5hKkTp+8Of/yvTJeAi9IKO7hyARgFX8cd7FuXfsInPChW50WbqGiRUZgnNw
         sip9E8gg5Cd30NSQnOfs3vdYjAK3lbXmJjax398KuI01uSL8Ip0N56WTPOxO3rBwxWIZ
         VOHv/l7IIrFmqvJh1H2D3/vQwqEsZb+OVeWZe0QHmZO/F7e/xZQJBCf7Tibdh/g4i1Rg
         AhjWf6slgwg8Xkxing8Bd3SDfA7K4rFTlSTpyqpwpWEs+eaqDT9MLd3mK8+5q8qgzwOA
         DP7jhgcjz23BRvXQgL4LsvN8jJgOmKTEJNsXZjjxArCaqW6u8OP020bUMO9RuQq8YupK
         +RSg==
X-Gm-Message-State: AFqh2kp9HZZkLWxtkjiT3DUrwfKkhCqHuInyuxo1H9RCNnugYED/r3ho
        KxhOQSc20QC0C4YEKHBuMSNAxg==
X-Google-Smtp-Source: AMrXdXvojSXuSoryp/+zW9mksXlqmVI/fQmGd01x2fGKaWw8fg70sKCJgMP5IIIdoaXSU2ynA3ADMw==
X-Received: by 2002:a05:6a00:410b:b0:57a:9482:843b with SMTP id bu11-20020a056a00410b00b0057a9482843bmr30916851pfb.5.1672278287678;
        Wed, 28 Dec 2022 17:44:47 -0800 (PST)
Received: from niej-dt-7B47.. (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id 14-20020a62150e000000b005609d3d3008sm5433780pfv.171.2022.12.28.17.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 17:44:46 -0800 (PST)
From:   Jun Nie <jun.nie@linaro.org>
To:     djwong@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tudor.ambarus@linaro.org
Subject: [PATCH] ext4: reject 1k block fs on the first block of disk
Date:   Thu, 29 Dec 2022 09:45:02 +0800
Message-Id: <20221229014502.2322727-1-jun.nie@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For 1k-block filesystems, the filesystem starts at block 1, not block 0.
If start_fsb is 0, it will be bump up to s_first_data_block. Then
ext4_get_group_no_and_offset don't know what to do and return garbage
results (blockgroup 2^32-1). The underflow make index
exceed es->s_groups_count in ext4_get_group_info() and trigger the BUG_ON.

Fixes: 4a4956249dac0 ("ext4: fix off-by-one fsmap error on 1k block filesystems")
Link: https://syzkaller.appspot.com/bug?id=79d5768e9bfe362911ac1a5057a36fc6b5c30002
Reported-by: syzbot+6be2b977c89f79b6b153@syzkaller.appspotmail.com
Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 fs/ext4/fsmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 4493ef0c715e..1aef127b0634 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -702,6 +702,12 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 		if (handlers[i].gfd_dev > head->fmh_keys[0].fmr_device)
 			memset(&dkeys[0], 0, sizeof(struct ext4_fsmap));
 
+		/*
+		 * Re-check the range after above limit operation and reject
+		 * 1K fs on block 0 as fs should start block 1. */
+		if (dkeys[0].fmr_physical ==0 && dkeys[1].fmr_physical == 0)
+			continue;
+
 		info.gfi_dev = handlers[i].gfd_dev;
 		info.gfi_last = false;
 		info.gfi_agno = -1;
-- 
2.34.1

