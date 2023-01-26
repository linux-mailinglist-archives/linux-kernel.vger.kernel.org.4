Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D00867D8DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjAZWyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjAZWye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:54:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8AA7AA8;
        Thu, 26 Jan 2023 14:54:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF00CB81C5E;
        Thu, 26 Jan 2023 22:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A2AC433D2;
        Thu, 26 Jan 2023 22:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674773667;
        bh=A3hJdPRvqNFhvIc040dVHaOyGrcDglgpuQvKqvik2wo=;
        h=From:To:Cc:Subject:Date:From;
        b=otj/1MSrw0yysqoNbGEuXeqQMozGhrSqIB9eZlrYgbsXb4hIJbrZMzmFR7/RnYlIQ
         u5V34KfTKJG9ucf79p0W1+TlGqcCdMG11D1PJxtMXKq3CVYLrD/jxEyVpzZq736mSn
         D240LUTOUZRvQW1B4b15LN0zrhZoVckt9GfvmDGiIvBCO2AIrqZZOoLIuyF6Cri+8K
         phI/LbAbDN9O2VSUNn8vSqwMpux/0Fo48+4Gk80UfKowbTCeDINM1rwX7PA3TWGMoz
         uLixwzi5EQJL6KJSG8Kl6wJ6p0mjzZ/mjg99bBrEaEc6CgkgIi+gQ2K9hdgpf9Ilkw
         BB5Z8mFI1EN9A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] printk: Document that CONFIG_BOOT_PRINTK_DELAY required for boot_delay=
Date:   Thu, 26 Jan 2023 16:54:20 -0600
Message-Id: <20230126225420.1320276-1-helgaas@kernel.org>
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

From: Bjorn Helgaas <bhelgaas@google.com>

Document the fact that CONFIG_BOOT_PRINTK_DELAY must be enabled for the
"boot_delay" kernel parameter to work.  Also mention that "lpj=" may be
necessary.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
Changes from v1 (https://lore.kernel.org/all/20230123180440.901793-1-helgaas@kernel.org/):
- Clarify use of "lpj=".  Reword consequences of delay larger than 10000.

 Documentation/admin-guide/kernel-parameters.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..814e58487239 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -480,8 +480,10 @@
 			See Documentation/block/cmdline-partition.rst
 
 	boot_delay=	Milliseconds to delay each printk during boot.
-			Values larger than 10 seconds (10000) are changed to
-			no delay (0).
+			Only works if CONFIG_BOOT_PRINTK_DELAY is enabled,
+			and you may also have to specify "lpj=".  Boot_delay
+			values larger than 10 seconds (10000) are assumed
+			erroneous and ignored.
 			Format: integer
 
 	bootconfig	[KNL]
-- 
2.25.1

