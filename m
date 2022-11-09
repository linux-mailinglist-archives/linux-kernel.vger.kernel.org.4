Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8717622F76
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiKIP4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiKIP4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:56:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E226118E09
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668009359; x=1699545359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eKtwWKYMTJ/eexktXqAdzMQnTSitnr28Dw+XVlTyufw=;
  b=klldGz6wR8V1oJX2wlVjtXQbNxQlskqL6h13fAa1iB1rME/bO2Mqsapu
   fH63m+08ImerqRGMII84xTfzGQ1Ro8h2irFkrsS5EngjmxQ793uspcIRW
   6MUSuknFtXBYIevb+NwFSQKQp/yAz/H9Mg861z4KTDE/eyufX6wKhcc/a
   6z1Ew9aCv8erqh7Aonaao880eE/64faT1hSer79XVEMuRoMy8SZyqcsbv
   0bFc25hAIFhxzcTZeqDNIwryfDaVhBNdrKV6B9d+hDne180F/A4QNWlI8
   06FiNh9oJN9rrYgx4cK7VaNA+xSDqT0y7fK6z2l37hNd5FOhrTunG/jDa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="397308201"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="397308201"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:55:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="631293196"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="631293196"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 09 Nov 2022 07:55:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A974015C; Wed,  9 Nov 2022 17:56:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/2] resource: Convert DEFINE_RES_NAMED() to be compound literal
Date:   Wed,  9 Nov 2022 17:56:18 +0200
Message-Id: <20221109155618.42276-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221109155618.42276-1-andriy.shevchenko@linux.intel.com>
References: <20221109155618.42276-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently DEFINE_RES_NAMED() can only be used to fill the static data.
In some cases it would be convenient to use it as right value in the
assignment operation. But it can't be done as is, because compiler has
no clue about the data layout. Converting it to be a compound literal
allows the above mentioned usage.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
---
v2: added tag (Rafael), Cc'ed to Greg (Rafael)

 include/linux/ioport.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 27642ca15d93..67d3fb2133b6 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -155,7 +155,7 @@ enum {
 
 /* helpers to define resources */
 #define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
-	{								\
+(struct resource) {							\
 		.start = (_start),					\
 		.end = (_start) + (_size) - 1,				\
 		.name = (_name),					\
-- 
2.35.1

