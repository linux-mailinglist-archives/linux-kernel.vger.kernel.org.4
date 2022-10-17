Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0828C601324
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiJQQDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiJQQCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:02:49 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA00E6DF9E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g27so16706486edf.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOp5dHui2KUwGT+5eQKWENO5yt6uGWyvR1ThU0hKA/E=;
        b=Ulbrgh28jEV/lGImNotOj9dffdC1RexllUrzQaQtpYYjk7xh8ATZSDn4NWtmsJt0ZG
         L73QhepRAssyp6RC7D07MffAXYOQ6aVWvUSjuDRzoGZSj02VYDKPTjCzkh6i18nN1S79
         L7QpRUyawMxDKpBZE+EZFq3gbtIJy/09N7IDTzjQj2ssVDNX/Nns6sjjKpp9rVm6Ld2K
         1ja0NXBtDjJNNqwGmxe6jNfJEnMmWUlNqfeHUYC7EfwYpiDF4cIBdRfRcDorDeV0E9ee
         zyhN1bEHhf2HFW9uBFX3HsvtRnw/GtNW3pfTPt+hsL1MermAd/NKWCbLu6XTMiSysmW4
         gPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOp5dHui2KUwGT+5eQKWENO5yt6uGWyvR1ThU0hKA/E=;
        b=7wzy6RjjTgH+ZZRtfScQllr8WUMVYGgeJQ0c/dFztKQnR/S8Gf5q3gt2e/srB2aKNY
         kfSNnsP5zjqDQxGaQN9KqU25ZCRQb07cX8hFtULHEXXOpVMgSFs6uK0ho6mcTufSJsbE
         0y9FyCSvC2a57mIz/Dsr9LFQ6vGl4BWVmuyiRltQ9fCoA71O6UMhs9j8bp/acJQI90UQ
         Vo99/TnFLVi3AfrTGitTCDqBNfFdC30dhgYxAHmDag4/Nh3U2G1DUQqGR/Xq+egbadNK
         rw2ZWbmRg1uED0LeBV5ZHT2KoDCvcC7Os8mqHJcveZZU7+p9dpUwAnl11XdkB8nS3qvQ
         bGgQ==
X-Gm-Message-State: ACrzQf2Tx6pj4fC1Ot+XaGxD77aIxu+2xLs3lTKTu/RRNtoFK0VX2WUN
        P1/XpiNg87Oxdu1eOCJQLUs=
X-Google-Smtp-Source: AMsMyM6daThHHLSBrhl7j4Z6yU0za+Zqoyp1UULFUGi/BMDqzG/RFwI65BX/Rd+wyTS6JUWQcB6ACQ==
X-Received: by 2002:a50:fe0a:0:b0:458:dce8:2b6b with SMTP id f10-20020a50fe0a000000b00458dce82b6bmr10732740edt.84.1666022566397;
        Mon, 17 Oct 2022 09:02:46 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b0073d5948855asm6389629ejo.1.2022.10.17.09.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:02:45 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 7/7] vmalloc: Add reviewers for vmalloc code
Date:   Mon, 17 Oct 2022 18:02:33 +0200
Message-Id: <20221017160233.16582-10-urezki@gmail.com>
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

Add myself and Christoph Hellwig as reviewers for vmalloc.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 MAINTAINERS | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 568ad7c5eeb6..a6f4e11755e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13289,10 +13289,20 @@ F:	include/linux/memory_hotplug.h
 F:	include/linux/mm.h
 F:	include/linux/mmzone.h
 F:	include/linux/pagewalk.h
-F:	include/linux/vmalloc.h
 F:	mm/
 F:	tools/testing/selftests/vm/
 
+VMALLOC
+M:	Andrew Morton <akpm@linux-foundation.org>
+R:	Uladzislau Rezki <urezki@gmail.com>
+R:	Christoph Hellwig <hch@infradead.org>
+L:	linux-mm@kvack.org
+S:	Maintained
+W:	http://www.linux-mm.org
+T:	git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	mm/vmalloc.c
+F:	include/linux/vmalloc.h
+
 MEMORY HOT(UN)PLUG
 M:	David Hildenbrand <david@redhat.com>
 M:	Oscar Salvador <osalvador@suse.de>
-- 
2.30.2

