Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AA66E4063
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDQHLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDQHLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F222E40D0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681715445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=khZ23ut9tSZy0CNwgidrOfEO75uvb5JIpDX8+Rd9+Ts=;
        b=U+GI2r8ezwYpGOdTymMXBkeyV6ALtOH2elZF2dJduFyWwzd3N2Cwzp+LY4BEpxZo64Ij5f
        ytSGCTPPiF/mmva15KDZhOCCOBTL4F1nJynKQ10wBPcVS5/YyDicY1KARVy+TVV0JIdkvx
        QI/Us3vNM02IilYr9fm4xvYVGlUR/i4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-3FuphniiPAyFBdfuaftE2w-1; Mon, 17 Apr 2023 03:10:38 -0400
X-MC-Unique: 3FuphniiPAyFBdfuaftE2w-1
Received: by mail-qv1-f70.google.com with SMTP id a9-20020a0ccdc9000000b005df3eac4c0bso7026810qvn.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681715437; x=1684307437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khZ23ut9tSZy0CNwgidrOfEO75uvb5JIpDX8+Rd9+Ts=;
        b=SAJy/il26zBX3UkNlcupf65DOKK5Bn86zhkrgKVa9Swz+UPLoOQSFe8WgUS3dlkpA7
         ZhSS1uHmF1Uf+PdUJ/yW/utNysYmo97dz9wNlaB+DelLczQ+7AyFCKRsiXXEcnAYe4rz
         iS3OjBGRGVbIQIT1b+6H54YSx4DfL5h2Npp6r85FW7WFLshEBBDOlWfNLB45K+PXHxl9
         Z1X6LlCPfzINn+CK9fKwzYB2BiTk7rRZQX8XmYxYaXNesHF/8mwFU8LrKUwqINXw8iWN
         pOTrycOl1iO9NcAoECb+mZgRKDUhybR00iTMqaMaZ/zOUn90VJ643uDjW8xSFSS6ORVH
         M3WA==
X-Gm-Message-State: AAQBX9cDLhjyhZDQz61e1cp7h4V+B7RWaC5+ODKxS45V3c0/VxLYEKR/
        Tn0L/s27RdyR8HfrLuck4Yg1egB41NKttslpef6IKNAbyVoE81aXyAaaXLHXp23pRwQNyJoXBIW
        Y16eO1CC3J0skLW3UoE8wBOTFEP3slxMt9/U=
X-Received: by 2002:ac8:5705:0:b0:3e1:18cc:7fb0 with SMTP id 5-20020ac85705000000b003e118cc7fb0mr19873675qtw.41.1681715437547;
        Mon, 17 Apr 2023 00:10:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZZNAN+4+EZys8WaUUUa9OgEdVXOuEUlcNT1Oqqqd2RWhLnDZZTLPDbDA7IGY19/AulMU52SA==
X-Received: by 2002:ac8:5705:0:b0:3e1:18cc:7fb0 with SMTP id 5-20020ac85705000000b003e118cc7fb0mr19873659qtw.41.1681715437280;
        Mon, 17 Apr 2023 00:10:37 -0700 (PDT)
Received: from redhat.com ([185.199.103.251])
        by smtp.gmail.com with ESMTPSA id p15-20020a05622a00cf00b003ecf475286csm1559676qtw.39.2023.04.17.00.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 00:10:36 -0700 (PDT)
Date:   Mon, 17 Apr 2023 03:10:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230417030713-mutt-send-email-mst@kernel.org>
References: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
 <AM0PR04MB4723C6E99A217F51973710F5D49F9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230416164453-mutt-send-email-mst@kernel.org>
 <CACGkMEvFhVyWb5+ET_akPvnjUq04+ZbJC8o_GtNBWqSMGNum8A@mail.gmail.com>
 <20230417021725-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723B8489F8F9AE547393697D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417023911-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237BFB8BB3A3606CE6A408D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB47237BFB8BB3A3606CE6A408D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 07:03:52AM +0000, Alvaro Karsz wrote:
> > > > Actually, I think that all you need to do is disable NETIF_F_SG,
> > > > and things will work, no?
> > >
> > > I think that this is not so simple, if I understand correctly, by disabling NETIF_F_SG we will never receive a chained skbs to transmit, but we still have more functionality to address, for example:
> > > * The TX timeouts.
> > 
> > I don't get it. With a linear skb we can transmit it as long as there's
> > space for 2 entries in the vq: header and data. What's the source of the
> > timeouts?
> > 
> 
> I'm not saying that this is not possible, I meant that we need more changes to virtio-net.
> The source of the timeouts is from the current implementation of virtnet_poll_tx.
> 
> if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> 	netif_tx_wake_queue(txq);

Oh right. So this should check NETIF_F_SG then.
BTW both ring size and s/g can be tweaked by ethtool, also
needs handling.


> 
> > > * Guest GSO/big MTU (without VIRTIO_NET_F_MRG_RXBUF?), we can't chain page size buffers anymore.
> > 
> > I think we can.  mergeable_min_buf_len will just be large.
> > 
> 
> I meant that we can't just by clearing NETIF_F_SG, we'll need to change virtio-net a little bit more, for example, the virtnet_set_big_packets function.
> 

Right - for RX, big_packets_num_skbfrags ignores ring size and that's
probably a bug if mtu is very large.

-- 
MST

