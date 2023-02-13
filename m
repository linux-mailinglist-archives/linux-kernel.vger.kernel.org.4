Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045A4694503
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjBMMAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjBMMAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:00:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426CD13D4F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676289586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46CLETJ40hAAVjqperX0UsKESJ1sk6fyhGA6Z8UODrY=;
        b=eRxCI7os+h7vCX+4rMT5laxw3OSdNyRx0hB6CFMX4/Qhen36qaIJIHnhgebtIgbRx0/ZuY
        UHol+TQWwN1tQFfnQHrcJ6eAvJd/ZUmtqc7ikgFOxWB0tDwlZNuCJ9Mzoj5LE9t80SFJz4
        RHsCzscm4NQOiFAk92mk57qZLDpPuVE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-155-CmjEpR7BMZifuUY8mXHj7Q-1; Mon, 13 Feb 2023 06:59:45 -0500
X-MC-Unique: CmjEpR7BMZifuUY8mXHj7Q-1
Received: by mail-ej1-f70.google.com with SMTP id nd38-20020a17090762a600b00871ff52c6b5so7432704ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:59:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46CLETJ40hAAVjqperX0UsKESJ1sk6fyhGA6Z8UODrY=;
        b=XzmJMYh8VzFc9ypZWIlX+++o5Y0KjwHxnK/b+dcptFExNBFp9SA4t88/LIBJCAURdI
         k7yvd0Ak6MKZBRFgG14ojvCzYJWZeU1hmvDp1x2D2DyBfYIqMM9MDu5AYaAXgYhZzB+h
         Y52LbI4s1EYMOiqFIEmYlZFxWsIMHJDh7/J4iuuoWbFVEKZ2kw2NYKN0pfSP7ffIqd0v
         PqNkgNJ3GaR3q3GF6bZP12n0RK8GUFx5/r823ypqRTbzW9FH432mD5SuO41lBCnKU8Ja
         smmfcAd6b37a96nb49DKXaYdRbYHwvts9RIoTypv/lJT5cD+jMSPBoxTixXZSd/ytWKn
         ZyYw==
X-Gm-Message-State: AO0yUKUdlEh+GLvrBRkM6UN8jKIOh/asDOOpo5HBuyN4YrTRIVdDarY8
        x1kpMI+/kWLrsWaNbAYH9wpwhilUExacHTG9txDEUcXZoHKcxP81a/TlBb2I+RXcPBSRufS+HSo
        L8GuIKPAwH6LtUqh03ZHv5Z6C6bA8wA==
X-Received: by 2002:a17:907:6ea8:b0:870:94e:13f9 with SMTP id sh40-20020a1709076ea800b00870094e13f9mr33062280ejc.0.1676289584024;
        Mon, 13 Feb 2023 03:59:44 -0800 (PST)
X-Google-Smtp-Source: AK7set9TdRlIREvM6fdM6jWVJOrK0vCr8EsGV3icl24AFGs3qHQf2X49gvhr+Cs+XywSMqELN9alyw==
X-Received: by 2002:a17:907:6ea8:b0:870:94e:13f9 with SMTP id sh40-20020a1709076ea800b00870094e13f9mr33062269ejc.0.1676289583874;
        Mon, 13 Feb 2023 03:59:43 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id mf17-20020a170906cb9100b008a60ed04e42sm6651265ejb.110.2023.02.13.03.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 03:59:43 -0800 (PST)
Date:   Mon, 13 Feb 2023 06:59:39 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export
 irq_create_affinity_masks()
Message-ID: <20230213065116-mutt-send-email-mst@kernel.org>
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-2-xieyongji@bytedance.com>
 <20221219023253-mutt-send-email-mst@kernel.org>
 <CACycT3utDJFZtWzqCUXJaqRjkCXPMTAi+VJd3g6dw25vWqaduw@mail.gmail.com>
 <20230127032039-mutt-send-email-mst@kernel.org>
 <CACycT3u=vULuZ9-ZakBjxmbu88iUb+xB2mHJUnHA_8SuUV7H4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACycT3u=vULuZ9-ZakBjxmbu88iUb+xB2mHJUnHA_8SuUV7H4w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 07:53:55PM +0800, Yongji Xie wrote:
> On Fri, Jan 27, 2023 at 4:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Dec 19, 2022 at 05:36:02PM +0800, Yongji Xie wrote:
> > > On Mon, Dec 19, 2022 at 3:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Dec 05, 2022 at 04:41:17PM +0800, Xie Yongji wrote:
> > > > > Export irq_create_affinity_masks() so that some modules
> > > > > can make use of it to implement interrupt affinity
> > > > > spreading mechanism.
> > > > >
> > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > >
> > > > So this got nacked, what's the plan now?
> > > >
> > >
> > > I‘d like to check with Christoph again first.
> > >
> > > Hi Christoph,
> > >
> > > Jason will post some patches to get rid of the DMA API for vDPA
> > > simulators. And the irq affinity algorithm is independent of the IRQ
> > > subsystem IIUC. So could you allow this patch so that we can reuse the
> > > algorithm to select the best CPU (per-cpu affinity if possible, or at
> > > least per-node) to run the virtqueue's irq callback.
> > >
> > > Thanks,
> > > Yongji
> >
> > I think you need to explain why you are building low level
> > affinity masks.
> 
> In VDUSE case, we use workqueue to run the virtqueue's irq callback.
> Now I want to queue the irq callback kwork to one specific CPU to get
> per-cpu affinity if possible, or at least per-node. So I need to use
> this function to build the low level affinity masks for each
> virtqueue.
> 
> > what's the plan now?
> >
> 
> If there is no objection, I'll post a new version.
> 
> Thanks,
> Yongji

I doubt you made a convicing case here - I think Christoph was saying if
it is not an irq it should not use an irq affinity API.
So a new API possibly sharing implementation with irq affinity
is called for then? Maybe.


-- 
MST

