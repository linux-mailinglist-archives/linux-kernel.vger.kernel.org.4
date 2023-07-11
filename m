Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05EA74E2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 02:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGKAxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 20:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjGKAxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:53:43 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3297EAF;
        Mon, 10 Jul 2023 17:53:42 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b8a6ca994eso4514551a34.1;
        Mon, 10 Jul 2023 17:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689036821; x=1691628821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TlH6F/OufMM8Ka/LNuOcbo5rYmpkl9l/kq7tYFybC5o=;
        b=XuCZOc6WJ1crJ6/ynTjn6wD0VJ7nGUtHeSlU0puj77UbrrcA71Tqhqsb2VCWnmQy/M
         5vu2HKoKCbYrx4kqN6OG/RlHlw6YJoYNqBt1+ZeKRnEDDbjJK/d9Dpy6ZAT52pf8UgrO
         PiVST+pweOb+/mRCxGSB+TcqVxw73rbFSDMHKMykIVtjLWd2eMYn8DKad8LQevbnXG8T
         ZnJ+z1/kl+wSyUuWUYc360bEMoqx3NvuPrhoX/scs/q/cwOZclPwbZYnmmHfzqHtduuq
         ZHRB59EJqM1yWDMc5APMPqYeYSNN3+sF30lXn43u5PN386WMItdfxSIedcZm9aDkOMDS
         Oxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689036821; x=1691628821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlH6F/OufMM8Ka/LNuOcbo5rYmpkl9l/kq7tYFybC5o=;
        b=UqN6zLRhFyQWuV0Ld6qeneMlvZWDnLieaE22Na6TEL5WK0iSYXNFErU0Es5ojtSON0
         +2nAHEf+kWNF/Vn00J3NOBWc+g5klRQVGE9qTDTOUBhR55rsYRPY40OQfmAt49fDtIz/
         d9efb2W94/Vk5fK4BnCMYt/3zH5L6cTZgiAax40C4GP3qqLqzUjaFSsUXdvlWJ/pjPTc
         iIs8C7eSZNcKZfy4JmLRdv8tHCzaKJkJ7R3SQlWWJBTMp03fm+P0jLhDGJkg0X5AkX5z
         E3W5k8BhZ9Q+3vJAcDEipr52S3WwQk3I/GvjKIVtlS0eedTyn2z2neLYphkLjTb5rw8Y
         Le8w==
X-Gm-Message-State: ABy/qLbwzTLDzZm9Q7zPswupixY0QXJ/ZlyHERNteKXPWveUZ/9tjRUr
        ApKf57hgrRevlb341EaURIs=
X-Google-Smtp-Source: APBJJlFGQ3yZMJHHulUmPV5TtKIfi0FMQWSyswOOo0THiqarbZQml2R6/2NevozOESSq9etcx4oFPA==
X-Received: by 2002:a05:6870:46a0:b0:1b3:7e8e:2b1b with SMTP id a32-20020a05687046a000b001b37e8e2b1bmr14916279oap.34.1689036821231;
        Mon, 10 Jul 2023 17:53:41 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 24-20020a17090a035800b00263f5ac814esm7407929pjf.38.2023.07.10.17.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 17:53:40 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 229758197D16; Tue, 11 Jul 2023 07:53:35 +0700 (WIB)
