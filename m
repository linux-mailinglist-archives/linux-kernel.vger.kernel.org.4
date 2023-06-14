Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADDB72F2E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjFNDCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbjFNDBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:01:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555B319A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:01:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E000D63D08
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1A7C433C0;
        Wed, 14 Jun 2023 03:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686711712;
        bh=J+s2slKhai8XoyOcd8BRcW7AAnL/2RowtfWNsgZlnt4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VJKJOxSM5D1wAB6WYS0ECG7YcHY4zcGi3xYMdXK87fVWyPnP1yKHuF7vWBX970rRG
         HvyItXpsHSRlde4DzBOZgkq/AQxNawM8PlEiTGXSXaAaX6Rwt73IhTQISgbQTaq+rC
         prmJR698iP3uo11HIPQrmLyh2pNxTZoMBwqefazReewy3O3hXL9ms2JfEhKYmMXRc6
         s57ctjAqRZYnvVtHMq2NYspE040cDeDN8EGDHw9QJVwzXoMnJikrPIff7AwApStkXN
         9DTZzPg0zvD6ZLAE32yeN4bWJCLvxVFJXnIsHDNE8/TlDTnOSz50lek7pAyym7RbPF
         jmDXVjMZ4bu8w==
Date:   Tue, 13 Jun 2023 20:01:50 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Lior Nahmanson <liorna@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] net: macsec: fix double free of percpu stats
Message-ID: <20230613200150.361bc462@kernel.org>
In-Reply-To: <20230613192220.159407-1-pchelkin@ispras.ru>
References: <20230613192220.159407-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 22:22:20 +0300 Fedor Pchelkin wrote:
> Inside macsec_add_dev() we free percpu macsec->secy.tx_sc.stats and
> macsec->stats on some of the memory allocation failure paths. However, the
> net_device is already registered to that moment: in macsec_newlink(), just
> before calling macsec_add_dev(). This means that during unregister process
> its priv_destructor - macsec_free_netdev() - will be called and will free
> the stats again.
> 
> Remove freeing percpu stats inside macsec_add_dev() because
> macsec_free_netdev() will correctly free the already allocated ones. The
> pointers to unallocated stats stay NULL, and free_percpu() treats that
> correctly.

What prevents the device from being opened and used before
macsec_add_dev() has finished? I think we need a fix which 
would move this code before register_netdev(), instead :(
-- 
pw-bot: cr
