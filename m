Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CEC72E334
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242444AbjFMMjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242441AbjFMMjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:39:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BA510EC;
        Tue, 13 Jun 2023 05:39:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F6E3635B7;
        Tue, 13 Jun 2023 12:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D89C4339C;
        Tue, 13 Jun 2023 12:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686659977;
        bh=azRXIxzoQcvDlB1Hx4tfpo3s2cNDdzMmtu0iY95TNVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AXcI+lrW2qI7Oe7JHhYf3CE3rpEaeB8STV+KzqQKZOMnmVrpj/ynOjx2KTyuk3YSX
         TXf70bUlQwboATWGf5P4BGrBLg9QnKCCyjR91VYCleMvIKSDptA9J1j5e8nQaZjBrY
         zbmPrmY81v82AWExy+XvquF1f1Sm8clZC5vr3qcZaYZ80f6KaByUMKti4XuzO+j+vD
         E3QF9n2B5a2tC6m/5LYw1qVKLWW2daU4EK/zOCxAOQ+4XPiQvZc5YIN59Fhz1d2Njn
         nbQrRc3uF2CVTdt7qqtl9cGvWHWmVAMvkqvOXNjDiQ7+ukixc1+YqFt3JL7+omHZb1
         WVrrGjlKjruPA==
Date:   Tue, 13 Jun 2023 15:39:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Networking <netdev@vger.kernel.org>,
        Daniel Jurgens <danielj@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Bloch <mbloch@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: linux-next: manual merge of the net-next tree with the
 rdma-fixes tree
Message-ID: <20230613123932.GA12152@unreal>
References: <20230613114359.59cadc05@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613114359.59cadc05@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 11:43:59AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>   include/linux/mlx5/driver.h
> 
> between commit:
> 
>   617f5db1a626 ("RDMA/mlx5: Fix affinity assignment")
> 
> from the rdma-fixes tree and commit:
> 
>   dc13180824b7 ("net/mlx5: Enable devlink port for embedded cpu VF vports")
> 
> from the net-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc include/linux/mlx5/driver.h
> index e0156b54d0b3,18a608a1f567..000000000000
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@@ -1228,18 -1246,11 +1236,23 @@@ static inline u16 mlx5_core_max_vfs(con
>   	return dev->priv.sriov.max_vfs;
>   }
>   
>  +static inline int mlx5_lag_is_lacp_owner(struct mlx5_core_dev *dev)
>  +{
>  +	/* LACP owner conditions:
>  +	 * 1) Function is physical.
>  +	 * 2) LAG is supported by FW.
>  +	 * 3) LAG is managed by driver (currently the only option).
>  +	 */
>  +	return  MLX5_CAP_GEN(dev, vport_group_manager) &&
>  +		   (MLX5_CAP_GEN(dev, num_lag_ports) > 1) &&
>  +		    MLX5_CAP_GEN(dev, lag_master);
>  +}
>  +
> + static inline u16 mlx5_core_max_ec_vfs(const struct mlx5_core_dev *dev)
> + {
> + 	return dev->priv.sriov.max_ec_vfs;
> + }
> + 

Thanks for the resolution. Looks good.

>   static inline int mlx5_get_gid_table_len(u16 param)
>   {
>   	if (param > 4) {


