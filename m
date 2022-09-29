Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17E55EEFA9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbiI2Htq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbiI2Htb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3222813A3B9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664437767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5qI7b94+taNEfTbBkn8B22CaCzkL3JdPIVHISnwlAM=;
        b=dXULStKlWMBA2or+/UCiQujzDj0u06NNf71y1WdHT173o3grKGwYOd2tvuU6ON+mwufuZi
        3V1ChX2HHz6pcNb+DLOSzX7heKzSGUM7uZtTwElbC6EOX9jig0upxbkoAVUq+xPzaQG+1n
        oi8AXsd/8QtiEPPZShBkGxs+PMnHhbI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-612-0bsupfYZN7ynQdTWWHkPhg-1; Thu, 29 Sep 2022 03:49:24 -0400
X-MC-Unique: 0bsupfYZN7ynQdTWWHkPhg-1
Received: by mail-wr1-f72.google.com with SMTP id i1-20020adfa501000000b0022cd1e1137bso202430wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=B5qI7b94+taNEfTbBkn8B22CaCzkL3JdPIVHISnwlAM=;
        b=HLlSMmA97wYAUrc7Wo70EIXRNlL3ZFsqa6J3yFSHm9jgouLy3PrwLXVtozj4GBlJpG
         04SMMk5AbHDdIXQNTBmhrhbH/TiugIPgDu7tZjgpHrV5yr9nV7+/MUmVkDMrKdoPKMUL
         8sR2dHerzl8iEaDX7vRamSFSpqp/39ZVMY/Rg/HoOUyDnquay9H7sXtSBCy/SxnpK62P
         CEeYQ1ClQhNkPuS4nrUeH6dZeiKEhX/FdX4VuaubSbk1oR7IdlyNK78m4Jlaq/PIpwp3
         Nslsda4n0p5rJiQQyXg6GdP5NhTADrjfYi7o6gT+9ttn5+bwkus9LPjqHdR9an0h+3wM
         0BEw==
X-Gm-Message-State: ACrzQf2N+ZlCsak8DN4pPEquGsfYvsEP+HQAB2cFRxuynygXrBic3DLe
        w8yDft3rv4GW0heD+tbtXNIO+d3f5ZFDUmQ7lzHxpyV9z8Dvk/vdoh8q93bYxTdt5LHts5gpiEa
        ExTD8uj4Q3r1/wda+qVySJ/tR
X-Received: by 2002:a05:600c:4fd2:b0:3b4:cab9:44f0 with SMTP id o18-20020a05600c4fd200b003b4cab944f0mr9860806wmq.73.1664437762950;
        Thu, 29 Sep 2022 00:49:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4msH8Z/F3t4GcEn/O8enUvxnRZFEtbEHz6nKwdRFvfOH+ZEpp/nXVxoWlaKXFvrX79zD/DFA==
X-Received: by 2002:a05:600c:4fd2:b0:3b4:cab9:44f0 with SMTP id o18-20020a05600c4fd200b003b4cab944f0mr9860792wmq.73.1664437762720;
        Thu, 29 Sep 2022 00:49:22 -0700 (PDT)
Received: from redhat.com ([2.55.17.78])
        by smtp.gmail.com with ESMTPSA id bi16-20020a05600c3d9000b003b4de550e34sm3503540wmb.40.2022.09.29.00.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 00:49:22 -0700 (PDT)
Date:   Thu, 29 Sep 2022 03:49:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Junichi Uekawa =?utf-8?B?KOS4iuW3nee0lOS4gCk=?= 
        <uekawa@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [PATCH] vhost/vsock: Use kvmalloc/kvfree for larger packets.
Message-ID: <20220929034807-mutt-send-email-mst@kernel.org>
References: <20220928064538.667678-1-uekawa@chromium.org>
 <20220928082823.wyxplop5wtpuurwo@sgarzare-redhat>
 <20220928052738-mutt-send-email-mst@kernel.org>
 <20220928151135.pvrlsylg6j3hzh74@sgarzare-redhat>
 <CADgJSGHxPWXJjbakEeWnqF42A03yK7Dpw6U1SKNLhk+B248Ymg@mail.gmail.com>
 <20220929031419-mutt-send-email-mst@kernel.org>
 <20220929074606.yqzihpcc7cl442c5@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220929074606.yqzihpcc7cl442c5@sgarzare-redhat>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 09:46:06AM +0200, Stefano Garzarella wrote:
