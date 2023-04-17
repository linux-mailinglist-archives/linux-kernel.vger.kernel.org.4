Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77FE6E41CF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDQH6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDQH5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:57:45 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6223594;
        Mon, 17 Apr 2023 00:57:37 -0700 (PDT)
X-UUID: c289f049c77a4a198bb1e1d0d4378632-20230417
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:7ce7aaf4-ce7a-4d63-a731-4be079b546fb,IP:-32
        768,URL:-32768,TC:-32768,Content:-32768,EDM:-32768,RT:-32768,SF:-32768,FIL
        E:-32768,BULK:-32768,RULE:Release_Ham,ACTION:release,TS:0
X-CID-INFO: VERSION:1.1.22,REQID:7ce7aaf4-ce7a-4d63-a731-4be079b546fb,IP:-3276
        8,URL:-32768,TC:-32768,Content:-32768,EDM:-32768,RT:-32768,SF:-32768,FILE:
        -32768,BULK:-32768,RULE:Release_Ham,ACTION:release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:nil,BulkID:nil,BulkQuantity:0,Recheck:
        0,SF:nil,TC:nil,Content:nil,EDM:nil,IP:nil,URL:nil,File:nil,Bulk:nil,QS:ni
        l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: c289f049c77a4a198bb1e1d0d4378632-20230417
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
        (envelope-from <zenghao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1100353138; Mon, 17 Apr 2023 15:56:21 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
        by mail.kylinos.cn (NSMail) with SMTP id 4763EE0084A1;
        Mon, 17 Apr 2023 15:56:21 +0800 (CST)
X-ns-mid: postfix-643CFBA5-20992179
Received: from zdzh5-QiTianM428-A376.. (unknown [172.20.12.253])
        by mail.kylinos.cn (NSMail) with ESMTPA id 7FF1FE0084A1;
        Mon, 17 Apr 2023 15:56:19 +0800 (CST)
From:   Hao Zeng <zenghao@kylinos.cn>
To:     skhan@linuxfoundation.org
Cc:     trenn@suse.com, shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zenghao@kylinos.cn
Subject: [PATCH v3] cpupower:Fix resource leaks in sysfs_get_enabled()
Date:   Mon, 17 Apr 2023 15:56:17 +0800
Message-Id: <20230417075617.10487-1-zenghao@kylinos.cn>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysfs_get_enabled() opened file processor not closed,
may cause a file handle leak.
Putting error handling and resource cleanup code together
makes the code easy to maintain and read.
Removed the unnecessary else if branch from the original
function, as it should return an error in cases other than '0'.

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/power/cpupower/lib/powercap.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/l=
ib/powercap.c
index 0ce29ee4c2e4..f0334a5f1acf 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -40,25 +40,31 @@ static int sysfs_get_enabled(char *path, int *mode)
 {
 	int fd;
 	char yes_no;
+	int ret =3D 0;
=20
 	*mode =3D 0;
=20
 	fd =3D open(path, O_RDONLY);
-	if (fd =3D=3D -1)
-		return -1;
+	if (fd =3D=3D -1) {
+		ret =3D -1;
+		goto out;
+	}
=20
 	if (read(fd, &yes_no, 1) !=3D 1) {
-		close(fd);
-		return -1;
+		ret =3D -1;
+		goto out_close;
 	}
=20
 	if (yes_no =3D=3D '1') {
 		*mode =3D 1;
-		return 0;
-	} else if (yes_no =3D=3D '0') {
-		return 0;
+	} else if (yes_no !=3D '0') {
+		ret =3D -1;
+		goto out_close;
 	}
-	return -1;
+out_close:
+	close(fd);
+out:
+	return ret;
 }
=20
 int powercap_get_enabled(int *mode)
--=20
2.37.2

