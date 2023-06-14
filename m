Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B225973090E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjFNURZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjFNURX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:17:23 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7911B1BCE;
        Wed, 14 Jun 2023 13:17:22 -0700 (PDT)
Received: from fpc (unknown [10.10.165.2])
        by mail.ispras.ru (Postfix) with ESMTPSA id C903D40755F4;
        Wed, 14 Jun 2023 20:17:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C903D40755F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1686773839;
        bh=U4qamVRGUE/7lnj5A2E6uk72VsqqwBoh4BujNKmSg44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfFc1tSsnUYTpkTrFOMKDL9XFDefo9nF9mmMA+YzekVgmNUhjkYgif4IrnYk64C+3
         MBVCCe4euQmKS3DmyP6wARjaKSqxymXR3DjcBf5WYXT6Tsu6eqWNnzUU1fu1M5W6aL
         i6pFA2nzj8u53T505tJNWhXh2tmpLgFPQvdl94Gw=
Date:   Wed, 14 Jun 2023 23:17:14 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Sabrina Dubroca <sd@queasysnail.net>,
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
Message-ID: <20230614201714.lgwpk4wyojribbyj@fpc>
References: <20230613192220.159407-1-pchelkin@ispras.ru>
 <20230613200150.361bc462@kernel.org>
 <ZImx5pp98OSNnv4I@hog>
 <20230614090126.149049b1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614090126.149049b1@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 09:01:26AM -0700, Jakub Kicinski wrote:
> On Wed, 14 Jun 2023 14:26:14 +0200 Sabrina Dubroca wrote:
> > > What prevents the device from being opened and used before
> > > macsec_add_dev() has finished? I think we need a fix which 
> > > would move this code before register_netdev(), instead :(  
> > 
> > Can the device be opened in parallel? We're under rtnl here.
> > 
> > If we want to move that code, then we'll also have to move the
> > eth_hw_addr_inherit call that's currently in macsec's ndo_init: in
> > case the user didn't give an SCI, we have to make it up based on the
> > device's mac address (dev_to_sci(dev, ...)), whether it's set by the
> > user or inherited. I can't remember if I had a good reason to put the
> > inherit in ndo_init.
> 
> Ah, you're right, this is a link creation path.

My reply probably won't give any new information now but if the code of
macsec_add_dev() and the parts from ndo_init it depends on which Sabrina
mentioned would be moved before registering netdev then the problem will
go away on its own.

Is it worth moving that code if rtnl_lock is held? Maybe it will be more
persistent to initialize the device for as maximum as possible before
calling register_netdevice()? Overall, it all depends on the reasons why
the code was implemented so initially.
