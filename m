Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4106772FE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244196AbjFNM1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjFNM11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:27:27 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Jun 2023 05:27:25 PDT
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF46A1FCC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:27:25 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-OhnLJhs7O2mcDYSWtjXsGg-1; Wed, 14 Jun 2023 08:26:20 -0400
X-MC-Unique: OhnLJhs7O2mcDYSWtjXsGg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1D008007CE;
        Wed, 14 Jun 2023 12:26:19 +0000 (UTC)
Received: from hog (unknown [10.45.224.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A1A4492CA6;
        Wed, 14 Jun 2023 12:26:16 +0000 (UTC)
Date:   Wed, 14 Jun 2023 14:26:14 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Lior Nahmanson <liorna@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] net: macsec: fix double free of percpu stats
Message-ID: <ZImx5pp98OSNnv4I@hog>
References: <20230613192220.159407-1-pchelkin@ispras.ru>
 <20230613200150.361bc462@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230613200150.361bc462@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-06-13, 20:01:50 -0700, Jakub Kicinski wrote:
> On Tue, 13 Jun 2023 22:22:20 +0300 Fedor Pchelkin wrote:
> > Inside macsec_add_dev() we free percpu macsec->secy.tx_sc.stats and
> > macsec->stats on some of the memory allocation failure paths. However, the
> > net_device is already registered to that moment: in macsec_newlink(), just
> > before calling macsec_add_dev(). This means that during unregister process
> > its priv_destructor - macsec_free_netdev() - will be called and will free
> > the stats again.
> > 
> > Remove freeing percpu stats inside macsec_add_dev() because
> > macsec_free_netdev() will correctly free the already allocated ones. The
> > pointers to unallocated stats stay NULL, and free_percpu() treats that
> > correctly.
> 
> What prevents the device from being opened and used before
> macsec_add_dev() has finished? I think we need a fix which 
> would move this code before register_netdev(), instead :(

Can the device be opened in parallel? We're under rtnl here.

If we want to move that code, then we'll also have to move the
eth_hw_addr_inherit call that's currently in macsec's ndo_init: in
case the user didn't give an SCI, we have to make it up based on the
device's mac address (dev_to_sci(dev, ...)), whether it's set by the
user or inherited. I can't remember if I had a good reason to put the
inherit in ndo_init.

-- 
Sabrina

