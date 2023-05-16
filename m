Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922117044EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 07:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjEPF6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 01:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjEPF6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 01:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BC440F5
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 22:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684216590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xE2vX9E3wrj8UcSGbMoNwC1q+B39hVP/OfNafMgz0vs=;
        b=I2hmVjHSNEsIjmC2Lx5wzjtxkPOi33cCsEF43VuJ7EeJYM5q8BYUgP0kxr0/fUW4UOB++r
        zHNHWrnnptisoFR2RX5xnPsd/kZ9mgmcpcPO7nA+Lr/Svh6f05lUIAyPi2jc85Bjoclz9D
        Sn1ZjyoYSedYHMHWvLfLU6EYWduaKHE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-LtuRdBjtP-irunm3UEYENg-1; Tue, 16 May 2023 01:56:28 -0400
X-MC-Unique: LtuRdBjtP-irunm3UEYENg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-306311a2b99so5345176f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 22:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684216587; x=1686808587;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xE2vX9E3wrj8UcSGbMoNwC1q+B39hVP/OfNafMgz0vs=;
        b=XnNKZ0dAuQIR0fWtJzAKHz91T/jcdSPSHLngZJEQw2Z6rTqmxUbXUFTyorg3ds13Es
         50sDKzdp1pLkLd7It+5utNZjyw9G7hEy2mSOsW6w1p3jBY6OIhx8WWOAV7XySGQ3eKKw
         8MvvDDwR61ZRt1/FWrWC3qgMoeSkDYPiR9cbgY0uw//UTOXWAlwjGaK7CguevATxcHRG
         H14P2eJ0Sk8QXOM+nYN06sDTKoYm4RW76UWznBzIdDxkYHvHOVRvHG7FpMscq1Wu8EBL
         8M+kF3yTav6Rc65sXfgkrVlnobU1Iz6CZx9jk6PRDRATiRGJbSqrX1qTlGH6619V9kB6
         vKnw==
X-Gm-Message-State: AC+VfDzOmuJPB37hYjbJTzlCv8wWoRY9OqK6IvZwLQI8/ozjP91h9wrP
        yAXCeQaa357dLm5Elk2VsyHa4T3h/nMDrJSoxRnRZLDo53WkDrXX/di7Mrt6ONc2Bm6xqJ3JdeA
        QVj2LllrQkp1lVnyL7GLZjMpS
X-Received: by 2002:adf:e88a:0:b0:2ef:bada:2f25 with SMTP id d10-20020adfe88a000000b002efbada2f25mr23481274wrm.67.1684216587766;
        Mon, 15 May 2023 22:56:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6VOYlL8HQ+iOu5OwzIWQzrbzMHDIe+8lZ375iEzXfw1aZ3CniP6q9reUDXiExA4a5y7ChjZg==
X-Received: by 2002:adf:e88a:0:b0:2ef:bada:2f25 with SMTP id d10-20020adfe88a000000b002efbada2f25mr23481259wrm.67.1684216587465;
        Mon, 15 May 2023 22:56:27 -0700 (PDT)
Received: from redhat.com ([2.52.26.5])
        by smtp.gmail.com with ESMTPSA id k15-20020a05600c0b4f00b003f4247fbb5fsm1067384wmr.10.2023.05.15.22.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 22:56:26 -0700 (PDT)
Date:   Tue, 16 May 2023 01:56:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        alvaro.karsz@solid-run.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, david.marchand@redhat.com,
        netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230516015514-mutt-send-email-mst@kernel.org>
References: <20230414031947-mutt-send-email-mst@kernel.org>
 <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
 <20230510012951-mutt-send-email-mst@kernel.org>
 <CACGkMEszPydzw_MOUOVJKBBW_8iYn66i_9OFvLDoZMH34hMx=w@mail.gmail.com>
 <20230515004422-mutt-send-email-mst@kernel.org>
 <CACGkMEv+Q2UoBarNOzKSrc3O=Wb2_73O2j9cZXFdAiLBm1qY-Q@mail.gmail.com>
 <20230515061455-mutt-send-email-mst@kernel.org>
 <CACGkMEt8QkK1PnTrRUjDbyJheBurdibr4--Es8P0Y9NZM659pQ@mail.gmail.com>
 <20230516000829-mutt-send-email-mst@kernel.org>
 <CACGkMEvCHQLFbtB2fbF27oCd5fNSjUtUOS0q-Lx7=MeYR8KzRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvCHQLFbtB2fbF27oCd5fNSjUtUOS0q-Lx7=MeYR8KzRA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 12:17:50PM +0800, Jason Wang wrote:
