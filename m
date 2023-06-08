Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9D472791D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjFHHrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjFHHq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:46:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F47226B5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686210375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4jks4xbNwfyNEVL0zypzxaGA+rFgT4ZCRcn8JM16ug=;
        b=Kk+wMU9CIPPuF/9WI+QIbgj2KEAc4RaRlmEEuVhMGJRDiZpcCqGORWLeA8hfktuRf4ECQn
        wzrrbnGYXT75Eep6+Ik/G3TJZTHrFP46zL9hVUL/t4t6t9G45dxeSO5yBK6BUXcHyfXSPB
        AjCzLLkoWY9ApQTmY8z0G7Ub/vggLpE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-_fZIhaKMO9KRdHsbBexIUg-1; Thu, 08 Jun 2023 03:46:14 -0400
X-MC-Unique: _fZIhaKMO9KRdHsbBexIUg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b1d8fa4629so1456951fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686210373; x=1688802373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4jks4xbNwfyNEVL0zypzxaGA+rFgT4ZCRcn8JM16ug=;
        b=MgYJR5RoJ3x1AfKnGTXrU7fUW0CLMylPnGCpQzCSo3zEU/ReVuzYkMS1WY6W1Qs+vc
         XBLb/XDN3DMqUYZlIRbP+nrVuyvskdAaKxVQSxVkQsP7CjgyakQ3MU3NZdpiitxsR8At
         15A47pyaKtTmz0PjnQ+kfpqjoEsx6qMpNnczrdtK7CfoiJqHty914UUWiTlJjeZjCoOw
         SOn+WxLkZrKLq1982T2YzZbWXnOrQm1T9zIfBLsTK094FtXLTI9NXvrf1n0BvLROv5HA
         MYKsvoFIPDt9QncxXc9Ux/Tcwq3IsuhnQlfVBHP0mTJQUQvIW/4Yh0cXPuOrzP4BpLb6
         0A/w==
X-Gm-Message-State: AC+VfDwNRrJ5KHqr8DZ6xKM8cFSU6DpLOzniOFJL6AWGzfYEKe9XwgSt
        zjdLt/qzBKylTx4Xt51+YLeBcW4oS+lZgMcwJnrXI2NyjbstnC9g42SCBeKfaOpneHY34v+ec0G
        B/7c18R6BQtBCJvRaDWwgLO1MjH/zUBW8POcSHuAA
X-Received: by 2002:a2e:8012:0:b0:2b2:90e:165d with SMTP id j18-20020a2e8012000000b002b2090e165dmr1082554ljg.2.1686210372776;
        Thu, 08 Jun 2023 00:46:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63Z8QuefCG7zMHV1KMGDYxy81pEGWNOWiZwJ5Vm+tBFN/LuRKfkpj4hyczsig6YB47pZpflzAsOmk9Bar5Yo4=
X-Received: by 2002:a2e:8012:0:b0:2b2:90e:165d with SMTP id
 j18-20020a2e8012000000b002b2090e165dmr1082541ljg.2.1686210372444; Thu, 08 Jun
 2023 00:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org> <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org> <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
 <20230606085643-mutt-send-email-mst@kernel.org> <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
 <20230607054246-mutt-send-email-mst@kernel.org> <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
 <20230608020111-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230608020111-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 8 Jun 2023 15:46:00 +0800
Message-ID: <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 2:03=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Jun 08, 2023 at 08:42:15AM +0800, Jason Wang wrote:
> > On Wed, Jun 7, 2023 at 5:43=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Wed, Jun 07, 2023 at 10:39:15AM +0200, Stefano Garzarella wrote:
> > > > On Tue, Jun 6, 2023 at 2:58=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > > >
> > > > > On Tue, Jun 06, 2023 at 09:29:22AM +0800, Jason Wang wrote:
> > > > > > On Mon, Jun 5, 2023 at 10:58=E2=80=AFPM Stefano Garzarella <sga=
rzare@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 05, 2023 at 09:54:57AM -0400, Michael S. Tsirkin =
wrote:
> > > > > > > >On Mon, Jun 05, 2023 at 03:30:35PM +0200, Stefano Garzarella=
 wrote:
> > > > > > > >> On Mon, Jun 05, 2023 at 09:00:25AM -0400, Michael S. Tsirk=
in wrote:
> > > > > > > >> > On Mon, Jun 05, 2023 at 02:54:20PM +0200, Stefano Garzar=
ella wrote:
> > > > > > > >> > > On Mon, Jun 05, 2023 at 08:41:54AM -0400, Michael S. T=
sirkin wrote:
> > > > > > > >> > > > On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Ga=
rzarella wrote:
> > > > > > > >> > > > > vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST=
_SET_VRING_BASE)
> > > > > > > >> > > > > don't support packed virtqueue well yet, so let's =
filter the
> > > > > > > >> > > > > VIRTIO_F_RING_PACKED feature for now in vhost_vdpa=
_get_features().
> > > > > > > >> > > > >
> > > > > > > >> > > > > This way, even if the device supports it, we don't=
 risk it being
> > > > > > > >> > > > > negotiated, then the VMM is unable to set the vrin=
g state properly.
> > > > > > > >> > > > >
> > > > > > > >> > > > > Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based =
backend")
> > > > > > > >> > > > > Cc: stable@vger.kernel.org
> > > > > > > >> > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat=
.com>
> > > > > > > >> > > > > ---
> > > > > > > >> > > > >
> > > > > > > >> > > > > Notes:
> > > > > > > >> > > > >     This patch should be applied before the "[PATC=
H v2 0/3] vhost_vdpa:
> > > > > > > >> > > > >     better PACKED support" series [1] and backport=
ed in stable branches.
> > > > > > > >> > > > >
> > > > > > > >> > > > >     We can revert it when we are sure that everyth=
ing is working with
> > > > > > > >> > > > >     packed virtqueues.
> > > > > > > >> > > > >
> > > > > > > >> > > > >     Thanks,
> > > > > > > >> > > > >     Stefano
> > > > > > > >> > > > >
> > > > > > > >> > > > >     [1] https://lore.kernel.org/virtualization/202=
30424225031.18947-1-shannon.nelson@amd.com/
> > > > > > > >> > > >
> > > > > > > >> > > > I'm a bit lost here. So why am I merging "better PAC=
KED support" then?
> > > > > > > >> > >
> > > > > > > >> > > To really support packed virtqueue with vhost-vdpa, at=
 that point we would
