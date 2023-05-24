Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C7970EE6C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239434AbjEXGrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbjEXGpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E391BB
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684910625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mAf4XjOaef4P+4MQgCAxHVADzrgzQEnmBFIEaQXIdMU=;
        b=NVWOmxUjHrt4jbrWKDH1GjXd54Itbxz6osA6g5WGqXhTj8VGSxBej6NBXPXq3oo/UjaPgP
        0rNiMxSR9Ax45NGnxnGwTbj06ev+6ninRL2G93Qel7eMpi01eM60os7wzao5JmmqniAptv
        LxWIhAuJQftPFjxAUKiUGo03Zxkhim4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-ObRZtJ2GN4y10ExFgswjIw-1; Wed, 24 May 2023 02:43:43 -0400
X-MC-Unique: ObRZtJ2GN4y10ExFgswjIw-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-33a8d572f29so2202065ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910620; x=1687502620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAf4XjOaef4P+4MQgCAxHVADzrgzQEnmBFIEaQXIdMU=;
        b=XxVynPH2Ht2pjgdZCItYvgiFD7UI5mUZzTbM/7RIzMVET4FmKBThzSTYI+XSyP2JLW
         9W10YPwnvy8Au8bh8nO3Sd6p5kv8ihvzb8Xotpb1aLWrziDgb0HHY5yoHWCaxVi6yNyH
         +AHOp+/hEmrJIONcQLW/+7Q9twzt/83twWDxn6NrnY9I8O8rAQpsAEfV+ZzWZaAfKFpa
         As7+6mrGp3nkd6U9imNjbncxqdrgmc/yd7r47ZPOrGvp6NDaGUqUnd/AeuvvYQO/lGpd
         aZC2Uh0bfKDOzOhaHCAYIpwx2je2WYobaWyRRO9KxoBCf4I3t/KgexspVYuo2RKSWqjt
         M5fg==
X-Gm-Message-State: AC+VfDzHFo/BdFPeF8yE8eKxqAzWyObvyt+SVHZpeirAGZD1g8K6dT/I
        zrrc8F97Ijd4qb/flbenf5RmSKLctVA4HSaVjwduHfHk7HoN+br/UaqZZL4r0HDq/R0EYDh4vSC
        J3CimZlhhSYCnVZ7fnDRVEmo0WtzwssM3ocIWxew+4nThiD96
X-Received: by 2002:a92:d24a:0:b0:334:309a:2492 with SMTP id v10-20020a92d24a000000b00334309a2492mr11059504ilg.20.1684910620250;
        Tue, 23 May 2023 23:43:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4gisdUFPTBh/gvzouw9Kn7wkeIB7YdSvtLl57t9HrQvgU2mTukFJo4qMdPjHfxXLpJMrEpeEdKGGs2Hs9o6rw=
X-Received: by 2002:a92:d24a:0:b0:334:309a:2492 with SMTP id
 v10-20020a92d24a000000b00334309a2492mr11059497ilg.20.1684910619996; Tue, 23
 May 2023 23:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <9505927dabc3b6695d62dfe1be371b12f5bdebf7.1684491648.git.durui@linux.alibaba.com>
 <ZGz32yw7ecKhW+lj@redhat.com>
In-Reply-To: <ZGz32yw7ecKhW+lj@redhat.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Wed, 24 May 2023 08:43:29 +0200
Message-ID: <CAL7ro1FPEqXyOuX_WPMYdsT6rW-bD5EU=v=oWKsd6XscykLF6Q@mail.gmail.com>
Subject: Re: dm overlaybd: targets mapping OverlayBD image
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Du Rui <durui@linux.alibaba.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 7:29=E2=80=AFPM Mike Snitzer <snitzer@kernel.org> w=
rote:
>
> On Fri, May 19 2023 at  6:27P -0400,
> Du Rui <durui@linux.alibaba.com> wrote:
>
> > OverlayBD is a novel layering block-level image format, which is design
> > for container, secure container and applicable to virtual machine,
> > published in USENIX ATC '20
> > https://www.usenix.org/system/files/atc20-li-huiba.pdf
> >
> > OverlayBD already has a ContainerD non-core sub-project implementation
> > in userspace, as an accelerated container image service
> > https://github.com/containerd/accelerated-container-image
> >
> > It could be much more efficient when do decompressing and mapping works
> > in the kernel with the framework of device-mapper, in many circumstance=
s,
> > such as secure container runtime, mobile-devices, etc.
> >
> > This patch contains a module, dm-overlaybd, provides two kinds of targe=
ts
> > dm-zfile and dm-lsmt, to expose a group of block-devices contains
> > OverlayBD image as a overlaid read-only block-device.
> >
> > Signed-off-by: Du Rui <durui@linux.alibaba.com>
>
> <snip, original patch here: [1] >

A long long time ago I wrote a docker container image based on
dm-snapshot that is vaguely similar to this one. It is still
available, but nobody really uses it. It has several weaknesses. First
of all the container image is an actual filesystem, so you need to
pre-allocate a fixed max size for images at construction time.
Secondly, all the lvm volume changes and mounts during runtime caused
weird behaviour (especially at scale) that was painful to manage (just
search the docker issue tracker for devmapper backend). In the end
everyone moved to a filesystem based implementation (overlayfs based).

> I appreciate that this work is being done with an eye toward
> containerd "community" and standardization but based on my limited
> research it appears that this format of OCI image storage/use is only
> used by Alibaba? (but I could be wrong...)
>
> But you'd do well to explain why the userspace solution isn't
> acceptable. Are there security issues that moving the implementation
> to kernel addresses?
>
> I also have doubts that this solution is _actually_ more performant
> than a proper filesystem based solution that allows page cache sharing
> of container image data across multiple containers.

This solution doesn't even allow page cache sharing between shared
layers (like current containers do), much less between independent
layers.

> There is an active discussion about, and active development effort
> for, using overlayfs + erofs for container images.  I'm reluctant to
> merge this DM based container image approach without wider consensus
> from other container stakeholders.
>
> But short of reaching wider consensus on the need for these DM
> targets: there is nothing preventing you from carrying these changes
> in your alibaba kernel.

Erofs already has some block-level support for container images (with
nydus), and composefs works with current in-kernel EROFS+overlayfs.
And this new approach doesn't help for the IMHO current weak spot we
have, which is unprivileged container images.

Also, while OCI artifacts can be used to store any kind of image
formats (or any other kind of file) I think for an actual standardized
new image format it would be better to work with the OCI org to come
up with a OCI v2 standard image format.

But, I don't really speak for the block layer developers, so take my
opinions with a pinch of salt.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

