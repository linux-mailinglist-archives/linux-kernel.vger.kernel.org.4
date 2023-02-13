Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B72694544
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjBMMIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBMMIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:08:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545259026
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676290002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1SXgBGYisUQ8diSE+v/6E4yyjWduJqYTQoW4hjh59pU=;
        b=NlLJnSdFlsIGQ1X8sWsUT4jboMsAdvdZy+h4+5Iy1mvRG3A7BuErGbSqCzYj85ePR1q0+l
        6x6Rqh2RA1BhvYx4fCL90uqY+wEc8tv9Pm6yUgpnnJJODnB3lZ/Wuby/DeWOBVfXdpOyc3
        birped3uo4kdtKT20j7XrbAq8WduQo4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-125-KQMOEamoOO23SlObruoCDw-1; Mon, 13 Feb 2023 07:03:21 -0500
X-MC-Unique: KQMOEamoOO23SlObruoCDw-1
Received: by mail-ed1-f71.google.com with SMTP id g25-20020aa7c859000000b004a3fe4cbb0cso7388601edt.17
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SXgBGYisUQ8diSE+v/6E4yyjWduJqYTQoW4hjh59pU=;
        b=etNSUagqfCx3rgu6ROEVisxG2TViVwZY/rm2EZVcnFio8q82RXHw/fhsGM5fgTBaCw
         7br1PqLG72b+E7Ut49X1zsJZLLkYW6JMB44RB98kpKPU0gxA46lOpL75z9JKMd/Al/db
         Wk8N4rh2Z2vMHTbMkebvENjnaSr4sRK4s1gvGDc2AXGbUWa3LGjHWo6xNP4c2oiaFyWE
         uuoY4vbwkqGVFIsr2O9T5TcfFcwa7V2kPlQNoYaJDCqk7xTJUNtNXqZa6SFZ38fX2niS
         P38OFmY+oxJPZuMzeN/PkkXw4SmgHZyRLXbcZtKrD4bXAX2SgRzpScXCOGW14XV60/Z2
         SRhQ==
X-Gm-Message-State: AO0yUKXU065+tyVbK7s0OfuChS2+IgSGGxMasuUd30t5w0+YEkw4+mpm
        BtakRozMy8NeAEB64hfS018Lzmfl2B6p53XnzmehshwTtzCvVnDDMiK41jteSmMRrwI7daL5phS
        ZE3y/xrI5ob6stRJUuh2gr+Ds
X-Received: by 2002:a17:907:3e0d:b0:8b1:d5c:986e with SMTP id hp13-20020a1709073e0d00b008b10d5c986emr4690553ejc.15.1676289800749;
        Mon, 13 Feb 2023 04:03:20 -0800 (PST)
X-Google-Smtp-Source: AK7set+tbCjGUeRdIebjg4KH94Xlrud5ePfcZiOsxW4hZEztVQmMNrBwQoh/ft2VBRBfQc7AvNql7A==
X-Received: by 2002:a17:907:3e0d:b0:8b1:d5c:986e with SMTP id hp13-20020a1709073e0d00b008b10d5c986emr4690522ejc.15.1676289800518;
        Mon, 13 Feb 2023 04:03:20 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906059300b0088f8803661asm6660033ejn.8.2023.02.13.04.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 04:03:19 -0800 (PST)
Date:   Mon, 13 Feb 2023 07:03:15 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, leiyang@redhat.com,
        Laurent Vivier <lvivier@redhat.com>, sgarzare@redhat.com,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        linux-kernel@vger.kernel.org, lulu@redhat.com,
        Gautam Dawar <gdawar@xilinx.com>, alvaro.karsz@solid-run.com,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Subject: Re: [PATCH 2/2] vringh: fetch used_idx from vring at
 vringh_init_iotlb
