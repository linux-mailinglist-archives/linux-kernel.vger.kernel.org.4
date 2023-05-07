Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AF96F97CF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 10:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjEGI7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 04:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEGI7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 04:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59151161F
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 01:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683449945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yeeGTjp1K1OeCb3ZIEFft75WO1ELEw08OZwAFoljYwY=;
        b=MlCOsEfktIlfqWuKVQsf7MPlkA5KlLOAmzkznToc6T7l7a3wAbG7HXbcLVQqLU/KkXspiZ
        HbBLwnAXkNZJ6iES6y+DM5hKxZBoxUVHz1tCVIWO+/MliC45qtsz9tLCChvpndzct+AMwu
        ld8Po6og3reXRX8u4akSWwGC0HITbpQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-lYGFP4NHMlKtWt6oUASxOw-1; Sun, 07 May 2023 04:59:04 -0400
X-MC-Unique: lYGFP4NHMlKtWt6oUASxOw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f21e35dc08so13882305e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 01:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683449943; x=1686041943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeeGTjp1K1OeCb3ZIEFft75WO1ELEw08OZwAFoljYwY=;
        b=Gcu+15tKrKvGMeFsc02B0kvtNJVZJzrrmz9SO2flukx/tyQs3kxaMcvrbWTzUoRJOg
         7JfkGB7QsWGcIUVW0jAFkkVeqFhbs95UcPH1fpucUoyEJcyvzmWJ6ubzDC7XnusqdXUG
         nT6Pz/2PkBHnuUDtR6fd8s4bjXZ3gAVi8vtLUB1gMIhM9VcysRiVb9KJ312vfUFuX53V
         BI0cuicExMYu2SX6Vu1sCbfDDLd43ltsg2aZ9k+IPWLWCaq6fIDIybIuL8Hn4UHNYBiK
         /MvkIRG1tBZ2AnZjvrvjlCedHJ2eX9YkS7cyNcNPGzN+dOM6QFMKasL3owUkH5epwUh6
         1geA==
X-Gm-Message-State: AC+VfDzaXJOk5Op8uEskAgmBNFUOnRkIe736NfYTrhr/puNbZbj0XLna
        HtEpUyYrcDe5XKqzzTyapMNHZKBhsj1e0vzGxAropfwkiVIwbxY3XGUSMUrlkvAISfKFZcOXxsl
        Q27T9++0DvsGgigFB4i34NnYT
X-Received: by 2002:a05:600c:b4b:b0:3f2:73a:32fc with SMTP id k11-20020a05600c0b4b00b003f2073a32fcmr4521784wmr.32.1683449943589;
        Sun, 07 May 2023 01:59:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7a9eutfAfd8aF4Cg4js80tavVGTVSzB9sy+7qygN//4rj17mi5XdK64Z91HAiqV/PL3Wlj8A==
X-Received: by 2002:a05:600c:b4b:b0:3f2:73a:32fc with SMTP id k11-20020a05600c0b4b00b003f2073a32fcmr4521773wmr.32.1683449943324;
        Sun, 07 May 2023 01:59:03 -0700 (PDT)
Received: from redhat.com ([2.52.158.28])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c219300b003f173419e7asm12993148wme.43.2023.05.07.01.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 01:59:02 -0700 (PDT)
Date:   Sun, 7 May 2023 04:58:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Hao Chen <chenh@yusur.tech>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>, huangml@yusur.tech,
        zy@yusur.tech, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_net: set default mtu to 1500 when 'Device maximum
 MTU' bigger than 1500
Message-ID: <20230507045627-mutt-send-email-mst@kernel.org>
References: <20230506021529.396812-1-chenh@yusur.tech>
 <1683341417.0965195-4-xuanzhuo@linux.alibaba.com>
 <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2023 at 04:56:35PM +0800, Hao Chen wrote:
> 
> 
> 在 2023/5/6 10:50, Xuan Zhuo 写道:
> > On Sat,  6 May 2023 10:15:29 +0800, Hao Chen <chenh@yusur.tech> wrote:
> > > When VIRTIO_NET_F_MTU(3) Device maximum MTU reporting is supported.
> > > If offered by the device, device advises driver about the value of its
> > > maximum MTU. If negotiated, the driver uses mtu as the maximum
> > > MTU value. But there the driver also uses it as default mtu,
> > > some devices may have a maximum MTU greater than 1500, this may
> > > cause some large packages to be discarded,
> > 
> > You mean tx packet?
> Yes.
> > 
> > If yes, I do not think this is the problem of driver.
> > 
> > Maybe you should give more details about the discard.
> > 
> In the current code, if the maximum MTU supported by the virtio net hardware
> is 9000, the default MTU of the virtio net driver will also be set to 9000.
> When sending packets through "ping -s 5000", if the peer router does not
> support negotiating a path MTU through ICMP packets, the packets will be
> discarded. If the peer router supports negotiating path mtu through ICMP
> packets, the host side will perform packet sharding processing based on the
> negotiated path mtu, which is generally within 1500.
> This is not a bugfix patch, I think setting the default mtu to within 1500
> would be more suitable here.Thanks.

I don't think VIRTIO_NET_F_MTU is appropriate for support for jumbo packets.
The spec says:
	The device MUST forward transmitted packets of up to mtu (plus low level ethernet header length) size with
	gso_type NONE or ECN, and do so without fragmentation, after VIRTIO_NET_F_MTU has been success-
	fully negotiated.
VIRTIO_NET_F_MTU has been designed for all kind of tunneling devices,
and this is why we set mtu to max by default.

For things like jumbo frames where MTU might or might not be available,
a new feature would be more appropriate.

> > > so I changed the MTU to a more
> > > general 1500 when 'Device maximum MTU' bigger than 1500.
> > > 
> > > Signed-off-by: Hao Chen <chenh@yusur.tech>
> > > ---
> > >   drivers/net/virtio_net.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 8d8038538fc4..e71c7d1b5f29 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -4040,7 +4040,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >   			goto free;
> > >   		}
> > > 
> > > -		dev->mtu = mtu;
> > > +		if (mtu > 1500)
> > 
> > s/1500/ETH_DATA_LEN/
> > 
> > Thanks.
> > 
> > > +			dev->mtu = 1500;
> > > +		else
> > > +			dev->mtu = mtu;
> > >   		dev->max_mtu = mtu;
> > >   	}
> > > 
> > > --
> > > 2.27.0
> > > 

