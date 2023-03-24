Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AED6C88A7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjCXW6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCXW6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:58:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9233F1C5B3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C350B8262C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 22:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A66C433D2;
        Fri, 24 Mar 2023 22:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679698728;
        bh=6DOB3pAoTnkvCSogv9KXyamFR2xytgfPyfRl68Nbriw=;
        h=From:Date:Subject:To:Cc:From;
        b=NCQFjTMfX151yVLZyjAfgm7zE45z1leoGT1t9ygLS4JkVHJbM+zi1gB4rF4RbCYOq
         cHtiBLj0ChzZHBf8Olay9uou6GAZ2KeSC0Ka2+iJC7OpKTQXS0ZV9Iz9zpvrtpftvr
         5C4XNMBicFGXVxHkgJn7KLT27vsHqkJlrGwZ8mQKg9bt00N3Rgt3R4UM1/DgYMYam8
         Nt3M2d3sxoAxvCQWN6YSuyG8dOInq60CBRMUdiwZM/wqgcFI9JTORkXz1yXAQnKPAb
         3djVi8vfAuuN7V8CsDl/n85SrPKJqzDR0h1CuEfjP4/Cynqbz08hPD3RaA5VmSRvKg
         HhcTFOldqR7PQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 24 Mar 2023 22:58:42 +0000
Subject: [PATCH] regmap: Support paging for buses with
 reg_read()/reg_write()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230324-regmap-reg-read-write-page-v1-1-1fbc0dac67ae@kernel.org>
X-B4-Tracking: v=1; b=H4sIACIrHmQC/x2NwQqDMBBEf0X23ECMCra/UnrY6KqLNIaN1ILk3
 914GIZ5DDMnJBKmBK/qBKEfJ96ChvpRwbBgmMnwqBmcdY1tXGuE5i/GYioczSG8k4moTf/0tut
 qR/3Ugg54TAoFw7CUiWOTteAoNPH//nx/cr4AqKY3+oMAAAA=
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6DOB3pAoTnkvCSogv9KXyamFR2xytgfPyfRl68Nbriw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkHisnxCGpr53VM68xN5E4Mc+t9NnhH3jwbTnI3GdT
 bGGqVgSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZB4rJwAKCRAk1otyXVSH0NhYB/
 9vIMdcWpilj4OAtTGNU0FzphCxl261DZpeUNXiSeouNnW3FoDnQr6eJSfSYn5XY2R9i7yzAeKmAGEX
 CqjYzH0dVsEQqfrueKXflMncyngoOIWCMF9D7kKEKppdCKLxz2E8j46GRlkbGaJ9GUcGob00nTWgR9
 RdtMCbxTwH2sBuCvi1i6RPDF8dI6Cu6x6PmDtIS+pn9d8ROlqWD5L/1WaNzoPWS8kvGVnrfyXL1HaX
 ZMMAtFRMGluxYME+wGVdJlT9FdRDRh37IWf9NRD2oHCBwD914Li4zm135M8ueZElbJaUYXWZyyIS+2
 2Z0nlUM+5aYltITWhzQgDG//GVUIi9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't currently support paging for regmaps where the I/O happens through
bus provided reg_read() and reg_write() operatons, we simply ignore the
range since nothing is wired up properly. Wire things up.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index d2a54eb0efd9..7960e80edb79 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1941,6 +1941,15 @@ static int _regmap_bus_reg_write(void *context, unsigned int reg,
 				 unsigned int val)
 {
 	struct regmap *map = context;
+	struct regmap_range_node *range;
+	int ret;
+
+	range = _regmap_range_lookup(map, reg);
+	if (range) {
+		ret = _regmap_select_page(map, &reg, range, 1);
+		if (ret != 0)
+			return ret;
+	}
 
 	reg += map->reg_base;
 	reg >>= map->format.reg_downshift;
@@ -2841,6 +2850,15 @@ static int _regmap_bus_reg_read(void *context, unsigned int reg,
 				unsigned int *val)
 {
 	struct regmap *map = context;
+	struct regmap_range_node *range;
+	int ret;
+
+	range = _regmap_range_lookup(map, reg);
+	if (range) {
+		ret = _regmap_select_page(map, &reg, range, 1);
+		if (ret != 0)
+			return ret;
+	}
 
 	reg += map->reg_base;
 	reg >>= map->format.reg_downshift;

---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230324-regmap-reg-read-write-page-b9b05512e8f4

Best regards,
-- 
Mark Brown <broonie@kernel.org>

