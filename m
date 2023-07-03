Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102B774564B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjGCHp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGCHpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D147EC1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688370306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=55bNqB8+Yuqx/ySjnDbigrCQp0fQIOTPHTvF9O0igIQ=;
        b=iq1MiASNguVECZ7jc2lOJ09mAzZS5TeIP3jhFAJnsr6mBDFDrdAf5lAAQR38HUhrZjfv1W
        GIJoUotpvh9ydJC1oc7F9g67S6+Ma5vXRnhT30IQBACEdcXQmLCmMzP1y+pKEqU95bukKL
        acPSumtWR7nsGHf71CGsPl/fWBvcXR4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-D1M01GfyNm2aVuB7jjhrfw-1; Mon, 03 Jul 2023 03:45:05 -0400
X-MC-Unique: D1M01GfyNm2aVuB7jjhrfw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6a47b59a5so39535051fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 00:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688370304; x=1690962304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55bNqB8+Yuqx/ySjnDbigrCQp0fQIOTPHTvF9O0igIQ=;
        b=HPngu6sIw9XPFfrrGAWzAJ+bau2lUcEdZ65wd/uHQK301kFCbZW9oqdIPOcds1yttr
         a6AqHyPJsYGTHPbhI6Cm67FJEidPFv4d5hUZ0k6YZoTqazoOJUttj0rEOzwxbTMVMNNS
         9bofWti0CrsVvInzYpUZUl7dOk0+H+z4PbH1/oCPqJvYOwNTulxNDM+zX7CxvkX3QX+y
         Au61YvZYC/T0MpDBugOGXIuY2UofT2E+VCjv3WmVLYLmkKOK1u9HA04td/JD47jVqkoq
         VoX3sag/8nxHuJTtsa5S1xQbyP+Wpw3jwvgp+Mndoq7SYYhKrq+2gZw/7Nx8ID2YBNgI
         NT0A==
X-Gm-Message-State: ABy/qLYgOY3t3egjVZkjq/ZWrMDn7SH9RT7cWDxZ7y2sVLJeMO2KFrKU
        kVXCdU3ViP4IuZgsVSHRvgu2ysvZSjEuf5K13Aqaulw6tRhOC8fePUy0n79BfqCZS1MgtEBUP5g
        JCsJSrbZiMFlXLpk1wFe8wVmEqvrMNay3ZvTLxXD7
X-Received: by 2002:a2e:9059:0:b0:2b6:9909:79cb with SMTP id n25-20020a2e9059000000b002b6990979cbmr6941102ljg.42.1688370304438;
        Mon, 03 Jul 2023 00:45:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEIF9G1Mas3bWI9l/SxIhrXke3ejPrphx9HBEOMX/W+63WdpsfNStOiAI6vn69dm4MUmGuyOhoxIof/LMmBT6M=
X-Received: by 2002:a2e:9059:0:b0:2b6:9909:79cb with SMTP id
 n25-20020a2e9059000000b002b6990979cbmr6941093ljg.42.1688370304167; Mon, 03
 Jul 2023 00:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230702093530-mutt-send-email-mst@kernel.org> <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
 <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
In-Reply-To: <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 3 Jul 2023 15:44:53 +0800
Message-ID: <CACGkMEt-Ao-0FmrG9y8+t31N9mJNyybY5SS+me_7pGyC_xJTsw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, xieyongji@bytedance.com,
        david.marchand@redhat.com, lulu@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 3:43=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
> On 7/3/23 08:44, Jason Wang wrote:
> > On Sun, Jul 2, 2023 at 9:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> >>
> >> On Tue, Jun 27, 2023 at 01:36:50PM +0200, Maxime Coquelin wrote:
> >>> This small series enables virtio-net device type in VDUSE.
> >>> With it, basic operation have been tested, both with
> >>> virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> >>> adding VDUSE support using split rings layout (merged in
> >>> DPDK v23.07-rc1).
> >>>
> >>> Control queue support (and so multiqueue) has also been
> >>> tested, but requires a Kernel series from Jason Wang
> >>> relaxing control queue polling [1] to function reliably.
> >>>
> >>> [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0=
WvjGRr3whU+QasUg@mail.gmail.com/T/
> >>
> >> Jason promised to post a new version of that patch.
> >> Right Jason?
> >
> > Yes.
> >
> >> For now let's make sure CVQ feature flag is off?
> >
> > We can do that and relax on top of my patch.
>
> I agree? Do you prefer a features negotiation, or failing init (like
> done for VERSION_1) if the VDUSE application advertises CVQ?

Assuming we will relax it soon, I think we can choose the easier way.
I guess it's just failing.

Thanks

>
> Thanks,
> Maxime
>
> > Thanks
> >
> >>
> >>> RFC -> v1 changes:
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> - Fail device init if it does not support VERSION_1 (Jason)
> >>>
> >>> Maxime Coquelin (2):
> >>>    vduse: validate block features only with block devices
> >>>    vduse: enable Virtio-net device type
> >>>
> >>>   drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
> >>>   1 file changed, 11 insertions(+), 4 deletions(-)
> >>>
> >>> --
> >>> 2.41.0
> >>
> >
>

