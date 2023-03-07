Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E696ADE98
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjCGMWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCGMW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:22:28 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AB37389B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:22:24 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso7060645wmp.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 04:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678191743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAH2B+NW5SSU/xj3C75LgiyZHEfWnwFX1N205HLY+Fc=;
        b=A6oZlSPABgn1fHOjhktak/Y+JGuxv6+EOsexhmrKMotPXWuKxMEYZxSaBI8waEbPgY
         4DO3THjR9GzcOh9uKkGlIl87MgIpmaKw0xTI1nL6VdBWyWmJHNPFF/bTwmHwuaavm7a7
         YYVHCf3ubL4LC7+34+ZLwdaJYFlGvsq/lcbB6gQKzH5MN9fGipsMsjWmgbkA8gIUcEd6
         Gyn/+ZX56RjE97jioAGUFQOgMCIM2bq9XImdUo4x2lsQ4ZD2tVMKZ99PG2YvvV3sE8+C
         AEMv4gfyZoCgjh9z4Fp7oWvBw45aSl3AFYHhb989zA2jrNlX4QO5wy+eixXKALxBaaVO
         kpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678191743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAH2B+NW5SSU/xj3C75LgiyZHEfWnwFX1N205HLY+Fc=;
        b=tsIjMqt6OH12juw5RHGC4tO5G0AsYhVQ0gQt1eLX/NYrgpjuV7Mg08gzNNlVeDDe6i
         lNqZkyKH7LpTdNrQt1RcEIIsMo0mrB5ptyEma9iX8nn6+t8WUJxXO3KGqtxC2vrb0gPb
         pwwlm1JGUs3Qx0uT8fscGRepjPW1FWWlZsLoYMAF3FuqkRU7wDaXMWhKxpaXxjIQadAm
         59cQrlgW/WpRfPEWU6EeNTbj4MmglIKD5Z5SzhPklAY6h4PXqc5tyrpRsuF6OQHUhjxK
         iuBun+DS7QQ38sdMETzGFhgu4xoMKMSbGvHpahJ2OcXP7enhC5c2BTbRMwoIl/sBGFva
         9M3g==
X-Gm-Message-State: AO0yUKV22hy+JsCwQ65DEsfPku4FKNus6/M9WI0bO1WShZtx6kgMlPXV
        S/gfbTBNJNYWQtF4mKSO6HE=
X-Google-Smtp-Source: AK7set8O+WdQEH9ujZVQ5z8j7ijAjdM4QQfsFC+4ZsMblyy2L2gx9CqIfzBbHTb0XsYORGrjD+fiMg==
X-Received: by 2002:a05:600c:a4c:b0:3dc:d5c:76d9 with SMTP id c12-20020a05600c0a4c00b003dc0d5c76d9mr13352304wmq.0.1678191743096;
        Tue, 07 Mar 2023 04:22:23 -0800 (PST)
Received: from suse.localnet (host-79-43-1-179.retail.telecomitalia.it. [79.43.1.179])
        by smtp.gmail.com with ESMTPSA id j21-20020a05600c075500b003e0238d9101sm12640029wmn.31.2023.03.07.04.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 04:22:22 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] fs/sysv: Don't round down address for kunmap_flush_on_unmap()
Date:   Tue, 07 Mar 2023 13:22:21 +0100
Message-ID: <1820093.atdPhlSkOF@suse>
In-Reply-To: <20230306172759.GB3390869@ZenIV>
References: <20230306125150.12166-1-fmdefrancesco@gmail.com>
 <20230306172759.GB3390869@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=EC 6 marzo 2023 18:27:59 CET Al Viro wrote:
> On Mon, Mar 06, 2023 at 01:51:50PM +0100, Fabio M. De Francesco wrote:
> > The kernel virtual address passed to kunmap_flush_on_unmap() has no more
> > any need to be rounded down.
> >=20
> > Therefore, delete the rounding down of "page_addr" when passed to
> > kunmap_local() in dir_put_page().
> >=20
> > Don't backport without commit 88d7b12068b9 ("highmem: round down the
> > address passed to kunmap_flush_on_unmap()").
>=20
> Applied (#work.misc).

Thanks!

I'm using (again, sorry) this opportunity to remind you that I'd really=20
appreciate if you could also set aside some time to look at my patch to fs/
aio.c.

Instead I'm not sure yet who is at the moment responsible for the patches t=
o=20
fs/ufs...=20

> FWIW, I've rebased the ext2 series to -rc1 (and
> realized what got Jan confused about ext2_rename() changes).

I just git-clone(ed) your "vfs" tree and started with building and testing =
the =20
#work.ext2 branch, without and with your latest commits (from Linux 6.3-rc1=
=20
merge onward).

As said in the thread with the pull request of my fs/sysv related patches I=
'll=20
test with (x)fstests in a QEMU/KVM x86_32 VM, 6GB RAM, running an HIGHMEM64=
GB=20
kernel.

> Re minixfs: it's actually very close to sysv, so much that at one point
> I considered merging them - making minixfs one of sysvfs flavours.

OK, so porting fs/sysv (or fs/ufs) changes to fs/minix should be an easy ta=
sk.

> Think of it as v7 filesystem with the simpler improvements copied from
> FFS.  Cylinder groups and variable-sized directory entries - too
> complex for Minix purposes.  Lifting the name length limit from 14 to
> 30 - sure, why not?  32bit block numbers - eventually made it,
> so did 32bit inode numbers (in v3).
>=20
> The main advance compared to v7 is the use of bitmaps for block
> and inode allocation.  Unlike FFS it's all in one lump, but at least
> it's not the "free block list".
>=20
> For directory contents handling it doesn't matter at all - there minixfs
> is really just another sysvfs variant.  Directory is stored the same
> way as a regular file would've been, the data in it is an array of
> fixed-sized entries (16, 32 or 64 bytes, depending upon the filesystem
> version), each consisting of inode number (2 or 4 bytes) + array of
> characters representing the name; name shorter than the longest possible
> are NUL-terminated.
>=20
> Anyway, I've slapped together a counterpart of your sysv series,
> see #work.minix

I must admit that I don't yet own enough good knowledge of the details you =
are=20
mentioning above. However, thanks for sharing!

Those insights surely help me to better understand what details to look at=
=20
when trying to tell the differences and commonalities between filesystems.

I'll take a look at #work.minix in the next days (build, test, review), but=
=20
only when I'm done with #work.ext2 (I have little spare time because ATM I'=
m=20
attending some courses and, in the meantime, I'm also volunteering as a co-
mentor with Ira).

Again thanks,

=46abio



