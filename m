Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE586937F5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBLPdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBLPdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:33:10 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E74AC14C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 07:33:06 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id r14-20020a05600c35ce00b003e10bfcd160so5405389wmq.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 07:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g1HftSdGyS004IfwkhWh+8a8ByAjMnKCXMzaWQVPz6Y=;
        b=rHkr2bczWXfZ1Rf97Gh0VrrFih+78H7JeiMK7C/qRIz9lQ1udj+40H1Rh/TFQvsh8P
         UjPF2XgYEV4WGLGM7+Z27spRJQdJdE51gA1M2u3NWYD3OvkLTKrMh17ymzJ1HdY4f5zd
         ryWPpriPCJW1oiX+Ee8j35kimhfGgbekolQF9p6SJexZfFg1/oeRZK/Q8vgf0/6hHvvZ
         IdiQs1JKNCKvGZ50Dgo4UPz1Fap8bguAfbjHIejQMOFNsjiunNdgOf/QtFgp1C9bkpsA
         08nAcd4yCu2xJrZhpmqLODzvYbv5H+ab5mPIQR5kSxo4f6D5elGvL9J5tyr5RUJP2DJd
         /PjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1HftSdGyS004IfwkhWh+8a8ByAjMnKCXMzaWQVPz6Y=;
        b=LInne4NJp5TQ8K/9PFeDsZn7DCc+ooGRA+aH7CFbusv8MGD4z7Gp/Cz4vk8w0Vdbvh
         P6yXOQlYWRUFrpUuxVm3EReLqNJ/ialKRNSrbaIUsNZrLd5NsCCXM673DQbLoVPLtu82
         J5hraIVZaxGb20DipqDtLGtO4z6dQ4UT0HC30SYfYU72a386t/u0cGM9x4GBuBylO+sY
         E80N3X5RbSPLJrHj+k6bLddUuPOyofH5lAfED5pXu179moMlfKuZtDgm93ke3fwTAn3C
         d36+nJ4+iFzOQ360zEB/gHLO4ill7VamBr36E7u7PvcJLLmKasWLC/2PjaxYXPjyqQi9
         BiYQ==
X-Gm-Message-State: AO0yUKV8cLgU7325XtNr7mBuvpOWn5A52DkzzzgIoaWCmXxOx1C5+K1y
        8Jw9LQB/GTE+bcd3skPiB71DCQ9LNsoUp0Rd
X-Google-Smtp-Source: AK7set/6pZyWnv50IgvomJ7ZKuznSHwum6yJMKBwSx08PcWBdT0+XZf7b1DGjid04ZOAt4M0/f8tesHIK8UASQLr
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:2045:b0:3dc:5ad2:86ed with
 SMTP id p5-20020a05600c204500b003dc5ad286edmr939213wmg.33.1676215984389; Sun,
 12 Feb 2023 07:33:04 -0800 (PST)
Date:   Sun, 12 Feb 2023 15:32:48 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230212153250.1099136-1-vdonnefort@google.com>
Subject: [RFC PATCH 0/2] Introducing trace buffer mapping by user-space
From:   Vincent Donnefort <vdonnefort@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We (Android folks) have been recently working on bringing tracing to the
pKVM hypervisor (more about pKVM? [1] [2]) reusing as much as possible the
tracefs support already available in the host. More specifically, sharing
the ring_buffer_per_cpu between the kernel and the hypervisor, the later
being the writer while the former is only reading. After presenting this
endeavour at the tracingsummit, end of last year [3], Steven observed this
is a similar problem to another idea he had a while ago: mapping the
tracing ring buffers directly into userspace.

The tracing ring-buffer can be stored or sent to network without any copy
via splice. However the later doesn't allow real time processing of the
traces by userspace without a copy, which can only be achieved by letting
userspace map directly the ring-buffer.

And indeed, in both ideas, we have a ring-buffer, an entity being the
writer, the other being a reader and both share the ring buffer pages while
having different VA spaces. So here's an RFC bringing userspace mapping of
a ring-buffer and if it doesn't cover the pKVM hypervisor it nonetheless
brings building blocks that will be reused later.

Any feedback very much appreciated.

Vincent

[1] https://lwn.net/Articles/836693/
[2] https://www.youtube.com/watch?v=9npebeVFbFw
[3] https://tracingsummit.org/ts/2022/hypervisortracing/

-- 

