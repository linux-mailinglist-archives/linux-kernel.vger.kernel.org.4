Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4C36EDA4D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 04:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjDYCqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 22:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjDYCqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 22:46:15 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B35C55B2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:46:13 -0700 (PDT)
X-UUID: 5a77b4e5fe374127bc4d8799d8dd4900-20230425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:beda3708-87cc-414b-ad35-f528de7f85f0,IP:10,
        URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-10
X-CID-INFO: VERSION:1.1.22,REQID:beda3708-87cc-414b-ad35-f528de7f85f0,IP:10,UR
        L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-META: VersionHash:120426c,CLOUDID:eb5106ec-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230425104609E4BQ6LXL,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 5a77b4e5fe374127bc4d8799d8dd4900-20230425
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
        (envelope-from <zenghao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 779924533; Tue, 25 Apr 2023 10:46:07 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
        by mail.kylinos.cn (NSMail) with SMTP id E96DCE0084A1;
        Tue, 25 Apr 2023 10:46:06 +0800 (CST)
X-ns-mid: postfix-64473EEE-754331113
Received: from zdzh5-QiTianM428-A376.. (unknown [172.20.12.253])
        by mail.kylinos.cn (NSMail) with ESMTPA id C4940E0084A1;
        Tue, 25 Apr 2023 10:46:05 +0800 (CST)
From:   Hao Zeng <zenghao@kylinos.cn>
To:     rostedt@goodmis.org
Cc:     chenhuacai@kernel.org, zhangqing@loongson.cn,
        linux-kernel@vger.kernel.org, Hao Zeng <zenghao@kylinos.cn>
Subject: [PATCH v2] recordmcount: Fix memory leaks in the uwrite function
Date:   Tue, 25 Apr 2023 10:46:03 +0800
Message-Id: <20230425024603.4005251-1-zenghao@kylinos.cn>
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

Common realloc mistake: 'file_append' nulled but not freed upon failure

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
---
 scripts/recordmcount.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index e30216525325..efeec898f632 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -110,6 +110,7 @@ static ssize_t uwrite(void const *const buf, size_t c=
onst count)
 {
 	size_t cnt =3D count;
 	off_t idx =3D 0;
+	void *p =3D NULL;
=20
 	file_updated =3D 1;
=20
@@ -117,7 +118,13 @@ static ssize_t uwrite(void const *const buf, size_t =
const count)
 		off_t aoffset =3D (file_ptr + count) - file_end;
=20
 		if (aoffset > file_append_size) {
-			file_append =3D realloc(file_append, aoffset);
+			p =3D realloc(file_append, aoffset);
+			if (!p) {
+				free(file_append);
+				file_append =3D NULL;
+			} else {
+				file_append =3D p;
+			}
 			file_append_size =3D aoffset;
 		}
 		if (!file_append) {
--=20
2.37.2

