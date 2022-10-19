Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A313A604676
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiJSNK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiJSNJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:09:39 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0514B0F9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:54:48 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id y72so19115028oia.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f59RIjGEwqOu67ef5ZU0jIO2IA5PQ6Gm9Ueoact0TG8=;
        b=bqRSRL8HLb+wNogKF5itSZhUrrM00dqcwkhn9W8gNWQ5In1LjWHJBmXjih9KVRyhmc
         Z5rm6JOPGNPHS9abKoxzZbhqKkuG1dS8MNCtVnKd/GoVhGxSifgIesc4J/egfw2wJKVu
         1mInCg2QGiFfYqSLu9eNlLFGztmcL+GWQi+Zw9ggWl39E0SVLgyYmtqrWGu15DOdgvae
         YMTOq0uPIgVyWINb7OzW+Y6Js13TiFMH5UBzO4NDLfJ2XjBsXkkdQnS2eVNhWpXICBrb
         V7MEOJ7ufOxgmuw6GDfnW86xizprbpGa/FHGBBp2FGuRZjGl55kambcgx1aVQTRrAAGb
         K5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f59RIjGEwqOu67ef5ZU0jIO2IA5PQ6Gm9Ueoact0TG8=;
        b=cEl5i0WU+1vIadmRu61jYCtV6JzFNVEjuJyT7NKp7UIYXlEQ3F/6VWPS+ibkCpTwnr
         KWtYwazP1r3/h+Woo0WssB1EfJtzXuYMt1il2jLAua7Hhg1Ngv7umArNHZsw+MIbsfN9
         7aDpWjraDuHK9XDqvtGJFp/mMrNn01uE49B44rp8Ib9x38+STlj9EMes5gqb7V7C1NbR
         ntPab8QnS2IJezFEIDHvtgXmTBs8mbI2YriTlDsG+wMflhYPhzki/isHwnGbIZF849Bf
         nUIc9rCGVV7kx0xSGLw4axNjDQDyxLzHpewEhds5SQ+sPeQJMR4RTdPdXfWeTZ4bVPBv
         VZAg==
X-Gm-Message-State: ACrzQf0DdHhIRLAttG03U42mTstYaKdVQxoeincAz7hELrbEDD7Pxr7b
        vKWk77nHrGoey8pGCs8X6wLgiA0xkrQ=
X-Google-Smtp-Source: AMsMyM5fQzzkn024/Xnp1HA6FMegw/A0XgS4TW8OSF1d6zoVF7Ykv1c1HdodUSgSMsHjk8G40tcTXA==
X-Received: by 2002:a17:90b:1c0e:b0:20d:8cc5:23e5 with SMTP id oc14-20020a17090b1c0e00b0020d8cc523e5mr8888517pjb.111.1666172387052;
        Wed, 19 Oct 2022 02:39:47 -0700 (PDT)
Received: from localhost.localdomain (124244014158.ctinets.com. [124.244.14.158])
        by smtp.gmail.com with ESMTPSA id y184-20020a6232c1000000b00562cfc80864sm10895192pfy.36.2022.10.19.02.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 02:39:46 -0700 (PDT)
From:   Hoi Pok Wu <wuhoipok@gmail.com>
To:     shaggy@kernel.org
Cc:     Hoi Pok Wu <wuhoipok@gmail.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+f0e0fcf3cd1047ae60ad@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] fs: jfs: fix shift-out-of-bounds in dbDiscardAG
Date:   Wed, 19 Oct 2022 17:38:25 +0800
Message-Id: <20221019093825.339991-1-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bug reported by syzbot, UBSAN: array-index-out-of-bounds in dbDiscardAG.
Fixed by simply rearranging agno_end smaller than MAXAG. However, I wonder if it
is a better idea to return -EINVAL, rejecting user input. Thank you.

Reported-by: syzbot+f0e0fcf3cd1047ae60ad@syzkaller.appspotmail.com
Signed-off-by: Hoi Pok Wu <wuhoipok@gmail.com>
---
 fs/jfs/jfs_discard.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/jfs/jfs_discard.c b/fs/jfs/jfs_discard.c
index 575cb2ba74fc..3101eaf3098a 100644
--- a/fs/jfs/jfs_discard.c
+++ b/fs/jfs/jfs_discard.c
@@ -96,6 +96,10 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 	 */
 	agno = BLKTOAG(start, JFS_SBI(ip->i_sb));
 	agno_end = BLKTOAG(end, JFS_SBI(ip->i_sb));
+
+	if (agno_end >= MAXAG)
+		agno_end = MAXAG - 1;
+
 	while (agno <= agno_end) {
 		trimmed += dbDiscardAG(ip, agno, minlen);
 		agno++;
-- 
2.38.0

