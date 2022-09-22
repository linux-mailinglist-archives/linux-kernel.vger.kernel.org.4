Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CA65E61E9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiIVMCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiIVMCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:02:21 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566B4B774C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:02:19 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d82so9034144pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=C6tsbrRVYpziVZpZ64ENw678okAOPxpIMURgtxNPHU4=;
        b=OL/rBWhbb9z7Wr2dZ6wvklE5QwIsBFnHIYRF3Lwq4PGZDanCnZUOJiOJVP6EInZ6yy
         4oQQuqxjlqqFpNgNxPNCeOsU+6mGsBh0sh0eFMdDa0uzKLxILuKV6EZ8Xk+Pm3htDLbt
         Y+HDubgmei3HXDmCeWWfeurAnIUDuoWcsVe46p4JD2d5B3Pqi9ukGD++OCO/4AJb4dfG
         jGi5QZ/UmxN8Y8bpbblIhZ9pttUgs/aH//zy5HGCFfy4XeqSEHR0L82dNGzLsM8F8+k2
         7GYARfMweL8eUEtEiUWJiczaeK0BfuaxfZSRuMtnGycj5nGw+0Nity76d3oalYRLmlY8
         EGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=C6tsbrRVYpziVZpZ64ENw678okAOPxpIMURgtxNPHU4=;
        b=hPtpat3AEzmSRfQc3ZeiFWqilyWcnycOGBIsiY/hX3YiVEg0UJYHMdTlEQmv7RvYui
         iMlXNn8I3G4nzpkXPrkJemJMuN/qLJzufFJ17xYlFWE6egvFv66h/25ib4L1fDXj6fHR
         0QbpVfCYGjxV/vYfif+H5P7YIhnaplNqkoWwKpS985Qc5Smtqx3adp6qiga1Wd8DbDD3
         YtH3/jIPCFl9BZvt+krLHcgwN6JKUuCpo9aCtlDyjbgKDoAMdp2LJsOQKgZSL0ef4sUC
         AdGvGKl+MT2kaem3Su6U4A5EdoMmA/UsZRx+MdjRCj6x9Y4axl+/4L7ktgllE9B3jegw
         r3rA==
X-Gm-Message-State: ACrzQf0aPiN+smKW5nwrBA4n5bN++v0CT+FlhH6w6TIB/js6jXljFfR2
        ED81tEEfSxSFtfzgHA+zi0UZncPuONM=
X-Google-Smtp-Source: AMsMyM6qM8wqPpNqekpiz2+mEBHcYzqAdi7bw4mr6gGBNSpJP4ZhrV2dQSQ1RlmNSCTq1DtXnR6YgQ==
X-Received: by 2002:a63:87c8:0:b0:43a:c2e4:efcc with SMTP id i191-20020a6387c8000000b0043ac2e4efccmr2786759pge.410.1663848138535;
        Thu, 22 Sep 2022 05:02:18 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z4-20020a1709027e8400b00176c6738d13sm3912064pla.169.2022.09.22.05.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 05:02:18 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] scripts/get_dvb_firmware: use absolute path when using system()
Date:   Thu, 22 Sep 2022 11:47:17 +0000
Message-Id: <20220922114715.237279-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

Not using absolute path when using system() which can lead to serious
security issues.
---
FYI:
We have to abide by strict rules. When we send out emails, it
will be forwarded by the unified mailbox. When we want to send emails in
personal name to anyone outside the company, we must apply for it, which
is far more difficult than modifying patches. I'm really sorry I can't
reply to you guys.
I used ./scripts/get_maintainer.pl scripts/get_dvb_firmware and only got
linux-kernel@vger.kernel.org (open list), so I didn't add -cc.
Can cause serious problems when using system(), maybe there's a better
way than using absolute paths, but there's no reason for a serious bug
to stay in the kernel.
Please give me some inspiration, thanks a lot.
---
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 scripts/get_dvb_firmware | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/get_dvb_firmware b/scripts/get_dvb_firmware
index 1a90802410bc..4ca5aef4203b 100755
--- a/scripts/get_dvb_firmware
+++ b/scripts/get_dvb_firmware
@@ -807,19 +807,19 @@ sub si2165 {
 # Utilities
 
 sub checkstandard {
-    if (system("which unzip > /dev/null 2>&1")) {
+    if (system("/usr/bin/which unzip > /dev/null 2>&1")) {
 	die "This firmware requires the unzip command - see ftp://ftp.info-zip.org/pub/infozip/UnZip.html\n";
     }
-    if (system("which md5sum > /dev/null 2>&1")) {
+    if (system("/usr/bin/which md5sum > /dev/null 2>&1")) {
 	die "This firmware requires the md5sum command - see http://www.gnu.org/software/coreutils/\n";
     }
-    if (system("which wget > /dev/null 2>&1")) {
+    if (system("/usr/bin/which wget > /dev/null 2>&1")) {
 	die "This firmware requires the wget command - see http://wget.sunsite.dk/\n";
     }
 }
 
 sub checkunshield {
-    if (system("which unshield > /dev/null 2>&1")) {
+    if (system("/usr/bin/which unshield > /dev/null 2>&1")) {
 	die "This firmware requires the unshield command - see http://sourceforge.net/projects/synce/\n";
     }
 }
@@ -828,14 +828,14 @@ sub wgetfile {
     my ($sourcefile, $url) = @_;
 
     if (! -f $sourcefile) {
-	system("wget -O \"$sourcefile\" \"$url\"") and die "wget failed - unable to download firmware";
+	system("/usr/bin/wget -O \"$sourcefile\" \"$url\"") and die "wget failed - unable to download firmware";
     }
 }
 
 sub unzip {
     my ($sourcefile, $todir) = @_;
 
-    $status = system("unzip -q -o -d \"$todir\" \"$sourcefile\" 2>/dev/null" );
+    $status = system("/usr/bin/unzip -q -o -d \"$todir\" \"$sourcefile\" 2>/dev/null" );
     if ((($status >> 8) > 2) || (($status & 0xff) != 0)) {
 	die ("unzip failed - unable to extract firmware");
     }
@@ -862,7 +862,7 @@ sub verify {
 sub copy {
     my ($from, $to) = @_;
 
-    system("cp -f \"$from\" \"$to\"") and die ("cp failed");
+    system("/usr/bin/cp -f \"$from\" \"$to\"") and die ("cp failed");
 }
 
 sub extract {
-- 
2.15.2     
