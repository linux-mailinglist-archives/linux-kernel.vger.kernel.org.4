Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9336FA785
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjEHKbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbjEHKbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E140E4C07
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683541816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xPsu5YVFrEenCLv+iZuaZj4Zmadv4HGEz/gE1xJGp6I=;
        b=drUTJiB1n3DLo5YemSOacZmi7dmMWEFhRFEpjOdQpjCrYNxPfjsjImqFlnuHBt6nxZAauP
        QdpE6PtLYlDDoX4Oqz1Df7aPTtUCYmwg4Aw/OdE/h5tIUHkfsszHCaOAfwjFrl1M+q7gKE
        ef6l0JX7REoyuopX8Ao803fco2P/ym0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-d4ujyNy9PgmuuRGlGQe7WA-1; Mon, 08 May 2023 06:30:14 -0400
X-MC-Unique: d4ujyNy9PgmuuRGlGQe7WA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-306286b3573so2681688f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 03:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683541813; x=1686133813;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPsu5YVFrEenCLv+iZuaZj4Zmadv4HGEz/gE1xJGp6I=;
        b=KypY3kKrQvB4oVXqFpZ0TJ3uOnToWwZK1YhZmFe7S2s+8yeqFKItd6B67iRhTkiF1s
         3FKLUfLsJ8RBebS7gKiepdy4wuvoyppeuoJ0dr9VouFKFDEbTCQBB6KTgGep5Bs7E64W
         DvzXl9lpd5TGNQAJmQ2l8y6bGxm3Za5nKBJrxquS7XxdN6/bkZQjJSi50p7x6Cf7y6W8
         A8kBEoCbyQAonPYc9f8CpV1exhKp98KyH9KTcZfq+D2VJUHPdPC4fX0qwT+8xrLpLUfn
         PYNFniQwnkyv4I5zUbMoK+A+CF7ax1HZRj6G58ALQdrvZ5UxekzpURyvel62kImybV/C
         ke0Q==
X-Gm-Message-State: AC+VfDxHkRl1lX8y2ZtOZdi53jiadR6HTyGmkmkrOMH6kxuzacNdi2L9
        iqKqZeQ03CThIAsJ2y8a7eN7Ltp2O1smGtl286FTPEPOQeCd40T+Hb4fej6aZDrpA/RwhjvIjM0
        4utCC3n+owg1ZLujJ5qkEOpKs
X-Received: by 2002:adf:e943:0:b0:306:2cf5:79dc with SMTP id m3-20020adfe943000000b003062cf579dcmr7718610wrn.35.1683541813557;
        Mon, 08 May 2023 03:30:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ykEugQ/sjlWtVtf+RWhyd+Wdn5biO6WeKJ/H0kdlQUIkECfX6aLaJNv/UFBtqbWwQjfrirw==
X-Received: by 2002:adf:e943:0:b0:306:2cf5:79dc with SMTP id m3-20020adfe943000000b003062cf579dcmr7718591wrn.35.1683541813164;
        Mon, 08 May 2023 03:30:13 -0700 (PDT)
Received: from redhat.com ([31.187.78.15])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d6e0e000000b0030631dcbea6sm10959097wrz.77.2023.05.08.03.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 03:30:12 -0700 (PDT)
Date:   Mon, 8 May 2023 06:30:07 -0400
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
Message-ID: <20230508062928-mutt-send-email-mst@kernel.org>
References: <20230506021529.396812-1-chenh@yusur.tech>
 <1683341417.0965195-4-xuanzhuo@linux.alibaba.com>
 <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
 <20230507045627-mutt-send-email-mst@kernel.org>
 <1683511319.099806-2-xuanzhuo@linux.alibaba.com>
 <20230508020953-mutt-send-email-mst@kernel.org>
 <1683526688.7492425-1-xuanzhuo@linux.alibaba.com>
 <20230508024147-mutt-send-email-mst@kernel.org>
 <1683531716.238961-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1683531716.238961-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 03:41:56PM +0800, Xuan Zhuo wrote:
