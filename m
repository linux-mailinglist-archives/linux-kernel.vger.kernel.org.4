Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7488B725AEF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbjFGJod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjFGJob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D345419AA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686131026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QZ1hF21NiKTJobI8K1XAh5a08hU1n8m1daENZFoRs8=;
        b=BsTfmNMHQn84w8Okj8MMcAI0BjBF8n/Ri1nz1bkCRIVpdEW5f6r08kTpCc6Pel3t5tPIHO
        KrFlwW2NBv0apsJrXx7TxHByTf03w2XcIv90Ar2yBFFD51xA4UnyCnfBxvp+Djfq9liNo/
        dmnRSQVGfEg4Srp5KT2vOWwqiLZLN6Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-nS0KdtDkM0OzaxsunvW9EQ-1; Wed, 07 Jun 2023 05:43:44 -0400
X-MC-Unique: nS0KdtDkM0OzaxsunvW9EQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30c5d31b567so2550254f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686131023; x=1688723023;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QZ1hF21NiKTJobI8K1XAh5a08hU1n8m1daENZFoRs8=;
        b=DF3Z2B4oJb0FKA9X1EbQQbR5F7HhSnNQKzeaNOncQ+MLo/7OWOxA7lbo8O4wIYSmf2
         4bZjQssPX4A8p5yQ4od4Jy/tjsD+F7gs32IrDaZLnA3BZeekTEevH/jrNtucMz1w+1uR
         tlKsahyph6r50/tCyL29rSXEDeM8/lEwl2YiT6FADsFUQsNWIokDCd1A1H6zIqOixUe+
         ewxToztEfbo1fdTM4NAo5DN3q9suraqzX3RRdZ7aCD3XnVBde1tTlQeW86EjwGVBtDyj
         fUMX+bjqTts1bBqwZylsKVhnYUkFVdLYremTX8wesofTFc29L5mB2pQyXjmn74xmSaap
         pMwA==
X-Gm-Message-State: AC+VfDxbWODjI3jMTDT5gRx6XPtd887fcqtGtYW2xerU9sKTKqr38F2D
        fRZHbMuG4MpZ6a2CbBpEjyxy3AaWlIOBtdI7lAY4xoy9/wMPlf1fGNwDnXAVsQBBuzTf5ayW0RU
        XyMi7xL6a2f/lRf7xnFJdn11f
X-Received: by 2002:adf:f752:0:b0:309:3b8d:16a8 with SMTP id z18-20020adff752000000b003093b8d16a8mr3811519wrp.50.1686131023289;
        Wed, 07 Jun 2023 02:43:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5r8F++2zoGvW9X0FQgUyGuci7Faw6wUX9bX8XWZ5GmLoFQBI7RaLBvwAY8GuRxbZAJ6VSSdQ==
X-Received: by 2002:adf:f752:0:b0:309:3b8d:16a8 with SMTP id z18-20020adff752000000b003093b8d16a8mr3811501wrp.50.1686131022945;
        Wed, 07 Jun 2023 02:43:42 -0700 (PDT)
Received: from redhat.com ([2.55.41.2])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d6841000000b003079c402762sm14993624wrw.19.2023.06.07.02.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:43:42 -0700 (PDT)
Date:   Wed, 7 Jun 2023 05:43:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <20230607054246-mutt-send-email-mst@kernel.org>
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230605084104-mutt-send-email-mst@kernel.org>
 <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org>
 <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org>
 <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
 <20230606085643-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:39:15AM +0200, Stefano Garzarella wrote:
