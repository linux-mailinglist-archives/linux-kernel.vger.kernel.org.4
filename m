Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26317707D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjERKKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjERKKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09631717
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684404561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jCIbZz6ZgescTd68JNRiPQpaemH52EcT/phWnnmN7dc=;
        b=N3iWg4fBMQrzDu8MuOwXgDxnSwRoatoUpYpQnGR87WfdMIqOHCCD49fQhxZ73wPvwacaVb
        nvQ8tMpu1gfwliABh4ZrDPmkuZRl4xk9xWLBuiAu5fEBdIfMqstmDj1miUki+/VLS2ankv
        vUPdH2Rhd+IeXc8wACMbiCEJ6VMbYRE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-2cfFjPaTNkaPDyWSQ8NRNg-1; Thu, 18 May 2023 06:09:19 -0400
X-MC-Unique: 2cfFjPaTNkaPDyWSQ8NRNg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f41dcf1e28so6880275e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684404558; x=1686996558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCIbZz6ZgescTd68JNRiPQpaemH52EcT/phWnnmN7dc=;
        b=ZNcf1j58ddul3X1xJnyClCnI4wOPUU8SfT2qs/JUxZGQJu6K5xpYnZPa5/m7tNcjXM
         HwXMmtfzbqaRhZn6T4DxNB0RkzLncmdzRUn4JW6L3UFJnCW5qcFCl7sDY4U8qgd+rfT7
         jP8Lj+NeFFsuvZRWqiXiu0z+CsWRRX4ZcdTZpIi54lTjYsJBmP1xuBosi0TvyRBCwvc5
         waulJNER6HLmHCqYOcz0ofsjxRhpRDyHufeN56nYP6XVRlD8Ox8Ug/6hoeBaRn+4Lm4B
         LwdatXKhSDg5FQgphp7xkh/B3G9s6kLd4Ou1iELT2PoN68KbDE0kIRJnzLLUPQxXfEI7
         owVw==
X-Gm-Message-State: AC+VfDxnSXLYpljinH1oJVQabGrH/WXaPN2aez+U96TDzVFq6J74G+d4
        cfkQ7oIBLUo2gvjPIodhy6m21WMWi+hI46Z6v6rUzvfAJKQJUaDXAKel9WcLbb7xatABdNFLUZK
        0Ljetv7i4Zf8B5k4fMHje/0cb
X-Received: by 2002:a1c:6a17:0:b0:3f4:f855:706b with SMTP id f23-20020a1c6a17000000b003f4f855706bmr968941wmc.27.1684404558524;
        Thu, 18 May 2023 03:09:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6oIgFtBVIy9bdA6+5Ow17knV96BGAtGJXZzadD+PYeaIhzN8pn6HZW19bRMu1KU+Q951kbgg==
X-Received: by 2002:a1c:6a17:0:b0:3f4:f855:706b with SMTP id f23-20020a1c6a17000000b003f4f855706bmr968925wmc.27.1684404558195;
        Thu, 18 May 2023 03:09:18 -0700 (PDT)
Received: from redhat.com ([2.52.6.43])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5552000000b0030631a599a0sm1646018wrw.24.2023.05.18.03.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 03:09:17 -0700 (PDT)
Date:   Thu, 18 May 2023 06:09:14 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     Christoph Hellwig <hch@infradead.org>, stefanha@redhat.com,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH v2 1/2] virtio: abstract virtqueue related methods
Message-ID: <20230518060656-mutt-send-email-mst@kernel.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230517025424.601141-2-pizhenwei@bytedance.com>
 <ZGSEq197W8VvOWCc@infradead.org>
 <9e4702f2-5473-2139-3858-ae58817bc7b5@bytedance.com>
 <ZGSGQWqbtdwGXurf@infradead.org>
 <cc9f3aea-b8bc-f312-41bb-3fd68083aa99@bytedance.com>
 <20230517062401-mutt-send-email-mst@kernel.org>
 <ee2a975f-0aa6-a46a-e9d2-7f82e313347f@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee2a975f-0aa6-a46a-e9d2-7f82e313347f@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 08:47:22AM +0800, zhenwei pi wrote:
> On 5/17/23 18:39, Michael S. Tsirkin wrote:
> > On Wed, May 17, 2023 at 04:35:55PM +0800, zhenwei pi wrote:
> > > 
> > > 
> > > On 5/17/23 15:46, Christoph Hellwig wrote:
> > > > On Wed, May 17, 2023 at 03:43:03PM +0800, zhenwei pi wrote:
> > > > > I have a plan to introduce 'Virtio Over Fabrics'(TCP&RDMA) as Virtio
> > > > > transport, as mentioned in cover letter of this series:
> > > > > 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
> > > > > https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
> > > > 
> > > > Just don't do it.  Please define your own protocols over RDMA or TCP
> > > > for exactly the operations you need (for many they will already exist)
> > > > instead of piggyg backing on virtio and making everyone else pay the
> > > > price.
> > > > 
> > > 
> > > Hi
> > > 
> > > 1, `virtqueue_add_inbuf` in current version:
> > > static inline int virtqueue_add_inbuf(struct virtqueue *vq,
> > >                                        struct scatterlist *sg,
> > >                                        unsigned int num,
> > >                                        void *data,
> > >                                        gfp_t gfp)
> > > {
> > >          if (likely(!vq->abstract))
> > >                  return vring_virtqueue_add_sgs(vq, &sg, num, 0, 1, data,
> > > NULL, gfp);
> > > 
> > >          return vq->add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
> > > }
> > > 
> > > And disassemble 'virtinput_queue_evtbuf':
> > > static void virtinput_queue_evtbuf(struct virtio_input *vi,
> > >                                     struct virtio_input_event *evtbuf)
> > > {
> > >          struct scatterlist sg[1];
> > > 
> > >          sg_init_one(sg, evtbuf, sizeof(*evtbuf));
> > >          virtqueue_add_inbuf(vi->evt, sg, 1, evtbuf, GFP_ATOMIC);
> > > }
> > > 
> > > I notice that two instructions are newly added for vring like:
> > >   24d:   80 78 35 00             cmpb   $0x0,0x35(%rax)
> > >   251:   75 3f                   jne    292
> > > 
> > > Is it an expensive price...
> > 
> > Can we somehow only override the kick method?
> > Then take the ring and send it over ...
> > 
> 
> Could you please take a look at this code?
> https://github.com/pizhenwei/linux/blob/virtio-of-github/drivers/virtio/virtio_fabrics.c#LL861C13-L861C23

what am I looking at here?

Looks like at least vof_handle_vq duplicates some code from vringh.
But besides that yes, that's the idea.


> > 
> > > 2, Storage/FS specific remote protocol is quite popular, otherwise I'm not
> > > familiar with other device protocols. For example, I need a remote crypto
> > > device to accelerate HTTPS ... With Virtio Over Fabrics, I have a chance to
> > > attach a virtio-crypto device to do this work.
> > > 
> > > -- 
> > > zhenwei pi
> > 
> 
> -- 
> zhenwei pi

