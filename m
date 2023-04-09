Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBF06DC0E2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 19:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjDIRjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 13:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDIRjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 13:39:33 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8277F3A80
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 10:39:31 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id m41-20020a05600c3b2900b003ee502f1b16so789210wms.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 10:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681061970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=De3yesDVMfZEEX8OSfiP+nxqpbJaFt7gWopDp+wvT80=;
        b=n2P08bz+Zn6zuZeJeAYcB9us2RwDjKLWuqq9olRcT/P4+HgdfbljjRcT8TEseuJfzJ
         dmrzskfn8CvJUFFs6bs3bpN7QT+8E0hncJo0qiOfvIOJkSYu99ez5+Tnhu46VTFJoREw
         VzrWW7DhQDq/tBhF2E32lI315MHLrZ/m/UhKa/D/vkmCWfwRfxFqNQ3wpBCmmhxDRXbK
         ib4tDwp75vWDQbmfLtmOxA57GdJ6PmnOUSzNCo0QNJJwENYnQlw3VkziCYnZoazff+Hg
         c6iGA7huQ0ne9zNe7X93cX/06ssdHQh5RRbdBAztwZGojrdIhprDgqJPcHD4qDJIG0nC
         zeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681061970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=De3yesDVMfZEEX8OSfiP+nxqpbJaFt7gWopDp+wvT80=;
        b=O/1Zqr+fKmCGZoMCmQaznwGywTy3lzNmzdef5wqYoG9NJ2e7AKdXpqPODS/6Tu1jOb
         JdATm7MSaAA1bdT3Dw0Y9DAFAvp0SgqXRr1VbaF7Sc4iBlnp9nEmDmp7GzOdof6zxGVM
         43Ps09hI8gjUpscr01YzEwMgGxTGXLUjoC1JrLNt48en8nMNKho6qKrg34HupxO3Gwb4
         nVMRxSyzNXO/nYfRbBFKP/BHmSfNm3t+3bczbcV6fkSSwcZ0GWA8JnR5vR7iM+i+Vd6H
         QcWNQpM8ZuwpgPaNQ7HNoI9dSwpfcPyPPvkbaRD0GLq/bsS9oD/7mU56kj/zxSOBZl/K
         l+pw==
X-Gm-Message-State: AAQBX9d4aWpCdZWmEQAKOo5/zG5XOH/4RoP2PQ+7+Z8zQPj9iua+hyX0
        P1f0MYeSqB6qNMMnILeMmcnAk3Z44h9er5uw
X-Google-Smtp-Source: AKy350YehyT3x+m7sJB1ykjffyiqkMQJHtEHpSQmmWnaKfsx6Nk5MvJAqQbL7y60ZkGcu8HuhsSwDbFO6cQHQdzY
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a7b:c7d4:0:b0:3ed:abb9:751e with SMTP
 id z20-20020a7bc7d4000000b003edabb9751emr1614435wmk.5.1681061970206; Sun, 09
 Apr 2023 10:39:30 -0700 (PDT)
Date:   Sun,  9 Apr 2023 18:39:22 +0100
In-Reply-To: <20230409173923.1822455-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20230409173923.1822455-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230409173923.1822455-2-vdonnefort@google.com>
Subject: [PATCH v3 1/2] ring-buffer: Introducing ring-buffer mapping functions
From:   Vincent Donnefort <vdonnefort@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing the user-space to map a ring-buffer, add
a set of mapping functions:

  ring_buffer_{map,unmap}()
  ring_buffer_map_fault()

And controls on the ring-buffer:

  ring_buffer_get_reader_page()  /* swap reader and head */

Mapping the ring-buffer also involves:

  A unique ID for each page of the ring-buffer, as currently the pages
  are only identified through their in-kernel VA.

  A meta-page, where are stored statistics about the ring-buffer and
  a page IDs list, ordered. A field gives what page is the reader
  one and one to gives where the ring-buffer starts in the list of data
  pages.

The linear mapping exposes the meta-page, and each page of the
ring-buffer, ordered following their unique ID, assigned during the
first mapping.

Once mapped, no page can get in or out of the ring-buffer: the buffer
size will remain unmodified and the splice enabling functions will in
reality simply memcpy the data instead of swapping pages.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 782e14f62201..5b3563507842 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -6,6 +6,8 @@
 #include <linux/seq_file.h>
 #include <linux/poll.h>
 
+#include <uapi/linux/trace_mmap.h>
+
 struct trace_buffer;
 struct ring_buffer_iter;
 
