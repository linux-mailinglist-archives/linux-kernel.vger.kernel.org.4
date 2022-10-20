Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0109B606729
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJTRje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJTRja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:39:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAB7D133;
        Thu, 20 Oct 2022 10:39:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j7so177841wrr.3;
        Thu, 20 Oct 2022 10:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u6QaoaC6eMyiR8pzqtN0H2lr4PQj6BJvo8PVOPWAT80=;
        b=nj5gRdjeqwlEkMp3RMnbTzqRRzQHztj0/GhJuQZtLqXlGg4vQ9TXW9q80rAYFpS+ue
         ALHqz1upOKkaYIpvRjYXClsUhHMhAQWA2vOldZcMHmK3j01HTxu+AjwVrTUzH+igDGYS
         zUHQ6PV/MBcWKn2JLxIg5GbXEm5ZF+lUZi5qAnILZa7dm0ycqDeABqOB3aeVTumxmixM
         XMyCV7mB4HcWKqEsaY1zsgsXIo6EBs6btEtRB+zskt6HY1/eh3kRhToWomSZjBm78jGd
         xFy1Yg4S2s/vbXHbASQczJr+Qcv9SbQL//T9XgXgJmYbJzPgLIbq97J7XL7cus5TVvkC
         VfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6QaoaC6eMyiR8pzqtN0H2lr4PQj6BJvo8PVOPWAT80=;
        b=2Ye/YqtxmmbllRnuxX5A7b29AEzSbhZpWebizr89VtjoQeRD1201iZK821Du5WusLR
         h/d/yuyiEOkdyLln0MHP9wEMtQjkDs2FNEKHpxiReFnAMQk7O/zHAMOhJhuVyVK1okzN
         OFwtrV5Ntwe+k3nOGspfugnR/2HdvlDtlNftLjbhQ0DgRr0ozhRvBI4K6soXqaun+4GL
         Ds0GauZigDqHOV3OShPXP83By7iyJojqEny73ZGeWEZiztCftZvwz5i0vtZCRtnR8s1/
         UOApNqvSe1OrVPrrfsyLMhFeJl2mRdpYuxGfEx9GaDlqzMJInUj2e94sQoGIUAajiFKW
         Z0AA==
X-Gm-Message-State: ACrzQf1UCX6FR9LIRE5G6c5FgyBKXuqgShHB+v9SgG8kivhuBUfs8Yzt
        RetFsr1K8lBvmhTp/7nhq/8=
X-Google-Smtp-Source: AMsMyM6Dc4YJMAlfq8xZ/eVY4VDIz3WqWWEiknWDwjIQ46F2Fq02ftSIkrJGENjc/Nn2YvdhMGhAyQ==
X-Received: by 2002:adf:ed91:0:b0:22e:4f88:a9fc with SMTP id c17-20020adfed91000000b0022e4f88a9fcmr9022828wro.669.1666287564899;
        Thu, 20 Oct 2022 10:39:24 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d62c5000000b00228cbac7a25sm17262443wrv.64.2022.10.20.10.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 10:39:24 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: remove variable nr_servers
Date:   Thu, 20 Oct 2022 18:39:23 +0100
Message-Id: <20221020173923.21342-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable nr_servers is no longer being used, the last reference
to it was removed in commit 45df8462730d ("afs: Fix server list handling")
so clean up the code by removing it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/afs/volume.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index f4937029dcd7..29d483c80281 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -70,11 +70,7 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 {
 	struct afs_server_list *slist;
 	struct afs_volume *volume;
-	int ret = -ENOMEM, nr_servers = 0, i;
-
-	for (i = 0; i < vldb->nr_servers; i++)
-		if (vldb->fs_mask[i] & type_mask)
-			nr_servers++;
+	int ret = -ENOMEM;
 
 	volume = kzalloc(sizeof(struct afs_volume), GFP_KERNEL);
 	if (!volume)
-- 
2.37.3

