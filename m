Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2595D608164
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJUWSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJUWSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:18:25 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB082AB11A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:18:23 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id y80so3495625iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZvHy7jdg7bn/NJGr1GFQwTrExyfPTldTZ+sxF4fBFk=;
        b=DPPzQn6bpnBujPZ4Po2qLVhYnKyqqB56z+hRzedBT+NeViwX3jGWzdOS1lofPngvYL
         0qf2JZIGX5bKY6sUyjWrRR90ki955StSmKMtrfGaqk79n8luJpEQ527LqW78kcgn0wyx
         cnvmOnTqlf4WGWa5dQKEeCEZLXZdrLNoea3t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZvHy7jdg7bn/NJGr1GFQwTrExyfPTldTZ+sxF4fBFk=;
        b=7hOGzVzaGJHCGSSMCYFOiAI8oltgoEUoK2Sb6C2HW7Z+06ksNjT8RDpJxMNnRNyW5X
         NXk3JB68WspEHmpWtRhhMzPkcEDIckJ6VscxsyM9vqWkemxiYSigiSFU/gx+rflBd+HU
         +Gnx/PBowHJmMHykiM66uRQwqKZz8B/FrdbNkiBkXqwunO+H6JQw6te44JQelXrk+dXl
         1IHiXXu4hbXJUNHRgYpNrkZ3WaSzvdyt7EQZ+gHxe5K6VhEMkWsUvb3P6d9LDRy4Wk2f
         sYG+EXFpaJEdF3+ioHoqwpYDxO4Dt9QE1nrcE1iHpJfYYf5xIJteDP+n0OdpBP3Cd6N6
         O3RA==
X-Gm-Message-State: ACrzQf35mgkDqPVK0JFTnsd3vtezHOGJekqA+8ZSvMvqitOQ/tskIi5i
        txltigy++0vXLvDxO/ungbl0Dw==
X-Google-Smtp-Source: AMsMyM7qFgbQoonCDjTvSpxKOA3uQILHkyAzMUOM9/7JV5qxcrt8wyutiuuLa6ftTC3mxrNHR1LDUQ==
X-Received: by 2002:a02:390c:0:b0:363:79f0:ad37 with SMTP id l12-20020a02390c000000b0036379f0ad37mr16856345jaa.95.1666390702490;
        Fri, 21 Oct 2022 15:18:22 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cp6-20020a056638480600b0036cc14af7adsm430740jab.149.2022.10.21.15.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:18:21 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     skhan@linuxfoundation.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] selftests/watchdog: change to print reset reason info.
Date:   Fri, 21 Oct 2022 16:18:16 -0600
Message-Id: <bf788f813682f27dda3f732c05476a4c3d521f89.1666390362.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666390362.git.skhan@linuxfoundation.org>
References: <cover.1666390362.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test prints reset reason when WDIOC_GETBOOTSTATUS returns
a 0 flag value and all other cases simply say watchdog.

Parse the flag values returned by WDIOC_GETBOOTSTATUS and print
corresponding reset reason for each WDIOF_* boot status.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../selftests/watchdog/watchdog-test.c        | 58 ++++++++++++++++++-
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index f45e510500c0..5db9ad8b543c 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -1,6 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Watchdog Driver Test Program
+* Watchdog Driver Test Program
+* - Tests all ioctls except WDIOC_GETTEMP
+* - Tests Magic Close - CONFIG_WATCHDOG_NOWAYOUT
+* - Could be tested against softdog driver on systems that
+*   don't have watchdog hadrware.
+* - TODO:
+* - WDIOC_GETSTATUS is called when WDIOC_GETBOOTSTATUS is called.
+* - Enhance the logic to call WDIOC_GETSTATUS and test return values.
+* - Enhance coverage of ioctl return values - flags and status.
+* - Enhance test to add coverage for WDIOC_GETTEMP.
+*
+* Reference: Documentation/watchdog/watchdog-api.rst
  */
 
 #include <errno.h>
@@ -91,6 +102,44 @@ static void usage(char *progname)
 	printf("Example: %s -t 12 -T -n 7 -N\n", progname);
 }
 
+struct wdiof_status {
+	int flag;
+	const char *status_str;
+};
+
+#define WDIOF_NUM_BOOTSTATUS 7
+
+static const struct wdiof_status wdiof_bootstatus[WDIOF_NUM_BOOTSTATUS] = {
+	{WDIOF_OVERHEAT, "Reset due to CPU overheat"},
+	{WDIOF_FANFAULT, "Fan failed"},
+	{WDIOF_EXTERN1, "External relay 1"},
+	{WDIOF_EXTERN2, "External relay 2"},
+	{WDIOF_POWERUNDER, "Power bad/power fault"},
+	{WDIOF_CARDRESET, "Card previously reset the CPU"},
+	{WDIOF_POWEROVER,  "Power over voltage"},
+};
+
+static void print_boot_status(int flags)
+{
+	int wdiof = 0;
+
+	if (flags == WDIOF_UNKNOWN) {
+		printf("Unknown flag error from WDIOC_GETBOOTSTATUS\n");
+		return;
+	}
+
+	if (flags == 0) {
+		printf("Last boot is caused by: Power-On-Reset\n");
+		return;
+	}
+
+	for (wdiof = 0; wdiof < WDIOF_NUM_BOOTSTATUS; wdiof++) {
+		if (flags & wdiof_bootstatus[wdiof].flag)
+			printf("Last boot is caused by: %s\n",
+				wdiof_bootstatus[wdiof].status_str);
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	int flags;
@@ -140,8 +189,7 @@ int main(int argc, char *argv[])
 			oneshot = 1;
 			ret = ioctl(fd, WDIOC_GETBOOTSTATUS, &flags);
 			if (!ret)
-				printf("Last boot is caused by: %s.\n", (flags != 0) ?
-					"Watchdog" : "Power-On-Reset");
+				print_boot_status(flags);
 			else
 				printf("WDIOC_GETBOOTSTATUS error '%s'\n", strerror(errno));
 			break;
@@ -249,6 +297,10 @@ int main(int argc, char *argv[])
 		sleep(ping_rate);
 	}
 end:
+	/*
+	 * Send specific magic character 'V' just in case Magic Close is
+	 * enabled to ensure watchdog gets disabled on close.
+	 */
 	ret = write(fd, &v, 1);
 	if (ret < 0)
 		printf("Stopping watchdog ticks failed (%d)...\n", errno);
-- 
2.34.1

