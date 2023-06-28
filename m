Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BD574152E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjF1Pcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:19758 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232237AbjF1Pc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687966349; x=1719502349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rkrFpsjN1kkwBUnx7S3/fsHajYxtZIFrVprJT5SR/KE=;
  b=myF5HRdh4ExUsTpMp5jYDvV073JU4tiPyetpvTnSXHKGX7LzGnw2i8hK
   NG+kpMfNUWkzo4xTe/MzYFiaCRp5lIrMcpyE4ZGEa2Yqnz4NyZaAHgFak
   NdnDBp3NzsqDubH4EFMl107e/Hie18dZTyWek/Tb11wEKP589SYq99oqc
   TQgieB2fjJuEXpL7Uyz8MIQNlsK4Wn9bABnQ+9S6yn8xXcJ0H3Yqya+Ii
   xdr3isOj7hkq3R7lq8konJu3VXHWe+vVPDHvubyc/k5iFaGnMn45LMdGo
   SjKx6waTNgYMnS4uTAuBF/4bbxxV1PFakpiYhgLkXl9CWIl+1Tuj5SWgF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="364427011"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="364427011"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 08:32:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="782344682"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="782344682"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2023 08:32:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8D4EE93; Wed, 28 Jun 2023 18:32:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tero Kristo <kristo@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/4] lib/string_helpers: Add kstrdup_and_replace() helper
Date:   Wed, 28 Jun 2023 18:32:08 +0300
Message-Id: <20230628153211.52988-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230628153211.52988-1-andriy.shevchenko@linux.intel.com>
References: <20230628153211.52988-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicate a NULL-terminated string and replace all occurrences of
the old character with a new one. In other words, provide functionality
of kstrdup() + strreplace().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string_helpers.h |  2 ++
 lib/string_helpers.c           | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 789ab30045da..9d1f5bb74dd5 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -109,6 +109,8 @@ char *kstrdup_quotable(const char *src, gfp_t gfp);
 char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp);
 char *kstrdup_quotable_file(struct file *file, gfp_t gfp);
 
+char *kstrdup_and_replace(const char *src, char old, char new, gfp_t gfp);
+
 char **kasprintf_strarray(gfp_t gfp, const char *prefix, size_t n);
 void kfree_strarray(char **array, size_t n);
 
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index d3b1dd718daf..9982344cca34 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -719,6 +719,21 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(kstrdup_quotable_file);
 
+/*
+ * Returns duplicate string in which the @old characters are replaced by @new.
+ */
+char *kstrdup_and_replace(const char *src, char old, char new, gfp_t gfp)
+{
+	char *dst;
+
+	dst = kstrdup(src, gfp);
+	if (!dst)
+		return NULL;
+
+	return strreplace(dst, old, new);
+}
+EXPORT_SYMBOL_GPL(kstrdup_and_replace);
+
 /**
  * kasprintf_strarray - allocate and fill array of sequential strings
  * @gfp: flags for the slab allocator
-- 
2.40.0.1.gaa8946217a0b

