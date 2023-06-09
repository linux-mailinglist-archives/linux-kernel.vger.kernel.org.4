Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D5C729BBA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239957AbjFINja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbjFINj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:39:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1E530F1;
        Fri,  9 Jun 2023 06:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E527A60A09;
        Fri,  9 Jun 2023 13:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55D1C433EF;
        Fri,  9 Jun 2023 13:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686317967;
        bh=ysACDiqv15WSMXirEWH3zL+zB9JT9lU1CCHgbJhy5TE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q491ic/RaHa+u/BYxn7wQszigsvRP+P1XgWnsp1LVSiiDa4mvI4Xji+qtIq8FstIU
         MEewjMnx+h3oKO3CAt3N47Aq/KcAy8AQpwf27CUDtfHPHOEY9Nh1mhgAWek+ZhyXZl
         Jin0GrVesqAewd3dZuIllGKzlIguXJQeyiIn8ZJ4=
Date:   Fri, 9 Jun 2023 15:39:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     arei.gonglei@huawei.com, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, amit@kernel.org, arnd@arndb.de,
        marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xianting Tian <tianxianting.txt@alibaba-inc.com>
Subject: Re: [PATCH 1/3] virtio-crypto: fixup potential cpu stall when free
 unused bufs
Message-ID: <2023060924-skinning-reset-e256@gregkh>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
 <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 09:18:15PM +0800, Xianting Tian wrote:
> From: Xianting Tian <tianxianting.txt@alibaba-inc.com>
> 
> Cpu stall issue may happen if device is configured with multi queues
> and large queue depth, so fix it.
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  drivers/crypto/virtio/virtio_crypto_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> index 1198bd306365..94849fa3bd74 100644
> --- a/drivers/crypto/virtio/virtio_crypto_core.c
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -480,6 +480,7 @@ static void virtcrypto_free_unused_reqs(struct virtio_crypto *vcrypto)
>  			kfree(vc_req->req_data);
>  			kfree(vc_req->sgs);
>  		}
> +		cond_resched();

that's not "fixing a stall", it is "call the scheduler because we are
taking too long".  The CPU isn't stalled at all, just busy.

Are you sure this isn't just a bug in the code?  Why is this code taking
so long that you have to force the scheduler to run?  This is almost
always a sign that something else needs to be fixed instead.

thanks,

greg k-h
