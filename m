Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994C1712508
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242977AbjEZKpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjEZKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:45:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189E912C;
        Fri, 26 May 2023 03:45:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95E0364F2F;
        Fri, 26 May 2023 10:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0FBC433EF;
        Fri, 26 May 2023 10:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685097944;
        bh=dfAaeLj5t+MmibfplLN35mTLwtHUE9bQ76Qg0stUzCI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EJjEtYiEV/mM1EyR5mgPJ1n3JH+G4XaS/+wanSXWM5wXwXE9flyKloKlTOJy0Ulxz
         koS5F3mDhm3LOhOAYSRJR/uGWCjGELZzJeGzNaT8zpcDJVTWt9nDRCkbfO5O8B6nTl
         U3iA01qft45qfT+Wl8awwVSecXPYIl7z8ak+31CiY2bNpNWFT/6mGZMEuCTGp62nhU
         a2o7iePCurKQfqd0gLLosqg4ZHhvUIRegwshr35IRVj3Q6rz1rGD1Qj+axc4Rkme2R
         Z+qpim3QD3nBBI6K48VF/oesYM8L0/iQl+04Esq5b6S7z3dZ9Y7VlJ4VS1xep/iArK
         yacCH6iLw/Obw==
Date:   Fri, 26 May 2023 11:45:39 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Su Hui <suhui@nfschina.com>, YongSu Yoo <yongsuyoo0215@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] media: dvb_ringbuffer: Return -EFAULT if copy fails
Message-ID: <20230526114539.0520dcbf@sal.lan>
In-Reply-To: <7466fead-1b99-4a78-86cb-5dd8a9baec19@kili.mountain>
References: <41a9c6a6-4b9a-4d84-9e32-09bf64c65b6c@kili.mountain>
        <aab14cc4-0400-c114-f180-6db943fd7e32@nfschina.com>
        <7466fead-1b99-4a78-86cb-5dd8a9baec19@kili.mountain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 24 May 2023 10:20:38 +0300
Dan Carpenter <dan.carpenter@linaro.org> escreveu:

> On Wed, May 24, 2023 at 01:20:27PM +0800, Su Hui wrote:
> > It's confusing about the comment on function declaration.
> >=20
> > =C2=A0=C2=A0=C2=A0 /**
> > =C2=A0=C2=A0=C2=A0=C2=A0 * dvb_ringbuffer_write_user - Writes a buffer =
received via a user
> > pointer
> >=20
> > =C2=A0=C2=A0=C2=A0 ..........
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 * Return: number of bytes transferred or -EFAU=
LT
> >=20
> > But the function Only returns=C2=A0 the number of bytes transferred.
> >=20
> > Maybe the comment should be modified because it never returns -EFAULT. =
=20
>=20
> To be honest, I think that -EFAULT is probably a better return.  But
> there is no way we could apply the patch with that commit message.  The
> commit message doesn't explain the problem for the user or why returning
> the number of bytes copied is not correct in this case.
>=20
> I think that maybe it's not too late to change this to return -EFAULT,
> but it would have been easier to make the change in 2014 before there
> were many users.  Also it would be easier if you were testing this on
> real hardware.

It is too late to change the API here, as this could break userspace.

Basically, DVB subsystem normally works with a Kernel-implemented ringbuffer
that transfers MPEG TS data between kernelspace/userspace. The size is
set via an ioctl (DMX_SET_BUFFER_SIZE). By the way, such uAPI is older=20
than 2014. It was added upstream on Kernel 2.6.

The buffer size is usually big. For instance, dvbv5-zap uses:

	#define DVB_BUF_SIZE      (4096 * 8 * 188)

The normal operation is that data will be received from a MPEG-TS
stream, although it is also possible to send data on cable TV, when
using dvb net interface.

While on several boards, the hardware<->kernel transfer happens on
188-bytes packages, there are some hardware out there where the
data passed from/to kernel is not 188-bytes aligned.

The normal operation (receiving a TV broadcast) means that the Kernel=20
will be filling a ringbuffer containing the data passed from the
hardware. The size of the such buffer is adjusted via DMX_SET_BUFFER_SIZE
and contains MPEG TS packets of 188-bytes. Userspace will be in an
endless loop that will be waiting for data to arrive at the ringbuffer,
copying received data its own userspace buffer. If the buffer is not set
to a multiple of 188, it should be up to userspace to handle incomplete
frames. The same occurs if the data is 204-bytes aligned. Btw, userspace
can detect the packet size, based on the frame content.

On such example, if a ringbuffer transfer would be passing 1554 bytes,
it means that 8 MPEG-TS frames are complete, and that 50 bytes of the
next frame was also transfered from/to userspace.

It should be up to userspace to ensure that those extra 50 bytes will
be probably taken into account by the application and ensure that the
remaining 138 bytes will be handled at the next from/to userspace
data transfer.

Not the best API, but any change there will break userspace.

In particular, this patch will completely break transfers if the
buffer size is not 188-bytes aligned.

so,

NACK.

Su,

Did you find any real problem with this? On what hardware/application?

Regards,
Mauro