> On Mon, 8 May 2023 02:43:24 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, May 08, 2023 at 02:18:08PM +0800, Xuan Zhuo wrote:
> > > On Mon, 8 May 2023 02:15:46 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Mon, May 08, 2023 at 10:01:59AM +0800, Xuan Zhuo wrote:
> > > > > On Sun, 7 May 2023 04:58:58 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > On Sat, May 06, 2023 at 04:56:35PM +0800, Hao Chen wrote:
> > > > > > >
> > > > > > >
> > > > > > > 在 2023/5/6 10:50, Xuan Zhuo 写道:
> > > > > > > > On Sat,  6 May 2023 10:15:29 +0800, Hao Chen <chenh@yusur.tech> wrote:
> > > > > > > > > When VIRTIO_NET_F_MTU(3) Device maximum MTU reporting is supported.
> > > > > > > > > If offered by the device, device advises driver about the value of its
> > > > > > > > > maximum MTU. If negotiated, the driver uses mtu as the maximum
> > > > > > > > > MTU value. But there the driver also uses it as default mtu,
> > > > > > > > > some devices may have a maximum MTU greater than 1500, this may
> > > > > > > > > cause some large packages to be discarded,
> > > > > > > >
> > > > > > > > You mean tx packet?
> > > > > > > Yes.
> > > > > > > >
> > > > > > > > If yes, I do not think this is the problem of driver.
> > > > > > > >
> > > > > > > > Maybe you should give more details about the discard.
> > > > > > > >
> > > > > > > In the current code, if the maximum MTU supported by the virtio net hardware
> > > > > > > is 9000, the default MTU of the virtio net driver will also be set to 9000.
> > > > > > > When sending packets through "ping -s 5000", if the peer router does not
> > > > > > > support negotiating a path MTU through ICMP packets, the packets will be
> > > > > > > discarded. If the peer router supports negotiating path mtu through ICMP
> > > > > > > packets, the host side will perform packet sharding processing based on the
> > > > > > > negotiated path mtu, which is generally within 1500.
> > > > > > > This is not a bugfix patch, I think setting the default mtu to within 1500
> > > > > > > would be more suitable here.Thanks.
> > > > > >
> > > > > > I don't think VIRTIO_NET_F_MTU is appropriate for support for jumbo packets.
> > > > > > The spec says:
> > > > > > 	The device MUST forward transmitted packets of up to mtu (plus low level ethernet header length) size with
> > > > > > 	gso_type NONE or ECN, and do so without fragmentation, after VIRTIO_NET_F_MTU has been success-
> > > > > > 	fully negotiated.
> > > > > > VIRTIO_NET_F_MTU has been designed for all kind of tunneling devices,
> > > > > > and this is why we set mtu to max by default.
> > > > > >
> > > > > > For things like jumbo frames where MTU might or might not be available,
> > > > > > a new feature would be more appropriate.
> > > > >
> > > > >
> > > > > So for jumbo frame, what is the problem?
> > > > >
> > > > > We are trying to do this. @Heng
> > > > >
> > > > > Thanks.
> > > >
> > > > It is not a problem as such. But VIRTIO_NET_F_MTU will set the
> > > > default MTU not just the maximum one, because spec seems to
> > > > say it can.
> > >
> > > I see.
> > >
> > > In the case of Jumbo Frame, we also hope that the driver will set the default
> > > directly to the max mtu. Just like what you said "Bigger packets = better
> > > performance."
> > >
> > > I don't know, in any scenario, when the hardware supports a large mtu, but we do
> > > not want the user to use it by default.
> >
> > When other devices on the same LAN have mtu set to 1500 and
> > won't accept bigger packets.
> 
> So, that depends on pmtu/tcp-probe-mtu.
> 
> If the os without pmtu/tcp-probe-mtu has a bigger mtu, then it's big packet
> will lost.
> 
> Thanks.
> 

pmtu is designed for routing. LAN is supposed to be configured with
a consistent MTU.

> >
> > > Of course, the scene that this patch
> > > wants to handle does exist, but I have never thought that this is a problem at
> > > the driver level.
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > > > > > so I changed the MTU to a more
> > > > > > > > > general 1500 when 'Device maximum MTU' bigger than 1500.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Hao Chen <chenh@yusur.tech>
> > > > > > > > > ---
> > > > > > > > >   drivers/net/virtio_net.c | 5 ++++-
> > > > > > > > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > > > index 8d8038538fc4..e71c7d1b5f29 100644
> > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > @@ -4040,7 +4040,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > > > > > >   			goto free;
> > > > > > > > >   		}
> > > > > > > > >
> > > > > > > > > -		dev->mtu = mtu;
> > > > > > > > > +		if (mtu > 1500)
> > > > > > > >
> > > > > > > > s/1500/ETH_DATA_LEN/
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > > > > +			dev->mtu = 1500;
> > > > > > > > > +		else
> > > > > > > > > +			dev->mtu = mtu;
> > > > > > > > >   		dev->max_mtu = mtu;
> > > > > > > > >   	}
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.27.0
> > > > > > > > >
> > > > > >
> > > >
> >

