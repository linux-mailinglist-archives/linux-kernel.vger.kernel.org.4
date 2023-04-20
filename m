Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF22B6E8DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbjDTJMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjDTJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:12:30 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD8F19BD;
        Thu, 20 Apr 2023 02:12:00 -0700 (PDT)
X-UUID: 8e95830756444c368126da967c86eca3-20230420
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:aa4e4d9a-4e80-4733-ad6c-14fdbe6050d4,IP:10,
        URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-INFO: VERSION:1.1.22,REQID:aa4e4d9a-4e80-4733-ad6c-14fdbe6050d4,IP:10,UR
        L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:25
X-CID-META: VersionHash:120426c,CLOUDID:ec0a99eb-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230420171131HQVO2A8D,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|102,
        TC:nil,Content:0,EDM:5,IP:-2,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 8e95830756444c368126da967c86eca3-20230420
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
        (envelope-from <yijiangshan@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1064259329; Thu, 20 Apr 2023 17:11:29 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
        by mail.kylinos.cn (NSMail) with SMTP id 96DADE0084A4;
        Thu, 20 Apr 2023 17:11:29 +0800 (CST)
X-ns-mid: postfix-644101C1-405864121
Received: from localhost.localdomain (unknown [172.20.125.154])
        by mail.kylinos.cn (NSMail) with ESMTPA id 6D00CE0084A4;
        Thu, 20 Apr 2023 17:11:27 +0800 (CST)
From:   Jiangshan Yi <yijiangshan@kylinos.cn>
To:     rafael@kernel.org, robert.moore@intel.com
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, 13667453960@163.com,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH v2] drivers/acpi/acpica/exserial.c: replace ternary operator with min()
Date:   Thu, 20 Apr 2023 17:11:02 +0800
Message-Id: <20230420091102.39835-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

Fix the following coccicheck warning:

drivers/acpi/acpica/exserial.c:346: WARNING opportunity for min().

min() macro is defined in include/linux/minmax.h. It avoids
multiple evaluations of the arguments when non-constant and performs
strict type-checking.

Link: https://github.com/acpica/acpica/pull/871
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/acpi/acpica/exserial.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exserial.c b/drivers/acpi/acpica/exseria=
l.c
index fd63f2042514..dfe507e0a09a 100644
--- a/drivers/acpi/acpica/exserial.c
+++ b/drivers/acpi/acpica/exserial.c
@@ -343,8 +343,7 @@ acpi_ex_write_serial_bus(union acpi_operand_object *s=
ource_desc,
 	/* Copy the input buffer data to the transfer buffer */
=20
 	buffer =3D buffer_desc->buffer.pointer;
-	data_length =3D (buffer_length < source_desc->buffer.length ?
-		       buffer_length : source_desc->buffer.length);
+	data_length =3D min(buffer_length, source_desc->buffer.length);
 	memcpy(buffer, source_desc->buffer.pointer, data_length);
=20
 	/* Lock entire transaction if requested */
--=20
2.27.0

