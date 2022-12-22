Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741A1653A72
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 03:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiLVCCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 21:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLVCCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 21:02:39 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E139220F6D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:02:38 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id jn22so628756plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/vSB+l3+h0STRS9DPPu2XELvIiGiSoWBn/FlK1C83SA=;
        b=ou9acgIDlwQ3xDhECuqvM25H6FtaND3bPaqdjPAqWdAhqo7Y83YVVOiGn0oWKpRBS4
         vdgdqILkVAYHVfYdf3pof6pdXyJCljnEs1wptCI9ej7Cr5ZAZl7t3PNkhtzsg1W3bURS
         2HV6er5F+bAYJRN1hxlb+2zSVOYMkz7cfO219sfs7x/Gq2WOpVPAOuneveYdLQEqPNo2
         /u7t31kWI4LUDAVT50QZFdyQZlAbgClBC1npmARQJs8QRnxoa/Y+JaRC1ofFSMs1nIk8
         eSyFzxaLsJjIdkigx9S0+zBa5ISSuOse5qFZ5m7kcu4uxDC5ykAF2+Vzkbq69ZX0hlll
         tKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vSB+l3+h0STRS9DPPu2XELvIiGiSoWBn/FlK1C83SA=;
        b=0uU9PXaqoLdzY760wOb7vl4L/uonGBQuRkw4FP+3qAO0BHzyAxOAcnZ/2y0euMuxO/
         8JkODUgxdNTmBMs1691jmqcmnpwW0r6CX+gkzVXMKqWFLmDYPWnlqm0VTFl0wIqKiMxW
         fI7UwBIZxZbpXHv0ZHenLYLfrdGLXoGkPu2iUuL2Pv6urfZs+uJ4mc3mtHlQaiMNqeSi
         1i3Mjax4BKY9yLRXYt6FcEp7spEPBcciNbLs0Z9iu11Qu628yaXopsNhPgTeqLMnJKCv
         LrMzGDSJnf+ca+7jFsEoMKdA+1ZxVALZWAFKXgKnHDoqzAPAlvAyg4a8axwlmaFndWIw
         yS4A==
X-Gm-Message-State: AFqh2kqXqck/JVL3shc7HyR6G5A+f6WMXTgQo+1EfFNHHeROZWXxFjCa
        7500VqTAhvJOMxFCcRqHFmpywg==
X-Google-Smtp-Source: AMrXdXvj/o3WHvnJUk8+g2IpdvN05DyQP5K+Yj2TLou5ynvcpC3HezzZFC19XqQqVNUb6wvxw/khvQ==
X-Received: by 2002:a17:902:82c8:b0:191:4389:f8fb with SMTP id u8-20020a17090282c800b001914389f8fbmr3938992plz.65.1671674558276;
        Wed, 21 Dec 2022 18:02:38 -0800 (PST)
Received: from niej-dt-7B47.. (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id k15-20020a170902c40f00b001869b988d93sm12154909plk.187.2022.12.21.18.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 18:02:37 -0800 (PST)
From:   Jun Nie <jun.nie@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: fix underflow in group bitmap calculation
Date:   Thu, 22 Dec 2022 10:02:44 +0800
Message-Id: <20221222020244.1821308-1-jun.nie@linaro.org>
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

There is case that s_first_data_block is not 0 and block nr is smaller than
s_first_data_block when calculating group bitmap during allocation. This
underflow make index exceed es->s_groups_count in ext4_get_group_info()
and trigger the BUG_ON.

Fix it with protection of underflow.

Fixes: 72b64b594081ef ("ext4 uninline ext4_get_group_no_and_offset()")
Link: https://syzkaller.appspot.com/bug?id=79d5768e9bfe362911ac1a5057a36fc6b5c30002
Reported-by: syzbot+6be2b977c89f79b6b153@syzkaller.appspotmail.com
Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 fs/ext4/balloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 8ff4b9192a9f..177ef6bd635a 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -56,7 +56,8 @@ void ext4_get_group_no_and_offset(struct super_block *sb, ext4_fsblk_t blocknr,
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	ext4_grpblk_t offset;
 
-	blocknr = blocknr - le32_to_cpu(es->s_first_data_block);
+	blocknr = blocknr > le32_to_cpu(es->s_first_data_block) ?
+		blocknr - le32_to_cpu(es->s_first_data_block) : 0;
 	offset = do_div(blocknr, EXT4_BLOCKS_PER_GROUP(sb)) >>
 		EXT4_SB(sb)->s_cluster_bits;
 	if (offsetp)
-- 
2.34.1

