Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBDF742679
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjF2Mbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjF2Mbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256E12681
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688041844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lxNJCuGafLKSPeJQnzjiGq0TjYezzEm7bsw6nf+e1Ec=;
        b=iZobZO2FrTsUgB9U0xDXNe05kHwpioMuHaqeaYnw3iHSR/sJeaAlAmZDPrY0VF/hE04rWC
        VJfyJaGW8qvL2MK2c/2jcxBAXvuyzJkWhnVo0zBCrEqTFbaP0P9DQxiEP3RERAwAG7ubM2
        IntVFms7WxDXNGQN3VULjHPHwR0wNqA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-ztsdvKdLMPySlC5rqFHiQg-1; Thu, 29 Jun 2023 08:30:41 -0400
X-MC-Unique: ztsdvKdLMPySlC5rqFHiQg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-313f376d2adso925619f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688041840; x=1690633840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxNJCuGafLKSPeJQnzjiGq0TjYezzEm7bsw6nf+e1Ec=;
        b=Cjvy7amRQ25EMXdYZwgiLaY7icxp5emnfbZlGk2kFkJVMxJJxIlN5lFNcRJqbZ4ocD
         7qHnGAVMm44P1hh3cHu+Q5gqd+X5LYcKEeiuKxV8klqrgMllrQQPxIuOJw7oCHM6sJRw
         8Af0NilM/aoF9jZzV6IEix4bW50q0T04UuDphZiaKJHpWlrYTfUUvvMgZu0WeMz3M+CR
         e8QJ3QTDUXKrgNYKUBrCjMcGGKyRqVHsVIj+JB1tsrwI/iG99TlT+TT51aSRVQiRq5Ol
         DrZoN39ppr/tL5WqRIRq7MFjKU819aQ0J1u4E7AJT/eERFa4ol/WhbTBId6qUsJ0QHzj
         ybgA==
X-Gm-Message-State: AC+VfDxqKTz0lDSsH9aOx6lkuVBTcLhtsxyn8TDAUp+RLGAc0mFkjDct
        pRUgDvsrqT2XV3CwREpXfm/3OVPPXQt7v19/LaZ/fuWdjJMye4tVQAL3V9ehmcNgACgNwj8ceQv
        3NZrgR+O6cPBWaMXBD5U4ixuf
X-Received: by 2002:adf:ed8c:0:b0:313:e922:3941 with SMTP id c12-20020adfed8c000000b00313e9223941mr17813873wro.46.1688041840057;
        Thu, 29 Jun 2023 05:30:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6kHN46tOVkCu1gvmqDPPPR5I5tNgGXFZ/EvKTkOoxsRLh+54YIckn5gW3VqlVkVhLtJAP1ow==
X-Received: by 2002:adf:ed8c:0:b0:313:e922:3941 with SMTP id c12-20020adfed8c000000b00313e9223941mr17813849wro.46.1688041839681;
        Thu, 29 Jun 2023 05:30:39 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id q17-20020a5d6591000000b0030796e103a1sm15964532wru.5.2023.06.29.05.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 05:30:38 -0700 (PDT)
Date:   Thu, 29 Jun 2023 14:30:35 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobbyeshleman@gmail.com>
Cc:     linux-hyperv@vger.kernel.org,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Simon Horman <simon.horman@corigine.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Eric Dumazet <edumazet@google.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bryan Tan <bryantan@vmware.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Arseniy Krasnov <oxffffaa@gmail.com>,
        Vishnu Dasa <vdasa@vmware.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC net-next v4 6/8] virtio/vsock: support dgrams
Message-ID: <yzxr4hdhac33gxpaelovlshdywdci2dqbt7fbellldy3zhc24e@hgrfvycmc7h6>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-6-0cebbb2ae899@bytedance.com>
 <92b3a6df-ded3-6470-39d1-fe0939441abc@gmail.com>
 <ppx75eomyyb354knfkwbwin3il2ot7hf5cefwrt6ztpcbc3pps@q736cq5v4bdh>
 <ZJUho6NbpCgGatap@bullseye>
 <d53tgo4igvz34pycgs36xikjosrncejlzuvh47bszk55milq52@whcyextsxfka>
 <ZJo5L+IM1P3kFAhe@bullseye>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZJo5L+IM1P3kFAhe@bullseye>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:19:43AM +0000, Bobby Eshleman wrote:
