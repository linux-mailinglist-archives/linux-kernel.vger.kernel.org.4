Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48396F98AD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 15:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjEGNfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 09:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjEGNfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 09:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E919D12485
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 06:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683466453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=65lQRJ+gv4EXk4uO01YGhnAV/eJrvV/vUJvZ5bnqIuQ=;
        b=SUqrfA/HiJnTfk63a/hV5ut5bxskMtolnasGYJc2C3Ltswg2Ek+Sa9pokexJ3a+uWJBOMw
        5bzSkzblF8QuBfL7pgq/PokTaBBvvUvOSCJpPrbPjHqB8dRkua/U1WZQD0DWwxuz84GlUI
        Yyqdp6/LA5ltnaRsIogjzG4sQbQ1FYg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-TurOFaeCOrOH30MkhdP0Rg-1; Sun, 07 May 2023 09:34:11 -0400
X-MC-Unique: TurOFaeCOrOH30MkhdP0Rg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f170a1fbe7so22236255e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 06:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683466450; x=1686058450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65lQRJ+gv4EXk4uO01YGhnAV/eJrvV/vUJvZ5bnqIuQ=;
        b=Rdn+YwK0SlxHy4s5v9p4rOTRgcL9hehxZQICW2pCpkEVHs5txBTtkK6x+4q92+7zJc
         vuct+NI2YgzMy6QNZfp6IOgDYDYwV4TQjOtrspowEGp+5dWfGfWGg6LzRgs4kkqbshAh
         82GgsYCJfoAeVqBL5A86eIcm187zM3XPPPmns284ORdcBWLu2Y50guuIOmJ8+KsV9wdG
         W1S7e2o0QSvwncXu0UYHdHwBvrRK8jn7AC9fJFymDpWCaqOldwx6m5Md7QXOQzBYF/te
         L7o4Vb07/JZtoRLBG5erMVIkj+a0zH3ZUZ/KsLh0HdChA4mTi4PSYKwKf+a30ukDblAy
         EHjw==
X-Gm-Message-State: AC+VfDzJRfe7+Rko6JPqn3G9A8Pb3L/PzRvcnCNVYa+AxBgEcCNq4JlX
        fMz59O1724ge2dIG+09hyOUnT4IEcgGAFhWOyrLWv9HCuzH7TcdsW4dqRorSEE9bP/ECRMpKoCA
        s21mzXicG5mHxduNQM5c/gZQA
X-Received: by 2002:a05:600c:28b:b0:3f4:2438:31c7 with SMTP id 11-20020a05600c028b00b003f4243831c7mr595355wmk.19.1683466450676;
        Sun, 07 May 2023 06:34:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7dlYJQ5LxrwZA0O74DMJJmxxnf1OSnMdKKrqzXaZWy/VspuXbmfoua2VeVLQcpx7zhqb/0Fw==
X-Received: by 2002:a05:600c:28b:b0:3f4:2438:31c7 with SMTP id 11-20020a05600c028b00b003f4243831c7mr595347wmk.19.1683466450367;
        Sun, 07 May 2023 06:34:10 -0700 (PDT)
Received: from redhat.com ([2.52.158.28])
        by smtp.gmail.com with ESMTPSA id z17-20020a1c4c11000000b003ee20b4b2dasm13605868wmf.46.2023.05.07.06.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 06:34:09 -0700 (PDT)
Date:   Sun, 7 May 2023 09:34:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Wenliang Wang <wangwenliang.1995@bytedance.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, zhengqi.arch@bytedance.com,
        willemdebruijn.kernel@gmail.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
Message-ID: <20230507093328-mutt-send-email-mst@kernel.org>
References: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
 <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 11:28:25AM +0800, Jason Wang wrote:
> On Thu, May 4, 2023 at 10:27 AM Wenliang Wang
> <wangwenliang.1995@bytedance.com> wrote:
> >
> > For multi-queue and large ring-size use case, the following error
> > occurred when free_unused_bufs:
> > rcu: INFO: rcu_sched self-detected stall on CPU.
> >
> > Fixes: 986a4f4d452d ("virtio_net: multiqueue support")
> > Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>
> > ---
> > v2:
> > -add need_resched check.
> > -apply same logic to sq.
> > v3:
> > -use cond_resched instead.
> > v4:
> > -add fixes tag
> > ---
> >  drivers/net/virtio_net.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 8d8038538fc4..a12ae26db0e2 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3560,12 +3560,14 @@ static void free_unused_bufs(struct virtnet_info *vi)
> >                 struct virtqueue *vq = vi->sq[i].vq;
> >                 while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> >                         virtnet_sq_free_unused_buf(vq, buf);
> > +               cond_resched();
> 
> Does this really address the case when the virtqueue is very large?
> 
> Thanks


it does in that a very large queue is still just 64k in size.
we might however have 64k of these queues.

> >         }
> >
> >         for (i = 0; i < vi->max_queue_pairs; i++) {
> >                 struct virtqueue *vq = vi->rq[i].vq;
> >                 while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> >                         virtnet_rq_free_unused_buf(vq, buf);
> > +               cond_resched();
> >         }
> >  }
> >
> > --
> > 2.20.1
> >

