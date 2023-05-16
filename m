Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D1C7049B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjEPJvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjEPJvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:51:06 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EAF3C3B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:51:03 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 2CBC85FD03;
        Tue, 16 May 2023 12:51:01 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684230661;
        bh=4Bi0KK9m/M8I5xBIw0piOBV6vW2Jir8/WPsX0rbFo1k=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=s/VOr+tkKmc+sNMYoBVnfmQUuBjwwpsVzTbONS2/OJn7L4+QlPVOZGiXY490MZdtM
         cEgpssWMGZTj4mkg9LZQK6ptOzWtM55QkVgomAyItHgmhG4J9qn/MPZu7MPqYWVZSm
         thOhr4ZK8qNH2zL+LIABBbZl/i7E14CwkjDlyMLjIgI8fyfOHtTKjWmxhUENcIQbud
         eLVAyt/Q2GHD8NtXXDEsuTikSzzm+eGF7+epetFFKCWJZjhSj6SBjkoGeTGLn6nIQk
         JM14aICafLpp1APvntQr8j3wA6mvcmWDeMDpWv1J3eGs1cH8BomFby6owW5XOiOI5Z
         1rjmLTFSBk01g==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 16 May 2023 12:50:59 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 1/2] mm/zsmalloc: use ARRAY_SIZE in isolate_zspage()
Date:   Tue, 16 May 2023 12:50:28 +0300
Message-ID: <20230516095029.49036-1-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/16 05:57:00 #21317490
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Better not to use hardcoded constants.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 mm/zsmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 702bc3fd687a..f23c2da55368 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1888,7 +1888,7 @@ static struct zspage *isolate_zspage(struct size_class *class, bool source)
 		fg[1] = ZS_ALMOST_EMPTY;
 	}
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < ARRAY_SIZE(fg); i++) {
 		zspage = list_first_entry_or_null(&class->fullness_list[fg[i]],
 							struct zspage, list);
 		if (zspage) {
-- 
2.38.1

