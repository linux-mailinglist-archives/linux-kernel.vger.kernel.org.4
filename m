Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F0C69B515
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBQVsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjBQVso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:48:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE3BA260
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 13:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676670471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=if/tW06TDxxLKgUq7/Etw5p2PggjEQkfj1fwjUBcfbU=;
        b=gaUVGgmRCGeKph1anuoLJyKyYO4SzEaVK/86ry8g1wal5IUzdlD5AkJ5+Z7O/0QCmds3Dt
        D23kPDYEcu6eP2s0jGtB6A1QV+YMYjpOTrgD+3Qp4uFfirEiRbEZV934EMrXgFr0UniaDb
        4b8FuIsQ30XOgK0SHHFcrKKZloJ0jAU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-80wKAcFcPWuJ9_HZUpt2Bw-1; Fri, 17 Feb 2023 16:47:47 -0500
X-MC-Unique: 80wKAcFcPWuJ9_HZUpt2Bw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 631B23815F7B;
        Fri, 17 Feb 2023 21:47:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1328F492C3E;
        Fri, 17 Feb 2023 21:47:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87a61ckowk.fsf@oc8242746057.ibm.com>
References: <87a61ckowk.fsf@oc8242746057.ibm.com>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     dhowells@redhat.com, axboe@kernel.dk, david@redhat.com,
        hch@infradead.org, hch@lst.de, hdanton@sina.com, jack@suse.cz,
        jgg@nvidia.com, jhubbard@nvidia.com, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        logang@deltatee.com, viro@zeniv.linux.org.uk, willy@infradead.org,
        Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH v14 08/17] splice: Do splice read from a file without using ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <732890.1676670463.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 17 Feb 2023 21:47:43 +0000
Message-ID: <732891.1676670463@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does the attached fix the problem for you?  The data being written into th=
e
pipe needs to be limited to the size of the file.

David

diff --git a/mm/filemap.c b/mm/filemap.c
index c01bbcb9fa92..6362ac697a70 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2948,7 +2948,8 @@ ssize_t filemap_splice_read(struct file *in, loff_t =
*ppos,
 			if (writably_mapped)
 				flush_dcache_folio(folio);
 =

-			n =3D splice_folio_into_pipe(pipe, folio, *ppos, len);
+			n =3D min_t(loff_t, len, isize - *ppos);
+			n =3D splice_folio_into_pipe(pipe, folio, *ppos, n);
 			if (!n)
 				goto out;
 			len -=3D n;

