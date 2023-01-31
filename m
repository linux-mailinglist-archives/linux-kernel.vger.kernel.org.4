Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC5968393D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjAaWVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjAaWVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:21:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6284E537
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:21:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD1DEB81F68
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 22:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977F8C433D2;
        Tue, 31 Jan 2023 22:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675203659;
        bh=s9F37xM7LhFLJp/xf/SllF+Kjwk5ytmvBvB+YyKKABs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=skGxjp2ImrOUOXpJCDOVO8Be8XE9TWgnCf+cH0nq9VeYJCKo8FsunY7CSXM37usUl
         7e2VsaKxrzMbaKPvPPmlyCD4mA2cGBzAcA4APSJN1yBmE+xwasE+4EqG42mtllcCIE
         04zEszNtcvR1+c9wEi29GDPpl71Xj/DQB01P67F1ANU/uGeIOLvdXdDnx3yu8wTZ0g
         hDENCrGEsXkdJyKX0rpi5G/hRqHAz6cPHx+conpcbD07jG0+iqnwEmVWAFBI7+geaf
         3d5HIUSfamsy6MkRDoQIANXwWj4mlv9H/msv1QqsCr5AjXbQB73SG2nMXumlw3itSe
         274akND6evaxg==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 31 Jan 2023 22:20:44 +0000
Subject: [PATCH v3 6/7] arm64/signal: Only read new data when parsing the
 ZA context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221212-arm64-signal-cleanup-v3-6-4545c94b20ff@kernel.org>
References: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
In-Reply-To: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1541; i=broonie@kernel.org;
 h=from:subject:message-id; bh=s9F37xM7LhFLJp/xf/SllF+Kjwk5ytmvBvB+YyKKABs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj2ZQ/xEqlBNbZLtXQ9Mx5CTs4LeILuHeNxC9RBFC+
 YegP0giJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9mUPwAKCRAk1otyXVSH0OlXB/
 9CpCkNmNGmjiSjxyBmSjmSnmYu3Mb7tkZudCsaFPGCOiB1UgNwOgtUIQe7Pod4w7t8eVBrxov3/MIr
 DHLaKHQZJ+6QmmisBQN62rr/oKLhq3gFj+p2F2yi1RfxlCvYMOTHmxSCJc2/dOJkliigpI4KhRy48z
 pjxL/YlBC+gPeUfktYf3pS3VR71uzhczPe9SQlcdLBIJsdc157DysZ/6nLWCkcqhR2/r/T+SdtuPo6
 ClGiTXvOMUg7C6fRtR/Z39QoQhl+JQ9yUlaB6iyvGyVFHXP7MI1k/nX5UVXQYm2V24ijKe/ePEjpEj
 efmd6L5XEHoJqWXFlyHzxe0GL1kqs5
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

When we parse the ZA signal context we read the entire context from
userspace, including the generic signal context header which was already
read by parse_user_sigframe() and padding bytes that we ignore. Avoid the
possibility of relying on the second read of the data read twice by only
reading the data which we are actually going to use.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/signal.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 27a1fa37f926..7810d090c025 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -435,17 +435,18 @@ static int preserve_za_context(struct za_context __user *ctx)
 
 static int restore_za_context(struct user_ctxs *user)
 {
-	int err;
+	int err = 0;
 	unsigned int vq;
-	struct za_context za;
+	u16 user_vl;
 
 	if (user->za_size < sizeof(*user->za))
 		return -EINVAL;
 
-	if (__copy_from_user(&za, user->za, sizeof(za)))
-		return -EFAULT;
+	__get_user_error(user_vl, &(user->za->vl), err);
+	if (err)
+		return err;
 
-	if (za.vl != task_get_sme_vl(current))
+	if (user_vl != task_get_sme_vl(current))
 		return -EINVAL;
 
 	if (user->za_size == sizeof(*user->za)) {
@@ -453,7 +454,7 @@ static int restore_za_context(struct user_ctxs *user)
 		return 0;
 	}
 
-	vq = sve_vq_from_vl(za.vl);
+	vq = sve_vq_from_vl(user_vl);
 
 	if (user->za_size < ZA_SIG_CONTEXT_SIZE(vq))
 		return -EINVAL;

-- 
2.30.2

