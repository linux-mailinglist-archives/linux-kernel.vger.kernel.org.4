Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3248689F1E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjBCQZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjBCQY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:24:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434DFA6B97
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675441446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oW45kccjUKB0azEOuaFwFd8f5AOwrTQBVn+oOQKIx4o=;
        b=JXi7iIOyVEcIILZXXqv2Yaf3tLKqgiF4bfMEWcY1kOkWua9KsQfed1eixTnwCbUj+fBFEV
        Xw6qc9WfvBD0YFK5GTVrGjEBp551E1yXGZSA3QQF7/BsrMnfG9en+G8JpFxiyO9ZvyhmeX
        1qsDygL6xXvUwUbNGpQRau74PQsWoc0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-M3Bi6QznOKWAvl_h0evyEQ-1; Fri, 03 Feb 2023 11:24:00 -0500
X-MC-Unique: M3Bi6QznOKWAvl_h0evyEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 700C387A380;
        Fri,  3 Feb 2023 16:24:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97616C15BA0;
        Fri,  3 Feb 2023 16:23:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2076817.1675434996@warthog.procyon.org.uk>
References: <2076817.1675434996@warthog.procyon.org.uk> <72029a93-1150-1994-916f-b15ef0befd49@nvidia.com> <e8065d6a-d2f9-60aa-8541-8dfc8e9b608f@redhat.com> <000000000000b0b3c005f3a09383@google.com> <822863.1675327935@warthog.procyon.org.uk> <1265629.1675350909@warthog.procyon.org.uk>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     dhowells@redhat.com, David Hildenbrand <david@redhat.com>,
        syzbot <syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com>,
        hch@lst.de, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] general protection fault in skb_dequeue (3)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2112098.1675441439.1@warthog.procyon.org.uk>
Date:   Fri, 03 Feb 2023 16:23:59 +0000
Message-ID: <2112099.1675441439@warthog.procyon.org.uk>
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

David Howells <dhowells@redhat.com> wrote:

> I think I have managed to isolate the bug to the read side of sendfile() or
> the pipe in the middle by the following:

I did something similar in iov_iter_extract_pipe_pages(), allocating a
permanent page there:

+	mutex_lock(&extract_tmp_lock);
+	if (!extract_tmp) {
+		pr_notice("alloc extract_tmp\n");
+		extract_tmp = alloc_page(GFP_USER);
+		if (extract_tmp) {
+			SetPageDebugMark(extract_tmp);
+			page_ref_add(extract_tmp, 200);
+		}
+	}
+	mutex_unlock(&extract_tmp_lock);
+	if (!extract_tmp)
+		return -ENOMEM;

and then subbing that for the returned page:

 		chunk = min_t(size_t, left, PAGE_SIZE - offset);
 		left -= chunk;
-		*p++ = page;
+		//*p++ = page;
+		*p++ = extract_tmp;

That makes the oopses stop happening.  Pages are still being added to the pipe
at one end and being removed at the other.

So I'm guessing a DMA happens to the destination buffer for the DIO read after
it has been released.

David

