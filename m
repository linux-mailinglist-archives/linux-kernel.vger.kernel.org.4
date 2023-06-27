Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0356773F29E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 05:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjF0D0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 23:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjF0DYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:24:36 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC09246B1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:19:45 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230627031943epoutp034a88025bc379d88afca77f0106146d1b~sZeJpvLrE2868528685epoutp03T
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:19:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230627031943epoutp034a88025bc379d88afca77f0106146d1b~sZeJpvLrE2868528685epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687835983;
        bh=DkBsbbgLtmsEDZwiUlk2kGOzeN7xXEE0fqF3HY7d+/g=;
        h=From:To:Cc:Subject:Date:References:From;
        b=uHa2SoEfJEDqsvtQHa7kIKOQP8H1APH5gZwgCsq31nll093tdJEwMOjDrg+OcCejZ
         CS7du58hpRSsvSaoggqbeOjArex0cRH6qeRVeIMUMtyt3ZrvG9foptIMu9EXbk0uZI
         WeeiMRIzQ3o5GMZa37HtRGSB6VMdh6LZlWdDmBWo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230627031942epcas5p1a9e5a82fd4d915ddd0ca6b3c03b0bb9f~sZeI-pv251523715237epcas5p1M;
        Tue, 27 Jun 2023 03:19:42 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QqqhD2C6Dz4x9Px; Tue, 27 Jun
        2023 03:19:40 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.02.44250.C455A946; Tue, 27 Jun 2023 12:19:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230627031105epcas5p3010432ebd447ad865c3ddd986b3ffee0~sZWnI_f2y0954609546epcas5p3K;
        Tue, 27 Jun 2023 03:11:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230627031105epsmtrp104d4bf6ff43d0e94851b2599537dcdbd~sZWnIMauj1415614156epsmtrp1u;
        Tue, 27 Jun 2023 03:11:05 +0000 (GMT)
