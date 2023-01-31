Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C24682F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjAaOrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjAaOrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:47:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0CD4859F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:47:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BFBCB81D1C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2603EC4339C;
        Tue, 31 Jan 2023 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675176430;
        bh=fHwIuqaUuMg5+WXKD6YgXPsdEqVlJYuXKPQIpe6n52A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cHNqm69tdUwpoBfLCMhg7nBegkoqKVbDKXOdq61CYE7/k0DP9jA3TkEXyYogDWAO7
         UFpUztxi7RoVBfibSn8vg78LvzH26y+/4yuUrUcLEe9aeZvrHjG7EO6lVsEePsCyzF
         FDpnUDnmf3O8QvLb0F+7gSLEQ+PaNBG5C7zjdh/n9Py4mppEpKcEEeBH6JrNXGLFtm
         LGr2P35GfCPWrk+7MnMckVIXq1eM8+Cu/5UkfAzn7jkV3XscXcwQlJ6hs/48cgA/3/
         O0pG8TfMe46nppq0SMLzvDoQ0g7z4t7VuCq7Lo+e5q6tmgl3we9U3UTVvbnUqPSC2X
         Wl+1AXgyVURMg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] f2fs: fix to update age extent in f2fs_do_zero_range()
Date:   Tue, 31 Jan 2023 22:47:01 +0800
Message-Id: <20230131144701.34418-3-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230131144701.34418-1-chao@kernel.org>
References: <20230131144701.34418-1-chao@kernel.org>
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

We should update age extent in f2fs_do_zero_range() like we
did in f2fs_truncate_data_blocks_range().

Fixes: 71644dff4811 ("f2fs: add block_age-based extent cache")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 746ffcd09b6c..60488749c35e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1494,6 +1494,7 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 	}
 
 	f2fs_update_read_extent_cache_range(dn, start, 0, index - start);
+	f2fs_update_age_extent_cache_range(dn, start, index - start);
 
 	return ret;
 }
-- 
2.36.1

