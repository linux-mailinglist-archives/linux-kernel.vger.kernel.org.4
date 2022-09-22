Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA995E6D40
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiIVUmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiIVUmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:42:04 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99B02BE08;
        Thu, 22 Sep 2022 13:42:03 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 10DB9383;
        Thu, 22 Sep 2022 20:42:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 10DB9383
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663879323; bh=O2wLRUp8cjLqcHTIqydpm4tGkQwiA1in+6jJri0y4nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ad8lnygXLt0vmhNy/dCz41MGdUXuI/ASP146Pgk1SPcmUs3jWljzdzpNX0NsaDDpF
         w1g/Bxio6NG18RxTQva+byutgqYZ5Qhv/R50YwEDI/Z6hw1wUkEcD4qiIwmIlUUotK
         99jNwFWxEPZz+hj+5hygo+MbdKQ42A/PZCk3FASOEGGORT7Fl9ObKcTAwfkyWn3zay
         ZNHDMe7CwQwUmfq1zqBnXzzBZQUJPW89iIhg/I/MkErY95AZJ5mS5RRAOed8bm70vO
         lBkedq0U+rj/6nNRY8cXbzvfZCo5aB4RAg1//e4hmp092mBTPirOtYRDlHlE1cMPZm
         mw3MOmjKVQL7w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 7/7] docs: put atomic*.txt and memory-barriers.txt into the core-api book
Date:   Thu, 22 Sep 2022 14:41:38 -0600
Message-Id: <20220922204138.153146-8-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220922204138.153146-1-corbet@lwn.net>
References: <20220922204138.153146-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These files describe part of the core API, but have never been converted to
RST due to ... let's say local oppposition.  So, create a set of
special-purpose wrappers to ..include these files into a separate page so
that they can be a part of the htmldocs build.  Then link them into the
core-api manual and remove them from the "staging" dumping ground.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/core-api/index.rst              |  3 ++
 .../core-api/wrappers/atomic_bitops.rst       | 18 ++++++++
 Documentation/core-api/wrappers/atomic_t.rst  | 19 +++++++++
 .../core-api/wrappers/memory-barriers.rst     | 18 ++++++++
 Documentation/staging/index.rst               | 42 -------------------
 5 files changed, 58 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/core-api/wrappers/atomic_bitops.rst
 create mode 100644 Documentation/core-api/wrappers/atomic_t.rst
 create mode 100644 Documentation/core-api/wrappers/memory-barriers.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index f5d8e3779fe8..b0e7b4771fff 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -45,6 +45,8 @@ Library functionality that is used throughout the kernel.
    this_cpu_ops
    timekeeping
    errseq
+   wrappers/atomic_t
+   wrappers/atomic_bitops
 
 Low level entry and exit
 ========================
@@ -68,6 +70,7 @@ Documentation/locking/index.rst for more related documentation.
    local_ops
    padata
    ../RCU/index
+   wrappers/memory-barriers.rst
 
 Low-level hardware management
 =============================
diff --git a/Documentation/core-api/wrappers/atomic_bitops.rst b/Documentation/core-api/wrappers/atomic_bitops.rst
new file mode 100644
index 000000000000..bf24e4081a8f
--- /dev/null
+++ b/Documentation/core-api/wrappers/atomic_bitops.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: GPL-2.0
+   This is a simple wrapper to bring atomic_bitops.txt into the RST world
+   until such a time as that file can be converted directly.
+
+=============
+Atomic bitops
+=============
+
+.. raw:: latex
+
+    \footnotesize
+
+.. include:: ../../atomic_bitops.txt
+   :literal:
+
+.. raw:: latex
+
+    \normalsize
diff --git a/Documentation/core-api/wrappers/atomic_t.rst b/Documentation/core-api/wrappers/atomic_t.rst
new file mode 100644
index 000000000000..ed109a964c77
--- /dev/null
+++ b/Documentation/core-api/wrappers/atomic_t.rst
@@ -0,0 +1,19 @@
+.. SPDX-License-Identifier: GPL-2.0
+   This is a simple wrapper to bring atomic_t.txt into the RST world
+   until such a time as that file can be converted directly.
+
+============
+Atomic types
+============
+
+.. raw:: latex
+
+    \footnotesize
+
+.. include:: ../../atomic_t.txt
+   :literal:
+
+.. raw:: latex
+
+    \normalsize
+
diff --git a/Documentation/core-api/wrappers/memory-barriers.rst b/Documentation/core-api/wrappers/memory-barriers.rst
new file mode 100644
index 000000000000..532460b5e3eb
--- /dev/null
+++ b/Documentation/core-api/wrappers/memory-barriers.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: GPL-2.0
+   This is a simple wrapper to bring memory-barriers.txt into the RST world
+   until such a time as that file can be converted directly.
+
+============================
+Linux kernel memory barriers
+============================
+
+.. raw:: latex
+
+    \footnotesize
+
+.. include:: ../../memory-barriers.txt
+   :literal:
+
+.. raw:: latex
+
+    \normalsize
diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
index abd0d18254d2..ded8254bc0d7 100644
--- a/Documentation/staging/index.rst
+++ b/Documentation/staging/index.rst
@@ -14,45 +14,3 @@ Unsorted Documentation
    static-keys
    tee
    xz
-
-Atomic Types
-============
-
-.. raw:: latex
-
-    \footnotesize
-
-.. include:: ../atomic_t.txt
-   :literal:
-
-.. raw:: latex
-
-    \normalsize
-
-Atomic bitops
-=============
-
-.. raw:: latex
-
-    \footnotesize
-
-.. include:: ../atomic_bitops.txt
-   :literal:
-
-.. raw:: latex
-
-    \normalsize
-
-Memory Barriers
-===============
-
-.. raw:: latex
-
-    \footnotesize
-
-.. include:: ../memory-barriers.txt
-   :literal:
-
-.. raw:: latex
-
-    \normalsize
-- 
2.37.2

