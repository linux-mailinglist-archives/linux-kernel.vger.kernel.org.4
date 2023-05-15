Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29C0702A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbjEOKTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjEOKTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:19:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D991026A4
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684145845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2F2MmPR6uvyF/S479nyiadAjTsmEszXcVeYTAPUBtGg=;
        b=CWh5CC+Vf1gPzx/i12ZKDR+BErB7C6MFXlQkRsU4A4CB97BynHajYvT4I+CWqVRg0QA0Zz
        9AjGzUfQFRo2fLN2i0n9Swhg8zUd/Ui/x4wXObYXENhfF7BPSC9LpyFFvL4rwUONpmXM+1
        MJoX1SbRCVeXRzXMHSBLkxEBt3twmy8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-uRvUeaFUM-y7cEftCTLcjA-1; Mon, 15 May 2023 06:17:24 -0400
X-MC-Unique: uRvUeaFUM-y7cEftCTLcjA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f433a2308bso117007295e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684145842; x=1686737842;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2F2MmPR6uvyF/S479nyiadAjTsmEszXcVeYTAPUBtGg=;
        b=C5iGhvT8a+OwmtzlrUyKLJItjoI84bbYI1xTJbd2dF7+k4j089rPrTzVKxUopx3shb
         G60dLDtqGap2iZ7U+XIYI8tEjE/oYi+leTxEzzfKvmtJHbgIKMq5rN2msqSnEugs4Ygl
         Nx37IKhajMIyeOyId32jfPpbF+9GOGjoiDE9rGwduqpuv//c+6PX+IL2S3OeYVi8cpwt
         K+Yf0ReueJ8TwqLbTHkwhOLxyLHp0Ipz32j/iwQEIXjrL4yus7wulCPcRIf0oxL1j/o8
         o+PkTcbMe59zIHcc//+l78zzev5b3Zgs1lIwXXC9gF+uT1dfbFvOOiIAJOVm8X3+aV+q
         vFUQ==
X-Gm-Message-State: AC+VfDwnoVF+gsO1g4IjsIoo64HXskrsV8rnMu2bxhQnTJ9NL317PUKw
        gB6hqpBIuV31mFhAyqn6ccBuBmT/Sni8ANd5Q2/offiyS/F3H9nsqJ1ybEgV9oHQTw8jKEXRH5U
        J5G1RlWGRjlIfakzQhEHjs3vc
X-Received: by 2002:a7b:cd8c:0:b0:3f4:2775:b45c with SMTP id y12-20020a7bcd8c000000b003f42775b45cmr16135078wmj.3.1684145842254;
        Mon, 15 May 2023 03:17:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5cjHf8wpirqMKODDcwtxNOIU7NCNEa+K+k2xQTKz5Pl8QX6uaHXd7dJ3fMMgRsMfUs2i6A+g==
X-Received: by 2002:a7b:cd8c:0:b0:3f4:2775:b45c with SMTP id y12-20020a7bcd8c000000b003f42775b45cmr16135056wmj.3.1684145841868;
        Mon, 15 May 2023 03:17:21 -0700 (PDT)
Received: from redhat.com ([2.52.26.5])
        by smtp.gmail.com with ESMTPSA id a6-20020a1cf006000000b003f0aefcc457sm36542703wmb.45.2023.05.15.03.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 03:17:21 -0700 (PDT)
Date:   Mon, 15 May 2023 06:17:17 -0400
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
Message-ID: <20230515061455-mutt-send-email-mst@kernel.org>
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-2-jasowang@redhat.com>
 <20230413121525-mutt-send-email-mst@kernel.org>
 <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
 <20230414031947-mutt-send-email-mst@kernel.org>
 <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
 <20230510012951-mutt-send-email-mst@kernel.org>
 <CACGkMEszPydzw_MOUOVJKBBW_8iYn66i_9OFvLDoZMH34hMx=w@mail.gmail.com>
 <20230515004422-mutt-send-email-mst@kernel.org>
 <CACGkMEv+Q2UoBarNOzKSrc3O=Wb2_73O2j9cZXFdAiLBm1qY-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv+Q2UoBarNOzKSrc3O=Wb2_73O2j9cZXFdAiLBm1qY-Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 01:13:33PM +0800, Jason Wang wrote:
