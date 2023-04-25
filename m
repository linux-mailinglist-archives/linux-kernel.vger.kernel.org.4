Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25046EE74B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbjDYSD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjDYSDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7643C17A25
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D93E6296A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E06C433EF;
        Tue, 25 Apr 2023 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682445818;
        bh=kcvnS38dqteSFxCDyzJt6TsrX4wlKiMlwbZ7L3FPe6g=;
        h=From:Date:Subject:To:Cc:From;
        b=eFup6VJrMD2Lx/o0ER5E0DrDaSsdeb10+pPBJaVSI/J0IbrD2DrgEpQqoCxlHTmVS
         AHOzONtcafhQQ2N7mnrcTG5Z29tQC4hvumarSah+NKJA5Ilf2tvh1qOU6VFmpm6OXl
         +3u8n73qQtRGQbCblJrBqDrIyxR/7HE38ZKVH1xdVyERqVy4CmsG5bdvUQuqqBpTKm
         WlMDz9aSzYPLdBZB8cUBELJI8OBgqxYZ32PitCssChs+jWF6bx7Gy69Ew9BwDnU+rE
         hAAiYZ5Qv+cjIe4wqO9V6IUrl7FTlplL57pBTZ3ujwS/YOtmyGhXDKqHPK5QNLgsmo
         zH8GjkUBoi9jw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 25 Apr 2023 19:03:33 +0100
Subject: [PATCH] mfd: wm831x: Use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-mfd-wm831x-maple-v1-1-e03e39d7bb0b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPQVSGQC/x2NQQqDMBAAvyJ77oIxUrRfKT1skk1d2kTZQBXEv
 zd6nIFhdiiswgUezQ7KPyky5wrm1oCfKL8ZJVSGru1s25sRUwy4psGaDRMtX8Yh0H00zluOHmr
 mqDA6peynM1xn/Zx6UY6yXafn6zj+dGkcRnkAAAA=
To:     Lee Jones <lee@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00e42
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; i=broonie@kernel.org;
 h=from:subject:message-id; bh=kcvnS38dqteSFxCDyzJt6TsrX4wlKiMlwbZ7L3FPe6g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkSBX4R9ogytMQ57hP+qeDhW1qtar4vRSfN/mlQ7lt
 3VSnjg6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZEgV+AAKCRAk1otyXVSH0OEGB/
 9RkAdaZzdGPd2HvXuzxpbQTDLY5/pTPAhtJUjoycsNv5uDtfys20RX6k70hrzVIqQGnoXGKTLMFlCo
 C1ksi+hF2Lt4luXxETyD3qpQ7h02n2FWHPFKA3/5LI8CPNE8gY7cZPj95eFSR2n//aKpLQDxYTYTWG
 +Gf+3HFsnuTl+JVHbrbrGsLr1T8Qe2YRP+G6cXsU/iKe0oVIGMcUju2xJiXhfU4Eczfa6P7ERfTgP8
 hEjWAjAaLI45gNJ/kgCvZSWNBAEi64ZmULWrlXTjgPenc/DJ9Eveq4sJ0nePZkoPHeTgCTPRmWg4da
 SbzHWiidPVCEgZvQaXOygbwfrb59Y4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap has introduced a maple tree based register cache which makes use of
this more advanced data structure which has been added to the kernel
recently. Maple trees are much flatter than rbtrees, meaning that they do
not grow to such depths when the register map is sparse which makes access
a bit more efficient. The maple tree cache type is still a bit of a work
in progress but should be effective for some devices already.

The wm831x devices have a pretty sparse register map and being always on
devices never do cache syncs so don't hit the major current disadvantage
so they should be good candiates for using the maple tree cache.  Update
to do so, there should be little if any visible difference at runtime.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/wm831x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wm831x-core.c b/drivers/mfd/wm831x-core.c
index d2f444d2ae78..e86b6a4896a6 100644
--- a/drivers/mfd/wm831x-core.c
+++ b/drivers/mfd/wm831x-core.c
@@ -1430,7 +1430,7 @@ struct regmap_config wm831x_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 16,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 
 	.max_register = WM831X_DBE_CHECK_DATA,
 	.readable_reg = wm831x_reg_readable,

---
base-commit: 4a670ac3e75e517c96cbd01ef870dbd598c3ce71
change-id: 20230419-mfd-wm831x-maple-8da691bc3efc

Best regards,
-- 
Mark Brown <broonie@kernel.org>

