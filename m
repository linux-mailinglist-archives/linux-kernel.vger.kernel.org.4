Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16326BEB58
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjCQOdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCQOdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:33:38 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA94B482F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:33:31 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id b14-20020a05600003ce00b002cfefd8e637so856739wrg.15
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679063610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PkYhcFSA6DbfFEE6GkQuWN6B5OP9XSkOTQiYSr9a+3A=;
        b=UyLSTmefxksmvXKeAjm571K9GjoJEbu1HCK12EknPVteilSMeBKavO3LkckLFNtlCm
         oXiHECL+QwsC1FPST5alLNKDzYGELsOrAEFswh0wwZGy7fPiyWIvxZtxbLa0tvB1JPb7
         KCNVAzwbGp14OzPjK6eE1i/r4f3uvdup+zBVPwR0ECqKinmvc1h2S8cJjJHfDB8NHy3U
         VIAKRaLC4nJ/Do+KeQ7i49c0RS3m7JL1uceRJ8Utdmp3UA4GOLh/4sO/Lbj4IQ5uysG8
         okM0D2vwHnkEq9ZSICRxNDMDTdNovitCFrQsO6+ydH8/o6A4W/otJaiNAwY2X4yVHDPY
         UM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679063610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkYhcFSA6DbfFEE6GkQuWN6B5OP9XSkOTQiYSr9a+3A=;
        b=5VIy3EtTo+kYcDvNJwMf3DjSRQCgRBujsC+3uP6TDLDW5IffnhK88JEDc0k8Cvt1Dp
         KtKoQTv4Nphwh6cq4xDHDhoVjcDsD3UxsU6arFjao95VE4pr9g1hthECvt8IKrWLNhKN
         614bG2DrNCDOv/6T7rgNFWp43KdL49a0h+DaTV9Ji/VncX66m3hNRfdpQ2PeA/wA2nng
         dtNb9i0XY/kIKZ/o0DqPNDOJPbTNWlHKAj15xPI4nNU/4K7sxhxzAaMQxPYBSzxrnIqj
         1DPf0nB0rYxHaEvFNA4WnuxJngcWXL8f9yQo6zDvvlLWfi5chDNWbBMHo6KpFPpuUnKQ
         Eldg==
X-Gm-Message-State: AO0yUKVeMu3xo87wOj4bkt+6Au2KDbF9C5iUFFfE6MvpP26P5yskN8VE
        AHzJDY9+RVnRsCQJOMMV1+lyjrt3qjpg5DyG
X-Google-Smtp-Source: AK7set8SxWfWnS4oBgajV2pTK1YYSm0x41jox9T8m0zwwlvUKztZw6o8+F2p9nJNrQhg05AC1DQGgntOGa1MXh4m
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a5d:49d0:0:b0:2cf:ec67:8f9f with SMTP
 id t16-20020a5d49d0000000b002cfec678f9fmr1731222wrs.13.1679063609848; Fri, 17
 Mar 2023 07:33:29 -0700 (PDT)
Date:   Fri, 17 Mar 2023 14:33:09 +0000
In-Reply-To: <20230317143310.1604700-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20230317143310.1604700-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230317143310.1604700-2-vdonnefort@google.com>
Subject: [PATCH 1/2] ring-buffer: Introducing ring-buffer mapping functions
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
  a page IDs list, ordered. A field gives what page is the reader
  one and one to gives where the ring-buffer starts in the list of data
  pages.

The linear mapping exposes the meta-page, and each page of the
ring-buffer, ordered following their unique ID, assigned during the
first mapping.

Once mapped, no page can get in or out of the ring-buffer: the buffer
size will remain unmodified and the splice enabling functions will in
reality simply memcpy the data instead of swapping pages.

Also, the meta-page being... a single page, this limits at the moment the
number of pages in the ring-buffer that can be mapped: ~3MB on a 4K pages
system.

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
index 000000000000..b5caed17a066
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
+struct ring_buffer_meta_page {
+#if __BITS_PER_LONG == 64
+	__u64	entries;
+	__u64	overrun;
+#else
+	__u32	entries;
+	__u32	overrun;
+#endif
+	__u32	pages_touched;
+	__u32	reader_page;
+	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
+	__u32	data_page_head;	/* index of data_pages[] */
+	__u32	data_pages[];
+};
+
+#endif /* _UAPI_TRACE_MMAP_H_ */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index af50d931b020..08765310380b 100644
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
+	struct ring_buffer_meta_page	*meta_page;
+
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -1452,12 +1459,37 @@ static inline void rb_inc_page(struct buffer_page **bpage)
 	*bpage = list_entry(p, struct buffer_page, list);
 }
 
