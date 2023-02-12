Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B176937F6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBLPdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBLPdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:33:11 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018FCC167
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 07:33:08 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id ay19-20020a05600c1e1300b003dc54daba42so5008217wmb.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 07:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnvuwkJ3TaNv9//GI4G63WEbKVVNVqAtuFtA55HGiRo=;
        b=SWZkvnVMVjChjhq/70PwpGiaAPT56FVJaS8DfOojNVdAxP4+oQb/goqTI7HNMfiS9H
         H+qOwCQh9TkbRrm8/EGTDY0MyKObpeg9/CwJ+vrRm0rqFgwBddVQPLkBY586Mob3P9rx
         BFiToAHjG6DdXa07Xaa17vpOGjGrFvt7WoFEg4O+vtl2ZdQ15lm66qxe3qts4TaPsVGQ
         8mvZ79ONLG7NbxMQLiB1RmtuFoJfbcwvjSldEiahgXxU8TuV5k3hwlOj6ekOLfpqGIDg
         vm5qfnADR5tQuj8An2bodsC1eNEqOFSmVtLcu+6rWiU9q1GlU9Vq74f1kzW8G6gXkT/c
         Uq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnvuwkJ3TaNv9//GI4G63WEbKVVNVqAtuFtA55HGiRo=;
        b=dPzwTqmMwgl/mImxU2XaYAeTjbDmltZ78aqy18zUxP0Cg7ONXLL8mTijNRxJNGmVm3
         MLOOomQdWO1TJncT7qKlT7WSWj8t4ZJ2D4pAIZk8VNRy86xVX0bUT9Cc/Rj+B65lEj6S
         sKszs58PCGlesPBvYhabVEwrEst8rfg+Qs9cTHyr3fl5qq+L6jwSP7X4wuPOAn3g9fw4
         7pDYo2rVvDEkwqeJfKkk4PUKuVrJbMyi4j3VAJxCV1pS2kdXsD9XLNp2J3PtqUJuJRox
         pFEIIv4LlLj9wsOW5XsVefHrkjSq0coHO6EvuhQkOBmwy8yn8pX4HRi7AvLu5JjxVOSO
         c4rQ==
X-Gm-Message-State: AO0yUKWz8v48XK0tQ12k4K9A+Djq8m9ZWMJQopJ3qPhh5snbBYApsPjU
        ty+1AYZ/x12qHBj8QnbfT+ECTAMbyJRn5IeV
X-Google-Smtp-Source: AK7set9TLexUa1XYgaBmux8OGlRuUDg7RonQ4TBl8sJCl4uOIglqLEBR0JTGcQjhbe0lUO+2jdk2Y38gEcn8Rvxw
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:45c9:b0:3e1:336:d219 with SMTP
 id s9-20020a05600c45c900b003e10336d219mr730294wmo.145.1676215986690; Sun, 12
 Feb 2023 07:33:06 -0800 (PST)
Date:   Sun, 12 Feb 2023 15:32:49 +0000
In-Reply-To: <20230212153250.1099136-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20230212153250.1099136-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230212153250.1099136-2-vdonnefort@google.com>
Subject: [RFC PATCH 1/2] ring-buffer: Introducing ring-buffer mapping functions
From:   Vincent Donnefort <vdonnefort@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
  ring_buffer_update_meta_page()

Mapping the ring-buffer also involves:

  A unique ID for each page of the ring-buffer, as currently the pages
  are only identified through their in-kernel VA.

  A meta-page, where are stored statistics about the ring-buffer and
  the list of pages ID, ordered. A field gives what page is the reader
  one and one to gives where the ring-buffer starts in the list of data
  pages.

The linear mapping exposes the meta-page, and each page of the
ring-buffer, ordered following their unique ID, assigned during the
first mapping.

Once mapped, no page can get in or out of the ring-buffer: the buffer
size will remain unmodified and the splice enabling functions will in
reality simply memcpy the data instead of swapping pages.

Also, the meta-page being... a single page, this limits at the moment the
number of pages in the ring-buffer that can be mapped.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 782e14f62201..4897e17ebdde 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -6,6 +6,8 @@
 #include <linux/seq_file.h>
 #include <linux/poll.h>
 
