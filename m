Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DA16E3FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjDQGmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQGmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3011729
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681713673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OxKMHMF5ij1bxNLeFZRcL6SeBcLJINT9bFcDHFvcGBQ=;
        b=YuETFynOezCctj1CJlHYhFR+u8Gtev3GqeiR4y5+NBR8qP9E3DPA4HBtcAIyNzhvt4sDLc
        kVVfYzhcOUvBNMtBVOY2BcM6VhjQ7bc3f3xvBEmtceifg98HEa3AKCm6ygU2JY+y0VuO19
        roQOQ21fzHzFbHc1bga78lJrY93CVNk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-yQjhFGMWPISM5mTPEXDjlA-1; Mon, 17 Apr 2023 02:41:11 -0400
X-MC-Unique: yQjhFGMWPISM5mTPEXDjlA-1
Received: by mail-qk1-f198.google.com with SMTP id 70-20020a370b49000000b0074de765f08eso840278qkl.18
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681713671; x=1684305671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxKMHMF5ij1bxNLeFZRcL6SeBcLJINT9bFcDHFvcGBQ=;
        b=At+v4T6cV95jJ18piVokVVpf57lMK1FcenpJai8KU232fdPxQQe8mQ2BGddHSYCkIL
         YtU/mFPj5Q6SIWYzLHI6VP2/GdqqwjLxNaxZA0s7NFbjziSY21DDXzRvY+o//1aeGe42
         PScrg/Yy+bbM1teqS0prjP2aa5ifYPPzAJh8txmgVsGSvU60hIZE1bQc+U9CRhRit/kO
         jOTBPFS6eRn4U8OAVTzLpEMFw8R4EJJYxmqeXMIzRT2FJfPAnhPJ8RfhmOWKvAuugOoh
         dXeQT+4OthfpXJIB032+HFedjkOo0eOnAdTwu+r34877ncNId13ZNZ39Vax1O9E2K0rJ
         2bdw==
X-Gm-Message-State: AAQBX9cOtv1FLpt8LykUTRC1o/h9K0LutwlgKnBrvrod1iVHyvWHEYCA
        Yz2CISNAI9ynJNlHL9E/JL1bYLoemikjgsxib8J7AydzYF0Mo0IMD//fgkyz8XpyJCdMiRyrs5A
        soU2FKhXDfhoHFQywsDiUSgIL
X-Received: by 2002:a05:622a:144:b0:3e3:9036:8d7b with SMTP id v4-20020a05622a014400b003e390368d7bmr23144629qtw.24.1681713671548;
        Sun, 16 Apr 2023 23:41:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350awUisy2QmOytI/7wHAUSKfUVvRV0PC8LxBgH9zz1azFDxXLfpwgedyZCjCtr2bsDRdI6Gagw==
X-Received: by 2002:a05:622a:144:b0:3e3:9036:8d7b with SMTP id v4-20020a05622a014400b003e390368d7bmr23144611qtw.24.1681713671291;
        Sun, 16 Apr 2023 23:41:11 -0700 (PDT)
Received: from redhat.com ([185.199.103.251])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05620a318800b007456b51ee13sm1898249qkb.16.2023.04.16.23.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 23:41:10 -0700 (PDT)
Date:   Mon, 17 Apr 2023 02:41:04 -0400
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
Message-ID: <20230417023911-mutt-send-email-mst@kernel.org>
References: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
 <AM0PR04MB4723C6E99A217F51973710F5D49F9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230416164453-mutt-send-email-mst@kernel.org>
 <CACGkMEvFhVyWb5+ET_akPvnjUq04+ZbJC8o_GtNBWqSMGNum8A@mail.gmail.com>
 <20230417021725-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723B8489F8F9AE547393697D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4723B8489F8F9AE547393697D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 06:38:43AM +0000, Alvaro Karsz wrote:
> > Actually, I think that all you need to do is disable NETIF_F_SG,
> > and things will work, no?
> 
> I think that this is not so simple, if I understand correctly, by disabling NETIF_F_SG we will never receive a chained skbs to transmit, but we still have more functionality to address, for example:
> * The TX timeouts.

I don't get it. With a linear skb we can transmit it as long as there's
space for 2 entries in the vq: header and data. What's the source of the
timeouts?

> * Guest GSO/big MTU (without VIRTIO_NET_F_MRG_RXBUF?), we can't chain page size buffers anymore.

I think we can.  mergeable_min_buf_len will just be large.


> > Alvaro, can you try?
> 
> It won't matter at the moment, we'll get TX timeout after the first tx packet, we need to address this part as well.

