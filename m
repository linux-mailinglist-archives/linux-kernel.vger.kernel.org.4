Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B556E723770
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbjFFGTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbjFFGSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:18:48 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D875E54;
        Mon,  5 Jun 2023 23:18:42 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3566BWxS003140;
        Tue, 6 Jun 2023 06:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=VPu/25lfyZpgHSj8sGg1O++Rr3OAaane9l0fJPC+G0g=;
 b=PjpihZ1P+YkPEwggICb1tmMtJAONTVxgxspiwjjD/h8VF6Zuxr2tGb90BKgNDIwVu1AI
 Io7vOvNAvE221P6ggAYt9WrT+1/YgUTttDk/XsgNgkgaU+YyGV+3mJjtvSm5WcTCl0fA
 W55ea3g8ieKMZ+rhB28qtZJ2ZbAAdt73Lxb2UnXTm8Enoi298paNfa+ZtfUEcCGgnTP8
 STRWfTIR57ONQsp1GU80VFQXzrN/soh777CwwDb/Y6EInCtvlqSgTLRIdk8982zw9MQR
 1Gr4SoE08eDeW8Aaq5w7/KHeTNEPz2uUF/c1fHlkoc3/sa8KLYZd0hK5rU8xAdoU1Lt6 dw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1y4rg99u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 06:18:37 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3565XEMb027288;
        Tue, 6 Jun 2023 06:18:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3qyx5q9d97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 06:18:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3566IX2Y30867804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Jun 2023 06:18:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EF6320043;
        Tue,  6 Jun 2023 06:18:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5402420040;
        Tue,  6 Jun 2023 06:18:32 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  6 Jun 2023 06:18:32 +0000 (GMT)
Received: from [10.61.2.107] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C49FA600E2;
        Tue,  6 Jun 2023 16:18:30 +1000 (AEST)
Message-ID: <c4f554ee05d92858e821399ff8cceba487297945.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] initramfs: Encode dependency on
 KBUILD_BUILD_TIMESTAMP
From:   Benjamin Gray <bgray@linux.ibm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Date:   Tue, 06 Jun 2023 16:18:30 +1000
In-Reply-To: <CAK7LNAT=kuXeKDiPLgVwxZAW3OHXwjreU9-o+fGK3Phgks+-PA@mail.gmail.com>
References: <20230320040839.660475-1-bgray@linux.ibm.com>
         <20230320040839.660475-2-bgray@linux.ibm.com>
         <CAK7LNASxnyFmM1JhuDatQfb4WMy616LzAqS3JzmNxb3wJGA52g@mail.gmail.com>
         <CAK7LNAT=kuXeKDiPLgVwxZAW3OHXwjreU9-o+fGK3Phgks+-PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rXI6a4F9syq8QPobjIE3tzeRatO6SxPf
