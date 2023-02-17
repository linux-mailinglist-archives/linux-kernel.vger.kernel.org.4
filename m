Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF2769A7FD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjBQJTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBQJTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:19:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14DD1F932
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676625500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JSjyZXclMQ8QT9phi3XaRxJO/pegb5ftImQVRxiePjc=;
        b=f9PrTRSgJ0SJCGyAHEn2MD2CSbe4ADhPKLqxSF6YuJZNrzro8A+Vn+wgy4ZY87wZNNTcre
        +G4rtVrXTWFCTE9cDnjYN59inozvaflE34fs7R+r85swNQF69Zy9jokUspabJQURoLL2qY
        Tk+21/JfrMlI3vtl52/VAkcEzGeNCf4=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-EAOgbfjHPKO4b4YoOt-oMQ-1; Fri, 17 Feb 2023 04:18:19 -0500
X-MC-Unique: EAOgbfjHPKO4b4YoOt-oMQ-1
Received: by mail-ua1-f72.google.com with SMTP id br27-20020ab03e9b000000b0068b9f3e0a2dso1116047uab.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676625498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSjyZXclMQ8QT9phi3XaRxJO/pegb5ftImQVRxiePjc=;
        b=TLizRLautCpPVslq3gNBcvvaql0QTGB/LnLjV9bVO2L9BY0Q8mx2mnyk2Kl+0h3SrN
         rvluBER/vhy2FqfzrBZLkuGtCHpuSBeLoEeLUlXhLL8H0OwpYVABZ/OUoj4/rDrXaQYo
         fEb2armTEKeuf3h/a/gB6C70wVgoAnoHOTjg0TxUveXKBuiV1W6Y0JsqB1ycbigBo1yv
         2OIvr3M58SQ+zR7mx0ggOYDzi/fB5NqTIJdqChDE37AxRwW2vvr8Zjz1aVWYGC+bT6z4
         an0bb74YwYmbQswbRLtzv2FlAWAeD04Lh/FbJ7iJjidOYWlPynYiNGP1H0lOHtQqztEv
         UWtQ==
X-Gm-Message-State: AO0yUKWJFXwMd9Nzpkzt9r2rKY3/JS7qwHGI7Pa8+mKA0ldAtFLbLjFD
        6J9zOATH6EPy5eW0+T3zDp+rKdQqXCOjdmt815FJpV7LrSyUVclxmMYN45zu+WhERoLsQ5Yg/Jq
        H4oNfzSorCv9OESPMhjImMWaD3HvyFv0aQJGXVscs
X-Received: by 2002:a05:6102:3b0b:b0:414:13c7:f583 with SMTP id x11-20020a0561023b0b00b0041413c7f583mr714108vsu.78.1676625498195;
        Fri, 17 Feb 2023 01:18:18 -0800 (PST)
X-Google-Smtp-Source: AK7set+lIxm58KEM1AennY2XsrLAcbikGNILzL6qgYViYa+ApoQ4BacvYccgWrTzqtVkNDIoILRdGOjWEC3MmtgRAVo=
X-Received: by 2002:a05:6102:3b0b:b0:414:13c7:f583 with SMTP id
 x11-20020a0561023b0b00b0041413c7f583mr714101vsu.78.1676625497977; Fri, 17 Feb
 2023 01:18:17 -0800 (PST)
MIME-Version: 1.0
References: <20230214171330.2722188-1-dhowells@redhat.com> <20230214171330.2722188-9-dhowells@redhat.com>
 <Y+85Ni9CH/7ajQga@T590>
In-Reply-To: <Y+85Ni9CH/7ajQga@T590>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Fri, 17 Feb 2023 17:18:06 +0800
Message-ID: <CAFj5m9KEMm29+yZ2sVUhNYHDy_9UNTQPpXbVp7NwfsueqdKKkA@mail.gmail.com>
Subject: Re: [PATCH v14 08/17] splice: Do splice read from a file without
 using ITER_PIPE
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 4:22 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Feb 14, 2023 at 05:13:21PM +0000, David Howells wrote:
> > Make generic_file_splice_read() use filemap_splice_read() and
> > direct_splice_read() rather than using an ITER_PIPE and call_read_iter().
> >
> > With this, ITER_PIPE is no longer used.
> >
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Jens Axboe <axboe@kernel.dk>
> > cc: Christoph Hellwig <hch@lst.de>
> > cc: Al Viro <viro@zeniv.linux.org.uk>
> > cc: David Hildenbrand <david@redhat.com>
> > cc: John Hubbard <jhubbard@nvidia.com>
> > cc: linux-mm@kvack.org
> > cc: linux-block@vger.kernel.org
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >
> > Notes:
> >     ver #14)
> >     - Split out filemap_splice_read() into a separate patch.
> >
> >  fs/splice.c | 30 +++++++-----------------------
> >  1 file changed, 7 insertions(+), 23 deletions(-)
> >
> > diff --git a/fs/splice.c b/fs/splice.c
> > index 4c6332854b63..a93478338cec 100644
> > --- a/fs/splice.c
> > +++ b/fs/splice.c
> > @@ -391,29 +391,13 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
> >                                struct pipe_inode_info *pipe, size_t len,
> >                                unsigned int flags)
> >  {
> > -     struct iov_iter to;
> > -     struct kiocb kiocb;
> > -     int ret;
> > -
> > -     iov_iter_pipe(&to, ITER_DEST, pipe, len);
> > -     init_sync_kiocb(&kiocb, in);
> > -     kiocb.ki_pos = *ppos;
> > -     ret = call_read_iter(in, &kiocb, &to);
> > -     if (ret > 0) {
> > -             *ppos = kiocb.ki_pos;
> > -             file_accessed(in);
> > -     } else if (ret < 0) {
> > -             /* free what was emitted */
> > -             pipe_discard_from(pipe, to.start_head);
> > -             /*
> > -              * callers of ->splice_read() expect -EAGAIN on
> > -              * "can't put anything in there", rather than -EFAULT.
> > -              */
> > -             if (ret == -EFAULT)
> > -                     ret = -EAGAIN;
> > -     }
> > -
> > -     return ret;
> > +     if (unlikely(*ppos >= file_inode(in)->i_sb->s_maxbytes))
> > +             return 0;
> > +     if (unlikely(!len))
> > +             return 0;
> > +     if (in->f_flags & O_DIRECT)
> > +             return direct_splice_read(in, ppos, pipe, len, flags);
>
> Hello David,
>
> I have one question, for dio, pages need to map to userspace
> memory, but direct_splice_read() just allocates pages and not
> see when the user mapping is setup, can you give one hint?

oops, it is ->splice_read,  not ->read_iter, and pipe buffer isn't
user-backed, sorry for the noise.

Thanks,
Ming

