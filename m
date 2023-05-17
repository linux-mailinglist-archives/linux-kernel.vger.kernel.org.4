Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF3D706573
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjEQKkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjEQKki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:40:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F5797
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684319990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K9RFNHgsvYsYoyjUlDzPxezQioa4wPBhCeawLWQ4WWw=;
        b=fzYR80SS7Y0SDAq4KWqlvwTqgwki8eDcKZ1mhzYLmFKZ5fLqIOcHm/tSTn2LGqbdPpzpa5
        TH1YzRy+gsg2xyQykWUahM0ykQU4Evln/2Xm7aDSssRxuC8w+usmPZHEVD4A8JrQ+tn8d2
        i6LyeR8il2jYgghPhPFLO8YVjSjAku8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602--pGWM6SVNA-MJ1Se6twqMw-1; Wed, 17 May 2023 06:39:48 -0400
X-MC-Unique: -pGWM6SVNA-MJ1Se6twqMw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-306286b3573so390828f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684319987; x=1686911987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9RFNHgsvYsYoyjUlDzPxezQioa4wPBhCeawLWQ4WWw=;
        b=BCJs3ouAAqcD7XzcXo4K37E9Q8ElioagO/mdu5T6mzFNPhYBYCpjQC22Zj3KqDC996
         t/y1V8AZYHlTWETaP3Sl0soiy8ZcYLnpFqum84pdPgTsBl4qoyqNbLgk03bDm4a/p5MY
         JAyzymTeHm6I2MGZQwJ0DDF2FH5lNFgVzuEKoKcaNw3g4HBJ5htEfBUWQTu6kQxpLVyY
         bu4GG5IJAefvGOPRoGIQawV36UzAHhgLkFIDMvZqNFITAQ5HcCRdPVxR+tFVgBhNh44O
         tSUS9M2N6r6eTJbQ1dsCmPt8CPgrqyXUwhzBUE/8/OXRDLsOge97jxFrT/4uAPTAjSxW
         tLEQ==
X-Gm-Message-State: AC+VfDwcFyfcQANi5c59RgXM1/v9d3A0YXGjqQQzHNQhqr6twvYQLfpT
        hsqVcbfi9gacU9AZ9ofYVXc15kMFJh67MLw8m0bLq7urS1oldzpLh45OiG8evjUlSeSetNf69cz
        Qlm5YQKNkuSnSwZ1FviMWawPf
X-Received: by 2002:a5d:54ca:0:b0:2ef:b4a9:202f with SMTP id x10-20020a5d54ca000000b002efb4a9202fmr236449wrv.69.1684319987569;
        Wed, 17 May 2023 03:39:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48S7q5cMVKOoBFLgTSo73ggc+dQUqjnyJuJwbUxLKbFp3Thr5m3KCEyEM6J2lKwxaUDPhdCA==
X-Received: by 2002:a5d:54ca:0:b0:2ef:b4a9:202f with SMTP id x10-20020a5d54ca000000b002efb4a9202fmr236437wrv.69.1684319987266;
        Wed, 17 May 2023 03:39:47 -0700 (PDT)
Received: from redhat.com ([2.52.6.43])
        by smtp.gmail.com with ESMTPSA id f12-20020adff8cc000000b002fe13ec49fasm2269476wrq.98.2023.05.17.03.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 03:39:46 -0700 (PDT)
Date:   Wed, 17 May 2023 06:39:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     Christoph Hellwig <hch@infradead.org>, stefanha@redhat.com,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2 1/2] virtio: abstract virtqueue related methods
Message-ID: <20230517062401-mutt-send-email-mst@kernel.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230517025424.601141-2-pizhenwei@bytedance.com>
 <ZGSEq197W8VvOWCc@infradead.org>
 <9e4702f2-5473-2139-3858-ae58817bc7b5@bytedance.com>
 <ZGSGQWqbtdwGXurf@infradead.org>
 <cc9f3aea-b8bc-f312-41bb-3fd68083aa99@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc9f3aea-b8bc-f312-41bb-3fd68083aa99@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 04:35:55PM +0800, zhenwei pi wrote:
> 
> 
> On 5/17/23 15:46, Christoph Hellwig wrote:
> > On Wed, May 17, 2023 at 03:43:03PM +0800, zhenwei pi wrote:
> > > I have a plan to introduce 'Virtio Over Fabrics'(TCP&RDMA) as Virtio
> > > transport, as mentioned in cover letter of this series:
> > > 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
> > > https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
> > 
> > Just don't do it.  Please define your own protocols over RDMA or TCP
> > for exactly the operations you need (for many they will already exist)
> > instead of piggyg backing on virtio and making everyone else pay the
> > price.
> > 
> 
> Hi
> 
> 1, `virtqueue_add_inbuf` in current version:
> static inline int virtqueue_add_inbuf(struct virtqueue *vq,
>                                       struct scatterlist *sg,
>                                       unsigned int num,
>                                       void *data,
>                                       gfp_t gfp)
> {
>         if (likely(!vq->abstract))
>                 return vring_virtqueue_add_sgs(vq, &sg, num, 0, 1, data,
> NULL, gfp);
> 
>         return vq->add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
> }
> 
> And disassemble 'virtinput_queue_evtbuf':
> static void virtinput_queue_evtbuf(struct virtio_input *vi,
>                                    struct virtio_input_event *evtbuf)
> {
>         struct scatterlist sg[1];
> 
>         sg_init_one(sg, evtbuf, sizeof(*evtbuf));
>         virtqueue_add_inbuf(vi->evt, sg, 1, evtbuf, GFP_ATOMIC);
> }
> 
> I notice that two instructions are newly added for vring like:
>  24d:   80 78 35 00             cmpb   $0x0,0x35(%rax)
>  251:   75 3f                   jne    292
> 
> Is it an expensive price...

Can we somehow only override the kick method?
Then take the ring and send it over ...


> 2, Storage/FS specific remote protocol is quite popular, otherwise I'm not
> familiar with other device protocols. For example, I need a remote crypto
> device to accelerate HTTPS ... With Virtio Over Fabrics, I have a chance to
> attach a virtio-crypto device to do this work.
> 
> -- 
> zhenwei pi

