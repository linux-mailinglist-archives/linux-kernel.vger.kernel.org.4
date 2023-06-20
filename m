Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0607376C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjFTVkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFTVkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:40:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC9C172C;
        Tue, 20 Jun 2023 14:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2C8C611CE;
        Tue, 20 Jun 2023 21:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED0BC433C0;
        Tue, 20 Jun 2023 21:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687297211;
        bh=VkuvObZWt7Z9BhO70T8nAE4CO8cD20X1Q+MakE1xwjM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R6bGj5L17YzJH2J+hIj+ChbgDH71YwP3niMY6KYwOhHhJ6FbUPDIvMw1dh7hrqA62
         MU9opa7+aQpWPcyoWWZmRF+j9T2nN2Y5LhQqc0rJ8WXcbEveEAeVk+Cw8FUZB4WlBW
         sikM+FR3OITcFWpW40uDuuXIDbpSER+xS71NLGU7Hv8GxryXUdzCn7jpuG2bhBnf7x
         /SqURxkbVgyTYcWmaQ0bdk7PQ17/0dS5FrR3EBp0koawT02p4SpxIzxup3jQtpi5ax
         vtm30I0iL2WEuRaLVA6NNIyIjjXKER/e+0MUqOcIrL9FoPB+2vSRFwP8qwGT7s9jGc
         MarnJOGM+W9BQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f8777caaa1so2607382e87.3;
        Tue, 20 Jun 2023 14:40:11 -0700 (PDT)
X-Gm-Message-State: AC+VfDwYbA4+XOjb8OPVMo3YTJLOVfB3w1PWYoDfR6ZHTCkcI4gGHMwF
        +H/0c/QHWd946xeAsFWqSXs3NN7MSnPlnLHRSRE=
X-Google-Smtp-Source: ACHHUZ4MnsM9wUCahuLx6WqFNOjsSTO31jxkr/NYk9tseCFYDf3n/NIZXqse7GNrN9ctZKOIINRcIlcP21NliNPeoeQ=
X-Received: by 2002:a19:6742:0:b0:4f8:5671:ed1 with SMTP id
 e2-20020a196742000000b004f856710ed1mr7831865lfj.29.1687297209166; Tue, 20 Jun
 2023 14:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230620210003.3818348-1-jbaron@akamai.com>
In-Reply-To: <20230620210003.3818348-1-jbaron@akamai.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 20 Jun 2023 14:39:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4iJjC5=z0rZEOw5xJ5MdEXyA+9fgvS1NjWooDpuZ31_g@mail.gmail.com>
Message-ID: <CAPhsuW4iJjC5=z0rZEOw5xJ5MdEXyA+9fgvS1NjWooDpuZ31_g@mail.gmail.com>
Subject: Re: raid0 + original layout + discard + different disk sizes => can
 corrupt data
To:     Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        neilb@suse.de, mzhivich@akamai.com, dbanerje@akamai.com,
        jdike@akamai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Tue, Jun 20, 2023 at 2:00=E2=80=AFPM Jason Baron <jbaron@akamai.com> wro=
te:
>
> Hi,
>
> SUMMARY
> =3D=3D=3D=3D=3D=3D=3D
>
> We've found that using raid0 with the 'original' layout and discard enabl=
ed
> with different disk sizes (such that at least two zones are created) can
> result in data corruption. This is due to the fact that the discard
> handling in 'raid0_handle_discard()' assumes the 'alternate' layout.
>
> More specifically, while multiple zones are necessary to create the
> corruption, the corruption may not occur with multiple zones if they
> layout in such a way the layout matches what the 'alternate' layout
> would have produced. Thus, not all raid0 devices with the 'original'
> layout, different size disks and discard enabled will encounter this
> corruption.
>
> BACKGROUND
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The 3.14 kernel inadvertleny changed the raid0 disk layout for different
> size disks. Thus, running a pre-3.14 kernel and post-3.14 kernel on the
> same raid0 array could corrupt data. This lead to the creation of the
> 'original' layout (to match the pre-3.14 layout) and the 'alternate' layo=
ut
> (to match the post 3.14 layout) in the 5.4 kernel time frame and an optio=
n
> to tell the kernel which layout to use (since it couldn't be autodetected=
)
> [1]. The mdadm tool also added support for writing the layout to the raid=
0
> superblock which the kernel honors. The mdadm tool defaults to the origin=
al
> layout unless --layout is given (--layout=3Dalternate or --layout=3Dorigi=
nal).
>
> REPRODUCER (pseudocode)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The below steps were the simplest we found to consistently reproduced the
> corruption:
>
> 1. create raid0 array with different size disks using original layout
> 2. mkfs
> 3. mount -o discard
> 4. create lots of files
> 5. remove 1/2 the files
> 6. fstrim -a (or just the mount point for the raid0 array)
> 7. umount
> 8. fsck -fn /dev/md1
>
> Here is an example corruption, though we've seen many others:
>
> fsck from util-linux 2.34
> e2fsck 1.45.5 (07-Jan-2020)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Directory inode 24557, block #0, offset 0: directory has no checksum.
> Fix? no
>
> Directory inode 24557, block #0, offset 0: directory corrupted
> Salvage? no
>
> e2fsck: aborted
>
> /dev/md1: ********** WARNING: Filesystem still has errors **********
>
>
> VULNERABLE VERSIONS
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> We've confirmed the corruption with the latest 6.4-rc7 kernel. Kernels th=
at
> support the 'original' layout could have this issue. The 'original' layou=
t
> was added to the 5.4+ kernels, although the 'original' layout may have be=
en
> backported to earlier kernels.
>
> Kernels versions from 3.14 to 5.4 that only have support for the 'alterna=
te'
> layout should be ok. I'm not sure about pre-3.14 kernels that only have t=
he
> 'original' layout. One would have to go back and see if they support
> discard and if that support is correct.
>
> WORKAROUNDS
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Until a proper code fix is implemented in the kernel and updated, valid
> workarounds we have found are any 1 of the following:
>
> 1. disable discard and fstrim from running on the raid0 array
> 2. create new arrays only with the 'alternate' layout, the 'mdadm'
>    command understands mdadm --layout=3Dalternate
> 3. ensure there is only 1 raid0 zone (if disks are all the same size)
>
> That said, you may already have 'silent corruption' if data is not covere=
d
> by a checksum.
>
> FIXING
> =3D=3D=3D=3D=3D=3D=3D
>
> It may make sense to have the kernel just disable discard for raid0 with
> the 'original' layout, and update mdadm to default to 'alternate' and tre=
at
> the 'original' layout more as a deprecated format? I'm curious as to why
> mdadm is using 'original' layout as the default for new arrays?
>
> Alternatively, we could patch the 'original' layout and add proper discar=
d
> support.

Thanks for the detailed report and analysis!

We will look into fixing it.

Song

>
> THANKS
> =3D=3D=3D=3D=3D=3D
>
> Thanks to Michael Zhivich, Debabrata Banerjee and Jeff Dike for helping u=
ncover this issue.
>
> Thanks,
>
> -Jason
>
> [1] https://wiki.ubuntu.com/Kernel/Raid0LayoutMigration
