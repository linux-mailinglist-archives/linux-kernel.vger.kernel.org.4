Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AD063421E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiKVRD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiKVRDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:03:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F16B4C25F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
        :Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=6OthWer9O3aM/7vfA9iZRVn/4cj/z/1mGdO9oyoM7xk=; b=lGNG+NpUCWZ0YKzSVCDfkpJka5
        iXQMJ/hXxvOeh84RrUGrLBSDfCblA21i8IWVAYnTKN/+uHtaN77LJZHAQ2YnGIRXx23lR4VAEqtFW
        fNYMAvt4kvy8CN2ktj83WwKqeIgHXYAAy6TnSghbN/0gw9vXjPrPciNgcCkUMkVqat7263IFEMoZ9
        wp2sfYK8G455k9gv1vZgFwngJvYz/TV1zCCUKGb8c5Hda7eqVaLzbo/a3HXVyIF94emcGa4uPObul
        sIG2gNVo2FsnpKymuD/AgXCE28FFNWlcj3qlkuP8ksfjzSCQToxwmhH+8cjf6Nhmrjy3Bxtvmd3Sy
        jAXCyGaw==;
Received: from [54.239.6.185] (helo=[192.168.10.109])
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxWfq-003W9O-Fg; Tue, 22 Nov 2022 17:03:06 +0000
Message-ID: <6293fd7d415950979c55c3f09254a6f52eba708b.camel@infradead.org>
Subject: Re: [PATCH v2] virtio_console: Introduce an ID allocator for
 virtual console numbers
From:   Amit Shah <amit@infradead.org>
To:     =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Amit Shah <amit@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Nov 2022 18:03:05 +0100
In-Reply-To: <20221114173811.1977367-1-clg@kaod.org>
References: <20221114173811.1977367-1-clg@kaod.org>
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

On Mon, 2022-11-14 at 18:38 +0100, C=C3=A9dric Le Goater wrote:
> When a virtio console port is initialized, it is registered as an hvc
> console using a virtual console number. If a KVM guest is started with
> multiple virtio console devices, the same vtermno (or virtual console
> number) can be used to allocate different hvc consoles, which leads to
> various communication problems later on.
>=20
> This is also reported in debugfs :
>=20
>   # grep vtermno /sys/kernel/debug/virtio-ports/*
>   /sys/kernel/debug/virtio-ports/vport1p1:console_vtermno: 1
>   /sys/kernel/debug/virtio-ports/vport2p1:console_vtermno: 1
>   /sys/kernel/debug/virtio-ports/vport3p1:console_vtermno: 2
>   /sys/kernel/debug/virtio-ports/vport4p1:console_vtermno: 3
>=20
> Replace the next_vtermno global with an ID allocator and start the
> allocation at 1 as it is today. Also recycle IDs when a console port
> is removed.

When the original virtio_console module was written, it didn't have
support for multiple ports to be used this way.  So the oddity you're
seeing is left there deliberately: VMMs should not be instantiating
console ports this way.

I don't know if we should take in this change, but can you walk through
all combinations of new/old guest and new/old hypervisor and ensure
nothing's going to break -- and confirm with the spec this is still OK
to do?  It may not be a goal to still ensure launches of a new guest on
a very old (say) Centos5 guest still works -- but that was the point of
maintaining backward compat...


		Amit
