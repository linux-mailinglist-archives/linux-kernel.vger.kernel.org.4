Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729F66F57B5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjECMOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjECMN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F985587
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683115997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QoebIRsfYnkRE4a4+0vvaV8EtKm1li2acPw6aTCsw8w=;
        b=cjrW+CCxzbk8LbUi5gUieFD7NW2KEKfHtViDsMKZKFT9+5Qh6xofV49j5PCKLTng3akqIR
        R8YxPbS8DHRz5rAWZqqCLzNcTXEWMqpKEGzGeocJAdsYWF46cIxSENl5cdwmiDwjDCQx1Z
        RSvP2P5pO6vdQYLqYkPi8Wg0gohgpLY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-BtxU4ruvObenL72m8tpkQw-1; Wed, 03 May 2023 08:13:16 -0400
X-MC-Unique: BtxU4ruvObenL72m8tpkQw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f321e60feaso17253295e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 05:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683115995; x=1685707995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoebIRsfYnkRE4a4+0vvaV8EtKm1li2acPw6aTCsw8w=;
        b=DozZk2BhJ73JihftUK0jzlumAwVpjUTUjZGKzghNU4FRAEenTrsTs3UfItDSIiFW/q
         8UtFAACPSWuGOy8SIAcUOZ0pvuBgSF2Z0L7nmW9mhOHI0KTb1nlACMM7bn7idgTQhpu0
         NAZSSv8sYW3L+oZMsT5XjitQfHCXDKJpCUSSn7wU9rIFu8xwLna9s6xTZtuA+Nf+LnAp
         eR4lZSORbkZU+ypZnxfOQ/6DlFJm6mzaf/KVMeFiQO8IE6LNiegXZF8xKJzj0i+9RnXe
         QnW0gcKQQCitTvQimsiMsVXscRLp2waEcX88lEwuapcY9F3rjXdLd9KVZ/m6vdY5F+2N
         tMgQ==
X-Gm-Message-State: AC+VfDwR/5jHmQhH8FwUATLsdn+pvHSKZ4nw5UrjTOGuUuw+oCdEgI5W
        3uHfBUIMHlzRyz8yamVDcRYh+8Q9ZcI55eB3n5j3sCmUcOTslUaWSCm1mAjesHrAyAI9NVDyil8
        mIYXausu8STtr8irwErZeP91p
X-Received: by 2002:a7b:c408:0:b0:3f1:75b6:8c7 with SMTP id k8-20020a7bc408000000b003f175b608c7mr14043838wmi.37.1683115995249;
        Wed, 03 May 2023 05:13:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67lm3NwTO03hE2PmJip283wLLIfqmiPdSnznYPeWJRfBG58fEWJZMqmPER/CfifMqoJCwIlw==
X-Received: by 2002:a7b:c408:0:b0:3f1:75b6:8c7 with SMTP id k8-20020a7bc408000000b003f175b608c7mr14043812wmi.37.1683115994929;
        Wed, 03 May 2023 05:13:14 -0700 (PDT)
Received: from sgarzare-redhat ([185.29.96.107])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d4d8c000000b003063408dd62sm5638329wru.65.2023.05.03.05.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 05:13:14 -0700 (PDT)
Date:   Wed, 3 May 2023 14:13:10 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobbyeshleman@gmail.com>
Cc:     Vishnu Dasa <vdasa@vmware.com>, virtio-dev@lists.oasis-open.org,
        linux-hyperv@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 0/4] virtio/vsock: support datagrams
Message-ID: <4ikawh4kks22iqjdkhbvkak7spoja6zr3g22pke2r3jsqgpddp@bx6purfp4f6a>
References: <20230413-b4-vsock-dgram-v2-0-079cc7cee62e@bytedance.com>
 <ZDk2kOVnUvyLMLKE@bullseye>
 <r6oxanmhwlonb7lcrrowpitlgobivzp7pcwk7snqvfnzudi6pb@4rnio5wef3qu>
 <ZDpOq0ACuMYIUbb1@bullseye>
 <yeu57zqwzcx33sylp565xgw7yv72qyczohkmukyex27rcdh6mr@w4x6t4enx6iu>
 <ZDrI2bBhiamYBKUB@bullseye>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZDrI2bBhiamYBKUB@bullseye>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 03:55:05PM +0000, Bobby Eshleman wrote:
