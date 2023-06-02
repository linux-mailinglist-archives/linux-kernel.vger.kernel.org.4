Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A2B71FD46
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjFBJMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjFBJMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:12:22 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Jun 2023 02:10:57 PDT
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F50E5F;
        Fri,  2 Jun 2023 02:10:57 -0700 (PDT)
From:   Daniil Dulov <d.dulov@aladdin.ru>
To:     Zhang Rui <rui.zhang@intel.com>
CC:     Daniil Dulov <d.dulov@aladdin.ru>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen Yu <yu.c.chen@intel.com>, Sasha Levin <sashal@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
Subject: [PATCH] thermal: intel_powerclamp: Check for a possible array out of bounds access.
Date:   Fri, 2 Jun 2023 01:55:46 -0700
Message-ID: <20230602085546.376086-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.20.125]
X-ClientProxiedBy: EXCH-2016-02.aladdin.ru (192.168.1.102) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ratio may be equal to MAX_TARGET_RATIO - 1 that will result in
out of bound access.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d6d71ee4a14a ("PM: Introduce Intel PowerClamp Driver")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/thermal/intel/intel_powerclamp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index fb04470d7d4b..9deaf2b8ccf6 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -277,7 +277,8 @@ static unsigned int get_compensation(int ratio)
 		comp = (cal_data[ratio].steady_comp +
 			cal_data[ratio - 1].steady_comp +
 			cal_data[ratio - 2].steady_comp) / 3;
-	} else if (cal_data[ratio].confidence >= CONFIDENCE_OK &&
+	} else if (ratio < MAX_TARGET_RATIO - 1 &&
+		cal_data[ratio].confidence >= CONFIDENCE_OK &&
 		cal_data[ratio - 1].confidence >= CONFIDENCE_OK &&
 		cal_data[ratio + 1].confidence >= CONFIDENCE_OK) {
 		comp = (cal_data[ratio].steady_comp +
-- 
2.25.1

