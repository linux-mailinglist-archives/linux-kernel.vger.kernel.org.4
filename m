Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D375273E2B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjFZPEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjFZPE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFDBE7B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687791813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ub/VWsuBNP1d/wVrp0FxrBklvO4kjHuqLjqpHpTQ37c=;
        b=ehHxC5pNYC6/BrflycKhHJMPvZEhH70Kp7i/SqoptOwKgDZD58uMtA7FJcH1pa9mFEbyGe
        RAFs5UTBXmKgOQB0IV1rWQXY2mS38o+pvua1/er1SWtTQQhOVB1JrPwrZ6h0B7JhDqxxxv
        P4DgOgbQfx9wl4XeLBgTyJzmdJhC/6Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-RFIWLMLHPOe3gwpDusWz5Q-1; Mon, 26 Jun 2023 11:03:30 -0400
X-MC-Unique: RFIWLMLHPOe3gwpDusWz5Q-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76531f671c0so310782185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687791805; x=1690383805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ub/VWsuBNP1d/wVrp0FxrBklvO4kjHuqLjqpHpTQ37c=;
        b=kwyQwzIblth4r+KCOU85Q63gWF1q0ZNcCM2A1zZroIdkfgdsluNdrHyFjKm09xttgG
         G/o61fW24pks1E+8hHsd707wLttjzciFeUIZN/IBSXZCBg8VkYb2oLyD7mzpqGlWdgc/
         TgBbDfz3NIDdg1+RSUaau0eFriGhNHvcZ3QZedDNpnPrwI+x5s1XfXnKJw/p7wSeK3Kp
         HruyEDKYBeOO6YbveXWM2hJfm3WgTqj5xCuyRJJk30AeCLwWi+ipUSiADL0u6amaPj8T
         82hzOMBuJdyffU0GI7olUUEPGW0OpNP8+7TYVmhb0adS4ct7PRXTVsXjPdoR/MGH6AFj
         CUkQ==
X-Gm-Message-State: AC+VfDxjOk81kbm3aq3L2URLxy/KuyuLbDGTItayxtsxYcfVhtilj6QW
        Khoje5VlRRLi64TM5GhoB/SlqhiYs5m3REwJLvfjD9nHzUBYoiOy/j2AnnUDlFi/DjsuBUJ4ieY
        2yBIYhlM/jTVR1ZN8CrVSTRn1
X-Received: by 2002:a05:620a:2448:b0:765:5ba6:a5d8 with SMTP id h8-20020a05620a244800b007655ba6a5d8mr7093243qkn.56.1687791805407;
        Mon, 26 Jun 2023 08:03:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7kkeJTxwkOuRgwOYiRhgUk3L+mBLGI2Low73pEvZAsI+uLzLMyBVcad67r2Cc4Q8w+k8KCrA==
X-Received: by 2002:a05:620a:2448:b0:765:5ba6:a5d8 with SMTP id h8-20020a05620a244800b007655ba6a5d8mr7093213qkn.56.1687791805149;
        Mon, 26 Jun 2023 08:03:25 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id y26-20020a37e31a000000b00765a7843382sm1194049qki.74.2023.06.26.08.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:03:24 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:03:15 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobbyeshleman@gmail.com>
Cc:     Arseniy Krasnov <oxffffaa@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH RFC net-next v4 6/8] virtio/vsock: support dgrams
Message-ID: <d53tgo4igvz34pycgs36xikjosrncejlzuvh47bszk55milq52@whcyextsxfka>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-6-0cebbb2ae899@bytedance.com>
 <92b3a6df-ded3-6470-39d1-fe0939441abc@gmail.com>
 <ppx75eomyyb354knfkwbwin3il2ot7hf5cefwrt6ztpcbc3pps@q736cq5v4bdh>
 <ZJUho6NbpCgGatap@bullseye>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZJUho6NbpCgGatap@bullseye>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 04:37:55AM +0000, Bobby Eshleman wrote:
>On Thu, Jun 22, 2023 at 06:09:12PM +0200, Stefano Garzarella wrote:
>> On Sun, Jun 11, 2023 at 11:49:02PM +0300, Arseniy Krasnov wrote:
>> > Hello Bobby!
>> >
>> > On 10.06.2023 03:58, Bobby Eshleman wrote:
>> > > This commit adds support for datagrams over virtio/vsock.
>> > >
>> > > Message boundaries are preserved on a per-skb and per-vq entry basis.
>> >
>> > I'm a little bit confused about the following case: let vhost sends 4097 bytes
>> > datagram to the guest. Guest uses 4096 RX buffers in it's virtio queue, each
>> > buffer has attached empty skb to it. Vhost places first 4096 bytes to the first
>> > buffer of guests RX queue, and 1 last byte to the second buffer. Now IIUC guest
>> > has two skb in it rx queue, and user in guest wants to read data - does it read
>> > 4097 bytes, while guest has two skb - 4096 bytes and 1 bytes? In seqpacket there is
>> > special marker in header which shows where message ends, and how it works here?
>>
>> I think the main difference is that DGRAM is not connection-oriented, so
>> we don't have a stream and we can't split the packet into 2 (maybe we
>> could, but we have no guarantee that the second one for example will be
>> not discarded because there is no space).
>>
>> So I think it is acceptable as a restriction to keep it simple.
>>
>> My only doubt is, should we make the RX buffer size configurable,
>> instead of always using 4k?
>>
>I think that is a really good idea. What mechanism do you imagine?

Some parameter in sysfs?

>
>For sendmsg() with buflen > VQ_BUF_SIZE, I think I'd like -ENOBUFS

For the guest it should be easy since it allocates the buffers, but for
the host?

Maybe we should add a field in the configuration space that reports some
sort of MTU.

Something in addition to what Laura had proposed here:
https://markmail.org/message/ymhz7wllutdxji3e

>returned even though it is uncharacteristic of Linux sockets.
>Alternatively, silently dropping is okay... but seems needlessly
>unhelpful.

UDP takes advantage of IP fragmentation, right?
But what happens if a fragment is lost?

We should try to behave in a similar way.

>
>FYI, this patch is broken for h2g because it requeues partially sent
>skbs, so probably doesn't need much code review until we decided on the
>policy.

Got it.

Thanks,
Stefano

