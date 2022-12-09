Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9419C64892E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLITsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiLITsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:48:09 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6662A726
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:48:07 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so9193392pje.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 11:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zQu0xHmezona1yp0QM9dAtI9Szifegp4YTL0XeOL4ws=;
        b=KxLrq1EpZy4M7WanlGgi3c9+zbE39YbH65vP0ep3ysHNOq02GB9CcLAGEZ2tpRTTo/
         H9lXrY7cVOxAaEkbWbF8MpUBsNPGSog+dS/6vPOrNxeRiOG0vssepsytbE9TjqJZxzH8
         has8/M+s2kNGv4kOUGYZ7b2SCcvuyfeU6ZTx8ywVnJaZ88Wm7LOL2N4Kt2FiCZTS+BTX
         Et30yE0LQBeuGBsIc2eh3QWi94H4e0nmYbIN9emHgQYDUv7ofLWLwed7T+371PiZ3a6m
         mUXzZT/h7khr0U2/GDXvO2+9zt9SY1WpDy8lkfm3EBTS3jy0xnFYftcWCwSsahPzeSJK
         46hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQu0xHmezona1yp0QM9dAtI9Szifegp4YTL0XeOL4ws=;
        b=hUZkfxcuhzERMn66YgJUlrWds2aeLezEv87JhmJ9Lyxj1Rf8gZ+z9+D0lvlO1+S94C
         HTsoW6zCwewB94IvQ3rLfyEpoof0Wujt5f2qOdGCsoJxciSlL8HowxU5iqZw0a6CFqUS
         BqW31PqtIgjuLmAeSOD7g6g3W17n+fdwOLJLiIAOU/f+V6hDi5J3KzQNrC7EvAfSPJOq
         TOo6IBXAAUpbg9d3Zuj9if3mzvxOX4gnl3N2YDZn5AP02OD0WlkSCkebh3GAMwgBbPZu
         JZtgh1E2/ns9k536kKldwuO12oqYMFfK7IJm1/aXb7sGx4E5yyvqMhQ/70ybtaSPRYA5
         QfiQ==
X-Gm-Message-State: ANoB5pmxqSvFb/jElIfgNkt4Q8x86tUTq8kbeUVWv2N7ZEw1w+ZF4NB3
        BJ2c0m85yBYT0Ib4HuWb7M9fXw==
X-Google-Smtp-Source: AA0mqf4flq+i9Vp0qY22m1GEIanI9xM7ZT69Q14Lx9EyzntEQOicmXDaqINBBGm6QxR9fg3WhVu9Cw==
X-Received: by 2002:a17:902:6ac4:b0:185:441e:90c9 with SMTP id i4-20020a1709026ac400b00185441e90c9mr6523389plt.47.1670615287052;
        Fri, 09 Dec 2022 11:48:07 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e5c200b0017ec1b1bf9fsm1677587plf.217.2022.12.09.11.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:48:06 -0800 (PST)
Date:   Fri, 9 Dec 2022 19:48:02 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Ram Muthiah <rammuthiah@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, jiang.wang@bytedance.com
Subject: Re: [PATCH 1/1] virtio/vsock: Make vsock virtio packet buff size
 configurable
Message-ID: <Y5OQ8jQsK2Dz8tPy@google.com>
References: <20210721143001.182009-1-lee.jones@linaro.org>
 <20210722125519.jzs7crke7yqfh73e@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722125519.jzs7crke7yqfh73e@steredhat>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 02:55:19PM +0200, Stefano Garzarella wrote:
> > 
> > +uint virtio_transport_max_vsock_pkt_buf_size = 1024 * 64;
> > +module_param(virtio_transport_max_vsock_pkt_buf_size, uint, 0444);
> > +EXPORT_SYMBOL_GPL(virtio_transport_max_vsock_pkt_buf_size);
> > +

I'm interested on this functionality, so I could take this on.

> 
> Maybe better to add an entry under sysfs similar to what Jiang proposed
> here:
> https://lists.linuxfoundation.org/pipermail/virtualization/2021-June/054769.html

Having a look at Jiang's RFC patch it seems the proposed sysfs node
hangs off from the main kernel object e.g. /sys/kernel. So I wonder if
there is a more appropriate parent for this knob?

Also, I noticed that Ram's patch here is using read-only permissions for
the module parameter and switching to sysfs would mean opening this knob
up to be dynamically configured? I'd need to be careful here.

--
Carlos Llamas
