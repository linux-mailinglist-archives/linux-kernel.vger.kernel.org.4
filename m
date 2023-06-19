Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2055735853
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjFSNSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjFSNSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:18:06 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7919124;
        Mon, 19 Jun 2023 06:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687180639; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=NBdXVMn5z9fWMBGwVqYqBoCyLpHQOCJwzIifpNUC3TNjRszlZfWK5/y5Eu/4/ZNFgfcrNJcq/BeSieQz9R4nNLvdHrcQ4MoaPQ02kt+PpuWmAc7XmfLn2XcReii6LBjkj/VFKDhw/bBbkJ8+YRhgHi/abmZhJe40zrMiAe+v0zE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1687180639; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=GvzDRB8KKM+eFSppRsIz/VHygepCr5cjnv/6S4U0hdo=; 
        b=fUJTI8z4jxlOoFSClv9SIhRkvh9fvRZdeXFs6G7rPwLtxlxLu2uWnL9RQrxLKZhO5E+Chj6oUHI6Xd9gtmDsHXHjfXEWtjvDQ9D5Y0CvT+B0J4P5JmJ4CbhYdIBkQ2EQepwli73ETqlxfgyonypPgThRg6ZfBH8fTnz67WpoABw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1687180639;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=GvzDRB8KKM+eFSppRsIz/VHygepCr5cjnv/6S4U0hdo=;
        b=GPgWrcCZkH2OW2/Y3pftJf/rXBY+6/GUt0qVsBANuoi/UFFygltgRbHJR9jkmaxi
        lJR+BnOPBtctgxnydC7ePBSwCLdjyJHhxOAp0kIJn6+kUHiowQ/cLkirmSsqUUCXv+C
        1yMeqKIpaXjSO2yE6e6RS2fnjMFYi6RSMcPWun6c=
Received: from kampyooter.. (223.179.149.51 [223.179.149.51]) by mx.zoho.in
        with SMTPS id 1687180638188470.44972217847703; Mon, 19 Jun 2023 18:47:18 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Dave Kleikamp <dave.kleikamp@oracle.com>,
        Hoi Pok Wu <wuhoipok@gmail.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+d2cd27dcf8e04b232eb2@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Message-ID: <20230619131644.118332-1-code@siddh.me>
Subject: [PATCH v2] jfs: jfs_dmap: Validate db_l2nbperpage while mounting
Date:   Mon, 19 Jun 2023 18:46:44 +0530
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Max number of pages =3D Page size / Min block size
=3D> log2(Max number of pages) =3D log2(Page size / Min block size)
=09=09=09     =3D log2(Page size) - log2(Min block size)

=3D> Max db_l2nbperpage =3D L2PSIZE - L2MINBLOCKSIZE

Reported-and-tested-by: syzbot+d2cd27dcf8e04b232eb2@syzkaller.appspotmail.c=
om
Closes: https://syzkaller.appspot.com/bug?id=3D2a70a453331db32ed491f5cbb07e=
81bf2d225715
Cc: stable@vger.kernel.org
Suggested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
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


