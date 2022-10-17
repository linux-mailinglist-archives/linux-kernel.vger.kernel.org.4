Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C9E601321
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiJQQDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiJQQCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:02:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0735A6DF8E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bj12so25923598ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtTLJEmxkngU/xzkXx+LrxeCsOIvLIsQVzHgn6JJ/30=;
        b=Rfae/Y+4yaGIP0vcpaZVNUfII+7m7g52LOf1BBwmovC33F4FdDhsJTYyIWL6AuKQyJ
         00E7hdNbT9AJARRPFsDe+QTTbCVOvP+tYMJdn3lM6XO5CgyjpiptP6Q89gE+W1m+COwH
         HIeCPuYctOpQLqLjeW8NBHyioUVGGZIfXWGSFqtzWlYBCk3fQzcUr7twHFDxB6r6BW5L
         KFSwG/f1vRCNHovUODXMUVMhzSQ+3NWuvcbOzn46gaRHV7UEPuNjXWgRV3pLSNYQtIoe
         cya/NQMrFKU+F/PM631Jf2/A1+xMxqBwxO0MeJ6+eWPO8W3Tq1TO0XHKXup/VIpqLgfW
         nVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtTLJEmxkngU/xzkXx+LrxeCsOIvLIsQVzHgn6JJ/30=;
        b=ZyLSrGnWQH7+n/Lu33Sl3aHk2p4WONg5+rGq4dezU8FwwClkPlddJtxBMNSH/blMmd
         3As5R8GxYVSj1ISxDHKmfX8AREr0Y9cQc+iY03/NQgCjtnVEhocKMuqoHzN7K5LXrWld
         OalRqohW+KoipH+i7CI/6IOl0mUa9Xp9wm+RDAqovtPBj65UJfpxtUxAC0Rr19ZFmKZI
         U5C6yDhGG37cKnQD4P//vrg+iIjqGoKXRA7wL4p45QXHoJQNabwfWBwQ6qi2vg6q+uLV
         tkgLGF4yMshx69+bqhGgdo5dapzaKX1FN02n9diNSvg89Z3OiSGwKHfTA80ZJtyxz6qs
         5KCg==
X-Gm-Message-State: ACrzQf2K0j48E47NEtAjcuOo6Q/1k8SpQSqcEnNFk98uLO8V10mg5buO
        E1q3Rpr6D19xBxDu9ZwTJGo=
X-Google-Smtp-Source: AMsMyM5llVzvSQnQKDP6QZSuQ5Zyi2qyUSdhaPTRPjvw7/c1QoH9pgMxAEO7uSQNp7a9ikcRbXmHEw==
X-Received: by 2002:a17:906:7944:b0:73c:838:ac3d with SMTP id l4-20020a170906794400b0073c0838ac3dmr9166590ejo.242.1666022563310;
        Mon, 17 Oct 2022 09:02:43 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b0073d5948855asm6389629ejo.1.2022.10.17.09.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:02:42 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 4/7] mm/vmalloc: Use a trace_alloc_vmap_area event
Date:   Mon, 17 Oct 2022 18:02:30 +0200
Message-Id: <20221017160233.16582-7-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221017160233.16582-1-urezki@gmail.com>
References: <20221017160233.16582-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is for debug purpose and is called when an allocation
attempt occurs. This event gives some information about:
- a start address of allocated area;
- a size that is requested;
- an align that is required;
- vstart/vend restriction;
- if an allocation fails.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 83b54beb12fa..f4397817ccd7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -43,6 +43,9 @@
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/vmap.h>
+
 #include "internal.h"
 #include "pgalloc-track.h"
 
@@ -1621,6 +1624,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		size, align, vstart, vend);
 	spin_unlock(&free_vmap_area_lock);
 
+	trace_alloc_vmap_area(addr, size, align, vstart, vend, addr == vend);
+
 	/*
 	 * If an allocation fails, the "vend" address is
 	 * returned. Therefore trigger the overflow path.
-- 
2.30.2