As an example, Steve wrote this quick demo that only needs libtracefs:

  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <stdarg.h>
  #include <errno.h>
  #include <unistd.h>
  #include <tracefs.h>
  #include <kbuffer.h>
  #include <event-parse.h>
  
  #include <asm/types.h>
  #include <sys/mman.h>
  #include <sys/ioctl.h>
  
  #define TRACE_MMAP_IOCTL_GET_READER_PAGE	_IO('T', 0x1)
  #define TRACE_MMAP_IOCTL_UPDATE_META_PAGE	_IO('T', 0x2)
  
  struct ring_buffer_meta_page {
  	__u64		entries;
  	__u64		overrun;
  	__u32		pages_touched;
  	__u32		reader_page;
  	__u32		nr_data_pages;
  	__u32		data_page_head;
  	__u32		data_pages[];
  };
  
  static char *argv0;
  static int page_size;
  
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
  
  static void usage(void)
  {
  	char *p = get_this_name();
  
  	printf("usage: %s exec\n"
  	       "\n",p);
  	exit(-1);
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
  
  void die(const char *fmt, ...)
  {
  	va_list ap;
  
  	va_start(ap, fmt);
  	__vdie(fmt, ap, 0);
  	va_end(ap);
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
  
  	kbuffer_load_subbuffer(kbuf, data + page_size * page);
  	while ((record.data = kbuffer_read_event(kbuf, &record.ts))) {
  		kbuffer_next_event(kbuf, NULL);
  		tep_print_event(tep, &seq, &record,
  				"%s-%d %9d\t%s: %s\n",
  				TEP_PRINT_COMM,
  				TEP_PRINT_PID,
  				TEP_PRINT_TIME,
  				TEP_PRINT_NAME,
  				TEP_PRINT_INFO);
  		trace_seq_do_printf(&seq);
  		trace_seq_reset(&seq);
  	}
  }
  
  static int get_reader_page(int fd, struct ring_buffer_meta_page *meta)
  {
  	return meta->reader_page;
  }
  
  static int next_reader_page(int fd, struct ring_buffer_meta_page *meta)
  {
  	if (ioctl(fd, TRACE_MMAP_IOCTL_GET_READER_PAGE) < 0)
  		pdie("ioctl");
  	return meta->reader_page;
  }
  
  int main (int argc, char **argv)
  {
  	struct ring_buffer_meta_page *map;
  	struct tep_handle *tep;
  	struct kbuffer *kbuf;
  	unsigned long *p;
  	void *meta;
  	void *data;
  	char *buf;
  	int data_len;
  	int start;
  	int page;
  	int fd;
  
  	argv0 = argv[0];
  
  	tep = tracefs_local_events(NULL);
  	kbuf = tep_kbuffer(tep);
  
  	page_size = getpagesize();
  
  	fd = tracefs_instance_file_open(NULL, "per_cpu/cpu0/trace_pipe_raw",
  					O_RDONLY);
  	if (fd < 0)
  		pdie("raw");
  
  	meta = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
  	if (meta == MAP_FAILED)
  		pdie("mmap");
  
  	if (ioctl(fd, TRACE_MMAP_IOCTL_UPDATE_META_PAGE) < 0)
  		pdie("ioctl");
  
  	map = meta;
  	printf("entries:	%llu\n", map->entries);
  	printf("overrun:	%llu\n", map->overrun);
  	printf("pages_touched:	%u\n", map->pages_touched);
  	printf("reader_page:	%u\n", map->reader_page);
  	printf("nr_data_pages:	%u\n\n", map->nr_data_pages);
  
  	data_len = page_size * map->nr_data_pages;
  
  	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED, fd, page_size);
  	if (data == MAP_FAILED)
  		pdie("mmap data");
  
  	page = get_reader_page(fd, meta);
  	start = page;
  	do {
  		read_page(tep, kbuf, data, page);
  		printf("reader_page:	%u\n", map->reader_page);
  		printf("PAGE: %d\n", page);
  	} while ((page = next_reader_page(fd, meta)) != start);
  	
  	p = data;
  	printf("%lx\n%lx\n%lx\n\n", p[0], p[1], p[2]);
  
  	munmap(data, data_len);
  	munmap(meta, page_size);
  	close(fd);
  
  	buf = tracefs_instance_file_read(NULL, "per_cpu/cpu0/stats", NULL);
  	if (!buf)
  		pdie("stats");
  	printf("%s\n", buf);
  	free(buf);
  
  
  	return 0;
  }

Vincent Donnefort (2):
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Allow user-space mapping of the ring-buffer

 include/linux/ring_buffer.h     |   8 +
 include/uapi/linux/trace_mmap.h |  17 ++
 kernel/trace/ring_buffer.c      | 355 +++++++++++++++++++++++++++++++-
 kernel/trace/trace.c            |  74 ++++++-
 4 files changed, 441 insertions(+), 13 deletions(-)
 create mode 100644 include/uapi/linux/trace_mmap.h

-- 
2.39.1.581.gbfd45094c4-goog

