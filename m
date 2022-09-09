Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA82D5B35F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiIILAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiIIK7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:59:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752C72B252
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662721188; x=1694257188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sw25/VEVNzYbUpj2DtWImbIBzsU8rdEcHgaL9vecVhE=;
  b=ct8QHmetWfR8WzJaq7kqPk/4t+uAhLFr1UkjyVveHgMAD5JVIgA+SShy
   LW/hQ2LrR7q8STv7zxfJq+yCqOGsBaxriw1xY+O2OQ5vc1Tew7RX9cNsL
   kmf0GMXA0+PIfjPZOhdO1H1zHtpiRcql2mnx1QkogYkt7z5UDLXf2MkKx
   3Q5JAJ47r4S1yDZtHUvP4xq/Txvmq1tD84OlZb+GkgP9hhWmyCHc765oN
   dBdBLzDU8grxiYXXLbbOFytD6KnOVSs+ISsMqAoTUbGqE2WypQL0/lpQM
   MUy6xLWaxo2wrLBRl7JHtW9pkKoU1sQ6WYFceXoftNNvzQEg44lsZTU69
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="297449535"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="297449535"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 03:59:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="704370341"
Received: from clbarnes-mobl.amr.corp.intel.com (HELO paris.amr.corp.intel.com) ([10.254.42.92])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 03:59:44 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@redhat.com,
        daniel@ffwll.ch, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, keescook@chromium.org,
        mauro.chehab@linux.intel.com, linux@rasmusvillemoes.dk,
        vitor@massaru.org, dlatypov@google.com, ndesaulniers@google.com
Subject: [PATCH v10 3/9] compiler_types.h: Add assert_type to catch type mis-match while compiling
Date:   Fri,  9 Sep 2022 19:59:07 +0900
Message-Id: <20220909105913.752049-4-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220909105913.752049-1-gwan-gyeong.mun@intel.com>
References: <20220909105913.752049-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds assert_type and assert_typable macros to catch type mis-match while
compiling. The existing typecheck() macro outputs build warnings, but the
newly added assert_type() macro uses the _Static_assert() keyword (which is
introduced in C11) to generate a build break when the types are different
and can be used to detect explicit build errors.
Unlike the assert_type() macro, assert_typable() macro allows a constant
value as the second argument.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler_types.h | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 4f2a819fd60a..19cc125918bb 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -294,6 +294,45 @@ struct ftrace_likely_data {
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 
+/**
+ * assert_type - break compile if the first argument's data type and the second
+ *               argument's data type are not the same
+ *
+ * @t1: data type or variable
+ * @t2: data type or variable
+ *
+ * The first and second arguments can be data types or variables or mixed (the
+ * first argument is the data type and the second argument is variable or vice
+ * versa). It determines whether the first argument's data type and the second
+ * argument's data type are the same while compiling, and it breaks compile if
+ * the two types are not the same.
+ * See also assert_typable().
+ */
+#define assert_type(t1, t2) _Static_assert(__same_type(t1, t2))
+
+/**
+ * assert_typable - break compile if the first argument's data type and the
+ *                  second argument's data type are not the same
+ *
+ * @t: data type or variable
+ * @n: data type or variable or constant value
+ *
+ * The first and second arguments can be data types or variables or mixed (the
+ * first argument is the data type and the second argument is variable or vice
+ * versa). Unlike the assert_type() macro, this macro allows a constant value
+ * as the second argument. And if the second argument is a constant value, it
+ * always passes. And it doesn't mean that the types are explicitly the same.
+ * When a constant value is used as the second argument, if you need an
+ * overflow check when assigning a constant value to a variable of the type of
+ * the first argument, you can use the overflows_type() macro. When a constant
+ * value is not used as a second argument, it determines whether the first
+ * argument's data type and the second argument's data type are the same while
+ * compiling, and it breaks compile if the two types are not the same.
+ * See also assert_type() and overflows_type().
+ */
+#define assert_typable(t, n) _Static_assert(__builtin_constant_p(n) ||	\
+					    __same_type(t, typeof(n)))
+
 /*
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
-- 
2.37.1