@@ -211,4 +213,9 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
 #define trace_rb_cpu_prepare	NULL
 #endif
 
+int ring_buffer_map(struct trace_buffer *buffer, int cpu);
+int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
+struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
+				   unsigned long pgoff);
+int ring_buffer_get_reader_page(struct trace_buffer *buffer, int cpu);
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
new file mode 100644
index 000000000000..b89e0c8562b5
--- /dev/null
+++ b/include/uapi/linux/trace_mmap.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_TRACE_MMAP_H_
+#define _UAPI_TRACE_MMAP_H_
+
+#include <asm/bitsperlong.h>
+
+#include <linux/types.h>
+
+struct ring_buffer_meta_header {
+#if __BITS_PER_LONG == 64
+	__u64	entries;
+	__u64	overrun;
+#else
+	__u32	entries;
+	__u32	overrun;
+#endif
+	__u32	pages_touched;
+	__u32	meta_page_size;
+	__u32	nr_data_pages;	/* Number of pages in the ring-buffer */
+	__u32	reader_page;	/* Reader page ID, from 0 to nr_data_pages - 1 */
+	__u32	read;		/* Number of bytes read on the current reader page */
+};
+
+#endif /* _UAPI_TRACE_MMAP_H_ */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index af50d931b020..529702af7615 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -332,6 +332,7 @@ struct buffer_page {
 	local_t		 entries;	/* entries on this page */
 	unsigned long	 real_end;	/* real end of data */
 	struct buffer_data_page *page;	/* Actual data page */
+	u32		 id;		/* ID for external mapping */
 };
 
 /*
@@ -529,6 +530,12 @@ struct ring_buffer_per_cpu {
 	rb_time_t			before_stamp;
 	u64				event_stamp[MAX_NEST];
 	u64				read_stamp;
+
+	int				mapped;
+	struct mutex			mapping_lock;
+	unsigned long			*page_ids;	/* ID to addr */
+	struct ring_buffer_meta_header	*meta_page;
+
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -1567,6 +1574,13 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 		/* Again, either we update tail_page or an interrupt does */
 		(void)cmpxchg(&cpu_buffer->tail_page, tail_page, next_page);
 	}
+
+	if (READ_ONCE(cpu_buffer->mapped)) {
+		/* Ensure the meta_page is ready */
+		smp_rmb();
+		WRITE_ONCE(cpu_buffer->meta_page->pages_touched,
+			   local_read(&cpu_buffer->pages_touched));
+	}
 }
 
 static int rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
@@ -1735,6 +1749,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
+	mutex_init(&cpu_buffer->mapping_lock);
 
 	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 			    GFP_KERNEL, cpu_to_node(cpu));
@@ -2173,7 +2188,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 	/* prevent another thread from changing buffer sizes */
 	mutex_lock(&buffer->mutex);
 
-
 	if (cpu_id == RING_BUFFER_ALL_CPUS) {
 		/*
 		 * Don't succeed if resizing is disabled, as a reader might be
@@ -2523,6 +2537,13 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 		local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
 		local_inc(&cpu_buffer->pages_lost);
 
+		if (READ_ONCE(cpu_buffer->mapped)) {
+			/* Ensure the meta_page is ready */
+			smp_rmb();
+			WRITE_ONCE(cpu_buffer->meta_page->overrun,
+				   local_read(&cpu_buffer->overrun));
+		}
+
 		/*
 		 * The entries will be zeroed out when we move the
 		 * tail page.
@@ -3179,6 +3200,14 @@ static inline void rb_event_discard(struct ring_buffer_event *event)
 static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	local_inc(&cpu_buffer->entries);
+
+	if (READ_ONCE(cpu_buffer->mapped)) {
+		/* Ensure the meta_page is ready */
+		smp_rmb();
+		WRITE_ONCE(cpu_buffer->meta_page->entries,
+			   local_read(&cpu_buffer->entries));
+	}
+
 	rb_end_commit(cpu_buffer);
 }
 
@@ -3482,7 +3511,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 		return;
 
 	/*
-	 * If this interrupted another event, 
+	 * If this interrupted another event,
 	 */
 	if (atomic_inc_return(this_cpu_ptr(&checking)) != 1)
 		goto out;
@@ -4651,6 +4680,11 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->reader_page = reader;
 	cpu_buffer->reader_page->read = 0;
 
