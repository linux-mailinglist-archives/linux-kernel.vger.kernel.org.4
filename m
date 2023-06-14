Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F35A7309A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 23:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbjFNVPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 17:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFNVPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 17:15:15 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5330F1FFA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 14:15:14 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-ocnmkyXQO2yJe2Z9632gjQ-1; Wed, 14 Jun 2023 17:15:09 -0400
X-MC-Unique: ocnmkyXQO2yJe2Z9632gjQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBB9D811E78;
        Wed, 14 Jun 2023 21:15:06 +0000 (UTC)
Received: from hog (unknown [10.45.224.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B482B2166B28;
        Wed, 14 Jun 2023 21:15:04 +0000 (UTC)
Date:   Wed, 14 Jun 2023 23:15:03 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <ZIot16xcgb7l8wer@hog>
References: <20230613192220.159407-1-pchelkin@ispras.ru>
 <20230613200150.361bc462@kernel.org>
 <ZImx5pp98OSNnv4I@hog>
 <20230614090126.149049b1@kernel.org>
 <20230614201714.lgwpk4wyojribbyj@fpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230614201714.lgwpk4wyojribbyj@fpc>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-06-14, 23:17:14 +0300, Fedor Pchelkin wrote:
> On Wed, Jun 14, 2023 at 09:01:26AM -0700, Jakub Kicinski wrote:
> > On Wed, 14 Jun 2023 14:26:14 +0200 Sabrina Dubroca wrote:
> > > > What prevents the device from being opened and used before
> > > > macsec_add_dev() has finished? I think we need a fix which 
> > > > would move this code before register_netdev(), instead :(  
> > > 
> > > Can the device be opened in parallel? We're under rtnl here.
> > > 
> > > If we want to move that code, then we'll also have to move the
> > > eth_hw_addr_inherit call that's currently in macsec's ndo_init: in
> > > case the user didn't give an SCI, we have to make it up based on the
> > > device's mac address (dev_to_sci(dev, ...)), whether it's set by the
> > > user or inherited. I can't remember if I had a good reason to put the
> > > inherit in ndo_init.
> > 
> > Ah, you're right, this is a link creation path.
> 
> My reply probably won't give any new information now but if the code of
> macsec_add_dev() and the parts from ndo_init it depends on which Sabrina
> mentioned would be moved before registering netdev then the problem will
> go away on its own.
> 
> Is it worth moving that code if rtnl_lock is held? Maybe it will be more
> persistent to initialize the device for as maximum as possible before
> calling register_netdevice()? Overall, it all depends on the reasons why
> the code was implemented so initially.

It's been 7 years... your guess is about as good as mine :/

I wouldn't bother reshuffling the device creation code just to make
the handling of rare failures a bit nicer.

-- 
Sabrina

