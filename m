Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7300F683935
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjAaWU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjAaWUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:20:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5007299
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:20:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D954A6173D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 22:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A91CC4339E;
        Tue, 31 Jan 2023 22:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675203652;
        bh=D80eThzhKADVxqMORjVE0hDBHtRmV9viVdr2cZRnMSo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=S2cVe/5sEOqaNnnne3v6HNZSuV5Ucgco7KfF4OGjPCfTc3vsXbaS3/GIsQJsjJ9gv
         k1z6qjS+kmuS+ZC/ZTI/BJ7Tli2LK4UtloP2IqeYcEQFeVQQXeIOn5dp/UYhWOtoeD
         LhXgxIXAwK9fdyVL8im/tyQnvzo4vCvXxHS7fqPRKbMLOrF/nl7ZIIQi4EpRUsDVSX
         egAvwEv82lWT0n59zXIpfhdk/y2gD/ZWhHexM2Y8h6TNfly2VFk9BsJC/LUPXKqQde
         ZkXIfBAzo+k6Qf9E7Z23A+AfCo2J9gEA/xAozlq8ZDkFM3GHtllzsBdDHNhmgFW3kR
         R6IUUCJTJWnUg==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 31 Jan 2023 22:20:39 +0000
Subject: [PATCH v3 1/7] arm64/signal: Don't redundantly verify FPSIMD magic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221212-arm64-signal-cleanup-v3-1-4545c94b20ff@kernel.org>
References: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
In-Reply-To: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247; i=broonie@kernel.org;
 h=from:subject:message-id; bh=D80eThzhKADVxqMORjVE0hDBHtRmV9viVdr2cZRnMSo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj2ZQ7UzzHkKaY6VK1I/m/Lz0hseWd/eVXEpv3YpLD
 9Dd2xROJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9mUOwAKCRAk1otyXVSH0IyUB/
 4hrvAnYvY7TY/SANWUu7jwCm9cEOqT8xGxiaNJ1/QpC2n4LoWPH05t66HkgEKjXp4TcOdAhu35Hn44
 FuIiOihlcODzU8Q/5u4rFVfWGgpxNoaU9keUDV2XnrKwMMS6DaxmZztH4t4q9QvW6gI0wuDwxJhgQh
 OJxuEzmbF0+Httqm4k+WbMZ5Xp9D+FQ3GWOXSbrZ1urAoUbP7Jrjw9+7uXpxO0vIGSBMpiPA7C5WV2
 BEuWhmSTzptMPSiiddfhubSLeai8eEW+WiPQtnQlusvK/5Ux0X9gAPjO+M2y5w4xQYpQdLFJ+17Ozp
 YT28GXwxVulxWe0l0xVMnBNDp1spF9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We validate that the magic in the struct fpsimd_context is correct in
restore_fpsimd_context() but this is redundant since parse_user_sigframe()
uses this magic to decide to call the function in the first place. Remove
the extra validation.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/signal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index ed692284f199..882f6d913508 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -191,15 +191,14 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 {
 	struct user_fpsimd_state fpsimd;
-	__u32 magic, size;
+	__u32 size;
 	int err = 0;
 
-	/* check the magic/size information */
-	__get_user_error(magic, &ctx->head.magic, err);
+	/* check the size information */
 	__get_user_error(size, &ctx->head.size, err);
 	if (err)
 		return -EFAULT;
-	if (magic != FPSIMD_MAGIC || size != sizeof(struct fpsimd_context))
+	if (size != sizeof(struct fpsimd_context))
 		return -EINVAL;
 
 	/* copy the FP and status/control registers */

-- 
2.30.2

