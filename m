Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0058626CB0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 00:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiKLXnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 18:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKLXnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 18:43:14 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BCD13DF4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 15:43:13 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id y14so20329154ejd.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 15:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JAPLUeDBIzUEBdWCKMJoUrcE6eDnC6Knva73vPL0M0=;
        b=CdUBDpjVZZCyKr2IzySbhtUr4+SVpUXmoCvWs6zI2fv5XgzhKsOOQQO1QGgaHAQqdP
         2+W/9a8Qwf9/y0ePQJTa3ieAbhztj/K2RlaeEmQNeuvVf946CyAap+aqz9h072e7wQGc
         vkJ65e5iCKLDm4uTNglOk4NyOIynN9NEqGltRqC0cUySA1gxq4FRy9ZjSrupxv82vIwA
         gE5uI/ip72wzha473gItUwY5EMQG3+dpirobZkU1AY+v5mjcTJ5cmFkCZt/zsrkTae9u
         HT8Ez5ssAbTrm1gmIunktBoCP4V4lgpWc6N58LDfJyyZjR0oEAtiZfpfTaTg+ldvOgH+
         ofXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JAPLUeDBIzUEBdWCKMJoUrcE6eDnC6Knva73vPL0M0=;
        b=OtD5xhKZLMp8ZBAnHv7YP9ctGldTQcj/goJrV5plqYjYmSk4KHCZLlGwGC2af8OAH7
         lOhYkuq3CgvBFARb5EbGiFEKtwxkGzUqGcMT5o5fo5boM7fQi8Nk5/MhIdAg3bE7sVbF
         818sVYLfmqZgRsWZO6/7UFj1JwlO8bkuN3Ets6uJx9ocT56VJcVMVY1A47rAPeKscmIA
         CkGsiXyna4D95F2RYv1muNgwDgmqaxBQiPgRzUARmgyGxqDKZRGrfYHZ8BwotYRUwPEG
         IqUmNstG9mt47PEOncaseex+s8A6E2sMDpUKz5Ami+4Bl1c/oaSRIC1TPvup825f3ztM
         EMPA==
X-Gm-Message-State: ANoB5pngCpC20pw5CW+VG8Tyl8WZFBd0AT7Ukux8MoT7QkeLYWoW8nRG
        Ejkewcji0otRwGKqrg/SvsB2Si0XHhl0Xg==
X-Google-Smtp-Source: AA0mqf5QxE7Q0KMrZxenpa+8bIEvBE14gtYDA9uqBe+FU9d3s/1+lrWSSZYkHxOqgZXrjSD4xVLSuQ==
X-Received: by 2002:a17:906:a1c8:b0:78d:585e:d183 with SMTP id bx8-20020a170906a1c800b0078d585ed183mr6267530ejb.768.1668296591873;
        Sat, 12 Nov 2022 15:43:11 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id b19-20020aa7df93000000b004587f9d3ce8sm2800189edy.56.2022.11.12.15.43.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Nov 2022 15:43:10 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Liam.Howlett@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH] maple_tree: should get pivots boundary by type
Date:   Sat, 12 Nov 2022 23:43:08 +0000
Message-Id: <20221112234308.23823-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get pivots boundary by type.

Fixes: 54a611b60590 (Maple Tree: add new data structure)
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

---
* kernel build looks good
---
 lib/maple_tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 73e2e6434e2f..2123d1930a9b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -669,12 +669,13 @@ static inline unsigned long mte_pivot(const struct maple_enode *mn,
 				 unsigned char piv)
 {
 	struct maple_node *node = mte_to_node(mn);
+	enum maple_type type = mte_node_type(mn);
 
-	if (piv >= mt_pivots[piv]) {
+	if (piv >= mt_pivots[type]) {
 		WARN_ON(1);
 		return 0;
 	}
-	switch (mte_node_type(mn)) {
+	switch (type) {
 	case maple_arange_64:
 		return node->ma64.pivot[piv];
 	case maple_range_64:
-- 
2.33.1

