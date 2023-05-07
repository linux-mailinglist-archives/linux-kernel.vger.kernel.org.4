Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A816F98B0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 15:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjEGNjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 09:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEGNjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 09:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B1415684
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683466700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uS0RstiP8T7ZH+Gobo8YpS9JLxcIWNZn7s+bIcTHKj0=;
        b=WSq2DSmoVjbQDTrdAFvn9J8kxStrSKiZo6eEOIUF57yypali3opguO/cIm+460bB5rNMlH
        pxkdMzHlwjA43nFHgON2UeaI57zBX7hdmLu4MDUtMnMgTC+jsFhSf+A0CbXNK54UFJjwV/
        ZQb/Dmx+pcM8epBQzyGLDbiu4sxyyH4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-SF9Gd3OJMVSG__gEFZg64Q-1; Sun, 07 May 2023 09:38:18 -0400
X-MC-Unique: SF9Gd3OJMVSG__gEFZg64Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30467a7020eso2029692f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 06:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683466697; x=1686058697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uS0RstiP8T7ZH+Gobo8YpS9JLxcIWNZn7s+bIcTHKj0=;
        b=SUOCV1IY7+Eph6Imr38v/3q7hOZ0OBUnCu1W8eoaUfDQCr/bbK0kM+GVWItz61bSas
         e/GSfAH6qtH1B+8ZA9yBuMXp+1hs8GHwRvsr999xhC4fYw01suJphKUIZxxga9GN3D5w
         ImRpD2vazbTsodE0aed5fduLmWfN/I8IsjKLEEtRfGUzZByWFSafsGeDCM2XXYFWKqcL
         y4z6CklYi7ivULJBcPoWwcjO7sA2A6eWTlpsq4Iy9Q6R8m9dHfCuNuV/4Uv0g/Qg42ct
         CTcOfQtp8Cmbx7XmB/15sTMKmtIBftPcIPe66/ZjwRQrqPWvMEcIa63KDmVWpKezOon5
         pw6A==
X-Gm-Message-State: AC+VfDyZ3Yi9LmwpWkaWpIgZ0j7dJZASiFB1xZEWopl25WOFzoVyDiym
        kjWyqsFseXM4nX/fUObI9+kZ+mDROX+xAm42HFKFmNaA3VxASjhX9zcXVe4n+H1VgI4Ifjr1VIp
        uytphr62yCi8wDPPSPv+YnWy9
X-Received: by 2002:adf:e3cd:0:b0:306:2bff:aad8 with SMTP id k13-20020adfe3cd000000b003062bffaad8mr5217168wrm.35.1683466697639;
        Sun, 07 May 2023 06:38:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7raV+1H23nZQQyJsfP3v5WDmwROkIJoLbvrcVTI1UBSNcA2EkWNlsLTJqPAmKBYRZa7JSNpg==
X-Received: by 2002:adf:e3cd:0:b0:306:2bff:aad8 with SMTP id k13-20020adfe3cd000000b003062bffaad8mr5217160wrm.35.1683466697361;
        Sun, 07 May 2023 06:38:17 -0700 (PDT)
Received: from redhat.com ([2.52.158.28])
        by smtp.gmail.com with ESMTPSA id l11-20020adfe58b000000b002f22c44e974sm8247506wrm.102.2023.05.07.06.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 06:38:16 -0700 (PDT)
Date:   Sun, 7 May 2023 09:38:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Hao Chen <chenh@yusur.tech>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, huangml@yusur.tech,
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
Message-ID: <20230507093502-mutt-send-email-mst@kernel.org>
References: <20230506021529.396812-1-chenh@yusur.tech>
 <1683341417.0965195-4-xuanzhuo@linux.alibaba.com>
 <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
 <49455AA8-0606-447E-B455-F905EA184E42@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49455AA8-0606-447E-B455-F905EA184E42@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2023 at 10:31:34AM +0100, David Woodhouse wrote:
> 
> 
> On 6 May 2023 09:56:35 BST, Hao Chen <chenh@yusur.tech> wrote:
> >In the current code, if the maximum MTU supported by the virtio net hardware is 9000, the default MTU of the virtio net driver will also be set to 9000. When sending packets through "ping -s 5000", if the peer router does not support negotiating a path MTU through ICMP packets, the packets will be discarded.
> 
> That router is just plain broken, and it's going to break all kinds of traffic. Hacking the virtio-net MTU is only a partial workaround.
> 
> Surely the correct fix here is to apply percussive education to whatever idiot thought it was OK to block ICMP. Not to hack the default MTU of one device to the lowest common denominator. 

Yea I don't understand what does path MTU have to do with it.
MTU has to be set the same for all endpoints on LAN, that's
a fundamental assumption that ethernet makes. Going outside LAN
all best are off.


-- 
MST

