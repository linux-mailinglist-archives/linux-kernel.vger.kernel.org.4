Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4667498EA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjGFKCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjGFKCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725F9199E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688637711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PFB/bHaV+5S4HNAEYX/AEdRm3PBRbuuOs/N7fpLg5iE=;
        b=hKw1k4X7OtdOsb8IlPWp/krUxNJCPDcMl2THTnD/JQDIDIqEe4jSI/J7Yz18cmLYiPKypi
        EDb7CnWlLlPCgDjAAtJ5IMW1e6q3sKSGMMt8J+WE4t0IN2A4Y3XQ98j3zEsUCezK0tN6Kr
        G01gBm5htE8Ppf44EOCIk38faQUsR30=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-BD_Yae-hOVqnySsQN8OXUw-1; Thu, 06 Jul 2023 06:01:50 -0400
X-MC-Unique: BD_Yae-hOVqnySsQN8OXUw-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-56942442eb0so6132007b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 03:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688637709; x=1691229709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFB/bHaV+5S4HNAEYX/AEdRm3PBRbuuOs/N7fpLg5iE=;
        b=Lt+wZBPyAWe26FwJUOdicHkRrayjEhpzy4GRVztd8qh/zV7IjDkpIN+wqnsoOdLI2B
         DuLcHysCzE1+BENWIOkRaHc8RJVaN1UT2EDWr9e6xkFJSwK/b9YyKHmQo8xF8BL8W9+M
         fBBlmqt+sOJpCr3qFEieujxLybw+xgvkWTgV54C7/7q9Ee7NPaTuCalpKVMnFEFwTm77
         AMkQtdd7IL3bMvu/Bx18fcc7GQoaU1D4RVPT3Rdqf27h3STcFKiw82rGCUv0wXTIqq0b
         KJ3Ypync6nLXixIem/xoprJySFe4Sb1RJ1/TiwWWf16dh4iOW+oyuN4RfPbGY5qlk1vX
         WlYg==
X-Gm-Message-State: ABy/qLacSE5cHyG5ObdbaQH5Y1JhUnyvIFKX13/UQdn9L6uyeqazkIA+
        mYZPEfZQRQ5cSBH2wcwKUb717zLrJ4o/6P25iEwL3eI9E3r2iHt36v5ul3or4UWqh8Ne3rvzvxo
        iagc+Sevey/aoy8LJPDx8wNtJxOq6DtoZbHMOiXqb
X-Received: by 2002:a81:8384:0:b0:56d:c97:39f4 with SMTP id t126-20020a818384000000b0056d0c9739f4mr1424682ywf.8.1688637709729;
        Thu, 06 Jul 2023 03:01:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHnS8DTGuBigSC1cOUEhrHGP3AjZEn+XIDZR976mIx9TGjJA3wYtGsoU6qHdLxp+gcwyMWCUHKwipRzaY/ylEo=
X-Received: by 2002:a81:8384:0:b0:56d:c97:39f4 with SMTP id
 t126-20020a818384000000b0056d0c9739f4mr1424668ywf.8.1688637709450; Thu, 06
 Jul 2023 03:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230704234532.532c8ee7.gary@garyguo.net>
In-Reply-To: <20230704234532.532c8ee7.gary@garyguo.net>
From:   Stefano Garzarella <sgarzare@redhat.com>
Date:   Thu, 6 Jul 2023 12:01:38 +0200
Message-ID: <CAGxU2F4_br6e3hEELXP_wpQSZTs5FYhQ-iahiZKzMMRYWpFXdA@mail.gmail.com>
Subject: Re: Hyper-V vsock streams do not fill the supplied buffer in full
To:     Gary Guo <gary@garyguo.net>, Dexuan Cui <decui@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gary,

On Wed, Jul 5, 2023 at 12:45=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> When a vsock stream is called with recvmsg with a buffer, it only fills
> the buffer with data from the first single VM packet. Even if there are
> more VM packets at the time and the buffer is still not completely
> filled, it will just leave the buffer partially filled.
>
> This causes some issues when in WSLD which uses the vsock in
> non-blocking mode and uses epoll.
>
> For stream-oriented sockets, the epoll man page [1] says that
>
> > For stream-oriented files (e.g., pipe, FIFO, stream socket),
> > the condition that the read/write I/O space is exhausted can
> > also be detected by checking the amount of data read from /
> > written to the target file descriptor.  For example, if you
> > call read(2) by asking to read a certain amount of data and
> > read(2) returns a lower number of bytes, you can be sure of
> > having exhausted the read I/O space for the file descriptor.
>
> This has been used as an optimisation in the wild for reducing number
> of syscalls required for stream sockets (by asserting that the socket
> will not have to polled to EAGAIN in edge-trigger mode, if the buffer
> given to recvmsg is not filled completely). An example is Tokio, which
> starting in v1.21.0 [2].
>
> When this optimisation combines with the behaviour of Hyper-V vsock, it
> causes issue in this scenario:
> * the VM host send data to the guest, and it's splitted into multiple
>   VM packets
> * sk_data_ready is called and epoll returns, notifying the userspace
>   that the socket is ready
> * userspace call recvmsg with a buffer, and it's partially filled
> * userspace assumes that the stream socket is depleted, and if new data
>   arrives epoll will notify it again.
> * kernel always considers the socket to be ready, and since it's in
>   edge-trigger mode, the epoll instance will never be notified again.
>
> This different realisation of the readiness causes the userspace to
> block forever.

Thanks for the detailed description of the problem.

I think we should fix the hvs_stream_dequeue() in
net/vmw_vsock/hyperv_transport.c.
We can do something similar to what we do in
virtio_transport_stream_do_dequeue() in
net/vmw_vsock/virtio_transport_common.c

@Dexuan WDYT?

Thanks,
Stefano