+	if (cpu_buffer->mapped) {
+		WRITE_ONCE(cpu_buffer->meta_page->read, 0);
+		WRITE_ONCE(cpu_buffer->meta_page->reader_page, reader->id);
+	}
+
 	if (overwrite != cpu_buffer->last_overrun) {
 		cpu_buffer->lost_events = overwrite - cpu_buffer->last_overrun;
 		cpu_buffer->last_overrun = overwrite;
@@ -4717,6 +4751,10 @@ static void rb_advance_reader(struct ring_buffer_per_cpu *cpu_buffer)
 
 	length = rb_event_length(event);
 	cpu_buffer->reader_page->read += length;
+
+	if (cpu_buffer->mapped)
+		WRITE_ONCE(cpu_buffer->meta_page->read,
+			   cpu_buffer->reader_page->read);
 }
 
 static void rb_advance_iter(struct ring_buffer_iter *iter)
@@ -5285,6 +5323,13 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->lost_events = 0;
 	cpu_buffer->last_overrun = 0;
 
+	if (cpu_buffer->mapped) {
+		WRITE_ONCE(cpu_buffer->meta_page->entries, 0);
+		WRITE_ONCE(cpu_buffer->meta_page->pages_touched, 0);
+		WRITE_ONCE(cpu_buffer->meta_page->overrun, 0);
+		WRITE_ONCE(cpu_buffer->meta_page->read, 0);
+	}
+
 	rb_head_page_activate(cpu_buffer);
 }
 
@@ -5489,6 +5534,11 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	cpu_buffer_a = buffer_a->buffers[cpu];
 	cpu_buffer_b = buffer_b->buffers[cpu];
 
+	if (READ_ONCE(cpu_buffer_a->mapped) || READ_ONCE(cpu_buffer_b->mapped)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* At least make sure the two buffers are somewhat the same */
 	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
 		goto out;
@@ -5722,7 +5772,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 * Otherwise, we can simply swap the page with the one passed in.
 	 */
 	if (read || (len < (commit - read)) ||
-	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
+	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
+	    cpu_buffer->mapped) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -5839,6 +5890,251 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_page);
 
