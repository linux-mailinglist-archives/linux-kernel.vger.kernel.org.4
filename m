Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1A972AC44
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 16:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbjFJO0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 10:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjFJO0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 10:26:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2724CE5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 07:26:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4C4660DFE
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 14:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12705C433EF;
        Sat, 10 Jun 2023 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686407202;
        bh=jaJzpJyj+5E2A//gUROcGxEPk881SMtYkFToNDsbtAM=;
        h=From:Date:Subject:To:Cc:From;
        b=Vp+4iCH89fmnVLPXUIJ9NkzYPo2Rcx88sQBzH03pUwpZujed/cNh2DDSunN9zcWcP
         yUB0Z8ikq7Xkmycqm+oDECWgi1HsOZAa4sim7ffz7w8WbLG5hOZgPLCDVfpxE8MUXX
         A/53+qgowMM7IAtmvq+/boRyslujb5lS7sOMx3sYXf/4JgnjlIC8JO5L5heSh8Z7bS
         5VGLZdJHsbVVP0OrHcUAPk4Ym3xGICFqfvNwyOi2JLhkW0d7HqvG2ciNdvUekqL9VG
         U41KoFSCEoixXJdCmJGSD1YeYGojByuTlbQsPa4J677vgzETtAxGppzljvpqnD1gLg
         EELLfJ4fUaYCg==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 10 Jun 2023 15:26:37 +0100
Subject: [PATCH] ALSA: hda: Use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-alsa-hda-maple-v1-1-a2b725c8b8f5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAByIhGQC/x2NQQqDQAwAvyI5NxC3VKlfkR6yGruhukoCbUH8e
 9ceZ2CYHVxMxaGrdjB5q+uaC9SXCobE+SmoY2EIFK7U0B15dsY0Mi68zYIUpvYmMVLTCpQosgt
 G4zykM/us9jr1ZjLp9//pH8fxA5q+90p3AAAA
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jaJzpJyj+5E2A//gUROcGxEPk881SMtYkFToNDsbtAM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhIgfdHrblT9jwwcTTb8u7IUpTl5wXqj820MyIg71
 lYQUT5+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZISIHwAKCRAk1otyXVSH0NznB/
 91sSHt6gyZfeq5HaKZVlOfypm8FPsMiE5ScY12lFPB5hGhX5M7JRYsyWc/ywdN4+PxWiRRNtMtmgpr
 rRVnKCrYWBQuhuo4zj6WUlTr6k0zT4193uio9FqHPGCds/6jlnvZNl4ceW9ViIUNI4Is9jS4YdfM+e
 CfqyxVeqbq55m/AcVFHPpLBqnoPeVdgVWDYCKLG7ZF+BNeLBDUItxH+iFW1sslX5aK5n4/Ewl4WHLN
 RXe93oRz2aDYq78MptC8AuwEMiTwtN1wIybG6+Q42afsHQJXdjXsuLG44fCADBhdiiijgjDsOFZ54S
 /O0nQJSoHOXeQXE+fagxjUNYoDv+a6
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDA can only support single register read and write operations so does not
benefit from block writes. This means it gets no benefit from using the
rbtree register cache over the maple tree register cache so convert it to
use maple trees instead, it is more modern.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/hda/hdac_regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index fe3587547cfe..2caa1f9b858e 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -358,7 +358,7 @@ static const struct regmap_config hda_regmap_cfg = {
 	.writeable_reg = hda_writeable_reg,
 	.readable_reg = hda_readable_reg,
 	.volatile_reg = hda_volatile_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_read = hda_reg_read,
 	.reg_write = hda_reg_write,
 	.use_single_read = true,

---
base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
change-id: 20230609-alsa-hda-maple-02f75ebb067e

Best regards,
-- 
Mark Brown <broonie@kernel.org>

