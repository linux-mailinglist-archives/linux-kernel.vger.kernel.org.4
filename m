Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2233F6DC0E1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 19:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjDIRjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 13:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDIRjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 13:39:31 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE3C35BC
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 10:39:29 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id n3-20020a05600c3b8300b003f048e0e09eso2993280wms.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 10:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681061968;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0bl4zqlNb9E20d6s59Y0GapPaxoNDljk2I3jc046xAg=;
        b=lCYCTAha2OqpLtQskRz0mq3Emcsz63lPeZCH+BAMbdjf2FM4/UgaDaolnJoaDRtuyC
         3CaFlp8A2qOcX+Tps/GalQd0caULnQE3E2gL3sukCF9Dibj8H3IEySD+Qu0H0OQUCCmL
         X6yV+qBji1TrnRrTqP98+nYm/cytCIYfW0HQtJ3Xcryz3VeUFV99w31+BdsmppAqyMZO
         2wQcqQw9FAVLMFcms0OIA232BlAhuLMI+wY0QXp7Zwh6kByIGayhZ7G6nzTzIFeBlrtA
         2UWA34QCsxxUz1ohA+FTRKfscgbMESvcIyxtv7LjDxU7EFOSdMmgm6lf8/za0lygGESo
         foXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681061968;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0bl4zqlNb9E20d6s59Y0GapPaxoNDljk2I3jc046xAg=;
        b=aVTVshPATG8cOiVoDq1vszwjboq0XGiYOJw5MWHVRcGwjuxt6mgDV56v0hx2Um4pHg
         D1W0f87K6ek2kgK4jNqWOD+YOabW1KsK2Oel//qeD/kiBvhmQiKQYb8in90R0MiE/4R4
         Bx/KoVYIXtpbErf9sAWIochxDvlR61AxtiUHZpgiWR3iQv8t3wWKUcR/Ab25xSFdJaSs
         Ygk4d+IEsLMI3n6r7gnLdZkQ0u0f3yZrn8uwTErAVcdEci8E/PhPhJPKIk1LVnoS26Bb
         ZEbHrjtjyrtrbgKDlxNMx1wcZMrZrdZ0MYWhynMPkidSac0ejOhMOnhCNhJl9x1LySlq
         jSMQ==
X-Gm-Message-State: AAQBX9cy8yh21QlQQBqwAsRJM6KHFv2Q+GOOuQeJ8ForQ2UNUWU+xhrv
        fN42L5ObINbwI+X89Jess7UtEiB1M9Z5q7kT
X-Google-Smtp-Source: AKy350aKMOIIi6PeNWWSn6mpi/CdFdwE9EVEv5sFvpWYCzJOCVYNxsCSzKsgDaFYKNATC97auc6atc1bKtLraEP4
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a1c:4b0e:0:b0:3ed:c669:8a13 with SMTP
 id y14-20020a1c4b0e000000b003edc6698a13mr1681554wma.8.1681061968145; Sun, 09
 Apr 2023 10:39:28 -0700 (PDT)
Date:   Sun,  9 Apr 2023 18:39:21 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230409173923.1822455-1-vdonnefort@google.com>
Subject: [PATCH v3 0/2] Introducing trace buffer mapping by user-space
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

The tracing ring-buffers can be stored on disk or sent to network without any
copy via splice. However the later doesn't allow real time processing of the
traces. A solution is to give access to userspace to the ring-buffer pages
directly via a mapping. A piece of software can now become a reader of the
ring-buffer, and drive a consuming or non-consuming read in a similar fashion to
what trace and trace_pipe offer.

Attached to this cover letter an example of consuming read for a ring-buffer,
using libtracefs.

Vincent

v2 -> v3:
  * Remove data page list (for non-consuming read)
    ** Implies removing order > 0 meta-page
  * Add a new meta page field ->read
  * Rename ring_buffer_meta_page_header into ring_buffer_meta_header

v1 -> v2:
  * Hide data_pages from the userspace struct
  * Fix META_PAGE_MAX_PAGES
  * Support for order > 0 meta-page
  * Add missing page->mapping.

Vincent Donnefort (2):
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Allow user-space mapping of the ring-buffer

 include/linux/ring_buffer.h     |   7 +
 include/uapi/linux/trace_mmap.h |  26 +++
 kernel/trace/ring_buffer.c      | 302 +++++++++++++++++++++++++++++++-
 kernel/trace/trace.c            |  72 +++++++-
 4 files changed, 400 insertions(+), 7 deletions(-)
 create mode 100644 include/uapi/linux/trace_mmap.h

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

struct ring_buffer_meta_header {
        __u64   entries;
        __u64   overrun;
        __u32   pages_touched;
        __u32   meta_page_size;
        __u32   nr_data_pages;  /* Number of pages in the ring-buffer */
        __u32   reader_page;    /* Reader page ID, from 0 to nr_data_pages - 1 */
        __u32   read;           /* Number of bytes read on the current reader page */
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

static int next_reader_page(int fd, struct ring_buffer_meta_header *meta,
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
	int page_size, meta_len, data_len, page, fd, start = -1;
	unsigned long prev_read, prev_entries;
	struct ring_buffer_meta_header *map;
	unsigned long long prev_timestamp;
	struct tep_handle *tep;
	struct kbuffer *kbuf;
	void *meta, *data;
	char *buf, path[32];
	int cpu;

	if (argc != 2)
		return -EINVAL;

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
	map = (struct ring_buffer_meta_header *)meta;
	meta_len = map->meta_page_size;

	printf("entries:	%llu\n", map->entries);
	printf("overrun:	%llu\n", map->overrun);
	printf("pages_touched:	%u\n", map->pages_touched);
	printf("reader_page:	%u\n", map->reader_page);
	printf("nr_data_pages:	%u\n\n", map->nr_data_pages);

	data_len = page_size * map->nr_data_pages;
	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED, fd, meta_len);
	if (data == MAP_FAILED)
		pdie("mmap data");

	signal(SIGINT, signal_handler);

	page = map->reader_page;
again:
	prev_read = map->read;

	do {
		kbuffer_load_subbuffer(kbuf, data + page_size * page);

		kbuf->curr = kbuf->index = kbuf->next = prev_read;
		kbuffer_next_event(kbuf, NULL);

		if (page != start)
			printf("READER PAGE: %d\n", map->reader_page);
		else
			kbuf->timestamp = prev_timestamp;

		start = page;

		read_page(tep, kbuf, data, page);
	} while ((page = next_reader_page(fd, meta, kbuf)) != start);

	prev_timestamp = kbuf->timestamp;
	prev_entries = map->entries;

	while (prev_entries == *(volatile __u64 *)&map->entries && !need_exit)
		usleep(100000);

	if (!need_exit)
		goto again;

	munmap(data, data_len);
	munmap(meta, page_size);
	close(fd);

	return 0;
}

-- 
2.40.0.577.gac1e443424-goog

