Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2F46D51B3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjDCUAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjDCUAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:00:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E963CD7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 13:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8543762950
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 20:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32ECC433D2;
        Mon,  3 Apr 2023 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680552017;
        bh=wWhl5BO+MfmttCEYPrR6iCQCTocuBDmG7hzKkDLpiEY=;
        h=From:Date:Subject:To:Cc:From;
        b=RlU27bvgnVIZ1GKdEIB6+ciFV1mx+akcXX2NWw7hnvXjrDbv+u3PSsaD6sKwAwIkU
         AL98YXCl+Vd6CUGAPMpP3zB+l4XBlj94ev9DaHwhA7USUXiwbsr9UFb+m9E0PbkmVp
         deWnn2Pa1hPuobDynVtTAm17pEGTTb448DOY8vZekIBHyTTFrm1128Scm79wPvijuw
         /8BaI07flgBKl8npYnm0hfRPNRNLfCHYtBXwmoHMpxFOl1HM4roaUxq4sitqFW5Q7S
         HR7DQLI51P2f0qGvOuQvy0SsqKE5EYHDMcsVkr0t62Hsc45KJUP7akn9e5S0j1x30y
         TJFCGaaOT+inw==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 03 Apr 2023 20:59:44 +0100
Subject: [PATCH] regmap: Use mas_walk() instead of mas_find()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-regmap-maple-walk-fine-v1-1-09512dd51e50@kernel.org>
X-B4-Tracking: v=1; b=H4sIAC8wK2QC/x2NywqDMBBFf0Vm3YE0Vmj7K6WLPG500EaZQC2I/
 97o4i7OhcPZqEAFhZ7NRoqvFJlzheuloTC43IMlViZrbGtupmVF/3EL103g1U0jJ8ngx916H20
 MCR1V2bsC9upyGA59nXU87kWR5Hf2Xu99/wPwVgZsfwAAAA==
To:     Liam.Howlett@Oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wWhl5BO+MfmttCEYPrR6iCQCTocuBDmG7hzKkDLpiEY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkKzBPMCJJJ9pw9zNKYOGOOOthUXSElqODjRYbaAQQ
 wHMJiNaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZCswTwAKCRAk1otyXVSH0HyjB/
 9wuWX5Z7lfnrqp1liHLKEwKUHODnEuvabqwTPf1uvVDhjFhgC3G9DFzPu978V6VXl4p3wNClqRku2N
 2T/8cUIuGr60h7YwgaE/UdYTwjzCUKTls1yYu7Oaxw+joUONq5KfogO5wpcxpPJf5y5zb5Jb4QFJl/
 5WSOkQdPYZG/sub3/fHB9hpDpyENfZbsu/xDWmcztea3nGf2Z47ygjGAeJ2b5RMBZrfruvpZZqgyvP
 UBPLEgFuOCPeFsQlCwn2dSugunJehlic96yryxmykQFgB7JayX7/cM8avae/ar6WTSoH43xw77ikLD
 9/pZKZMFtYcEsLineeob16SXJ/jxOO
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
 drivers/base/regmap/regcache-maple.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 497cc708d277..5d1bc3691830 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -22,7 +22,9 @@ static int regcache_maple_read(struct regmap *map,
 
 	rcu_read_lock();
 
-	entry = mas_find(&mas, reg);
+	mas.index = reg;
+	mas.last = reg;
+	entry = mas_walk(&mas);
 	if (!entry) {
 		rcu_read_unlock();
 		return -ENOENT;
@@ -47,7 +49,9 @@ static int regcache_maple_write(struct regmap *map, unsigned int reg,
 
 	rcu_read_lock();
 
-	entry = mas_find(&mas, reg);
+	mas.index = reg;
+	mas.last = reg;
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

