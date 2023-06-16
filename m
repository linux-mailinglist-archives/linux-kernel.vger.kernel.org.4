Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16747333D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345669AbjFPOnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjFPOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:43:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB75519B5;
        Fri, 16 Jun 2023 07:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686926597; x=1718462597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K2g2JGeLr7QbMNnChySDPCIFrNL8eGLfo9YkCI+2hEQ=;
  b=ZOqzlcIp1ghIgzEZwPxbYVOso3IXVbtfP//fwsD6sEHHBhVaOBPDk5sr
   9rC7ekDUyr51xveOsytYjhhkLEeUk5wC/KCy+CSKQDm48bxGgSivHxASH
   H/m/zacvhyKLztjGmiOoyaW/3EU+B5kcRpg3RindK8gZoqH2ZDxl6LWVf
   u66MUmFFbSp4tY/l8RY8w5gow7ZkeKRJTnvaRFZ9HoF5UFuVN9OO9KuBp
   VgVtXEItq9p02Q9eu6Cwslb8ch8s/ZtWhSF+YjECBMbSr7migSdJGEqAp
   zLl7HZ/VC7SwJ0hGWfAUQmVyU/L7v1MOAFDfZGV2Fy104i0lFp4LaReq/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="348937410"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="348937410"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 07:43:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="716047644"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="716047644"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2023 07:43:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EF493379; Fri, 16 Jun 2023 17:43:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] math.h: Introduce struct u8_fract and struct s8_fract
Date:   Fri, 16 Jun 2023 17:43:18 +0300
Message-Id: <20230616144318.39532-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <ZIxzsUbuUz3ysA31@smile.fi.intel.com>
References: <ZIxzsUbuUz3ysA31@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems there going to be users for these data types, besides
quite likely existing users that may benifit from them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/math.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/math.h b/include/linux/math.h
index 2d388650c556..449a29b73f6d 100644
--- a/include/linux/math.h
+++ b/include/linux/math.h
@@ -112,6 +112,8 @@ struct type##_fract {					\
 	__##type numerator;				\
 	__##type denominator;				\
 };
+__STRUCT_FRACT(s8)
+__STRUCT_FRACT(u8)
 __STRUCT_FRACT(s16)
 __STRUCT_FRACT(u16)
 __STRUCT_FRACT(s32)
-- 
2.40.0.1.gaa8946217a0b