Date:   Tue, 11 Jul 2023 07:53:35 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Chris Dunlop <chris@onthe.net.au>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linux Stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: rm hanging, v6.1.35
Message-ID: <ZKyoD7WDKfzsKAaT@debian.me>
References: <20230710215354.GA679018@onthe.net.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GhqsgA1hSdl/QpsA"
Content-Disposition: inline
In-Reply-To: <20230710215354.GA679018@onthe.net.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GhqsgA1hSdl/QpsA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 07:53:54AM +1000, Chris Dunlop wrote:
> Hi,
>=20
> This box is newly booted into linux v6.1.35 (2 days ago), it was previous=
ly
> running v5.15.118 without any problems (other than that fixed by
> "5e672cd69f0a xfs: non-blocking inodegc pushes", the reason for the
> upgrade).
>=20
> I have rm operations on two files that have been stuck for in excess of 22
> hours and 18 hours respectively:
>=20
> $ ps -opid,lstart,state,wchan=3DWCHAN-xxxxxxxxxxxxxxx,cmd -C rm
>     PID                  STARTED S WCHAN-xxxxxxxxxxxxxxx CMD
> 2379355 Mon Jul 10 09:07:57 2023 D vfs_unlink            /bin/rm -rf /aaa=
/5539_tmp
> 2392421 Mon Jul 10 09:18:27 2023 D down_write_nested     /bin/rm -rf /aaa=
/5539_tmp
> 2485728 Mon Jul 10 09:28:57 2023 D down_write_nested     /bin/rm -rf /aaa=
/5539_tmp
> 2488254 Mon Jul 10 09:39:27 2023 D down_write_nested     /bin/rm -rf /aaa=
/5539_tmp
> 2491180 Mon Jul 10 09:49:58 2023 D down_write_nested     /bin/rm -rf /aaa=
/5539_tmp
> 3014914 Mon Jul 10 13:00:33 2023 D vfs_unlink            /bin/rm -rf /bbb=
/5541_tmp
> 3095893 Mon Jul 10 13:11:03 2023 D down_write_nested     /bin/rm -rf /bbb=
/5541_tmp
> 3098809 Mon Jul 10 13:21:35 2023 D down_write_nested     /bin/rm -rf /bbb=
/5541_tmp
> 3101387 Mon Jul 10 13:32:06 2023 D down_write_nested     /bin/rm -rf /bbb=
/5541_tmp
> 3195017 Mon Jul 10 13:42:37 2023 D down_write_nested     /bin/rm -rf /bbb=
/5541_tmp
>=20
> The "rm"s are run from a process that's obviously tried a few times to get
> rid of these files.
>=20
> There's nothing extraordinary about the files in terms of size:
>=20
> $ ls -ltrn --full-time /aaa/5539_tmp /bbb/5541_tmp
> -rw-rw-rw- 1 1482 1482 7870643 2023-07-10 06:07:58.684036505 +1000 /aaa/5=
539_tmp
> -rw-rw-rw- 1 1482 1482  701240 2023-07-10 10:00:34.181064549 +1000 /bbb/5=
541_tmp
>=20
> As hinted by the WCHAN in the ps output above, each "primary" rm (i.e. the
> first one run on each file) stack trace looks like:
>=20
> [<0>] vfs_unlink+0x48/0x270
> [<0>] do_unlinkat+0x1f5/0x290
> [<0>] __x64_sys_unlinkat+0x3b/0x60
> [<0>] do_syscall_64+0x34/0x80
> [<0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>=20
> And each "secondary" rm (i.e. the subsequent ones on each file) stack tra=
ce
> looks like:
>=20
> =3D=3D blog-230710-xfs-rm-stuckd
> [<0>] down_write_nested+0xdc/0x100
> [<0>] do_unlinkat+0x10d/0x290
> [<0>] __x64_sys_unlinkat+0x3b/0x60
> [<0>] do_syscall_64+0x34/0x80
> [<0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>=20
> Multiple kernel strack traces don't show vfs_unlink or anything related t=
hat
> I can see, or anything else consistent or otherwise interesting. Most cor=
es
> are idle.
>=20
> Each of /aaa and /bbb are separate XFS filesystems:
>=20
> $ xfs_info /aaa
> meta-data=3D/dev/mapper/aaa        isize=3D512    agcount=3D2, agsize=3D2=
68434432 blks
>          =3D                       sectsz=3D4096  attr=3D2, projid32bit=
=3D1
>          =3D                       crc=3D1        finobt=3D1, sparse=3D1,=
 rmapbt=3D1
>          =3D                       reflink=3D1    bigtime=3D1 inobtcount=
=3D1
> data     =3D                       bsize=3D4096   blocks=3D536868864, ima=
xpct=3D5
>          =3D                       sunit=3D256    swidth=3D256 blks
> naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0, ftype=3D1
> log      =3Dinternal log           bsize=3D4096   blocks=3D262143, versio=
n=3D2
>          =3D                       sectsz=3D4096  sunit=3D1 blks, lazy-co=
unt=3D1
> realtime =3Dnone                   extsz=3D4096   blocks=3D0, rtextents=
=3D0
>=20
> $ xfs_info /bbb
> meta-data=3D/dev/mapper/bbb        isize=3D512    agcount=3D8, agsize=3D2=
68434432 blks
>          =3D                       sectsz=3D4096  attr=3D2, projid32bit=
=3D1
>          =3D                       crc=3D1        finobt=3D1, sparse=3D1,=
 rmapbt=3D1
>          =3D                       reflink=3D1    bigtime=3D1 inobtcount=
=3D1
> data     =3D                       bsize=3D4096   blocks=3D1879047168, im=
axpct=3D5
>          =3D                       sunit=3D256    swidth=3D256 blks
> naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0, ftype=3D1
> log      =3Dinternal log           bsize=3D4096   blocks=3D521728, versio=
n=3D2
>          =3D                       sectsz=3D4096  sunit=3D1 blks, lazy-co=
unt=3D1
> realtime =3Dnone                   extsz=3D4096   blocks=3D0, rtextents=
=3D0
>=20
> There's plenty of free space at the fs level:
>=20
> $ df -h /aaa /bbb
> Filesystem          Size  Used Avail Use% Mounted on
> /dev/mapper/aaa     2.0T  551G  1.5T  27% /aaa
> /dev/mapper/bbb     7.0T  3.6T  3.5T  52% /bbb
>=20
> The fses are on sparse ceph/rbd volumes, the underlying storage tells me
> they're 50-60% utilised:
>=20
> aaa: provisioned=3D"2048G" used=3D"1015.9G"
> bbb: provisioned=3D"7168G" used=3D"4925.3G"
>=20
> Where to from here?
>=20
> I'm guessing only a reboot is going to unstick this. Anything I should be
> looking at before reverting to v5.15.118?
>=20
> ...subsequent to starting writing all this down I have another two sets of
> rms stuck, again on unremarkable files, and on two more separate
> filesystems.
>=20
> ...oh. And an 'ls' on those files is hanging. The reboot has become more
> urgent.
>=20

Smells like regression resurfaced, right? I mean, does 5e672cd69f0a53 not
completely fix your reported blocking regression earlier?

I'm kinda confused...

--=20
An old man doll... just what I always wanted! - Clara

--GhqsgA1hSdl/QpsA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZKyoCwAKCRD2uYlJVVFO
ox6KAQD2Aa2hpid2mNF13QCdctw+xIPLLJVu7x29O65bMaQgBAEAxY/5ZQTSxAIa
9kjCu9oKY1syCtfQKaf0dXrQixI9/gY=
=P7Ru
-----END PGP SIGNATURE-----

--GhqsgA1hSdl/QpsA--
