Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D99609C77
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiJXI1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiJXI0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:26:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926EEFAC0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666599949; x=1698135949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YJtA74YQm4A6lPUrh3QtcR1iB0PmZLMp2ejYydWO/IA=;
  b=TPxEq8mp05Wb68t27HgUmeOCQZNhx6N/jagSq59RlJlCDSeZq2LlhUpS
   jREuRvgNG8y+B/HojpGvdSfTcMF9+XiXO5JjW4pcp1me4CxPjGkuLOwyC
   KUYyFUo5bRsrI8p5I5ZSwMEiii2PWlGMmn3vfAe4FrgftULICtv1y7Fcw
   LwYLiPzjI634Ob2YRjZnfHtOFzuQrois70Oa/oJE+LBuUQVkkI6upMhnx
   xy749sNt/IWW7VgRWgloRLQA20WwIX/63KyzHtSHxepacFcdfp/mCGrFJ
   4a5/cEFke2ssANc88AqwjslPToVie6reB1ZvE2lHSt4xH4BOORVI/0fdr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="307356793"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="307356793"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 01:25:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="806237388"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="806237388"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 01:25:44 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id D8F4D2021B;
        Mon, 24 Oct 2022 11:25:41 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1omsmg-000JWJ-PX; Mon, 24 Oct 2022 11:26:10 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Date:   Mon, 24 Oct 2022 11:26:10 +0300
Message-Id: <20221024082610.74990-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

container_of() casts the original type to another which leads to the loss
of the const qualifier if it is not specified in the caller-provided type.
This easily leads to container_of() returning a non-const pointer to a
const struct which the C compiler does not warn about.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/container_of.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 2f4944b791b81..c7c21d0f41a87 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -13,6 +13,10 @@
  * @type:	the type of the container struct this is embedded in.
  * @member:	the name of the member within the struct.
  *
+ * WARNING: as container_of() casts the given struct to another, also the
+ * possible const qualifier of @ptr is lost unless it is also specified in
+ * @type. This is not a problem if the containing object is not const. Use with
+ * care.
  */
 #define container_of(ptr, type, member) ({				\
 	void *__mptr = (void *)(ptr);					\
@@ -27,6 +31,11 @@
  * @type:	the type of the container struct this is embedded in.
  * @member:	the name of the member within the struct.
  *
+ * WARNING: as container_of() casts the given struct to another, also the
+ * possible const qualifier of @ptr is lost unless it is also specified in
+ * @type. This is not a problem if the containing object is not const. Use with
+ * care.
+ *
  * If IS_ERR_OR_NULL(ptr), ptr is returned unchanged.
  */
 #define container_of_safe(ptr, type, member) ({				\
-- 
2.30.2

