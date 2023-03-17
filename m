Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621BE6BEB56
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCQOdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjCQOdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:33:35 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6997E7B0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:33:28 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id l20-20020a05600c1d1400b003e10d3e1c23so4373562wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679063607;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NAlu1ZsRN3U938dPa2PYC4fE3ZHRDQI3wHPzWFpTsMc=;
        b=NJvWR0UNYLX65E1V3A7V+zzgtw/7Cckr9NZqdavukoK9+16y+Q4B8CXE5d3hZ+8nhK
         JQzJLFsdkJbsbYxO3wXkYhlMgfR6/a0kyp0Blg6RkVPxKHZ15vULo7LU+1MO478YrZyc
         rFOsBzHKPj+skT3PxZMXVUYzl3aUQ1Liz/XYMyQ70/ercjSFktl73TEP7+I18PUhwUJe
         f9FXNb+sqFDlb8/AS44gTPEof8PfXmtgIUTKMiQW2xMTngOJ+niXauFEwqBVsRFec4TL
         f9AP9AEGDbTeNOvsbO9kVe1oGpPU+SF6r3jC47pH00Yv4OuqMgGg/zmnV0nmXCRCv9AP
         JZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679063607;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NAlu1ZsRN3U938dPa2PYC4fE3ZHRDQI3wHPzWFpTsMc=;
        b=us0qA+JKp0XefX2fbeuegBmAaGLiZbbYwA5DQEZpFHyI77XLJh9mTtZoi/guthnLd/
         c++TWnn2O6D1yrnXU2OfRWYJZ5V1B7r5vjfoLNKknY0wF9aAbIyCCwP1qr6MUZYzJgRU
         W2MCZFcU9KSWbyHy+HIGugyYESH8wrBRvPvTErT/b11bHPD3ISxyQyvToi7xFOm5BQx5
         DFpRgmk6Cojf6G+ROx/Z6dhmMg3ZFVaQzge238EHIvauK3Zpw2qbQSfLsBr6ZyEcEDDa
         sV+lJ+atdkoWiSWVgWHrlwKTYgzeli/Ga0m2nhOIotM3tYxLBwoJGDLgeaD5TgNfQPi6
         /z2A==
X-Gm-Message-State: AO0yUKWiwVwYNsvlTm9owD+wQO/VCUAKMtvV2hgh2ypgNhZAKpoNQHNw
        xrNFqM0sjtBlmEDm5u9kGe284dABAoED+F6l
X-Google-Smtp-Source: AK7set+7i4rX5HlPHHRPyI7UrjRAR/rq3GDVZ5hV79/j+cfQxDj/ZYO0b1RyevsjLgoELhJey2bLx5gehlSuNH7O
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a5d:64ec:0:b0:2c7:e48:8c98 with SMTP id
 g12-20020a5d64ec000000b002c70e488c98mr961410wri.4.1679063607189; Fri, 17 Mar
 2023 07:33:27 -0700 (PDT)
Date:   Fri, 17 Mar 2023 14:33:08 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230317143310.1604700-1-vdonnefort@google.com>
Subject: [PATCH 0/2] Introducing trace buffer mapping by user-space
From:   Vincent Donnefort <vdonnefort@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tracing ring-buffers can be stored on disk or sent to network without any
copy via splice. However the later doesn't allow real time processing of the
traces. A solution is to give access to userspace to the ring-buffer pages
directly via a mapping. A piece of software can now become a reader of the
ring-buffer, and drive a consuming or non-consuming read in a similar fashion to
what trace and trace_pipe offer.

Attached to this cover letter an example of consuming read for a ring-buffer,
using libtracefs.

Vincent

--

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <signal.h>
#include <errno.h>
#include <unistd.h>
#include <tracefs.h>
#include <kbuffer.h>
#include <event-parse.h>

#include <asm/types.h>
#include <sys/mman.h>
#include <sys/ioctl.h>

#define TRACE_MMAP_IOCTL_GET_READER_PAGE	_IO('T', 0x1)

struct ring_buffer_meta_page {
	__u64		entries;
	__u64		overrun;
	__u32		pages_touched;
	__u32		reader_page;
	__u32		nr_data_pages;
	__u32		data_page_head;
	__u32		data_pages[];
};

/* Need to access private struct to save counters */
struct kbuffer {
	unsigned long long 	timestamp;
	long long		lost_events;
	unsigned long		flags;
	void			*subbuffer;
	void			*data;
	unsigned int		index;
	unsigned int		curr;
	unsigned int		next;
	unsigned int		size;
	unsigned int		start;
	unsigned int		first;

	unsigned int (*read_4)(void *ptr);
	unsigned long long (*read_8)(void *ptr);
	unsigned long long (*read_long)(struct kbuffer *kbuf, void *ptr);
	int (*next_event)(struct kbuffer *kbuf);
};

static char *argv0;
static bool need_exit;

