Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B795870BB57
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjEVLOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjEVLN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:13:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8DE1BCF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-970028cfb6cso94840866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684753735; x=1687345735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvsDwavnfIYng0FXX5ciX4/rx3a5CWQd4rOb3eMOJOg=;
        b=iDb9tK4TOgaJNMq61xrRvzxoVUaPP0VvNEnz6NrY+zacf0FfJnwnuypFPmwH5SLNBS
         GyEOPDWFsssngIu4YWW0FrNovP9ZjqfzkUf/51MOpeMHMX80L0GnQUdqQZEtrUUDgAN5
         CqpASsjwkoQ7U63fy74gThmTbQvI9Ie3XaHwC17zsSXEk9lHt40AkqJDIcGVhr55gFza
         Ab5qRCRkiZfB7QM1qkbc7/2z6/RGesk6zCBFvjSfwFLXPP4gxqH+BsOk1j0UanBK1aWA
         e+0Ct1vWALCAGVP46sp1nfM2tzxvrxxrGXz0I5hY5eIN0kmUd5nEpcG0c3MTS3rmdd8s
         WEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753735; x=1687345735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvsDwavnfIYng0FXX5ciX4/rx3a5CWQd4rOb3eMOJOg=;
        b=EkECDYmO1cmq7RrmSSdvaPq3iu2YuN+IjQuaqMIMMVcYC+lSqik1QlC5sPR38AcuO6
         DQrzdJd4a54m3R0mgdtdVUPfn+jNCGU9NycSiqrvRhOBYLNx7qlkQx+9VXvGpCIx4B98
         ty0jwlBP/GlTafI5uWnwUnccsiRH/UEifmAGfFoRjQ2ber3v67U4UZH3o5cU/O1LKF5l
         paS7n7986s07d/iY+z+BZvnz3DhvtsxJFK4nZMtKOh8QuFxKX2EXeh7i+/tWkQfBOtyO
         9k6YWlDDaw8Raycf4+6tpptpcCsTaQa3q4Daxrax/BlNrr6i4BDvd7n5QzNgNb/IxubQ
         opzA==
X-Gm-Message-State: AC+VfDzSUYRIkfJHKrTOwqVlv9l8HE/NZIF+e41P6gNgUnwYhknaeaew
        Bp1wP6ZvVIm6Xf2jQ1uJMX8=
X-Google-Smtp-Source: ACHHUZ5RSuVJjDArE0w69xzADXBpvX8mfpX9Veg7DqUbJpCMdvLgHaYw03z8mFT9WRUtE0g9JS1nlg==
X-Received: by 2002:a17:907:2d0e:b0:96f:cde5:5f5e with SMTP id gs14-20020a1709072d0e00b0096fcde55f5emr3930140ejc.29.1684753735155;
        Mon, 22 May 2023 04:08:55 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id lx19-20020a170906af1300b0094f07545d40sm2949453ejb.220.2023.05.22.04.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 04:08:54 -0700 (PDT)
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
Subject: [PATCH 4/9] mm: vmalloc: Add a per-CPU-zone infrastructure
Date:   Mon, 22 May 2023 13:08:44 +0200
Message-Id: <20230522110849.2921-5-urezki@gmail.com>
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

Introduce a basic skeleton that defines a cache entity for
a CPU. It consist of bookkeeping data which belong to a CPU
zone. A CPU-zone defines a virtual address range with its
fixed size.

This approach gives a possibility to map any address to a
particular CPU-zone it belongs to. Below is a high-level
description how it is used in alloc and free paths:

alloc-path:
 in-front-pre-fetch occurs if a cache is empty. A chunk is
 placed to a free-tree of this CPU. Finally this CPU cache
 is clipped in order to accomplish a request. A fresh VA
 resides in a busy-tree of specific CPU-zone it is bound
 to.

free-path:
 va->va_start is converted to a zone, so a lookup occurs in
 a bookkeeping zone it belongs to. Once it gets removed a VA
 is moved to a lazy-tree. It is freed after a TLB flushing.

A "cvz_size", that reflects a zone size, is set to ULONG_MAX
by this patch. The reason is we would like to follow an old
behavior until all dependent changes are in place.

There is no a functional change as a result of this patch.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 19dcffb0d563..f6da2590b4de 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -773,6 +773,61 @@ static struct rb_root free_vmap_area_root = RB_ROOT;
  */
 static DEFINE_PER_CPU(struct vmap_area *, ne_fit_preload_node);
 
+/*
+ * A per-cpu effective vmap cache logic. It allows to pre-fetch
+ * a memory vmap chunk with a specified size. A bookkeeping data
+ * is stored and accessed per-CPU.
+ */
+enum { FREE = 0, BUSY, LAZY, NFBL };
+
+#define fbl(z, i, m) z->fbl[i].m
+#define fbl_root(z, i) fbl(z, i, root)
+#define fbl_head(z, i) fbl(z, i, head)
+
+#define fbl_lock(z, i) spin_lock(&fbl(z, i, lock))
+#define fbl_unlock(z, i) spin_unlock(&fbl(z, i, lock))
+
+struct cpu_vmap_zone {
+	/*
+	 * FREE, BUSY, LAZY bookkeeping data of this CPU zone.
+	 */
+	struct {
+		struct rb_root root;
+		struct list_head head;
+		spinlock_t lock;
+	} fbl[NFBL];
+
+	/*
+	 * A list of outstanding lazily-freed areas, ready to
+	 * be drained, which belong(address space) to this CPU
+	 * zone.
+	 */
+	struct list_head purge_list;
+
+	/*
+	 * It controls that only one CPU can pre-fetch this
+	 * CPU zone.
+	 */
+	atomic_t fill_in_progress;
+};
+
+static DEFINE_PER_CPU(struct cpu_vmap_zone, cpu_vmap_zone);
+
+/* Disable a per-cpu caching. */
+static __read_mostly unsigned long cvz_size = ULONG_MAX;
+
+static inline unsigned int
+addr_to_cpu(unsigned long addr)
+{
+	return (addr / cvz_size) % num_possible_cpus();
+}
+
+static inline struct cpu_vmap_zone *
+__maybe_unused addr_to_cvz(unsigned long addr)
+{
+	return &per_cpu(cpu_vmap_zone, addr_to_cpu(addr));
+}
+
 static __always_inline unsigned long
 va_size(struct vmap_area *va)
 {
-- 
2.30.2

