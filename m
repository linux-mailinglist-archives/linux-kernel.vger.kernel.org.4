Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2D25EC917
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiI0QII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiI0QHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:07:32 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0BAB14F1;
        Tue, 27 Sep 2022 09:06:16 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 366BC7F8;
        Tue, 27 Sep 2022 16:06:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 366BC7F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664294776; bh=Fwtxq3iIjYwQxaI52YLezdXTv1SluuHrldzBLIG1uo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LKVkY7nu+tM4Evl53NUeinYcIixA+N9Y4ehwB3Gke60aYLEnCwnegEzP3Ud0CQB6r
         06mNGBy7cwNFjj2MzXw8vNhBxVS2tksO0AmetzIrwpTpsSRNitewpclFNOwwpwGDq4
         XTqogzFXIlZBw4Rfw0F3Z+h+vGXBQ1Ni3+cEO3PSd6jWq5nI8dOMMxge97DqUTXpf/
         JI2H92amiMEXpx/MpcmZa3+6o33t7UzMBdWG/Z1G/nKAeY991P+LyB6DhdLDlp0GgE
         yPRDmL++xkhbj3GY257wtiZg09xsk/XaTN5+JqJOTbBYo2KZqKLH9L/B5aK6fKjDV6
         cZrsCzxy23Wpw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        David Vernet <void@manifault.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v3 5/7] docs: move asm-annotations.rst into core-api
Date:   Tue, 27 Sep 2022 10:05:57 -0600
Message-Id: <20220927160559.97154-6-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220927160559.97154-1-corbet@lwn.net>
References: <20220927160559.97154-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one file should not really be in the top-level documentation
directory.  core-api/ may not be a perfect fit but seems to be best, so
move it there.  Adjust a couple of internal document references to make
them location-independent, and point checkpatch.pl at the new location.

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Joe Perches <joe@perches.com>
Reviewed-by: David Vernet <void@manifault.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/{ => core-api}/asm-annotations.rst | 7 ++++---
 Documentation/core-api/index.rst                 | 1 +
 Documentation/index.rst                          | 8 --------
 scripts/checkpatch.pl                            | 2 +-
 4 files changed, 6 insertions(+), 12 deletions(-)
 rename Documentation/{ => core-api}/asm-annotations.rst (97%)

diff --git a/Documentation/asm-annotations.rst b/Documentation/core-api/asm-annotations.rst
similarity index 97%
rename from Documentation/asm-annotations.rst
rename to Documentation/core-api/asm-annotations.rst
index a64f2ca469d4..bc514ed59887 100644
--- a/Documentation/asm-annotations.rst
+++ b/Documentation/core-api/asm-annotations.rst
@@ -43,10 +43,11 @@ annotated objects like this, tools can be run on them to generate more useful
 information. In particular, on properly annotated objects, ``objtool`` can be
 run to check and fix the object if needed. Currently, ``objtool`` can report
 missing frame pointer setup/destruction in functions. It can also
-automatically generate annotations for :doc:`ORC unwinder <x86/orc-unwinder>`
+automatically generate annotations for the ORC unwinder
+(Documentation/x86/orc-unwinder.rst)
 for most code. Both of these are especially important to support reliable
-stack traces which are in turn necessary for :doc:`Kernel live patching
-<livepatch/livepatch>`.
+stack traces which are in turn necessary for kernel live patching
+(Documentation/livepatch/livepatch.rst).
 
 Caveat and Discussion
 ---------------------
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index dc95df462eea..f5d8e3779fe8 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -23,6 +23,7 @@ it.
    printk-formats
    printk-index
    symbol-namespaces
+   asm-annotations
 
 Data structures and low-level utilities
 =======================================
diff --git a/Documentation/index.rst b/Documentation/index.rst
index da80c584133c..5a700548ae82 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -89,14 +89,6 @@ platform firmwares.
    devicetree/index
 
 
-Architecture-agnostic documentation
------------------------------------
-
-.. toctree::
-   :maxdepth: 1
-
-   asm-annotations
-
 Architecture-specific documentation
 -----------------------------------
 
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543..812af52f97d2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3751,7 +3751,7 @@ sub process {
 		if ($realfile =~ /\.S$/ &&
 		    $line =~ /^\+\s*(?:[A-Z]+_)?SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) {
 			WARN("AVOID_L_PREFIX",
-			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/asm-annotations.rst\n" . $herecurr);
+			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/core-api/asm-annotations.rst\n" . $herecurr);
 		}
 
 # check we are in a valid source file C or perl if not then ignore this hunk
-- 
2.37.2

