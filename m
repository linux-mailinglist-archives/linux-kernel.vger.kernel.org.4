Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47C76A8873
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCBSUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCBSUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:20:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EE741B42
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 10:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677781199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=08ij22MNfZ9u3+wCNpzXsusFP6zZwihMc8avaihmWHc=;
        b=YQzcGaMFJMayqQb7A5yMYGH3VcKmftUarJkriicB1HAoMMGXjkPgaOOTyHAcv0CaBsT6tv
        WO7J1U2U1F3WnG15hUAmadbrTrU15YEEF1WO7E+tmHSAZMwxAd8LXuZOVM03UUpLctHrt4
        1SKw+m/e2mcGzCujvet9eOYfTfKgclc=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-355-YU6uV6k0Ma2HXxQpqyIPIg-1; Thu, 02 Mar 2023 13:19:57 -0500
X-MC-Unique: YU6uV6k0Ma2HXxQpqyIPIg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-536a5a0b6e3so326692797b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 10:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677781197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08ij22MNfZ9u3+wCNpzXsusFP6zZwihMc8avaihmWHc=;
        b=5fmSxCB5d7n2YMUJGCOA3EQmC8UKRDCTlK5oMpOyPbVSwfwZNnrBKTXdOvdMuIN3iE
         gjkuW36+BLnAkEefoYGkaqfIOIlEq+pBiIcGc9axihWXZoDCLS5d1TH6K8E2cOhesjiR
         covgksxVmVLvFKfDG2nZq3ACcwwU3Xueg6RhIX0aZRP3SjAlZ71Jwelk+avwmiSPSVFO
         xvVbLptY9RN+0noVdVYF+3dBCAe4JmswzVwIEV4l6MmS83s81WqGKaW9FUq0MieE8L5w
         8ZiPVDklaSGSW4jH9LByviQNBh0PGwcbX6WATjfhtku2LvE3LMzVJr+BHzPM0puP5Ekb
         qJDg==
X-Gm-Message-State: AO0yUKW8iR2MkatTejnzTmi05w757MUG5wLJi5/Iz2Sft1adS94MwN+u
        Yx8BDdCEF0sdcsnAcM21OH1YCVRAuYe4VZBWTrteVcwrLmrjVKwbFqk8IfxwlpWmMDzronrU+dk
        O9ka6z3dizwMddSYCQEXvyomjWTR5dC8t6v4aMGs2
X-Received: by 2002:a81:ad14:0:b0:53c:6fdb:2629 with SMTP id l20-20020a81ad14000000b0053c6fdb2629mr3948194ywh.6.1677781197086;
        Thu, 02 Mar 2023 10:19:57 -0800 (PST)
X-Google-Smtp-Source: AK7set+1i7QAKt+1HQRwaQ2yVsJ6sxoqAfoC+mZ+0A79+57bmzoQ5wlDBd8it0c1uAAWe9FY86GYdB18952n4S6e3Ds=
X-Received: by 2002:a81:ad14:0:b0:53c:6fdb:2629 with SMTP id
 l20-20020a81ad14000000b0053c6fdb2629mr3948186ywh.6.1677781196763; Thu, 02 Mar
 2023 10:19:56 -0800 (PST)
MIME-Version: 1.0
References: <20230203142501.300125-1-eperezma@redhat.com> <20230228105628.lwd4l2nw6isfjc7c@sgarzare-redhat>
In-Reply-To: <20230228105628.lwd4l2nw6isfjc7c@sgarzare-redhat>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 2 Mar 2023 19:19:20 +0100
Message-ID: <CAJaqyWcNO+McdRaHwe4ZV=jo-0n1AVgiRdNFh5J2Hq20qMJr1g@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa_sim: set last_used_idx as last_avail_idx in vdpasim_queue_ready
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     mst@redhat.com, lulu@redhat.com,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        leiyang@redhat.com, Gautam Dawar <gdawar@xilinx.com>,
        Eli Cohen <elic@nvidia.com>, longpeng2@huawei.com,
        parav@nvidia.com, linux-kernel@vger.kernel.org,
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

On Tue, Feb 28, 2023 at 11:56 AM Stefano Garzarella <sgarzare@redhat.com> w=
rote:
>
> On Fri, Feb 03, 2023 at 03:25:01PM +0100, Eugenio P=C3=A9rez wrote:
> >Starting from an used_idx different than 0 is needed in use cases like
> >virtual machine migration.  Not doing so and letting the caller set an
> >avail idx different than 0 causes destination device to try to use old
> >buffers that source driver already recover and are not available
> >anymore.
> >
> >Since vdpa_sim does not support receive inflight descriptors as a
> >destination of a migration, let's set both avail_idx and used_idx the
> >same at vq start.  This is how vhost-user works in a
> >VHOST_SET_VRING_BASE call.
> >
> >Although the simple fix is to set last_used_idx at vdpasim_set_vq_state,
> >it would be reset at vdpasim_queue_ready.  The last_avail_idx case is
> >fixed with commit a09f493c ("vdpa_sim: not reset state in
> >vdpasim_queue_ready").  Since the only option is to make it equal to
> >last_avail_idx, adding the only change needed here.
> >
> >This was discovered and tested live migrating the vdpa_sim_net device.
> >
> >Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> >Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >---
> >Cherry-picked from patch 2/2 of the series [1]. Differences are:
> >* Set the value of used_idx at vdpasim_queue_ready instead of fetching
> >  from the guest vring like vhost-kernel.
> >
> >v2: Actually update last_used_idx only at vdpasim_queue_ready.
> >
> >Note that commit id present in the patch text is not in master but in
> >git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.
> >
> >[1] https://lkml.org/lkml/2023/1/18/1041
> >---
> > drivers/vdpa/vdpa_sim/vdpa_sim.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vd=
pa_sim.c
> >index 6a0a65814626..79ac585e40b9 100644
> >--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >@@ -68,6 +68,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasi=
m, unsigned int idx)
> >                         (uintptr_t)vq->device_addr);
> >
> >       vq->vring.last_avail_idx =3D last_avail_idx;
> >+      vq->vring.last_used_idx =3D last_avail_idx;
> >       vq->vring.notify =3D vdpasim_vq_notify;
> > }
> >
> >-- 2.31.1
> >
>
> If you need to resend, I'd add a comment in the code following the
> commit description.
>
> Anyway, the patch LGTM:
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>

Added in v3, thanks for the review!

> Thanks,
> Stefano
>

