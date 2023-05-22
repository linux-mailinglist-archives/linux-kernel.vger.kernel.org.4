Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C63A70BB5D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjEVLPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjEVLOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:14:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAB31BD1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-510b869fe0dso10509970a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684753737; x=1687345737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/CF6SD8t4KOzLfI5LisrLifDfr954/t5B1JlATADoU=;
        b=Fi720qzQUzMzlB1l50k0vAlTsjRzBe/cg9qRDCZSutZdUCFmDwXU1qWUWjnhF6C+YJ
         IYmwGB/dBSBFcf+4n8lnS3JuELxCnqx/5KzHyZvkVrc0zdw6+T1veg4ZmjJxjg9CxrEV
         OKjrPtpIsPfNKe3Tk/UTfUWcUqfmc21TZhwMRhoz1hrlNz5snsaWIbFcpPMBqrvXzw+e
         BjnHOUkDc9QXislazQsjEiQDUHPub3bFS8PaRZShQXGb/Yb2GfHmsHP7ed4HMpnWLyiW
         rLbMYl8TEH+ya11TbsE8iAZdu8RNYvaI/k8Wdj555MFh7QE1iHfdGfjD0joUYCDSs+QZ
         4VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753737; x=1687345737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/CF6SD8t4KOzLfI5LisrLifDfr954/t5B1JlATADoU=;
        b=P06ktIl7nPoWMHbVMHWYfM4gVoS5HzGsi/giE8KswU23lAHx/Pvy2VHdQrFT6xck0J
         PzjowFZKY+EbtZJfl/o1RvdjeMqdSHGLs/AGBgSlN8truGcliJHOQnQS60PtQNiF9FEX
         g6g6RI66gcqTnynAsSRw6escN+m6Wvg7bQ/l+MEuEZ+7OSLQEGWgCmkfoGF6ONWf7xxC
         GioUdSGlzO05JDN1cO4DIl8DRTseIKkluw7ktTgfcZEZkB/UHE3No9nL7PIVY95csyiz
         7XBIJB/xUP2jDY1T18Y2pBI8C7sm52YhXKqv4VWsd786sL3wwuPgZU2JT5u3PLB5SdlY
         eMMg==
X-Gm-Message-State: AC+VfDz4ccvktdKc6aTgl75rt56yWjCsD3y2LJDHm4aZv4zvdqKrNiMz
        3jXEgihcde3bll9Bt6z6Jro=
X-Google-Smtp-Source: ACHHUZ4+1Ulvc5fCkI/Ge8lzhIjdkOo8SAA6ig4yBJZkl0gY7cfCTg6POEY2/5MBo0jvvQfpKEnDTQ==
X-Received: by 2002:a17:907:8a12:b0:93e:fa12:aa1a with SMTP id sc18-20020a1709078a1200b0093efa12aa1amr10143550ejc.1.1684753736842;
        Mon, 22 May 2023 04:08:56 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id lx19-20020a170906af1300b0094f07545d40sm2949453ejb.220.2023.05.22.04.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 04:08:56 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 6/9] mm: vmalloc: Support multiple zones in vmallocinfo
Date:   Mon, 22 May 2023 13:08:46 +0200
Message-Id: <20230522110849.2921-7-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522110849.2921-1-urezki@gmail.com>
References: <20230522110849.2921-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A global vmap area busy tree has been removed and replaced by
multiple per-cpu trees/lists, therefore we need to traversal
all per-cpu busy-lists in order to dump all allocated objects.

Please note, after this patch, dumped addresses of allocated
areas are not sequential. See an example below:

  0   1   2   0   1   2
|---|---|---|---|---|---|-> vmap space

There 3 CPUs dumping is done per-CPU zone, as you can see
address of zone_0 can be ahead of addresses residing in the
zone_1 or zone_2.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 90 ++++++++++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a9170fe19909..dd83deb5ef4f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4159,26 +4159,18 @@ bool vmalloc_dump_obj(void *object)
 
 #ifdef CONFIG_PROC_FS
 static void *s_start(struct seq_file *m, loff_t *pos)
-	__acquires(&vmap_purge_lock)
-	__acquires(&fbl(&per_cpu(cpu_vmap_zone, 0), BUSY, lock))
 {
-	mutex_lock(&vmap_purge_lock);
-	fbl_lock((&per_cpu(cpu_vmap_zone, 0)), BUSY);
-
-	return seq_list_start(&fbl_head((&per_cpu(cpu_vmap_zone, 0)), BUSY), *pos);
+	return *pos < 1 ? (void *)1 : NULL;
 }
 
 static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 {
-	return seq_list_next(p, &fbl_head((&per_cpu(cpu_vmap_zone, 0)), BUSY), pos);
+	++*pos;
+	return NULL;
 }
 
 static void s_stop(struct seq_file *m, void *p)