> > > > > > > >> > > also have to revert this patch.
> > > > > > > >> > >
> > > > > > > >> > > I wasn't sure if you wanted to queue the series for th=
is merge window.
> > > > > > > >> > > In that case do you think it is better to send this pa=
tch only for stable
> > > > > > > >> > > branches?
> > > > > > > >> > > > Does this patch make them a NOP?
> > > > > > > >> > >
> > > > > > > >> > > Yep, after applying the "better PACKED support" series=
 and being
> > > > > > > >> > > sure that
> > > > > > > >> > > the IOCTLs of vhost-vdpa support packed virtqueue, we =
should revert this
> > > > > > > >> > > patch.
> > > > > > > >> > >
> > > > > > > >> > > Let me know if you prefer a different approach.
> > > > > > > >> > >
> > > > > > > >> > > I'm concerned that QEMU uses vhost-vdpa IOCTLs thinkin=
g that the kernel
> > > > > > > >> > > interprets them the right way, when it does not.
> > > > > > > >> > >
> > > > > > > >> > > Thanks,
> > > > > > > >> > > Stefano
> > > > > > > >> > >
> > > > > > > >> >
> > > > > > > >> > If this fixes a bug can you add Fixes tags to each of th=
em? Then it's ok
> > > > > > > >> > to merge in this window. Probably easier than the elabor=
ate
> > > > > > > >> > mask/unmask dance.
> > > > > > > >>
> > > > > > > >> CCing Shannon (the original author of the "better PACKED s=
upport"
> > > > > > > >> series).
> > > > > > > >>
> > > > > > > >> IIUC Shannon is going to send a v3 of that series to fix t=
he
> > > > > > > >> documentation, so Shannon can you also add the Fixes tags?
> > > > > > > >>
> > > > > > > >> Thanks,
> > > > > > > >> Stefano
> > > > > > > >
> > > > > > > >Well this is in my tree already. Just reply with
> > > > > > > >Fixes: <>
> > > > > > > >to each and I will add these tags.
> > > > > > >
> > > > > > > I tried, but it is not easy since we added the support for pa=
cked
> > > > > > > virtqueue in vdpa and vhost incrementally.
> > > > > > >
> > > > > > > Initially I was thinking of adding the same tag used here:
> > > > > > >
> > > > > > > Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> > > > > > >
> > > > > > > Then I discovered that vq_state wasn't there, so I was thinki=
ng of
> > > > > > >
> > > > > > > Fixes: 530a5678bc00 ("vdpa: support packed virtqueue for set/=
get_vq_state()")
> > > > > > >
> > > > > > > So we would have to backport quite a few patches into the sta=
ble branches.
> > > > > > > I don't know if it's worth it...
> > > > > > >
> > > > > > > I still think it is better to disable packed in the stable br=
anches,
> > > > > > > otherwise I have to make a list of all the patches we need.
> > > > > > >
> > > > > > > Any other ideas?
> > > > > >
> > > > > > AFAIK, except for vp_vdpa, pds seems to be the first parent tha=
t
> > > > > > supports packed virtqueue. Users should not notice anything wro=
ng if
> > > > > > they don't use packed virtqueue. And the problem of vp_vdpa + p=
acked
> > > > > > virtqueue came since the day0 of vp_vdpa. It seems fine to do n=
othing
> > > > > > I guess.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > >
> > > > > I have a question though, what if down the road there
> > > > > is a new feature that needs more changes? It will be
> > > > > broken too just like PACKED no?
> > > > > Shouldn't vdpa have an allowlist of features it knows how
> > > > > to support?
> > > >
> > > > It looks like we had it, but we took it out (by the way, we were
> > > > enabling packed even though we didn't support it):
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D6234f80574d7569444d8718355fa2838e92b158b
> > > >
> > > > The only problem I see is that for each new feature we have to modi=
fy
> > > > the kernel.
> > > > Could we have new features that don't require handling by vhost-vdp=
a?
> > > >
> > > > Thanks,
> > > > Stefano
> > >
> > > Jason what do you say to reverting this?
> >
> > I may miss something but I don't see any problem with vDPA core.
> >
> > It's the duty of the parents to advertise the features it has. For exam=
ple,
> >
> > 1) If some kernel version that is packed is not supported via
> > set_vq_state, parents should not advertise PACKED features in this
> > case.
> > 2) If the kernel has support packed set_vq_state(), but it's emulated
> > cvq doesn't support, parents should not advertise PACKED as well
> >
> > If a parent violates the above 2, it looks like a bug of the parents.
> >
> > Thanks
>
> Yes but what about vhost_vdpa? Talking about that not the core.

Not sure it's a good idea to workaround parent bugs via vhost-vDPA.

> Should that not have a whitelist of features
> since it interprets ioctls differently depending on this?

If there's a bug, it might only matter the following setup:

SET_VRING_BASE/GET_VRING_BASE + VDUSE.

This seems to be broken since VDUSE was introduced. If we really want
to backport something, it could be a fix to filter out PACKED in
VDUSE?

Thanks

>
> > >
> > > --
> > > MST
> > >
>

