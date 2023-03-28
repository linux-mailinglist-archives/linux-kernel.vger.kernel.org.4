Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8826CB4BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjC1DRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1DR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:17:27 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ED41A6;
        Mon, 27 Mar 2023 20:17:24 -0700 (PDT)
X-UUID: 772770d80c7d4fd38ba61bfec402c8de-20230328
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:f8a37e21-fb75-4c37-b66e-8dd682e4175d,IP:10,
        URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:31
X-CID-INFO: VERSION:1.1.20,REQID:f8a37e21-fb75-4c37-b66e-8dd682e4175d,IP:10,UR
        L:0,TC:0,Content:-5,EDM:25,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:31
X-CID-META: VersionHash:25b5999,CLOUDID:ea98ae29-564d-42d9-9875-7c868ee415ec,B
        ulkID:230328111721W4Q58S1F,BulkQuantity:0,Recheck:0,SF:24|17|19|43|102,TC:
        nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 772770d80c7d4fd38ba61bfec402c8de-20230328
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
        (envelope-from <yijiangshan@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 505668487; Tue, 28 Mar 2023 11:17:18 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
        by mail.kylinos.cn (NSMail) with SMTP id 93F94E0084A1;
        Tue, 28 Mar 2023 11:17:18 +0800 (CST)
X-ns-mid: postfix-64225C3E-350120133
Received: from localhost.localdomain (unknown [172.20.125.154])
        by mail.kylinos.cn (NSMail) with ESMTPA id CCA28E0084A1;
        Tue, 28 Mar 2023 11:17:17 +0800 (CST)
From:   Jiangshan Yi <yijiangshan@kylinos.cn>
To:     rafael@kernel.org
Cc:     rui.zhang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, 13667453960@163.com,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] ACPI: thermal: replace ternary operator with min_t()
Date:   Tue, 28 Mar 2023 11:16:29 +0800
Message-Id: <20230328031629.202268-1-yijiangshan@kylinos.cn>
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

drivers/acpi/thermal.c:422: WARNING opportunity for min().

min_t() macro is defined in include/linux/minmax.h. It avoids multiple
evaluations of the arguments when non-constant and performs strict
type-checking.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/acpi/thermal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 0b4b844f9d4c..179f41196a9d 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -419,10 +419,9 @@ static int acpi_thermal_trips_update(struct acpi_the=
rmal *tz, int flag)
 					 * the next higher trip point
 					 */
 					tz->trips.active[i-1].temperature =3D
-						(tz->trips.active[i-2].temperature <
-						celsius_to_deci_kelvin(act) ?
-						tz->trips.active[i-2].temperature :
-						celsius_to_deci_kelvin(act));
+						min_t(unsigned long,
+						      tz->trips.active[i-2].temperature,
+						      celsius_to_deci_kelvin(act));
=20
 				break;
 			} else {
--=20
2.25.1

