Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B095BD899
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 02:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiITABl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 20:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiITAB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 20:01:28 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3032B52084;
        Mon, 19 Sep 2022 17:01:18 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id mi14so837450qvb.12;
        Mon, 19 Sep 2022 17:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0K9lD0L7HlsQherxPHLjANUqH3/gfBcnW4RwaQKKsTU=;
        b=1t1PA5iQPxoqNQx6JHG0giMZVz/WkcOboZU9wDJe7S9T+ITR9h4y3B7Jjw8WWKfSZA
         ax62mesVZ/TxH0l7kq8ddiJfIeggP8tauMWnCDjl3vtvakkxQVNMJMyfdi+4f3xJqWi0
         Ct6W0bd6JANZ+YB1/kP/fYR3hUYUogUZGBU8W8Tnl8IPghu6uFSqemMBe/MEL+5IOuCf
         JVQAcMZl8SrUiwWnFW/kcm/f5VdlzWeF3uNKq2cJqBa68nB9Yg38z9bfoklAxMEY+Jjg
         YbN6vTVlhQcsqe6SPKK6SkX21HHVOsi79UGZl8ac+o+3H1CnbwBwFtt/TMfvIIdvrR50
         4FBQ==
X-Gm-Message-State: ACrzQf0x3IIUu2Yd9DKTfXzipzmQC2ggbpLbs5bH2TkW7gtTa5bzSOYy
        FJsLHhziQ8b+8/vHpfaLF7K9kYQBinYbe4jm
X-Google-Smtp-Source: AMsMyM6L2CtPT+l7dJZawpOyXYWl1mMYu01ukEkq/PD63AaB6HaBSzRdmgJH/MI4dxX21n3mSqIKuw==
X-Received: by 2002:a05:6214:62a:b0:4ac:b768:ac53 with SMTP id a10-20020a056214062a00b004acb768ac53mr16543393qvx.120.1663632077542;
        Mon, 19 Sep 2022 17:01:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::148f])
        by smtp.gmail.com with ESMTPSA id o17-20020a05622a139100b0035ced0a8382sm2504037qtk.54.2022.09.19.17.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 17:01:17 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev
Cc:     kernel-team@fb.com, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, brho@google.com,
        joshdon@google.com
Subject: [PATCH v6 3/4] bpf: Add libbpf logic for user-space ring buffer
Date:   Mon, 19 Sep 2022 19:00:59 -0500
Message-Id: <20220920000100.477320-4-void@manifault.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920000100.477320-1-void@manifault.com>
References: <20220920000100.477320-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all of the logic is in place in the kernel to support user-space
produced ring buffers, we can add the user-space logic to libbpf. This
patch therefore adds the following public symbols to libbpf:

struct user_ring_buffer *
user_ring_buffer__new(int map_fd,
		      const struct user_ring_buffer_opts *opts);
void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size);
void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb,
                                         __u32 size, int timeout_ms);
void user_ring_buffer__submit(struct user_ring_buffer *rb, void *sample);
void user_ring_buffer__discard(struct user_ring_buffer *rb,
void user_ring_buffer__free(struct user_ring_buffer *rb);

A user-space producer must first create a struct user_ring_buffer * object
with user_ring_buffer__new(), and can then reserve samples in the
ring buffer using one of the following two symbols:

void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size);
void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb,
                                         __u32 size, int timeout_ms);

With user_ring_buffer__reserve(), a pointer to a 'size' region of the ring
buffer will be returned if sufficient space is available in the buffer.
user_ring_buffer__reserve_blocking() provides similar semantics, but will
block for up to 'timeout_ms' in epoll_wait if there is insufficient space
in the buffer. This function has the guarantee from the kernel that it will
receive at least one event-notification per invocation to
bpf_ringbuf_drain(), provided that at least one sample is drained, and the
BPF program did not pass the BPF_RB_NO_WAKEUP flag to bpf_ringbuf_drain().

Once a sample is reserved, it must either be committed to the ring buffer
with user_ring_buffer__submit(), or discarded with
user_ring_buffer__discard().

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/lib/bpf/libbpf.c         |  10 +-
 tools/lib/bpf/libbpf.h         | 107 +++++++++++++
 tools/lib/bpf/libbpf.map       |  10 ++
 tools/lib/bpf/libbpf_probes.c  |   1 +
 tools/lib/bpf/libbpf_version.h |   2 +-
 tools/lib/bpf/ringbuf.c        | 271 +++++++++++++++++++++++++++++++++
 6 files changed, 398 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d480da05b6de..67bc18506150 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2373,6 +2373,12 @@ static size_t adjust_ringbuf_sz(size_t sz)
 	return sz;
 }
 
