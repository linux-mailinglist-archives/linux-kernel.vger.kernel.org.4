Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCDF702302
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 06:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbjEOEqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 00:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjEOEqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 00:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8719A2686
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 21:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684125932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2XjOq8S6eLxylOWfxVE7lTJHF71GQ9YxxKOvqpFm4bE=;
        b=exUnSQD/WWSO6r7RF1/EoKPPpPpkmZnlq1E37o9gc8p2etB2OUWzVKAAHD0zmYXoZiObWU
        /YINpiLM8bPXfFnKfKozfEXN9U2SU6g94/3vWSwD7DAYjvQ/ydeMvJ6wf2zPEzJ+sDv22r
        WWvVq12/M0+oOu+/PYi7ZNsz2VsEZEY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-HXHP-ZxHNCK15agmx-wBWA-1; Mon, 15 May 2023 00:45:30 -0400
X-MC-Unique: HXHP-ZxHNCK15agmx-wBWA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f433a2308bso110156905e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 21:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684125929; x=1686717929;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XjOq8S6eLxylOWfxVE7lTJHF71GQ9YxxKOvqpFm4bE=;
        b=iEMM34ofEw+n6rzVuiFM57ZIxSwBSC1kbJCSmWCFxI76VHngs4O6/i/kyEk04cowAp
         wlDp3hoAqNL3Fb//gMb/oH40kfXqLzBbR/jl2mm9cGO1sp5ebD0S9uBiv2yvTfng0Nyb
         IsrBlD5t5/oSEc2KXlYAN514WyGodOPYMYPBQXVfDirFTHwUlxpFIiwYehUPcFGlinsU
         pFLUio/UtqtyvbRjSXZEr/Yh6NunE9K9BFZGYx/PdMO9vymJmoTYa9+WLyr5uYtqVFGK
         WVqYx9DFLac6zcVCIwl8mwo1RfYrupcQFi6mwyZc1srtfJNdogpRs5O9oST3Zm5O+t7U
         7arg==
X-Gm-Message-State: AC+VfDyEd3zeucHg49Mnk3ivoA4C/BWMsG+z4jvO2PEhjGdcgFpOxbsO
        y/uH3S7aBoegnEiJVmm43hgArmiUhERHuhfqa6zVh71gKctpSQsoUzglUMOFGhWdJpDTeVPdgDE
        vd0/+fi//f4CE+CZIt7FO99zq
X-Received: by 2002:adf:dd83:0:b0:307:7d1a:20fd with SMTP id x3-20020adfdd83000000b003077d1a20fdmr21880986wrl.12.1684125929769;
        Sun, 14 May 2023 21:45:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4OdZsGOJb5yblTc2DXNqTp+ArQzg1WhoBfxb9JKuFEQkr0FvMpdV5CBb5jM57qjG8ZfvnWbw==
X-Received: by 2002:adf:dd83:0:b0:307:7d1a:20fd with SMTP id x3-20020adfdd83000000b003077d1a20fdmr21880965wrl.12.1684125929446;
        Sun, 14 May 2023 21:45:29 -0700 (PDT)
Received: from redhat.com ([2.52.146.3])
        by smtp.gmail.com with ESMTPSA id k11-20020adff5cb000000b0030649242b72sm31024743wrp.113.2023.05.14.21.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 21:45:28 -0700 (PDT)
Date:   Mon, 15 May 2023 00:45:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        alvaro.karsz@solid-run.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, david.marchand@redhat.com,
        netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230515004422-mutt-send-email-mst@kernel.org>
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-2-jasowang@redhat.com>
 <20230413121525-mutt-send-email-mst@kernel.org>
 <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
 <20230414031947-mutt-send-email-mst@kernel.org>
 <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
 <20230510012951-mutt-send-email-mst@kernel.org>
 <CACGkMEszPydzw_MOUOVJKBBW_8iYn66i_9OFvLDoZMH34hMx=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEszPydzw_MOUOVJKBBW_8iYn66i_9OFvLDoZMH34hMx=w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 09:05:54AM +0800, Jason Wang wrote:
> On Wed, May 10, 2023 at 1:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Apr 17, 2023 at 11:40:58AM +0800, Jason Wang wrote:
> > > On Fri, Apr 14, 2023 at 3:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Apr 14, 2023 at 01:04:15PM +0800, Jason Wang wrote:
> > > > > Forget to cc netdev, adding.
> > > > >
> > > > > On Fri, Apr 14, 2023 at 12:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Apr 13, 2023 at 02:40:26PM +0800, Jason Wang wrote:
> > > > > > > This patch convert rx mode setting to be done in a workqueue, this is
> > > > > > > a must for allow to sleep when waiting for the cvq command to
> > > > > > > response since current code is executed under addr spin lock.
> > > > > > >
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > >
> > > > > > I don't like this frankly. This means that setting RX mode which would
> > > > > > previously be reliable, now becomes unreliable.
> > > > >
> > > > > It is "unreliable" by design:
> > > > >
> > > > >       void                    (*ndo_set_rx_mode)(struct net_device *dev);
> > > > >
> > > > > > - first of all configuration is no longer immediate
> > > > >
> > > > > Is immediate a hard requirement? I can see a workqueue is used at least:
> > > > >
> > > > > mlx5e, ipoib, efx, ...
> > > > >
> > > > > >   and there is no way for driver to find out when
> > > > > >   it actually took effect
> > > > >
> > > > > But we know rx mode is best effort e.g it doesn't support vhost and we
> > > > > survive from this for years.
> > > > >
> > > > > > - second, if device fails command, this is also not
> > > > > >   propagated to driver, again no way for driver to find out
> > > > > >
> > > > > > VDUSE needs to be fixed to do tricks to fix this
> > > > > > without breaking normal drivers.
> > > > >
> > > > > It's not specific to VDUSE. For example, when using virtio-net in the
> > > > > UP environment with any software cvq (like mlx5 via vDPA or cma
> > > > > transport).
> > > > >
> > > > > Thanks
> > > >
> > > > Hmm. Can we differentiate between these use-cases?
> > >
> > > It doesn't look easy since we are drivers for virtio bus. Underlayer
> > > details were hidden from virtio-net.
> > >
> > > Or do you have any ideas on this?
> > >
> > > Thanks
> >
> > I don't know, pass some kind of flag in struct virtqueue?
> >         "bool slow; /* This vq can be very slow sometimes. Don't wait for it! */"
> >
> > ?
> >
> 
> So if it's slow, sleep, otherwise poll?
> 
> I feel setting this flag might be tricky, since the driver doesn't
> know whether or not it's really slow. E.g smartNIC vendor may allow
> virtio-net emulation over PCI.
> 
> Thanks

driver will have the choice, depending on whether
vq is deterministic or not.


> > --
> > MST
> >

