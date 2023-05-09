Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3332E6FC82C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbjEINn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjEINnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D5030F3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 06:43:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAC8A62FEB
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 13:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318EDC433EF;
        Tue,  9 May 2023 13:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683639796;
        bh=wAyj0pfH0D6dPu3vwviP23w1K4Snew4vfueLBpD7evU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JmNfpXc/WQwNWK/wVWSUGvBKFC26Vy9UCPyWwLVeIKyJ6pHVhP1myzdS6dQuy/wV0
         lY7mLWdJIT0PFT1v5jnKEHxM5VhtFyGsErpEbIUDmPPg5bD8p6FKaLg3KVUR/Tohcf
         QjEuEWZZ+kHpYki6pmTX7lQv4RJGE7T0SFSc/Q3OiLsZ9yKax99/f1qQEhfDggxgMU
         DJE9PlEeEXdyhZywtR/t2KFyjo7ApljYcHkPNtZPQ89DOq8VxOwIaaKyAaCRYB9QIv
         XWGELz913XJ5yDJV9hRQ+pZdlSnbImHVsWNaPAi+YGA1qVLcncIPTBK+Ld4QjyeGWL
         TfM9B+el0ruEA==
Date:   Tue, 9 May 2023 16:43:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/2] net: introduce and use
 skb_frag_fill_page_desc()
Message-ID: <20230509134311.GN38143@unreal>
References: <20230509114337.21005-1-linyunsheng@huawei.com>
 <20230509114337.21005-2-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509114337.21005-2-linyunsheng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 07:43:36PM +0800, Yunsheng Lin wrote:
> Most users use __skb_frag_set_page()/skb_frag_off_set()/
> skb_frag_size_set() to fill the page desc for a skb frag.
> 
> Introduce skb_frag_fill_page_desc() to do that.
> 
> net/bpf/test_run.c does not call skb_frag_off_set() to
> set the offset, "copy_from_user(page_address(page), ...)"
> suggest that it is assuming offset to be initialized as
> zero, so call skb_frag_fill_page_desc() with offset being
> zero for this case.
> 
> Also, skb_frag_set_page() is not used anymore, so remove
> it.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  .../net/ethernet/aquantia/atlantic/aq_ring.c  |  6 ++--
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++-
>  drivers/net/ethernet/chelsio/cxgb3/sge.c      |  5 ++-
>  drivers/net/ethernet/emulex/benet/be_main.c   | 32 ++++++++++---------
>  drivers/net/ethernet/freescale/enetc/enetc.c  |  5 ++-
>  .../net/ethernet/fungible/funeth/funeth_rx.c  |  5 ++-
>  drivers/net/ethernet/marvell/mvneta.c         |  5 ++-
>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +--
>  drivers/net/ethernet/sun/cassini.c            |  8 ++---
>  drivers/net/virtio_net.c                      |  4 +--
>  drivers/net/vmxnet3/vmxnet3_drv.c             |  4 +--
>  drivers/net/xen-netback/netback.c             |  4 +--
>  include/linux/skbuff.h                        | 27 ++++++----------
>  net/bpf/test_run.c                            |  3 +-
>  net/core/gro.c                                |  4 +--
>  net/core/pktgen.c                             | 13 +++++---
>  net/core/skbuff.c                             |  7 ++--
>  net/tls/tls_device.c                          | 10 +++---
>  net/xfrm/xfrm_ipcomp.c                        |  5 +--
>  19 files changed, 64 insertions(+), 92 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
