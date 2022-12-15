Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D5E64DE98
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiLOQ2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLOQ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:27:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359EF28738
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:27:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5C51B81C0D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDD6C433D2;
        Thu, 15 Dec 2022 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671121635;
        bh=BfenddMZffflFBpCkDgdfkrr1/054jtaefDkr+14vh0=;
        h=From:To:Cc:Subject:Date:From;
        b=PhIKLFHQF1/QaV/w9RvkMZvMSUJgufPsRjMPyXjFbqqHD5H9goy6aF3ADPYMlHK5s
         1Q9wtEKdpV/qtBSWm1kGjv5OBuT1/muOGIMBVNI/w6yL5xb+svnVqAR+S0T1wWU/7T
         LWfz0EuWAJS3F7obfqbbSVX4Wq7OfIEt/UIML2en/tuyoz01xCIjp+T/fIktjK34ei
         81Tp3KgT8teG9QGpj1FgIz4A+xQX5Yngc7UqU1B5wLBkzpflxkqYMPqkiTGzeKNhzb
         s7XsbK4seovcB2oaE6EtWQJDaAQm5Xxci6+xNh3XgFBQjZ/woX5mRJhNBik2GZEUYA
         Qn3oncftF4WuQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kmsan: export kmsan_handle_urb
Date:   Thu, 15 Dec 2022 17:26:57 +0100
Message-Id: <20221215162710.3802378-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
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

From: Arnd Bergmann <arnd@arndb.de>

USB support can be in a loadable module, and this causes a link
failure with KMSAN:

ERROR: modpost: "kmsan_handle_urb" [drivers/usb/core/usbcore.ko] undefined!

Export the symbol so it can be used by this module.

Fixes: 553a80188a5d ("kmsan: handle memory sent to/from USB")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/kmsan/hooks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 35f6b6e6a908..3807502766a3 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -260,6 +260,7 @@ void kmsan_handle_urb(const struct urb *urb, bool is_out)
 					       urb->transfer_buffer_length,
 					       /*checked*/ false);
 }
+EXPORT_SYMBOL_GPL(kmsan_handle_urb);
 
 static void kmsan_handle_dma_page(const void *addr, size_t size,
 				  enum dma_data_direction dir)
-- 
2.35.1

