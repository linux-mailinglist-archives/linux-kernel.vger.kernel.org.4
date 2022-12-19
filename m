Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFC5650788
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLSGYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiLSGYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:24:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8BE2AE8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 22:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671431032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ohf8zY/aWMcSPR1xSFDFYuLDJlIH0hSLiTuHM0f70LU=;
        b=BN4EisM2EIHRNZsMQMQYVh7cwUoPpWCMFI6ToQP/bxCTBpEkUizYWxhnO7z6spodIDRmvw
        CFZSRDWpmuOEdIgJoFW6EsfT9Ytir8Gy6M9cH0DkBIC2kLPI9hCq1bgOVycjQ7RS0/f4Yx
        TwBaX1miRp9+SeGDiIf6hNKjdnyy03k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-Rpyu96yHP6mltUu1qshCOg-1; Mon, 19 Dec 2022 01:23:50 -0500
X-MC-Unique: Rpyu96yHP6mltUu1qshCOg-1
Received: by mail-qt1-f199.google.com with SMTP id fg11-20020a05622a580b00b003a7eaa5cb47so3612260qtb.15
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 22:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ohf8zY/aWMcSPR1xSFDFYuLDJlIH0hSLiTuHM0f70LU=;
        b=X7aNjROMIsX27LsRSWhrH6/t83uRi+To1PwA2uszuFDRoYktIgiCProctKOTkk9EMt
         ArgNrl7hr1LUx2SuYt7p5jUutARVn5hSI5jQMm3e3zvWlMwF0cCTAIL81TjBiivVJNz6
         S1CU3vP+X3ceNVR6a1X1XjYw95mtttx+VqMWJKhJlabxpXf+49H8O/3sq95eOwUQEYO0
         53TW1mzBClw2yQiPpo2BXH3Sod1PKoQ2x0qGuxW+1t0JBkGo5F210oxncpz+nWS5iVx2
         /ctZutoEWxvgWidrm0K2/aeSzOfh8U/A0wkStIZ97jy66dgEmsh9DFW/m+92iTtjTH8H
         iYwA==
X-Gm-Message-State: ANoB5pn0IkOYYqKxyN4Qn351d3W5viQMTjS4GhUTr3uH9Urnjx1JnHhI
        WclIV62Oy1pO8VEV6sM1L4fvHAM2fCdHoemn2tSKGp8ru2yI+k9WUnbk0392EZUvZUHfYTqxldR
        ud7XLl7NV+sEsfH7xKlh1JJKu
X-Received: by 2002:a05:622a:248c:b0:3a5:2e1d:74c2 with SMTP id cn12-20020a05622a248c00b003a52e1d74c2mr56118190qtb.39.1671431030234;
        Sun, 18 Dec 2022 22:23:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7ZJW3qjSiZ4BtuejaknalDMwumFr2wJTzJxFC1VNHtxV8+pQbD/YcHQRfrW5Zz5w5UshwccQ==
X-Received: by 2002:a05:622a:248c:b0:3a5:2e1d:74c2 with SMTP id cn12-20020a05622a248c00b003a52e1d74c2mr56118174qtb.39.1671431029974;
        Sun, 18 Dec 2022 22:23:49 -0800 (PST)
Received: from redhat.com ([45.144.113.29])
        by smtp.gmail.com with ESMTPSA id a19-20020ac85b93000000b003a611cb2a95sm5762676qta.9.2022.12.18.22.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 22:23:49 -0800 (PST)
Date:   Mon, 19 Dec 2022 01:23:44 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     sebastien.boeuf@intel.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, eperezma@redhat.com
Subject: Re: [PATCH v5 4/4] vdpa_sim: Implement resume vdpa op
Message-ID: <20221219012313-mutt-send-email-mst@kernel.org>
References: <cover.1666796792.git.sebastien.boeuf@intel.com>
 <d8c405c150c6eb25acab58718c38e0ef4c3c0293.1666796792.git.sebastien.boeuf@intel.com>
 <CACGkMEt93LU009MVK3cDKAU1fv3ZoaDskWp4hakmeTZyBQa=fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEt93LU009MVK3cDKAU1fv3ZoaDskWp4hakmeTZyBQa=fg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:43:54PM +0800, Jason Wang wrote:
> On Wed, Oct 26, 2022 at 11:09 PM <sebastien.boeuf@intel.com> wrote:
> >
> > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> >
> > Implement resume operation for vdpa_sim devices, so vhost-vdpa will
> > offer that backend feature and userspace can effectively resume the
> > device.
> >
> > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c | 28 ++++++++++++++++++++++++++++
> >  drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > index b071f0d842fb..84fee8bb2929 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > @@ -357,6 +357,11 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
> >         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> >         struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
> >
> > +       if (!vdpasim->running) {
> > +               vdpasim->pending_kick = true;
> > +               return;
> 
> I think we may hit here when the driver kicks vq before DRIVER_OK. Do
> we need to check device status in this case and resume?
> 
> Thanks

Sebastien did you forget to reply here?

> > +       }
> > +
> >         if (vq->ready)
> >                 schedule_work(&vdpasim->work);
> >  }
> > @@ -527,6 +532,27 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
> >         return 0;
> >  }
> >
> > +static int vdpasim_resume(struct vdpa_device *vdpa)
> > +{
> > +       struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > +       int i;
> > +
> > +       spin_lock(&vdpasim->lock);
> > +       vdpasim->running = true;
> > +
> > +       if (vdpasim->pending_kick) {
> > +               /* Process pending descriptors */
> > +               for (i = 0; i < vdpasim->dev_attr.nvqs; ++i)
> > +                       vdpasim_kick_vq(vdpa, i);
> > +
> > +               vdpasim->pending_kick = false;
> > +       }
> > +
> > +       spin_unlock(&vdpasim->lock);
> > +
> > +       return 0;
> > +}
> > +
> >  static size_t vdpasim_get_config_size(struct vdpa_device *vdpa)
> >  {
> >         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > @@ -717,6 +743,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
> >         .set_status             = vdpasim_set_status,
> >         .reset                  = vdpasim_reset,
> >         .suspend                = vdpasim_suspend,
> > +       .resume                 = vdpasim_resume,
> >         .get_config_size        = vdpasim_get_config_size,
> >         .get_config             = vdpasim_get_config,
> >         .set_config             = vdpasim_set_config,
> > @@ -750,6 +777,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
> >         .set_status             = vdpasim_set_status,
> >         .reset                  = vdpasim_reset,
> >         .suspend                = vdpasim_suspend,
> > +       .resume                 = vdpasim_resume,
> >         .get_config_size        = vdpasim_get_config_size,
> >         .get_config             = vdpasim_get_config,
> >         .set_config             = vdpasim_set_config,
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > index 0e78737dcc16..a745605589e2 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > @@ -67,6 +67,7 @@ struct vdpasim {
> >         u64 features;
> >         u32 groups;
> >         bool running;
> > +       bool pending_kick;
> >         /* spinlock to synchronize iommu table */
> >         spinlock_t iommu_lock;
> >  };
> > --
> > 2.34.1
> >
> > ---------------------------------------------------------------------
> > Intel Corporation SAS (French simplified joint stock company)
> > Registered headquarters: "Les Montalets"- 2, rue de Paris,
> > 92196 Meudon Cedex, France
> > Registration Number:  302 456 199 R.C.S. NANTERRE
> > Capital: 5 208 026.16 Euros
> >
> > This e-mail and any attachments may contain confidential material for
> > the sole use of the intended recipient(s). Any review or distribution
> > by others is strictly prohibited. If you are not the intended
> > recipient, please contact the sender and delete all copies.
> >