> On Thu, Sep 29, 2022 at 03:19:14AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 29, 2022 at 08:14:24AM +0900, Junichi Uekawa (上川純一) wrote:
> > > 2022年9月29日(木) 0:11 Stefano Garzarella <sgarzare@redhat.com>:
> > > >
> > > > On Wed, Sep 28, 2022 at 05:31:58AM -0400, Michael S. Tsirkin wrote:
> > > > >On Wed, Sep 28, 2022 at 10:28:23AM +0200, Stefano Garzarella wrote:
> > > > >> On Wed, Sep 28, 2022 at 03:45:38PM +0900, Junichi Uekawa wrote:
> > > > >> > When copying a large file over sftp over vsock, data size is usually 32kB,
> > > > >> > and kmalloc seems to fail to try to allocate 32 32kB regions.
> > > > >> >
> > > > >> > Call Trace:
> > > > >> >  [<ffffffffb6a0df64>] dump_stack+0x97/0xdb
> > > > >> >  [<ffffffffb68d6aed>] warn_alloc_failed+0x10f/0x138
> > > > >> >  [<ffffffffb68d868a>] ? __alloc_pages_direct_compact+0x38/0xc8
> > > > >> >  [<ffffffffb664619f>] __alloc_pages_nodemask+0x84c/0x90d
> > > > >> >  [<ffffffffb6646e56>] alloc_kmem_pages+0x17/0x19
> > > > >> >  [<ffffffffb6653a26>] kmalloc_order_trace+0x2b/0xdb
> > > > >> >  [<ffffffffb66682f3>] __kmalloc+0x177/0x1f7
> > > > >> >  [<ffffffffb66e0d94>] ? copy_from_iter+0x8d/0x31d
> > > > >> >  [<ffffffffc0689ab7>] vhost_vsock_handle_tx_kick+0x1fa/0x301 [vhost_vsock]
> > > > >> >  [<ffffffffc06828d9>] vhost_worker+0xf7/0x157 [vhost]
> > > > >> >  [<ffffffffb683ddce>] kthread+0xfd/0x105
> > > > >> >  [<ffffffffc06827e2>] ? vhost_dev_set_owner+0x22e/0x22e [vhost]
> > > > >> >  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
> > > > >> >  [<ffffffffb6eb332e>] ret_from_fork+0x4e/0x80
> > > > >> >  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
> > > > >> >
> > > > >> > Work around by doing kvmalloc instead.
> > > > >> >
> > > > >> > Signed-off-by: Junichi Uekawa <uekawa@chromium.org>
> > > > >
> > > > >My worry here is that this in more of a work around.
> > > > >It would be better to not allocate memory so aggressively:
> > > > >if we are so short on memory we should probably process
> > > > >packets one at a time. Is that very hard to implement?
> > > >
> > > > Currently the "virtio_vsock_pkt" is allocated in the "handle_kick"
> > > > callback of TX virtqueue. Then the packet is multiplexed on the right
> > > > socket queue, then the user space can de-queue it whenever they want.
> > > >
> > > > So maybe we can stop processing the virtqueue if we are short on memory,
> > > > but when can we restart the TX virtqueue processing?
> > > >
> > > > I think as long as the guest used only 4K buffers we had no problem, but
> > > > now that it can create larger buffers the host may not be able to
> > > > allocate it contiguously. Since there is no need to have them contiguous
> > > > here, I think this patch is okay.
> > > >
> > > > However, if we switch to sk_buff (as Bobby is already doing), maybe we
> > > > don't have this problem because I think there is some kind of
> > > > pre-allocated pool.
> > > >
> > > 
> > > Thank you for the review! I was wondering if this is a reasonable workaround (as
> > > we found that this patch makes a reliably crashing system into a
> > > reliably surviving system.)
> > > 
> > > 
> > > ... Sounds like it is a reasonable patch to use backported to older kernels?
> > 
> > Hmm. Good point about stable. OK.
> 
> Right, so in this case I think is better to add a Fixes tag. Since we used
> kmalloc from the beginning we can use the following:
> 
> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> 
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> 
> @Michael are you queueing this, or should it go through net tree?
> 
> Thanks,
> Stefano

net tree would be preferable, my pull for this release is kind of ready ... kuba?

-- 
MST

