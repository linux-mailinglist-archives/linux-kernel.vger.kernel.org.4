Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3936C4A83
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCVMaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCVMaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5417E4D630
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679488167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DDZ81cwjjCLDnbq2gzVynfA+CfCd2gVU17eXqtriDsI=;
        b=Y4UnSA5yJ2bi8XuAR5EbjQQ9EElRsmy52BEd3H420sCkGZ0YFjgZSV8mOVY0jt6wHIyZl2
        +xP/UFbVcjAYkOTTt3x4LRQ6YPawHVY0nDtxZItsKswpLoXdW5fO27aorsrsobFtq8pPqW
        8BZbsF0kgTdTEv9spyQFP/eV6xlZIYA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-b_yorsKQMHavVIILlI1VxA-1; Wed, 22 Mar 2023 08:29:24 -0400
X-MC-Unique: b_yorsKQMHavVIILlI1VxA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E11C93C54277;
        Wed, 22 Mar 2023 12:29:23 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3A4B1731B;
        Wed, 22 Mar 2023 12:29:22 +0000 (UTC)
Date:   Wed, 22 Mar 2023 07:29:21 -0500
From:   Eric Blake <eblake@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] block nbd: send handle in network order
Message-ID: <20230322122921.ac47tbbkddrb72gq@redhat.com>
References: <20230317202749.419094-1-eblake@redhat.com>
 <20230317202749.419094-3-eblake@redhat.com>
 <ZBjqQckL7d5EJPlh@ovpn-8-29.pek2.redhat.com>
 <20230321135900.ni4w5ichvjba7s4u@redhat.com>
 <ZBpQLQtZP3Gj8MdS@ovpn-8-18.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBpQLQtZP3Gj8MdS@ovpn-8-18.pek2.redhat.com>
User-Agent: NeoMutt/20220429
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 08:47:41AM +0800, Ming Lei wrote:
> On Tue, Mar 21, 2023 at 08:59:00AM -0500, Eric Blake wrote:
> > On Tue, Mar 21, 2023 at 07:20:33AM +0800, Ming Lei wrote:
> > > On Fri, Mar 17, 2023 at 03:27:46PM -0500, Eric Blake wrote:
> > > > The NBD spec says the client handle (or cookie) is opaque on the
> > > > server, and therefore it really doesn't matter what endianness we use;
> > > > to date, the use of memcpy() between u64 and a char[8] has exposed
> > > > native endianness when treating the handle as a 64-bit number.
> > > 
> > > No, memcpy() works fine for char[8], which doesn't break endianness.
> > 
> > I didn't say memcpy() breaks endianness, I said it preserves it.  By
> > using memcpy(), you are exposing native endianness over the wire.
> > Thus, even though a server should not be making any decisions based on
> > the content of the handle (it is an opaque value handed back to the
> > client unchanged), the current kernel client code DOES leak through
> > information about whether the client is big- or little-endian;
> 
> How is the client cpu endianness leaked with handle defined as char[8]?
> 
> Suppose it is leaked, is it really one issue? Cause most of CPUs in
> the world is little-endian.
> 
> > contrast to the NBD protocol saying that ALL data is
> > network-byte-order.
> 
> That doesn't make sense for any data defined as char[] or byte which
> needn't to be little or big endian.

The NBD spec defines it as a 64-bit opaque quantity - that does not
indicate whether it is a single integer or 8 characters, but because
it is opaque, we don't have to care.  However, if we DO treat it as an
integer (and the kernel client code DOES do that: internally, it is
building up a u64 integer), it is wise to consider network endianness.

> 
> > 
> > > 
> > > > However, since NBD protocol documents that everything else is in
> > > > network order, and tools like Wireshark will dump even the contents of
> > > > the handle as seen over the network, it's worth using a consistent
> > > > ordering regardless of the native endianness.
> > > > 
> > > > Plus, using a consistent endianness now allows an upcoming patch to
> > > > simplify this to directly use integer assignment instead of memcpy().
> > > 
> > > It isn't necessary, given ->handle is actually u64, which is handled by
> > > nbd client only.
> > 
> > No, re-read the whole series.  ->handle is actually char[8].  Later in
> > the series adds ->cookie as __be64 as an alias to ->handle, precisely
> > so that we are converting the u64 'handle' in kernel code into a
> > big-endian value on the wire, regardless of the host type, and making
> > it impossible for a server to inspect the wire data and learn the
> > kernel's endianness.
> 
> How does server learn the client cpu endianness in this way? Is it really
> one issue?

Not a security issue, merely a consistency one.  A server that
inspects the handles being sent by the client, and checks whether they
are sequential when treated as a big- or little-endian number, can
infer whether the client is little-endian.  But there is nothing
useful it can do with that knowledge.  Rather, the consistency factor
is that if you have a wireshark plugin reading network traffic, and
are trying to correlate it back to kernel traces, it is NICE if the
wireshark plugin can display the SAME u64 number as the kernel was
sticking into the field - and the way to do that is to have a fixed
endianness of the u64 value over the wire.

> 
> > 
> > > 
> > > > 
> > > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > > 
> > > > ---
> > > > v2: new patch
> > > > ---
> > > >  drivers/block/nbd.c | 10 +++++++---
> > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > > > index 592cfa8b765a..8a9487e79f1c 100644
> > > > --- a/drivers/block/nbd.c
> > > > +++ b/drivers/block/nbd.c
> > > > @@ -560,6 +560,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
> > > >  	unsigned long size = blk_rq_bytes(req);
> > > >  	struct bio *bio;
> > > >  	u64 handle;
> > > > +	__be64 tmp;
> > > >  	u32 type;
> > > >  	u32 nbd_cmd_flags = 0;
> > > >  	int sent = nsock->sent, skip = 0;
> > > > @@ -606,7 +607,8 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
> > > >  		request.len = htonl(size);
> > > >  	}
> > > >  	handle = nbd_cmd_handle(cmd);
> > > > -	memcpy(request.handle, &handle, sizeof(handle));
> > > > +	tmp = cpu_to_be64(handle);
> > > > +	memcpy(request.handle, &tmp, sizeof(tmp));
> > > 
> > > This way copies handle two times, really not fun.
> > 
> > Indeed.  And as mentioned in the commit message, it is temporary; the
> > second copy goes away later in the series once we can use direct
> > integer assignment.
> 
> Then please merge with following patch, given it is hard to review
> temporary change.

The underlying reason I split this patch out is that in v1 I got
complaints that I was not taking endianness into account.  The patch
series DOES cause an observable change (namely, a little-endian client
now sends a value in big-endian order that it used to send in
little-endian order) - but the change is harmless.  But if you want me
to squash this patch back with 4/5 in v3, I'm happy to do that.

Are there any other comments on this series that I should consider
before spending time putting out a v3?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

