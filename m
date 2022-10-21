Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C186072F9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiJUIyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiJUIyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:54:01 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A332505C4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:53:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 204so1974626pfx.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiebFKtnsrtXianXD3JL4DWupXndbhs034Yj5s+RxrE=;
        b=mE/t/bt4w+oJh8KFnimQ8O2wcibAG6Lq3MlVWFEZkbXium8WqHvJK8sRDFWRd2L56i
         Vww8d7O6Y+mXOTNtkt5RsIINWwXUrmRcqWwtFr+9RtjrLh7MVAqU6AsUt42/xnn8P8P2
         Z2eem93rUGdCRpOZ924FyFlwYXcNzfPJOiaOWxIsB3Q1PMcUvL/WVcVAjHceHCQR+e49
         b8/dOE3JfEktAlN6cTb8MVewHWDPk7XAIbRhsxoFnMJcb+4EESvvy/tjxQ94eJGxVfNs
         yT6C0fKFi57J9cjZl5Kv2BAwMxF3KEJqdIqD15JSWZmIy+iDgR3d/FT2k0AqofMHi//0
         +T2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiebFKtnsrtXianXD3JL4DWupXndbhs034Yj5s+RxrE=;
        b=L1M9Lpob4fUd0q/LJCIVDWN/PtXlRcHuNwUSVAyXrL0+/2ncg+u1Ww725JZaKNgFfp
         w35wraLodxNWQgT2AIQgWZ/Z9a0KK4RbHSF2euGTbRTtj8W0MHb4ffVHsQlUqQYnwMKd
         YMzXUPi3pHfWm6ElUEn/GcBgc4WceXf7qXLf8oh1PS7r2u/ejF+EJUi5l+dvCYrNsjj5
         gyXFSHGNLwfh2U5BOpbHj/du/Y9ZB4zFDJoBjEn+iVxdZKCfEEYEluKfhosReasEpdu5
         KW8ob2Q1Vs57fPC2X+fEqUpENaczoH/BpfVOAmrAXC1k0gySg+lE6avVh+1+T90FbIPW
         X2Jw==
X-Gm-Message-State: ACrzQf0VGx3FjK9oqSa2ymQ2t9k0CdUAI3WFM8G2xmNbeQrAmzgsqR/w
        wstRbKewlWlfdAALg+5ly1o=
X-Google-Smtp-Source: AMsMyM7PkyURCraVtdQN1vKJbNHZyc1INbLu985EFIkNQGDGKtTVTHPeVmw+aT7qtdfly+b0bTaxwA==
X-Received: by 2002:a63:1c47:0:b0:44c:2476:12ff with SMTP id c7-20020a631c47000000b0044c247612ffmr15899522pgm.50.1666342439140;
        Fri, 21 Oct 2022 01:53:59 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id o16-20020a634e50000000b0046ae5cfc3d5sm12658609pgl.61.2022.10.21.01.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:53:58 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, zhangwen@coolpad.com,
        Yue Hu <huyue2@coolpad.com>
Subject: [PATCH v2] erofs: fix general protection fault when reading fragment
Date:   Fri, 21 Oct 2022 16:53:25 +0800
Message-Id: <20221021085325.25788-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

As syzbot reported [1], the fragment feature sb flag is not set, so
packed_inode != NULL needs to be checked in z_erofs_read_fragment().

[1] https://lore.kernel.org/all/0000000000002e7a8905eb841ddd@google.com/

Reported-by: syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com
Fixes: 08a0c9ef3e7e ("erofs: support on-disk compressed fragments data")
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v2: fix return value to -EFSCURRUPTED (Xiang)

 fs/erofs/zdata.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cce56dde135c..55c13cd6934b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -659,6 +659,9 @@ static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
 	u8 *src, *dst;
 	unsigned int i, cnt;
 
+	if (!packed_inode)
+		return -EFSCORRUPTED;
+
 	pos += EROFS_I(inode)->z_fragmentoff;
 	for (i = 0; i < len; i += cnt) {
 		cnt = min_t(unsigned int, len - i,
-- 
2.17.1

