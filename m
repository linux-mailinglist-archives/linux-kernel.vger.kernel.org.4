Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A2A6296B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiKOLDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbiKOLCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:02:22 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56EFB5C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:02:12 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4BB276001A;
        Tue, 15 Nov 2022 11:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668510131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vmdLqqdX83NrVxFfCs3G+u/+UCwYeudzJBMjz9k4QTU=;
        b=nX4wxGfs+5xQ+rXbSCCo8OZlM7CyBO8xL4MEtGtnnnP4Qk8wly2COTihpqMx6xxNvQRbCZ
        ddzF5FjxcZzBxMYNIrAp587hJfLgDKdlkbT59+jOmlecTkp2CBW6M7Hp3Z2pqWqXyQvn5B
        FBymAvSlplEI2NacPEasYHfzCSnQMDNZrqe6fmNVl8AVhj3TkDVGAhi/HLsdPZfzUTxxfN
        9lDY0/7yxn4GuPTYXqG10RC8mwMJBitkgtdWlzUsPAfMlMxRrpwVxNP8NKeNJhP0p9XOXu
        LjYUkhLy1zYI/0nT2VFpagt7SiVRq5OSI/G5sI5+V4X7UfiXiix/cAo7uIqEwQ==
From:   alexandre.belloni@bootlin.com
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] init/Kconfig: fix CC_HAS_ASM_GOTO_TIED_OUTPUT test with dash
Date:   Tue, 15 Nov 2022 12:01:58 +0100
Message-Id: <20221115110158.2207117-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

When using dash as /bin/sh, the CC_HAS_ASM_GOTO_TIED_OUTPUT test fails
with a syntax error which is not the one we are looking for:

<stdin>: In function ‘foo’:
<stdin>:1:29: warning: missing terminating " character
<stdin>:1:29: error: missing terminating " character
<stdin>:2:5: error: expected ‘:’ before ‘+’ token
<stdin>:2:7: warning: missing terminating " character
<stdin>:2:7: error: missing terminating " character
<stdin>:2:5: error: expected declaration or statement at end of input

Removing '\n' solves this.

Fixes: 1aa0e8b144b6 ("Kconfig: Add option for asm goto w/ tied outputs to workaround clang-13 bug")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 694f7c160c9c..13e93bcbc807 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -87,7 +87,7 @@ config CC_HAS_ASM_GOTO_OUTPUT
 config CC_HAS_ASM_GOTO_TIED_OUTPUT
 	depends on CC_HAS_ASM_GOTO_OUTPUT
 	# Detect buggy gcc and clang, fixed in gcc-11 clang-14.
-	def_bool $(success,echo 'int foo(int *x) { asm goto (".long (%l[bar]) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }' | $CC -x c - -c -o /dev/null)
+	def_bool $(success,echo 'int foo(int *x) { asm goto (".long (%l[bar]) - .": "+m"(*x) ::: bar); return *x; bar: return 0; }' | $CC -x c - -c -o /dev/null)
 
 config TOOLS_SUPPORT_RELR
 	def_bool $(success,env "CC=$(CC)" "LD=$(LD)" "NM=$(NM)" "OBJCOPY=$(OBJCOPY)" $(srctree)/scripts/tools-support-relr.sh)
-- 
2.38.1