X-Proofpoint-GUID: rXI6a4F9syq8QPobjIE3tzeRatO6SxPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_03,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-06-06 at 13:14 +0900, Masahiro Yamada wrote:
> Hi Benjamin,
>=20
>=20
> I like this patch.
>=20
> Will you send v2 with fixes I pointed out?
> (add double-quotes and remove the unneeded comment)
>=20
>=20
> On Sun, Apr 16, 2023 at 1:06=E2=80=AFPM Masahiro Yamada
> <masahiroy@kernel.org> wrote:
> >=20
> > On Mon, Mar 20, 2023 at 1:09=E2=80=AFPM Benjamin Gray <bgray@linux.ibm.=
com>
> > wrote:
> > >=20
> > > gen_initramfs.sh has an internal dependency on
> > > KBUILD_BUILD_TIMESTAMP
> > > for generating file mtimes that is not exposed to make, so
> > > changing
> > > KBUILD_BUILD_TIMESTAMP will not trigger a rebuild of the archive.
> > >=20
> > > Declare the mtime date as a new parameter to gen_initramfs.sh to
> > > encode
> > > KBUILD_BUILD_TIMESTAMP in the shell command, thereby making make
> > > aware
> > > of the dependency.
> > >=20
> > > It will rebuild if KBUILD_BUILD_TIMESTAMP changes or is newly
> > > set/unset.
> > > It will _not_ rebuild if KBUILD_BUILD_TIMESTAMP is unset before
> > > and
> > > after. This should be fine for anyone who doesn't care about
> > > setting
> > > specific build times in the first place.
> > >=20
> > > Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> > >=20
> > > ---
> > >=20
> > > Ran into this while debugging the issue in the first patch. Made
> > > for a
> > > very perplexing debug session before we worked out the state
> > > wasn't
> > > being rebuilt.
> > > ---
> > > =C2=A0usr/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 ++
> > > =C2=A0usr/gen_initramfs.sh | 16 +++++++++-------
> > > =C2=A02 files changed, 11 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/usr/Makefile b/usr/Makefile
> > > index 59d9e8b07a01..2aa386cf48d6 100644
> > > --- a/usr/Makefile
> > > +++ b/usr/Makefile
> > > @@ -64,6 +64,7 @@ quiet_cmd_initfs =3D GEN=C2=A0=C2=A0=C2=A0=C2=A0 $@
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(CONFIG_SHELL) $< -o $@ -=
l $(obj)/.initramfs_data.cpio.d
> > > \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(if $(CONFIG_INITRAMFS_RO=
OT_UID), -u
> > > $(CONFIG_INITRAMFS_ROOT_UID)) \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(if $(CONFIG_INITRAMFS_RO=
OT_GID), -g
> > > $(CONFIG_INITRAMFS_ROOT_GID)) \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(if $(KBUILD_BUILD_TIMESTAMP),=
 -d
> > > $(KBUILD_BUILD_TIMESTAMP)) \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(ramfs-input)
> >=20
> >=20
> >=20
> > If I apply this patch, I see a build error.
> >=20
> >=20
> > $ make -j16 KBUILD_BUILD_TIMESTAMP=3D"$(date)"
> > [snip]
> > =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0 usr/initramfs_data.cpio
> > =C2=A0 usr/gen_initramfs.sh: Cannot open 'Apr'
> > make[2]: *** [usr/Makefile:76: usr/initramfs_data.cpio] Error 1
> > make[1]: *** [scripts/Makefile.build:494: usr] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> >=20
> >=20
> >=20
> >=20
> > Because KBUILD_BUILD_TIMESTAMP may contain spaces
> > depending on the format, init/Makefile and
> > kernel/gen_kheaders.sh surround the date with
> > double-quotes.
> >=20
> >=20
> > Double-quoting it in the same way fixes the issue.
> >=20
> > $(if $(KBUILD_BUILD_TIMESTAMP), -d "$(KBUILD_BUILD_TIMESTAMP)") \
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > > =C2=A0# We rebuild initramfs_data.cpio if:
> > > @@ -71,6 +72,7 @@ quiet_cmd_initfs =3D GEN=C2=A0=C2=A0=C2=A0=C2=A0 $@
> > > =C2=A0# 2) There are changes in which files are included (added or
> > > deleted)
> > > =C2=A0# 3) If gen_init_cpio are newer than initramfs_data.cpio
> > > =C2=A0# 4) Arguments to gen_initramfs.sh changes
> > > +# 5) KBUILD_BUILD_TIMESTAMP is changed
> >=20
> >=20
> > This is unneeded because the change of KBUILD_BUILD_TIMESTAMP
> > is contained in
> >=20
> > =C2=A0 4) Arguments to gen_initramfs.sh changes
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > > =C2=A0$(obj)/initramfs_data.cpio: $(src)/gen_initramfs.sh
> > > $(obj)/gen_init_cpio $(deps_initramfs) FORCE
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call if_changed,initfs)
> > >=20
> > > diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
> > > index 63476bb70b41..14b5782f961a 100755
> > > --- a/usr/gen_initramfs.sh
> > > +++ b/usr/gen_initramfs.sh
> > > @@ -23,6 +23,7 @@ $0 [-o <file>] [-l <dep_list>] [-u <uid>] [-g
> > > <gid>] {-d | <cpio_source>} ...
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -g <gid>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Group ID to map to group ID 0 (root).
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <gid> is on=
ly meaningful if <cpio_source>
> > > is a
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 directory.=
=C2=A0 "squash" forces all files to
> > > gid 0.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -d <date>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Use date for all file mtime values
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <cpio_source>=C2=A0 File l=
ist or directory for cpio archive.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If <cpio_so=
urce> is a .cpio file it will
> > > be used
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as direct i=
nput to initramfs.
> > > @@ -190,6 +191,7 @@ prog=3D$0
> > > =C2=A0root_uid=3D0
> > > =C2=A0root_gid=3D0
> > > =C2=A0dep_list=3D
> > > +timestamp=3D
> > > =C2=A0cpio_list=3D$(mktemp ${TMPDIR:-/tmp}/cpiolist.XXXXXX)
> > > =C2=A0output=3D"/dev/stdout"
> > >=20
> > > @@ -218,6 +220,13 @@ while [ $# -gt 0 ]; do
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ "$r=
oot_gid" =3D "-1" ] && root_gid=3D$(id -
> > > g || echo 0)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shift
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "-d")=C2=A0=C2=A0 # date for file mtimes
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timestam=
p=3D"$(date -d"$1" +%s || :)"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if test =
-n "$timestamp"; then
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timestamp=3D"-t $timestamp"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shift
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "-h")
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usage
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit =
0
> > > @@ -237,11 +246,4 @@ done
> > >=20
> > > =C2=A0# If output_file is set we will generate cpio archive
> > > =C2=A0# we are careful to delete tmp files
> > > -timestamp=3D
> > > -if test -n "$KBUILD_BUILD_TIMESTAMP"; then
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timestamp=3D"$(date -d"$KBUILD_=
BUILD_TIMESTAMP" +%s || :)"
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if test -n "$timestamp"; then
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 timestamp=3D"-t $timestamp"
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
> > > -fi
> > > =C2=A0usr/gen_init_cpio $timestamp $cpio_list > $output
> > > --
> > > 2.39.2
> > >=20
> >=20
> >=20
> > --
> > Best Regards
> > Masahiro Yamada
>=20
>=20
>=20
> --
> Best Regards
> Masahiro Yamada

Sorry, I forgot to follow up on this one. Sent the v2 now.
