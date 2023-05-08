Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9219A6F9F69
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjEHGIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjEHGIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E6513875
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 23:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683526084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=496riEt70CLjVEPXxKBFIzM6DccwKHKgAN0XgS7K+xk=;
        b=WU3MR5nPwyORCS4PDfIDUkkSu3M9zLSEngYD76mv+AO7vSBezbqusIT1qIq9bMi+o9Kni5
        eJ3KJa3nYJ5lajV9cBqiMcdG3l1G1jJ1ruJgT8Z+O5JdUVuqBJwkdEMM3rLmJSk4goWcHm
        Es7bUys3H2Xczgetv6iWj1C9fC2+xAs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-bzsvHkrjNFa2-JndIPgE7g-1; Mon, 08 May 2023 02:08:03 -0400
X-MC-Unique: bzsvHkrjNFa2-JndIPgE7g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30641258c9eso1359709f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 23:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683526082; x=1686118082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=496riEt70CLjVEPXxKBFIzM6DccwKHKgAN0XgS7K+xk=;
        b=SkgpRetj6l/hsB9vOOf6gWmK0UeXmxxSBGEd7jjxXlOqORLzaRSt9U70wtpg/s/hP0
         6hgyyb6HXNVmnClkiGLHb8vNrmpCAWXrLomwhQwqXFCLX77gF/TOdPgBJVZKSX5lJW7h
         7S7h5xc+mVWzVkSpon/0A2+QULXaHQ2QPulGYfMz1PO1cOJyhC7ifIb/pF4TsorzYenD
         w5OyRsAsmP9GwtNzlpe2mBvLc34KUbvSsZElMHhPyVpCmNx1orrM75s5U4AuYup4Lp5L
         emdfCXPpQbz6ozzLcwtSvWDro1Yk+gaSRflgl05wZ6GcLR0bZecjUcZ7hDITB26QnNLo
         mq6A==
X-Gm-Message-State: AC+VfDw/4N0CDrF6U+MxjkD1Fubtsotz8wEvPE+WGXkAfF0lgKkA3ZFO
        p63NfVxXI5a5KicMwSgeiWWnl+TI8y5dEkETlPOo2WvLjskz3uD57Ghe599xqZULz6NbU601G/j
        biM3E/YXgCSstOf2cBGrajBnH
X-Received: by 2002:a5d:6801:0:b0:306:2b64:fd1b with SMTP id w1-20020a5d6801000000b003062b64fd1bmr6387823wru.52.1683526082131;
        Sun, 07 May 2023 23:08:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7f8poeeWKuFbkFRFraXJPQPQU8mq+PdFxmJfqKohdU/FLK+Ng7mCXc+1OoWwdFP0rxufKFDA==
X-Received: by 2002:a5d:6801:0:b0:306:2b64:fd1b with SMTP id w1-20020a5d6801000000b003062b64fd1bmr6387812wru.52.1683526081830;
        Sun, 07 May 2023 23:08:01 -0700 (PDT)
Received: from redhat.com ([2.52.158.28])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d428f000000b003062d815fa6sm10182362wrq.85.2023.05.07.23.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 23:08:01 -0700 (PDT)
Date:   Mon, 8 May 2023 02:07:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Wenliang Wang <wangwenliang.1995@bytedance.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, zhengqi.arch@bytedance.com,
        willemdebruijn.kernel@gmail.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
Message-ID: <20230508020717-mutt-send-email-mst@kernel.org>
References: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
 <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
 <20230507093328-mutt-send-email-mst@kernel.org>
 <2b5cf90a-efa8-52a7-9277-77722622c128@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b5cf90a-efa8-52a7-9277-77722622c128@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 11:12:03AM +0800, Jason Wang wrote:
> 
> 在 2023/5/7 21:34, Michael S. Tsirkin 写道:
> > On Fri, May 05, 2023 at 11:28:25AM +0800, Jason Wang wrote:
> > > On Thu, May 4, 2023 at 10:27 AM Wenliang Wang
> > > <wangwenliang.1995@bytedance.com> wrote:
> > > > For multi-queue and large ring-size use case, the following error
> > > > occurred when free_unused_bufs:
> > > > rcu: INFO: rcu_sched self-detected stall on CPU.
> > > > 
> > > > Fixes: 986a4f4d452d ("virtio_net: multiqueue support")
> > > > Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>
> > > > ---
> > > > v2:
> > > > -add need_resched check.
> > > > -apply same logic to sq.
> > > > v3:
> > > > -use cond_resched instead.
> > > > v4:
> > > > -add fixes tag
> > > > ---
> > > >   drivers/net/virtio_net.c | 2 ++
> > > >   1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 8d8038538fc4..a12ae26db0e2 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -3560,12 +3560,14 @@ static void free_unused_bufs(struct virtnet_info *vi)
> > > >                  struct virtqueue *vq = vi->sq[i].vq;
> > > >                  while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> > > >                          virtnet_sq_free_unused_buf(vq, buf);
> > > > +               cond_resched();
> > > Does this really address the case when the virtqueue is very large?
> > > 
> > > Thanks
> > 
> > it does in that a very large queue is still just 64k in size.
> > we might however have 64k of these queues.
> 
> 
> Ok, but we have other similar loops especially the refill, I think we may
> need cond_resched() there as well.
> 
> Thanks
> 

Refill is already per vq isn't it?


> > 
> > > >          }
> > > > 
> > > >          for (i = 0; i < vi->max_queue_pairs; i++) {
> > > >                  struct virtqueue *vq = vi->rq[i].vq;
> > > >                  while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> > > >                          virtnet_rq_free_unused_buf(vq, buf);
> > > > +               cond_resched();
> > > >          }
> > > >   }
> > > > 
> > > > --
> > > > 2.20.1
> > > > 

