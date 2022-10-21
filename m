Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B55F607262
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJUIdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJUIdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:33:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02D411CB41
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:33:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso4017482pjn.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUhUf8tD5P9UtY7kvr1O4iHq3ocdqCg7p3bMwN8zrt4=;
        b=SQLfosJ00IIaQWaztjwBMmwEMk2b/3/oJ1NnBipOaC+XOHnQRX+9CmqfOdvo3fCRl0
         n3vIk9R5MCtn/iXYYLrWHXlXYecIMGvuyt93PTOcDa5xCS52bFtcHH6vMI5kge6/udx1
         P2undt15ogyw2MiL1e3SeYyPZ4HQ4dsJrB54xL0ys+uG0A7Rv5OVnb6RvJEWKTya4OHd
         ZTFgBHFll4j5hdLMLCTxGl344rzT9Ab77+DbuTJmSXBFyz+7uYGtEZ+4qA+DWECLt5F8
         hMan3jzzD3INwa8sZdelPDOLHS2qXKPV/5tm2TshM3tgDlYonvnsbWFNXAqdpHs/eQ6w
         o9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUhUf8tD5P9UtY7kvr1O4iHq3ocdqCg7p3bMwN8zrt4=;
        b=Jz4+UKdFIZi/Tb+MLFo0MaFpxrNx/EUQHEeUUmxrNBQ3TzCMKt+bDwnWSmn8m7M6Aw
         KZymV2WPCAZ2thNxh8mR27e0kd+8J5O7XoF9vL2gnghmFRoDccj/uoJUUu7hVHxpiv09
         Vrsadhwi/ADSx9vzcoOACH6bBYjV6JpeUWkOyxI5RZz1rYnbW1E//XdPxkjjo0k0FjSE
         Lze8NU3HmEq3+Ypt+Qe/wsisV1U3dpEf+s+jZOzd5Na7LxRyROS8mymEAF6D4jFFDTWJ
         nhQMJ3/KsRM42seA4gVvmRVxo5S0PtT/Z/DYUhC/RRo+jvkogunfcx9knRT4GR3WLHOj
         xZnQ==
X-Gm-Message-State: ACrzQf15c8WS7ycqOuIsh/1T7YQwhw/ncitOYhJsN02KWXHJEnC9GxfS
        bv0OL6LAtZNLtsgl3iPgMXs=
X-Google-Smtp-Source: AMsMyM71jJ7gDgk17Qb+d6fmhl6HWAVPYZLi9r4XOtM3m+aM3RfKluid6P6DtU51uQGlUgqwpgispQ==
X-Received: by 2002:a17:90b:1d4c:b0:20a:8db1:da52 with SMTP id ok12-20020a17090b1d4c00b0020a8db1da52mr55567602pjb.98.1666341146252;
        Fri, 21 Oct 2022 01:32:26 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090a650500b002009db534d1sm1098630pjj.24.2022.10.21.01.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:32:24 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, zhangwen@coolpad.com,
        Yue Hu <huyue2@coolpad.com>
Subject: [PATCH] erofs: fix general protection fault when reading fragment
Date:   Fri, 21 Oct 2022 16:31:16 +0800
Message-Id: <20221021083116.20048-1-zbestahu@gmail.com>
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
 fs/erofs/zdata.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cce56dde135c..310f6916787a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -659,6 +659,9 @@ static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
 	u8 *src, *dst;
 	unsigned int i, cnt;
 
+	if (!packed_inode)
+		return -EFAULT;
+
 	pos += EROFS_I(inode)->z_fragmentoff;
 	for (i = 0; i < len; i += cnt) {
 		cnt = min_t(unsigned int, len - i,
-- 
2.17.1

