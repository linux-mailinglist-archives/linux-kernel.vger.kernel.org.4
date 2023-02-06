Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9C768CA34
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBFXDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBFXDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:03:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA2BEFAF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675724577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HafLRwuDKhvMUB3t6snmTU2FQ23EqiYcnHLv7JdxfGI=;
        b=JIxOHIRB0JhHxtoW3iv2gCXyCegCZoMk953AVk2HAaemNQMfHSl/RKx01HO/G63cmJxY7c
        0RtDFDxTJ8IDXPsSNIRy5KilQBlY37UW0qD7rKPFTBsgB45oWy3HIi0xjn7uRvcsUdZKVE
        ttksdpeNNaAf2zdj9eEHZB3C6bHuRyE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-YY9qNXDPPFaf80fTCGFsuQ-1; Mon, 06 Feb 2023 18:02:54 -0500
X-MC-Unique: YY9qNXDPPFaf80fTCGFsuQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06B378027FD;
        Mon,  6 Feb 2023 23:02:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8950C15BA0;
        Mon,  6 Feb 2023 23:02:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
cc:     dhowells@redhat.com, David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Need help tracking down a bug in the bio-FOLL_PIN patches
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2811507.1675724572.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 06 Feb 2023 23:02:52 +0000
Message-ID: <2811508.1675724572@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens, Christoph,

I need some help tracking down a bug in the patches that make the bio usin=
g
page pinning or no pinning using iov_iter_extract_pages().  The bug causes
seemingly random memory corruption once the "block: Convert
bio_iov_iter_get_pages to use iov_iter_extract_pages" patch is applied.

The bug was detected by a syzbot special:

	https://lore.kernel.org/r/000000000000b0b3c005f3a09383@google.com/

The basic test body creates/opens a file, truncates it, opens it again
O_DIRECT and then uses sendfile to copy from the file to itself, causing t=
he
file to extend as it goes.  I've added a reduced testcase below.  Note tha=
t
the problem only seems to occur if several instances of the test are run i=
n
parallel.  After a few iterations, random memory corruption start showing =
up
and I see things like:

syz-direct-send[6095]: segfault at 0 ip 0000000000000000 sp 00007ffc81488b=
28 error 14 in syz-direct-sendfile[400000+1000] likely on CPU 0 (core 0, s=
ocket 0)
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
BUG: Bad rss-counter state mm:00000000d5d20a39 type:MM_FILEPAGES val:2
BUG: Bad rss-counter state mm:00000000d5d20a39 type:MM_ANONPAGES val:2
BUG: non-zero pgtables_bytes on freeing mm: 8192

The bug goes away if the file is not truncated, O_DIRECT is not used or tw=
o
different files are used.

I've investigated the splice and iov_iter code and looked at what sendfile=
()
is doing in this case:

 (1) sendfile creates buffer pages and adds them into a pipe, does an, in =
this
     case, DIO read into those pages, then calls the fs write_iter to writ=
e
     the data to the file.

 (2) iov_iter_extract_pages() does not get refs/pins on the pages extracte=
d
     from an ITER_PIPE iterator - but it shouldn't need to as the pipe hol=
ds
     the refs.  These pages are passed to DIO read - this op is synchronou=
s,
     so any bios associated with it should be complete.

 (3) I enabled the page_ref tracepoints and added a page flag to limit it =
to
     pages allocated by append_pipe().  This shows the buffer pipe pages b=
eing
     added and I made it dump the list of them in __bio_release_pages() (w=
hich
     I made non-optional in bio_release_pages()).

 (4) I added some extra page_ref_set tracepoints with weird "val" paramete=
rs
     to add markers into the log.

 (5) I added a tracepoint to trace the lifetime of a bio struct and a flag=
 to
     turn on the tracing, set when the pageflag added in (3) is seen.  Mos=
t of
     the time I can see the bio being destroyed in the correct order with
     regard to the splice code, though occasionally there's a bit missing.

 (6) Substituting a fixed preallocated page for the page coming out of the
     pipe in iter_file_splice_write() doesn't get rid of the bug:

	-	array[n].bv_page =3D buf->page;
	+	array[n].bv_page =3D splice_tmp;

 (7) Getting an extra ref on the buffer pipe page and deliberately leaking=
 it
     gets rid of the problem.

 (8) Substituting a fixed preallocated page for the page sent to the DIO r=
ead
     in iov_iter_extract_pipe_pages() gets rid of the problem.  The pages
     going through the pipe seem to passed to write_iter with no issues.

 (9) I've tried instrumenting kmap() and co. to catch debug-marked pages b=
eing
     accessed after they've been released, but didn't see anything.  This
     might not catch if DMA is doing the corrupting.

(10) On the notion that DMA might do the corrupting, I've tried adding a
     permanent ref on the pages, adding them to a list and scanning them
     occasionally - but that doesn't catch anything.