X-AuditID: b6c32a4a-ec1fd7000000acda-3d-649a554c9e4d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.14.30535.9435A946; Tue, 27 Jun 2023 12:11:05 +0900 (KST)
Received: from ubuntu.. (unknown [109.105.118.54]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230627031104epsmtip1ef92c610f9e93066c045be8be10ff5c9~sZWl8DSEE3251632516epsmtip11;
        Tue, 27 Jun 2023 03:11:03 +0000 (GMT)
From:   Min Li <min15.li@samsung.com>
To:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Min Li <min15.li@samsung.com>
Subject: [PATCH v2] block: add check that partition length needs to be
 aligned with block size
Date:   Tue, 27 Jun 2023 11:09:18 +0000
Message-Id: <20230627110918.7608-1-min15.li@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmhq5P6KwUg+uruCxW3+1ns3iw396i
        efF6Nosbx98xW8x9fYnFYuXqo0wWe29pW1zeNYfNYvmqDiaLsxM+sFr8/gHk3lh3lcWBx2Pz
        Ci2Py2dLPTat6mTz2D93DbvH7psNbB59W1YxenzeJBfAHpVtk5GamJJapJCal5yfkpmXbqvk
        HRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0pZJCWWJOKVAoILG4WEnfzqYov7QkVSEj
        v7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+Pi2V/sBTf5KubNOsnWwPiVu4uR
        k0NCwETi3fWDrF2MXBxCArsZJTZs/8YI4XxilOj9vQ0q841R4tfsb2wwLY9730Al9jJKdCw8
        xgzhPGeU2NNwFCjDwcEmoCyxbakPSIOIQJrE0o6fYM3MAnESl7o62UFsYYEEiWl/poDFWQRU
        JY4cWw1m8wpYSPQ9a2SBWCYvsf/gWWaIuKDEyZlPWCDmyEs0b50NtldC4Ce7xJSHR6Guc5HY
        92otVLOwxKvjW9ghbCmJl/1t7CC3SQgUS7z8EQYRrpHY/e02E4RtLbFt/TomkBJmAU2J9bv0
        IcKyElNPrWOCWMsHDJQnUOW8EjvmwdhKEn8vnGOEsCUkFu9/yAphe0jc3/EC7DIhgViJd4v/
        sUxglJ+F5JtZSL6ZhbB5ASPzKkbJ1ILi3PTUYtMCo7zUcni8JufnbmIEp1Utrx2MDx980DvE
        yMTBeIhRgoNZSYRX7Mf0FCHelMTKqtSi/Pii0pzU4kOMpsAgnsgsJZqcD0zseSXxhiaWBiZm
        ZmYmlsZmhkrivMuu9KYICaQnlqRmp6YWpBbB9DFxcEo1MEUc81nDZPvnbHDOx/Y1W90Up07u
        WX8h8tXTBsO/2y7v3qe0prhyT+38jy6aKfePXX6XoHRuW86bE1oFJkGeHifanmvPX3m21Uu+
        K/UE9+JYmXez5z/Q37v7wMfzzuFKkrEPJl5LenS7rVb5xfOFUVdk608+/X5c89zR8y4r38x8
        etrPykHp6OclaRoNnzjc10qpay6anPLl8ZfHv9bsOxS+7qdWyqJfqssD1v1fbPVF+tfyxUdu
        W170XXhm4zbjXY+TTK+wJmn1MzYcZZ+9RPHUnZV/TlkJ2Yrc7FDeXVBQtHw7z0V7tivF4aeO
        KNmHHmr5weXjM2MaJ+/Mk8fl1Lbzf9zQYBD7UFy7Wfsvt86FDiWW4oxEQy3mouJEAJWlmbw0
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSnK5n8KwUg53vBSxW3+1ns3iw396i
        efF6Nosbx98xW8x9fYnFYuXqo0wWe29pW1zeNYfNYvmqDiaLsxM+sFr8/gHk3lh3lcWBx2Pz
        Ci2Py2dLPTat6mTz2D93DbvH7psNbB59W1YxenzeJBfAHsVlk5Kak1mWWqRvl8CVcfHsL/aC
        m3wV82adZGtg/MrdxcjJISFgIvG49w1rFyMXh5DAbkaJraevskAkJCTOz/vFBmELS6z895wd
        ougpo8Ty3ceAijg42ASUJbYt9QExRQRyJFZ89wcpZxZIkOj4cYgdJCwsECfRvFcRJMwioCpx
        5NhqsIm8AhYSfc8aoTbJS+w/eJYZIi4ocXLmExaIMfISzVtnM09g5JuFJDULSWoBI9MqRsnU
        guLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg8NbS2sG4Z9UHvUOMTByMhxglOJiVRHjFfkxP
        EeJNSaysSi3Kjy8qzUktPsQozcGiJM777XVvipBAemJJanZqakFqEUyWiYNTqoFpotEReZvU
        2kfWW9fXzDh57I7ukkVii2Vt0y81VuedPjb5G98B5jdrzP2n7C/lnnf7mntyZYqWr8TZVtG7
        aVOk8st9nZcfuCuxpOjF8xanWoXELwf/dwWU+viUW2WlLXT9nt63ecXalQGFh0y2rX3LeXxm
        Ctt19b63qhc8mbtmuH7rihXzeC6rx/brHlv65kMde2ZfFnEydH0s8+Ez//OAabO2csz1ntKb
        +/X3ztvquXPUxLuzvNfOii3Lb9Ivbu/k+Bq2ZrvgypN1XKcO/46cfuOUzuQTbz4a5fgKXzqc
        JOfE6XLyfSZLrlG5Q8X2ogI/F7OzUxZ8PhazLG7/3kXb2h2/Vrkssbvx1qiz3EldiaU4I9FQ
        i7moOBEA9d/g5t4CAAA=
X-CMS-MailID: 20230627031105epcas5p3010432ebd447ad865c3ddd986b3ffee0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230627031105epcas5p3010432ebd447ad865c3ddd986b3ffee0
References: <CGME20230627031105epcas5p3010432ebd447ad865c3ddd986b3ffee0@epcas5p3.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before calling add partition or resize partition, there is no check
on whether the length is aligned with the logical block size.
If the logical block size of the disk is larger than 512 bytes,
then the partition size maybe not the multiple of the logical block size,
and when the last sector is read, bio_truncate() will adjust the bio size,
resulting in an IO error if the size of the read command is smaller than
the logical block size.If integrity data is supported, this will also
result in a null pointer dereference when calling bio_integrity_free.

Signed-off-by: Min Li <min15.li@samsung.com>

---
Changes from v1:

- Add a space after /* and before */.
- Move length alignment check before the "start = p.start >> SECTOR_SHIFT"
- Move check for p.start being aligned together with this length alignment check.
---
 block/ioctl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 3be11941fb2d..c40b382dd58f 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -33,14 +33,18 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	if (op == BLKPG_DEL_PARTITION)
 		return bdev_del_partition(disk, p.pno);
 
+	/* check if partition is aligned to blocksize */
+	if (p.start & (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+	/* check if length is aligned to blocksize */
+	if (p.length & (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+
 	start = p.start >> SECTOR_SHIFT;
 	length = p.length >> SECTOR_SHIFT;
 
 	switch (op) {
 	case BLKPG_ADD_PARTITION:
-		/* check if partition is aligned to blocksize */
-		if (p.start & (bdev_logical_block_size(bdev) - 1))
-			return -EINVAL;
 		return bdev_add_partition(disk, p.pno, start, length);
 	case BLKPG_RESIZE_PARTITION:
 		return bdev_resize_partition(disk, p.pno, start, length);
-- 
2.34.1

