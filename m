Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F15C650ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiLSPmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiLSPmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:42:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA7825FE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671464493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vlKnSWSIx1ojfKs5edw/VgZ4TRdc4IynKJCcaopveyo=;
        b=GREtjv889MT64dKVhhsXjW5qgU5hMMHnL/bw+kd9aN7B/soNfMUNOsOukuFjhATVACCtT4
        SCkqLCjr1IUeGzg+/HNhE/kzJFV2qqZ+WnWIkIMbg8pEGTKyCY3tClfL8NSl1pOvsViC1l
        06IENGQfCZuQw+YWOaQqWU/jQONj9VY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-PobU9o7iOOm7K5UIO4VjgQ-1; Mon, 19 Dec 2022 10:41:30 -0500
X-MC-Unique: PobU9o7iOOm7K5UIO4VjgQ-1
Received: by mail-wm1-f69.google.com with SMTP id h9-20020a1c2109000000b003cfd37aec58so5303046wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlKnSWSIx1ojfKs5edw/VgZ4TRdc4IynKJCcaopveyo=;
        b=RQSjWaaBWNVRIFppXUH5EhwvmQHphQBUr34JaS75XuDLpi3H6Z21F9H2BfTgxhMKaD
         ZT8HUykgeXyt8pxdXhh+nd1Ak9cc+UO2PqgflQdr61zBq2PsOgOExCMmof7Ve8Ef/NsX
         LKcJ8CYjp3zihEb146YtFBgZ/I1PG3kaZlongJKLYcQFgQuy9FopZPfvcKBXksrK5Olx
         TAoJ9N8mjE9SlPwiKfzWeyz9TDoodevUHlKpmr5f8RQ3Sx8LewvzPGiCE9V3n+yMRoDY
         BtqMk8JmgW5K9F4ZS62xoTEg6nD26e/CXOwQO8MbIpt4J/BafS4mXE449BhACZgFCEN8
         2vbQ==
X-Gm-Message-State: ANoB5pkVAom3fZMM0ceVKq7vlRIJ1IJPi864PoMWZPRX9ub11aNFHPvV
        en3Pj13Db+qnih/FAudzDjzuQ/v7f6/wdyhL/tR3F0A1cmsi4HE1pFD9kjtjtfY9L+V4lLVrr+v
        gjG1jOqJP7toKjqK33jFFfRRq
X-Received: by 2002:adf:f98c:0:b0:242:5582:f947 with SMTP id f12-20020adff98c000000b002425582f947mr27182921wrr.19.1671464488915;
        Mon, 19 Dec 2022 07:41:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7c1CCW4GpXsPVVZneJb9YGEsZaku3fS+KXI667IWEo0kL8508tyP91BWhdT1KIQ5j10Q7ikw==
X-Received: by 2002:adf:f98c:0:b0:242:5582:f947 with SMTP id f12-20020adff98c000000b002425582f947mr27182913wrr.19.1671464488677;
        Mon, 19 Dec 2022 07:41:28 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it. [87.11.6.51])
        by smtp.gmail.com with ESMTPSA id az17-20020adfe191000000b00241bd7a7165sm10281220wrb.82.2022.12.19.07.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:41:28 -0800 (PST)
Date:   Mon, 19 Dec 2022 16:41:23 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 0/2] virtio/vsock: fix mutual rx/tx hungup
Message-ID: <CAGxU2F4ca5pxW3RX4wzsTx3KRBtxLK_rO9KxPgUtqcaSNsqXCA@mail.gmail.com>
References: <39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

On Sat, Dec 17, 2022 at 8:42 PM Arseniy Krasnov <AVKrasnov@sberdevices.ru> wrote:
>
> Hello,
>
> seems I found strange thing(may be a bug) where sender('tx' later) and
> receiver('rx' later) could stuck forever. Potential fix is in the first
> patch, second patch contains reproducer, based on vsock test suite.
> Reproducer is simple: tx just sends data to rx by 'write() syscall, rx
> dequeues it using 'read()' syscall and uses 'poll()' for waiting. I run
> server in host and client in guest.
>
> rx side params:
> 1) SO_VM_SOCKETS_BUFFER_SIZE is 256Kb(e.g. default).
> 2) SO_RCVLOWAT is 128Kb.
>
> What happens in the reproducer step by step:
>

I put the values of the variables involved to facilitate understanding:

RX: buf_alloc = 256 KB; fwd_cnt = 0; last_fwd_cnt = 0;
    free_space = buf_alloc - (fwd_cnt - last_fwd_cnt) = 256 KB

The credit update is sent if
free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE [64 KB]

> 1) tx tries to send 256Kb + 1 byte (in a single 'write()')
> 2) tx sends 256Kb, data reaches rx (rx_bytes == 256Kb)
> 3) tx waits for space in 'write()' to send last 1 byte
> 4) rx does poll(), (rx_bytes >= rcvlowat) 256Kb >= 128Kb, POLLIN is set
> 5) rx reads 64Kb, credit update is not sent due to *

RX: buf_alloc = 256 KB; fwd_cnt = 64 KB; last_fwd_cnt = 0;
    free_space = 192 KB

> 6) rx does poll(), (rx_bytes >= rcvlowat) 192Kb >= 128Kb, POLLIN is set
> 7) rx reads 64Kb, credit update is not sent due to *

RX: buf_alloc = 256 KB; fwd_cnt = 128 KB; last_fwd_cnt = 0;
    free_space = 128 KB

> 8) rx does poll(), (rx_bytes >= rcvlowat) 128Kb >= 128Kb, POLLIN is set
> 9) rx reads 64Kb, credit update is not sent due to *

Right, (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) is still false.

RX: buf_alloc = 256 KB; fwd_cnt = 196 KB; last_fwd_cnt = 0;
    free_space = 64 KB

> 10) rx does poll(), (rx_bytes < rcvlowat) 64Kb < 128Kb, rx waits in poll()

I agree that the TX is stuck because we are not sending the credit 
update, but also if RX sends the credit update at step 9, RX won't be 
woken up at step 10, right?

>
> * is optimization in 'virtio_transport_stream_do_dequeue()' which
>   sends OP_CREDIT_UPDATE only when we have not too much space -
>   less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.
>
> Now tx side waits for space inside write() and rx waits in poll() for
> 'rx_bytes' to reach SO_RCVLOWAT value. Both sides will wait forever. I
> think, possible fix is to send credit update not only when we have too
> small space, but also when number of bytes in receive queue is smaller
> than SO_RCVLOWAT thus not enough to wake up sleeping reader. I'm not
> sure about correctness of this idea, but anyway - I think that problem
> above exists. What do You think?

I'm not sure, I have to think more about it, but if RX reads less than 
SO_RCVLOWAT, I expect it's normal to get to a case of stuck.

In this case we are only unstucking TX, but even if it sends that single 
byte, RX is still stuck and not consuming it, so it was useless to wake 
up TX if RX won't consume it anyway, right?

If RX woke up (e.g. SO_RCVLOWAT = 64KB) and read the remaining 64KB, 
then it would still send the credit update even without this patch and 
TX will send the 1 byte.

Thanks,
Stefano

