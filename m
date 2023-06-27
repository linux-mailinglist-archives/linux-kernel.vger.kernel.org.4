Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7208740249
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjF0Rfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjF0Rfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:35:51 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510E4269E;
        Tue, 27 Jun 2023 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iIHKX23DruyWxNvBPEkGuI6LxtvA8lzHrP07ul+XeWg=;
  b=Ixk+uerCSeTIr9ry6BMbctwfqD/cZnATnAx+lIta14URQK6WCY5xHjGm
   o3KZXqW1gNajuttsDVa436Hys12QuNPP2txSbbx2HNdh9pIRN48Mulca3
   yAySyKmwGTMzvh54rhJs1cScpvyPiplespvWI9GEO7/NX4JgVXoWk5zMN
   0=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,163,1684792800"; 
   d="scan'208";a="59972658"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 19:35:47 +0200
Date:   Tue, 27 Jun 2023 19:35:47 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Julia Lawall <Julia.Lawall@inria.fr>
cc:     Sakari Ailus <sakari.ailus@linux.intel.com>, keescook@chromium.org,
        kernel-janitors@vger.kernel.org, Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/26] media: staging: imgu: use array_size
In-Reply-To: <20230623211457.102544-24-Julia.Lawall@inria.fr>
Message-ID: <alpine.DEB.2.22.394.2306271933480.3150@hadrien>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr> <20230623211457.102544-24-Julia.Lawall@inria.fr>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Jun 2023, Julia Lawall wrote:

> Use array_size to protect against multiplication overflows.
>
> The changes were done using the following Coccinelle semantic patch:
>
> // <smpl>
> @@
>     expression E1, E2;
>     constant C1, C2;
>     identifier alloc = {vmalloc,vzalloc};
> @@
>
> (
>       alloc(C1 * C2,...)
> |
>       alloc(
> -           (E1) * (E2)
> +           array_size(E1, E2)
>       ,...)
> )
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  drivers/staging/media/ipu3/ipu3-mmu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/media/ipu3/ipu3-mmu.c b/drivers/staging/media/ipu3/ipu3-mmu.c
> index cb9bf5fb29a5..9c4adb815c94 100644
> --- a/drivers/staging/media/ipu3/ipu3-mmu.c
> +++ b/drivers/staging/media/ipu3/ipu3-mmu.c
> @@ -464,7 +464,7 @@ struct imgu_mmu_info *imgu_mmu_init(struct device *parent, void __iomem *base)
>  	 * Allocate the array of L2PT CPU pointers, initialized to zero,
>  	 * which means the dummy L2PT allocated above.
>  	 */
> -	mmu->l2pts = vzalloc(IPU3_PT_PTES * sizeof(*mmu->l2pts));
> +	mmu->l2pts = vzalloc(array_size(IPU3_PT_PTES, sizeof(*mmu->l2pts)));
>  	if (!mmu->l2pts)
>  		goto fail_l2pt;

I think that this patch can be dropped.  Since it is a multiplcation of
two constants, if there is an overflow, I guess the compiler would detect
it?

julia
