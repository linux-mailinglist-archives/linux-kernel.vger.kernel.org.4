Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D987333F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345721AbjFPOuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345713AbjFPOuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA0030EB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43C6A63CFD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 14:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA777C433C0;
        Fri, 16 Jun 2023 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686927020;
        bh=aEGQIyQH+ng6zCmITf21YgP8Yf+bC5Kk7ngJnR9VmGQ=;
        h=From:To:Cc:Subject:Date:From;
        b=pskvSaL4qUT8OQmfocSE2D1oC123LHsXjhHwQI5qJhBT+4LUCNli2MN3wz1DiJKr1
         a0LK82Ju/N+XJU2mFfMyRtSamYBUETjRK3zOvDm2Ujs4Va5Kiw59vpV9IDi0DgNoov
         D2+C5y9pROF6ouIwrWYnM5iHu2D6rt4P/5RXxpS/XJ2EeCX7NlUyqLqcZ7Nfjt5EZn
         THclYP5FJzESYRA+aaBD9Hl2YnULHKI9i84J1r2xiA16HjNHJUz6ExOGdubllAKCJG
         MkNZjByS4xpuFE3zjKBYAl+LhLsXWshaI30ii80oezdg4fB8LSg/Q3uWnAfAyyS8P2
         zRjS609bP/LRA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Julien Panis <jpanis@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, Hao Ge <gehao@kylinos.cn>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Miguel Ojeda <ojeda@kernel.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] samples: pfsm: add CC_CAN_LINK dependency
Date:   Fri, 16 Jun 2023 16:50:10 +0200
Message-Id: <20230616145013.3889906-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When no libc for the target architecture is available, cross-compiling
the same cannot work:

samples/pfsm/pfsm-wakeup.c:12:10: fatal error: fcntl.h: No such file or directory

Fixes: 9e66fb5244953 ("samples: Add userspace example for TI TPS6594 PFSM")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 samples/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/Kconfig b/samples/Kconfig
index 3edf73a3dc9bf..bf49ed0d73623 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -256,6 +256,7 @@ config SAMPLE_INTEL_MEI
 config SAMPLE_TPS6594_PFSM
 	bool "Build example program working with TPS6594 PFSM driver"
 	depends on HEADERS_INSTALL
+	depends on CC_CAN_LINK
 	help
 	  Build a sample program to work with PFSM devices.
 
-- 
2.39.2

