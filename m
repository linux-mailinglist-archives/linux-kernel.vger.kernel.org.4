Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27D4635A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbiKWKvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbiKWKue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:50:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B0212297E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/tHbzbSasw+hImnptkkp3nuEh8k6WTnyh4/3rgiCqtg=; b=F36by0QJC/hGNAId6GNID4dp3a
        cWDdL40++hOniXPaks3p3FXQRsROBS+Y7MrYxwAIOC0BZjIJmhKXdCliu7mHxlr30R3cOtYghPsRc
        cWX60BX99nR6sqks/FbNNEl2/6SztwhkEjU8d+8pGOAT2vEDUvzSjgvZ9UDUIWbSBqJM1Rs/XHqMv
        FN40HDSsDZAR+kF9CBnu61IEqmbXayjkdTZY5WgdYewZ6mRE0SojCRJHAsw81ubSJ2vIyBrEDryR6
        NTOoLkGVV7VekuLbhpeNFVaKZuu/IfqWZ/BQX03iDkLnIIvBG0hN9e/S9KWWKAC/RuL3dQ9+QRWWo
        9UMtjcEA==;
Received: from [54.239.6.187] (helo=[192.168.3.58])
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxn7D-007RIP-51; Wed, 23 Nov 2022 10:36:27 +0000
Message-ID: <76dabea8f5a305870933bab27fa99a5fb6be3f6d.camel@infradead.org>
Subject: Re: [PATCH v2] virtio_console: Introduce an ID allocator for
 virtual console numbers
From:   Amit Shah <amit@infradead.org>
To:     =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Amit Shah <amit@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Date:   Wed, 23 Nov 2022 11:36:19 +0100
In-Reply-To: <62cfdcff-9323-5007-67e2-54178e43b21e@kaod.org>
References: <20221114173811.1977367-1-clg@kaod.org>
         <6293fd7d415950979c55c3f09254a6f52eba708b.camel@infradead.org>
         <62cfdcff-9323-5007-67e2-54178e43b21e@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-23 at 11:17 +0100, C=C3=A9dric Le Goater wrote:
> Hello Amit,
>=20
> On 11/22/22 18:03, Amit Shah wrote:
> > On Mon, 2022-11-14 at 18:38 +0100, C=C3=A9dric Le Goater wrote:
> > > When a virtio console port is initialized, it is registered as an hvc
> > > console using a virtual console number. If a KVM guest is started wit=
h
> > > multiple virtio console devices, the same vtermno (or virtual console
> > > number) can be used to allocate different hvc consoles, which leads t=
o
> > > various communication problems later on.
> > >=20
> > > This is also reported in debugfs :
> > >=20
> > >    # grep vtermno /sys/kernel/debug/virtio-ports/*
> > >    /sys/kernel/debug/virtio-ports/vport1p1:console_vtermno: 1
> > >    /sys/kernel/debug/virtio-ports/vport2p1:console_vtermno: 1
> > >    /sys/kernel/debug/virtio-ports/vport3p1:console_vtermno: 2
> > >    /sys/kernel/debug/virtio-ports/vport4p1:console_vtermno: 3
> > >=20
> > > Replace the next_vtermno global with an ID allocator and start the
> > > allocation at 1 as it is today. Also recycle IDs when a console port
> > > is removed.
> >=20
> > When the original virtio_console module was written, it didn't have
> > support for multiple ports to be used this way.  So the oddity you're
> > seeing is left there deliberately: VMMs should not be instantiating
> > console ports this way.
> >=20
> > I don't know if we should take in this change, but can you walk through
> > all combinations of new/old guest and new/old hypervisor and ensure
> > nothing's going to break -- and confirm with the spec this is still OK
> > to do?  It may not be a goal to still ensure launches of a new guest on
> > a very old (say) Centos5 guest still works -- but that was the point of
> > maintaining backward compat...
>=20
> 'next_vtermno' was introduced by d8a02bd58ab6 ("virtio: console:
> remove global var") to differentiate the underlying kernel hvc console
> associated with each virtio console port. Some drivers, like XEN,
> simply use a magic/cookie number for instance.
>=20
> This number is not related to the virtio specs. It is not exposed to
> QEMU nor the guest (a part from debugfs). It's an internal identifier
> related to the implementation in the kernel. I don't understand how
> this could break compatibility. The change even keeps the allocated
> range the same in case some assumption is made on vtermno 0. Am I
> missing something ?

No, you're right about this being kernel-internal -- just that it's
used with hvc instead of qemu like I mentioned.

I think this is the right change; just want to confirm hvc didn't get
confused.

>=20
> In the virtio console driver case, we could also generate a unique
> number from the tuple { virtio device index, virtio console port }.
> The ID allocator approach is simpler.

I think the bug is that we don't increment the vtermno today in all
places that we should; but this patch solves it too - I don't mind
adding the extra ida bits.
