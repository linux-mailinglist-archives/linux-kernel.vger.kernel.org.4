Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CEB627C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbiKNLoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbiKNLoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A58E20BF6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1DF7B80E71
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B2DC433D6;
        Mon, 14 Nov 2022 11:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426248;
        bh=Rea/9roCehb335b4DrtNyO/qn+jvaXcltDXAFPr/hzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H8yVQASEluCLaERJpcSWhON6r9oiDC8MsZ+Rt7B3r1AKkiAJ3QxkRhuNixXl+qo0v
         QdA7o5Dm2km8G9OuVEm3SVR12K62zYowYqplqlcgLLH0BRsvtpYFhmcIYioXbnfmdi
         waVVX09VuL1vSaewNv7dDS5csLa6iw7QztUYz3r6h5luKI9BtowSILSaeeJPBvDyIY
         KBlxDouQRMK0aqRAHNIwGTQZfSB5yoMgWhZzFpDoU4Ixv8CiyihQA8dcge//f+vPY9
         /gtFJVPKbIyLp/SXFtg4S4/aiw/m0IXY2FdhsmilqJT+Js5owP+EX/IGNrCVtheuRF
         UJwMzbFhUsfQw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>, Martin Liska <mliska@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/46] Compiler Attributes, lto: introduce __noreorder
Date:   Mon, 14 Nov 2022 12:43:04 +0100
Message-Id: <20221114114344.18650-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

gcc 5 has a new no_reorder attribute that prevents top level reordering
only for that symbol. So add a new __noreorder wrapper for the
no_reorder attribute. This will be used in the next patches to support
gcc LTO.

[js] split this to introduction & use

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/compiler_attributes.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 898b3458b24a..be6c71fd5ebb 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -379,4 +379,14 @@
  */
 #define __fix_address noinline __noclone
 
+/*
+ * https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#Common-Function-Attributes
+ */
+
+#if __has_attribute(__no_reorder__)
+#define __noreorder			__attribute__((no_reorder))
+#else
+#define __noreorder
+#endif
+
 #endif /* __LINUX_COMPILER_ATTRIBUTES_H */
-- 
2.38.1

