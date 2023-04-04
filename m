Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C801C6D6D57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbjDDTmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjDDTmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:42:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9D740D9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7DFC63662
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 19:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDF1C433EF;
        Tue,  4 Apr 2023 19:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680637354;
        bh=9jF6cncPMExB3h8iUIwTFCwOtG+nCcN1cxEvxO5Y8io=;
        h=From:Date:Subject:To:Cc:From;
        b=QCUUSa3rs55stYoSESzuIUFgKM4FYXJLnU2ZqUGAVl0lkJhfc3X7gkqiUZWGV5dX5
         B/hNkM4Yq0sRmmBALwdG4QeBv6rfN0rtjUN8Gw6/QmvrYPf/o0fw/JaRKFjI6BKOLh
         wnNfzpe8aAs2kMjfiJGk/7txXqtj/rmh/5W0DuCFnpk31RGKSGLzlHOA8CnWcANGdb
         AfO/Pa4DSCINVt9neu8/vM7x2L0oV+JK6KSWxowycPTkC4o32ZuG1kV7acYJ77qinw
         nOps0zVk4W005pPGsOwNTAkqvACa6zAJOiDoQ3vN4npoKbpHrv9Eg6hbIvTtJvuQZz
         bTxajOXFOoPdQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 04 Apr 2023 20:42:28 +0100
Subject: [PATCH v2] regmap: Use mas_walk() instead of mas_find()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-regmap-maple-walk-fine-v2-1-c07371c8a867@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKN9LGQC/4WNQQqDMBBFryKz7pQkNlC76j3ERWJGDdpEJkVbx
 Ls3eoEu/uJ9eLwNErGnBI9iA6bFJx9DBnUpoB1M6Am9ywxKqFLcRIlM/cvMmDcRrmYasfOBsLo
 ra51ybUcasmxNIrRsQjsc+hp5PO6ZqfOfs1c3mQef3pG/Z36Rx/u3tEiUKCotlXNakhbPkTjQd
 I3cQ7Pv+w+Cdfal1AAAAA==
To:     Liam.Howlett@Oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9jF6cncPMExB3h8iUIwTFCwOtG+nCcN1cxEvxO5Y8io=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkLH2ofhETmgYh0TRqZKndr5LeWM04/2yTtJQCSP+m
 jP9LfwyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZCx9qAAKCRAk1otyXVSH0HTIB/
 4hzczWbRFBucw2Q4aW32qRaWrUomLRaPgbkaAiIziLaHdGalxllgJVJYX7X6PxVRogv5VgIkAJ+C6g
 Ge1ATIMT5xX7lxGcjMkobPROm0QXechQ/V80oqWyZ+u97rgjgFRkWxP/enPxUfx+OiBB++EOjI3RCy
 W/6ZEA3P1vLelu85zbCtDMKhWRa4D6W2YfCydFZLC0nrUZLfClrMnyVo1jU7oLymErdhhPs/i4gP2c
 n/w2+XHPh78tyR05UbpfZtKbeq4fuhqItSknFkoFdbyxZ+6GGjzR5ob0gnLAVmBILFPAo2srAAvu3f
 54XRBnNKR5DmrozZ4OJ+NhkUUYYrUe
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liam recommends using mas_walk() instead of mas_find() for our use case so
let's do that, it avoids some minor overhead associated with being able to
restart the operation which we don't need since we do a simple search.

Suggested-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Don't set index and last again needlessly.
- Link to v1: https://lore.kernel.org/r/20230403-regmap-maple-walk-fine-v1-1-09512dd51e50@kernel.org
---
 drivers/base/regmap/regcache-maple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 497cc708d277..e48f5b0c96cb 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -22,7 +22,7 @@ static int regcache_maple_read(struct regmap *map,
 
 	rcu_read_lock();
 
-	entry = mas_find(&mas, reg);
+	entry = mas_walk(&mas);
 	if (!entry) {
 		rcu_read_unlock();
 		return -ENOENT;
@@ -47,7 +47,7 @@ static int regcache_maple_write(struct regmap *map, unsigned int reg,
 
 	rcu_read_lock();
 
-	entry = mas_find(&mas, reg);
+	entry = mas_walk(&mas);
 	if (entry) {
 		entry[reg - mas.index] = val;
 		rcu_read_unlock();

---
base-commit: f033c26de5a5734625d2dd1dc196745fae186f1b
change-id: 20230403-regmap-maple-walk-fine-982bbd2dcfe5

Best regards,
-- 
Mark Brown <broonie@kernel.org>

