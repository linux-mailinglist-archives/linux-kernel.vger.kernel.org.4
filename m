Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58F95FD863
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJML2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJML2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:28:47 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AC6125853
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:28:39 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 27F155FD02;
        Thu, 13 Oct 2022 14:28:36 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1665660516;
        bh=I+EwayS2mXiTVYC1YgiXzkHmIUayGLlFvMVLY98UxeQ=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=W0aYpoC6nbXXubmUlI+Q9zdZHp9twEt3VMTvrO6o9Sa6TzimBpUS3j0ZtcRFhaQJQ
         QPEBgCXZnX8CpIFvtcEFLxcdJxMpb/xmRO0tR2PKukmgjbJG15j9SqzC86A1b1DcCe
         A6nVMambHSTvzdmnPyRzd2ucbNwVyD/eAQS22mueZ15uw/mfTPHTIKBqgsijt2xfxV
         wRH06UbZ7WwAY5hF4Uvpd18VEIzVTa+r32aNIsXjk7dB8yTdEjkG4rRwk5O7MIP6Ci
         4FgNIddcFShvX4FPmMigDdUFSddiFq3/i0B9UmHP+Ac3cjv4onKeKgcMVHIg0YQEfO
         X0czXvbfkodIA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu, 13 Oct 2022 14:28:34 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <ngupta@vflare.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1] zsmalloc: zs_destroy_pool: add size_class NULL check
Date:   Thu, 13 Oct 2022 14:28:25 +0300
Message-ID: <20221013112825.61869-1-avromanov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/10/13 08:08:00 #20452392
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside the zs_destroy_pool() function, there can still
be NULL size_class pointers: if when the next size_class is
allocated, inside zs_create_pool() function, kzalloc will
return NULL and handling the error condition, zs_create_pool()
will call zs_destroy_pool().

Fixes: f24263a5a076 ("zsmalloc: remove unnecessary size_class NULL check")
Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 mm/zsmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 525758713a55..d03941cace2c 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2311,6 +2311,9 @@ void zs_destroy_pool(struct zs_pool *pool)
 		int fg;
 		struct size_class *class = pool->size_class[i];
 
+		if (!class)
+			continue;
+
 		if (class->index != i)
 			continue;
 
-- 
2.25.1

