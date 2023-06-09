Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99638728DB6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbjFICR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjFICRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C34C2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686277027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kgOrLEw+CGqbzexB3hSoqE0ZkI0YLrxw+EejRuKoWQE=;
        b=IsmGcg6vkYv5UL1k0/shSxVwrLmoqd+1MjOE9S5CeR1KcAX7SPN04+xdghMCDRYSeMe9/o
        3QdJILRH2TIl9sdz1QCFR2Yd1ffMUH93r0iJERq06a1SeSoQyJ+06HFLWxjSBv9rM7uaEQ
        RWVKM9PQInydK3SboFSa+zEEc+I23dc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-_wzu3TntNG2ibX5tsACN3Q-1; Thu, 08 Jun 2023 22:17:05 -0400
X-MC-Unique: _wzu3TntNG2ibX5tsACN3Q-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b1acd44a31so9035261fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 19:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686277024; x=1688869024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgOrLEw+CGqbzexB3hSoqE0ZkI0YLrxw+EejRuKoWQE=;
        b=Op8tf8XtvnPW3usmxolyD7G0kGUWGCLWdZ0kRxjhKdZUIRUnAkmOjoVyHSyPiYbXMU
         ao+SvVyMga7sWz9ADPaYBwRxLjie3PXK+7bhxXL/9+RGVlqy+P3YEGQuClYm4jM6lkO0
         rGiWvrgsY+bX56cOuJthJrWTR1zNPVkoURCHiqHMVfc+CBDD4X5K8iOckkOvFtzu2zze
         SWvHZzuOYwwISp1iXQDhu8PWS+RPA4/9eUdzIqkD7hxWma4RviUI4qIGjFsrhpXRbA2m
         OcM7TH3izTxqEZlCP3mCNUvXKyiQripdzvnY0+oJQmD5MRAc2T9P0CvniJHU9NZsZpxg
         RzZg==
X-Gm-Message-State: AC+VfDz9bbD1uR8tQIHpa4tuBcf9g7ZYKY2FOQsiFVrBrbw0XKPFMzBk
        nGbGuu198yex0E6IAPGb0yzzY9jwvWbgaKtciJagLVWQt7bmVJvNutJ1cFRewcgctRjoFyMo/SY
        MjqAxr6MLWIjju52cainl0fsIIU1ReJ/l8LyBy9NhEnP1Lxrs
X-Received: by 2002:a2e:b163:0:b0:2b0:a4b1:df6 with SMTP id a3-20020a2eb163000000b002b0a4b10df6mr123923ljm.49.1686277023829;
        Thu, 08 Jun 2023 19:17:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/8wdm9HnZ2Nlq0u+xmMq+q13VRX7hsdmKW7Maw8V8eVTx/FWCzW2thzAyQ/MvYC6Xa3LumlbBLVc0Z0sDrGE=
X-Received: by 2002:a2e:b163:0:b0:2b0:a4b1:df6 with SMTP id
 a3-20020a2eb163000000b002b0a4b10df6mr123915ljm.49.1686277023521; Thu, 08 Jun
 2023 19:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230606085643-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
 <20230607054246-mutt-send-email-mst@kernel.org> <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
 <20230608020111-mutt-send-email-mst@kernel.org> <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
 <5giudxjp6siucr4l3i4tggrh2dpqiqhhihmdd34w3mq2pm5dlo@mrqpbwckpxai>
 <CACGkMEtqn1dbrQZn3i-W_7sVikY4sQjwLRC5xAhMnyqkc3jwOw@mail.gmail.com>
 <lw3nmkdszqo6jjtneyp4kjlmutooozz7xj2fqyxgh4v2ralptc@vkimgnbfafvi>
 <CACGkMEt1yRV9qOLBqtQQmJA_UoRLCpznT=Gvd5D51Uaz2jakHA@mail.gmail.com> <20230608102259-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230608102259-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 9 Jun 2023 10:16:50 +0800
