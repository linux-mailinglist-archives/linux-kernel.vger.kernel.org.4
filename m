Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C6F603209
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJRSLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiJRSLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:11:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F5A72FEC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:11:02 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id d26so34246229eje.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAJWBA/OARebIHwOWWIUrI8OsApEiB0+kqbjGVUJums=;
        b=HvkyVCyohI92aQ42AIyvAmRtEfrXjp3pdtcMqXO4f1kiXF3JRKo6/+ClnJLEJc1Q2j
         K7WRrHtKlCnYcQgAQY1/2RMQ4v13NmnVELOdn28A4n6N7QTDJP/7yOG85liAJgGQdGg/
         O+Ve4jEHCwMyPOWikF0Sw9vsqnh3Ulsi7gfS5owk+S6P902sb28WHA+7IP60laDr6cOn
         j9JdxHesbeQt4mS+XVtD0VCZEiuDGk64otVXpr3u1cYUDewim+CyLnSDJdAUZ73WQIKg
         x5bjSJchsWWNoqqH2RFIatAQkN5dBhRtuHJOkSPQKQeyOfdMqZPeHVcpCYju4pGP+Hy+
         niow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAJWBA/OARebIHwOWWIUrI8OsApEiB0+kqbjGVUJums=;
        b=bncn5+Pi7syBqWgSpTseURkIBNVcXC7JFtNYkWPw2g9Vq5jYYKuFPVd4ybe/ph9/nc
         gYYidvvGxJISJyCk1m721itofCi8YSlgm9jV7d1wDBlRTQwda8xXoEEeMTbY8k5U98zH
         hlkBrbPO7+d7iX+35oD2nGV1xzsGMrX9OIKlCxSELNjFLaD16b8iFroiZUYJ1XeErnDI
         TZtESaTYtrezHEvAml/uDpOlFh3m1VeIybLUrdijgL7yxSepYaMjsy1s412T3e17z5uc
         KjjKGCgfFtERgVgvJBtmQX7rw2jITedGT4JHwhaa6+9YgUvoP9+T2/Kgw4XO0kRdnaAu
         Rfqg==
X-Gm-Message-State: ACrzQf1kGpKq7mAMAPKHHKu0duIJ6MsSpyB0XEwTuUdWQNPaqtIqM0j4
        ahQNtscInJEcfKTOoNGHb88=
X-Google-Smtp-Source: AMsMyM6m69A/S4DEPbsi+ZnkiCQ3JicwD+7InxxliYmIyXlzonVAsFkR6XtzF1+gbfMOqzFtQptv9g==
X-Received: by 2002:a17:906:328c:b0:780:7574:ced2 with SMTP id 12-20020a170906328c00b007807574ced2mr3541108ejw.634.1666116660657;
        Tue, 18 Oct 2022 11:11:00 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b007877ad05b32sm7739302ejf.208.2022.10.18.11.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:11:00 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 4/7] mm: vmalloc: Use trace_alloc_vmap_area event
Date:   Tue, 18 Oct 2022 20:10:50 +0200
Message-Id: <20221018181053.434508-5-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221018181053.434508-1-urezki@gmail.com>
References: <20221018181053.434508-1-urezki@gmail.com>
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

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 83b54beb12fa..aa86f21bfad0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -43,6 +43,9 @@
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/vmalloc.h>
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

