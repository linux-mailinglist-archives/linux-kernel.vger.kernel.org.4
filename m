Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFB0729BC7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjFINlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbjFINlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:41:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC753588;
        Fri,  9 Jun 2023 06:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F254A60EF4;
        Fri,  9 Jun 2023 13:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D794AC433EF;
        Fri,  9 Jun 2023 13:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686318075;
        bh=yjbSjmu9BKcOVBkALZ9aVw5SbohM/yF5/0fVveOk2Uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wkKfaDpQt2SdpI3FmTZKILMbpvdN+jr3R5Qu/MXyusQxnrqylXhPSiT4Cl19gOdY1
         d8QbhJPK/QtuMLzZuxM/keOSJTFy3eFpxi0dfEYYRlT9SfurNHZoPHSfJzBfaokBEv
         5Dmzre1r/j+r1lO1wOmlD8fWHIfoMuRmIoJa6K1k=
Date:   Fri, 9 Jun 2023 15:41:12 +0200
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
Message-ID: <2023060940-wrongdoer-wince-5701@gregkh>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
 <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
 <2023060924-skinning-reset-e256@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023060924-skinning-reset-e256@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 03:39:24PM +0200, Greg KH wrote:
> On Fri, Jun 09, 2023 at 09:18:15PM +0800, Xianting Tian wrote:
> > From: Xianting Tian <tianxianting.txt@alibaba-inc.com>
> > 
> > Cpu stall issue may happen if device is configured with multi queues
> > and large queue depth, so fix it.
> > 
> > Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> > ---
> >  drivers/crypto/virtio/virtio_crypto_core.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> > index 1198bd306365..94849fa3bd74 100644
> > --- a/drivers/crypto/virtio/virtio_crypto_core.c
> > +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> > @@ -480,6 +480,7 @@ static void virtcrypto_free_unused_reqs(struct virtio_crypto *vcrypto)
> >  			kfree(vc_req->req_data);
> >  			kfree(vc_req->sgs);
> >  		}
> > +		cond_resched();
> 
> that's not "fixing a stall", it is "call the scheduler because we are
> taking too long".  The CPU isn't stalled at all, just busy.
> 
> Are you sure this isn't just a bug in the code?  Why is this code taking
> so long that you have to force the scheduler to run?  This is almost
> always a sign that something else needs to be fixed instead.

And same comment on the other 2 patches, please fix this properly.

Also, this is a tight loop that is just freeing memory, why is it taking
so long?  Why do you want it to take longer (which is what you are doing
here), ideally it would be faster, not slower, so you are now slowing
down the system overall with this patchset, right?

thanks,

greg k-h
