Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB3874C5FE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjGIPVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjGIPVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:21:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C2A3C10;
        Sun,  9 Jul 2023 08:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1B8160BFB;
        Sun,  9 Jul 2023 15:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E91EC433C8;
        Sun,  9 Jul 2023 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915755;
        bh=HNcLdJT+rGUMH2QEx9FvKd4oupmDsOo1k5N5Y0hlCqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F70v8wDPiuoAbv+QRRpWfTSXi3j3Pmkw0zNqL0+b07vtM92LlLoYSVZHUWTuEHdcr
         AkhdwlsOX7qPQ+JhwB8zud/R2d2JrgLncjAN6mP+p1/H88p+WgwxdymgUq/zZ2p05q
         7f0GVy1XIL+tf5ZIUaNTvjfQ27mcqocRyIdRE2QVIqFTaV+VGYDcjTKhBYLM2LRSv7
         LxtSDCVT/b5v/XlJc7WiX+ACvJO0oFmUouxFJXU57wbWMsemHlTavy+Iwm4mtfsfXZ
         GGJ76leZeC/9cf+qneG6wogAPlwDXpoxjVaQ/Kr6mRvlEjlpyhcqoCcwvtUkw80Kwa
         NWzH7N0j48MAQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hao Chen <chenhao418@huawei.com>,
        kernel test robot <lkp@intel.com>,
        Hao Lan <lanhao@huawei.com>, Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, guoren@kernel.org, huangguangbin2@huawei.com,
        netdev@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 10/10] net: hns3: fix strncpy() not using dest-buf length as length issue
Date:   Sun,  9 Jul 2023 11:15:28 -0400
Message-Id: <20230709151528.513775-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151528.513775-1-sashal@kernel.org>
References: <20230709151528.513775-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.120
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
index 3158c08a3aa9c..ff931b8ef569e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -388,19 +388,36 @@ static void hns3_dbg_fill_content(char *content, u16 len,
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
index 9cda8b3562b89..9d064efdfd59f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -81,16 +81,35 @@ static void hclge_dbg_fill_content(char *content, u16 len,
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