Message-ID: <CACGkMEvirfb8g0ev=b0CjpL5_SPJabqiQKxdwuRNqG2E=N7iGA@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 10:23=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jun 08, 2023 at 05:29:58PM +0800, Jason Wang wrote:
> > On Thu, Jun 8, 2023 at 5:21=E2=80=AFPM Stefano Garzarella <sgarzare@red=
hat.com> wrote:
> > >
> > > On Thu, Jun 08, 2023 at 05:00:00PM +0800, Jason Wang wrote:
> > > >On Thu, Jun 8, 2023 at 4:00=E2=80=AFPM Stefano Garzarella <sgarzare@=
redhat.com> wrote:
> > > >>
> > > >> On Thu, Jun 08, 2023 at 03:46:00PM +0800, Jason Wang wrote:
> > > >>
> > > >> [...]
> > > >>
> > > >> >> > > > > I have a question though, what if down the road there
> > > >> >> > > > > is a new feature that needs more changes? It will be
> > > >> >> > > > > broken too just like PACKED no?
> > > >> >> > > > > Shouldn't vdpa have an allowlist of features it knows h=
ow
> > > >> >> > > > > to support?
> > > >> >> > > >
> > > >> >> > > > It looks like we had it, but we took it out (by the way, =
we were
> > > >> >> > > > enabling packed even though we didn't support it):
> > > >> >> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git/commit/?id=3D6234f80574d7569444d8718355fa2838e92b158b
> > > >> >> > > >
> > > >> >> > > > The only problem I see is that for each new feature we ha=
ve to modify
> > > >> >> > > > the kernel.
> > > >> >> > > > Could we have new features that don't require handling by=
 vhost-vdpa?
> > > >> >> > > >
> > > >> >> > > > Thanks,
> > > >> >> > > > Stefano
> > > >> >> > >
> > > >> >> > > Jason what do you say to reverting this?
> > > >> >> >
> > > >> >> > I may miss something but I don't see any problem with vDPA co=
re.
> > > >> >> >
> > > >> >> > It's the duty of the parents to advertise the features it has=
. For example,
> > > >> >> >
> > > >> >> > 1) If some kernel version that is packed is not supported via
> > > >> >> > set_vq_state, parents should not advertise PACKED features in=
 this
> > > >> >> > case.
> > > >> >> > 2) If the kernel has support packed set_vq_state(), but it's =
emulated
> > > >> >> > cvq doesn't support, parents should not advertise PACKED as w=
ell
> > > >> >> >
> > > >> >> > If a parent violates the above 2, it looks like a bug of the =
parents.
> > > >> >> >
> > > >> >> > Thanks
> > > >> >>
> > > >> >> Yes but what about vhost_vdpa? Talking about that not the core.
> > > >> >
> > > >> >Not sure it's a good idea to workaround parent bugs via vhost-vDP=
A.
> > > >>
> > > >> Sorry, I'm getting lost...
> > > >> We were talking about the fact that vhost-vdpa doesn't handle
> > > >> SET_VRING_BASE/GET_VRING_BASE ioctls well for packed virtqueue bef=
ore
> > > >> that series [1], no?
> > > >>
> > > >> The parents seem okay, but maybe I missed a few things.
> > > >>
> > > >> [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-=
shannon.nelson@amd.com/
> > > >
> > > >Yes, more below.
> > > >
> > > >>
> > > >> >
> > > >> >> Should that not have a whitelist of features
> > > >> >> since it interprets ioctls differently depending on this?
> > > >> >
> > > >> >If there's a bug, it might only matter the following setup:
> > > >> >
> > > >> >SET_VRING_BASE/GET_VRING_BASE + VDUSE.
> > > >> >
> > > >> >This seems to be broken since VDUSE was introduced. If we really =
want
> > > >> >to backport something, it could be a fix to filter out PACKED in
> > > >> >VDUSE?
> > > >>
> > > >> mmm it doesn't seem to be a problem in VDUSE, but in vhost-vdpa.
> > > >> I think VDUSE works fine with packed virtqueue using virtio-vdpa
> > > >> (I haven't tried), so why should we filter PACKED in VDUSE?
> > > >
> > > >I don't think we need any filtering since:
> > > >
> > > >PACKED features has been advertised to userspace via uAPI since
> > > >6234f80574d7569444d8718355fa2838e92b158b. Once we relax in uAPI, it
> > > >would be very hard to restrict it again. For the userspace that trie=
s
> > > >to negotiate PACKED:
> > > >
> > > >1) if it doesn't use SET_VRING_BASE/GET_VRING_BASE, everything works=
 well
> > > >2) if it uses SET_VRING_BASE/GET_VRING_BASE. it might fail or break =
silently
> > > >
> > > >If we backport the fixes to -stable, we may break the application at
> > > >least in the case 1).
> > >
> > > Okay, I see now, thanks for the details!
> > >
> > > Maybe instead of "break silently", we can return an explicit error fo=
r
> > > SET_VRING_BASE/GET_VRING_BASE in stable branches.
> > > But if there are not many cases, we can leave it like that.
> >
> > A second thought, if we need to do something for stable. is it better
> > if we just backport Shannon's series to stable?
> >
> > >
> > > I was just concerned about how does the user space understand that it
> > > can use SET_VRING_BASE/GET_VRING_BASE for PACKED virtqueues in a give=
n
> > > kernel or not.
> >
> > My understanding is that if packed is advertised, the application
> > should assume SET/GET_VRING_BASE work.
> >
> > Thanks
>
>
> Let me ask you this. This is a bugfix yes?

Not sure since it may break existing user space applications which
make it hard to be backported to -stable.

Before the fix, PACKED might work if SET/GET_VRING_BASE is not used.
After the fix, PACKED won't work at all.

Thanks

What is the appropriate Fixes
> tag?
>
> > >
> > > Thanks,
> > > Stefano
> > >
>

