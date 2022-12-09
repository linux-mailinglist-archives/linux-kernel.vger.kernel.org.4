Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6206480DB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiLIKWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLIKWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:22:40 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF7A28B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 02:22:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670581320; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=JKZvFEQC0s+u8mPgmbSg+4UnMydSwUlXT7fqoEejG0SsstB2FdiD4GRHE7PDef5NucFMzmuyqfZUZ4XSG5LtfL/xGPS42BG6JJvUDLUoVbEg70I+2I+3PBGnTt1xWLJuUk5xyuANF9q+XYCUQLcA2xRfJZYl5SXwME+3pdUEhik=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1670581320; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=JUZ1nbgPyt696GphUrYZhsJZC+42uCS/7nfOQ2ALbBw=; 
        b=M1BKZrHabNPzWfYVHg9Yse+zEUwQV4k89Js9gDG2v79E0BICX7ASemKskTNQJDIY88VAdPfwtFMQY7AwuOpJcawS3JW/wd9GhgLo9tGbrIOaM1+taio25LZj+iTR6PZgH9qKO9mhPA9ZjuXJ48cwZAuHggaOOmoun8XxN+szwVY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670581320;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=JUZ1nbgPyt696GphUrYZhsJZC+42uCS/7nfOQ2ALbBw=;
        b=PnHtyBfHVkuau6YA04pqos05PXgOlGNy0VcBY3he0rTBjMNJyRAW6qaPXmsza0HO
        0VyxwpcH6xfOsYolR5JBbzsSWq4/mesBZ7YWeS5Zc25X5ThW3sZDN58KDTnrZrYz5P5
        tD6X1rPuj58lK671Zf7j3cbU8LvLzDt1TxsffB1k=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1670581318019810.3770917612286; Fri, 9 Dec 2022 15:51:58 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
Message-ID: <20221209102151.311049-1-code@siddh.me>
Subject: [PATCH v2] erofs/zmap.c: Fix incorrect offset calculation
Date:   Fri,  9 Dec 2022 15:51:51 +0530
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Effective offset to add to length was being incorrectly calculated,
which resulted in iomap->length being set to 0, triggering a WARN_ON
in iomap_iter_done().

Fix that, and describe it in comments.

This was reported as a crash by syzbot under an issue about a warning
encountered in iomap_iter_done(), but unrelated to erofs.

C reproducer: https://syzkaller.appspot.com/text?tag=3DReproC&x=3D1037a6b28=
80000
Kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3De2=
021a61197ebe02
Dashboard link: https://syzkaller.appspot.com/bug?extid=3Da8e049cd3abd34293=
6b6

Reported-by: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
Changes since v2:
- Fix the calculation instead of bailing out.

 fs/erofs/zmap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 0bb66927e3d0..a171e4caba3c 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -790,12 +790,16 @@ static int z_erofs_iomap_begin_report(struct inode *i=
node, loff_t offset,
 =09=09iomap->type =3D IOMAP_HOLE;
 =09=09iomap->addr =3D IOMAP_NULL_ADDR;
 =09=09/*
-=09=09 * No strict rule how to describe extents for post EOF, yet
-=09=09 * we need do like below. Otherwise, iomap itself will get
+=09=09 * No strict rule on how to describe extents for post EOF, yet
+=09=09 * we need to do like below. Otherwise, iomap itself will get
 =09=09 * into an endless loop on post EOF.
+=09=09 *
+=09=09 * Calculate the effective offset by subtracting extent start
+=09=09 * (map.m_la) from the requested offset, and add it to length.
+=09=09 * (NB: offset >=3D map.m_la always)
 =09=09 */
 =09=09if (iomap->offset >=3D inode->i_size)
-=09=09=09iomap->length =3D length + map.m_la - offset;
+=09=09=09iomap->length =3D length + offset - map.m_la;
 =09}
 =09iomap->flags =3D 0;
 =09return 0;
--=20
2.35.1


