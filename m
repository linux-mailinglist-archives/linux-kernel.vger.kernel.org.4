Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA0E7228A0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjFEOSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjFEOSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:18:40 -0400
X-Greylist: delayed 909 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 07:18:37 PDT
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953349B;
        Mon,  5 Jun 2023 07:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685973765; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=UEjRH8X+EQPCqNC4TrenHe7UT7DcPjTYAl6zPzWlWo1g81Cw4KiQh1T2LoI8R1bUZiTPlJgwQy0Z6w4RoVYViBt1Z07OcXigTAOfsPUBwjuxKHmLZUJN+ExjzRK2TQrZiTKM4hLQiyPCKLNWkkF/qM+WIEVxx/Fud6rHycoLOTs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1685973765; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=+o71O1pYRWmOO9H0o1rqpmBm9jZwIdAhrIJOrg/czBU=; 
        b=N/ZmxwD6165BXU4zhP4ipTcF/VzkXeXa3LRN9WhvuStU2S9RlHZ7v9eihIpGgmyX4mcAwESK0KTqUCMh5jVhJiPzQZvD1sC1coxBJai8M1pT1wbVqTcf/VD/rZW0ccEJh7vAN9gMe2nT3snbH+WX2aRp1cmGdEnQqkNkLcreMIM=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685973765;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=+o71O1pYRWmOO9H0o1rqpmBm9jZwIdAhrIJOrg/czBU=;
        b=cPs99wbzw9VM349ypot/e1Z/NVpS6rPpcETAKTyMARht2bZHfLZ1ugqSzrDNx6Ef
        fHxfE05xrB5XAxGFj1eJM3LG+KpUNGVak/vUemR8BTRR4OOfd6CAtoWO7dyAcWyIwl5
        3kEPnsDVCmMY8nCFjL0Mr3365nH6V8esLdRVjY2g=
Received: from kampyooter.. (223.236.126.120 [223.236.126.120]) by mx.zoho.in
        with SMTPS id 1685973763050332.8195646780821; Mon, 5 Jun 2023 19:32:43 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Dave Kleikamp <shaggy@kernel.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Hoi Pok Wu <wuhoipok@gmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Anup Sharma <anupnewsmail@gmail.com>,
        syzbot+d2cd27dcf8e04b232eb2@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Message-ID: <20230605140151.635604-1-code@siddh.me>
Subject: [PATCH] jfs: jfs_dmap: Validate db_l2nbperpage while mounting
Date:   Mon,  5 Jun 2023 19:31:51 +0530
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

Reported-and-tested-by: syzbot+d2cd27dcf8e04b232eb2@syzkaller.appspotmail.c=
om
Link: https://syzkaller.appspot.com/bug?id=3D2a70a453331db32ed491f5cbb07e81=
bf2d225715
Cc: stable@vger.kernel.org
Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 fs/jfs/jfs_dmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a3eb1e826947..62f058822a3a 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -178,7 +178,13 @@ int dbMount(struct inode *ipbmap)
 =09dbmp_le =3D (struct dbmap_disk *) mp->data;
 =09bmp->db_mapsize =3D le64_to_cpu(dbmp_le->dn_mapsize);
 =09bmp->db_nfree =3D le64_to_cpu(dbmp_le->dn_nfree);
+
 =09bmp->db_l2nbperpage =3D le32_to_cpu(dbmp_le->dn_l2nbperpage);
+=09if (bmp->db_l2nbperpage > L2MAXL0SIZE) {
+=09=09err =3D -EINVAL;
+=09=09goto err_release_metapage;
+=09}
+
 =09bmp->db_numag =3D le32_to_cpu(dbmp_le->dn_numag);
 =09if (!bmp->db_numag) {
 =09=09err =3D -EINVAL;
--=20
2.39.2