+#include <uapi/linux/trace_mmap.h>
+
 struct trace_buffer;
 struct ring_buffer_iter;
 
@@ -211,4 +213,10 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
 #define trace_rb_cpu_prepare	NULL
 #endif
 
+int ring_buffer_map(struct trace_buffer *buffer, int cpu);
+int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
+struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
+				   unsigned long pgoff);
+int ring_buffer_get_reader_page(struct trace_buffer *buffer, int cpu);
+int ring_buffer_update_meta_page(struct trace_buffer *buffer, int cpu);
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
new file mode 100644
index 000000000000..0f3282fa1a94
--- /dev/null
+++ b/include/uapi/linux/trace_mmap.h
@@ -0,0 +1,14 @@
+#ifndef _UAPI_TRACE_MMAP_H_
+#define _UAPI_TRACE_MMAP_H_
+
+struct ring_buffer_meta_page {
+	__u64		entries;
+	__u64		overrun;
+	__u32		pages_touched;
+	__u32		reader_page;
+	__u32		nr_data_pages;
+	__u32		data_page_head;
+	__u32		data_pages[];
+};
+
+#endif /* _UAPI_TRACE_MMAP_H_ */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c366a0a9ddba..ffbb216a18a9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -20,6 +20,7 @@
 #include <linux/percpu.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
+#include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/hash.h>
@@ -332,6 +333,7 @@ struct buffer_page {
 	local_t		 entries;	/* entries on this page */
 	unsigned long	 real_end;	/* real end of data */
 	struct buffer_data_page *page;	/* Actual data page */
+	u32		 id;		/* ID for external mapping */
 };
 
 /*
@@ -529,6 +531,12 @@ struct ring_buffer_per_cpu {
 	rb_time_t			before_stamp;
 	u64				event_stamp[MAX_NEST];
 	u64				read_stamp;
+
+	atomic_t			mapped;
+	struct rw_semaphore		mapping_lock;
+	unsigned long			*page_ids;	/* ID to addr */
+	void				*meta_page;
+
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -1452,12 +1460,41 @@ static inline void rb_inc_page(struct buffer_page **bpage)
 	*bpage = list_entry(p, struct buffer_page, list);
 }
 
+static inline void
+rb_meta_page_head_move(struct ring_buffer_per_cpu *cpu_buffer, unsigned long num)
+{
+	struct ring_buffer_meta_page *meta = cpu_buffer->meta_page;
+	unsigned long head_id = meta->data_page_head;
+
+	/* No bookkeeping necessary */
+	if (!atomic_read(&cpu_buffer->mapped))
+		return;
+
+	meta->data_page_head = (head_id + num) % cpu_buffer->nr_pages;
+}
+
+static inline void
+rb_meta_page_head_swap(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct ring_buffer_meta_page *meta = cpu_buffer->meta_page;
+
+	/* No bookkeeping necessary */
+	if (!atomic_read(&cpu_buffer->mapped))
+		return;
+
+	meta->reader_page = cpu_buffer->reader_page->id;
+	meta->data_pages[meta->data_page_head] = cpu_buffer->head_page->id;
+
+	rb_meta_page_head_move(cpu_buffer, 1);
+}
+
 static struct buffer_page *
 rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct buffer_page *head;
 	struct buffer_page *page;
 	struct list_head *list;
+	unsigned long cnt = 0;
 	int i;
 
 	if (RB_WARN_ON(cpu_buffer, !cpu_buffer->head_page))
@@ -1479,9 +1516,11 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
 		do {
 			if (rb_is_head_page(page, page->list.prev)) {
 				cpu_buffer->head_page = page;
+				rb_meta_page_head_move(cpu_buffer, cnt);
 				return page;
 			}
 			rb_inc_page(&page);
+			cnt++;
 		} while (page != head);
 	}
 
@@ -1757,6 +1796,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
+	init_rwsem(&cpu_buffer->mapping_lock);
 
 	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 			    GFP_KERNEL, cpu_to_node(cpu));
@@ -2195,7 +2235,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 	/* prevent another thread from changing buffer sizes */
 	mutex_lock(&buffer->mutex);
 
