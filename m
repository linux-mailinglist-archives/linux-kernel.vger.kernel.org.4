Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD1B67DF00
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjA0IXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjA0IXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:23:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C06D38026
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674807745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aDjl4klenBNtl/PLFSbWMzoXaIOyzFKf0hXB3Iobp5g=;
        b=ObUwNRFPJwOJlY3fwEUj3vc/vMfwPgasxdY1yzXNDHmwXTjNrWDBUtV1unXLmgm+p+ynp8
        O5Wji+x7XzmXqHxloihi9k0/W3s1gVHDYaAAlf+hdSD3HcdhoZZ03dO58Pi+RDQiwS8bU8
        Hf63/YED1SsKupdkQ/PrSW/miMEa0GU=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-547-kVvYXSfoPbWcdf_IKURBcA-1; Fri, 27 Jan 2023 03:22:23 -0500
X-MC-Unique: kVvYXSfoPbWcdf_IKURBcA-1
Received: by mail-ua1-f71.google.com with SMTP id z22-20020ab05656000000b00652f9577464so1575400uaa.15
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDjl4klenBNtl/PLFSbWMzoXaIOyzFKf0hXB3Iobp5g=;
        b=gM9G+woj3UngNlNoa1DblrjzZVZlEzelAQnfV4rC7UagBE+PnxRNdgm50C+XndK4Jf
         AHU36LhvPU264ro7slGtVqvHNRitF/82q5KhQJCTcHiGPMDcV/zmW6ihtuMfcUH9OwAo
         SSbQYd33vZvFQQ5awpP8LV8eM8OXE7P56vOp0Tdem0TLHmcsEtciKq491M6mcbzvRshg
         vlxEo/tiM3ymSb1+ToWNdMzwPnBHGOjWZvlqbjDQcAPLPrhYwTe38MsS8FGuFreZMO8D
         Ev6Epn4TNWLzmCeMT6aNbblYX2DwJDbzB2BsMo9dL3g96ENilQhMo6hFvkFvq6aE++dG
         Qq5A==
X-Gm-Message-State: AO0yUKXGwQmFYA1z37kPX4fQWWI1It6iVqtFpTZPgbbLKkauP9YP7OgG
        vyP5XQTZhKyvj9dO7tGsZ/4S8eSZ3wQG2WnCxd6ExuA82ocy8zkS6G88/DuE/t15Y2anlPFWl6T
        Xlpr6TuSKTJuJ/Rg6NDSdIRow
X-Received: by 2002:a1f:a846:0:b0:3e6:2734:7602 with SMTP id r67-20020a1fa846000000b003e627347602mr5111681vke.1.1674807743440;
        Fri, 27 Jan 2023 00:22:23 -0800 (PST)
X-Google-Smtp-Source: AK7set9iRj9arz3CD4aqIKW6gnt+cnTuOdlvDcBZLcVWFqllfMd02qFwImS0F1+FxuC3fl0sIaIUCA==
X-Received: by 2002:a1f:a846:0:b0:3e6:2734:7602 with SMTP id r67-20020a1fa846000000b003e627347602mr5111676vke.1.1674807743221;
        Fri, 27 Jan 2023 00:22:23 -0800 (PST)
Received: from redhat.com ([37.19.199.113])
        by smtp.gmail.com with ESMTPSA id s8-20020a05612204c800b003e25aef33f5sm254005vkn.9.2023.01.27.00.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 00:22:22 -0800 (PST)
Date:   Fri, 27 Jan 2023 03:22:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export
 irq_create_affinity_masks()
Message-ID: <20230127032039-mutt-send-email-mst@kernel.org>
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-2-xieyongji@bytedance.com>
 <20221219023253-mutt-send-email-mst@kernel.org>
 <CACycT3utDJFZtWzqCUXJaqRjkCXPMTAi+VJd3g6dw25vWqaduw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACycT3utDJFZtWzqCUXJaqRjkCXPMTAi+VJd3g6dw25vWqaduw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 05:36:02PM +0800, Yongji Xie wrote:
> On Mon, Dec 19, 2022 at 3:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Dec 05, 2022 at 04:41:17PM +0800, Xie Yongji wrote:
> > > Export irq_create_affinity_masks() so that some modules
> > > can make use of it to implement interrupt affinity
> > > spreading mechanism.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> >
> > So this got nacked, what's the plan now?
> >
> 
> I‘d like to check with Christoph again first.
> 
> Hi Christoph,
> 
> Jason will post some patches to get rid of the DMA API for vDPA
> simulators. And the irq affinity algorithm is independent of the IRQ
> subsystem IIUC. So could you allow this patch so that we can reuse the
> algorithm to select the best CPU (per-cpu affinity if possible, or at
> least per-node) to run the virtqueue's irq callback.
> 
> Thanks,
> Yongji

I think you need to explain why you are building low level
affinity masks.  what's the plan now?

> > > ---
> > >  kernel/irq/affinity.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> > > index d9a5c1d65a79..f074a7707c6d 100644
> > > --- a/kernel/irq/affinity.c
> > > +++ b/kernel/irq/affinity.c
> > > @@ -487,6 +487,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
> > >
> > >       return masks;
> > >  }
> > > +EXPORT_SYMBOL_GPL(irq_create_affinity_masks);
> > >
> > >  /**
> > >   * irq_calc_affinity_vectors - Calculate the optimal number of vectors
> > > --
> > > 2.20.1
> >