>On Mon, Jun 26, 2023 at 05:03:15PM +0200, Stefano Garzarella wrote:
>> On Fri, Jun 23, 2023 at 04:37:55AM +0000, Bobby Eshleman wrote:
>> > On Thu, Jun 22, 2023 at 06:09:12PM +0200, Stefano Garzarella wrote:
>> > > On Sun, Jun 11, 2023 at 11:49:02PM +0300, Arseniy Krasnov wrote:
>> > > > Hello Bobby!
>> > > >
>> > > > On 10.06.2023 03:58, Bobby Eshleman wrote:
>> > > > > This commit adds support for datagrams over virtio/vsock.
>> > > > >
>> > > > > Message boundaries are preserved on a per-skb and per-vq entry basis.
>> > > >
>> > > > I'm a little bit confused about the following case: let vhost sends 4097 bytes
>> > > > datagram to the guest. Guest uses 4096 RX buffers in it's virtio queue, each
>> > > > buffer has attached empty skb to it. Vhost places first 4096 bytes to the first
>> > > > buffer of guests RX queue, and 1 last byte to the second buffer. Now IIUC guest
>> > > > has two skb in it rx queue, and user in guest wants to read data - does it read
>> > > > 4097 bytes, while guest has two skb - 4096 bytes and 1 bytes? In seqpacket there is
>> > > > special marker in header which shows where message ends, and how it works here?
>> > >
>> > > I think the main difference is that DGRAM is not connection-oriented, so
>> > > we don't have a stream and we can't split the packet into 2 (maybe we
>> > > could, but we have no guarantee that the second one for example will be
>> > > not discarded because there is no space).
>> > >
>> > > So I think it is acceptable as a restriction to keep it simple.
>> > >
>> > > My only doubt is, should we make the RX buffer size configurable,
>> > > instead of always using 4k?
>> > >
>> > I think that is a really good idea. What mechanism do you imagine?
>>
>> Some parameter in sysfs?
>>
>
>I comment more on this below.
>
>> >
>> > For sendmsg() with buflen > VQ_BUF_SIZE, I think I'd like -ENOBUFS
>>
>> For the guest it should be easy since it allocates the buffers, but for
>> the host?
>>
>> Maybe we should add a field in the configuration space that reports some
>> sort of MTU.
>>
>> Something in addition to what Laura had proposed here:
>> https://markmail.org/message/ymhz7wllutdxji3e
>>
>
>That sounds good to me.
>
>IIUC vhost exposes the limit via the configuration space, and the guest
>can configure the RX buffer size up to that limit via sysfs?
>
>> > returned even though it is uncharacteristic of Linux sockets.
>> > Alternatively, silently dropping is okay... but seems needlessly
>> > unhelpful.
>>
>> UDP takes advantage of IP fragmentation, right?
>> But what happens if a fragment is lost?
>>
>> We should try to behave in a similar way.
>>
>
>AFAICT in UDP the sending socket will see EHOSTUNREACH on its error
>queue and the packet will be dropped.
>
>For more details:
>- the IP defragmenter will emit an ICMP_TIME_EXCEEDED from ip_expire()
>  if the fragment queue is not completed within time.
>- Upon seeing ICMP_TIME_EXCEEDED, the sending stack will then add
>  EHOSTUNREACH to the socket's error queue, as seen in __udp4_lib_err().
>
>Given some updated man pages I think enqueuing EHOSTUNREACH is okay for
>vsock too. This also reserves ENOBUFS/ENOMEM only for shortage on local
>buffers / mem.
>
>What do you think?

Yep, makes sense to me!

Stefano

