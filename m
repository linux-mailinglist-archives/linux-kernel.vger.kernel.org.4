Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01736C3F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 01:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCVAsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 20:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCVAsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 20:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679A8106
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 17:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679446076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/QpOu03OMHxoyPFRrcM3jxdNE487xqKrAW2wGh931kM=;
        b=H8RBSaQODZWXM9/NYRhEyViZ+rcc7paDveHTxmyGhFd0OV0nd80ZwZXDxsr+V5v+JF8JDJ
        da2L1pbKVQl0KyTZhG12pb9p70tU5j6OhgLpp0v4Mw0e+LYzNXN3U8AduTHFcOb39ajfmU
        OSrPiJpIpBMwoQNTma551KFepqti4f4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-8upX8vKWM_uqw-iYU6elwA-1; Tue, 21 Mar 2023 20:47:53 -0400
X-MC-Unique: 8upX8vKWM_uqw-iYU6elwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DE46185A791;
        Wed, 22 Mar 2023 00:47:52 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D5242166B29;
        Wed, 22 Mar 2023 00:47:46 +0000 (UTC)
Date:   Wed, 22 Mar 2023 08:47:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Eric Blake <eblake@redhat.com>
Cc:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH v2 2/5] block nbd: send handle in network order
Message-ID: <ZBpQLQtZP3Gj8MdS@ovpn-8-18.pek2.redhat.com>
References: <20230317202749.419094-1-eblake@redhat.com>
 <20230317202749.419094-3-eblake@redhat.com>
 <ZBjqQckL7d5EJPlh@ovpn-8-29.pek2.redhat.com>
 <20230321135900.ni4w5ichvjba7s4u@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321135900.ni4w5ichvjba7s4u@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:59:00AM -0500, Eric Blake wrote:
> On Tue, Mar 21, 2023 at 07:20:33AM +0800, Ming Lei wrote:
> > On Fri, Mar 17, 2023 at 03:27:46PM -0500, Eric Blake wrote:
> > > The NBD spec says the client handle (or cookie) is opaque on the
> > > server, and therefore it really doesn't matter what endianness we use;
> > > to date, the use of memcpy() between u64 and a char[8] has exposed
> > > native endianness when treating the handle as a 64-bit number.
> > 
> > No, memcpy() works fine for char[8], which doesn't break endianness.
> 
> I didn't say memcpy() breaks endianness, I said it preserves it.  By
> using memcpy(), you are exposing native endianness over the wire.
> Thus, even though a server should not be making any decisions based on
> the content of the handle (it is an opaque value handed back to the
> client unchanged), the current kernel client code DOES leak through
> information about whether the client is big- or little-endian;

How is the client cpu endianness leaked with handle defined as char[8]?

Suppose it is leaked, is it really one issue? Cause most of CPUs in
the world is little-endian.

> contrast to the NBD protocol saying that ALL data is
> network-byte-order.

That doesn't make sense for any data defined as char[] or byte which
needn't to be little or big endian.

> 
> > 
> > > However, since NBD protocol documents that everything else is in
> > > network order, and tools like Wireshark will dump even the contents of
> > > the handle as seen over the network, it's worth using a consistent
> > > ordering regardless of the native endianness.
> > > 
> > > Plus, using a consistent endianness now allows an upcoming patch to
> > > simplify this to directly use integer assignment instead of memcpy().
> > 
> > It isn't necessary, given ->handle is actually u64, which is handled by
> > nbd client only.
> 
> No, re-read the whole series.  ->handle is actually char[8].  Later in
> the series adds ->cookie as __be64 as an alias to ->handle, precisely
> so that we are converting the u64 'handle' in kernel code into a
> big-endian value on the wire, regardless of the host type, and making
> it impossible for a server to inspect the wire data and learn the
> kernel's endianness.

How does server learn the client cpu endianness in this way? Is it really
one issue?

> 
> > 
> > > 
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > 
> > > ---
> > > v2: new patch
> > > ---
> > >  drivers/block/nbd.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > > index 592cfa8b765a..8a9487e79f1c 100644
> > > --- a/drivers/block/nbd.c
> > > +++ b/drivers/block/nbd.c
> > > @@ -560,6 +560,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
> > >  	unsigned long size = blk_rq_bytes(req);
> > >  	struct bio *bio;
> > >  	u64 handle;
> > > +	__be64 tmp;
> > >  	u32 type;
> > >  	u32 nbd_cmd_flags = 0;
> > >  	int sent = nsock->sent, skip = 0;
> > > @@ -606,7 +607,8 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
> > >  		request.len = htonl(size);
> > >  	}
> > >  	handle = nbd_cmd_handle(cmd);
> > > -	memcpy(request.handle, &handle, sizeof(handle));
> > > +	tmp = cpu_to_be64(handle);
> > > +	memcpy(request.handle, &tmp, sizeof(tmp));
> > 
> > This way copies handle two times, really not fun.
> 
> Indeed.  And as mentioned in the commit message, it is temporary; the
> second copy goes away later in the series once we can use direct
> integer assignment.

Then please merge with following patch, given it is hard to review
temporary change.

thanks,
Ming

