Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027336A8874
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCBSVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCBSVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:21:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0165056793
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 10:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677781233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zwu6siX51Sx+jV6fphFzEZqVIx1UGmcNzvqx/+gJ8D4=;
        b=SQ3K7dwYTi/MkmJ88XwN5Eww16uSeCOA8a5NudnD2kUNpIXaP6UdgrmP8Z6YZMIs2nyvn7
        eytu02Dbo+Npd2swABl67KtCVFOuqGdHOLIRyQWBjSjJo+LSvUsQzcV8DsI+N7yDu9903F
        ASC7TVPqkecZnt3LsaVNBDRa7zDA+Bk=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-lgNN-7NZP5ux5IEwTY_kAA-1; Thu, 02 Mar 2023 13:20:32 -0500
X-MC-Unique: lgNN-7NZP5ux5IEwTY_kAA-1
Received: by mail-yb1-f199.google.com with SMTP id c192-20020a25c0c9000000b0092aabd4fa90so4922251ybf.18
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 10:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677781231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwu6siX51Sx+jV6fphFzEZqVIx1UGmcNzvqx/+gJ8D4=;
        b=sVjyi/yl5pdKwjRp2ctMsaGYAxAmQ8Z8Ll+O0HpUxeM2AAnWCNHJPQtjXHkalG415t
         DPRAH6x3kg0Kvp2f4v/NRuq+w6ikKZMH7uy2jjadYlddOSCHYmV2IbOFUAqSRhykcRo3
         w9ya4Kc319JgIRQCsVX6DfCmRbVbtNr7w/5Oo1iYtXvT4pqZrKX5rxiJuaVubCoaKJjv
         x6VBn3785MJdeCaK1AMF8mTnljDrABQVFOvg2ByKnAlYseOUbAtacCaZki9MUrPsFQkc
         8OqjsGDIOwuaAFRJrro+sV1wWgWthUMdXe5UzYChrXqu6COWSMjiCJIjzeqRVeWQQi0+
         nTeA==
X-Gm-Message-State: AO0yUKWbphbyUol2kmjUcs6O+XS2RgCq9gr+MVEB18Nq7sHn42TfPLnQ
        4AT7DBUiw162ICvaguAuIJ7sbkQAhZmuQwfajOqi8J7qd6vSUmZvTECSxEs6o0HA9MxQmRKX2nW
        XimpGsl9uB5RK99FotlbynCWQSxJDczoSWh0H5DyaJX3BZ3Mp
X-Received: by 2002:a81:ae24:0:b0:52e:b48f:7349 with SMTP id m36-20020a81ae24000000b0052eb48f7349mr5345752ywh.6.1677781231456;
        Thu, 02 Mar 2023 10:20:31 -0800 (PST)
X-Google-Smtp-Source: AK7set/NyT5OxQwUDgiRdA4ewLAQ1LhRtmuu3s+ZeylMuM0jBrrWScji41Fk7liqls858pllMiwIPi23gCnZ7dEUCsg=
X-Received: by 2002:a81:ae24:0:b0:52e:b48f:7349 with SMTP id
 m36-20020a81ae24000000b0052eb48f7349mr5345742ywh.6.1677781231228; Thu, 02 Mar
 2023 10:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20230203142501.300125-1-eperezma@redhat.com> <20230228071109-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230228071109-mutt-send-email-mst@kernel.org>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 2 Mar 2023 19:19:55 +0100
Message-ID: <CAJaqyWcc8pxG-0uakdrvu5_xFAU+yZF7vYHMr-bTHvZEpJVGDA@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa_sim: set last_used_idx as last_avail_idx in vdpasim_queue_ready
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     lulu@redhat.com, virtualization@lists.linux-foundation.org,
        si-wei.liu@oracle.com, leiyang@redhat.com,
        Gautam Dawar <gdawar@xilinx.com>, Eli Cohen <elic@nvidia.com>,
        longpeng2@huawei.com, parav@nvidia.com,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        alvaro.karsz@solid-run.com, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 1:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Feb 03, 2023 at 03:25:01PM +0100, Eugenio P=C3=A9rez wrote:
> > Starting from an used_idx different than 0 is needed in use cases like
> > virtual machine migration.  Not doing so and letting the caller set an
> > avail idx different than 0 causes destination device to try to use old
> > buffers that source driver already recover and are not available
> > anymore.
> >
> > Since vdpa_sim does not support receive inflight descriptors as a
> > destination of a migration, let's set both avail_idx and used_idx the
> > same at vq start.  This is how vhost-user works in a
> > VHOST_SET_VRING_BASE call.
> >
> > Although the simple fix is to set last_used_idx at vdpasim_set_vq_state=
,
> > it would be reset at vdpasim_queue_ready.  The last_avail_idx case is
> > fixed with commit a09f493c ("vdpa_sim: not reset state in
> > vdpasim_queue_ready").  Since the only option is to make it equal to
> > last_avail_idx, adding the only change needed here.
> >
> > This was discovered and tested live migrating the vdpa_sim_net device.
> >
> > Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > Cherry-picked from patch 2/2 of the series [1]. Differences are:
> > * Set the value of used_idx at vdpasim_queue_ready instead of fetching
> >   from the guest vring like vhost-kernel.
> >
> > v2: Actually update last_used_idx only at vdpasim_queue_ready.
> >
> > Note that commit id present in the patch text is not in master but in
> > git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.
> >
> > [1] https://lkml.org/lkml/2023/1/18/1041
>
>
> Can you post with a fixed hash please?
>

Sent v3, please let me know if I need to do further modifications.

Thanks!

> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/v=
dpa_sim.c
> > index 6a0a65814626..79ac585e40b9 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > @@ -68,6 +68,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpas=
im, unsigned int idx)
> >                         (uintptr_t)vq->device_addr);
> >
> >       vq->vring.last_avail_idx =3D last_avail_idx;
> > +     vq->vring.last_used_idx =3D last_avail_idx;
> >       vq->vring.notify =3D vdpasim_vq_notify;
> >  }
> >
> > --
> > 2.31.1
>

