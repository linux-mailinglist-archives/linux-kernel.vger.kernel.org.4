Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE0A6F302B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 12:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjEAKWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 06:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAKWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 06:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAB710E5
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 03:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682936459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xqEYTLc79qp9oTPQxNKqZLuaG3/dvV631bV4KWP+w7E=;
        b=D49GZzgdH3Z7a2EX/fXuL7zDJ0NgpMqd5qeUPRQv2WJVL6jNQMAc8OTo9Qs/bM9qcgZ2ki
        7a3ZGQKvMiWqeS/ozIGmkLtB6qmMYuOHdnyXpE43HDmaJ857IleHLIB9i+EwINQgUrlaHf
        O13d90aqhAHoEWQF35kJh5ClG77UpuE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-U2lkcp7qPlygcBF5lphqRw-1; Mon, 01 May 2023 06:20:58 -0400
X-MC-Unique: U2lkcp7qPlygcBF5lphqRw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f173bd0d1bso14191225e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 03:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682936456; x=1685528456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqEYTLc79qp9oTPQxNKqZLuaG3/dvV631bV4KWP+w7E=;
        b=lOnbG//o8nsdHsxNJ7aAQV1/FLI2SBbnNi15OEBYrR32/upeSaXIiU4FTNfxroFy84
         Ycp12Px5nKm7Ph5clpk04aUrixmSt7p8X0BTbpdXi1oQkeRB7EmWyH9eSwQZckDdk5ZJ
         LxFNsg5hqjvhlNSfzNVWhYuJlrqchfdwkHdQkWiMfEmDh6Kbtujzqr2lWncEiccc7fQ1
         XCBU5i/6WQAhzVkoYcp8kqZcIKi0AXpxjpKgV+FM+Ti3sNoihEA0NaVFnbtT0bfvGpSE
         Znls0Dpt/ylnPEtTpSYb9RGSE/0QDeH2fJ1Z9s1rWDJ5p5lb/m8xjC4neigfXVhV5Kky
         +y8w==
X-Gm-Message-State: AC+VfDyXYwMsjJfaWUms7qCxoouCcBpWpP6MpZdX3DwVueQgyf8wIDBj
        5ec6eNYL3xTMpMUnSULtsumkDV2B7ZoSv5AFtTx5OZixUj/LbGSfkAKG1kWdIhAaitQWR7geCTZ
        GfarrbOZnER57bi8Zyw50W9P0lL2Lii5f
X-Received: by 2002:a1c:ed0e:0:b0:3f2:5999:4f2b with SMTP id l14-20020a1ced0e000000b003f259994f2bmr9139286wmh.33.1682936456679;
        Mon, 01 May 2023 03:20:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72X1vR13VjjxYqG1HTUb+n8Z2asBncrr5dEu91cJ0Bd7PlhwGBobchaQrzQgj/VfvezvCgTA==
X-Received: by 2002:a1c:ed0e:0:b0:3f2:5999:4f2b with SMTP id l14-20020a1ced0e000000b003f259994f2bmr9139277wmh.33.1682936456371;
        Mon, 01 May 2023 03:20:56 -0700 (PDT)
Received: from redhat.com ([2a06:c701:742c:c300:3695:a81b:6f0b:8940])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d5186000000b003062b57ffd1sm3366770wrv.50.2023.05.01.03.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 03:20:55 -0700 (PDT)
Date:   Mon, 1 May 2023 06:20:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC PATCH net 2/3] virtio-net: allow usage of vrings smaller
 than MAX_SKB_FRAGS + 2
Message-ID: <20230501061401-mutt-send-email-mst@kernel.org>
References: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
 <20230430131518.2708471-3-alvaro.karsz@solid-run.com>
 <20230430093009-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723043772ACAF516D6BFA79D4699@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4723043772ACAF516D6BFA79D4699@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 30, 2023 at 06:54:08PM +0000, Alvaro Karsz wrote:
