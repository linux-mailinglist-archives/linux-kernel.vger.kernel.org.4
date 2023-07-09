Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466FD74C5B2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjGIPSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjGIPRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:17:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB297E4C;
        Sun,  9 Jul 2023 08:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB1BE60C24;
        Sun,  9 Jul 2023 15:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D9CC433CC;
        Sun,  9 Jul 2023 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915728;
        bh=QCldKSRCuUDGHPV/X+YuHqMghAyLd4JfvxS3WWOupJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjFSfSU1dozk//Jl85afMJPOAjFbGDdkl35kHuhq+a/vokNE24Dnrdh6Y2zjLQoMf
         hedox8DVqFfGqTX3rARNbNY2+fcQ6vqe2QZ7+ZEyjD6hXxPUzZm9uSMxWUXcIaPk3/
         M4Y01SuSZB+29ILej/Iw86TD7sFYmzWtoTy8QJ/tRisWlv8x2VgSS+184d6ciMmyA2
         aUnb5IsPppR/AFiAV2Q6nUZie2HwK7t8D248cLDz/XhRabhNp1Aj0IR0zQqaRZFAdi
         uZIIcfinMZbSNhY0w9LlGXYvOFnsn+hw30yReg+afi0xol8m8XWHF/ehsW+afXTOo9
         iJKuysqkiE8JQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hao Chen <chenhao418@huawei.com>,
        kernel test robot <lkp@intel.com>,
        Hao Lan <lanhao@huawei.com>, Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, guoren@kernel.org, huangguangbin2@huawei.com,
        netdev@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 18/18] net: hns3: fix strncpy() not using dest-buf length as length issue
Date:   Sun,  9 Jul 2023 11:14:46 -0400
Message-Id: <20230709151446.513549-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151446.513549-1-sashal@kernel.org>
References: <20230709151446.513549-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.38
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Chen <chenhao418@huawei.com>

[ Upstream commit 1cf3d5567f273a8746d1bade00633a93204f80f0 ]

Now, strncpy() in hns3_dbg_fill_content() use src-length as copy-length,
it may result in dest-buf overflow.

This patch is to fix intel compile warning for csky-linux-gcc (GCC) 12.1.0
compiler.

The warning reports as below:

hclge_debugfs.c:92:25: warning: 'strncpy' specified bound depends on
the length of the source argument [-Wstringop-truncation]

strncpy(pos, items[i].name, strlen(items[i].name));

hclge_debugfs.c:90:25: warning: 'strncpy' output truncated before
terminating nul copying as many bytes from a string as its length
[-Wstringop-truncation]

strncpy(pos, result[i], strlen(result[i]));

strncpy() use src-length as copy-length, it may result in
dest-buf overflow.

So,this patch add some values check to avoid this issue.

Signed-off-by: Hao Chen <chenhao418@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/lkml/202207170606.7WtHs9yS-lkp@intel.com/T/
Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 31 ++++++++++++++-----
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 29 ++++++++++++++---
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index bcccd82a2620f..f6ededec5a4fa 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -435,19 +435,36 @@ static void hns3_dbg_fill_content(char *content, u16 len,
 				  const struct hns3_dbg_item *items,
 				  const char **result, u16 size)
 {
+#define HNS3_DBG_LINE_END_LEN	2
 	char *pos = content;
+	u16 item_len;
 	u16 i;
 
+	if (!len) {
+		return;
+	} else if (len <= HNS3_DBG_LINE_END_LEN) {
+		*pos++ = '\0';
+		return;
+	}
+
 	memset(content, ' ', len);
-	for (i = 0; i < size; i++) {
-		if (result)
-			strncpy(pos, result[i], strlen(result[i]));
-		else
-			strncpy(pos, items[i].name, strlen(items[i].name));
+	len -= HNS3_DBG_LINE_END_LEN;
 
-		pos += strlen(items[i].name) + items[i].interval;
+	for (i = 0; i < size; i++) {
+		item_len = strlen(items[i].name) + items[i].interval;
+		if (len < item_len)
+			break;
+
+		if (result) {
+			if (item_len < strlen(result[i]))
+				break;
+			strscpy(pos, result[i], strlen(result[i]));
+		} else {
+			strscpy(pos, items[i].name, strlen(items[i].name));
+		}
+		pos += item_len;
+		len -= item_len;
 	}
-
 	*pos++ = '\n';
 	*pos++ = '\0';
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 142415c84c6b2..0ebc21401b7c2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -87,16 +87,35 @@ static void hclge_dbg_fill_content(char *content, u16 len,
 				   const struct hclge_dbg_item *items,
 				   const char **result, u16 size)
 {
+#define HCLGE_DBG_LINE_END_LEN	2
 	char *pos = content;
+	u16 item_len;
 	u16 i;
 
+	if (!len) {
+		return;
+	} else if (len <= HCLGE_DBG_LINE_END_LEN) {
+		*pos++ = '\0';
+		return;
+	}
+
 	memset(content, ' ', len);
+	len -= HCLGE_DBG_LINE_END_LEN;
+
 	for (i = 0; i < size; i++) {
-		if (result)
-			strncpy(pos, result[i], strlen(result[i]));
-		else
-			strncpy(pos, items[i].name, strlen(items[i].name));
-		pos += strlen(items[i].name) + items[i].interval;
+		item_len = strlen(items[i].name) + items[i].interval;
+		if (len < item_len)
+			break;
+
+		if (result) {
+			if (item_len < strlen(result[i]))
+				break;
+			strscpy(pos, result[i], strlen(result[i]));
+		} else {
+			strscpy(pos, items[i].name, strlen(items[i].name));
+		}
+		pos += item_len;
+		len -= item_len;
 	}
 	*pos++ = '\n';
 	*pos++ = '\0';
-- 
2.39.2

