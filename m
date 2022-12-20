Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C5B65262E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiLTS1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLTS1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:27:11 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08E1DA59
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:27:09 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 1so19900264lfz.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OTHapwSXF9jX+CGaarNe5ZZYPpmWxQHenWVZbs8G3o=;
        b=P+POCPq/xX3ozKp7CYneD0KUS2lmehapstKWeSkNpMRhLrBW1WEVQ7/tS5iJF1m4pZ
         KcO+9GEU7xFEbOJ06vY3cGqMHtU27p390VWaQtUTHDM/TxZl/TZg4xvcVMa5zY4urd/t
         9cDLt2LQo4MI7gnkmFG1LN9cfILUe9we42b8B9ZFZDmCgPW3lNop1LmqdyjXhhssIT96
         3Cv+6V+T/5FzftgtMASsly9FB/rxLmRgCMaBXVJp2X25lJGK6LyHOjydiVLh43NoMTgI
         Nq0FmwpUNnFi8H3SdTjDyhiFtUMqTAAP0xuI59Xf+i/KE0GUNpLIM2darvcA94yrVhZ+
         x0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OTHapwSXF9jX+CGaarNe5ZZYPpmWxQHenWVZbs8G3o=;
        b=TWTglyIj8F/oiBJH/rTgl+HqkFacXGP/D3cRpwuvTMqdqt/cXmVOvFKttwqtrccQ31
         Z1V9+K2bD0QydJgFoNgR2oZuecjQNFCrHyaYmULe1UgeK8a8XDdeKLtUWJBfA7f6faHF
         n9g9lzbihtWJuFBwwb/1DLM3vh2h3ZYG7lU2ihfzoZ0S4DCbkNXBAJZRzeDYWkkqO2Wk
         TmKNx0fJV8H4CUQSrPemzJcW45VRk5Uz4IAvnF9SzHuR2ZX9LpJ/wH8IwwNmZWWKSY/W
         aGyNe25rWHItbtlb+2ok4rOmjjCkKu3V7GAg4Wq59caNfx1RX5wef1VdDGDVkp/EBqPj
         FbSg==
X-Gm-Message-State: ANoB5pnw8C5aptXweNnBNKIpp3B/L14D1Wq8cG602DNvVoDPP5AU1Cok
        S44EAR4ITOtIg+wl9LRko5g=
X-Google-Smtp-Source: AA0mqf7SXylMWGmBiQaU3+6304aZUwaDM8HyTat6M0HTi0M/QuEGAD29hTD/lsaPdTr4lbhnBafM+w==
X-Received: by 2002:a05:6512:21ca:b0:4b5:1e6c:785c with SMTP id d10-20020a05651221ca00b004b51e6c785cmr13913360lft.34.1671560828057;
        Tue, 20 Dec 2022 10:27:08 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id v17-20020a056512349100b004bc1dd05351sm1538176lfr.206.2022.12.20.10.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:27:07 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 2/2] mm: vmalloc: Replace BUG_ON() by WARN_ON_ONCE()
Date:   Tue, 20 Dec 2022 19:27:04 +0100
Message-Id: <20221220182704.181657-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221220182704.181657-1-urezki@gmail.com>
References: <20221220182704.181657-1-urezki@gmail.com>
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

Currently a vm_unmap_ram() functions triggers a BUG() if an area
is not found. Replace it by the WARN_ON_ONCE() error message and
keep machine alive instead of stopping it.

The worst case is a memory leaking.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0fc38c36e0df..e05a0dc79ac5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2255,10 +2255,12 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 	}
 
 	va = find_unlink_vmap_area(addr);
-	BUG_ON(!va);
-	debug_check_no_locks_freed((void *)va->va_start,
-				    (va->va_end - va->va_start));
-	free_unmap_vmap_area(va);
+
+	if (!WARN_ON_ONCE(!va)) {
+		debug_check_no_locks_freed((void *)va->va_start,
+			(va->va_end - va->va_start));
+		free_unmap_vmap_area(va);
+	}
 }
 EXPORT_SYMBOL(vm_unmap_ram);
 
-- 
2.30.2

