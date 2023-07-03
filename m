Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EE97462CC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGCSwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjGCSw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:52:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1465E72;
        Mon,  3 Jul 2023 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688410347; x=1719946347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0qX8wJqCVwS6J5mYlzsfBNDUlm1C8MXGFzfdUeV0hJg=;
  b=KJLvrjEU7DE5rusmQtdVhwzMqMwbsTs0TK+ZnOwxBWGaxdu7AYqLbbll
   WkPjkomkC3IkuIgFaCCZmXAkCi1DXaR8ggJtnjuugOTSRl0JFDm76IaD5
   C/lBwftO2apDLJEI1EKegusuYF5+ws49hxqOlJhN/cXh2h7gc2DqYY/Ce
   T0Z1Yf/Y82lPvjDE21ZOC5e2fgXyMPlX9ndUc0l8uxuTVtyUPlxr73Cba
   15B/44Y780fK8wpz/Us2SXk/1tLJUClwXGXNyZIQ6gmQtgtenXztbxAjY
   86ypeVhdZkmbL/f15wJ6EimtVUzLUV9W/BBS4B5OsvNGR7WxnEN0+ai44
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="362986956"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="362986956"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:52:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="721860810"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="721860810"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2023 11:52:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2803013C; Mon,  3 Jul 2023 21:52:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 01/12] lib/string_choices: Add str_write_read() helper
Date:   Mon,  3 Jul 2023 21:52:11 +0300
Message-Id: <20230703185222.50554-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an inversed variant of str_read_write(), i.e. str_write_read().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string_choices.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 48120222b9b2..3c1091941eb8 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -30,6 +30,7 @@ static inline const char *str_read_write(bool v)
 {
 	return v ? "read" : "write";
 }
+#define str_write_read(v)		str_read_write(!(v))
 
 static inline const char *str_on_off(bool v)
 {
-- 
2.40.0.1.gaa8946217a0b

