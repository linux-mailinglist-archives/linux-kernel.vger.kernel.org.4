Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FFE6CB367
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjC1BwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjC1BwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:52:12 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4F21FDE;
        Mon, 27 Mar 2023 18:52:11 -0700 (PDT)
X-UUID: 08321cc7251f4a488c4909c7af261d8a-20230328
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:fcfc3164-7bc9-4ae3-bb3a-67c55f0bc93b,IP:20,
        URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:14,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:29
X-CID-INFO: VERSION:1.1.20,REQID:fcfc3164-7bc9-4ae3-bb3a-67c55f0bc93b,IP:20,UR
        L:0,TC:0,Content:-5,EDM:0,RT:0,SF:14,FILE:0,BULK:0,RULE:Release_HamU,ACTIO
        N:release,TS:29
X-CID-META: VersionHash:25b5999,CLOUDID:31748cb4-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:2303280952064848OZ6D,BulkQuantity:0,Recheck:0,SF:24|16|19|43|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 08321cc7251f4a488c4909c7af261d8a-20230328
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
        (envelope-from <yijiangshan@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 484537904; Tue, 28 Mar 2023 09:52:05 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
        by mail.kylinos.cn (NSMail) with SMTP id 3DAABE0084A1;
        Tue, 28 Mar 2023 09:52:05 +0800 (CST)
X-ns-mid: postfix-64224844-71411298
Received: from localhost.localdomain (unknown [172.20.125.154])
        by mail.kylinos.cn (NSMail) with ESMTPA id D4907E0084A1;
        Tue, 28 Mar 2023 09:52:03 +0800 (CST)
From:   Jiangshan Yi <yijiangshan@kylinos.cn>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, 13667453960@163.com,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] drivers/acpi/acpica/exserial.c: replace ternary operator with min()
Date:   Tue, 28 Mar 2023 09:51:20 +0800
Message-Id: <20230328015120.111168-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
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