+static bool map_is_ringbuf(const struct bpf_map *map)
+{
+	return map->def.type == BPF_MAP_TYPE_RINGBUF ||
+	       map->def.type == BPF_MAP_TYPE_USER_RINGBUF;
+}
+
 static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def)
 {
 	map->def.type = def->map_type;
@@ -2387,7 +2393,7 @@ static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def
 	map->btf_value_type_id = def->value_type_id;
 
 	/* auto-adjust BPF ringbuf map max_entries to be a multiple of page size */
-	if (map->def.type == BPF_MAP_TYPE_RINGBUF)
+	if (map_is_ringbuf(map))
 		map->def.max_entries = adjust_ringbuf_sz(map->def.max_entries);
 
 	if (def->parts & MAP_DEF_MAP_TYPE)
@@ -4370,7 +4376,7 @@ int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
 	map->def.max_entries = max_entries;
 
 	/* auto-adjust BPF ringbuf map max_entries to be a multiple of page size */
-	if (map->def.type == BPF_MAP_TYPE_RINGBUF)
+	if (map_is_ringbuf(map))
 		map->def.max_entries = adjust_ringbuf_sz(map->def.max_entries);
 
 	return 0;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 88a1ac34b12a..e2d8c17f2e85 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1011,6 +1011,7 @@ LIBBPF_API int bpf_tc_query(const struct bpf_tc_hook *hook,
 
 /* Ring buffer APIs */
 struct ring_buffer;
+struct user_ring_buffer;
 
 typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size);
 
@@ -1030,6 +1031,112 @@ LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
 LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 
+struct user_ring_buffer_opts {
+	size_t sz; /* size of this struct, for forward/backward compatibility */
+};
+
+#define user_ring_buffer_opts__last_field sz
+
+/* @brief **user_ring_buffer__new()** creates a new instance of a user ring
+ * buffer.
+ *
+ * @param map_fd A file descriptor to a BPF_MAP_TYPE_USER_RINGBUF map.
+ * @param opts Options for how the ring buffer should be created.
+ * @return A user ring buffer on success; NULL and errno being set on a
+ * failure.
+ */
+LIBBPF_API struct user_ring_buffer *
+user_ring_buffer__new(int map_fd, const struct user_ring_buffer_opts *opts);
+
+/* @brief **user_ring_buffer__reserve()** reserves a pointer to a sample in the
+ * user ring buffer.
+ * @param rb A pointer to a user ring buffer.
+ * @param size The size of the sample, in bytes.
+ * @return A pointer to an 8-byte aligned reserved region of the user ring
+ * buffer; NULL, and errno being set if a sample could not be reserved.
+ *
+ * This function is *not* thread safe, and callers must synchronize accessing
+ * this function if there are multiple producers.  If a size is requested that
+ * is larger than the size of the entire ring buffer, errno will be set to
+ * E2BIG and NULL is returned. If the ring buffer could accommodate the size,
+ * but currently does not have enough space, errno is set to ENOSPC and NULL is
+ * returned.
+ *
+ * After initializing the sample, callers must invoke
+ * **user_ring_buffer__submit()** to post the sample to the kernel. Otherwise,
+ * the sample must be freed with **user_ring_buffer__discard()**.
+ */
+LIBBPF_API void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size);
+
+/* @brief **user_ring_buffer__reserve_blocking()** reserves a record in the
+ * ring buffer, possibly blocking for up to @timeout_ms until a sample becomes
+ * available.
+ * @param rb The user ring buffer.
+ * @param size The size of the sample, in bytes.
+ * @param timeout_ms The amount of time, in milliseconds, for which the caller
+ * should block when waiting for a sample. -1 causes the caller to block
+ * indefinitely.
+ * @return A pointer to an 8-byte aligned reserved region of the user ring
+ * buffer; NULL, and errno being set if a sample could not be reserved.
+ *
+ * This function is *not* thread safe, and callers must synchronize
+ * accessing this function if there are multiple producers
+ *
+ * If **timeout_ms** is -1, the function will block indefinitely until a sample
+ * becomes available. Otherwise, **timeout_ms** must be non-negative, or errno
+ * is set to EINVAL, and NULL is returned. If **timeout_ms** is 0, no blocking
+ * will occur and the function will return immediately after attempting to
+ * reserve a sample.
+ *
+ * If **size** is larger than the size of the entire ring buffer, errno is set
+ * to E2BIG and NULL is returned. If the ring buffer could accommodate
+ * **size**, but currently does not have enough space, the caller will block
+ * until at most **timeout_ms** has elapsed. If insufficient space is available
+ * at that time, errno is set to ENOSPC, and NULL is returned.
+ *
+ * The kernel guarantees that it will wake up this thread to check if
+ * sufficient space is available in the ring buffer at least once per
+ * invocation of the **bpf_ringbuf_drain()** helper function, provided that at
+ * least one sample is consumed, and the BPF program did not invoke the
+ * function with BPF_RB_NO_WAKEUP. A wakeup may occur sooner than that, but the
+ * kernel does not guarantee this. If the helper function is invoked with
+ * BPF_RB_FORCE_WAKEUP, a wakeup event will be sent even if no sample is
+ * consumed.
+ *
+ * When a sample of size **size** is found within **timeout_ms**, a pointer to
+ * the sample is returned. After initializing the sample, callers must invoke
+ * **user_ring_buffer__submit()** to post the sample to the ring buffer.
+ * Otherwise, the sample must be freed with **user_ring_buffer__discard()**.
+ */
+LIBBPF_API void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb,
+						    __u32 size,
+						    int timeout_ms);
+
+/* @brief **user_ring_buffer__submit()** submits a previously reserved sample
+ * into the ring buffer.
+ * @param rb The user ring buffer.
+ * @param sample A reserved sample.
+ *
+ * It is not necessary to synchronize amongst multiple producers when invoking
+ * this function.
+ */
+LIBBPF_API void user_ring_buffer__submit(struct user_ring_buffer *rb, void *sample);
+
+/* @brief **user_ring_buffer__discard()** discards a previously reserved sample.
+ * @param rb The user ring buffer.
+ * @param sample A reserved sample.
+ *
+ * It is not necessary to synchronize amongst multiple producers when invoking
+ * this function.
+ */
+LIBBPF_API void user_ring_buffer__discard(struct user_ring_buffer *rb, void *sample);
+
+/* @brief **user_ring_buffer__free()** frees a ring buffer that was previously
+ * created with **user_ring_buffer__new()**.
+ * @param rb The user ring buffer being freed.
+ */
+LIBBPF_API void user_ring_buffer__free(struct user_ring_buffer *rb);
+
 /* Perf buffer APIs */
 struct perf_buffer;
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 2b928dc21af0..c1d6aa7c82b6 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -368,3 +368,13 @@ LIBBPF_1.0.0 {
 		libbpf_bpf_prog_type_str;
 		perf_buffer__buffer;
 };
