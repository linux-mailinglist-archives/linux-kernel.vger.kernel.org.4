Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D9C6FD63A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbjEJFdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJFdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:33:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2275F2688
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 22:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683696782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CfR3pdTnrmVcxjx1/XCpuBAbDSlJT7L6QiQpFvOxED0=;
        b=BSx6gP9MiDLr9IJcrQvxP7BF3YI4CsJveJSJpa2ybBHspYUUCXUmD7kDjg0nr7U8G48NRN
        EVxdZAmcEIZBeuCSq9pXlYXuGtdDTuxj8E8A56v/C6nWpyivQXQ0wPiQxB3x594zZnoAcl
        8p3GAyE6+4zIYMusqy0nkefkpwfRLRI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-fXh1mayuPVyCE5ZsK3VhAw-1; Wed, 10 May 2023 01:33:01 -0400
X-MC-Unique: fXh1mayuPVyCE5ZsK3VhAw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50bc6c6b9dbso10736384a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 22:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683696780; x=1686288780;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfR3pdTnrmVcxjx1/XCpuBAbDSlJT7L6QiQpFvOxED0=;
        b=A3PxizlxUVF3GRB83V2f/YalUHvFdxSnKFrEWhvcMUKWQVT9h7IwsBurZnQrV+9GbM
         tCVWvDWocSFGncZP9SxJav6z0kMqj+0Herw+lLpzGPit8u0XYJjeVWgwl5QArLU1EzDn
         rwJa2sr9xd7Qpt93yoEX897WmkFoo9L7BPOz/2Lvgla3aToGmhReWRLTmul/qs+n1d8U
         CR8CytdOgZkNmksFb6beidLfScgv0HoRbHnXuQ8AoP/r+Q6wGg/kg8DSMGN03X1uBYQw
         /sMPZm3Asu3NUByyyasrpZFY9kHqhoTZ1gPl6KU/Hg+RA+jVhNq5Xtke/9cYTvnyFnmx
         fgYA==
X-Gm-Message-State: AC+VfDy5u0j4D0+eF7bPODAbo1WFAV4ucOn6SmDCmjhe6XUryAUe2JOe
        WWCGFjfhoKvDLh7siiTUNVXG+kdoPO9DFUhll5fbJCdcTvYrmFNGG3qm4xrGMD+T+QlRLfmfnIT
        mf61ZZncdkJxtTsVTIunuI7UI
X-Received: by 2002:a05:6402:3587:b0:50c:1603:654 with SMTP id y7-20020a056402358700b0050c16030654mr14748674edc.16.1683696779947;
        Tue, 09 May 2023 22:32:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6V4Bg09XaNc7Uq/10va+cr/YvgkAVnRjG5KK8NmISXyPQ+XKlfBDvcGuJ6+QR7dyAWLxXywg==
X-Received: by 2002:a05:6402:3587:b0:50c:1603:654 with SMTP id y7-20020a056402358700b0050c16030654mr14748657edc.16.1683696779652;
        Tue, 09 May 2023 22:32:59 -0700 (PDT)
Received: from redhat.com ([176.119.195.36])
        by smtp.gmail.com with ESMTPSA id sa40-20020a1709076d2800b00965d4b2bd4csm2230865ejc.141.2023.05.09.22.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 22:32:58 -0700 (PDT)
Date:   Wed, 10 May 2023 01:32:53 -0400
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
Message-ID: <20230510012951-mutt-send-email-mst@kernel.org>
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-2-jasowang@redhat.com>
 <20230413121525-mutt-send-email-mst@kernel.org>
 <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
 <20230414031947-mutt-send-email-mst@kernel.org>
 <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 11:40:58AM +0800, Jason Wang wrote:
> On Fri, Apr 14, 2023 at 3:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Apr 14, 2023 at 01:04:15PM +0800, Jason Wang wrote:
> > > Forget to cc netdev, adding.
> > >
> > > On Fri, Apr 14, 2023 at 12:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Apr 13, 2023 at 02:40:26PM +0800, Jason Wang wrote:
> > > > > This patch convert rx mode setting to be done in a workqueue, this is
> > > > > a must for allow to sleep when waiting for the cvq command to
> > > > > response since current code is executed under addr spin lock.
> > > > >
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > >
> > > > I don't like this frankly. This means that setting RX mode which would
> > > > previously be reliable, now becomes unreliable.
> > >
> > > It is "unreliable" by design:
> > >
> > >       void                    (*ndo_set_rx_mode)(struct net_device *dev);
> > >
> > > > - first of all configuration is no longer immediate
> > >
> > > Is immediate a hard requirement? I can see a workqueue is used at least:
> > >
> > > mlx5e, ipoib, efx, ...
> > >
> > > >   and there is no way for driver to find out when
> > > >   it actually took effect
> > >
> > > But we know rx mode is best effort e.g it doesn't support vhost and we
> > > survive from this for years.
> > >
> > > > - second, if device fails command, this is also not
> > > >   propagated to driver, again no way for driver to find out
> > > >
> > > > VDUSE needs to be fixed to do tricks to fix this
> > > > without breaking normal drivers.
> > >
> > > It's not specific to VDUSE. For example, when using virtio-net in the
> > > UP environment with any software cvq (like mlx5 via vDPA or cma
> > > transport).
> > >
> > > Thanks
> >
> > Hmm. Can we differentiate between these use-cases?
> 
> It doesn't look easy since we are drivers for virtio bus. Underlayer
> details were hidden from virtio-net.
> 
> Or do you have any ideas on this?
> 
> Thanks

I don't know, pass some kind of flag in struct virtqueue?
	"bool slow; /* This vq can be very slow sometimes. Don't wait for it! */"

?

-- 
MST