-
 	if (cpu_id == RING_BUFFER_ALL_CPUS) {
 		/*
 		 * Don't succeed if resizing is disabled, as a reader might be
@@ -3504,7 +3543,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 		return;
 
 	/*
-	 * If this interrupted another event, 
+	 * If this interrupted another event,
 	 */
 	if (atomic_inc_return(this_cpu_ptr(&checking)) != 1)
 		goto out;
@@ -4665,6 +4704,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 * Now make the new head point back to the reader page.
 	 */
 	rb_list_head(reader->list.next)->prev = &cpu_buffer->reader_page->list;
+	rb_meta_page_head_swap(cpu_buffer);
 	rb_inc_page(&cpu_buffer->head_page);
 
 	local_inc(&cpu_buffer->pages_read);
@@ -5511,6 +5551,12 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	cpu_buffer_a = buffer_a->buffers[cpu];
 	cpu_buffer_b = buffer_b->buffers[cpu];
 
+	if (atomic_read(&cpu_buffer_a->mapped) ||
+	    atomic_read(&cpu_buffer_b->mapped)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* At least make sure the two buffers are somewhat the same */
 	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
 		goto out;
@@ -5804,14 +5850,19 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		cpu_buffer->read += rb_page_entries(reader);
 		cpu_buffer->read_bytes += BUF_PAGE_SIZE;
 
-		/* swap the pages */
-		rb_init_page(bpage);
-		bpage = reader->page;
-		reader->page = *data_page;
-		local_set(&reader->write, 0);
-		local_set(&reader->entries, 0);
-		reader->read = 0;
-		*data_page = bpage;
+		if (likely(!atomic_read(&cpu_buffer->mapped))) {
+			/* swap the pages */
+			rb_init_page(bpage);
+			bpage = reader->page;
+			reader->page = *data_page;
+			local_set(&reader->write, 0);
+			local_set(&reader->entries, 0);
+			reader->read = 0;
+			*data_page = bpage;
+		} else {
+			memcpy(bpage->data, cpu_buffer->reader_page->page->data,
+			       PAGE_SIZE);
+		}
 
 		/*
 		 * Use the real_end for the data size,
@@ -5856,6 +5907,290 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_page);
 
+#define META_PAGE_MAX_PAGES \
+	((PAGE_SIZE - (offsetof(struct ring_buffer_meta_page, data_page_head))) >> 2)
+
+static void rb_free_page_ids(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	kfree(cpu_buffer->page_ids);
+	cpu_buffer->page_ids = NULL;
+}
+
+static int rb_alloc_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	if (cpu_buffer->meta_page)
+		return 0;
+
+	if ((cpu_buffer->nr_pages + 1) > META_PAGE_MAX_PAGES)
+		return -E2BIG;
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
+	free_page((unsigned long)cpu_buffer->meta_page);
+	cpu_buffer->meta_page = NULL;
+}
+
+static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct ring_buffer_meta_page *meta;
+	unsigned long flags;
+
+	/* Update the head page if the writer moved it */
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	rb_set_head_page(cpu_buffer);
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+
+	/*
+	 * Instead of letting the writer carry the meta page burden,
+	 * give the responsibility to the reader.
+	 */
+	meta = (struct ring_buffer_meta_page *)cpu_buffer->meta_page;
+	meta->entries = local_read(&cpu_buffer->entries);
+	meta->pages_touched = local_read(&cpu_buffer->pages_touched);
+	meta->overrun = local_read(&cpu_buffer->overrun);
+}
+
+static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
+				   unsigned long *page_ids)
+{
+	struct buffer_page *first_page, *bpage;
+	struct ring_buffer_meta_page *meta;
+	int id = 0, i = 0;
+
+	meta = (struct ring_buffer_meta_page *)cpu_buffer->meta_page;
+
+	meta->reader_page = cpu_buffer->reader_page->id;
+	meta->nr_data_pages = cpu_buffer->nr_pages;
+	meta->data_page_head = 0;
+
+	page_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
+	cpu_buffer->reader_page->id = id;
+
+	id++;
+
+	first_page = bpage = rb_set_head_page(cpu_buffer);
+	do {
+		if (i >= META_PAGE_MAX_PAGES) {
+			WARN_ON(1);
+			break;
+		}
+
+		page_ids[id] = (unsigned long)bpage->page;
+		bpage->id = id;
+		meta->data_pages[i] = id;
+
+		rb_inc_page(&bpage);
+		i++; id++;
+	} while (bpage != first_page);
+
+	/* install page ID to kern VA translation */
+	cpu_buffer->page_ids = page_ids;
+}
+
+static struct ring_buffer_per_cpu *
+rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return ERR_PTR(-EINVAL);
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	down_read(&cpu_buffer->mapping_lock);
+
+	if (!atomic_read(&cpu_buffer->mapped)) {
+		up_read(&cpu_buffer->mapping_lock);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return cpu_buffer;
+}
+
+void rb_put_mapped_buffer(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	up_read(&cpu_buffer->mapping_lock);
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
+	down_write(&cpu_buffer->mapping_lock);
+
+	if (atomic_read(&cpu_buffer->mapped)) {
+		atomic_inc(&cpu_buffer->mapped);
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
+	 * Lock all other readers as we'll disable the splice and enable the
+	 * meta-page data_head_page book keeping.
+	 */
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+	rb_setup_ids_meta_page(cpu_buffer, page_ids);
+	atomic_inc(&cpu_buffer->mapped);
+
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+unlock:
+	up_write(&cpu_buffer->mapping_lock);
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
+	down_write(&cpu_buffer->mapping_lock);
+
+	if (!atomic_read(&cpu_buffer->mapped)) {
+		err = -ENODEV;
+		goto unlock;
+	}
+
+	if (atomic_dec_and_test(&cpu_buffer->mapped)) {
+		unsigned long flags;
+
+		/*
+		 * Lock all readers to make sure none will attempt meta-page
+		 * book keeping while we free the resources
+		 */
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+		rb_free_page_ids(cpu_buffer);
+		rb_free_meta_page(cpu_buffer);
+		atomic_dec(&cpu_buffer->resize_disabled);
+
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	}
+
+unlock:
+	up_write(&cpu_buffer->mapping_lock);
+
+	return err;
+}
+
+/*
+ *   +--------------+
+ *   |   meta page  |  pgoff=0
+ *   +--------------+
+ *   |  data page1  |  pgoff=1 page_ids=0
+ *   +--------------+
+ *   |  data page2  |  pgoff=2 page_ids=1
+ *         ...
+ */
+struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
+				   unsigned long pgoff)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	struct page *page = NULL;
+
+	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
+	if (IS_ERR(cpu_buffer))
+		return NULL;
+
+	if (!cpu_buffer->page_ids) {
+		WARN_ON(1);
+		goto put;
+	}
+
+	if (pgoff == 0) {
+		page = virt_to_page(cpu_buffer->meta_page);
+	} else {
+		pgoff--;
+
+		if (pgoff > (cpu_buffer->nr_pages))
+			goto put;
+
+		page = virt_to_page(cpu_buffer->page_ids[pgoff]);
+	}
+put:
+	rb_put_mapped_buffer(cpu_buffer);
+
+	return page;
+}
+
+int ring_buffer_get_reader_page(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	struct buffer_page *bpage, *reader;
+	unsigned long flags;
+	int err = 0;
+
+	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
+	if (IS_ERR(cpu_buffer))
+		return (int)PTR_ERR(cpu_buffer);
+
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	reader = cpu_buffer->reader_page;
+	reader->read = rb_page_size(reader);
+	bpage = rb_get_reader_page(cpu_buffer);
+	if (!bpage)
+		err = -ENODEV;
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+
+	rb_put_mapped_buffer(cpu_buffer);
+
+	return err;
+}
+
+int ring_buffer_update_meta_page(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+
+	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
+	if (IS_ERR(cpu_buffer))
+		return PTR_ERR(cpu_buffer);
+
+	rb_update_meta_page(cpu_buffer);
+	rb_put_mapped_buffer(cpu_buffer);
+
+	return 0;
+}
+
 /*
  * We only allocate new buffers, never free them if the CPU goes down.
  * If we were to free the buffer, then the user would lose any trace that was in
-- 
2.39.1.581.gbfd45094c4-goog