> On Tue, Jun 6, 2023 at 2:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 06, 2023 at 09:29:22AM +0800, Jason Wang wrote:
> > > On Mon, Jun 5, 2023 at 10:58 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > >
> > > > On Mon, Jun 05, 2023 at 09:54:57AM -0400, Michael S. Tsirkin wrote:
> > > > >On Mon, Jun 05, 2023 at 03:30:35PM +0200, Stefano Garzarella wrote:
> > > > >> On Mon, Jun 05, 2023 at 09:00:25AM -0400, Michael S. Tsirkin wrote:
> > > > >> > On Mon, Jun 05, 2023 at 02:54:20PM +0200, Stefano Garzarella wrote:
> > > > >> > > On Mon, Jun 05, 2023 at 08:41:54AM -0400, Michael S. Tsirkin wrote:
> > > > >> > > > On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
> > > > >> > > > > vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
> > > > >> > > > > don't support packed virtqueue well yet, so let's filter the
> > > > >> > > > > VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
> > > > >> > > > >
> > > > >> > > > > This way, even if the device supports it, we don't risk it being
> > > > >> > > > > negotiated, then the VMM is unable to set the vring state properly.
> > > > >> > > > >
> > > > >> > > > > Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> > > > >> > > > > Cc: stable@vger.kernel.org
> > > > >> > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > >> > > > > ---
> > > > >> > > > >
> > > > >> > > > > Notes:
> > > > >> > > > >     This patch should be applied before the "[PATCH v2 0/3] vhost_vdpa:
> > > > >> > > > >     better PACKED support" series [1] and backported in stable branches.
> > > > >> > > > >
> > > > >> > > > >     We can revert it when we are sure that everything is working with
> > > > >> > > > >     packed virtqueues.
> > > > >> > > > >
> > > > >> > > > >     Thanks,
> > > > >> > > > >     Stefano
> > > > >> > > > >
> > > > >> > > > >     [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/
> > > > >> > > >
> > > > >> > > > I'm a bit lost here. So why am I merging "better PACKED support" then?
> > > > >> > >
> > > > >> > > To really support packed virtqueue with vhost-vdpa, at that point we would
> > > > >> > > also have to revert this patch.
> > > > >> > >
> > > > >> > > I wasn't sure if you wanted to queue the series for this merge window.
> > > > >> > > In that case do you think it is better to send this patch only for stable
> > > > >> > > branches?
> > > > >> > > > Does this patch make them a NOP?
> > > > >> > >
> > > > >> > > Yep, after applying the "better PACKED support" series and being
> > > > >> > > sure that
> > > > >> > > the IOCTLs of vhost-vdpa support packed virtqueue, we should revert this
> > > > >> > > patch.
> > > > >> > >
> > > > >> > > Let me know if you prefer a different approach.
> > > > >> > >
> > > > >> > > I'm concerned that QEMU uses vhost-vdpa IOCTLs thinking that the kernel
> > > > >> > > interprets them the right way, when it does not.
> > > > >> > >
> > > > >> > > Thanks,
> > > > >> > > Stefano
> > > > >> > >
> > > > >> >
> > > > >> > If this fixes a bug can you add Fixes tags to each of them? Then it's ok
> > > > >> > to merge in this window. Probably easier than the elaborate
> > > > >> > mask/unmask dance.
> > > > >>
> > > > >> CCing Shannon (the original author of the "better PACKED support"
> > > > >> series).
> > > > >>
> > > > >> IIUC Shannon is going to send a v3 of that series to fix the
> > > > >> documentation, so Shannon can you also add the Fixes tags?
> > > > >>
> > > > >> Thanks,
> > > > >> Stefano
> > > > >
> > > > >Well this is in my tree already. Just reply with
> > > > >Fixes: <>
> > > > >to each and I will add these tags.
> > > >
> > > > I tried, but it is not easy since we added the support for packed
> > > > virtqueue in vdpa and vhost incrementally.
> > > >
> > > > Initially I was thinking of adding the same tag used here:
> > > >
> > > > Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> > > >
> > > > Then I discovered that vq_state wasn't there, so I was thinking of
> > > >
> > > > Fixes: 530a5678bc00 ("vdpa: support packed virtqueue for set/get_vq_state()")
> > > >
> > > > So we would have to backport quite a few patches into the stable branches.
> > > > I don't know if it's worth it...
> > > >
> > > > I still think it is better to disable packed in the stable branches,
> > > > otherwise I have to make a list of all the patches we need.
> > > >
> > > > Any other ideas?
> > >
> > > AFAIK, except for vp_vdpa, pds seems to be the first parent that
> > > supports packed virtqueue. Users should not notice anything wrong if
> > > they don't use packed virtqueue. And the problem of vp_vdpa + packed
> > > virtqueue came since the day0 of vp_vdpa. It seems fine to do nothing
> > > I guess.
> > >
> > > Thanks
> >
> >
> > I have a question though, what if down the road there
> > is a new feature that needs more changes? It will be
> > broken too just like PACKED no?
> > Shouldn't vdpa have an allowlist of features it knows how
> > to support?
> 
> It looks like we had it, but we took it out (by the way, we were
> enabling packed even though we didn't support it):
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6234f80574d7569444d8718355fa2838e92b158b
> 
> The only problem I see is that for each new feature we have to modify 
> the kernel.
> Could we have new features that don't require handling by vhost-vdpa?
> 
> Thanks,
> Stefano

Jason what do you say to reverting this?

-- 
MST