+
+LIBBPF_1.1.0 {
+	global:
+		user_ring_buffer__discard;
+		user_ring_buffer__free;
+		user_ring_buffer__new;
+		user_ring_buffer__reserve;
+		user_ring_buffer__reserve_blocking;
+		user_ring_buffer__submit;
+} LIBBPF_1.0.0;
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 6d495656f554..f3a8e8e74eb8 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -231,6 +231,7 @@ static int probe_map_create(enum bpf_map_type map_type)
 			return btf_fd;
 		break;
 	case BPF_MAP_TYPE_RINGBUF:
+	case BPF_MAP_TYPE_USER_RINGBUF:
 		key_size = 0;
 		value_size = 0;
 		max_entries = 4096;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
index 2fb2f4290080..e944f5bce728 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
 
 #define LIBBPF_MAJOR_VERSION 1
-#define LIBBPF_MINOR_VERSION 0
+#define LIBBPF_MINOR_VERSION 1
 
 #endif /* __LIBBPF_VERSION_H */
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 8bc117bcc7bc..d285171d4b69 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -16,6 +16,7 @@
 #include <asm/barrier.h>
 #include <sys/mman.h>
 #include <sys/epoll.h>
+#include <time.h>
 
 #include "libbpf.h"
 #include "libbpf_internal.h"
@@ -39,6 +40,23 @@ struct ring_buffer {
 	int ring_cnt;
 };
 