> > > At the moment, if a network device uses vrings with less than
> > > MAX_SKB_FRAGS + 2 entries, the device won't be functional.
> > >
> > > The following condition vq->num_free >= 2 + MAX_SKB_FRAGS will always
> > > evaluate to false, leading to TX timeouts.
> > >
> > > This patch introduces a new variable, single_pkt_max_descs, that holds
> > > the max number of descriptors we may need to handle a single packet.
> > >
> > > This patch also detects the small vring during probe, blocks some
> > > features that can't be used with small vrings, and fails probe,
> > > leading to a reset and features re-negotiation.
> > >
> > > Features that can't be used with small vrings:
> > > GRO features (VIRTIO_NET_F_GUEST_*):
> > > When we use small vrings, we may not have enough entries in the ring to
> > > chain page size buffers and form a 64K buffer.
> > > So we may need to allocate 64k of continuous memory, which may be too
> > > much when the system is stressed.
> > >
> > > This patch also fixes the MTU size in small vring cases to be up to the
> > > default one, 1500B.
> > 
> > and then it should clear VIRTIO_NET_F_MTU?
> > 
> 
> Following [1], I was thinking to accept the feature and a let the device figure out that it can't transmit a big packet, since the RX buffers are not big enough (without VIRTIO_NET_F_MRG_RXBUF).
> But, I think that we may need to block the MTU feature after all.
> Quoting the spec:
> 
> A driver SHOULD negotiate VIRTIO_NET_F_MTU if the device offers it.
> If the driver negotiates VIRTIO_NET_F_MTU, it MUST supply enough receive buffers to receive at least one receive packet of size mtu (plus low level ethernet header length) with gso_type NONE or ECN.
> 
> So, if VIRTIO_NET_F_MTU is negotiated, we MUST supply enough receive buffers.
> So I think that blocking VIRTIO_NET_F_MTU  should be the way to go, If mtu > 1500.
> 
> [1] https://lore.kernel.org/lkml/20230417031052-mutt-send-email-mst@kernel.org/


First up to 4k should not be a problem. Even jumbo frames e.g. 9k
is highly likely to succeed. And a probe time which is often boot
even 64k isn't a problem ...

Hmm. We could allocate large buffers at probe time. Reuse them and
copy data over.

IOW reusing  GOOD_COPY_LEN flow for this case.  Not yet sure how I feel
about this. OTOH it removes the need for the whole feature blocking
approach, does it not?
WDYT?


> > > +     /* How many ring descriptors we may need to transmit a single packet */
> > > +     u16 single_pkt_max_descs;
> > > +
> > > +     /* Do we have virtqueues with small vrings? */
> > > +     bool svring;
> > > +
> > >       /* CPU hotplug instances for online & dead */
> > >       struct hlist_node node;
> > >       struct hlist_node node_dead;
> > 
> > worth checking that all these layout changes don't push useful things to
> > a different cache line. can you add that analysis?
> > 
> 
> Good point.
> I think that we can just move these to the bottom of the struct.
> 
> > 
> > I see confusiong here wrt whether some rings are "small"? all of them?
> > some rx rings? some tx rings? names should make it clear.
> 
> The small vring is a device attribute, not a vq attribute. It blocks features, which affects the entire device.
> Maybe we can call it "small vring mode".
> 
> > also do we really need bool svring? can't we just check single_pkt_max_descs
> > all the time?
> > 
> 
> We can work without the bool, we could always check if single_pkt_max_descs != MAX_SKB_FRAGS + 2.
> It doesn't really matter to me, I was thinking it may be more readable this way.
> 
> > > +static bool virtnet_uses_svring(struct virtnet_info *vi)
> > > +{
> > > +     u32 i;
> > > +
> > > +     /* If a transmit/receive virtqueue is small,
> > > +      * we cannot handle fragmented packets.
> > > +      */
> > > +     for (i = 0; i < vi->max_queue_pairs; i++) {
> > > +             if (IS_SMALL_VRING(virtqueue_get_vring_size(vi->sq[i].vq)) ||
> > > +                 IS_SMALL_VRING(virtqueue_get_vring_size(vi->rq[i].vq)))
> > > +                     return true;
> > > +     }
> > > +
> > > +     return false;
> > > +}
> > 
> > I see even if only some rings are too small we force everything to use
> > small ones. Wouldn't it be better to just disable small ones in this
> > case? That would not need a reset.
> > 
> 
> I'm not sure. It may complicate things.
> 
> What if all TX vqs are small?
> What if all RX vqs are small?
> What if we end up with an unbalanced number of TX vqs and RX vqs? is this allowed by the spec?
> What if we end up disabling the RX default vq (receiveq1)?
> 
> I guess we could do it, after checking some conditions.
> Maybe we can do it in a follow up patch?
> Do you think it's important for it to be included since day 1?
> 
> I think that the question is: what's more important, to use all the vqs while blocking some features, or to use part of the vqs without blocking features?
> 
> > > +
> > > +/* Function returns the number of features it blocked */
> > 
> > We don't need the # though. Make it bool?
> > 
> 
> Sure.
> 