Message-ID: <20230213070248-mutt-send-email-mst@kernel.org>
References: <20230118164359.1523760-1-eperezma@redhat.com>
 <20230118164359.1523760-3-eperezma@redhat.com>
 <CACGkMEtq_ZOoLaS=vGYPZUc45oP8ENa+5H1KVCF1NS=-SwuPQw@mail.gmail.com>
 <CAJaqyWetovvndcU=pu_kPNUNYkgao=HsENnrKCzoHdK7RBjyAQ@mail.gmail.com>
 <CACGkMEvX5Li3c8oW2ARc0OAutfDK2=cckjuEf4KQRuNKfH1hfg@mail.gmail.com>
 <CAJaqyWeWaddX9KjZWs8n9eqx8u-Lk4Nj+VVH_jDh38URuZWJdA@mail.gmail.com>
 <CACGkMEubK3jRyKy5_TsRvKtcUQ2dYnr_hEnWwds4ZtewVsxz_Q@mail.gmail.com>
 <CAJaqyWcqnHAkUv9UZF=dOukg0C5u2g+eB-G5g8p+adcGZwRB_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWcqnHAkUv9UZF=dOukg0C5u2g+eB-G5g8p+adcGZwRB_Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 08:58:37AM +0100, Eugenio Perez Martin wrote:
