Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427506F306F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 13:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjEALa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 07:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjEALay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 07:30:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B872510FA;
        Mon,  1 May 2023 04:30:53 -0700 (PDT)
Received: from koko.localdomain ([213.196.213.13]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N7iKo-1qNbbV2mws-014k2Q; Mon, 01 May 2023 13:30:43 +0200
From:   Maximilian Weigand <mweigand@mweigand.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v2 1/6] Input: cyttsp5 - fix array length
Date:   Mon,  1 May 2023 13:30:05 +0200
Message-Id: <20230501113010.891786-2-mweigand@mweigand.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501113010.891786-1-mweigand@mweigand.net>
References: <20230501113010.891786-1-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:p/5GtVKUJPnHQuTfJuon7vGN4jRyuRUKN4lAKxXfbccB7EmDnaC
 3KBBK8At5C65x/HXFnSQmx/Nrl322WQXn5iKsdvENkEbpQGOByUN+Kt2vx+hSzEP0gL8pg0
 M6BmLjOPt0mNnx1qw+qemgDs049TLxzDBNCsE+AnampUPKQo1Z39sxj7E15SPMZZh5sd7ou
 S8pK4sHuSP3YBtA4n8Fvw==
UI-OutboundReport: notjunk:1;M01:P0:sk8asawXIvw=;XQvol0O474AgmlBRt3WdtGpLEJo
 2uHuXyIzIE9YLtQ3CFaWbHweOqriHM691A+gUdkwmZnzwhHyKipG+DTVx+Rj91ruz4sSGj5IT
 oxtnF7WQvm/TEIvl15fP78Hlj+E5NIndxwxWGOuVQpawfYdP3Boc4MLkAirMOkiSDl5L/bo86
 lsxIYDQr7lpPMGzWACdEMuqsPAapHCSSpYC5QaUUkG+1e8023a35GuvwYBUVlzxwn88h0mA03
 K7DIBFyrKmu2/jIYlJKeSZnUHSEokpFs/tFBY03Q55SVJfi65DLrxrgm5pKWvzwSiNXNpD//x
 sMNOx7gIliDMV0yTOqM0WwId4RkTkTZofQIN5sI/VQAnPe3cT0tIGITzWncto9SVlgsdd8Eoe
 DEiaHGtdaxhVQgExvNFoG8B7y2aZL5njjybfm+MDaSxnx28kAADDy7cXV2gZt3uRA6K94Bi1N
 hHSWyMKQsJl+jyfCPgH/KY01T9wH1rgFkPeACEbfgm9yZhWQzC337Vp5LmasUO0bD8ko8J5bH
 H98/3Jbj4bZUO3lBBPWfNuWTkqhGSEiF1em4j/63Od5iTh+G0RCXOXlGH9/WAbK/eNZ2Qd1yJ
 3+pEC25KWjlf2TXfPQHEZNU4ZQ2fHD2r4GoGUjsvuQhw5GqVGh5g8HyS23uMv8d/G7PETFegc
 g7mpKDeY/gbJJvbQoqwoMebRMHIO3FSU2zeCNbOQAQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cmd array should be initialized with the proper command size and not
with the actual command value that is sent to the touchscreen.

Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
Reviewed-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/input/touchscreen/cyttsp5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index 30102cb80fac..3c9d07218f48 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -560,7 +560,7 @@ static int cyttsp5_hid_output_get_sysinfo(struct cyttsp5 *ts)
 static int cyttsp5_hid_output_bl_launch_app(struct cyttsp5 *ts)
 {
 	int rc;
-	u8 cmd[HID_OUTPUT_BL_LAUNCH_APP];
+	u8 cmd[HID_OUTPUT_BL_LAUNCH_APP_SIZE];
 	u16 crc;
 
 	put_unaligned_le16(HID_OUTPUT_BL_LAUNCH_APP_SIZE, cmd);
-- 
2.39.2

