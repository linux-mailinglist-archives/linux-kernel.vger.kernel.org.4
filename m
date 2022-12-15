Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C91764D66E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiLOGUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLOGUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:20:49 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59DE85445B;
        Wed, 14 Dec 2022 22:20:48 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id 089FA20A67F7; Wed, 14 Dec 2022 22:20:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 089FA20A67F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1671085248;
        bh=txxZyi1fNvIRHpcRd9K+cXPr9cLQU3hMoUsOwHCO7+c=;
        h=From:To:Cc:Subject:Date:From;
        b=JQ1Y+sAEo6sEG5h4xiaOtmSAdNZWGQsvnWygTZhRmYSSK34IJw0WGsLWAgCx+MXVe
         SG0+su7trpA41/t/CGq5cDvNVqRQxf1uM9EL5+I2JDtgEOcySWQVDX1cPzEQBYdJ2o
         1QbMXJnK1nlDzfBgH5Bv5XYbnqMSsyscHgIJPWC4=
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH] kernel: power: swap: Suppress expected 'Image not found'  error on Ubuntu
Date:   Wed, 14 Dec 2022 22:20:26 -0800
Message-Id: <1671085226-21347-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 'systemctl hibernate' if resume device is written to the sysfs
resume parameter, a software_resume() call is triggerred. This call
is expected to fail in swsusp_check() call with -EBUSY error and an
'Image not found' error message. This fix suppresses the expected
failure message from getting logged in Ubuntu setups where
CONFIG_DYNAMIC_DEBUG is enabled by default.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 kernel/power/swap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 277434b6c0bf..9cbd3edc8339 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1552,6 +1552,14 @@ int swsusp_check(void)
 			pr_debug("Image signature found, resuming\n");
 	} else {
 		error = PTR_ERR(hib_resume_bdev);
+		/*
+		 * If this call is triggered by `systemctl hibernate`, the
+		 * call is expected to fail with -EBUSY error.
+		 * TODO: Figure out a better way to suppress the error msg
+		 * in this case.
+		 */
+		if (error == -EBUSY)
+			return error;
 	}
 
 	if (error)
-- 
2.37.2

