Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77926F9F99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjEHGQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjEHGQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF3411542
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 23:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683526555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a16qsR25aXRVKPUMu4eumPHJGCumyCFazBn+gGGgB/I=;
        b=OLQee0+zsMbX5aRZ0LvnQKOsSFx4ybwjinZKptM+s8bYB3N7PfYLE2TnKwboK6eNB5HZ3E
        7voXucAparkfNDwRu/O/PaLLf/zs6IBIFT4bCupy1cDApBQYRd+G22WquBGgnK+GbadcBO
        Nf6rO68CRYHbBw+ftlX8dn+sdwp4O7g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-hU1uG0cXPzm0CBK4aUF_vQ-1; Mon, 08 May 2023 02:15:53 -0400
X-MC-Unique: hU1uG0cXPzm0CBK4aUF_vQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f16fa91923so22408805e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 23:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683526551; x=1686118551;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a16qsR25aXRVKPUMu4eumPHJGCumyCFazBn+gGGgB/I=;
        b=TeCiVmgjFUjDsoLiLKHYEGGEvKfcyqC+t7xOvLluq4f6L5/wdVIKszZDkCW7zXzVci
         hIqzx9rL+wA26QzcSQMafVdKl6HSyaxmbBe/Cse/pgw4AhUveOQUM0SuzlyrN9Y8oDkm
         s9AW0mEMK/CYuW8PmCR2osFCB7aYXWfQlwqt3hP0J06uWHmqtW4O4hQ64Ndg8yfLl7Jk
         oWEjwjTkd4y+6r9saSWt1/utr7BF7aG1ZHcIN/zMsKL2N8Np6263PIA2i5ZctGaA7jKt
         yfkcY+W/rYGlKAGa3TYJWMGfBAdeGn1dl2PEBzlX4JMfp/anZ9gh3kriWZdL+pcKXONz
         HDYA==
X-Gm-Message-State: AC+VfDw5xjooFuXH2RBxaYitjg1LzslxgAj5+6gVJPbtuJz8jGiNxgr1
        RcM91MHLeXtB1xboF3s8K16eXxiLyAQKzM3MOkzbJBWsuXSGsRBrdcmzs6T+9SMSSlXJzCza+gv
        oSsobUnr/WcpG2gwcBExpgGAxAqJvX7Tw
X-Received: by 2002:adf:fccd:0:b0:2f5:7e67:9c68 with SMTP id f13-20020adffccd000000b002f57e679c68mr6231383wrs.30.1683526551627;
        Sun, 07 May 2023 23:15:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51aIif9Zzf71VSyESMCs9ojU26BNYa4ExPKWLDuG2PEVBUuxy/OQj9y3Xq+EYvx0RZfh2HcQ==
X-Received: by 2002:adf:fccd:0:b0:2f5:7e67:9c68 with SMTP id f13-20020adffccd000000b002f57e679c68mr6231373wrs.30.1683526551304;
        Sun, 07 May 2023 23:15:51 -0700 (PDT)
Received: from redhat.com ([2.52.158.28])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600010cd00b00306299be5a2sm10289776wrx.72.2023.05.07.23.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 23:15:50 -0700 (PDT)
Date:   Mon, 8 May 2023 02:15:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     huangml@yusur.tech, zy@yusur.tech,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hao Chen <chenh@yusur.tech>, hengqi@linux.alibaba.com
Subject: Re: [PATCH] virtio_net: set default mtu to 1500 when 'Device maximum
 MTU' bigger than 1500
Message-ID: <20230508020953-mutt-send-email-mst@kernel.org>
References: <20230506021529.396812-1-chenh@yusur.tech>
 <1683341417.0965195-4-xuanzhuo@linux.alibaba.com>
 <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
 <20230507045627-mutt-send-email-mst@kernel.org>
 <1683511319.099806-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1683511319.099806-2-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 10:01:59AM +0800, Xuan Zhuo wrote:
> On Sun, 7 May 2023 04:58:58 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Sat, May 06, 2023 at 04:56:35PM +0800, Hao Chen wrote:
> > >
> > >
> > > 在 2023/5/6 10:50, Xuan Zhuo 写道:
> > > > On Sat,  6 May 2023 10:15:29 +0800, Hao Chen <chenh@yusur.tech> wrote:
> > > > > When VIRTIO_NET_F_MTU(3) Device maximum MTU reporting is supported.
> > > > > If offered by the device, device advises driver about the value of its
> > > > > maximum MTU. If negotiated, the driver uses mtu as the maximum
> > > > > MTU value. But there the driver also uses it as default mtu,
> > > > > some devices may have a maximum MTU greater than 1500, this may
> > > > > cause some large packages to be discarded,
> > > >
> > > > You mean tx packet?
> > > Yes.
> > > >
> > > > If yes, I do not think this is the problem of driver.
> > > >
> > > > Maybe you should give more details about the discard.
> > > >
> > > In the current code, if the maximum MTU supported by the virtio net hardware
> > > is 9000, the default MTU of the virtio net driver will also be set to 9000.
> > > When sending packets through "ping -s 5000", if the peer router does not
> > > support negotiating a path MTU through ICMP packets, the packets will be
> > > discarded. If the peer router supports negotiating path mtu through ICMP
> > > packets, the host side will perform packet sharding processing based on the
> > > negotiated path mtu, which is generally within 1500.
> > > This is not a bugfix patch, I think setting the default mtu to within 1500
> > > would be more suitable here.Thanks.
> >
> > I don't think VIRTIO_NET_F_MTU is appropriate for support for jumbo packets.
> > The spec says:
> > 	The device MUST forward transmitted packets of up to mtu (plus low level ethernet header length) size with
> > 	gso_type NONE or ECN, and do so without fragmentation, after VIRTIO_NET_F_MTU has been success-
> > 	fully negotiated.
> > VIRTIO_NET_F_MTU has been designed for all kind of tunneling devices,
> > and this is why we set mtu to max by default.
> >
> > For things like jumbo frames where MTU might or might not be available,
> > a new feature would be more appropriate.
> 
> 
> So for jumbo frame, what is the problem?
> 
> We are trying to do this. @Heng
> 
> Thanks.

It is not a problem as such. But VIRTIO_NET_F_MTU will set the
default MTU not just the maximum one, because spec seems to
say it can.


> 
> >
> > > > > so I changed the MTU to a more
> > > > > general 1500 when 'Device maximum MTU' bigger than 1500.
> > > > >
> > > > > Signed-off-by: Hao Chen <chenh@yusur.tech>
> > > > > ---
> > > > >   drivers/net/virtio_net.c | 5 ++++-
> > > > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 8d8038538fc4..e71c7d1b5f29 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -4040,7 +4040,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > >   			goto free;
> > > > >   		}
> > > > >
> > > > > -		dev->mtu = mtu;
> > > > > +		if (mtu > 1500)
> > > >
> > > > s/1500/ETH_DATA_LEN/
> > > >
> > > > Thanks.
> > > >
> > > > > +			dev->mtu = 1500;
> > > > > +		else
> > > > > +			dev->mtu = mtu;
> > > > >   		dev->max_mtu = mtu;
> > > > >   	}
> > > > >
> > > > > --
> > > > > 2.27.0
> > > > >
> >

