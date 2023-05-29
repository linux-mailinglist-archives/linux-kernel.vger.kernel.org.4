Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12716714CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjE2PQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjE2PQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:16:03 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954D4D2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:15:57 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3ebBqRDyGfPgg3ebBqe9kc; Mon, 29 May 2023 17:15:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685373355;
        bh=BltMKT3kn+lp68ycQvoOpDcBVtIurMfM0OHRUsxk4vg=;
        h=From:To:Cc:Subject:Date;
        b=Je23+tjFXIoQFK7nljsPigyn8btd5HgWlTRRcug7vc0TAY6XIxdjphHuC107i9Mky
         CrseczmHneG/8QLu1s2ax/qTB5lMGB3duWGtHvm5igrbr/UH8fbaNUVyMyihdnUpvJ
         Y4A8LSAsFBEra+B75VdrSE5ze7VDe3hhhgcGkSGU6LyKX7TDtWqjDncTccYylX13sx
         PKx7dwpl72hW0MPGX2ba/P2H2yWsza8wPwHzBm/QKaESbgPVQo6jK3skPdAP9mbQ0E
         jvpm4ThqKDPoW1IyF3RCWf8NVybC0GtqCYlLVGwqMK0rBCy+SKKGm/xdk/bX4p4hSP
         NGuQg16efvztw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 May 2023 17:15:55 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Subject: [PATCH V2] ACPICA: Slightly simplify an error message in acpi_ds_result_push()
Date:   Mon, 29 May 2023 17:15:52 +0200
Message-Id: <1464371bc72147e10a392a18734e6c8dff330a9c.1685341309.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'object' is known to be NULL at this point. There is little value to log
it twice in the error message.

Link: https://github.com/acpica/acpica/pull/875
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: Add a link to the PR on github
Patch below and in the PR are slightly different because if CamelCase.

 drivers/acpi/acpica/dswstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index d3841ded3a81..75338a13c802 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -146,8 +146,8 @@ acpi_ds_result_push(union acpi_operand_object *object,
 
 	if (!object) {
 		ACPI_ERROR((AE_INFO,
-			    "Null Object! Obj=%p State=%p Num=%u",
-			    object, walk_state, walk_state->result_count));
+			    "Null Object! State=%p Num=%u",
+			    walk_state, walk_state->result_count));
 		return (AE_BAD_PARAMETER);
 	}
 
-- 
2.34.1