> On Tue, May 16, 2023 at 12:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, May 16, 2023 at 10:44:45AM +0800, Jason Wang wrote:
> > > On Mon, May 15, 2023 at 6:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, May 15, 2023 at 01:13:33PM +0800, Jason Wang wrote:
> > > > > On Mon, May 15, 2023 at 12:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, May 15, 2023 at 09:05:54AM +0800, Jason Wang wrote:
> > > > > > > On Wed, May 10, 2023 at 1:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Apr 17, 2023 at 11:40:58AM +0800, Jason Wang wrote:
> > > > > > > > > On Fri, Apr 14, 2023 at 3:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Apr 14, 2023 at 01:04:15PM +0800, Jason Wang wrote:
> > > > > > > > > > > Forget to cc netdev, adding.
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Apr 14, 2023 at 12:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Apr 13, 2023 at 02:40:26PM +0800, Jason Wang wrote:
> > > > > > > > > > > > > This patch convert rx mode setting to be done in a workqueue, this is
> > > > > > > > > > > > > a must for allow to sleep when waiting for the cvq command to
> > > > > > > > > > > > > response since current code is executed under addr spin lock.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > > >
> > > > > > > > > > > > I don't like this frankly. This means that setting RX mode which would
> > > > > > > > > > > > previously be reliable, now becomes unreliable.
> > > > > > > > > > >
> > > > > > > > > > > It is "unreliable" by design:
> > > > > > > > > > >
> > > > > > > > > > >       void                    (*ndo_set_rx_mode)(struct net_device *dev);
> > > > > > > > > > >
> > > > > > > > > > > > - first of all configuration is no longer immediate
> > > > > > > > > > >
> > > > > > > > > > > Is immediate a hard requirement? I can see a workqueue is used at least:
> > > > > > > > > > >
> > > > > > > > > > > mlx5e, ipoib, efx, ...
> > > > > > > > > > >
> > > > > > > > > > > >   and there is no way for driver to find out when
> > > > > > > > > > > >   it actually took effect
> > > > > > > > > > >
> > > > > > > > > > > But we know rx mode is best effort e.g it doesn't support vhost and we
> > > > > > > > > > > survive from this for years.
> > > > > > > > > > >
> > > > > > > > > > > > - second, if device fails command, this is also not
> > > > > > > > > > > >   propagated to driver, again no way for driver to find out
> > > > > > > > > > > >
> > > > > > > > > > > > VDUSE needs to be fixed to do tricks to fix this
> > > > > > > > > > > > without breaking normal drivers.
> > > > > > > > > > >
> > > > > > > > > > > It's not specific to VDUSE. For example, when using virtio-net in the
> > > > > > > > > > > UP environment with any software cvq (like mlx5 via vDPA or cma
> > > > > > > > > > > transport).
> > > > > > > > > > >
> > > > > > > > > > > Thanks
> > > > > > > > > >
> > > > > > > > > > Hmm. Can we differentiate between these use-cases?
> > > > > > > > >
> > > > > > > > > It doesn't look easy since we are drivers for virtio bus. Underlayer
> > > > > > > > > details were hidden from virtio-net.
> > > > > > > > >
> > > > > > > > > Or do you have any ideas on this?
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > >
> > > > > > > > I don't know, pass some kind of flag in struct virtqueue?
> > > > > > > >         "bool slow; /* This vq can be very slow sometimes. Don't wait for it! */"
> > > > > > > >
> > > > > > > > ?
> > > > > > > >
> > > > > > >
> > > > > > > So if it's slow, sleep, otherwise poll?
> > > > > > >
> > > > > > > I feel setting this flag might be tricky, since the driver doesn't
> > > > > > > know whether or not it's really slow. E.g smartNIC vendor may allow
> > > > > > > virtio-net emulation over PCI.
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > driver will have the choice, depending on whether
> > > > > > vq is deterministic or not.
> > > > >
> > > > > Ok, but the problem is, such booleans are only useful for virtio ring
> > > > > codes. But in this case, virtio-net knows what to do for cvq. So I'm
> > > > > not sure who the user is.
> > > > >
> > > > > Thanks
> > > >
> > > > Circling back, what exactly does the architecture you are trying
> > > > to fix look like? Who is going to introduce unbounded latency?
> > > > The hypervisor?
> > >
> > > Hypervisor is one of the possible reason, we have many more:
> > >
> > > Hardware device that provides virtio-pci emulation.
> > > Userspace devices like VDUSE.
> >
> > So let's start by addressing VDUSE maybe?
> 
> It's reported by at least one hardware vendor as well. I remember it
> was Alvaro who reported this first in the past.
> 
> >
> > > > If so do we not maybe want a new feature bit
> > > > that documents this? Hypervisor then can detect old guests
> > > > that spin and decide what to do, e.g. prioritise cvq more,
> > > > or fail FEATURES_OK.
> > >
> > > We suffer from this for bare metal as well.
> > >
> > > But a question is what's wrong with the approach that is used in this
> > > patch? I've answered that set_rx_mode is not reliable, so it should be
> > > fine to use workqueue. Except for this, any other thing that worries
> > > you?
> > >
> > > Thanks
> >
> > It's not reliable for other drivers but has been reliable for virtio.
> > I worry some software relied on this.
> 
> It's probably fine since some device like vhost doesn't support this
> at all and we manage to survive for several years.

vhost is often connected to a clever learning backend
such as a bridge which will DTRT without guest configuring
anything at all though, this could be why it works.



> > You are making good points though ... could we get some
> > maintainer's feedback on this?
> 
> That would be helpful. Jakub, any input on this?
> 
> Thanks
> 
> >
> > > >
> > > > > >
> > > > > >
> > > > > > > > --
> > > > > > > > MST
> > > > > > > >
> > > > > >
> > > >
> >

