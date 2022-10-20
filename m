Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6038B606654
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJTQzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJTQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:55:21 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05C9ACF5F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:55:18 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 7085 invoked from network); 20 Oct 2022 18:55:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1666284915; bh=n4gJTD8b3MoWMElJc5sUpbaAckINJ1gq7JN80v6Jqh0=;
          h=From:To:Cc:Subject;
          b=B1j2O5fHYEyN2RFJI8psqljWcXq3jwjq1Zgpj4U+RZifDLoX1ee5xmFSoZqllK4a8
           raG2uH572CB0yko0dt0sj/y3zZBj7sL4Ma2aDeBN0zOC6KzKW2+rAMIe9yZYOvOyXQ
           jWTXDcf3TZFIJoboRwlcjHd6Iyy4iDfqK8so/ehw=
Received: from 89-64-7-202.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.202])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <joe@perches.com>; 20 Oct 2022 18:55:14 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC] scripts: checkpatch: allow case x: return #x macros
Date:   Thu, 20 Oct 2022 18:55:14 +0200
Message-Id: <20221020165514.103211-1-stf_xl@wp.pl>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 3e94f896817b2284c9f72481a3a8b359
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [QXNE]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not report errors like below:

./scripts/checkpatch.pl -f drivers/net/wireless/ath/ath10k/wmi.h

ERROR: Macros with complex values should be enclosed in parentheses
+#define C2S(x) case x: return #x

since "case x: return #x" macros are already used by some
in-kernel drivers.

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1e5e66ae5a52..4b888b1313d5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5901,6 +5901,7 @@ sub process {
 			    $dstat !~ /$exceptions/ &&
 			    $dstat !~ /^\.$Ident\s*=/ &&				# .foo =
 			    $dstat !~ /^(?:\#\s*$Ident|\#\s*$Constant)\s*$/ &&		# stringification #foo
+			    $dstat !~ /^case\s*$Ident:\s*return\s*#$Ident$/ &&		# case x: return #x
 			    $dstat !~ /^do\s*$Constant\s*while\s*$Constant;?$/ &&	# do {...} while (...); // do {...} while (...)
 			    $dstat !~ /^while\s*$Constant\s*$Constant\s*$/ &&		# while (...) {...}
 			    $dstat !~ /^for\s*$Constant$/ &&				# for (...)
-- 
2.25.4

