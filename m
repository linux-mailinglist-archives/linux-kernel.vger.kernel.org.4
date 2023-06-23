Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E40773B22C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjFWH6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjFWH6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:58:10 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B9381BCC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 00:58:07 -0700 (PDT)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 23 Jun 2023 16:58:05 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
        by 156.147.1.125 with ESMTP; 23 Jun 2023 16:58:05 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From:   Chanho Min <chanho.min@lge.com>
To:     andreyknvl@gmail.com
Cc:     chanho.min@lge.com, dvyukov@google.com, elver@google.com,
        glider@google.com, gunho.lee@lge.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com
Subject: [PATCH v2] kasan: fix mention for KASAN_HW_TAGS
Date:   Fri, 23 Jun 2023 16:58:05 +0900
Message-Id: <20230623075805.1630-1-chanho.min@lge.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CA+fCnZfi_o6QbfDamUjsPXjtnEwKyBn8y+T8=zxV2mEpA=DUyQ@mail.gmail.com>
References: <CA+fCnZfi_o6QbfDamUjsPXjtnEwKyBn8y+T8=zxV2mEpA=DUyQ@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes description of the KASAN_HW_TAGS's memory consumption.
KASAN_HW_TAGS are dependent on the HW implementation and are not reserved
from system memory like shadow memory.

Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 lib/Kconfig.kasan | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index fdca89c05745..f8f9e12510b7 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -124,7 +124,8 @@ config KASAN_HW_TAGS
 	  Supported only on arm64 CPUs starting from ARMv8.5 and relies on
 	  Memory Tagging Extension and Top Byte Ignore.
 
-	  Consumes about 1/32nd of available memory.
+	  Does not consume memory by itself but relies on the 1/32nd of
+	  available memory being reserved by the firmware when MTE is enabled.
 
 	  May potentially introduce problems related to pointer casting and
 	  comparison, as it embeds a tag into the top byte of each pointer.
-- 
2.17.1

