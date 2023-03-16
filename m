Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3996BC853
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCPIKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjCPIKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:10:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65B189F0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678954183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANBi6moGFCcHvuEVtc5exSmPpTznsGEIvNhn1pGPofU=;
        b=KTO7Qv74eS1LkOVnD12sLTSYpc47rWPYrVa4OIi4g2YXTQA0p/qmYdURXJqBQWXwJxBl/+
        7GNH1kjalRBazjAPV+H9hbLx9MdjMTi6wPd06+NBozsTbCeINbvexLAlWXsKKMBD8Z8fjO
        Zd7kSFNIOkKcrAoI1rjNAzfLMWAq014=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-6VXZ0iyxN5mCqx69VdE2hw-1; Thu, 16 Mar 2023 04:09:41 -0400
X-MC-Unique: 6VXZ0iyxN5mCqx69VdE2hw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-541942bfdccso8325287b3.14
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANBi6moGFCcHvuEVtc5exSmPpTznsGEIvNhn1pGPofU=;
        b=NiNRFD6UVtcbpQtABf3uK1D1e73eouZSl4dfEAGF5/gZc+0Snh1blrStrWKCwYrKPs
         FsOzC+DQiYp3JW6yBIvXeEOzk8AUiLsug08NU2ZobX9ClQVhVbjBQjWwjNJ5LTq8jwTK
         bIGgFq8DSiCVdw2TEpsO+Y8ztAEnxc0FyIJZ6vGzxM/hNCaGWGC3k9HvTFdtgf8/cEzr
         eokZsBkUF3V/BWJSw9cR1m+rYZc7vsmu1Qfce9Po49whh22Wp6i4pgXdZMBYldd6hKF2
         j0Z8dNA/71pgc1EiXbXa7C/H8PqQ+/p1Go6kLo9E4dTtWW9RYTU7bWFyuUhcERia7TSF
         ebQA==
X-Gm-Message-State: AO0yUKVwEV11g0f0YYFljDXBa0j+MwKm3ClNonKu5NZUd/PDriKKYRA/
        Xpsqvf5cgJ6uNmuUeyiYkR52mI3lX/S1aGCMKAnYgattGGHDa4GgPmDud6scug8d2S75Qx1Kgx4
        uj2+IPjIa54S/OVJDy0ZL1Zova2EQK9lSBFQP5GDZ
X-Received: by 2002:a81:ad26:0:b0:544:a67b:8be0 with SMTP id l38-20020a81ad26000000b00544a67b8be0mr481694ywh.3.1678954181316;
        Thu, 16 Mar 2023 01:09:41 -0700 (PDT)
X-Google-Smtp-Source: AK7set9AvRTqOxXewC6b1IQRkPJ8SS1rw3/pZRF3qWDjUZCuLuTU6cRWfxgoColGfBP0bqfJ0oACLTw3fPECEJ22bt4=
X-Received: by 2002:a81:ad26:0:b0:544:a67b:8be0 with SMTP id
 l38-20020a81ad26000000b00544a67b8be0mr481683ywh.3.1678954181027; Thu, 16 Mar
 2023 01:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230302113421.174582-1-sgarzare@redhat.com> <20230302113421.174582-4-sgarzare@redhat.com>
 <CACGkMEs6cW7LdpCdWQnX4Pif2gGOu=f3bjNeYQ6MVcdQe=X--Q@mail.gmail.com> <1980067.5pFmK94fv0@suse>
In-Reply-To: <1980067.5pFmK94fv0@suse>
From:   Stefano Garzarella <sgarzare@redhat.com>
Date:   Thu, 16 Mar 2023 09:09:29 +0100
Message-ID: <CAGxU2F4k-UHxHxpLcsvKvJdvcXfb3WpV+wU=8ZpnJwMNkx0rdA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] vringh: replace kmap_atomic() with kmap_local_page()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        eperezma@redhat.com, netdev@vger.kernel.org, stefanha@redhat.com,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
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

On Wed, Mar 15, 2023 at 10:12=E2=80=AFPM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On marted=C3=AC 14 marzo 2023 04:56:08 CET Jason Wang wrote:
> > On Thu, Mar 2, 2023 at 7:34=E2=80=AFPM Stefano Garzarella <sgarzare@red=
hat.com>
> wrote:
> > > kmap_atomic() is deprecated in favor of kmap_local_page().
> >
> > It's better to mention the commit or code that introduces this.
> >
> > > With kmap_local_page() the mappings are per thread, CPU local, can ta=
ke
> > > page-faults, and can be called from any context (including interrupts=
).
> > > Furthermore, the tasks can be preempted and, when they are scheduled =
to
> > > run again, the kernel virtual addresses are restored and still valid.
> > >
> > > kmap_atomic() is implemented like a kmap_local_page() which also disa=
bles
> > > page-faults and preemption (the latter only for !PREEMPT_RT kernels,
> > > otherwise it only disables migration).
> > >
> > > The code within the mappings/un-mappings in getu16_iotlb() and
> > > putu16_iotlb() don't depend on the above-mentioned side effects of
> > > kmap_atomic(),
> >
> > Note we used to use spinlock to protect simulators (at least until
> > patch 7, so we probably need to re-order the patches at least) so I
> > think this is only valid when:
> >
> > The vringh IOTLB helpers are not used in atomic context (e.g spinlock,
> > interrupts).
>
> I'm probably missing some context but it looks that you are saying that
> kmap_local_page() is not suited for any use in atomic context (you are
> mentioning spinlocks).
>
> The commit message (that I know pretty well since it's the exact copy, wo=
rd by
> word, of my boiler plate commits)

I hope it's not a problem for you, should I mention it somehow?

I searched for the last commits that made a similar change and found
yours that explained it perfectly ;-)

Do I need to rephrase?

> explains that kmap_local_page() is perfectly
> usable in atomic context (including interrupts).
>
> I don't know this code, however I am not able to see why these vringh IOT=
LB
> helpers cannot work if used under spinlocks. Can you please elaborate a l=
ittle
> more?
>
> > If yes, should we document this? (Or should we introduce a boolean to
> > say whether an IOTLB variant can be used in an atomic context)?
>
> Again, you'll have no problems from the use of kmap_local_page() and so y=
ou
> don't need any boolean to tell whether or not the code is running in atom=
ic
> context.
>
> Please take a look at the Highmem documentation which has been recently
> reworked and extended by me: https://docs.kernel.org/mm/highmem.html
>
> Anyway, I have been ATK 12 or 13 hours in a row. So I'm probably missing =
the
> whole picture.

Thanks for your useful info!
Stefano

