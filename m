Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E916EDE4E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjDYIkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjDYIj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:39:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F0D14461
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682411705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12yPNwee6eKmLgy6pNQQ5971cnoVK8ZLgf7UFS2TwrU=;
        b=SnrKdbHK1WzgQpXjmh5e4SGPv2zOrzIuNUB8NduF/PnFAN/WVfvXuJcqNHfdvEHE2jop1Z
        n/c2C0SdUsWkuCqumf4gDc7l/GGvbcXFHYc4vLeN8tpw2IOc+2A2gDhRC0RAl/CyzKgdWq
        NujJFixNfKEWFuHNa4mKxX17qcAANNk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-ZLLAGlQMPyWjqctvw4FcEQ-1; Tue, 25 Apr 2023 04:35:04 -0400
X-MC-Unique: ZLLAGlQMPyWjqctvw4FcEQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2fbb99cb2easo1725423f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682411703; x=1685003703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12yPNwee6eKmLgy6pNQQ5971cnoVK8ZLgf7UFS2TwrU=;
        b=eXR0/fziXTpoZ+bEeuMMN3arYKdE4Fpf8HwxQU1FwrtFnaCW3P6NgjIJiE8CcKmBhU
         OvU7Z1pG0smTM+e6TSznReFp/BaxXhheMCb0WUFfnZMu6jHaaerozLm3HLJL3VjO9N3D
         J8TVebShIq5qbsiaefDHKm6pe6+2QQZXPC2GqYL8UjrTMIOSZsLJgbx62wujx0+w3ins
         YiNPhiVnCG/Y/lVW9LIM6n9V7jfZv5BOHM68+euTKvbsngZHiRFcOOV58U5dN4itDPgU
         NznF1JmncCSWjM5XkMUuy1LYC2XOeZSigYlur2cHDoI/P9bQkm2YTQfBvbNPaQsA+KDp
         x1rg==
X-Gm-Message-State: AAQBX9cAEEWjFZoOscpkttO1SUwgHOLMq6mbvEkICTYv9bjcRvYIkPrQ
        6V5SMQu8jEx5dY4Z1/bT+EQbwWe/L9q8akGYWFMOzwDqSFWJpMgC1Srmxdsoxhhy/Mld/N5u3Q4
        haixSlnpIyrLdwCpBFQBXaqZn
X-Received: by 2002:adf:f24c:0:b0:2f4:6574:5a93 with SMTP id b12-20020adff24c000000b002f465745a93mr12516603wrp.4.1682411703056;
        Tue, 25 Apr 2023 01:35:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350YzvhAFxQchdtafHwvmXBchE/YcmkSUeMa1HoC1zk1lBrrRDtHRpjgJc3aGfUSP7c/RWHiheA==
X-Received: by 2002:adf:f24c:0:b0:2f4:6574:5a93 with SMTP id b12-20020adff24c000000b002f465745a93mr12516582wrp.4.1682411702685;
        Tue, 25 Apr 2023 01:35:02 -0700 (PDT)
Received: from redhat.com ([2.55.61.39])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm12594526wrz.75.2023.04.25.01.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 01:35:02 -0700 (PDT)
Date:   Tue, 25 Apr 2023 04:34:58 -0400
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
Message-ID: <20230425041352-mutt-send-email-mst@kernel.org>
References: <20230417051816-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237705695AFD873DEE4530D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417073830-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417075645-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA90465186B5A8A5C001D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423031308-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47233B680283E892C45430BCD4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423065132-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237D46ADE7954289025B66D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB47237D46ADE7954289025B66D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 12:28:49PM +0000, Alvaro Karsz wrote:
> 
> > > > The rest of stuff can probably just be moved to after find_vqs without
> > > > much pain.
> > > >
> > > Actually, I think that with a little bit of pain :)
> > > If we use small vrings and a GRO feature bit is set, Linux will need to allocate 64KB of continuous memory for every receive descriptor..
> > 
> > Oh right. Hmm. Well this is same as big packets though, isn't it?
> > 
> 
> Well, when VIRTIO_NET_F_MRG_RXBUF is not negotiated and one of the GRO features is, the receive buffers are page size buffers chained together to form a 64K buffer.
> In this case, do all the chained descriptors actually point to a single block of continuous memory, or is it possible for the descriptors to point to pages spread all over?
> 
> > 
> > > Instead of failing probe if GRO/CVQ are set, can we just reset the device if we discover small vrings and start over?
> > > Can we remember that this device uses small vrings, and then just avoid negotiating the features that we cannot support?
> > 
> > 
> > We technically can of course. I am just not sure supporting CVQ with just 1 s/g entry will
> > ever be viable.
> 
> Even if we won't support 1 s/g entry, do we want to fail probe in such cases?
> We could just disable the CVQ feature (with reset, as suggested before).
> I'm not saying that we should, just raising the option.
> 

So, let's add some funky flags in virtio device to block out
features, have core compare these before and after,
detect change, reset and retry?


-- 
MST