-	__releases(&fbl(&per_cpu(cpu_vmap_zone, 0), BUSY, lock))
-	__releases(&vmap_purge_lock)
 {
-	fbl_unlock((&per_cpu(cpu_vmap_zone, 0)), BUSY);
-	mutex_unlock(&vmap_purge_lock);
 }
 
 static void show_numa_info(struct seq_file *m, struct vm_struct *v)
@@ -4209,6 +4201,7 @@ static void show_purge_info(struct seq_file *m)
 {
 	struct vmap_area *va;
 
+	mutex_lock(&vmap_purge_lock);
 	spin_lock(&purge_vmap_area_lock);
 	list_for_each_entry(va, &purge_vmap_area_list, list) {
 		seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
@@ -4216,65 +4209,72 @@ static void show_purge_info(struct seq_file *m)
 			va->va_end - va->va_start);
 	}
 	spin_unlock(&purge_vmap_area_lock);
+	mutex_unlock(&vmap_purge_lock);
 }
 
 static int s_show(struct seq_file *m, void *p)
 {
+	struct cpu_vmap_zone *z;
 	struct vmap_area *va;
 	struct vm_struct *v;
+	int i;
 
-	va = list_entry(p, struct vmap_area, list);
+	for_each_possible_cpu(i) {
+		z = per_cpu_ptr(&cpu_vmap_zone, i);
 
-	if (!va->vm) {
-		if (va->flags & VMAP_RAM)
-			seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
-				(void *)va->va_start, (void *)va->va_end,
-				va->va_end - va->va_start);
+		fbl_lock(z, BUSY);
+		list_for_each_entry(va, &fbl_head(z, BUSY), list) {
+			if (!va->vm) {
+				if (va->flags & VMAP_RAM)
+					seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
+						(void *)va->va_start, (void *)va->va_end,
+						va->va_end - va->va_start);
 
-		goto final;
-	}
+				continue;
+			}
 
-	v = va->vm;
+			v = va->vm;
 
-	seq_printf(m, "0x%pK-0x%pK %7ld",
-		v->addr, v->addr + v->size, v->size);
+			seq_printf(m, "0x%pK-0x%pK %7ld",
+			   v->addr, v->addr + v->size, v->size);
 
-	if (v->caller)
-		seq_printf(m, " %pS", v->caller);
+			if (v->caller)
+				seq_printf(m, " %pS", v->caller);
 
-	if (v->nr_pages)
-		seq_printf(m, " pages=%d", v->nr_pages);
+			if (v->nr_pages)
+				seq_printf(m, " pages=%d", v->nr_pages);
 
-	if (v->phys_addr)
-		seq_printf(m, " phys=%pa", &v->phys_addr);
+			if (v->phys_addr)
+				seq_printf(m, " phys=%pa", &v->phys_addr);
 
-	if (v->flags & VM_IOREMAP)
-		seq_puts(m, " ioremap");
+			if (v->flags & VM_IOREMAP)
+				seq_puts(m, " ioremap");
 
-	if (v->flags & VM_ALLOC)
-		seq_puts(m, " vmalloc");
+			if (v->flags & VM_ALLOC)
+				seq_puts(m, " vmalloc");
 
-	if (v->flags & VM_MAP)
-		seq_puts(m, " vmap");
+			if (v->flags & VM_MAP)
+				seq_puts(m, " vmap");
 
-	if (v->flags & VM_USERMAP)
-		seq_puts(m, " user");
+			if (v->flags & VM_USERMAP)
+				seq_puts(m, " user");
 
-	if (v->flags & VM_DMA_COHERENT)
-		seq_puts(m, " dma-coherent");
+			if (v->flags & VM_DMA_COHERENT)
+				seq_puts(m, " dma-coherent");
 
-	if (is_vmalloc_addr(v->pages))
-		seq_puts(m, " vpages");
+			if (is_vmalloc_addr(v->pages))
+				seq_puts(m, " vpages");
 
-	show_numa_info(m, v);
-	seq_putc(m, '\n');
+			show_numa_info(m, v);
+			seq_putc(m, '\n');
+		}
+		fbl_unlock(z, BUSY);
+	}
 
 	/*
 	 * As a final step, dump "unpurged" areas.
 	 */
-final:
-	if (list_is_last(&va->list, &fbl_head((&per_cpu(cpu_vmap_zone, 0)), BUSY)))
-		show_purge_info(m);
+	show_purge_info(m);
 
 	return 0;
 }
-- 
2.30.2

