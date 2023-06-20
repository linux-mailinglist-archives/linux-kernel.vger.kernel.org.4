Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373FC737204
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjFTQsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjFTQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:48:00 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA4D12C;
        Tue, 20 Jun 2023 09:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687279631; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=D4m11pFsGamxvO5rb0IOylq5LfxBXghIsnwdSlCMx8Asbt115Rht6BP5cKIhZVIYdYaLjtEAovUnZ6i4NjCzdfTzlC5DFz9sPXe+ugh2wwIjQJlJOo4JNHWgWPzGXMIi1KyZJ5fzoHpW8gk5Np47TTTnQOmlcta4HQkaw5z4l6E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1687279631; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=2km/+FC5CJNIts5K1Qb08VHKBfl24zZT41xMIlQqDeY=; 
        b=DFekpnqb+jRlpIxgHgOT1GOgDm/vyvzDH2xWccFxYknzZx3j6ydrQBKoS9GDvUlaekI1ncPoS3WpAHRSJNRgPdaOVCtke8gGFHtg6X/NLLflfBH7sa8JJDCK5VG6RBWnMk21NBQqmm9QuE22borHfroVpF+K8YXQtEgEIooN+Wk=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1687279631;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=2km/+FC5CJNIts5K1Qb08VHKBfl24zZT41xMIlQqDeY=;
        b=UVMTwhtWvVf3N5MMxSdUrGbVHiK2b8fo3tBnEKSB/YYx1qthh2NVXOqnj5mOk/iJ
        vd8fkHNKoCG5rKdSBfJjzFBtnUldRPaTwDFztavULupX7v5sBFuw7Z7r+ZDHOmZ3YTE
        1irham1chcJTe9RSFwUfMX9UUVPcN2HgpmZJjBc8=
Received: from kampyooter.. (223.179.149.51 [223.179.149.51]) by mx.zoho.in
        with SMTPS id 1687279629337809.8626610827803; Tue, 20 Jun 2023 22:17:09 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Dave Kleikamp <shaggy@kernel.org>, Hoi Pok Wu <wuhoipok@gmail.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+d2cd27dcf8e04b232eb2@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Dave Kleikamp <dave.kleikamp@oracle.com>
Message-ID: <20230620164700.11083-1-code@siddh.me>
Subject: [PATCH v3] jfs: jfs_dmap: Validate db_l2nbperpage while mounting
Date:   Tue, 20 Jun 2023 22:17:00 +0530
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In jfs_dmap.c at line 381, BLKTODMAP is used to get a logical block
number inside dbFree(). db_l2nbperpage, which is the log2 number of
blocks per page, is passed as an argument to BLKTODMAP which uses it
for shifting.

Syzbot reported a shift out-of-bounds crash because db_l2nbperpage is
too big. This happens because the large value is set without any
validation in dbMount() at line 181.

Thus, make sure that db_l2nbperpage is correct while mounting.

Max number of blocks per page =3D Page size / Min block size
=3D> log2(Max num_block per page) =3D log2(Page size / Min block size)
=09=09=09=09=3D log2(Page size) - log2(Min block size)

=3D> Max db_l2nbperpage =3D L2PSIZE - L2MINBLOCKSIZE

Reported-and-tested-by: syzbot+d2cd27dcf8e04b232eb2@syzkaller.appspotmail.c=
om
Closes: https://syzkaller.appspot.com/bug?id=3D2a70a453331db32ed491f5cbb07e=
81bf2d225715
Cc: stable@vger.kernel.org
Suggested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
Changes in v3:
- Fix typo in commit message (number of pages -> number of blocks per page)=
.

Changes in v2:
- Fix upper bound as pointed out in v1 by Shaggy.
- Add an explanation for the same in commit message for completeness.

 fs/jfs/jfs_dmap.c   | 6 ++++++
 fs/jfs/jfs_filsys.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a3eb1e826947..da6a2bc6bf02 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -178,7 +178,13 @@ int dbMount(struct inode *ipbmap)
 =09dbmp_le =3D (struct dbmap_disk *) mp->data;
 =09bmp->db_mapsize =3D le64_to_cpu(dbmp_le->dn_mapsize);
 =09bmp->db_nfree =3D le64_to_cpu(dbmp_le->dn_nfree);
+
 =09bmp->db_l2nbperpage =3D le32_to_cpu(dbmp_le->dn_l2nbperpage);
+=09if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE) {
+=09=09err =3D -EINVAL;
+=09=09goto err_release_metapage;
+=09}
+
 =09bmp->db_numag =3D le32_to_cpu(dbmp_le->dn_numag);
 =09if (!bmp->db_numag) {
 =09=09err =3D -EINVAL;
diff --git a/fs/jfs/jfs_filsys.h b/fs/jfs/jfs_filsys.h
index b5d702df7111..33ef13a0b110 100644
--- a/fs/jfs/jfs_filsys.h
+++ b/fs/jfs/jfs_filsys.h
@@ -122,7 +122,9 @@
 #define NUM_INODE_PER_IAG=09INOSPERIAG
=20
 #define MINBLOCKSIZE=09=09512
+#define L2MINBLOCKSIZE=09=099
 #define MAXBLOCKSIZE=09=094096
+#define L2MAXBLOCKSIZE=09=0912
 #define=09MAXFILESIZE=09=09((s64)1 << 52)
=20
 #define JFS_LINK_MAX=09=090xffffffff
--=20
2.39.2


