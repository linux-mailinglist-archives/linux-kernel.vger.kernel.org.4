Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA52E68E1A1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjBGT63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjBGT60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:58:26 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4821EBF3;
        Tue,  7 Feb 2023 11:58:24 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675799902;
        bh=gQIB2oBdFzdMrOmsZZakdwbSbKgg9O/YSolMA4XUr1U=;
        h=From:Date:Subject:To:Cc:From;
        b=g4Ed3ZyyQ696wqyDleKSdeI0hjWTXYFovyZVz8/CWkk7n4Hd6VYsZdBRqmpcsdtAv
         bZhGPUbHmHvxbrT0snImNyA43bIMd2stlpR6TVUfL7KELxv+8DL2MrfkYYb10RPY0k
         vzBSElGdrbG/I7tJMse21hvzqKKbQNIh9dqmBKw0=
Date:   Tue, 07 Feb 2023 19:58:18 +0000
Subject: [PATCH] cpufreq: Make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230207-kobj_type-cpufreq-v1-1-c7fa2dbd0754@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAFmt4mMC/x2NWwrCMBAAr1L224WYUBSvIiJ5bOxqSePGilJ69
 y79nIFhFmgkTA0u3QJCX248FYXjoYM4+PIg5KQM1lhnrDnhawrP++dfCWOds9Abc/Kpd9mE3p1
 Bu+AbYRBf4qBlmcdRZRXK/NtH19u6bv/PHtt4AAAA
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675799898; l=1020;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=gQIB2oBdFzdMrOmsZZakdwbSbKgg9O/YSolMA4XUr1U=;
 b=oSax7r559kqmhMpcuU6FLIVeWeqnoxNwcj7aKLS5irfkVrnnp/ZceW9/4J7YUIGFNDSFOAYt+
 BdzEBP0Q/HrBNK+h+fgBac9tE8ij+v5QMPLNT9pNVoI7V0axMiu87BY
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

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definition to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7e56a42750ea..ceb1574417f9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -993,7 +993,7 @@ static const struct sysfs_ops sysfs_ops = {
 	.store	= store,
 };
 
-static struct kobj_type ktype_cpufreq = {
+static const struct kobj_type ktype_cpufreq = {
 	.sysfs_ops	= &sysfs_ops,
 	.default_groups	= cpufreq_groups,
 	.release	= cpufreq_sysfs_release,

---
base-commit: 513c1a3d3f1982fb850c910937099525b0d35e24
change-id: 20230207-kobj_type-cpufreq-fdad53f0b538

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

