Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B8264DEA2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiLOQ3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiLOQ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:29:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D3232B84;
        Thu, 15 Dec 2022 08:29:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD69861E62;
        Thu, 15 Dec 2022 16:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18432C433D2;
        Thu, 15 Dec 2022 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671121752;
        bh=hTVlrLLNPPrnPwLwZn/P6XxxNEQh61wi48u/i/H+3Fk=;
        h=From:To:Cc:Subject:Date:From;
        b=sMsCqgJjCYkzb8omjFTfh4gJjfPdKVca1gyUvNd+kGHH2Catybh3ApOuNimtbNH5M
         WpFGmqWe2JnVK4HAJ9xt+ydJm1FkNeDwlX5w1c7ODEOVgxpmO2QDbWH6Z1m3W7hYX8
         cQJ8Xi3DUs88KozktfLLO+cHB4MEPeQlmyO6WO82RwNzMfCsG3O1rDhEICcCWYbP8P
         B/BdfesiqAZDfiLF54HDkICKCyI+XLUcAXQ7YLEzeJPzJ2pIuYBocpBMgDljBvpYYf
         pN6UdnmV0KSsLbq2Qy/2z2zwwjlYV7GySiFPy7kYXbIwO1GtB9ZywIpRxdLA+XTx1P
         1bnxVt5LBn6NQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>,
        Todor Tomov <todor.too@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jonathan Marek <jonathan@marek.ca>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: camss: csiphy-3ph: avoid undefined behavior
Date:   Thu, 15 Dec 2022 17:28:46 +0100
Message-Id: <20221215162905.3960806-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Marking a case of the switch statement as unreachable means the
compiler treats it as undefined behavior, which is then caught by
an objtool warning:

drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.o: warning: objtool: csiphy_lanes_enable() falls through to next function csiphy_lanes_disable()

Instead of simply continuing execution at a random place of the
driver, print a warning and return from to the caller, which
makes it possible to understand what happens and avoids the
warning.

Fixes: 53655d2a0ff2 ("media: camss: csiphy-3ph: add support for SM8250 CSI DPHY")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index 451a4c9b3d30..04baa80494c6 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -429,7 +429,8 @@ static void csiphy_gen2_config_lanes(struct csiphy_device *csiphy,
 		array_size = ARRAY_SIZE(lane_regs_sm8250[0]);
 		break;
 	default:
-		unreachable();
+		WARN(1, "unknown cspi version\n");
+		return;
 	}
 
 	for (l = 0; l < 5; l++) {
-- 
2.35.1

