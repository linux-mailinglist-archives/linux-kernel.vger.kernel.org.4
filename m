Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FE570E903
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 00:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbjEWWSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 18:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238702AbjEWWSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 18:18:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8188B18B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 15:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2CF6636A1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55445C433D2;
        Tue, 23 May 2023 22:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684880307;
        bh=veuGFlBxvJfC7X2QtcsRIS3sb0+f5+8pwpEBphVcea0=;
        h=From:Date:Subject:To:Cc:From;
        b=JR708gZp1IuCASbi+tDPkn5+t1JnIHoMs9mSTcig2R+T9CxxXkdHsf9XBy+XyjTMv
         yYwWMFkESn+z5kokf/CGwqfLEeIsN15IZBhIhmrFXtQ9gBrmiwb+43+q9nCPr0eYvF
         PTXJUdA/APWCtM7dK3DXD1X1sLP39HdwmrCRUrtsL1mZQTPDQW26H49PNClitjQ+WM
         tzXIciRH24k2j0G55oHXFX2pxazGzoc/q0Yvm8xc5aHKw54H7TUsjowK/GEjEyApLD
         PHp1WQs8I3B/t57U0PuaTX1DZBrBBP7WFFZsM7Pv7vgUPgd3B0RYQcBVp2lAkkEK3y
         joL3vYR+Z+10A==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 23 May 2023 23:18:19 +0100
Subject: [PATCH] regmap: maple: Drop the RCU read lock while syncing
 registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230523-regcache-maple-sync-lock-v1-1-530e4d68dfab@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKo7bWQC/x2NSwrDMAwFrxK0rsC1cQq9SulCVtTYJLWDDP0Qc
 vc4Wc6DebNCFU1S4d6toPJJNZXc4HrpgCPlUTANjcEa64y3DlVGJo6Cb1pmwfrPjHPhCf1NyPl
 +4N4EaHqgKhiUMsfj4Ft0OuZF5ZV+Z/Hx3LYdNbKb+IEAAAA=
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=broonie@kernel.org;
 h=from:subject:message-id; bh=veuGFlBxvJfC7X2QtcsRIS3sb0+f5+8pwpEBphVcea0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkbTux4oldhXQTi6/rzUziSGq1Bbp/Z2NlJcHmVfx7
 fiVpr36JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZG07sQAKCRAk1otyXVSH0LrfB/
 wLlMLGMlNDljolW7vhDGSgSVC1ef3/0xxRYT7v8CnysolmzHP09D4O5rX4blrw9D7+pL81KrAAc0Ht
 4lHCGE18Z4FCHuKpEkul+vpL9FrhysJMxVh0QKwCXZ0bXuqU9xoPWAlI1sUQcG/Po8uJJLvXFg5tVF
 3pBPGhev+JPpfl2wZqH+CR8R4l7NgSZ90syYXXAnYL1Q7uCaxbiA3nkpUAmahZCPNku9jlJw6NIPC4
 3vHz4xm7SGYbsvnhiJ/P1taHJH+93gUh5qCRxUcWumlg2wpXu3Y2MeL/hNbnSY4cFjI5K/7d4HqeAm
 a5l6fPwiwaFf5V8hfh/7zgbxGqCfZh
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

Unfortunately the maple tree requires us to explicitly lock it so we need
to take the RCU read lock while iterating. When syncing this means that we
end up trying to write out register values while holding the RCU read lock
which triggers lockdep issues since that is an atomic context but most
buses can't be used in atomic context. Pause the iteration and drop the
lock for each register we check to avoid this.

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regcache-maple.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 9b1b559107ef..c2e3a0f6c218 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -203,15 +203,18 @@ static int regcache_maple_sync(struct regmap *map, unsigned int min,
 
 	mas_for_each(&mas, entry, max) {
 		for (r = max(mas.index, lmin); r <= min(mas.last, lmax); r++) {
+			mas_pause(&mas);
+			rcu_read_unlock();
 			ret = regcache_sync_val(map, r, entry[r - mas.index]);
 			if (ret != 0)
 				goto out;
+			rcu_read_lock();
 		}
 	}
 
-out:
 	rcu_read_unlock();
 
+out:
 	map->cache_bypass = false;
 
 	return ret;

---
base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
change-id: 20230523-regcache-maple-sync-lock-57ea356dc60b

Best regards,
-- 
Mark Brown <broonie@kernel.org>