> On Mon, May 15, 2023 at 12:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, May 15, 2023 at 09:05:54AM +0800, Jason Wang wrote:
> > > On Wed, May 10, 2023 at 1:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Apr 17, 2023 at 11:40:58AM +0800, Jason Wang wrote:
> > > > > On Fri, Apr 14, 2023 at 3:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Apr 14, 2023 at 01:04:15PM +0800, Jason Wang wrote:
> > > > > > > Forget to cc netdev, adding.
> > > > > > >
> > > > > > > On Fri, Apr 14, 2023 at 12:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Apr 13, 2023 at 02:40:26PM +0800, Jason Wang wrote:
> > > > > > > > > This patch convert rx mode setting to be done in a workqueue, this is
> > > > > > > > > a must for allow to sleep when waiting for the cvq command to
> > > > > > > > > response since current code is executed under addr spin lock.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > >
> > > > > > > > I don't like this frankly. This means that setting RX mode which would
> > > > > > > > previously be reliable, now becomes unreliable.
> > > > > > >
> > > > > > > It is "unreliable" by design:
> > > > > > >
> > > > > > >       void                    (*ndo_set_rx_mode)(struct net_device *dev);
> > > > > > >
> > > > > > > > - first of all configuration is no longer immediate
> > > > > > >
> > > > > > > Is immediate a hard requirement? I can see a workqueue is used at least:
> > > > > > >
> > > > > > > mlx5e, ipoib, efx, ...
> > > > > > >
> > > > > > > >   and there is no way for driver to find out when
> > > > > > > >   it actually took effect
> > > > > > >
> > > > > > > But we know rx mode is best effort e.g it doesn't support vhost and we
> > > > > > > survive from this for years.
> > > > > > >
> > > > > > > > - second, if device fails command, this is also not
> > > > > > > >   propagated to driver, again no way for driver to find out
> > > > > > > >
> > > > > > > > VDUSE needs to be fixed to do tricks to fix this
> > > > > > > > without breaking normal drivers.
> > > > > > >
> > > > > > > It's not specific to VDUSE. For example, when using virtio-net in the
> > > > > > > UP environment with any software cvq (like mlx5 via vDPA or cma
> > > > > > > transport).
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > Hmm. Can we differentiate between these use-cases?
> > > > >
> > > > > It doesn't look easy since we are drivers for virtio bus. Underlayer
> > > > > details were hidden from virtio-net.
> > > > >
> > > > > Or do you have any ideas on this?
> > > > >
> > > > > Thanks
> > > >
> > > > I don't know, pass some kind of flag in struct virtqueue?
> > > >         "bool slow; /* This vq can be very slow sometimes. Don't wait for it! */"
> > > >
> > > > ?
> > > >
> > >
> > > So if it's slow, sleep, otherwise poll?
> > >
> > > I feel setting this flag might be tricky, since the driver doesn't
> > > know whether or not it's really slow. E.g smartNIC vendor may allow
> > > virtio-net emulation over PCI.
> > >
> > > Thanks
> >
> > driver will have the choice, depending on whether
> > vq is deterministic or not.
> 
> Ok, but the problem is, such booleans are only useful for virtio ring
> codes. But in this case, virtio-net knows what to do for cvq. So I'm
> not sure who the user is.
> 
> Thanks

Circling back, what exactly does the architecture you are trying
to fix look like? Who is going to introduce unbounded latency?
The hypervisor? If so do we not maybe want a new feature bit
that documents this? Hypervisor then can detect old guests
that spin and decide what to do, e.g. prioritise cvq more,
or fail FEATURES_OK.

> >
> >
> > > > --
> > > > MST
> > > >
> >

