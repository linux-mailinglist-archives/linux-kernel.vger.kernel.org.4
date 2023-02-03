Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAB4689F4A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjBCQbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBCQbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:31:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A56A7ED4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675441828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=694N5msFhrkVa8LNaIWk1E6ovjIeS28rqb0Rrs8TYWA=;
        b=CAmam11XsU9+OYB2R6qOdQKg5VWLbIGYqtFfP4ltmHb/fGfnRPYP2go9jFTmz/WmEyjZfc
        CkHq/WTB2XiOXoyi9RawKTbUdnFMPh8b/6JSa35eR3OYnFIV5ws+Ld3stSFB++DcGaaHAq
        tDiOMmpIkbsfN+VxQVjkrN0ibPUE0ps=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131--QceGmEzO0a1HASQtfXEUw-1; Fri, 03 Feb 2023 11:30:23 -0500
X-MC-Unique: -QceGmEzO0a1HASQtfXEUw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AAD985A5B1;
        Fri,  3 Feb 2023 16:30:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3BF14024A7E;
        Fri,  3 Feb 2023 16:30:21 +0000 (UTC)
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
Content-ID: <2116766.1675441821.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 03 Feb 2023 16:30:21 +0000
Message-ID: <2116767.1675441821@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

> I think I have managed to isolate the bug to the read side of sendfile()=
 or
> the pipe in the middle by the following:
> =

> In iter_file_splice_write(), I allocate a permanent page:
> ...
> and then stick it into the BVEC iter to be handed over to vfs_iter_write=
()
> instead of buf->page:
> =

> -			array[n].bv_page =3D buf->page;
> +			array[n].bv_page =3D splice_tmp;
> +			trace_page_ref_set(splice_tmp, 887);
>  			array[n].bv_len =3D this_len;
>  			array[n].bv_offset =3D buf->offset;
> =

> that prevents vfs_iter_write() from ever seeing the pages from the pipe =
- but
> the crash still happens even with this change.

With the DIO output isolation in iov_iter_extract_pipe_pages(), this chang=
e
can be removed without causing oopses to happen.

David

