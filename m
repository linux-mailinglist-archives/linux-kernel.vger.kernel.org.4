Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777A4648CFD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 04:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLJDvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 22:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiLJDvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 22:51:09 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8CE60EB7;
        Fri,  9 Dec 2022 19:51:05 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id jl24so6850253plb.8;
        Fri, 09 Dec 2022 19:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Z1BxGqgHITzxO8Bw1N1uCOjsI728aaE4AlHdATKeMY=;
        b=f+DxILPCiJEbc3+xycVStaiFr60dHklhd9G068nwGG1d6SfL1d7MTVFBW2kC027c/X
         kD+IQ/CMX1QBrt2LoumioD57wI/07k2HHIstp1PZC5Ci/MsZlgtDnT948fkpgqEOuRPE
         hN+kSiqO0Lc/uKx6qc94XL40oyB5c5EWEZr9yVpZbfF4ZGguSe8hXqtJRL5jOOAmRt7t
         ZkXCy6oL8Nf4xkkGkcWAFGzw2dzaDF832rFg1t6KjkkEEuGl2gyz5lFFFJ5kAxUhoGmq
         0GZ6tuqlSXH3zK12qTVApHROmJaTU+t1lMIgtlReHTcARzZRLQcNyl+dKyQzXFxBTYmK
         XhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Z1BxGqgHITzxO8Bw1N1uCOjsI728aaE4AlHdATKeMY=;
        b=kj3eVe4xufZGvjh6CZaYw4QBiL8SP4IWjqx68kdy0nkR2wv+ty3suVsqROjAoBJZ6L
         SFxEXhNhYHkxb3TlIXIPepWiRBwQckS5jvGu4ij14J8NQBdVV2XMKZA+9MwaUS7Ku0Kh
         SOweX4PQXbpRAKvHIn6VvMaS3sEaPboQ8oAgmYXqKPHlEsCXNdHnotHwODGfV3qBZNLo
         TszziLaPDsVhwhxCk1+QVB0awauEEJXkFo5amryjJFoXDtntHo6ueKefKjv0TohrLz3j
         eNaODaNNy7WzBe60KUIEydSJCfmwxVT0Vw48PFwBmicdV1rjO9Iz9FDx/+yn6AmQMfCh
         Ktwg==
X-Gm-Message-State: ANoB5pk1JRxspA7DwU54VrJzteNReUglWqmg8Jdo7euxrXarsECEPJ/x
        eUVNScD5TgW3bgXrujoLQQc=
X-Google-Smtp-Source: AA0mqf4rCVdO8UL0ztSnV+pTxDUcUzFbCj5XZieEIPqwQnHFA5oe7BYNe4+ZjB0ris45py/m6zJN1g==
X-Received: by 2002:a17:902:7890:b0:188:fc0c:cdb1 with SMTP id q16-20020a170902789000b00188fc0ccdb1mr8238689pll.16.1670644265334;
        Fri, 09 Dec 2022 19:51:05 -0800 (PST)
Received: from debian.me (subs02-180-214-232-76.three.co.id. [180.214.232.76])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902a3cf00b0016d9b101413sm1993404plb.200.2022.12.09.19.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 19:51:03 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 18D54103E00; Sat, 10 Dec 2022 10:50:59 +0700 (WIB)
Date:   Sat, 10 Dec 2022 10:50:59 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/21] documentation, blksnap:  Block Devices
 Snapshots Module
Message-ID: <Y5QCI9rXE+HW03ci@debian.me>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20221209142331.26395-5-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="740pxZ5UMCIx1ZPc"
Content-Disposition: inline
In-Reply-To: <20221209142331.26395-5-sergei.shtepa@veeam.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--740pxZ5UMCIx1ZPc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2022 at 03:23:14PM +0100, Sergei Shtepa wrote:
> The document contains:
> * Describes the purpose of the mechanism
> * Description of features
> * Description of algorithms
> * Recommendations about using the module from the user-space side
> * Reference to module interface description

The patch subject should be "Documentation: document Block Devices
Snapshots Module".

Don't forget to write the description in imperative mood instead.

> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +At first glance, there is no novelty in the idea of creating snapshots f=
or
> +block devices. The Linux kernel already has mechanisms for creating snap=
shots.
> +Device Mapper includes dm-snap, which allows to create snapshots of block
> +devices. BTRFS supports snapshots at the file system level. However, both
> +of these options have flaws that do not allow to use them as a universal
> +tool for creating backups.
> +
> +Device Mapper flaws:
> +
> +- Block devices must have LVM markup.
> +  If no logical volumes were created during system installation, then dm=
-snap
> +  cannot be applied.
> +- To store snapshot differences of one logical volume, it is necessary to
> +  reserve a fixed range of sectors on a reserved empty logical volume.
> +  Firstly, it is required that the system has enough space unoccupied by=
 the
> +  file system, which rarely occurs on real servers. Secondly, as a rule,
> +  it is necessary to create snapshots for all logical volumes at once, w=
hich
> +  requires dividing this reserved space between several logical volumes.
> +  This space can be divided equally or proportionally to the size. But
> +  the load on different disks is usually uneven. As a result, a snapshot
> +  overflow may occur for one of the block devices, while for others all
> +  the reserved space may remain free. This complicates management of the
> +  difference storage and makes it almost impossible to create a coherent
> +  snapshot of multiple logical volumes.
> +
> +BTRFS flaws:
> +
> +- Snapshots create a persistent image of the file system, not a block de=
vice.
> +  Such a snapshot is only applicable for a file backup.
> +- When synchronizing the snapshot subvolume with the backup subvolume, r=
eading
> +  the differences leads to random access to the block device, which leads
> +  to decrease in efficiency compared to direct copying of the block devi=
ce.
> +- BTRFS allows to get an incremental backup [#btrfs_increment]_, but it =
is
> +  necessary to keep a snapshot of the previous backup cycle on the syste=
m,
> +  which leads to excessive consumption of disk space.
> +- If there is not enough free space on the file system while holding the
> +  snapshot, new data cannot be saved, which leads to a server malfunctio=
n.
> +
> +Features of the blksnap module:
> +
> +- Change tracker
> +- Snapshots at the block device level
> +- Dynamic allocation of space for storing differences
> +- Snapshot overflow resistance
> +- Coherent snapshot of multiple block devices

There is a jump from drawbacks of existing method to blksnap features.
Before introducing the latter, there should have been blksnap
description and how it solves the drawbacks. Also, the features list
above is redundant due to features section which describes each of them.

> +Static C++ library
> +------------------
> +
> +The [#userspace_libs]_ library was created primarily to simplify creatio=
n of

"The libblksnap [#userspace_libs]_ library was ..."


> +Module interface description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +.. kernel-doc:: include/uapi/linux/blksnap.h

IMO this section should be placed after "How to use" section, because
it's quite odd to add another info after references section.

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--740pxZ5UMCIx1ZPc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5QCHwAKCRD2uYlJVVFO
o28kAP9cdVAiAeRGozPZ57xf/LM6z/ASMVfrquTf9kSnycL3NAEAoW6WPu+U1KsR
azbIOnLYwKahdIXUoQ0AkDbSqBO5Vgw=
=L60b
-----END PGP SIGNATURE-----

--740pxZ5UMCIx1ZPc--
