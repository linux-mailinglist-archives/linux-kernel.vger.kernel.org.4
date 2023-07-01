Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFED744887
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjGAKqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 06:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGAKqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 06:46:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CA53ABD;
        Sat,  1 Jul 2023 03:46:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso20566785e9.2;
        Sat, 01 Jul 2023 03:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688208392; x=1690800392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzefV+3/bAJMZ1EY+HGNx4UGOVXv5aV6u0IMJ/RBDac=;
        b=iJswOWoZx5k/NxJpQ7GfKhnESQo3LOeNouBwm7HBDMl0qAewRMwylXGzb8WDgn7MzD
         8Ljj2SBcezmseI1NsObGf8ATwMIfa6t+0JHzeXWJRp9foeDDZ+L40jfV0jTmX/UPFWDY
         FjGPhaUOMd9EN43lUeiHpLS2niRJ9uyy8IJBKMq0X9y4OHpe+6c8hqS122QKN/p7p/Mx
         dg2r3jvliluD4c/2hxb923s51mMJBfuKH5LOjVWAqK3b5iruhHvP4yS5zkPZRTu4h/tF
         8hZU0+KniuJTEyxSh2Zi3bDv2vnxhMv1mnkW0Iy+akg563oCNtEElWEb1DkPDUIgWlPh
         d1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688208392; x=1690800392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzefV+3/bAJMZ1EY+HGNx4UGOVXv5aV6u0IMJ/RBDac=;
        b=Yq6IydSb2rbcYr218xbIvJrXOifGUk+1NiG/EB6VygQCumgwfX06m3qzjrDoeW+V6X
         oBjVFhL5uw6+/tribnFoOAPzdTi6lLCYO9tT9D/Q/jr1ynjpJI/CaZT57DdSdsfg16Z3
         yIRrLIPMMUBQopS8I7mXhykiHA8Iys/bq0n1vy7e0roPLFkySjOtBodpr+9ZrzAc8p+h
         ifdTGJ37W0S8bxKVGDXysXk6bB+8qBfzj0ybZHocpcNX/Q0gwGwLGnfNWgpX4jLp94xE
         7KLB/qiySYBFbyy9cargU9JtqIKW1gwM6IB1kILi5EqoSsJlHdfb6Yvqtf3c8BxyIhgB
         fEEw==
X-Gm-Message-State: ABy/qLYLN/8i0CN+3Cb9JLYVeIbUXVpRVCbbsm41J8bUZ4pwcGE/7zBQ
        nY7uI8PetVLLkPrAf4rKFFM=
X-Google-Smtp-Source: APBJJlHYp6Irr5YsvAuGHlnzU/mEKNkJcMWaw8V8ImtI2VJXGUQ7qua7fyOzUaSgk5SwWnj2X6w/+g==
X-Received: by 2002:a5d:4f08:0:b0:314:10c1:881d with SMTP id c8-20020a5d4f08000000b0031410c1881dmr3643560wru.68.1688208392184;
        Sat, 01 Jul 2023 03:46:32 -0700 (PDT)
Received: from suse.localnet (host-212-171-6-230.retail.telecomitalia.it. [212.171.6.230])
        by smtp.gmail.com with ESMTPSA id u8-20020adfdd48000000b0030ae6432504sm20388152wrm.38.2023.07.01.03.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 03:46:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Tyler Hicks <code@tyhicks.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 0/3] fs/ecryptfs: Replace kmap{,_atomic}() with
 kmap_local_page()
Date:   Sat, 01 Jul 2023 12:46:29 +0200
Message-ID: <1852492.atdPhlSkOF@suse>
In-Reply-To: <20230630-umfang-pumpt-a0cd2d6cdd91@brauner>
References: <20230426172223.8896-1-fmdefrancesco@gmail.com>
 <20230630-umfang-pumpt-a0cd2d6cdd91@brauner>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On venerd=EC 30 giugno 2023 10:45:17 CEST Christian Brauner wrote:
> On Wed, 26 Apr 2023 19:22:20 +0200, Fabio M. De Francesco wrote:
> > kmap() and kmap_atomic() have been deprecated in favor of
> > kmap_local_page().
> >=20
> > Therefore, replace kmap() and kmap_atomic() with kmap_local_page().
> >=20
> > Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> > HIGHMEM64GB enabled.
> >=20
> > [...]
>=20
> Picking this up.

Well, you anticipated me before I could ask you to take these patches throu=
gh=20
the VFS tree, as suggested by Eric.

> Please tell me if this should be routed somewhere else.
> vfs.misc will be rebased once v6.5-rc1 is released.

Actually, I really don't care which route they take, what really matters to=
 me=20
is that they get upstream one way or another :-)

Thank you very much,

=46abio

> ---
>=20
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
>=20
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>=20
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>=20
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
>=20
> [1/3] fs/ecryptfs: Replace kmap() with kmap_local_page()
>       https://git.kernel.org/vfs/vfs/c/7a367455b6a5
> [2/3] fs/ecryptfs: Use kmap_local_page() in ecryptfs_write()
>       https://git.kernel.org/vfs/vfs/c/55f13011af9d
> [3/3] fs/ecryptfs: Use kmap_local_page() in copy_up_encrypted_with_header=
()
>       https://git.kernel.org/vfs/vfs/c/de9f5a15080f




