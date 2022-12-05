Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1100A643769
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiLEVw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiLEVw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:52:26 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D5314089
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:51:12 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n197-20020a25d6ce000000b00702558fba96so2210821ybg.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 13:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHaN/rxrdTlLNmHkIlcPiYJ+TDwo4KCFt7QuQtzqTRE=;
        b=ezbkPVk+gANDmDB3slX0LIDT+GXoGI4xG2jnCJZjxEIny0W/0FWw78vciEzyI7Ukj7
         RgSvvofXwpCVf2yARjRAT0576DboGtRN++XwON3MSO3eJyh2UCMFvEa++LYG7ErrzqO2
         C7f/wQsM5J3hXxmTTmc6B59reRG4wQqsC5bIuhPjgSs8h6zUZLTGtGQbZ/Xj/CmMm9Zh
         MYlG6+TnpqZknQxmbPLInZ/T1iDqcgFbIDGSl24zuHvhlIaw+D5OIy3lavnzA2+9ydFE
         QnJSImLeC199vLikRq0kVXpiNB+yoZuPobJ7kvcXcuBSIpZ1UnuoOZdNoIYf3Eg+ZSDa
         mdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHaN/rxrdTlLNmHkIlcPiYJ+TDwo4KCFt7QuQtzqTRE=;
        b=jEuGu6WcTRf1tWDiFDtddRcln1nH7R2ScPRJgT9meTUsfVzMOn0l8WwF8zd91YcNHx
         D7kj+pZvtNVMytp0Lkf8OxoegiBCDQrA9Bp2g+EX6ACugZvBT+yaU94rhCKf1CvlKyQR
         Y2ADp6KzE2zsZRyELf2aJahKPzlzL94tlTM0un/aczIMoXptsYjjUJPwgPPiQBZoioEA
         yE/2JYSzU/ZZLS7PXuN4GP/u/G2EJXirZQ8muB899CZ8l/wcDUn0+H5XfbnSW9tmpeTt
         FzzlSi0OaBrp9dW6u4dgHcKktjXlzEVcpWKX9FTbmaazkqKre7wM74BpRcI5orsbWj1G
         t/sA==
X-Gm-Message-State: ANoB5pkvyv7EFdQnpt3fmpYcDfE/l8yPKy1AXhtQVA2OFICqNMeRgL2w
        hjyEfUNCtKbrIXjsAxwm7x7BuH3+zg==
X-Google-Smtp-Source: AA0mqf6lvqWkEuvZgqLHmk5rJjpI3nI+CfBPBXL+rv479JHG6NqzXP82xrmhXOZP4uwHFTAxRMlOZaGtmQ==
X-Received: from rmoar.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:4259])
 (user=rmoar job=sendgmr) by 2002:a81:598b:0:b0:3b7:78c8:a205 with SMTP id
 n133-20020a81598b000000b003b778c8a205mr49937654ywb.188.1670277071514; Mon, 05
 Dec 2022 13:51:11 -0800 (PST)
Date:   Mon,  5 Dec 2022 21:50:57 +0000
In-Reply-To: <20221205215058.143688-1-rmoar@google.com>
Mime-Version: 1.0
References: <20221205215058.143688-1-rmoar@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221205215058.143688-2-rmoar@google.com>
Subject: [PATCH v2 1/2] kunit: add macro to allow conditionally exposing
 static symbols to tests
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, john.johansen@canonical.com
Cc:     skhan@linuxfoundation.org, tales.aparecida@gmail.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, apparmor@lists.ubuntu.com,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create two macros:

VISIBLE_IF_KUNIT - A macro that sets symbols to be static if CONFIG_KUNIT
is not enabled. Otherwise if CONFIG_KUNIT is enabled there is no change to
the symbol definition.

EXPORT_SYMBOL_IF_KUNIT(symbol) - Exports symbol into
EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is enabled. Must
use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING) in test file in order to
use symbols.

Signed-off-by: Rae Moar <rmoar@google.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: David Gow <davidgow@google.com>
---

Changes since v1:
 - Separated the documentation comments for macros.
 - Changed copyright date and author for new header file.

 include/kunit/visibility.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 include/kunit/visibility.h

diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
new file mode 100644
index 000000000000..0dfe35feeec6
--- /dev/null
+++ b/include/kunit/visibility.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit API to allow symbols to be conditionally visible during KUnit
+ * testing
+ *
+ * Copyright (C) 2022, Google LLC.
+ * Author: Rae Moar <rmoar@google.com>
+ */
+
+#ifndef _KUNIT_VISIBILITY_H
+#define _KUNIT_VISIBILITY_H
+
+#if IS_ENABLED(CONFIG_KUNIT)
+    /**
+     * VISIBLE_IF_KUNIT - A macro that sets symbols to be static if
+     * CONFIG_KUNIT is not enabled. Otherwise if CONFIG_KUNIT is enabled
+     * there is no change to the symbol definition.
+     */
+    #define VISIBLE_IF_KUNIT
+    /**
+     * EXPORT_SYMBOL_IF_KUNIT(symbol) - Exports symbol into
+     * EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is
+     * enabled. Must use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING)
+     * in test file in order to use symbols.
+     */
+    #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
+	    EXPORTED_FOR_KUNIT_TESTING)
+#else
+    #define VISIBLE_IF_KUNIT static
+    #define EXPORT_SYMBOL_IF_KUNIT(symbol)
+#endif
+
+#endif /* _KUNIT_VISIBILITY_H */
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

