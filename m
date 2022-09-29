Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C645EEF96
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbiI2HrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiI2HrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:47:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE99A2528A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664437636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PsFKA0JcnshzZDoVR/7R357TCzayyacAiy4vW0aVEaY=;
        b=YduBBko3FML/DaZT+jos0HbhalfuSUQu+jT1EpYznMDU+fdr0vYTmE0wNsBbtPRAUgNAPI
        UCTfjZz2VDPpr+2wxh6jrPTYfPzPNhnt/TQEEwUk9tTfM29+SQwAolZmT2dlrn2KTmXc2+
        Y/8v3QO4BSlU8r6ZlR9RagJeTb8aoPo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-183-eDeus3RGMTOnmQz4BgNHnA-1; Thu, 29 Sep 2022 03:47:14 -0400
X-MC-Unique: eDeus3RGMTOnmQz4BgNHnA-1
Received: by mail-wm1-f72.google.com with SMTP id n7-20020a1c2707000000b003a638356355so325459wmn.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=PsFKA0JcnshzZDoVR/7R357TCzayyacAiy4vW0aVEaY=;
        b=zEphZ+PNCBHYdlMi2V2h1UoY+TjmkpVZjjseS776VaJiT4Z4ARyB7qou86lH1zQxy/
         GjjfA4X5j5AkB019ZYv7VToqga/Z2BSFEsYEoNoTTaqT/WgL6tdN42pwmDElqTfAOzNm
         SHEojdNbKk1xZUQlwZ10ykEoMpl3a+hubT71WLEmiLQQkxBCI7amJy7il6MQc0tneFsC
         ejrkDdBljAVb8IVdH670Z1EfPxrVHfpQ9yCPUlTxNlJ7UaVp30FSsmTDhtefZxdp+E4j
         LehFgN2QX9UjjtUbtmlVZq1+6nCqjBcMFBwEeRzoZwx8lKWF/pZOxDPcm7hgKUVgPNb0
         e13g==
X-Gm-Message-State: ACrzQf1WdNYgOap7DDW5Le67ZasLVll/s+mtaO7yXThLykno7R7szL1I
        iwE6gygbWPC4vF46usHSKtPDGKN3WVqOfbpa13zjV4dDDklWUBOvYK+neMA0Ra+Q3muHg9Ya7h5
        +ppp4VpRgDmuc+Hz+aPUB40OB
X-Received: by 2002:a5d:4284:0:b0:22a:291e:fa8f with SMTP id k4-20020a5d4284000000b0022a291efa8fmr1154738wrq.553.1664437633412;
        Thu, 29 Sep 2022 00:47:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4+U+FYi8gr6euyVSrck8fFbYRHG3C6n/KBq6oIquAU+3k+fHj1pTJKlSFhr1Cm9nI7F+MMDw==
X-Received: by 2002:a5d:4284:0:b0:22a:291e:fa8f with SMTP id k4-20020a5d4284000000b0022a291efa8fmr1154726wrq.553.1664437633210;
        Thu, 29 Sep 2022 00:47:13 -0700 (PDT)
Received: from redhat.com ([2.55.17.78])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c230300b003b4727d199asm3639886wmo.15.2022.09.29.00.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 00:47:12 -0700 (PDT)
Date:   Thu, 29 Sep 2022 03:47:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Junichi Uekawa <uekawa@chromium.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [PATCH] vhost/vsock: Use kvmalloc/kvfree for larger packets.
Message-ID: <20220929034552-mutt-send-email-mst@kernel.org>
References: <20220928064538.667678-1-uekawa@chromium.org>
 <20220928082823.wyxplop5wtpuurwo@sgarzare-redhat>
 <20220928052738-mutt-send-email-mst@kernel.org>
 <20220928151135.pvrlsylg6j3hzh74@sgarzare-redhat>
 <20220928160116-mutt-send-email-mst@kernel.org>
 <20220929074010.37mksjmwr3l4wlwt@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929074010.37mksjmwr3l4wlwt@sgarzare-redhat>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 09:40:10AM +0200, Stefano Garzarella wrote:
> On Wed, Sep 28, 2022 at 04:02:12PM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 28, 2022 at 05:11:35PM +0200, Stefano Garzarella wrote:
> > > On Wed, Sep 28, 2022 at 05:31:58AM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Sep 28, 2022 at 10:28:23AM +0200, Stefano Garzarella wrote:
> > > > > On Wed, Sep 28, 2022 at 03:45:38PM +0900, Junichi Uekawa wrote:
> > > > > > When copying a large file over sftp over vsock, data size is usually 32kB,
> > > > > > and kmalloc seems to fail to try to allocate 32 32kB regions.
> > > > > >
> > > > > > Call Trace:
> > > > > >  [<ffffffffb6a0df64>] dump_stack+0x97/0xdb
> > > > > >  [<ffffffffb68d6aed>] warn_alloc_failed+0x10f/0x138
> > > > > >  [<ffffffffb68d868a>] ? __alloc_pages_direct_compact+0x38/0xc8
> > > > > >  [<ffffffffb664619f>] __alloc_pages_nodemask+0x84c/0x90d
> > > > > >  [<ffffffffb6646e56>] alloc_kmem_pages+0x17/0x19
> > > > > >  [<ffffffffb6653a26>] kmalloc_order_trace+0x2b/0xdb
> > > > > >  [<ffffffffb66682f3>] __kmalloc+0x177/0x1f7
> > > > > >  [<ffffffffb66e0d94>] ? copy_from_iter+0x8d/0x31d
> > > > > >  [<ffffffffc0689ab7>] vhost_vsock_handle_tx_kick+0x1fa/0x301 [vhost_vsock]
> > > > > >  [<ffffffffc06828d9>] vhost_worker+0xf7/0x157 [vhost]
> > > > > >  [<ffffffffb683ddce>] kthread+0xfd/0x105
> > > > > >  [<ffffffffc06827e2>] ? vhost_dev_set_owner+0x22e/0x22e [vhost]
> > > > > >  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
> > > > > >  [<ffffffffb6eb332e>] ret_from_fork+0x4e/0x80
> > > > > >  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
> > > > > >
> > > > > > Work around by doing kvmalloc instead.
> > > > > >
> > > > > > Signed-off-by: Junichi Uekawa <uekawa@chromium.org>
> > > >
> > > > My worry here is that this in more of a work around.
> > > > It would be better to not allocate memory so aggressively:
> > > > if we are so short on memory we should probably process
> > > > packets one at a time. Is that very hard to implement?
> > > 
> > > Currently the "virtio_vsock_pkt" is allocated in the "handle_kick" callback
> > > of TX virtqueue. Then the packet is multiplexed on the right socket queue,
> > > then the user space can de-queue it whenever they want.
> > > 
> > > So maybe we can stop processing the virtqueue if we are short on memory, but
> > > when can we restart the TX virtqueue processing?
> > 
> > Assuming you added at least one buffer, the time to restart would be
> > after that buffer has been used.
> 
> Yes, but we still might not have as many continuous pages to allocate, so I
> would use kvmalloc the same.


you would do something like
	if (is_vmalloc_addr())
		stop adding buffers.



> I agree that we should do better, I hope that moving to sk_buff will allow
> us to better manage allocation. Maybe after we merge that part we should
> spend some time to solve these problems.
> 
> Thanks,
> Stefano