static char *get_this_name(void)
{
	static char *this_name;
	char *arg;
	char *p;

	if (this_name)
		return this_name;

	arg = argv0;
	p = arg+strlen(arg);

	while (p >= arg && *p != '/')
		p--;
	p++;

	this_name = p;
	return p;
}

static void __vdie(const char *fmt, va_list ap, int err)
{
	int ret = errno;
	char *p = get_this_name();

	if (err && errno)
		perror(p);
	else
		ret = -1;

	fprintf(stderr, "  ");
	vfprintf(stderr, fmt, ap);

	fprintf(stderr, "\n");
	exit(ret);
}

void pdie(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	__vdie(fmt, ap, 1);
	va_end(ap);
}

static void read_page(struct tep_handle *tep, struct kbuffer *kbuf,
		      void *data, int page)
{
	static struct trace_seq seq;
	struct tep_record record;

	if (seq.buffer)
		trace_seq_reset(&seq);
	else
		trace_seq_init(&seq);

	while ((record.data = kbuffer_read_event(kbuf, &record.ts))) {
		kbuffer_next_event(kbuf, NULL);
		tep_print_event(tep, &seq, &record,
				"%s-%d %9d\t%s\n", TEP_PRINT_COMM,
				TEP_PRINT_PID, TEP_PRINT_TIME, TEP_PRINT_NAME);
		trace_seq_do_printf(&seq);
		trace_seq_reset(&seq);
	}
}

static int next_reader_page(int fd, struct ring_buffer_meta_page *meta,
			    struct kbuffer *kbuf)
{
	int prev_reader_page = meta->reader_page;

	if (ioctl(fd, TRACE_MMAP_IOCTL_GET_READER_PAGE) < 0)
		pdie("ioctl");

	return meta->reader_page;
}

static void signal_handler(int unused)
{
	printf("Exit!\n");
	need_exit = true;
}

int main(int argc, char **argv)
{
	int page_size, data_len, page, fd, start = -1;
	struct ring_buffer_meta_page *map;
	struct kbuffer *kbuf, prev_kbuf;
	struct tep_handle *tep;
	__u64 prev_entries;
	void *meta, *data;
	char *buf, path[32];
	int cpu;

	argv0 = argv[0];
	cpu = atoi(argv[1]);
	snprintf(path, 32, "per_cpu/cpu%d/trace_pipe_raw", cpu);

	tep = tracefs_local_events(NULL);
	kbuf = tep_kbuffer(tep);
	page_size = getpagesize();

	fd = tracefs_instance_file_open(NULL, path, O_RDONLY);
	if (fd < 0)
		pdie("raw");

	meta = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
	if (meta == MAP_FAILED)
		pdie("mmap");
	map = meta;

	printf("entries:	%llu\n", map->entries);
	printf("overrun:	%llu\n", map->overrun);
	printf("pages_touched:	%u\n", map->pages_touched);
	printf("reader_page:	%u\n", map->reader_page);
	printf("nr_data_pages:	%u\n\n", map->nr_data_pages);

	data_len = page_size * (map->nr_data_pages + 1);

	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED, fd, page_size);
	if (data == MAP_FAILED)
		pdie("mmap data");

	signal(SIGINT, signal_handler);

	page = ((struct ring_buffer_meta_page*)meta)->reader_page;
again:
	do {
		kbuffer_load_subbuffer(kbuf, data + page_size * page);

		if (page != start) {
			printf("READER PAGE: %d\n", map->reader_page);
		} else {
			kbuf->curr = prev_kbuf.curr;
			kbuf->index = prev_kbuf.index;
			kbuf->next = prev_kbuf.next;
			kbuf->timestamp = prev_kbuf.timestamp;
			kbuffer_next_event(kbuf, NULL);
		}

		prev_entries = map->entries;
		start = page;

		read_page(tep, kbuf, data, page);
	} while ((page = next_reader_page(fd, meta, kbuf)) != start);

	prev_kbuf.curr = kbuf->curr;
	prev_kbuf.index = kbuf->index;
	prev_kbuf.next = kbuf->next;
	prev_kbuf.timestamp = kbuf->timestamp;

	while (prev_entries == *(volatile __u64 *)&map->entries && !need_exit)
		usleep(100000);

	if (!need_exit)
		goto again;

	munmap(data, data_len);
	munmap(meta, page_size);
	close(fd);

	return 0;
}

Vincent Donnefort (2):
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Allow user-space mapping of the ring-buffer

 include/linux/ring_buffer.h     |   8 +
 include/uapi/linux/trace_mmap.h |  27 +++
 kernel/trace/ring_buffer.c      | 334 +++++++++++++++++++++++++++++++-
 kernel/trace/trace.c            |  73 ++++++-
 4 files changed, 436 insertions(+), 6 deletions(-)
 create mode 100644 include/uapi/linux/trace_mmap.h

-- 
2.40.0.rc1.284.g88254d51c5-goog

