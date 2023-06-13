Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E1B72DC8A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbjFMIf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240870AbjFMIfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:35:25 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE25E6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:35:23 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-30fa3ea38bcso1347236f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686645321; x=1689237321;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9J53u8rH/oco2XUjfDmDbG8cc4V2zsexlwr0RX07LCQ=;
        b=GvKNgovkNbB45iZAOHhj1ScRHLBviSop8boniWse3Ggzu6ujA/XZW5LmHO9qorFHzn
         4n7EqXRWx/qKMB4t28NtuIVXeCEcrIEOn/elwxO+C3qXTb3YSOZE3kdmnapb5sp8KzyI
         TXDl6V/JP6PLs0d/400CNRFbzkiqnWpk4ddEo/3CF9zwSHBHcmhahhLlthC1iEKOc7Y3
         6tbKSbVeAPNhayF/wN7u1CPgk7AJrtqkb6nIOMg0MPcYDReGMvtgRTWzdwkBjjC4gKxz
         gKYE4XRUqjyLA8djlJlGuAU7N/S75ePp95nzyt6vCKK4HMXunq4ms4PxAQJM46NsEWnK
         LVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686645321; x=1689237321;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9J53u8rH/oco2XUjfDmDbG8cc4V2zsexlwr0RX07LCQ=;
        b=C6eFkyNtZpQP6YXxNDBMeCWZ5Y1Hg8dpQqbtALuKDBicsE767l3kT9fUoJaRznLKBi
         iHm9MBcF7cCNUJBKnEgAnIFFibfypOCrFPMa4y8GyxmiEJzEEijBZRxJcLKWHIzImh/7
         ws6TF93AZjylJdCDdpe+tVKnOtvZYeFupKP8l93fuYAkpRdagT6LELMnUcsbi0PpTF8i
         ifNxbDtCJImfu52lRErV0cy40OkwQuBYrrqGwlIsrq53P7Raevx9GiqxcbG+T0kgiM1b
         yUkiJ0GNOnQ+vZrUxk0I7vhED3UkiDOPD7Ljv4k27OEIB0xgP2/J+dVjh9Rne2yUSQbg
         1vbg==
X-Gm-Message-State: AC+VfDyok9+0bEg/ZDxuzS5G7Au/pwnMCtAcXmYUMfyydhIhtMlpEzTD
        WoWyJwyJkJtejyYcc2nery7AUynLGZ6Lw2eM
X-Google-Smtp-Source: ACHHUZ62ynjzSsdB3NqjjT23tvTcZEgedzffD7a8cAMs9LjIhsiVu3ktl6E8mD+yHWJCgfhzmbrR9Y2oILBY6arh
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:adf:dd52:0:b0:30f:c50e:7cd9 with SMTP
 id u18-20020adfdd52000000b0030fc50e7cd9mr421306wrm.7.1686645321644; Tue, 13
 Jun 2023 01:35:21 -0700 (PDT)
Date:   Tue, 13 Jun 2023 09:35:11 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230613083513.3312612-1-vdonnefort@google.com>
Subject: [PATCH v4 0/2] Introducing trace buffer mapping by user-space
From:   Vincent Donnefort <vdonnefort@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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

v3 -> v3:
  * Add to the meta-page:
       - pages_lost / pages_read (allow to compute how full is the ring-buffer)
       - read (allow to compute how many entries can be read)
       - A reader_page struct.
  * Rename ring_buffer_meta_header -> ring_buffer_meta
  * Rename ring_buffer_get_reader_page -> ring_buffer_map_get_reader_page
  * Properly consume events on ring_buffer_map_get_reader_page() with
    rb_advance_reader().

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
 include/uapi/linux/trace_mmap.h |  28 +++
 kernel/trace/ring_buffer.c      | 322 +++++++++++++++++++++++++++++++-
 kernel/trace/trace.c            |  72 ++++++-
 4 files changed, 422 insertions(+), 7 deletions(-)
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

struct ring_buffer_meta {
        unsigned long   entries;
        unsigned long   overrun;
        unsigned long   read;

        unsigned long   pages_touched;
        unsigned long   pages_lost;
        unsigned long   pages_read;

        __u32           meta_page_size;
        __u32           nr_data_pages;  /* Number of pages in the ring-buffer */

        struct reader_page {
                __u32   id;             /* Reader page ID from 0 to nr_data_pages - 1 */
                __u32   read;           /* Number of bytes read on the reader page */
                unsigned long   lost_events; /* Events lost at the time of the reader swap */
        } reader_page;
};

static char *argv0;
static bool exit_requested;

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

#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))

static unsigned long number_entries(struct ring_buffer_meta *meta)
{
	return READ_ONCE(meta->entries) - (READ_ONCE(meta->overrun) +
					   READ_ONCE(meta->read));
}

static void read_page(struct tep_handle *tep, struct kbuffer *kbuf)
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

static int next_reader_page(int fd, struct ring_buffer_meta *meta, unsigned long *read)
{
	__u32 prev_reader, new_reader;
	unsigned long prev_read;

	prev_read = READ_ONCE(meta->reader_page.read);
	prev_reader = READ_ONCE(meta->reader_page.id);
	if (ioctl(fd, TRACE_MMAP_IOCTL_GET_READER_PAGE) < 0)
		pdie("ioctl");
	new_reader = READ_ONCE(meta->reader_page.id);

	if (prev_reader != new_reader)
		*read = 0;
	else
		*read = prev_read;

	return new_reader;
}

static void signal_handler(int unused)
{
	printf("Exit!\n");
	exit_requested = true;
}

int main(int argc, char **argv)
{
	int page_size, meta_len, data_len, page, fd;
	struct ring_buffer_meta *map;
	struct tep_handle *tep;
	struct kbuffer *kbuf;
	unsigned long read;
	void *meta, *data;
	char path[32];
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
	map = (struct ring_buffer_meta *)meta;
	meta_len = map->meta_page_size;

	printf("entries:	%lu\n", map->entries);
	printf("overrun:	%lu\n", map->overrun);
	printf("read:		%lu\n", map->read);
	printf("pages_touched:	%lu\n", map->pages_touched);
	printf("pages_lost:	%lu\n", map->pages_lost);
	printf("pages_read:	%lu\n", map->pages_read);

	data_len = page_size * map->nr_data_pages;
	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED, fd, meta_len);
	if (data == MAP_FAILED)
		pdie("mmap data");

	signal(SIGINT, signal_handler);

	while (!exit_requested) {
		if (!number_entries(map)) {
			usleep(100000);
			continue;
		}

		page = next_reader_page(fd, map, &read);
		kbuffer_load_subbuffer(kbuf, data + page_size * page);
		while (kbuf->curr < read)
			kbuffer_next_event(kbuf, NULL);

		read_page(tep, kbuf);
	}

	munmap(data, data_len);
	munmap(meta, page_size);
	close(fd);

	return 0;
}
-- 
2.41.0.162.gfafddb0af9-goog

