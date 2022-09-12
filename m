Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747D05B6002
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiILSNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiILSNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A60419B9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663006392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MIivuanKSjygaobAWTqz6Vlrz5BF6yE307kFzPCTliY=;
        b=KhwxpNx5B3Ye2r8CCZQtWpI8BKNK6eFzYLr0q5HatB3YxE21/nwiqSIOXD4+3dVqXU6IeM
        NqFCw05NnNP3n4xdm8t1Z/CCcAc1140aYszZGQHoSRH9sJHeBvk42lpjz1NlzOfDLjBAW6
        ZbHNM6i9y6lcIrildlvF7jJo445MYaU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-488-2g8OFTu7OketjDPiqLHnaA-1; Mon, 12 Sep 2022 14:13:11 -0400
X-MC-Unique: 2g8OFTu7OketjDPiqLHnaA-1
Received: by mail-lf1-f71.google.com with SMTP id h4-20020a05651211c400b00497abd0d657so3123574lfr.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MIivuanKSjygaobAWTqz6Vlrz5BF6yE307kFzPCTliY=;
        b=JYoB7j49JMBLisR3CNvA/8yhIfAQBLlCNeKgvm0ndXAqn3SbMIt21if0vmT6y2Jtr1
         JSy8upYkoWikcM3uxpLGqAL5t8+g9rYgJIueQqSj1VefqWk7zRff/SaVw4tc5CcTY18P
         bIocZupgDfM932btAMK90zIOxkF+xGjqXFm6P+0dPyEc0G9v4V0E+09K9AuikQ9Y/yJM
         UOMOJFMvl1/Ddhdv1+59Zd7ms8sMpjlSlLPf78PhnEnOhhj/tpXZ2uNcWls6N0RvmD8u
         OvqQCamWSjZ+Hhc3ZXEdQl24y5eto3qv5lwiaB83rrJyfpi/IXEAGcYCaFlMUCUtrPSX
         0h7g==
X-Gm-Message-State: ACgBeo0tCm0AyKse04GP/jTWHMyBa5n6tpZY4ZXB5oJwiZH5E9ETl48X
        mqg5KernwQVYGQS3DcyBb5ufGcDzQ6FvNMUrxouWajCx6ts9MUOjRtIT26dGJjrlNZkHDX883Kq
        c6Fx2ytbtjZG0rpkKI/At9I4tHi4EWquuZHz5I7Kf
X-Received: by 2002:a05:6512:3b1e:b0:49b:49d9:cb9e with SMTP id f30-20020a0565123b1e00b0049b49d9cb9emr877217lfv.201.1663006390234;
        Mon, 12 Sep 2022 11:13:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ppAN5/qdHGxQeudg4Zh5HihxK1wLBPBp6mq9A3a1ed9G1ccE8gIbz65FRZyZtWK+AopezeLNQh/bU8TMuMvk=
X-Received: by 2002:a05:6512:3b1e:b0:49b:49d9:cb9e with SMTP id
 f30-20020a0565123b1e00b0049b49d9cb9emr877188lfv.201.1663006389976; Mon, 12
 Sep 2022 11:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <YxdKiUzlfpHs3h3q@fedora> <Yv5PFz1YrSk8jxzY@bullseye> <20220908143652.tfyjjx2z6in6v66c@sgarzare-redhat>
 <YxuCVfFcRdWHeeh8@bullseye>
In-Reply-To: <YxuCVfFcRdWHeeh8@bullseye>
From:   Stefano Garzarella <sgarzare@redhat.com>
Date:   Mon, 12 Sep 2022 20:12:58 +0200
Message-ID: <CAGxU2F5HG_UouKzJNuvfeCASJ4j84qPY9-7-yFUpEtAJQSoxJg@mail.gmail.com>
Subject: Re: Call to discuss vsock netdev/sk_buff [was Re: [PATCH 0/6]
 virtio/vsock: introduce dgrams, sk_buff, and qdisc]
To:     Bobby Eshleman <bobbyeshleman@gmail.com>
Cc:     Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Bobby Eshleman <bobby.eshleman@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 8:13 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
>
> Hey Stefano, thanks for sending this out.
>
> On Thu, Sep 08, 2022 at 04:36:52PM +0200, Stefano Garzarella wrote:
> >
> > Looking better at the KVM forum sched, I found 1h slot for Sep 15 at 16:30
> > UTC.
> >
> > Could this work for you?
>
> Unfortunately, I can't make this time slot.

No problem at all!

>
> My schedule also opens up a lot the week of the 26th, especially between
> 16:00 and 19:00 UTC, as well as after 22:00 UTC.

Great, that week works for me too.
What about Sep 27 @ 16:00 UTC?

Thanks,
Stefano

