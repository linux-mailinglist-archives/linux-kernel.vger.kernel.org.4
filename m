Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083775F6A5C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiJFPOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJFPOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:14:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C7FFF2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:14:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 995BEB820C0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAD4C433D6;
        Thu,  6 Oct 2022 15:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665069273;
        bh=iWa1rm6SdQ2WK8Wust6X3A7TVGiD5e+VeSaAdtLkQuw=;
        h=From:To:Cc:Subject:Date:From;
        b=MEYApFcs7c2zP6aIDq3MKt+SQH8lpFSTZ6LLi8pk5mjmYUCKDrHbW8n5txPc6acX5
         oZS1LD/Ap+jhUnluF4fMv8yYgu+5uD3ZXORGDAu7WpwQusnT2qO4TzvadBkpQAis/V
         ecIPCWRnsGUri4dnBsubtl0eKJA3hNqki5WhXmxJ70ICvrYUEHlyazXb7HCX+J0d51
         GYE6XlBSTXD5Kv4h+JGQf7XTcA+2nOgmKONnmhF7LWeZfVIfIOlzMX8Maq9dO84FiR
         vDz2jXtb1dRZSjl0KZiXHzMQWBs1c1S+uleAsW3020b2zbDcR0jznefmUigdrG+tUM
         NcV8nHgXKMvng==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix compile warning
Date:   Thu,  6 Oct 2022 23:14:28 +0800
Message-Id: <20221006151428.57561-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/f2fs/super.c:3886:6: warning: no previous prototype for 'f2fs_record_stop_reason' [-Wmissing-prototypes]

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fad333881ea2..2908d41ed462 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3884,7 +3884,7 @@ static void save_stop_reason(struct f2fs_sb_info *sbi, unsigned char reason)
 	spin_unlock(&sbi->error_lock);
 }
 
-void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
+static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	int err;
-- 
2.36.1

