Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6881D6DA59C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbjDFWMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjDFWMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:12:35 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765C0B455
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:12:33 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id ld14so233105qvb.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680819151; x=1683411151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/a+4VDDPwS/RRF9EmWa2djAoEzc30Ym18+xLqrhOLM=;
        b=gHJIA+wejylPYAXvOEDxEAdVzRUU1Ha2hQerAHVOBbdUQpFufphds9hPOJ6hD4adY5
         bZow27oUDQvaRW6tGFJkz/8bsKR7hZQyzfXs59FFkrKHVs7MmMvn450rHOjvlraslDCN
         F0Lux9ajYawZ/6Z5zjkesB9N5aN86ENtqmON8+rS2x4VygFDzErgmGw/tmBhWgCxIZ7X
         Hk+zgLN3fljPCgx52oBWIfNJ2XhyKYrKHBLnDHUVMEmSyxPdpcEmD0728fpK2VAudNqT
         x4ByhI8CgDkJXhtcy1wdMLD++v2bFDDYAh8Sa0BysnlAuFk8ejG8Y+b2rRRwvY1dhq65
         lRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680819151; x=1683411151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/a+4VDDPwS/RRF9EmWa2djAoEzc30Ym18+xLqrhOLM=;
        b=2Cuv5Lq5ilu+09SsKf4JoxpNI2UKl+cna9O3WGCTMmdb+JSgIcggMBz3dAPQeQm2Ce
         ozQnuF7uCgJG/78hFskzGADu5nyyFIz+7V0Vbisc1yt7ZYT7ZOWQ7MKJN4oVLjea1TZl
         o/02RIszeZCEl7LIYV9ez+E08fVbAu0JeqK4Iq1U4zwbUue4aiqwAVsUQjpen1xeP+uB
         dRwc8Fc/ATM7vBnmAuuRZ0FkD0f3Dw5F2kIGieackGNo9F28XXdVX/Shv+5UoDf1XYVX
         14nFtz72SO7HRaSKerpUDBDguvAS/TniOLqDnEIO2glPqmNKswfS87KIcIVP1IWiPaNi
         mFfg==
X-Gm-Message-State: AAQBX9dEjO3i2nM/D0biBLHm++DecEQGc9HXxmGE/SQqo419r3vy2snT
        /R9prO/8yjIDqRlu4CZzIvfrn+lV/Srv2A==
X-Google-Smtp-Source: AKy350YyRUtbiLNikyC7Jn/5/dY4cME14lan2FXVhMd9UaEeGkoGtcFHTXiFKwhxrq/6tup+IIC1eg==
X-Received: by 2002:ad4:5baa:0:b0:5c1:59b9:40b4 with SMTP id 10-20020ad45baa000000b005c159b940b4mr855565qvq.48.1680819151446;
        Thu, 06 Apr 2023 15:12:31 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ks15-20020a056214310f00b005dd8b9345e2sm816353qvb.122.2023.04.06.15.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:12:30 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Subject: [PATCH RESEND 2/3] scripts/gdb: timerlist: fix rb_node access
Date:   Thu,  6 Apr 2023 15:12:16 -0700
Message-Id: <20230406221217.1585486-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406221217.1585486-1-f.fainelli@gmail.com>
References: <20230406221217.1585486-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amjad Ouled-Ameur <aouledameur@baylibre.com>

"struct timerqueue_head" no longer has "next" member since v5.4-rc1:
commit 511885d7061e ("lib/timerqueue: Rely on rbtree semantics for next
timer")

Therefore, access "rb_node" through active->rb_root->rb_root->rb_node.

Moreoever, remove  curr.address.cast() on rb_node as this breaks the code
and is not necessary.

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 scripts/gdb/linux/timerlist.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index fac951236dc4..d16909f8df35 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -43,8 +43,7 @@ def print_timer(rb_node, idx):
 
 
 def print_active_timers(base):
-    curr = base['active']['next']['node']
-    curr = curr.address.cast(rbtree.rb_node_type.get_type().pointer())
+    curr = base['active']['rb_root']['rb_root']['rb_node']
     idx = 0
     while curr:
         yield print_timer(curr, idx)
-- 
2.34.1

