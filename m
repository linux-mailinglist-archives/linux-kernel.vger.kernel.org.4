Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1E560F5B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiJ0Kts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiJ0Ktp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:49:45 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5918117A92
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:49:40 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 757 invoked from network); 27 Oct 2022 12:49:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1666867775; bh=n4gJTD8b3MoWMElJc5sUpbaAckINJ1gq7JN80v6Jqh0=;
          h=From:To:Cc:Subject;
          b=eEHVHg1dRZlZJwtUfXpxsTbYUxVmKVBsOxVK3ETsONMqdtRVZDrGSGRjj9KO5YUt5
           OUn43gwy01IgRIjgRrt8ElltuHboKqZ/lI31tYgARgmzznCmuqqLPFrJu6a3qYM7JL
           fCSxXLqKLsbmQ8w9t5B/CarQBEclF7KFLnoByhbA=
Received: from 89-64-7-202.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.202])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <akpm@linux-foundation.org>; 27 Oct 2022 12:49:34 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: checkpatch: allow case x: return #x macros
Date:   Thu, 27 Oct 2022 12:49:34 +0200
Message-Id: <20221027104934.160513-1-stf_xl@wp.pl>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 0d1ea40ff672987e9a9430f29094d703
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [kXN0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

