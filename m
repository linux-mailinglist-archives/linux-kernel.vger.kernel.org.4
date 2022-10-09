Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4794E5F8C49
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 18:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiJIQXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 12:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiJIQWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 12:22:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CB92B19D
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 09:22:45 -0700 (PDT)
X-QQ-mid: bizesmtp63t1665332553tg3dgxz5
Received: from localhost.localdomain ( [58.247.70.42])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Oct 2022 00:22:32 +0800 (CST)
X-QQ-SSF: 01100000002000G0Z000B00A0000000
X-QQ-FEAT: xqT8U4SkSphFgcFPh5JRStQ/GKaIUXNKUgQ68cyZGIRbaqdoULKWb5GOFKtg3
        cIxNITCqwXcs2VsfBb/8vGApOIm4U/q4iBSp4mnq580tWgEyhuNcM467J2T2LbqZIGr2LDd
        r8gOhflJ9f5AWNhMgGTlC+Vsvht1MO5wG/fdSV9ZPLt8DxrrRBLCPZVPoz2MvhuNCjLM7ub
        SU3BswYGhbXsOkGIe28jEHuduxNT1hd8xCuFaD3TYmGN0yjj7y8JjxPxkQrnE/zdXV45b7v
        iSugb/5UZ1tITubb34afvTMkCYAy7Aejtd3s9MBxgyjbQxFeN5vL2mkUFhvmm6CNXOKnq24
        M3kLYO9wu89Vq6zgnk/39flVPvR2IW9mxUZaCWG6wqRPUdfKnmpcco43mrsfA==
X-QQ-GoodBg: 0
From:   Soha Jin <soha@lohu.info>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, Soha Jin <soha@lohu.info>
Subject: [PATCH 3/3] device property: add fwnode_is_compatible() for compatible match
Date:   Mon, 10 Oct 2022 00:21:55 +0800
Message-Id: <20221009162155.1318-4-soha@lohu.info>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221009162155.1318-1-soha@lohu.info>
References: <20221009162155.1318-1-soha@lohu.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lohu.info:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fwnode_is_compatible is a shortcut to check if a device is compatible with
a compat string in fwnode property "compatible". This function is similar
to of_device_is_compatible.

Signed-off-by: Soha Jin <soha@lohu.info>
---
 include/linux/property.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index dbe747f3e3be..776e4a8bc379 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -252,6 +252,13 @@ fwnode_property_string_array_count(const struct fwnode_handle *fwnode,
 	return fwnode_property_read_string_array(fwnode, propname, NULL, 0);
 }
 
+static inline bool fwnode_is_compatible(const struct fwnode_handle *fwnode,
+					const char *compat)
+{
+	return fwnode_property_match_string_nocase(fwnode, "compatible",
+						   compat) >= 0;
+}
+
 struct software_node;
 
 /**
-- 
2.30.2