>On Fri, Apr 28, 2023 at 12:43:09PM +0200, Stefano Garzarella wrote:
>> On Sat, Apr 15, 2023 at 07:13:47AM +0000, Bobby Eshleman wrote:
>> > CC'ing virtio-dev@lists.oasis-open.org because this thread is starting
>> > to touch the spec.
>> >
>> > On Wed, Apr 19, 2023 at 12:00:17PM +0200, Stefano Garzarella wrote:
>> > > Hi Bobby,
>> > >
>> > > On Fri, Apr 14, 2023 at 11:18:40AM +0000, Bobby Eshleman wrote:
>> > > > CC'ing Cong.
>> > > >
>> > > > On Fri, Apr 14, 2023 at 12:25:56AM +0000, Bobby Eshleman wrote:
>> > > > > Hey all!
>> > > > >
>> > > > > This series introduces support for datagrams to virtio/vsock.
>> > >
>> > > Great! Thanks for restarting this work!
>> > >
>> >
>> > No problem!
>> >
>> > > > >
>> > > > > It is a spin-off (and smaller version) of this series from the summer:
>> > > > >   https://lore.kernel.org/all/cover.1660362668.git.bobby.eshleman@bytedance.com/
>> > > > >
>> > > > > Please note that this is an RFC and should not be merged until
>> > > > > associated changes are made to the virtio specification, which will
>> > > > > follow after discussion from this series.
>> > > > >
>> > > > > This series first supports datagrams in a basic form for virtio, and
>> > > > > then optimizes the sendpath for all transports.
>> > > > >
>> > > > > The result is a very fast datagram communication protocol that
>> > > > > outperforms even UDP on multi-queue virtio-net w/ vhost on a variety
>> > > > > of multi-threaded workload samples.
>> > > > >
>> > > > > For those that are curious, some summary data comparing UDP and VSOCK
>> > > > > DGRAM (N=5):
>> > > > >
>> > > > > 	vCPUS: 16
>> > > > > 	virtio-net queues: 16
>> > > > > 	payload size: 4KB
>> > > > > 	Setup: bare metal + vm (non-nested)
>> > > > >
>> > > > > 	UDP: 287.59 MB/s
>> > > > > 	VSOCK DGRAM: 509.2 MB/s
>> > > > >
>> > > > > Some notes about the implementation...
>> > > > >
>> > > > > This datagram implementation forces datagrams to self-throttle according
>> > > > > to the threshold set by sk_sndbuf. It behaves similar to the credits
>> > > > > used by streams in its effect on throughput and memory consumption, but
>> > > > > it is not influenced by the receiving socket as credits are.
>> > >
>> > > So, sk_sndbuf influece the sender and sk_rcvbuf the receiver, right?
>> > >
>> >
>> > Correct.
>> >
>> > > We should check if VMCI behaves the same.
>> > >
>> > > > >
>> > > > > The device drops packets silently. There is room for improvement by
>> > > > > building into the device and driver some intelligence around how to
>> > > > > reduce frequency of kicking the virtqueue when packet loss is high. I
>> > > > > think there is a good discussion to be had on this.
>> > >
>> > > Can you elaborate a bit here?
>> > >
>> > > Do you mean some mechanism to report to the sender that a destination
>> > > (cid, port) is full so the packet will be dropped?
>> > >
>> >
>> > Correct. There is also the case of there being no receiver at all for
>> > this address since this case isn't rejected upon connect(). Ideally,
>> > such a socket (which will have 100% packet loss) will be throttled
>> > aggressively.
>> >
>> > Before we go down too far on this path, I also want to clarify that
>> > using UDP over vhost/virtio-net also has this property... this can be
>> > observed by using tcpdump to dump the UDP packets on the bridge network
>> > your VM is using. UDP packets sent to a garbage address can be seen on
>> > the host bridge (this is the nature of UDP, how is the host supposed to
>> > know the address eventually goes nowhere). I mention the above because I
>> > think it is possible for vsock to avoid this cost, given that it
>> > benefits from being point-to-point and g2h/h2g.
>> >
>> > If we're okay with vsock being on par, then the current series does
>> > that. I propose something below that can be added later and maybe
>> > negotiated as a feature bit too.
>>
>> I see and I agree on that, let's do it step by step.
>> If we can do it in the first phase is great, but I think is fine to add
>> this feature later.
>>
>> >
>> > > Can we adapt the credit mechanism?
>> > >
>> >
>> > I've thought about this a lot because the attraction of the approach for
>> > me would be that we could get the wait/buffer-limiting logic for free
>> > and without big changes to the protocol, but the problem is that the
>> > unreliable nature of datagrams means that the source's free-running
>> > tx_cnt will become out-of-sync with the destination's fwd_cnt upon
>> > packet loss.
>>
>> We need to understand where the packet can be lost.
>> If the packet always reaches the destination (vsock driver or device),
>> we can discard it, but also update the counters.
>>
>> >
>> > Imagine a source that initializes and starts sending packets before a
>> > destination socket even is created, the source's self-throttling will be
>> > dysfunctional because its tx_cnt will always far exceed the
>> > destination's fwd_cnt.
>>
>> Right, the other problem I see is that the socket aren't connected, so
>> we have 1-N relationship.
>>
>
>Oh yeah, good point.
>
>> >
>> > We could play tricks with the meaning of the CREDIT_UPDATE message and
>> > fwd_cnt/buf_alloc fields, but I don't think we want to go down that
>> > path.
>> >
>> > I think that the best and simplest approach introduces a congestion
>> > notification (VIRTIO_VSOCK_OP_CN?). When a packet is dropped, the
>> > destination sends this notification. At a given repeated time period T,
>> > the source can check if it has received any notifications in the last T.
>> > If so, it halves its buffer allocation. If not, it doubles its buffer
>> > allocation unless it is already at its max or original value.
>> >
>> > An "invalid" socket which never has any receiver will converge towards a
>> > rate limit of one packet per time T * log2(average pkt size). That is, a
>> > socket with 100% packet loss will only be able to send 16 bytes every
>> > 4T. A default send buffer of MAX_UINT32 and T=5ms would hit zero within
>> > 160ms given at least one packet sent per 5ms. I have no idea if that is
>> > a reasonable default T for vsock, I just pulled it out of a hat for the
>> > sake of the example.
>> >
>> > "Normal" sockets will be responsive to high loss and rebalance during
>> > low loss. The source is trying to guess and converge on the actual
>> > buffer state of the destination.
>> >
>> > This would reuse the already-existing throttling mechanisms that
>> > throttle based upon buffer allocation. The usage of sk_sndbuf would have
>> > to be re-worked. The application using sendmsg() will see EAGAIN when
>> > throttled, or just sleep if !MSG_DONTWAIT.
>>
>> I see, it looks interesting, but I think we need to share that
>> information between multiple sockets, since the same destination
>> (cid, port), can be reached by multiple sockets.
>>
>
>Good point, that is true.
>
>> Another approach could be to have both congestion notification and
>> decongestion, but maybe it produces double traffic.
>>
>
>I think this could simplify things and could reduce noise. It is also
>probably sufficient for the source to simply halt upon congestion
>notification and resume upon decongestion notification, instead of
>scaling up and down like I suggested above. It also avoids the
>burstiness that would occur with a "congestion notification"-only
>approach where the source guesses when to resume and guesses wrong.
>
>The congestion notification may want to have an expiration period after
>which the sender can resume without receiving a decongestion
>notification? If it receives congestion again, then it can halt again.

Yep, I agree.

Anyway the congestion/decongestion messages should be just a hint, 
because the other peer has to keep the state and a malicious host/guest 
could use it for DoS, so the peer could discard these packets if it has 
no more space to save the state.

Thanks,
Stefano

