Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE6C7392A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjFUWnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFUWnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:43:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3282F1;
        Wed, 21 Jun 2023 15:42:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44B5C616F5;
        Wed, 21 Jun 2023 22:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A789C433C0;
        Wed, 21 Jun 2023 22:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687387378;
        bh=4kl07al0Jzvum5d8UANt44upxbmeLGvcypOHEKRd24g=;
        h=Date:From:To:Cc:Subject:From;
        b=a2QblHnOuvKjfWHwLNTTBOT/dKg0l/lM4+DxplEJkUhTJBJFfJfSaLpbh8VpmRh2M
         Fdm/WkVndX/G1Jkz7Yaf4kT+3GsgDZD+doKNXwWCP3GcJrfvBPuJpKaATiwz8n2fZR
         zkMHGCDvuhEJYb0P1StefrO2WIE2K1vdXtrNGWv6bFbzDhA4RBPC7A2tSe8q+GWwkK
         oIQbxvwrLwpQDF1Co2k9cudV2F8MdEECv1lDox7ulPYrukl8oPD18cO1LUfo3XEiQE
         Dkx00pw2DQ0ZnpmrWePGzR4e1Q4AU34al9+hS7sQ2q0oqDuSa5CERmUghq+IYLVeps
         02aR1CvCvJdOg==
Date:   Wed, 21 Jun 2023 16:43:54 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>
Subject: [PATCH][next] reiserfs: Replace one-element array with
 flexible-array member
Message-ID: <ZJN9Kqhcs0ZGET/8@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element array with flexible-array
member in direntry_uarea structure, and refactor the rest of the code,
accordingly.

Worth mentioning is that before these changes, the original implementation
was returning two-too many bytes in function direntry_create_vi():

fs/reiserfs/item_ops.c:464:     int size = sizeof(struct direntry_uarea);
...
fs/reiserfs/item_ops.c-490-     size += (dir_u->entry_count * sizeof(short));
...
fs/reiserfs/item_ops.c-517-     return size;

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/290
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/reiserfs/fix_node.c | 5 +++--
 fs/reiserfs/reiserfs.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/reiserfs/fix_node.c b/fs/reiserfs/fix_node.c
index fefe87e1c099..6c13a8d9a73c 100644
--- a/fs/reiserfs/fix_node.c
+++ b/fs/reiserfs/fix_node.c
@@ -2252,8 +2252,9 @@ static int get_virtual_node_size(struct super_block *sb, struct buffer_head *bh)
 
 	return sizeof(struct virtual_node) +
 	    max(max_num_of_items * sizeof(struct virtual_item),
-		sizeof(struct virtual_item) + sizeof(struct direntry_uarea) +
-		(max_num_of_entries - 1) * sizeof(__u16));
+		sizeof(struct virtual_item) +
+		struct_size_t(struct direntry_uarea, entry_sizes,
+			      max_num_of_entries));
 }
 
 /*
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 55e85256aae8..b81749492ef9 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -2373,7 +2373,7 @@ struct virtual_node {
 struct direntry_uarea {
 	int flags;
 	__u16 entry_count;
-	__u16 entry_sizes[1];
+	__u16 entry_sizes[];
 } __attribute__ ((__packed__));
 
 /***************************************************************************
-- 
2.34.1

