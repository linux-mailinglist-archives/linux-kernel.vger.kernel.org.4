Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC76A5EEF59
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbiI2Hko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbiI2Hke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41EA7EFEE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664437222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oaCFqrQ5GzdKP7AhOQ10Zj7koIi79amAnF/+mMQ81sg=;
        b=NwN/qMzmmcwF7ZZ97nGUA9u9JnnXcGUvDFPRYbeOKAvZnRLQyB6AYarC9RVJa7j1fnDojv
        80GDMcIO7uLMOjRuCCXfPYpqd91L+qBN/PeyTLf8U6dtKPw9YhqXd9pEHC7DS0V0NZ920A
        GHvBfHF/MWXvVwiwfG8nJKvqYONRuXg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-612-_Fi2a6saP8SPcLLknrPuww-1; Thu, 29 Sep 2022 03:40:21 -0400
X-MC-Unique: _Fi2a6saP8SPcLLknrPuww-1
Received: by mail-qk1-f199.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso473138qkp.21
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=oaCFqrQ5GzdKP7AhOQ10Zj7koIi79amAnF/+mMQ81sg=;
        b=wsGLHH+XNYzArXOnrkGTF7s7QMxJKQBvMbviq2bsgbm+t6SUlsk25WgdrYBI9c4zJB
         kmRAqiIoh7m/sO5i4O1Q8egIt6pHNEWU0JAkcbtWO382GxvZWsVcIzpA0JbJG06vm1RS
         XcbRdmsHSF2T+e2KJzmKw3PJIY4AFt5GIh46kkRkHa4+pMp/Takal/SbK+ts1XFzrsEa
         ELhYA7gluE13Ieg6kUSJfzbRMNRfdkr/cfYD7VHKI9VNnbXBu+7+T9byMeyFze8KAOTy
         fSymWFaPF654zPUCxv4uKrB9hyr/zv1T9zILPwGmVh9tAh9OEMLFGZPNvqsNe+gL4wVw
         6a8w==
X-Gm-Message-State: ACrzQf2HZB845lJfE4IST2W4TQPj3yC1VH3AhLSHXVBNalwBym7RRroQ
        umofiBWKK9yU7eHlbNxNnaP+F8cusg9ThmSfwWcTB0mmvRNSlIR9o7sJkQxu4OYXtbTuP0iJ1aD
        F6v2foU3wXQ0Cm60hSyhrFhRp
X-Received: by 2002:a05:620a:c15:b0:6ce:d1db:f7dc with SMTP id l21-20020a05620a0c1500b006ced1dbf7dcmr1200827qki.259.1664437221183;
        Thu, 29 Sep 2022 00:40:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ojPjmY7apjIi1WK+7gxu/7NwTtehomIcT45iZfLQ6HJTQ6dVYty87P02i03q/EK/PFipsQA==
X-Received: by 2002:a05:620a:c15:b0:6ce:d1db:f7dc with SMTP id l21-20020a05620a0c1500b006ced1dbf7dcmr1200814qki.259.1664437220936;
        Thu, 29 Sep 2022 00:40:20 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-222.retail.telecomitalia.it. [79.46.200.222])
        by smtp.gmail.com with ESMTPSA id x11-20020a05620a258b00b006bac157ec19sm5392848qko.123.2022.09.29.00.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 00:40:20 -0700 (PDT)
Date:   Thu, 29 Sep 2022 09:40:10 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Junichi Uekawa <uekawa@chromium.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [PATCH] vhost/vsock: Use kvmalloc/kvfree for larger packets.
Message-ID: <20220929074010.37mksjmwr3l4wlwt@sgarzare-redhat>
References: <20220928064538.667678-1-uekawa@chromium.org>
 <20220928082823.wyxplop5wtpuurwo@sgarzare-redhat>
 <20220928052738-mutt-send-email-mst@kernel.org>
 <20220928151135.pvrlsylg6j3hzh74@sgarzare-redhat>
 <20220928160116-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220928160116-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 04:02:12PM -0400, Michael S. Tsirkin wrote:
>On Wed, Sep 28, 2022 at 05:11:35PM +0200, Stefano Garzarella wrote:
>> On Wed, Sep 28, 2022 at 05:31:58AM -0400, Michael S. Tsirkin wrote:
>> > On Wed, Sep 28, 2022 at 10:28:23AM +0200, Stefano Garzarella wrote:
>> > > On Wed, Sep 28, 2022 at 03:45:38PM +0900, Junichi Uekawa wrote:
>> > > > When copying a large file over sftp over vsock, data size is usually 32kB,
>> > > > and kmalloc seems to fail to try to allocate 32 32kB regions.
>> > > >
>> > > > Call Trace:
>> > > >  [<ffffffffb6a0df64>] dump_stack+0x97/0xdb
>> > > >  [<ffffffffb68d6aed>] warn_alloc_failed+0x10f/0x138
>> > > >  [<ffffffffb68d868a>] ? __alloc_pages_direct_compact+0x38/0xc8
>> > > >  [<ffffffffb664619f>] __alloc_pages_nodemask+0x84c/0x90d
>> > > >  [<ffffffffb6646e56>] alloc_kmem_pages+0x17/0x19
>> > > >  [<ffffffffb6653a26>] kmalloc_order_trace+0x2b/0xdb
>> > > >  [<ffffffffb66682f3>] __kmalloc+0x177/0x1f7
>> > > >  [<ffffffffb66e0d94>] ? copy_from_iter+0x8d/0x31d
>> > > >  [<ffffffffc0689ab7>] vhost_vsock_handle_tx_kick+0x1fa/0x301 [vhost_vsock]
>> > > >  [<ffffffffc06828d9>] vhost_worker+0xf7/0x157 [vhost]
>> > > >  [<ffffffffb683ddce>] kthread+0xfd/0x105
>> > > >  [<ffffffffc06827e2>] ? vhost_dev_set_owner+0x22e/0x22e [vhost]
>> > > >  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
>> > > >  [<ffffffffb6eb332e>] ret_from_fork+0x4e/0x80
>> > > >  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
>> > > >
>> > > > Work around by doing kvmalloc instead.
>> > > >
>> > > > Signed-off-by: Junichi Uekawa <uekawa@chromium.org>
>> >
>> > My worry here is that this in more of a work around.
>> > It would be better to not allocate memory so aggressively:
>> > if we are so short on memory we should probably process
>> > packets one at a time. Is that very hard to implement?
>>
>> Currently the "virtio_vsock_pkt" is allocated in the "handle_kick" callback
>> of TX virtqueue. Then the packet is multiplexed on the right socket queue,
>> then the user space can de-queue it whenever they want.
>>
>> So maybe we can stop processing the virtqueue if we are short on memory, but
>> when can we restart the TX virtqueue processing?
>
>Assuming you added at least one buffer, the time to restart would be
>after that buffer has been used.

Yes, but we still might not have as many continuous pages to allocate, 
so I would use kvmalloc the same.

I agree that we should do better, I hope that moving to sk_buff will 
allow us to better manage allocation. Maybe after we merge that part we 
should spend some time to solve these problems.

Thanks,
Stefano

