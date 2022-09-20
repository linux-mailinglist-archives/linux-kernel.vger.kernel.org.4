Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8165A5BE654
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiITMw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiITMwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:52:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960936BD54
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:52:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BD2BB817AC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECF0C433D6;
        Tue, 20 Sep 2022 12:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663678371;
        bh=rYXkxXhZXkhz9QcfPOwuYRFm6MTk5vueHNl2IpH5XgA=;
        h=From:To:Cc:Subject:Date:From;
        b=tO9LJiAebW1nuHuzdghgjkxiEITkNraKftjg3ggaWWqhpp1UrQZrgIodMJMdsBcEv
         b49IK4zHR6g6V+OT6hkXfynoq5DubUV7mrCF0rXlw1iCI/bNJG0mgePxafi9BbBzDj
         AGd+Ap4BStD3u8gLuIuSrT6yCearXjb84FrKF61CLCqSednnGF8AQAzQetni3lDTXk
         5ouJ6UG3OLME9WgrXxVelrHrRrLTUMNnggD7HicBu8VXAOr3MYDbPrb8TxJMMLYInM
         OSxACE7GxH/+ZIVx3mmF3GCfxT/EGYnD9iqZvA3cxcEykjULS/+lx1YQfl9LEEc+R+
         LKY45a9bJXCHQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 1/4] habanalabs: build ASICs from new to old
Date:   Tue, 20 Sep 2022 15:52:42 +0300
Message-Id: <20220920125245.161233-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

From: Ohad Sharabi <osharabi@habana.ai>

Newer ASICs code changes more often, has more chance to fail
compilation. So, let's compile them first so errors in those files
will fail compilation sooner.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
index b35d7000c86b..a48a9e0969ed 100644
--- a/drivers/misc/habanalabs/Makefile
+++ b/drivers/misc/habanalabs/Makefile
@@ -8,13 +8,13 @@ obj-$(CONFIG_HABANA_AI) := habanalabs.o
 include $(src)/common/Makefile
 habanalabs-y += $(HL_COMMON_FILES)
 
-include $(src)/goya/Makefile
-habanalabs-y += $(HL_GOYA_FILES)
+include $(src)/gaudi2/Makefile
+habanalabs-y += $(HL_GAUDI2_FILES)
 
 include $(src)/gaudi/Makefile
 habanalabs-y += $(HL_GAUDI_FILES)
 
-include $(src)/gaudi2/Makefile
-habanalabs-y += $(HL_GAUDI2_FILES)
+include $(src)/goya/Makefile
+habanalabs-y += $(HL_GOYA_FILES)
 
 habanalabs-$(CONFIG_DEBUG_FS) += common/debugfs.o
-- 
2.25.1

