Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4126635F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbjAJAAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbjAIX75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:59:57 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECEF1D0FE;
        Mon,  9 Jan 2023 15:59:55 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1673308791;
        bh=1Wy0BHk7SYwdUBaE089VQhP0zqUnmzWkZKjn/dXjACA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bhYuK2oeJY8gviN3HbJr/bo8VBWAmueZts0nHUoGcq3wDBImKh7MFnh3mRZrmDLX+
         0SMkp+n5/sN1Ia632LjMZfE5fKkV/zMB4MfJ05wQy58ri0JC+j6xtYCUG+SJnjfQp3
         7qN5m62yuq9QPbpr1ftpjnboqLplCnonAy03Js54=
Date:   Mon, 09 Jan 2023 23:59:41 +0000
Subject: [PATCH RESEND v6 1/3] certs: make blacklisted hash available in
 klog
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221212-keys-blacklist-v6-1-933267a80582@weissschuh.net>
References: <20221212-keys-blacklist-v6-0-933267a80582@weissschuh.net>
In-Reply-To: <20221212-keys-blacklist-v6-0-933267a80582@weissschuh.net>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Mark Pearson <markpearson@lenovo.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12-dev-3dd91
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673308789; l=1169;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1Wy0BHk7SYwdUBaE089VQhP0zqUnmzWkZKjn/dXjACA=;
 b=c64cfXF9x4RM7Q5bWJbzQNo5OWkOwIZr0wI7+wka2HDRG/48d5yVSzS0LCG0cnzCPOFgUHMulrWd
 K0BaoTTODZ2RvzZDdadPLf0x0X4UvcdDZDrPF3LICVGlxG1Qv3Gg
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One common situation triggering this log statement are duplicate hashes
reported by the system firmware.

These duplicates should be removed from the firmware.

Without logging the blacklisted hash triggering the issue however the users
can not report it properly to the firmware vendors and the firmware vendors
can not easily see which specific hash is duplicated.

While changing the log message also use the dedicated ERR_PTR format
placeholder for the returned error value.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 certs/blacklist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 41f10601cc72..6e260c4b6a19 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -192,7 +192,7 @@ static int mark_raw_hash_blacklisted(const char *hash)
 				   KEY_ALLOC_NOT_IN_QUOTA |
 				   KEY_ALLOC_BUILT_IN);
 	if (IS_ERR(key)) {
-		pr_err("Problem blacklisting hash (%ld)\n", PTR_ERR(key));
+		pr_err("Problem blacklisting hash %s: %pe\n", hash, key);
 		return PTR_ERR(key);
 	}
 	return 0;

-- 
2.39.0

