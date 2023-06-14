Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D985273047B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245401AbjFNQB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbjFNQBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:01:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916C42116
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:01:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23C9D64410
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CCAC433C0;
        Wed, 14 Jun 2023 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686758488;
        bh=c/w30hWZPq7B/xF67XMBljxlZ1LiFXkgssX8UYL4sVU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oSYDBXh/T+vZ89y12Y2Ui0TIGUC+XmnpqzCftxHWAsrc1igZbdGpK2Cmfkfsd3SOm
         04sXTBbwJwKI8TWMpjEp2+93uGQ+STTU7g9riaCKjA+lyQKcLwn8LcEsidVhBKG+0v
         hGGVf3q/HVZZE6w9EO3G3qij2XSNRJon6zNcm0NuycxURdV65WtJldVZms9AvW/RGg
         iRqh+23gxW5LdD8y80nUJe9hW8VG1kkU1UyPzPHgGXIsC4Er0jWD1LKqMMKai7jE9e
         5hzR8h11oofrPEwINz3t5QuAsuRHnY6w/dZ0fotIw2YT93OmaTC3NFrLqVMLhWGtZB
         ITfJdFhpBXyYg==
Date:   Wed, 14 Jun 2023 09:01:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sabrina Dubroca <sd@queasysnail.net>
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
Message-ID: <20230614090126.149049b1@kernel.org>
In-Reply-To: <ZImx5pp98OSNnv4I@hog>
References: <20230613192220.159407-1-pchelkin@ispras.ru>
        <20230613200150.361bc462@kernel.org>
        <ZImx5pp98OSNnv4I@hog>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 14:26:14 +0200 Sabrina Dubroca wrote:
> > What prevents the device from being opened and used before
> > macsec_add_dev() has finished? I think we need a fix which 
> > would move this code before register_netdev(), instead :(  
> 
> Can the device be opened in parallel? We're under rtnl here.
> 
> If we want to move that code, then we'll also have to move the
> eth_hw_addr_inherit call that's currently in macsec's ndo_init: in
> case the user didn't give an SCI, we have to make it up based on the
> device's mac address (dev_to_sci(dev, ...)), whether it's set by the
> user or inherited. I can't remember if I had a good reason to put the
> inherit in ndo_init.

Ah, you're right, this is a link creation path.
-- 
pw-bot: ur
