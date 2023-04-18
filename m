Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4596E595F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjDRGZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDRGZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:25:17 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D10E1BD8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:25:15 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 92E2F5FD0A;
        Tue, 18 Apr 2023 09:25:12 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681799112;
        bh=4Bi0KK9m/M8I5xBIw0piOBV6vW2Jir8/WPsX0rbFo1k=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=bQF8kwlLnIL4gFlxGkjrHhSyOwxOthrfF5p7DqK7gxSGzrvCc+CuZ1WQqZa6feozl
         CgjmBHR/JufPBhpEhvo/gwUwJnSbysPWxaOl0NPKpjXS4UZ2wR8PcKEzRm4e74mnlP
         fJlBXog9u1ouVP3crp7QapLLlqnUDlDMG65Dc/1s9zl6fKek20B0c6ETveiYgiYloo
         JC2v749RnUTyv/q9LM/cjW+0u/GCxAhyhjR7gu/tYSqULeDQFz7tBCe9oBcblZzaPr
         mDyIk4nHDeBNNKOiKjew2s0zbQg0xrP8Vd6+yZk5teXivy6b3eJ2KSlMPQ6u6idwB4
         kdH8DXp2vZoDw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 18 Apr 2023 09:25:12 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [RFC PATCH v1 1/5] mm/zsmalloc: use ARRAY_SIZE in isolate_zspage()
Date:   Tue, 18 Apr 2023 09:24:59 +0300
Message-ID: <20230418062503.62121-2-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230418062503.62121-1-avromanov@sberdevices.ru>
References: <20230418062503.62121-1-avromanov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/18 02:02:00 #21122658
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
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

