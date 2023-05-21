Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4B170AD73
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 12:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjEUKZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 06:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjEUKHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 06:07:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1465E6E
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 02:55:41 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25566708233so78538a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 02:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684662941; x=1687254941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2wvUeHhuusQaep940v40WYCSBa0GTC/pU4VHFBZK60=;
        b=XnIQqtxdxPmD/KnZq8uj/btOSp0PPr8cQxoppCk6LlcV9cq2J7lenURpztkriMgNAh
         sK3FUJUMe/6fFhvg1YPxrBjRCff0j4Vm+3jxxp6lsGM3tZOXYW4RNrDvKAWQmB65hwZ5
         SLGfeEZarhej8B+HRf8MQPQDEIkQLh//EquRSaY0Q87miZs8ojMxNZ3gn/oH0QiO+IIx
         Hd3MshNLmegApz9HX6IksnLt7K7INyLwibs0UIGS81aWqIrSedRMK2TpXarOumqSMP/2
         jy1hRpLb53TGSsHE3T6ICh6n/sZ8SnWdDjit0y/DrNnPj8DMpwaUUkEcm9lt39OyByPk
         HqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684662941; x=1687254941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2wvUeHhuusQaep940v40WYCSBa0GTC/pU4VHFBZK60=;
        b=D59SoVCRCkzLfO3WQJbpbrXFg5LkF02wRisPiUC/C0X2VgUQ261sySCvlOl/M+F7OM
         +Ei+oEy1csUJqRUr2MnEIM5sNd6CUoZoN0DRKy5DEHOtsIUWcWBg7xap1z4hVqs3NcMF
         P5iZqIWrOsi8alQ8ZWtfkPpaqfeaDgCfYycL6f3s8kPJjMwc9aKarzC/XKcTG4x7p56n
         bQDLrXi9oVDyIzXALlrvVv4YBtbGkJZVPxmntCh7Jz8m2hH6PEJ9942sdVOGfmLsDaPf
         qxRQ+r6ibllqHqr11CavqNh++x6HULCv0+xSxfn5WLhHXuQCOwavmYhE1b0MfODdsySC
         9UEQ==
X-Gm-Message-State: AC+VfDyE8TtwOyUBxeTnximqq0zIXGRST1PFqXWtF+/CdfwIqp3IrEqn
        7gHeSGwuPNbI4yJdt6t/aaaxUwPRtsrv3859eKc=
X-Google-Smtp-Source: ACHHUZ4pNkFMSNTwnq79r37gYRmD1cb5gl4v11Ef3rVSHBUEsV1w9A31bRWAJMxfSePavMnzWl8xYg==
X-Received: by 2002:a17:90b:4f4e:b0:250:4f32:54b2 with SMTP id pj14-20020a17090b4f4e00b002504f3254b2mr7164761pjb.19.1684662941280;
        Sun, 21 May 2023 02:55:41 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id b15-20020a631b4f000000b00534684201b0sm2530629pgm.27.2023.05.21.02.55.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 May 2023 02:55:40 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     arnd@kernel.org, willy@infradead.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Liam.Howlett@oracle.com,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH] radix tree test suite: Fix building radix tree test suite.
Date:   Sun, 21 May 2023 17:54:50 +0800
Message-Id: <20230521095450.21332-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230516194212.548910-1-arnd@kernel.org>
References: <20230516194212.548910-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The build of radix tree test suite failed due to a new internal header
file added to radix-tree.c. Adding the header directory in the Makefile
fixes it.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 tools/testing/radix-tree/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index caf32a9b9608..7527f738b4a1 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -I. -I../../include -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address \
-	  -fsanitize=undefined
+CFLAGS += -I. -I../../include -I../../../lib -g -Og -Wall \
+	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
 LDFLAGS += -fsanitize=address -fsanitize=undefined
 LDLIBS+= -lpthread -lurcu
 TARGETS = main idr-test multiorder xarray maple
@@ -49,6 +49,7 @@ $(OFILES): Makefile *.h */*.h generated/map-shift.h generated/bit-length.h \
 	../../../include/linux/xarray.h \
 	../../../include/linux/maple_tree.h \
 	../../../include/linux/radix-tree.h \
+	../../../lib/radix-tree.h \
 	../../../include/linux/idr.h
 
 radix-tree.c: ../../../lib/radix-tree.c
-- 
2.20.1

