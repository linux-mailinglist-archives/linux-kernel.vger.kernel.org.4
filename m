Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D426FA01C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjEHGsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjEHGr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:47:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945F283C2
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 23:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683528435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPcE+tPXUEU9Pj6uvbRoX+sGl02xWP0SMsbFFZ3dcbg=;
        b=YFNOKMBsD5Bzpd6pPlLaYpcgz7E3wwQ/nuNw/phv4JQ7VHJUUIigynI2W/YWtCqe9fCNA2
        bB2tt0+ARGGvITydKiU3wYen1rYIj5mr1oBrHW0HFssHwlBdn0ZRszpBq/dbxGKoOTu19n
        KEmtIf+k0lz7aOL8KlFAis/hAadngB4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-Uc76LJMkNtKQtinTgyRLrg-1; Mon, 08 May 2023 02:47:14 -0400
X-MC-Unique: Uc76LJMkNtKQtinTgyRLrg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f16f50aeb5so15110945e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 23:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683528433; x=1686120433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iPcE+tPXUEU9Pj6uvbRoX+sGl02xWP0SMsbFFZ3dcbg=;
        b=g7QYnPesJ10/ZhQLh6yHIkxt0ltaeYOJ/hPwJWVQw8t1JatDwuzg+KBGOnt0LbWJwS
         h0bTA29oH0A+Eh6pw+3/OfkhCZFbQRfYjNkPa8QLuioO715vETgt9gTZVsqPoYUSEd1A
         mmqUqyDKrPTRd9sGMkvCVvQiI17QUzb6NDJKvYVUv57Sc0qVIWj4CqoNvhZg4bYWhVGB
         8mJrWIsYItcD9FeEiy2PUd+V57cxqanJXQIx2feTNjPoTvjxvqrPwt6a/F90mNoahwB6
         niBuCpn9rthx3qVslJ/N1HZGwEh9yg4mfKcku+Y7Qvh+szdE0uCpJp0A6/JyTjM6QoM5
         PXVA==
X-Gm-Message-State: AC+VfDzDOzCp2dcRGMuI8lOd9KpmbUgE/39OcNyQHkoT3Ix55ZenjHjQ
        CEeDCfi9M09koPGj04mPjVYQvF4lB/1itZTGsTfF9Rd24vphAfP/QxO7JnsbLK/p/3YHTg5pWut
        MnuIPvTR4zwba82RaSZEJOCKt
X-Received: by 2002:a1c:f704:0:b0:3f1:9526:22be with SMTP id v4-20020a1cf704000000b003f1952622bemr6095767wmh.23.1683528433437;
        Sun, 07 May 2023 23:47:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4vYeuFr5Bz2rslLpzPqeYDEDuyU1V6E3rGgoS88aNCbpJ9YMyQlWE3PZrEOwea2SRvN6MNbQ==
X-Received: by 2002:a1c:f704:0:b0:3f1:9526:22be with SMTP id v4-20020a1cf704000000b003f1952622bemr6095754wmh.23.1683528433143;
        Sun, 07 May 2023 23:47:13 -0700 (PDT)
Received: from redhat.com ([31.187.78.15])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c22c200b003f42328b5d9sm3729073wmg.39.2023.05.07.23.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 23:47:12 -0700 (PDT)
Date:   Mon, 8 May 2023 02:47:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Wenliang Wang <wangwenliang.1995@bytedance.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, zhengqi.arch@bytedance.com,
        willemdebruijn.kernel@gmail.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
Message-ID: <20230508024433-mutt-send-email-mst@kernel.org>
References: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
 <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
 <20230507093328-mutt-send-email-mst@kernel.org>
 <2b5cf90a-efa8-52a7-9277-77722622c128@redhat.com>
 <20230508020717-mutt-send-email-mst@kernel.org>
 <CACGkMEuQdy8xi=eD4v7-UNQ12xOUdnuyQ73vvC6vdGXUfeasug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuQdy8xi=eD4v7-UNQ12xOUdnuyQ73vvC6vdGXUfeasug@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 02:13:42PM +0800, Jason Wang wrote:
> On Mon, May 8, 2023 at 2:08 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, May 08, 2023 at 11:12:03AM +0800, Jason Wang wrote:
> > >
> > > 在 2023/5/7 21:34, Michael S. Tsirkin 写道:
> > > > On Fri, May 05, 2023 at 11:28:25AM +0800, Jason Wang wrote:
> > > > > On Thu, May 4, 2023 at 10:27 AM Wenliang Wang
> > > > > <wangwenliang.1995@bytedance.com> wrote:
> > > > > > For multi-queue and large ring-size use case, the following error
> > > > > > occurred when free_unused_bufs:
> > > > > > rcu: INFO: rcu_sched self-detected stall on CPU.
> > > > > >
> > > > > > Fixes: 986a4f4d452d ("virtio_net: multiqueue support")
> > > > > > Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>
> > > > > > ---
> > > > > > v2:
> > > > > > -add need_resched check.
> > > > > > -apply same logic to sq.
> > > > > > v3:
> > > > > > -use cond_resched instead.
> > > > > > v4:
> > > > > > -add fixes tag
> > > > > > ---
> > > > > >   drivers/net/virtio_net.c | 2 ++
> > > > > >   1 file changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 8d8038538fc4..a12ae26db0e2 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -3560,12 +3560,14 @@ static void free_unused_bufs(struct virtnet_info *vi)
> > > > > >                  struct virtqueue *vq = vi->sq[i].vq;
> > > > > >                  while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> > > > > >                          virtnet_sq_free_unused_buf(vq, buf);
> > > > > > +               cond_resched();
> > > > > Does this really address the case when the virtqueue is very large?
> > > > >
> > > > > Thanks
> > > >
> > > > it does in that a very large queue is still just 64k in size.
> > > > we might however have 64k of these queues.
> > >
> > >
> > > Ok, but we have other similar loops especially the refill, I think we may
> > > need cond_resched() there as well.
> > >
> > > Thanks
> > >
> >
> > Refill is already per vq isn't it?
> 
> Not for the refill_work().
> 
> Thanks

Good point, refill_work probably needs cond_resched, too.
And I guess virtnet_open?


> >
> >
> > > >
> > > > > >          }
> > > > > >
> > > > > >          for (i = 0; i < vi->max_queue_pairs; i++) {
> > > > > >                  struct virtqueue *vq = vi->rq[i].vq;
> > > > > >                  while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> > > > > >                          virtnet_rq_free_unused_buf(vq, buf);
> > > > > > +               cond_resched();
> > > > > >          }
> > > > > >   }
> > > > > >
> > > > > > --
> > > > > > 2.20.1
> > > > > >
> >

