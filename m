Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C782570F056
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbjEXIL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjEXILz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:11:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9339E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684915877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LD0RBfHkt8RyyoR9/xsXmW+SWj3IJjCO9a4bxL4YoU=;
        b=JYz7DEvKeyBpE2Lkhf1PjmzkPnyRhdFdPRIUcgmqK9N+oaWDJJnF4f3k0FjHjUjCgOUVz0
        Ojb6fYQFwm8ILVzR389To30cBRQhSLKOTc92BDfbkuKrOF4Q/UQ/PS8L9mEeYGspO3rZ4M
        QZx6AeZ+kLFW+pQdR9dO0vrB6OKuXag=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-Nm3rW3t5MSeQAD4O1iF8hA-1; Wed, 24 May 2023 04:11:16 -0400
X-MC-Unique: Nm3rW3t5MSeQAD4O1iF8hA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 870EC281424F;
        Wed, 24 May 2023 08:11:15 +0000 (UTC)
Received: from localhost (unknown [10.39.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0182620296C6;
        Wed, 24 May 2023 08:11:14 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Du Rui <durui@linux.alibaba.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>
Subject: Re: dm overlaybd: targets mapping OverlayBD image
References: <9505927dabc3b6695d62dfe1be371b12f5bdebf7.1684491648.git.durui@linux.alibaba.com>
        <ZGz32yw7ecKhW+lj@redhat.com>
        <CAL7ro1FPEqXyOuX_WPMYdsT6rW-bD5EU=v=oWKsd6XscykLF6Q@mail.gmail.com>
        <fd4d0429-4da3-8217-6c13-14fd8a198920@linux.alibaba.com>
Date:   Wed, 24 May 2023 10:11:13 +0200
In-Reply-To: <fd4d0429-4da3-8217-6c13-14fd8a198920@linux.alibaba.com> (Gao
        Xiang's message of "Wed, 24 May 2023 15:13:49 +0800")
Message-ID: <87r0r6ywri.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gao Xiang <hsiangkao@linux.alibaba.com> writes:

> On 2023/5/24 23:43, Alexander Larsson wrote:
>> On Tue, May 23, 2023 at 7:29=E2=80=AFPM Mike Snitzer <snitzer@kernel.org=
> wrote:
>>>
>>> On Fri, May 19 2023 at  6:27P -0400,
>>> Du Rui <durui@linux.alibaba.com> wrote:
>>>
>>>> OverlayBD is a novel layering block-level image format, which is design
>>>> for container, secure container and applicable to virtual machine,
>>>> published in USENIX ATC '20
>>>> https://www.usenix.org/system/files/atc20-li-huiba.pdf
>>>>
>>>> OverlayBD already has a ContainerD non-core sub-project implementation
>>>> in userspace, as an accelerated container image service
>>>> https://github.com/containerd/accelerated-container-image
>>>>
>>>> It could be much more efficient when do decompressing and mapping works
>>>> in the kernel with the framework of device-mapper, in many circumstanc=
es,
>>>> such as secure container runtime, mobile-devices, etc.
>>>>
>>>> This patch contains a module, dm-overlaybd, provides two kinds of targ=
ets
>>>> dm-zfile and dm-lsmt, to expose a group of block-devices contains
>>>> OverlayBD image as a overlaid read-only block-device.
>>>>
>>>> Signed-off-by: Du Rui <durui@linux.alibaba.com>
>>>
>>> <snip, original patch here: [1] >
>> A long long time ago I wrote a docker container image based on
>> dm-snapshot that is vaguely similar to this one. It is still
>> available, but nobody really uses it. It has several weaknesses. First
>> of all the container image is an actual filesystem, so you need to
>> pre-allocate a fixed max size for images at construction time.
>> Secondly, all the lvm volume changes and mounts during runtime caused
>> weird behaviour (especially at scale) that was painful to manage (just
>> search the docker issue tracker for devmapper backend). In the end
>> everyone moved to a filesystem based implementation (overlayfs based).
>
> Yeah, and I think reproducibility issue is another problem, which means
> it's quite hard to select a random fs without some change to get the
> best result.  I do find these guys work on e2fsprogs again and again.
>
> I've already told them internally again and again, but.. They only focus
> on some minor points such as how to do I/O and CPU prefetch to get
> (somewhat) better performance and beat EROFS.  I don't know, I have no
> enough time to even look into that whether this new kernel stuffs is
> fine: because of a very simplist idea:
>
>  stacked storage overhead generally takes double runtime/memory
> footprints:
>    filesystem + block drivers
>
>>=20
>>> I appreciate that this work is being done with an eye toward
>>> containerd "community" and standardization but based on my limited
>>> research it appears that this format of OCI image storage/use is only
>>> used by Alibaba? (but I could be wrong...)
>>>
>>> But you'd do well to explain why the userspace solution isn't
>>> acceptable. Are there security issues that moving the implementation
>>> to kernel addresses?
>>>
>>> I also have doubts that this solution is _actually_ more performant
>>> than a proper filesystem based solution that allows page cache sharing
>>> of container image data across multiple containers.
>> This solution doesn't even allow page cache sharing between shared
>> layers (like current containers do), much less between independent
>> layers.
>>=20
>>> There is an active discussion about, and active development effort
>>> for, using overlayfs + erofs for container images.  I'm reluctant to
>>> merge this DM based container image approach without wider consensus
>>> from other container stakeholders.
>>>
>>> But short of reaching wider consensus on the need for these DM
>>> targets: there is nothing preventing you from carrying these changes
>>> in your alibaba kernel.
>> Erofs already has some block-level support for container images
>> (with
>> nydus), and composefs works with current in-kernel EROFS+overlayfs.
>> And this new approach doesn't help for the IMHO current weak spot we
>> have, which is unprivileged container images.
>> Also, while OCI artifacts can be used to store any kind of image
>> formats (or any other kind of file) I think for an actual standardized
>> new image format it would be better to work with the OCI org to come
>> up with a OCI v2 standard image format.
> Agreed, I hope you guys could actually sit down and evaluate a proper
> solution on the next OCI v2, currently I know there are:
>
>  - Composefs
>  - (e)stargz   https://github.com/containerd/stargz-snapshotter
>  - Nydus       https://github.com/containerd/nydus-snapshotter
>  - OverlayBD   https://github.com/containerd/accelerated-container-image
>  - SOCI        https://github.com/awslabs/soci-snapshotter
>  - Tarfs
>  - (maybe even more..)
>
> Honestly, I do think OSTree/Composefs is the best approach for now for
> deduplication and page cache sharing (due to kernel limitation of page
> cache sharing and overlayfs copyup limitation).  I'm too tired of
> container image stuffs honestly.  Too much unnecessary manpower waste.

for a file-based storage model, I am not sure a new format would really
buy us much or it can be significantly different.

Without a proper support from the kernel, a new format would still need
to create the layout overlay expects, so it won't be much different than
what we have now.

The current OCI format, with some tweaks like (e)stargz or zstd:chunked,
already make its content addressable and a client can retrieve only the
subset of the files that are needed.  At the same time we maintain the
simplicity of a tarball and it won't break existing clients.

IMO, the most interesting problem is how to store these images locally
and how the kernel can help with that.

The idea behind composefs is to replace the existing storage model used
for overlay, where each layer has its own directory, with a single
directory where all the files are stored by their checksum.  The
expected layout then is recreated at runtime.

