Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C30750CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjGLPhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjGLPhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:37:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C8A1BB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:37:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B7BF61870
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF812C433C7;
        Wed, 12 Jul 2023 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689176225;
        bh=OILACASUQuNBny7ncHi7TU9onZ6doz2v4VcsFgSmJsI=;
        h=From:To:Cc:Subject:Date:From;
        b=O6NPKaincgWQcVkv+hw4hzpMudod6daSbCgq/ZMBH7+V2yFEOBbPaGe616LZWzgc9
         NGpaHrlt3BrQjtPwgTvYZm591aN8dwPuiO+GNylATNypiZ7qdOHc2Ol4+8f8tOnWdG
         VQroY2LMKGOw6RKLFiwjavbSvTWCg2AEkBYSeeQO50Yv6IhAfbNTJs2vq0uqgRMFQ5
         rao8hpG2xROPTMINXdzBqy9W6avYPW9wix2qJCvNj7caV+zPSjwPJI84MgI26Gikk/
         f9SuWGQ3Cb+JytkyOk0rY5UwZKUJ1Q2OFkcghXNYTw3hLApumCALuTGGb8LEsKl31y
         fo036TIjMYMSg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: allow f2fs_ioc_{,de}compress_file to be interrupted
Date:   Wed, 12 Jul 2023 04:08:05 +0800
Message-Id: <20230711200806.4884-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows f2fs_ioc_{,de}compress_file() to be interrupted, so that,
userspace won't be blocked when manual {,de}compression on large file is
interrupted by signal.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d9073afe021f..79cb6a41f128 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4107,6 +4107,12 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 
 		count -= len;
 		page_idx += len;
+
+		cond_resched();
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
 	}
 
 	if (!ret)
@@ -4181,6 +4187,12 @@ static int f2fs_ioc_compress_file(struct file *filp)
 
 		count -= len;
 		page_idx += len;
+
+		cond_resched();
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
 	}
 
 	if (!ret)
-- 
2.40.1

