Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD75685D48
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjBACRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 21:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjBACRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:17:41 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815584FAD4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 18:17:39 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id k18so114774qvm.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 18:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x5iQyorjie9zjqZQLGloEICQ/MkHbdAomUF8loo1hT8=;
        b=oPQNNqIgBmGvvYvLhj6geOOy57VTPhssoqg2kOc9qD1WBiwjOIEZKCcEr5l5j+fmVA
         OpOkE0m8VpYZDvND+5viyp4g9gacSko0LExGBFj3VQHKHnF+wXgGePrJ2fK+4lqGD94n
         6mSqBDEICM9NzKVQ+5AIgCEFaNrFSeF5UnfQIrvDt8y0+MKL9MhUQvZHC5V1CRnFQdZ9
         XoGve+KaES9TA5IjMLoBjumRTpzCNNrkXdYzccc9ZUiXqwSrl8sSyu1Icp0BKqWLCv/A
         isnmjmsVusCoH5g/z1QgEX4cYZdYGz2IQ/mPliO3VhKHHwgWchZR8DHCGSj5uS4rXnjk
         vRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5iQyorjie9zjqZQLGloEICQ/MkHbdAomUF8loo1hT8=;
        b=yP/cLjv6kEX8MKw26YH0MI9PKDMnJx9RAB2I64hNiOBqfGxiIVhPKsgNBKoaIHuV3U
         4UDbvvnLTCms4/VsqLwoxN3OkoYOxzDArgJ6k4du2LqPTwe9Vtogn2OnLBzY14TWmJqA
         wEMDWkpxU6PSwzsG9k+2Ll91Afcjn3y2lDKyOq6HMEcyRLyZHU+YBi6RVHDJesox+axe
         uIUv9gvyxww07PlGQBm6xLWiyNqWGbzS7sxFZPzkeNBED15chvoVW1n5CHGgdF87rkik
         rwF4Lyd/GGkdhdeBxXQ85TI5Z2hJjDd7/xfVH1XpvMaK+UERf9aSbdpYenNMK1X4+sb6
         VJhA==
X-Gm-Message-State: AO0yUKX8foWtuOyomddVoesb8TD6VT5zoPNRJGKGcZetSIsiytBUqDFf
        1L4gydTmfQybQBUEzc/0IV0JzmvlAEQ1kHvU
X-Google-Smtp-Source: AK7set/ezsM8LcPeJhFF+cz4bDDCboiYyXvnIdAD57Rh3jmZndwBkWkSnl7NtdHNGJBaRQzoKYo/xA==
X-Received: by 2002:a05:6214:2d01:b0:537:7d20:d73 with SMTP id mz1-20020a0562142d0100b005377d200d73mr16820927qvb.4.1675217858575;
        Tue, 31 Jan 2023 18:17:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id d9-20020a05620a140900b0071c9eea2056sm6889712qkj.14.2023.01.31.18.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 18:17:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pN2gr-002G9E-6h;
        Tue, 31 Jan 2023 22:17:37 -0400
Date:   Tue, 31 Jan 2023 22:17:37 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Joerg Roedel <joro@8bytes.org>, Doug Ledford <dledford@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: linux-next: manual merge of the iommu tree with the rdma-fixes
 tree
Message-ID: <Y9nLwemhReecdLpr@ziepe.ca>
References: <20230201121402.15715aaa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201121402.15715aaa@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 12:14:02PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the iommu tree got a conflict in:
> 
>   drivers/infiniband/hw/usnic/usnic_uiom.c
> 
> between commit:
> 
>   b7e08a5a63a1 ("RDMA/usnic: use iommu_map_atomic() under spin_lock()")
> 
> from the rdma-fixes tree and commits:
> 
>   1369459b2e21 ("iommu: Add a gfp parameter to iommu_map()")
>   4dc6376af596 ("iommu: Remove iommu_map_atomic()")
> 
> from the iommu tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks good thank you

Jason 

