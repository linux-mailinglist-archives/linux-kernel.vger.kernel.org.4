Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11E4608165
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiJUWSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJUWS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:18:26 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715A72AA17B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:18:24 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id i9so2386509ilv.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlh6byGTM8abd+hoZXnHkK8wpHen7Kg7enAq8H4CPPg=;
        b=fx3eYTlJhUHw9ssE2UFhZioTH5qkq8bbUlKoP3gCYFuyZ5CTJ6I30rvFDFt0xTwsls
         4FeyxKdYL6SCSn9DwNscDbkvWF5Cg3ZDfomKYrLavJn5sZk98NMu24LI2sAw/kdoHDHA
         Y5+TArRJuMGxlCjU1GzHehRi13O8t3D21O2iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlh6byGTM8abd+hoZXnHkK8wpHen7Kg7enAq8H4CPPg=;
        b=GZmcaF7neUKsdb/qEP3pj2Qver8Mh9MRNahpXVONbBGdSCU/chWLjH154ZC8448MDk
         wgTlNne5VwAfrYQbdot/zi0XMgjfI3y6JvFnFq6p8ue+B+9AHmEt7CmsM8G06D5ZA1iN
         Q1PzBdUl+WpwXqlWa1bIQGlFD6WMtxs33bjuz/FOoHJbM9lbYQ8DsFiNymh+BU0HAho8
         kuIxX0TSCsUyMh7NjW0Uf8cRdnra0kf0HTqTdFXMopb5LJ55MGWFq0exxu+n8YPCnV11
         PPurv7TCNlQx7vr4e4ZRd1A0KtkIj2TK5tHBc9LJb96CaArPmCpD0jB280iSI0kTtl4w
         ro8Q==
X-Gm-Message-State: ACrzQf2fsEsjy9BSituYjIX6yInwP/VQd2TYzeIrVu+ksR6dZBGaHNuH
        zQtBtZJNvdGeEoXQY6NdgPhtmQ==
X-Google-Smtp-Source: AMsMyM43+LSyXTj6Uagl4g1vhPUIUEEKVecmTeM5qHOJz02aFGaZpbaeQjHz7HkuHgxm+AAFG65WyA==
X-Received: by 2002:a05:6e02:1c0c:b0:2fa:bd75:55a5 with SMTP id l12-20020a056e021c0c00b002fabd7555a5mr15240001ilh.234.1666390703410;
        Fri, 21 Oct 2022 15:18:23 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cp6-20020a056638480600b0036cc14af7adsm430740jab.149.2022.10.21.15.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:18:22 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     skhan@linuxfoundation.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] selftests/watchdog: add support for WDIOC_GETSTATUS
Date:   Fri, 21 Oct 2022 16:18:17 -0600
Message-Id: <de434449f962c396f0dfd8c170461f894d62dd70.1666390362.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666390362.git.skhan@linuxfoundation.org>
References: <cover.1666390362.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for calling WDIOC_GETSTATUS and printing supported
features and status.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../selftests/watchdog/watchdog-test.c        | 44 +++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index 5db9ad8b543c..e6af6e327eb3 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -6,8 +6,6 @@
 * - Could be tested against softdog driver on systems that
 *   don't have watchdog hadrware.
 * - TODO:
-* - WDIOC_GETSTATUS is called when WDIOC_GETBOOTSTATUS is called.
-* - Enhance the logic to call WDIOC_GETSTATUS and test return values.
 * - Enhance coverage of ioctl return values - flags and status.
 * - Enhance test to add coverage for WDIOC_GETTEMP.
 *
@@ -30,13 +28,14 @@
 
 int fd;
 const char v = 'V';
-static const char sopts[] = "bdehp:t:Tn:NLf:i";
+static const char sopts[] = "bdehp:st:Tn:NLf:i";
 static const struct option lopts[] = {
 	{"bootstatus",          no_argument, NULL, 'b'},
 	{"disable",             no_argument, NULL, 'd'},
 	{"enable",              no_argument, NULL, 'e'},
 	{"help",                no_argument, NULL, 'h'},
 	{"pingrate",      required_argument, NULL, 'p'},
+	{"status",              no_argument, NULL, 's'},
 	{"timeout",       required_argument, NULL, 't'},
 	{"gettimeout",          no_argument, NULL, 'T'},
 	{"pretimeout",    required_argument, NULL, 'n'},
@@ -85,6 +84,7 @@ static void usage(char *progname)
 	printf(" -f, --file\t\tOpen watchdog device file\n");
 	printf("\t\t\tDefault is /dev/watchdog\n");
 	printf(" -i, --info\t\tShow watchdog_info\n");
+	printf(" -s, --status\t\tGet status & supported features\n");
 	printf(" -b, --bootstatus\tGet last boot status (Watchdog/POR)\n");
 	printf(" -d, --disable\t\tTurn off the watchdog timer\n");
 	printf(" -e, --enable\t\tTurn on the watchdog timer\n");
@@ -107,6 +107,35 @@ struct wdiof_status {
 	const char *status_str;
 };
 
+#define WDIOF_NUM_STATUS 8
+
+static const struct wdiof_status wdiof_status[WDIOF_NUM_STATUS] = {
+	{WDIOF_SETTIMEOUT,  "Set timeout (in seconds)"},
+	{WDIOF_MAGICCLOSE,  "Supports magic close char"},
+	{WDIOF_PRETIMEOUT,  "Pretimeout (in seconds), get/set"},
+	{WDIOF_ALARMONLY,  "Watchdog triggers a management or other external alarm not a reboot"},
+	{WDIOF_KEEPALIVEPING,  "Keep alive ping reply"},
+	{WDIOS_DISABLECARD,  "Turn off the watchdog timer"},
+	{WDIOS_ENABLECARD,  "Turn on the watchdog timer"},
+	{WDIOS_TEMPPANIC,  "Kernel panic on temperature trip"},
+};
+
+static void print_status(int flags)
+{
+	int wdiof = 0;
+
+	if (flags == WDIOS_UNKNOWN) {
+		printf("Unknown status error from WDIOC_GETSTATUS\n");
+		return;
+	}
+
+	for (wdiof = 0; wdiof < WDIOF_NUM_STATUS; wdiof++) {
+		if (flags & wdiof_status[wdiof].flag)
+			printf("Support/Status: %s\n",
+				wdiof_status[wdiof].status_str);
+	}
+}
+
 #define WDIOF_NUM_BOOTSTATUS 7
 
 static const struct wdiof_status wdiof_bootstatus[WDIOF_NUM_BOOTSTATUS] = {
@@ -219,6 +248,15 @@ int main(int argc, char *argv[])
 				ping_rate = DEFAULT_PING_RATE;
 			printf("Watchdog ping rate set to %u seconds.\n", ping_rate);
 			break;
+		case 's':
+			flags = 0;
+			oneshot = 1;
+			ret = ioctl(fd, WDIOC_GETSTATUS, &flags);
+			if (!ret)
+				print_status(flags);
+			else
+				printf("WDIOC_GETSTATUS error '%s'\n", strerror(errno));
+			break;
 		case 't':
 			flags = strtoul(optarg, NULL, 0);
 			ret = ioctl(fd, WDIOC_SETTIMEOUT, &flags);
-- 
2.34.1