(11) KASAN doesn't spot anything interesting - which might also suggest
     DMA-based corruption.  But since we're dealing with the contents of
     pages, not the page structs themselves (I think), I'm not sure kasan
     would see spot anything.

I'm wondering if the apparent interaction with sendfile/splice is actually=
 a
red herring and that the page turnover that that induces is having an effe=
ct.

One thing I don't see is how commenting out ftruncate() should cause the
problem to go away if it's something to do with the splice buffer pipe -
though I guess ftruncate() would release a bunch of pages.

Here's an excerpt from a trace of something I'd expect to see:

   page_ref_set: pfn=3D0x10e38c flags=3Ddebug_mark count=3D1 mapcount=3D0 =
mapping=3D0 mt=3D0 val=3D777
   page_ref_set: pfn=3D0x10e38c flags=3Ddebug_mark count=3D1 mapcount=3D0 =
mapping=3D0 mt=3D0 val=3D666
   bio: bio=3D00038d84 ADD-PG I=3D10e38c
   bio: bio=3D00038d84 END-IO I=3D0
   page_ref_set: pfn=3D0x10e38c flags=3Ddebug_mark count=3D1 mapcount=3D0 =
mapping=3D0 mt=3D0 val=3D623
   bio: bio=3D00038d84 UNINIT I=3D0
   bio_endio: bio=3D00038d84 iomap_dio_bio_end_io+0x0/0xec
   bio: bio=3D00038d84 REL-PG I=3D0
   page_ref_set: pfn=3D0x10e38c flags=3Ddebug_mark count=3D1 mapcount=3D0 =
mapping=3D0 mt=3D0 val=3D980
   bio: bio=3D00038d84 FREE   I=3D0
   bio: bio=3D00038d84 UNINIT I=3D0
   page_ref_set: pfn=3D0x10e38c flags=3Ddebug_mark count=3D1 mapcount=3D0 =
mapping=3D0 mt=3D0 val=3D888
   page_ref_mod_and_test: pfn=3D0x10e38c flags=3Ddebug_mark count=3D0 mapc=
ount=3D0 mapping=3D0 mt=3D0 val=3D-1 ret=3D1

The weird val=3DN codes on page_ref_set lines are:
	777 - The page iov_iter_extract_pipe_pages() got from append_pipe()
	666 - __bio_add_page() adding a page
	623 - bio_endio() logging a page
	98n - __bio_release_pages() logging the nth page
	888 - iter_file_splice_write() adding page to array[]

But occasionally I'm seeing something like:

   page_ref_set: pfn=3D0x1102df flags=3Ddebug_mark count=3D1 mapcount=3D0 =
mapping=3D0000000000000000 mt=3D0 val=3D777
   page_ref_set: pfn=3D0x1102df flags=3Ddebug_mark count=3D1 mapcount=3D0 =
mapping=3D0000000000000000 mt=3D0 val=3D666
   bio: bio=3D0000e514 ADD-PG I=3D1102df
   page_ref_set: pfn=3D0x1102df flags=3Ddebug_mark count=3D1 mapcount=3D0 =
mapping=3D0000000000000000 mt=3D0 val=3D888
   page_ref_mod_and_test: pfn=3D0x1102df flags=3Ddebug_mark count=3D0 mapc=
ount=3D0 mapping=3D0000000000000000 mt=3D0 val=3D-1 ret=3D1

though I'm not sure why.  Could it be an attempt to read beyond the EOF?  =
I
don't see the bio being torn down, but the page is passed to
iter_file_splice_write() and released, despite for all I know still with
outstanding I/O pending.  Another possibility is that the bio flag got
cleared.

David
---
#define _GNU_SOURCE =

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/sendfile.h>
#include <sys/wait.h>

#define file_size 0x800
#define send_size 0x1dd00
#define repeat_count 1000

static char buffer[send_size];

int main(int argc, char *argv[])
{
	int in, out, i, wt;

	if (argc !=3D 2 || !argv[1][0]) {
		fprintf(stderr, "Usage: %s <file>\n", argv[0]);
		exit(2);
	}

	for (i =3D 0; i < repeat_count; i++) {
		switch (fork()) {
		case -1:
			perror("fork");
			exit(1);
		case 0:
			out =3D creat(argv[1], 0666);
			if (out < 0) {
				perror(argv[1]);
				exit(1);
			}

			if (ftruncate(out, file_size) < 0) {
				perror("ftruncate");
				exit(1);
			}

			if (lseek(out, 0x200, SEEK_SET) < 0) {
				perror("lseek");
				exit(1);
			}

			in =3D open(argv[1], O_RDONLY | O_DIRECT | O_NOFOLLOW);
			if (in < 0) {
				perror("open");
				exit(1);
			}

			if (sendfile(out, in, NULL, send_size) < 0) {
				perror("sendfile");
				exit(1);
			}
			exit(0);

		default:
			if (wait(&wt) < 0) {
				perror("wait");
				exit(1);
			}
			break;
		}
	}

	exit(0);
}

