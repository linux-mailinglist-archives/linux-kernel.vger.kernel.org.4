Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66DE653581
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbiLURpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiLURpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:45:02 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7788423BD7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:44:58 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b13so24612236lfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=544etTN2zsLy2RuJnjdxp9kpPg16kDUmBRROWQgCx4I=;
        b=BOkkSj8GfNQTDHhyrFcn0I/nzedv1dEd1KOPyb8qyCjqL4R7Ob9ZtFrGu/Ybe/ewJF
         ZmGXGIDcN8J+NQ1p4qaFZ7gxdg0Wjd0aFZYgWv6CJtKALROMkPC3tvN3e3pPqNQcyGaY
         JU6bOj0Pc1+JwwTIEfO4D9onySWHA1QC/VZumjpFigrfTWmOXO5rpj3xBLPDbADsrfnZ
         QvR9I5coGxquW1LfTsPUpghKJeZpQAk3phKWG367TrGUXdOa7gLvO37kGtsOPA7Zevg6
         YfAE3MXVXednaBs2917MzU6urWoRyKNRqQd1rf7E8Pn6GabfkRi/1T7PFJ8lkNUoAqOG
         xBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=544etTN2zsLy2RuJnjdxp9kpPg16kDUmBRROWQgCx4I=;
        b=mBDM7NTitN7x+GEdRNdptZ9TTqjg8oJ5OV+QdJwN6yF/WH4BYCm68ipwcR1bf27r7+
         HK34j0+V63oeVhStN9s2nFNTJgJSmijsT7SP+nM7yUPHa6K/3NbALdfph3BbrjF1dv5M
         9kQZCxcZoye4RBTd/b9/lb30/wW/c5SW4FVzYfrDeWpOUAEcIoGkXXJ30uyetj02dtW6
         g8Xdu3NBcM6CrNcktxzU3Nw/thvtI7EzF6quarO8zERlqb7ch7HsBhVqstJ7j/b1kyLE
         w2ymygMrlFfSCp42hDBbUl/glKDtCgy1KT9G2TwP8k0iTKN74mHndR24SIn1KgopM/e3
         SEBA==
X-Gm-Message-State: AFqh2krRjTNuBlZ0a0GAwQ+gm68KSMZOwPb6W/Umh56NriRvFT9a/OMY
        QzFKUkQkeTQzgcEz2W92Qt8=
X-Google-Smtp-Source: AMrXdXvH8wAVdlO1kFdpPpNCE8zm69xdiqCJVUw6EzElonJPtrOpsedL6IUbSLLGOH2j29vr4ZWoqA==
X-Received: by 2002:a05:6512:3ca0:b0:4b5:b7c3:8053 with SMTP id h32-20020a0565123ca000b004b5b7c38053mr1021482lfv.42.1671644696863;
        Wed, 21 Dec 2022 09:44:56 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id r18-20020ac252b2000000b004a91d1b3070sm1904915lfm.308.2022.12.21.09.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 09:44:56 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 2/3] mm: vmalloc: Switch to find_unlink_vmap_area() in vm_unmap_ram()
Date:   Wed, 21 Dec 2022 18:44:53 +0100
Message-Id: <20221221174454.1085130-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221221174454.1085130-1-urezki@gmail.com>
References: <20221221174454.1085130-1-urezki@gmail.com>
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

Switch from find_vmap_area() to find_unlink_vmap_area() to prevent
a double access to the vmap_area_lock: one for finding area, second
time is for unlinking from a tree.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 28030d2441f1..17e688cc7357 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2251,7 +2251,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 		return;
 	}
 
-	va = find_vmap_area(addr);
+	va = find_unlink_vmap_area(addr);
 	BUG_ON(!va);
 	debug_check_no_locks_freed((void *)va->va_start,
 				    (va->va_end - va->va_start));
-- 
2.30.2

