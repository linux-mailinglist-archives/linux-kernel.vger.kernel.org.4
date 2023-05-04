Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA426F7227
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjEDSwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjEDSwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264A361B1
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683226322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yoeKifcrHut/aVoBaYmqNutB3vVh6nFGSk8RRjdeSWE=;
        b=VzNKQ3CTR+ygNFB931MTt1V0XvvYvCP9EsbHPo5/48RsNvvDyvMsVwi56B6c2MNUlgi71Q
        JiT0alN1sl70+mHBo/YQoK/wEjn2HttLWXXGmJhPgql0BPJtLwqBqxcnjL3DjQbfoH+i5Y
        yE6rnDPKpgn02vfLUCP2Wn56+y9qvK8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68--dEw0jZROxGGHtP_k7pnJQ-1; Thu, 04 May 2023 14:52:01 -0400
X-MC-Unique: -dEw0jZROxGGHtP_k7pnJQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2fbb99cb244so476255f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 11:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683226319; x=1685818319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoeKifcrHut/aVoBaYmqNutB3vVh6nFGSk8RRjdeSWE=;
        b=cJbqOuC4xhAuQMs18nF647JUeKcU2sIAd1M1LHkuNGYozdhgf+23jYIRnvZt+pn6pw
         G8c7s65Wnnx7VebOiKgBUH4V267JxStusuM43V+2AATH/uhCSZ0Q/tldkhwXarpi9qqP
         netXqRii18kNh6DrFZ4txO1ZIUcwwAxG9TqRk15OgEoStEK9BgMiq72yGdLjTcwJ0E5B
         RtKYI8YCVATL5WNrrYeYJDJjf0IRULlJeNej0fMaqRAvwPjFS+bFlmiX0YbqM/RC3VIC
         94YjAbkRg9GMF42U5uV0bwBuChAixv/GDt5xX6sLEbyCIyl+4zAOqTLASR3lX2EGoAho
         dmxg==
X-Gm-Message-State: AC+VfDwyR2fd1eonQNUrB79V6eewDK0KlrhnmMOqPY1zYZ2GVwep4NRx
        1KovulC6o+DSe7QOoiQLCclFaD2cSRXmhZqSFT3c/1Dx0aV/toHZXRQueQwDP5+YOB0iiRUdfv9
        y/p82h7J7kWdjPtrEJtLZN9JojdWhyOXg
X-Received: by 2002:adf:dcd2:0:b0:306:2aea:3dff with SMTP id x18-20020adfdcd2000000b003062aea3dffmr3617971wrm.31.1683226319572;
        Thu, 04 May 2023 11:51:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7cx+2cMwtc4BneZKjj77rQ0pMBPF0hJCSWkGLah28tDXXF/f2SErFruAwMUMwKlukaFfr+tA==
X-Received: by 2002:adf:dcd2:0:b0:306:2aea:3dff with SMTP id x18-20020adfdcd2000000b003062aea3dffmr3617960wrm.31.1683226319266;
        Thu, 04 May 2023 11:51:59 -0700 (PDT)
Received: from redhat.com ([2.52.10.43])
        by smtp.gmail.com with ESMTPSA id u6-20020adff886000000b002f7780eee10sm37569197wrp.59.2023.05.04.11.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 11:51:58 -0700 (PDT)
Date:   Thu, 4 May 2023 14:51:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Feng Liu <feliu@nvidia.com>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Gal Pressman <gal@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
Message-ID: <20230504145110-mutt-send-email-mst@kernel.org>
References: <20230504135053.2283816-1-dtatulea@nvidia.com>
 <26ee2c04-7844-14fe-5cba-fe30172f075f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ee2c04-7844-14fe-5cba-fe30172f075f@nvidia.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 01:08:54PM -0400, Feng Liu wrote:
> 
> 
> On 2023-05-04 a.m.9:50, Dragos Tatulea wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > The referenced patch calls set_vq_affinity without checking if the op is
> > valid. This patch adds the check.
> > 
> > Fixes: 3dad56823b53 ("virtio-vdpa: Support interrupt affinity spreading mechanism")
> > Reviewed-by: Gal Pressman <gal@nvidia.com>
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > ---
> >   drivers/virtio/virtio_vdpa.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > index eb6aee8c06b2..989e2d7184ce 100644
> > --- a/drivers/virtio/virtio_vdpa.c
> > +++ b/drivers/virtio/virtio_vdpa.c
> > @@ -385,7 +385,9 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> >                          err = PTR_ERR(vqs[i]);
> >                          goto err_setup_vq;
> >                  }
> > -               ops->set_vq_affinity(vdpa, i, &masks[i]);
> > +
> > +               if (ops->set_vq_affinity)
> > +                       ops->set_vq_affinity(vdpa, i, &masks[i]);
> if ops->set_vq_affinity is NULL, should give an error code to err, and
> return err

Given we ignore return code, hardly seems like a critical thing to do.
Is it really important? affinity is an optimization isn't it?

> >          }
> > 
> >          cb.callback = virtio_vdpa_config_cb;
> > --
> > 2.40.1
> > 

