Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D376F31ED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjEAOWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjEAOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07525B3
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 07:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682950884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZbS5IjUaNlPU8hbwLWUCcqwd+h51QQNEXep9a6KbrKM=;
        b=QKX8jCTNNmFDl6sHpDaa5HgCeI40CxHSwXdbowsCa3KTR5MLMPwTobMouWC16/1SgeQ3rW
        tvt/4DX74UVlo0C+58q/ZYob0SzKnuu0dQWLT7Mb7DEHk7zC31hyN1Lwt8WgcSOWHh9xMw
        4oH/wY+v66zmlOQxlXOEebL555zvP6o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-Fnn6414wObmBLxJ8uJz1UA-1; Mon, 01 May 2023 10:14:22 -0400
X-MC-Unique: Fnn6414wObmBLxJ8uJz1UA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f17afcf99cso7394225e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 07:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682950444; x=1685542444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbS5IjUaNlPU8hbwLWUCcqwd+h51QQNEXep9a6KbrKM=;
        b=W+F/kOqcXIG7Q8ARSswyg4nVa+na0pI/Y2pRewKIwP86+RyLmD/lIs8wJs1vH5/g7W
         sYnWepLNUOTY8a1Cgopmnr9G3UhRQw3iH74mSZ7BMRtJo17OEKJJNYKXLJG9uc2dE/2r
         NNFnKbR06iJXbcxgiLUVaz+YFYCR+KrYJ4GAHRRBqCiJnktgYvB585Mk/QmhFLRI+uKm
         9KziBNfZvEiabtxBGydNdR82ye4oz2xzSymN3C12/ZXy95JoCKXXTAwQKae0qHVmKDlt
         sqXUqPpfS9Bn+Z3d5zZZaAE4IPAX+IvhzmbPZG7N/BIVc4ry3d759nW9vBX4Rab4Lw5b
         yVHQ==
X-Gm-Message-State: AC+VfDxvPPtOZLd/tqqTwlf5x9no7Xc7YMl9MdlZmh9oQhotsHLBRD0B
        8lu7FCH2ZngsrtzMxdco/YEjsr7xTE8FjQKAXwrs9lO+KY1aaAwyahbWmIqbPd7E7j0ZgNVpH7o
        ijWNMooI4XjXZqLberVr0tJM0
X-Received: by 2002:a1c:4b06:0:b0:3f0:3d47:2cc5 with SMTP id y6-20020a1c4b06000000b003f03d472cc5mr10326840wma.10.1682950443988;
        Mon, 01 May 2023 07:14:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uwbn+68k6dEwgamd9RB+Cf3SAOrfWXIAOfHT0cY5NAJ1rKClQM9jVpxSANY9aJ1gTlwwrQA==
X-Received: by 2002:a1c:4b06:0:b0:3f0:3d47:2cc5 with SMTP id y6-20020a1c4b06000000b003f03d472cc5mr10326826wma.10.1682950443676;
        Mon, 01 May 2023 07:14:03 -0700 (PDT)
Received: from redhat.com ([31.210.184.46])
        by smtp.gmail.com with ESMTPSA id f22-20020a1c6a16000000b003f17e79d74asm33036957wmc.7.2023.05.01.07.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 07:14:03 -0700 (PDT)
Date:   Mon, 1 May 2023 10:14:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Feng Liu <feliu@nvidia.com>
Cc:     Simon Horman <simon.horman@corigine.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        William Tu <witu@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net v1 2/2] virtio_net: Close queue pairs using helper
 function
Message-ID: <20230501101231-mutt-send-email-mst@kernel.org>
References: <20230428224346.68211-1-feliu@nvidia.com>
 <ZE+0RsBYDTgnauOX@corigine.com>
 <9dba94bb-3e40-6809-3f5a-cbb0ae19c5b7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dba94bb-3e40-6809-3f5a-cbb0ae19c5b7@nvidia.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 09:58:18AM -0400, Feng Liu wrote:
> 
> 
> On 2023-05-01 a.m.8:44, Simon Horman wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Fri, Apr 28, 2023 at 06:43:46PM -0400, Feng Liu wrote:
> > > Use newly introduced helper function that exactly does the same of
> > > closing the queue pairs.
> > > 
> > > Signed-off-by: Feng Liu <feliu@nvidia.com>
> > > Reviewed-by: William Tu <witu@nvidia.com>
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > 
> > I guess this was put in a separate patch to 1/2, as it's more
> > net-next material, as opposed to 1/2 which seems to be net material.
> > FWIIW, I'd lean to putting 1/2 in net. And holding this one for net-next.
> > 
> > That aside, this looks good to me.
> > 
> > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> 
> Will do, thanks Simon

Nah, I think you should just squash these two patches together.
It's early in the merge window.

-- 
MST

