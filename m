Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC2371443C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjE2GWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjE2GWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:22:10 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28218C4
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:22:08 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3WGaqT3FDsdVE3WGaqliG4; Mon, 29 May 2023 08:22:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685341326;
        bh=heLRroh3CNUr9htV1zv4nneIJNvGBNjdwo/3UP94dsE=;
        h=From:To:Cc:Subject:Date;
        b=btPa7tEYR3wji3B48+qtsDvNhW+06Wj/DppAKuqLoJKXBAOt16OnpHCx92Kpwe3z5
         J2UuVDEpW1l+c2zCqsm3vLRGXBf78dY2HCOelqcLAV3yG9FgFexkDr2kirFpGuV/xk
         jCIKPGp313eOanwqlzwb/ENKyu1BZE+6ocLDuLx+bkUj6yF+BWgWEQCfR+gu6r/5Hd
         k3my2hmg3LFEAR4zDlxTl5dXwKJHWD3z+TWxsYDtJWOU0/1vB8SmH2N8/gR631u9p7
         oFRTGBYrlE8gzBEGyH2hTjU32hr8232P8LXMrQFbRzdMWpLSrSrudpR3m5Zzu/z45s
         GfX2z8KLQGm5A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 May 2023 08:22:06 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Subject: [PATCH] ACPICA: Slightly simplify an error message in acpi_ds_result_push()
Date:   Mon, 29 May 2023 08:22:02 +0200
Message-Id: <4464371bc72147e10a392a1873466c8df033039c.1685341309.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'object' is known to be NULL at this point. There is little value to log
it twice in the error message.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
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

