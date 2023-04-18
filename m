Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7166E567E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDRBbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDRBbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:31:35 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3157FEC;
        Mon, 17 Apr 2023 18:31:31 -0700 (PDT)
X-UUID: 9a07e4d5f39c4ddcab5b58965412e4d8-20230418
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:08c9f934-2b0b-4ad5-a1a4-fd84f8acc7d8,IP:20,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-INFO: VERSION:1.1.22,REQID:08c9f934-2b0b-4ad5-a1a4-fd84f8acc7d8,IP:20,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:5
X-CID-META: VersionHash:120426c,CLOUDID:a97b6284-cd9c-45f5-8134-710979e3df0e,B
        ulkID:230418093117RV3XC0OP,BulkQuantity:0,Recheck:0,SF:19|44|24|17|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 9a07e4d5f39c4ddcab5b58965412e4d8-20230418
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
        (envelope-from <zenghao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1882977521; Tue, 18 Apr 2023 09:30:59 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
        by mail.kylinos.cn (NSMail) with SMTP id 9E25FE0084A4;
        Tue, 18 Apr 2023 09:30:59 +0800 (CST)
X-ns-mid: postfix-643DF2D3-43431154
Received: from zdzh5-QiTianM428-A376.. (unknown [172.20.12.253])
        by mail.kylinos.cn (NSMail) with ESMTPA id D603DE0084A4;
        Tue, 18 Apr 2023 09:30:58 +0800 (CST)
From:   Hao Zeng <zenghao@kylinos.cn>
To:     skhan@linuxfoundation.org
Cc:     trenn@suse.com, shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zenghao@kylinos.cn
Subject: [PATCH v4] cpupower:Fix resource leaks in sysfs_get_enabled()
Date:   Tue, 18 Apr 2023 09:30:56 +0800
Message-Id: <20230418013056.995478-1-zenghao@kylinos.cn>
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
 tools/power/cpupower/lib/powercap.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/l=
ib/powercap.c
index 0ce29ee4c2e4..a7a59c6bacda 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -40,25 +40,34 @@ static int sysfs_get_enabled(char *path, int *mode)
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
+		goto out_close;
 	} else if (yes_no =3D=3D '0') {
-		return 0;
+		goto out_close;
+	} else {
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

