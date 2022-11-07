Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650A561EC2C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiKGHgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiKGHgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:36:08 -0500
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB56355AB
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 23:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oWlV1
        /PN2hdeIdlOnNLd5vGcmonaDcfm0d75QqcwyFU=; b=NKa+faHeYwcWjVSNlwyB0
        TxTui03HF63KnO91Vd8w9GhnNEChGuluWbEK7CTOLcUnxUHA3dm4i+I6RXDPgwQJ
        1H9h+ZF+upcmlOPEzdQU8aFHz/v4HqjOld+QqEQ5fMJDYYpRMRZIZFT4dK1dHgi+
        pbFEGjPuGWKaOtzC/ZIpNM=
Received: from localhost.localdomain (unknown [111.197.233.249])
        by smtp3 (Coremail) with SMTP id G9xpCgDn+FxEtWhjNUPBrA--.11221S2;
        Mon, 07 Nov 2022 15:35:33 +0800 (CST)
From:   SPeak Shen <speakshen@163.com>
To:     Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, shenyanfeng <shenyanfeng@xiaomi.com>,
        SPeak <speakshen@163.com>
Subject: [PATCH] driver: gpu: add failure check for ftell
Date:   Mon,  7 Nov 2022 15:33:23 +0800
Message-Id: <20221107073323.1283046-1-speakshen@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgDn+FxEtWhjNUPBrA--.11221S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrKry3Cr18Gr1fWr1DGFyfZwb_yoW8Jr17pF
        4fG3sYvryrXwnrKr1DAFWkZrySya97tFyF9FWxuwn3uw15Jry2kryak340qryDJr47Aw1a
        9r1vgrySvF4xZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziIPfdUUUUU=
X-Originating-IP: [111.197.233.249]
X-CM-SenderInfo: 5vshtyhvkh0qqrwthudrp/1tbiWQWyPFWBwwL5lQAAsr
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: shenyanfeng <shenyanfeng@xiaomi.com>

add return-value check of ftell to improve robustness(and avoid abnormal behavior)

Signed-off-by: SPeak <speakshen@163.com>
Signed-off-by: shenyanfeng <shenyanfeng@xiaomi.com>
---


Receive "Undelivered Mail Returned to Sender", so send again


 drivers/gpu/drm/radeon/mkregtable.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/mkregtable.c b/drivers/gpu/drm/radeon/mkregtable.c
index 52a7246fe..c31c58e5f 100644
--- a/drivers/gpu/drm/radeon/mkregtable.c
+++ b/drivers/gpu/drm/radeon/mkregtable.c
@@ -193,6 +193,7 @@ static int parser_auth(struct table *t, const char *filename)
 	regmatch_t match[4];
 	char buf[1024];
 	size_t end;
+	long pos;
 	int len;
 	int done = 0;
 	int r;
@@ -228,12 +229,12 @@ static int parser_auth(struct table *t, const char *filename)
 	last_reg = strtol(last_reg_s, NULL, 16);
 
 	do {
-		if (fgets(buf, 1024, file) == NULL) {
+		if ((fgets(buf, 1024, file) == NULL) || (pos = ftell(file)) < 0) {
 			fclose(file);
 			return -1;
 		}
 		len = strlen(buf);
-		if (ftell(file) == end)
+		if (pos == end)
 			done = 1;
 		if (len) {
 			r = regexec(&mask_rex, buf, 4, match, 0);
-- 
2.25.1