+static inline void
+rb_meta_page_head_move(struct ring_buffer_per_cpu *cpu_buffer, unsigned long num)
+{
+	unsigned long head_id;
+
+	if (!READ_ONCE(cpu_buffer->mapped))
+		return;
+
+	head_id = cpu_buffer->meta_page->data_page_head;
+	cpu_buffer->meta_page->data_page_head = (head_id + num) % cpu_buffer->nr_pages;
+}
+
+static inline void
+rb_meta_page_head_swap(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct ring_buffer_meta_page *meta = cpu_buffer->meta_page;
+
+	if (!READ_ONCE(cpu_buffer->mapped))
+		return;
+
+	meta->reader_page = cpu_buffer->head_page->id;
+	meta->data_pages[meta->data_page_head] = cpu_buffer->reader_page->id;
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
@@ -1479,9 +1511,12 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
 		do {
 			if (rb_is_head_page(page, page->list.prev)) {
 				cpu_buffer->head_page = page;
+				rb_meta_page_head_move(cpu_buffer, cnt);
+
 				return page;
 			}
 			rb_inc_page(&page);
+			cnt++;
 		} while (page != head);
 	}
 
@@ -1567,6 +1602,13 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
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
@@ -1735,6 +1777,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
+	mutex_init(&cpu_buffer->mapping_lock);
 
 	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 			    GFP_KERNEL, cpu_to_node(cpu));
@@ -2173,7 +2216,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 	/* prevent another thread from changing buffer sizes */
 	mutex_lock(&buffer->mutex);
 
-
 	if (cpu_id == RING_BUFFER_ALL_CPUS) {
 		/*
 		 * Don't succeed if resizing is disabled, as a reader might be
@@ -2523,6 +2565,13 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
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
@@ -3179,6 +3228,14 @@ static inline void rb_event_discard(struct ring_buffer_event *event)
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
 
@@ -3482,7 +3539,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 		return;
 
 	/*
-	 * If this interrupted another event, 
+	 * If this interrupted another event,
 	 */
 	if (atomic_inc_return(this_cpu_ptr(&checking)) != 1)
 		goto out;
@@ -4643,7 +4700,9 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 * Now make the new head point back to the reader page.
 	 */
 	rb_list_head(reader->list.next)->prev = &cpu_buffer->reader_page->list;
+	rb_meta_page_head_swap(cpu_buffer);
 	rb_inc_page(&cpu_buffer->head_page);
+	rb_meta_page_head_move(cpu_buffer, 1);
 
 	local_inc(&cpu_buffer->pages_read);
 
@@ -5285,6 +5344,12 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->lost_events = 0;
 	cpu_buffer->last_overrun = 0;
 
+	if (READ_ONCE(cpu_buffer->mapped)) {
+		WRITE_ONCE(cpu_buffer->meta_page->entries, 0);
+		WRITE_ONCE(cpu_buffer->meta_page->pages_touched, 0);
+		WRITE_ONCE(cpu_buffer->meta_page->overrun, 0);
+	}
+
 	rb_head_page_activate(cpu_buffer);
 }
 
@@ -5489,6 +5554,11 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
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
@@ -5722,7 +5792,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 * Otherwise, we can simply swap the page with the one passed in.
 	 */
 	if (read || (len < (commit - read)) ||
-	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
+	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
+	    READ_ONCE(cpu_buffer->mapped)) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -5839,6 +5910,263 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
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
+	if (cpu_buffer->nr_pages > META_PAGE_MAX_PAGES)
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
+static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
+				   unsigned long *page_ids)
+{
+	struct ring_buffer_meta_page *meta = cpu_buffer->meta_page;
+	struct buffer_page *first_page, *bpage;
+	int id = 0;
+
+	page_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
+	cpu_buffer->reader_page->id = id++;
+
+	first_page = bpage = rb_set_head_page(cpu_buffer);
+	do {
+		if (id > META_PAGE_MAX_PAGES) {
+			WARN_ON(1);
+			break;
+		}
+
+		page_ids[id] = (unsigned long)bpage->page;
+		bpage->id = id;
+		meta->data_pages[id - 1] = id;
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
+	meta->reader_page = cpu_buffer->reader_page->id;
+	meta->nr_data_pages = cpu_buffer->nr_pages;
+	meta->data_page_head = 0;
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
+ *   |  data page1  |  pgoff=1 page_ids=0
+ *   +--------------+
+ *   |  data page2  |  pgoff=2 page_ids=1
+ *         ...
+ */
+struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
+				   unsigned long pgoff)
+{
+	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
+
+	if (!pgoff)
+		return virt_to_page(cpu_buffer->meta_page);
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
+	struct buffer_page *reader;
+	unsigned long flags;
+
+	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
+	if (IS_ERR(cpu_buffer))
+		return (int)PTR_ERR(cpu_buffer);
+
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	reader = cpu_buffer->reader_page;
+	reader->read = rb_page_size(reader);
+	if (!rb_per_cpu_empty(cpu_buffer))
+		WARN_ON(!rb_get_reader_page(cpu_buffer));
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+
+	rb_put_mapped_buffer(cpu_buffer);
+
+	return 0;
+}
+
+int ring_buffer_update_meta_page(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned long flags;
+
+	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
+	if (IS_ERR(cpu_buffer))
+		return PTR_ERR(cpu_buffer);
+
+	/* Update the head page if the writer moved it */
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	rb_set_head_page(cpu_buffer);
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
2.40.0.rc1.284.g88254d51c5-goog

