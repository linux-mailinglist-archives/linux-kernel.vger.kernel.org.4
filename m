Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70398689C03
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjBCOhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjBCOha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:37:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F69A3B3FB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675435003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OusdvQmEd+b+L9V42P0FNXwc+VhYOROhGnUOon3UdU0=;
        b=I+Eu9BfNjLTIMJ0L6fhlwQ3U+1lNGeCSuNm4FpSxJEJ+CX0n1QZzo7rYZp9JGpHcs/rS6P
        X1ySYHjPi2uylTNiRYjm6I3ID1pLeQpRlbSrwHis9ajQuPPoy5IZ6G260HEk+UG6qNkuOM
        SW2SD7DEctdJ/mfyX/0bTDG8MOjgLyA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-bYNyA8h0N0CTKTdD0dkU7Q-1; Fri, 03 Feb 2023 09:36:39 -0500
X-MC-Unique: bYNyA8h0N0CTKTdD0dkU7Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34846801779;
        Fri,  3 Feb 2023 14:36:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 108C9492C14;
        Fri,  3 Feb 2023 14:36:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <72029a93-1150-1994-916f-b15ef0befd49@nvidia.com>
References: <72029a93-1150-1994-916f-b15ef0befd49@nvidia.com> <e8065d6a-d2f9-60aa-8541-8dfc8e9b608f@redhat.com> <000000000000b0b3c005f3a09383@google.com> <822863.1675327935@warthog.procyon.org.uk> <1265629.1675350909@warthog.procyon.org.uk>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     dhowells@redhat.com, David Hildenbrand <david@redhat.com>,
        syzbot <syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com>,
        hch@lst.de, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] general protection fault in skb_dequeue (3)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2076816.1675434996.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 03 Feb 2023 14:36:36 +0000
Message-ID: <2076817.1675434996@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think I have managed to isolate the bug to the read side of sendfile() o=
r
the pipe in the middle by the following:

In iter_file_splice_write(), I allocate a permanent page:

+	mutex_lock(&splice_tmp_lock);
+	if (!splice_tmp) {
+		pr_notice("alloc splice_tmp\n");
+		splice_tmp =3D alloc_page(GFP_USER);
+		if (splice_tmp) {
+			SetPageDebugMark(splice_tmp);
+			page_ref_add(splice_tmp, 100);
+		}
+	}
+	mutex_unlock(&splice_tmp_lock);
+	if (!splice_tmp)
+		return -ENOMEM;
+

and then stick it into the BVEC iter to be handed over to vfs_iter_write()
instead of buf->page:

-			array[n].bv_page =3D buf->page;
+			array[n].bv_page =3D splice_tmp;
+			trace_page_ref_set(splice_tmp, 887);
 			array[n].bv_len =3D this_len;
 			array[n].bv_offset =3D buf->offset;

that prevents vfs_iter_write() from ever seeing the pages from the pipe - =
but
the crash still happens even with this change.

One thing that does make me wonder is that I've made bio_release_pages()
always call __bio_release_pages() and made the latter dump all the pages i=
n
the bio to the trace with val=3D999 - but some of the time, I don't see th=
at
happening, so I'm wondering if there are some bio structs with pointers to
released pages floating around and not getting cleaned up.

I've added some event-specific tracepoints using the page_ref_set tracepoi=
nt,
using val=3DN as a key indicate the event:

val=3D888 -> Page seen in iter_file_splice_write() with PG_debug_mark set.
val=3D887 -> splice_tmp subbed for page
val=3D777 -> Page obtained from append_pipe() in iov_iter_extract_pipe_pag=
es()
val=3D623 -> Page listed in bio_endio()
val=3D666 -> Page added by __bio_add_page()
val=3D98x -> xth page listed by __bio_release_pages()
val=3D-1  -> put_page()

Here's an excerpt from the trace when it looks right (note I removed
mapcount=3D0 from all lines):