+static void rb_free_page_ids(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	int i;
+
+	for (i = 0; i < cpu_buffer->nr_pages + 1; i++)
+		virt_to_page(cpu_buffer->page_ids[i])->mapping = NULL;
+
+	kfree(cpu_buffer->page_ids);
+	cpu_buffer->page_ids = NULL;
+}
+
+static int rb_alloc_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	if (cpu_buffer->meta_page)
+		return 0;
+
+	cpu_buffer->meta_page = page_to_virt(alloc_page(GFP_USER));
+	if (!cpu_buffer->meta_page)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	unsigned long addr = (unsigned long)cpu_buffer->meta_page;
+
+	virt_to_page(addr)->mapping = NULL;
+	free_page(addr);
+	cpu_buffer->meta_page = NULL;
+}
+
+static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
+				   unsigned long *page_ids)
+{
+	struct ring_buffer_meta_header *meta = cpu_buffer->meta_page;
+	unsigned int nr_data_pages = cpu_buffer->nr_pages + 1;
+	struct buffer_page *first_page, *bpage;
+	int id = 0;
+
+	page_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
+	cpu_buffer->reader_page->id = id++;
+
+	first_page = bpage = rb_set_head_page(cpu_buffer);
+	do {
+		if (id >= nr_data_pages) {
+			WARN_ON(1);
+			break;
+		}
+
+		page_ids[id] = (unsigned long)bpage->page;
+		bpage->id = id;
+
+		rb_inc_page(&bpage);
+		id++;
+	} while (bpage != first_page);
+
+	/* install page ID to kern VA translation */
+	cpu_buffer->page_ids = page_ids;
+
+	meta->entries = 0;
+	meta->overrun = 0;
+	meta->pages_touched = 0;
+	meta->meta_page_size = PAGE_SIZE;
+	meta->nr_data_pages = nr_data_pages;
+	meta->reader_page = cpu_buffer->reader_page->id;
+	meta->read = cpu_buffer->reader_page->read;
+}
+
+static inline struct ring_buffer_per_cpu *
+rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return ERR_PTR(-EINVAL);
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	mutex_lock(&cpu_buffer->mapping_lock);
+
+	if (!cpu_buffer->mapped) {
+		mutex_unlock(&cpu_buffer->mapping_lock);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return cpu_buffer;
+}
+
+static inline void rb_put_mapped_buffer(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	mutex_unlock(&cpu_buffer->mapping_lock);
+}
+
+int ring_buffer_map(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned long flags, *page_ids;
+	int err = 0;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return -EINVAL;
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	mutex_lock(&cpu_buffer->mapping_lock);
+
+	if (cpu_buffer->mapped) {
+		WRITE_ONCE(cpu_buffer->mapped, cpu_buffer->mapped + 1);
+		goto unlock;
+	}
+
+	/* prevent another thread from changing buffer sizes */
+	mutex_lock(&buffer->mutex);
+	atomic_inc(&cpu_buffer->resize_disabled);
+	mutex_unlock(&buffer->mutex);
+
+	err = rb_alloc_meta_page(cpu_buffer);
+	if (err) {
+		atomic_dec(&cpu_buffer->resize_disabled);
+		goto unlock;
+	}
+
+	/* page_ids include the reader page while nr_pages does not */
+	page_ids = kzalloc(sizeof(*page_ids) * (cpu_buffer->nr_pages + 1),
+			   GFP_KERNEL);
+	if (!page_ids) {
+		rb_free_meta_page(cpu_buffer);
+		atomic_dec(&cpu_buffer->resize_disabled);
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	/*
+	 * Lock all readers to block any page swap until the page IDs are
+	 * assigned.
+	 */
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+	rb_setup_ids_meta_page(cpu_buffer, page_ids);
+	/*
+	 * Ensure the writer will observe the meta-page before
+	 * cpu_buffer->mapped.
+	 */
+	smp_wmb();
+	WRITE_ONCE(cpu_buffer->mapped, 1);
+
+	/* Init meta_page values unless the writer did it already */
+	cmpxchg(&cpu_buffer->meta_page->entries, 0,
+		local_read(&cpu_buffer->entries));
+	cmpxchg(&cpu_buffer->meta_page->overrun, 0,
+		local_read(&cpu_buffer->overrun));
+	cmpxchg(&cpu_buffer->meta_page->pages_touched, 0,
+		local_read(&cpu_buffer->pages_touched));
+
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+unlock:
+	mutex_unlock(&cpu_buffer->mapping_lock);
+
+	return err;
+}
+
+int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	int err = 0;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return -EINVAL;
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	mutex_lock(&cpu_buffer->mapping_lock);
+
+	if (!cpu_buffer->mapped) {
+		err = -ENODEV;
+		goto unlock;
+	}
+
+	WRITE_ONCE(cpu_buffer->mapped, cpu_buffer->mapped - 1);
+	if (!cpu_buffer->mapped) {
+		/* Wait the writer and readers to observe !mapped */
+		synchronize_rcu();
+
+		rb_free_page_ids(cpu_buffer);
+		rb_free_meta_page(cpu_buffer);
+		atomic_dec(&cpu_buffer->resize_disabled);
+	}
+
+unlock:
+	mutex_unlock(&cpu_buffer->mapping_lock);
+
+	return err;
+}
+
+/*
+ *   +--------------+
+ *   |   meta page  |  pgoff=0
+ *   +--------------+
+ *   |  data page1  |  page_ids=0
+ *   +--------------+
+ *   |  data page2  |  page_ids=1
+ *         ...
+ */
+struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
+				   unsigned long pgoff)
+{
+	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
+
+	if (!pgoff)
+		return virt_to_page((void *)cpu_buffer->meta_page);
+
+	pgoff--;
+	if (pgoff > cpu_buffer->nr_pages)
+		return NULL;
+
+	return virt_to_page(cpu_buffer->page_ids[pgoff]);
+}
+
+int ring_buffer_get_reader_page(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned long flags;
+
+	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
+	if (IS_ERR(cpu_buffer))
+		return (int)PTR_ERR(cpu_buffer);
+
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	if (!rb_per_cpu_empty(cpu_buffer)) {
+		unsigned int reader_size;
+
+		WARN_ON(!rb_get_reader_page(cpu_buffer));
+
+		reader_size = rb_page_size(cpu_buffer->reader_page);
+		cpu_buffer->reader_page->read = reader_size;
+		cpu_buffer->meta_page->read = reader_size;
+	}
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+
+	rb_put_mapped_buffer(cpu_buffer);
+
+	return 0;
+}
+
 /*
  * We only allocate new buffers, never free them if the CPU goes down.
  * If we were to free the buffer, then the user would lose any trace that was in
-- 
2.40.0.577.gac1e443424-goog

