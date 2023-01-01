Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E634B65A91D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 07:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjAAGHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 01:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAAGHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 01:07:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31F063A8;
        Sat, 31 Dec 2022 22:07:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 985FCB8091A;
        Sun,  1 Jan 2023 06:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD58C433EF;
        Sun,  1 Jan 2023 06:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672553240;
        bh=9xpDRRiUqx+Q+CCLWj7hfItw6akiNPSCwfmhAiX3nDQ=;
        h=From:To:Cc:Subject:Date:From;
        b=G7lksRvydhnrDpc+WaKM2/DLI3ZDlRfr+DgGYkgRmOxR4fAIe7rbud98ViQa+gt3p
         SReE6beKDR/dEYb/RJS/IaxLyT7cMMD6zv3+hOQHfv1b2WsXJcDoPzc/WPUBBC2a91
         BUqUYhl1HMivM34EU0yr4Gvv4kiN5qjzmt7a1cZT5Amz/1kMLv7hwJKM8bPWug8URU
         DTW83RKm21yGDRz7l2nE8O/BSNV1laG9MQoZ38cuuyy0uYykrYz5nx4yFtG2JxdCle
         w8bO5mv98vXR1L+sCPCqvQnB0GSHa+uSVHItogJ795KNwVi90x7R1ZgH9hW4SPo6Mf
         RCPDQHeWfbKnQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: fix single *.ko build
Date:   Sun,  1 Jan 2023 15:07:09 +0900
Message-Id: <20230101060709.208512-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

The single *.ko build is broken since commit f65a486821cf ("kbuild:
change module.order to list *.o instead of *.ko").

Fixes: f65a486821cf ("kbuild: change module.order to list *.o instead of *.ko")
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7cfbf3d15466..a0536633cdf6 100644
--- a/Makefile
+++ b/Makefile
@@ -1989,7 +1989,7 @@ $(single-no-ko): $(build-dir)
 # Remove MODORDER when done because it is not the real one.
 PHONY += single_modules
 single_modules: $(single-no-ko) modules_prepare
-	$(Q){ $(foreach m, $(single-ko), echo $(extmod_prefix)$m;) } > $(MODORDER)
+	$(Q){ $(foreach m, $(single-ko), echo $(extmod_prefix)$(m:%.ko=%.o);) } > $(MODORDER)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 ifneq ($(KBUILD_MODPOST_NOFINAL),1)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
-- 
2.34.1

