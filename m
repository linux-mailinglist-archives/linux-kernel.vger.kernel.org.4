Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3E474C59E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjGIPRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjGIPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:16:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681E926AE;
        Sun,  9 Jul 2023 08:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3742D60BA4;
        Sun,  9 Jul 2023 15:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CBBC433AD;
        Sun,  9 Jul 2023 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915651;
        bh=tPlnrUOB44ixW+YBquQhtPmxhbOHRKsLyCXO3Ctx5n8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fR502gn3j5irkmlOamCCkNlVD5JEpZ6PT9EB/lCFuMuEZoVh00W9kipbtrBZ3LzFv
         8Zgs2ADx0G0NDacEnjeIsQIHXcfqYsTcRIanP4iZW7k3eUtb5Pe8pk40fO3R2LPnmY
         YYeNHrrtNjlOwV56CvSstUstMQqW6aVWkNl5SwpXs3/5v++Qnb1GwlcGocZ0LpnWbw
         lSgOGnPJXum+iRc9B8Vhlk7TxnJZrTYJwmZKdXfQ8kAUDBulsVptuSf7FhwP84XrMl
         olHNLtj4N72SFsUamvsAIltoyYFXzjpDIVyS72GAY99oUV59m2LKFuWUr/yh1iiPcu
         xo5abzUsdNYUw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 08/22] devlink: make health report on unregistered instance warn just once
Date:   Sun,  9 Jul 2023 11:13:42 -0400
Message-Id: <20230709151356.513279-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151356.513279-1-sashal@kernel.org>
References: <20230709151356.513279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 6f4b98147b8dfcabacb19b5c6abd087af66d0049 ]

Devlink health is involved in error recovery. Machines in bad
state tend to be fairly unreliable, and occasionally get stuck
in error loops. Even with a reasonable grace period devlink health
may get a thousand reports in an hour.

In case of reporting on an unregistered devlink instance
the subsequent reports don't add much value. Switch to
WARN_ON_ONCE() to avoid flooding dmesg and fleet monitoring
dashboards.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://lore.kernel.org/r/20230531015523.48961-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/devlink/health.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index 0839706d5741a..194340a8bb863 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -480,7 +480,7 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
 	int err;
 
 	WARN_ON(cmd != DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
-	WARN_ON(!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED));
+	ASSERT_DEVLINK_REGISTERED(devlink);
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
-- 
2.39.2