page_ref_set: pfn=3D0x10b70b flags=3Ddebug_mark count=3D1 mapping=3D000000=
0000000000 mt=3D0 val=3D777
page_ref_set: pfn=3D0x10b70b flags=3Ddebug_mark count=3D1 mapping=3D000000=
0000000000 mt=3D0 val=3D666
page_ref_set: pfn=3D0x10b70b flags=3Ddebug_mark count=3D1 mapping=3D000000=
0000000000 mt=3D0 val=3D623
page_ref_set: pfn=3D0x10b70b flags=3Ddebug_mark count=3D1 mapping=3D000000=
0000000000 mt=3D0 val=3D980
page_ref_set: pfn=3D0x10b70b flags=3Ddebug_mark count=3D1 mapping=3D000000=
0000000000 mt=3D0 val=3D888
page_ref_set: pfn=3D0x10642f flags=3Ddebug_mark count=3D101 mapping=3D0000=
000000000000 mt=3D0 val=3D887
page_ref_mod_and_test: pfn=3D0x116209 flags=3Duptodate|dirty|debug_mark co=
unt=3D2 mapping=3D00000000d367da24 mt=3D1 val=3D-1 ret=3D0
page_ref_mod_and_test: pfn=3D0x10b70b flags=3Ddebug_mark count=3D0 mapping=
=3D0000000000000000 mt=3D0 val=3D-1 ret=3D1
page_ref_set: pfn=3D0x116209 flags=3Dlocked|uptodate|debug_mark count=3D3 =
mapping=3D00000000d367da24 mt=3D1 val=3D666
page_ref_mod_and_test: pfn=3D0x116209 flags=3Duptodate|lru|writeback|debug=
_mark count=3D2 mapping=3D00000000d367da24 mt=3D1 val=3D-1 ret=3D0
page_ref_mod_and_test: pfn=3D0x116209 flags=3Duptodate|lru|writeback|debug=
_mark count=3D1 mapping=3D00000000d367da24 mt=3D1 val=3D-1 ret=3D0
page_ref_set: pfn=3D0x116209 flags=3Dwaiters|uptodate|lru|writeback|debug_=
mark count=3D2 mapping=3D00000000d367da24 mt=3D1 val=3D623
page_ref_mod_and_test: pfn=3D0x116209 flags=3Duptodate|lru|debug_mark coun=
t=3D2 mapping=3D00000000d367da24 mt=3D1 val=3D-1 ret=3D0
page_ref_mod_and_test: pfn=3D0x116209 flags=3Duptodate|lru|debug_mark coun=
t=3D1 mapping=3D00000000d367da24 mt=3D1 val=3D-1 ret=3D0

pfn=3D0x10b70b is a page pulled out of the pipe, pfn=3D0x10642f is splice_=
tmp (has
count=3D101) and pfn=3D0x116209 is presumably the page the data is to be w=
ritten
to.

And when it looks off:

page_ref_set: pfn=3D0x106fca flags=3Ddebug_mark count=3D1 mapping=3D000000=
0000000000 mt=3D0 val=3D777
page_ref_set: pfn=3D0x106fca flags=3Ddebug_mark count=3D1 mapping=3D000000=
0000000000 mt=3D0 val=3D666
page_ref_set: pfn=3D0x106fca flags=3Ddebug_mark count=3D1 mapping=3D000000=
0000000000 mt=3D0 val=3D888
page_ref_set: pfn=3D0x11e6bc flags=3Ddebug_mark count=3D101 mapping=3D0000=
000000000000 mt=3D0 val=3D887
page_ref_mod_and_test: pfn=3D0x11399a flags=3Duptodate|dirty|debug_mark co=
unt=3D2 mapping=3D000000003bd7df47 mt=3D1 val=3D-1 ret=3D0
page_ref_mod_and_test: pfn=3D0x106fca flags=3Ddebug_mark count=3D0 mapping=
=3D0000000000000000 mt=3D0 val=3D-1 ret=3D1
page_ref_set: pfn=3D0x11399a flags=3Dlocked|uptodate|debug_mark count=3D3 =
mapping=3D000000003bd7df47 mt=3D1 val=3D666
page_ref_mod_and_test: pfn=3D0x11399a flags=3Duptodate|lru|writeback|debug=
_mark count=3D2 mapping=3D000000003bd7df47 mt=3D1 val=3D-1 ret=3D0
page_ref_mod_and_test: pfn=3D0x11399a flags=3Duptodate|lru|writeback|debug=
_mark count=3D1 mapping=3D000000003bd7df47 mt=3D1 val=3D-1 ret=3D0
page_ref_mod_and_test: pfn=3D0x11399a flags=3Duptodate|lru|debug_mark coun=
t=3D1 mapping=3D000000003bd7df47 mt=3D1 val=3D-1 ret=3D0

pfn=3D0x106fca is the page from the pipe, pfn=3D0x11e6bc is splice_tmp and
pfn=3D0x11399a is the destination.

In the first trace, there's a val=3D980 line (page released from bio), but=
 not
in the second trace.

David