> On Tue, Jan 31, 2023 at 4:16 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Jan 31, 2023 at 12:39 AM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Sun, Jan 29, 2023 at 7:01 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Thu, Jan 19, 2023 at 4:11 PM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Thu, Jan 19, 2023 at 4:20 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Jan 19, 2023 at 12:44 AM Eugenio Pérez <eperezma@redhat.com> wrote:
> > > > > > >
> > > > > > > Starting from an used_idx different than 0 is needed in use cases like
> > > > > > > virtual machine migration.  Not doing so and letting the caller set an
> > > > > > > avail idx different than 0 causes destination device to try to use old
> > > > > > > buffers that source driver already recover and are not available
> > > > > > > anymore.
> > > > > > >
> > > > > > > While callers like vdpa_sim set avail_idx directly it does not set
> > > > > > > used_idx.  Instead of let the caller do the assignment, fetch it from
> > > > > > > the guest at initialization like vhost-kernel do.
> > > > > > >
> > > > > > > To perform the same at vring_kernel_init and vring_user_init is left for
> > > > > > > the future.
> > > > > > >
> > > > > > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > > > > > ---
> > > > > > >  drivers/vhost/vringh.c | 25 +++++++++++++++++++++++--
> > > > > > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > > > > > > index 33eb941fcf15..0eed825197f2 100644
> > > > > > > --- a/drivers/vhost/vringh.c
> > > > > > > +++ b/drivers/vhost/vringh.c
> > > > > > > @@ -1301,6 +1301,17 @@ static inline int putused_iotlb(const struct vringh *vrh,
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > +/**
> > > > > > > + * vringh_update_used_idx - fetch used idx from driver's used split vring
> > > > > > > + * @vrh: The vring.
> > > > > > > + *
> > > > > > > + * Returns -errno or 0.
> > > > > > > + */
> > > > > > > +static inline int vringh_update_used_idx(struct vringh *vrh)
> > > > > > > +{
> > > > > > > +       return getu16_iotlb(vrh, &vrh->last_used_idx, &vrh->vring.used->idx);
> > > > > > > +}
> > > > > > > +
> > > > > > >  /**
> > > > > > >   * vringh_init_iotlb - initialize a vringh for a ring with IOTLB.
> > > > > > >   * @vrh: the vringh to initialize.
> > > > > > > @@ -1319,8 +1330,18 @@ int vringh_init_iotlb(struct vringh *vrh, u64 features,
> > > > > > >                       struct vring_avail *avail,
> > > > > > >                       struct vring_used *used)
> > > > > > >  {
> > > > > >
> > > > > > While at this, I wonder if it's better to have a dedicated parameter
> > > > > > for last_avail_idx?
> > > > > >
> > > > >
> > > > > I also had that thought. To directly assign last_avail_idx is not a
> > > > > specially elegant API IMO.
> > > > >
> > > > > Maybe expose a way to fetch used_idx from device vring and pass
> > > > > used_idx as parameter too?
> > > >
> > > > If I was not wrong, we can start from last_avail_idx, for used_idx it
> > > > is only needed for inflight descriptors which might require other
> > > > APIs?
> > > >
> > > > (All the current vDPA user of vringh is doing in order processing)
> > > >
> > >
> > > That was actually my first attempt and it works equally well for the
> > > moment, but it diverges from vhost-kernel behavior for little benefit.
> > >
> > > To assign both values at set_vring_base mean that if vDPA introduces
> > > an (hypothetical) VHOST_VDPA_F_INFLIGHT backend feature in the future,
> > > the initialization process would vary a lot:
> > > * Without that feature, the used_idx starts with 0, and the avail one
> > > is 0 or whatever value the user set with vring_set_base.
> > > * With that feature, the device will read guest's used_idx as
> > > vhost-kernel? We would enable a new ioctl to set it, or expand
> > > set_base to include used_idx, effectively diverting from vhost-kernel?
> >
> > Adding Longpeng who is looking at this.
> >
> 
> Sorry, I'll CC longpeng2@huawei.com in future series like this one.
> 
> > We can leave this to the caller to decide.
> >
> > Btw, a question, at which case the device used index does not equal to
> > the used index in the vring when the device is suspended? I think the
> > correct way is to flush the pending used indexes before suspending.
> > Otherwise we need an API to get pending used indices?
> >
> > >
> > > To me the wisest option is to move this with vhost-kernel. Maybe we
> > > need to add a feature bit to know that the hypervisor can trust the
> > > device will do "the right thing" (VHOST_VDPA_F_FETCH_USED_AT_ENABLE?),
> > > but we should keep it orthogonal to inflight descriptor migration in
> > > my opinion.
> >
> > I think we need to understand if there are any other possible use
> > cases for setting used idx other than inflight stuff.
> >
> 
> Answering this and the previous comment, I cannot think in any case
> outside of inflight migration. I'm just trying to avoid different
> behavior between vhost-kernel and vhost-vdpa, and to make features as
> orthogonal as possible.
> 
> > >
> > > Having said that, I'm totally ok to do it otherwise (or to expand the
> > > patch message if needed).
> >
> > I tend to do that in another series (not mix with the fixes).
> >
> > >
> > > > >
> > > > > > > -       return vringh_init_kern(vrh, features, num, weak_barriers,
> > > > > > > -                               desc, avail, used);
> > > > > > > +       int r = vringh_init_kern(vrh, features, num, weak_barriers, desc,
> > > > > > > +                                avail, used);
> > > > > > > +
> > > > > > > +       if (r != 0)
> > > > > > > +               return r;
> > > > > > > +
> > > > > > > +       /* Consider the ring not initialized */
> > > > > > > +       if ((void *)desc == used)
> > > > > > > +               return 0;
> > > > > >
> > > > > > I don't understand when we can get this (actually it should be a bug
> > > > > > of the caller).
> > > > > >
> > > > >
> > > > > You can see it in vdpasim_vq_reset.
> > > > >
> > > > > Note that to consider desc == 0 to be an uninitialized ring is a bug
> > > > > IMO. QEMU considers it that way also, but the standard does not forbid
> > > > > any ring to be at address 0. Especially if we use vIOMMU.
> > > > >
> > > > > So I think the best way to know if we can use the vringh is either
> > > > > this way, or provide an explicit "initialized" boolean attribute.
> > > > > Maybe a new "bool is_initialized(vrh)" is enough, if we don't want to
> > > > > add new attributes.
> > > >
> > > > I wonder if we can avoid this in the simulator level instead of the
> > > > vringh (anyhow it only exposes a vringh_init_xxx() helper now).
> > > >
> > >
> > > In my opinion that is a mistake if other drivers will use it to
> > > implement the emulated control virtqueue. And it requires more
> > > changes. But it is doable for sure.
> >
> > The problem is, there's no reset API in vringh, that's why you need to
> > do if ((void *)desc == used) which depends on behaviour of the vringh
> > user.
> >
> 
> That's a very good point indeed.
> 
> > So I think we should either:
> >
> > 1) move that check in vdpa_sim (since it's not guaranteed that all the
> > vringh users will make desc equal to used during reset)
> >
> > or
> >
> > 2) introduce a vringh_reset_xxx()
> >
> > 1) seems a good step for -stable.
> >
> 
> We can go to 1 for sure. So let's set last_used_idx at
> vdpasim_set_vq_state, same value as last_avail_idx, and stash it at
> vdpasim_queue_ready.
> 
> Do I need to resend the previous patch in this series?
> 
> Do we need to offer a new feature flag indicating we will set used_idx
> with avail_idx?
> 
> Thanks!

Jason did you forget to answer or did I miss it?

