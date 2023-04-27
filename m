Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8C6F0260
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242972AbjD0INs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242855AbjD0INo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:13:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4E930D5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 01:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682583173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aB49IfnVQxAVPmxftGfpUlkFmuC67pXs44wakcN9xOc=;
        b=cobwwMHzsfnMq0G7pz5J/WPJmHjeWKP7+rIw9NnRMolphunjyQnLAXT6ryG6NvroSOpGJ8
        9S2/QLpZyeCArvR3wLd+QRv+JHH/DKT/PS7rQZjpEk4VrqNUiIds+tFOfcOr5cHa/kGHC/
        UTm7TJLG1w0ooxDTHqRqEmlAB9coghU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-Oa-_h_8BNuSqFun6KKEKqw-1; Thu, 27 Apr 2023 04:12:49 -0400
X-MC-Unique: Oa-_h_8BNuSqFun6KKEKqw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-2f92bd71f32so2682428f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 01:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682583168; x=1685175168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB49IfnVQxAVPmxftGfpUlkFmuC67pXs44wakcN9xOc=;
        b=h6VSbA7KSxHrcMjcDUWsH3ySI5fTenuC2u8yHYdkIGny+eMXHYhymUllomjPC7xK1W
         Vo3Fa10P4MZQy8BmrKAJ0K6UMHrOijbu4QwJbZ1XZ+9xh0q9t2s3S3eNFvbOR69DlfJE
         dIwNomLdU7Avc5WwmCp5t0IpDex6ZnpGy4QCv15vJsBTSa9dEpG0wXpX70b+rI2MPFCl
         //xjON/FfDYFz+7XEHVaZTJb9UHMEaksFoKG63nivPsTiCu3u1ZZpsSwEabgcetxm5Cr
         GPYrWlx+orI6U6187glcP3IP5ElVIDXei3p32fxJEEAtJr7Bs3KJ6SFhw86wNDi3RHBV
         L49A==
X-Gm-Message-State: AC+VfDwRoalYTBg381rW45lbpnRHsMfPCDzK+naYZYKkKs68TYlBuPQE
        /HHiCd4YiYKf+biofWAxi5Ro3juAwxITyuZjsOgvb+yT0tko8l7b2C5rjlh/ezogAXU+NP0zMSp
        dS9kUKWN6OPzA0v2VCuo/0HgZ
X-Received: by 2002:adf:f64c:0:b0:2f9:a75:b854 with SMTP id x12-20020adff64c000000b002f90a75b854mr536192wrp.59.1682583168408;
        Thu, 27 Apr 2023 01:12:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5emRcma09Oxn5dJrEsZwosfPxvNpGMisqE8jgCL0zI/xRIB9M5uqzHDqbC55yckTxtp6HXjQ==
X-Received: by 2002:adf:f64c:0:b0:2f9:a75:b854 with SMTP id x12-20020adff64c000000b002f90a75b854mr536175wrp.59.1682583168106;
        Thu, 27 Apr 2023 01:12:48 -0700 (PDT)
Received: from redhat.com ([2.52.19.183])
        by smtp.gmail.com with ESMTPSA id m2-20020a056000008200b002f53fa16239sm17804457wrx.103.2023.04.27.01.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 01:12:47 -0700 (PDT)
Date:   Thu, 27 Apr 2023 04:12:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Wenliang Wang <wangwenliang.1995@bytedance.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jasowang@redhat.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH] virtio_net: suppress cpu stall when free_unused_bufs
Message-ID: <20230427041206-mutt-send-email-mst@kernel.org>
References: <20230427043433.2594960-1-wangwenliang.1995@bytedance.com>
 <1682576442.2203932-1-xuanzhuo@linux.alibaba.com>
 <252ee222-f918-426e-68ef-b3710a60662e@bytedance.com>
 <1682579624.5395834-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682579624.5395834-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 03:13:44PM +0800, Xuan Zhuo wrote:
> On Thu, 27 Apr 2023 15:02:26 +0800, Wenliang Wang <wangwenliang.1995@bytedance.com> wrote:
> >
> >
> > On 4/27/23 2:20 PM, Xuan Zhuo wrote:
> > > On Thu, 27 Apr 2023 12:34:33 +0800, Wenliang Wang <wangwenliang.1995@bytedance.com> wrote:
> > >> For multi-queue and large rx-ring-size use case, the following error
> > >
> > > Cound you give we one number for example?
> >
> > 128 queues and 16K queue_size is typical.
> >
> > >
> > >> occurred when free_unused_bufs:
> > >> rcu: INFO: rcu_sched self-detected stall on CPU.
> > >>
> > >> Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>
> > >> ---
> > >>   drivers/net/virtio_net.c | 1 +
> > >>   1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > >> index ea1bd4bb326d..21d8382fd2c7 100644
> > >> --- a/drivers/net/virtio_net.c
> > >> +++ b/drivers/net/virtio_net.c
> > >> @@ -3565,6 +3565,7 @@ static void free_unused_bufs(struct virtnet_info *vi)
> > >>   		struct virtqueue *vq = vi->rq[i].vq;
> > >>   		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> > >>   			virtnet_rq_free_unused_buf(vq, buf);
> > >> +		schedule();
> > >
> > > Just for rq?
> > >
> > > Do we need to do the same thing for sq?
> > Rq buffers are pre-allocated, take seconds to free rq unused buffers.
> >
> > Sq unused buffers are much less, so do the same for sq is optional.
> 
> I got.
> 
> I think we should look for a way, compatible with the less queues or the smaller
> rings. Calling schedule() directly may be not a good way.
> 
> Thanks.

Why isn't it a good way?

> 
> >
> > >
> > > Thanks.
> > >
> > >
> > >>   	}
> > >>   }
> > >>
> > >> --
> > >> 2.20.1
> > >>