+struct user_ring_buffer {
+	struct epoll_event event;
+	unsigned long *consumer_pos;
+	unsigned long *producer_pos;
+	void *data;
+	unsigned long mask;
+	size_t page_size;
+	int map_fd;
+	int epoll_fd;
+};
+
+/* 8-byte ring buffer header structure */
+struct ringbuf_hdr {
+	__u32 len;
+	__u32 pad;
+};
+
 static void ringbuf_unmap_ring(struct ring_buffer *rb, struct ring *r)
 {
 	if (r->consumer_pos) {
@@ -300,3 +318,256 @@ int ring_buffer__epoll_fd(const struct ring_buffer *rb)
 {
 	return rb->epoll_fd;
 }
+
+static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
+{
+	if (rb->consumer_pos) {
+		munmap(rb->consumer_pos, rb->page_size);
+		rb->consumer_pos = NULL;
+	}
+	if (rb->producer_pos) {
+		munmap(rb->producer_pos, rb->page_size + 2 * (rb->mask + 1));
+		rb->producer_pos = NULL;
+	}
+}
+
+void user_ring_buffer__free(struct user_ring_buffer *rb)
+{
+	if (!rb)
+		return;
+
+	user_ringbuf_unmap_ring(rb);
+
+	if (rb->epoll_fd >= 0)
+		close(rb->epoll_fd);
+
+	free(rb);
+}
+
+static int user_ringbuf_map(struct user_ring_buffer *rb, int map_fd)
+{
+	struct bpf_map_info info;
+	__u32 len = sizeof(info);
+	void *tmp;
+	struct epoll_event *rb_epoll;
+	int err;
+
+	memset(&info, 0, sizeof(info));
+
+	err = bpf_obj_get_info_by_fd(map_fd, &info, &len);
+	if (err) {
+		err = -errno;
+		pr_warn("user ringbuf: failed to get map info for fd=%d: %d\n", map_fd, err);
+		return err;
+	}
+
+	if (info.type != BPF_MAP_TYPE_USER_RINGBUF) {
+		pr_warn("user ringbuf: map fd=%d is not BPF_MAP_TYPE_USER_RINGBUF\n", map_fd);
+		return -EINVAL;
+	}
+
+	rb->map_fd = map_fd;
+	rb->mask = info.max_entries - 1;
+
+	/* Map read-only consumer page */
+	tmp = mmap(NULL, rb->page_size, PROT_READ, MAP_SHARED, map_fd, 0);
+	if (tmp == MAP_FAILED) {
+		err = -errno;
+		pr_warn("user ringbuf: failed to mmap consumer page for map fd=%d: %d\n",
+			map_fd, err);
+		return err;
+	}
+	rb->consumer_pos = tmp;
+
+	/* Map read-write the producer page and data pages. We map the data
+	 * region as twice the total size of the ring buffer to allow the
+	 * simple reading and writing of samples that wrap around the end of
+	 * the buffer.  See the kernel implementation for details.
+	 */
+	tmp = mmap(NULL, rb->page_size + 2 * info.max_entries,
+		   PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, rb->page_size);
+	if (tmp == MAP_FAILED) {
+		err = -errno;
+		pr_warn("user ringbuf: failed to mmap data pages for map fd=%d: %d\n",
+			map_fd, err);
+		return err;
+	}
+
+	rb->producer_pos = tmp;
+	rb->data = tmp + rb->page_size;
+
+	rb_epoll = &rb->event;
+	rb_epoll->events = EPOLLOUT;
+	if (epoll_ctl(rb->epoll_fd, EPOLL_CTL_ADD, map_fd, rb_epoll) < 0) {
+		err = -errno;
+		pr_warn("user ringbuf: failed to epoll add map fd=%d: %d\n", map_fd, err);
+		return err;
+	}
+
+	return 0;
+}
+
+struct user_ring_buffer *
+user_ring_buffer__new(int map_fd, const struct user_ring_buffer_opts *opts)
+{
+	struct user_ring_buffer *rb;
+	int err;
+
+	if (!OPTS_VALID(opts, user_ring_buffer_opts))
+		return errno = EINVAL, NULL;
+
+	rb = calloc(1, sizeof(*rb));
+	if (!rb)
+		return errno = ENOMEM, NULL;
+
+	rb->page_size = getpagesize();
+
+	rb->epoll_fd = epoll_create1(EPOLL_CLOEXEC);
+	if (rb->epoll_fd < 0) {
+		err = -errno;
+		pr_warn("user ringbuf: failed to create epoll instance: %d\n", err);
+		goto err_out;
+	}
+
+	err = user_ringbuf_map(rb, map_fd);
+	if (err)
+		goto err_out;
+
+	return rb;
+
+err_out:
+	user_ring_buffer__free(rb);
+	return errno = -err, NULL;
+}
+
+static void user_ringbuf_commit(struct user_ring_buffer *rb, void *sample, bool discard)
+{
+	__u32 new_len;
+	struct ringbuf_hdr *hdr;
+	uintptr_t hdr_offset;
+
+	hdr_offset = rb->mask + 1 + (sample - rb->data) - BPF_RINGBUF_HDR_SZ;
+	hdr = rb->data + (hdr_offset & rb->mask);
+
+	new_len = hdr->len & ~BPF_RINGBUF_BUSY_BIT;
+	if (discard)
+		new_len |= BPF_RINGBUF_DISCARD_BIT;
+
+	/* Synchronizes with smp_load_acquire() in __bpf_user_ringbuf_peek() in
+	 * the kernel.
+	 */
+	__atomic_exchange_n(&hdr->len, new_len, __ATOMIC_ACQ_REL);
+}
+
+void user_ring_buffer__discard(struct user_ring_buffer *rb, void *sample)
+{
+	user_ringbuf_commit(rb, sample, true);
+}
+
+void user_ring_buffer__submit(struct user_ring_buffer *rb, void *sample)
+{
+	user_ringbuf_commit(rb, sample, false);
+}
+
+void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size)
+{
+	__u32 avail_size, total_size, max_size;
+	/* 64-bit to avoid overflow in case of extreme application behavior */
+	__u64 cons_pos, prod_pos;
+	struct ringbuf_hdr *hdr;
+
+	/* Synchronizes with smp_store_release() in __bpf_user_ringbuf_peek() in
+	 * the kernel.
+	 */
+	cons_pos = smp_load_acquire(rb->consumer_pos);
+	/* Synchronizes with smp_store_release() in user_ringbuf_commit() */
+	prod_pos = smp_load_acquire(rb->producer_pos);
+
+	max_size = rb->mask + 1;
+	avail_size = max_size - (prod_pos - cons_pos);
+	/* Round up total size to a multiple of 8. */
+	total_size = (size + BPF_RINGBUF_HDR_SZ + 7) / 8 * 8;
+
+	if (total_size > max_size)
+		return errno = E2BIG, NULL;
+
+	if (avail_size < total_size)
+		return errno = ENOSPC, NULL;
+
+	hdr = rb->data + (prod_pos & rb->mask);
+	hdr->len = size | BPF_RINGBUF_BUSY_BIT;
+	hdr->pad = 0;
+
+	/* Synchronizes with smp_load_acquire() in __bpf_user_ringbuf_peek() in
+	 * the kernel.
+	 */
+	smp_store_release(rb->producer_pos, prod_pos + total_size);
+
+	return (void *)rb->data + ((prod_pos + BPF_RINGBUF_HDR_SZ) & rb->mask);
+}
+
+static __u64 ns_elapsed_timespec(const struct timespec *start, const struct timespec *end)
+{
+	__u64 start_ns, end_ns, ns_per_s = 1000000000;
+
+	start_ns = (__u64)start->tv_sec * ns_per_s + start->tv_nsec;
+	end_ns = (__u64)end->tv_sec * ns_per_s + end->tv_nsec;
+
+	return end_ns - start_ns;
+}
+
+void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb, __u32 size, int timeout_ms)
+{
+	void *sample;
+	int err, ms_remaining = timeout_ms;
+	struct timespec start;
+
+	if (timeout_ms < 0 && timeout_ms != -1)
+		return errno = EINVAL, NULL;
+
+	if (timeout_ms != -1) {
+		err = clock_gettime(CLOCK_MONOTONIC, &start);
+		if (err)
+			return NULL;
+	}
+
+	do {
+		int cnt, ms_elapsed;
+		struct timespec curr;
+		__u64 ns_per_ms = 1000000;
+
+		sample = user_ring_buffer__reserve(rb, size);
+		if (sample)
+			return sample;
+		else if (errno != ENOSPC)
+			return NULL;
+
+		/* The kernel guarantees at least one event notification
+		 * delivery whenever at least one sample is drained from the
+		 * ring buffer in an invocation to bpf_ringbuf_drain(). Other
+		 * additional events may be delivered at any time, but only one
+		 * event is guaranteed per bpf_ringbuf_drain() invocation,
+		 * provided that a sample is drained, and the BPF program did
+		 * not pass BPF_RB_NO_WAKEUP to bpf_ringbuf_drain(). If
+		 * BPF_RB_FORCE_WAKEUP is passed to bpf_ringbuf_drain(), a
+		 * wakeup event will be delivered even if no samples are
+		 * drained.
+		 */
+		cnt = epoll_wait(rb->epoll_fd, &rb->event, 1, ms_remaining);
+		if (cnt < 0)
+			return NULL;
+
+		if (timeout_ms == -1)
+			continue;
+
+		err = clock_gettime(CLOCK_MONOTONIC, &curr);
+		if (err)
+			return NULL;
+
+		ms_elapsed = ns_elapsed_timespec(&start, &curr) / ns_per_ms;
+		ms_remaining = timeout_ms - ms_elapsed;
+	} while (ms_remaining > 0);
+
+	/* Try one more time to reserve a sample after the specified timeout has elapsed. */
+	return user_ring_buffer__reserve(rb, size);
+}
-- 
2.37.3

