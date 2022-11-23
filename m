Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593E6636328
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbiKWPTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbiKWPTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:19:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF88549B64;
        Wed, 23 Nov 2022 07:19:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A394B8201C;
        Wed, 23 Nov 2022 15:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EFBC433D6;
        Wed, 23 Nov 2022 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669216768;
        bh=TYgZT0UGUrDb3jnlRqypuUU6uixbw+w0KmXfqkCj/Ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MaWBZskklIpI/JB9pyv3uj9JVrxpNthVMW9OCVg7JdlrPm9I3l5wStLREBgY7yIDu
         KseZCUv4wY/W0yY1wOB1ULSvVHI6TANy2oA2l85bV/Oy8FeUMjJtt5Btq696yki63v
         PZ61+M+vkL35h2ZQURwb6osKWB49ru7xvolIUfH4RRcjnrFB4NGghDLAF901N6C5FI
         MvsOn7s8b9a6Ni0Uu8Fw1aOYQDcMajS4xVut8GplZhtEzyVvu0BLWTH9pshEQrLISF
         bZ+voy/9gzYZ+v0GWkUikRJTWKun5uY90RiJpEEh6th86OgHUzUXrtO7A1D+NHpiN7
         cyaTUqXthK6Iw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v2 5/5] kbuild: check Make version
Date:   Thu, 24 Nov 2022 00:18:28 +0900
Message-Id: <20221123151828.509565-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123151828.509565-1-masahiroy@kernel.org>
References: <20221123151828.509565-1-masahiroy@kernel.org>
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

This is implemented based on test-le. It will work until GNU Make 10
is released.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 60ce9dcafc72..797fafbc1b45 100644
--- a/Makefile
+++ b/Makefile
@@ -368,6 +368,9 @@ else # !mixed-build
 
 include $(srctree)/scripts/Kbuild.include
 
+# Check for the minimal Make version
+$(if $(call test-lt, $(MAKE_VERSION), 3.82), $(error Make $(MAKE_VERSION) is too old))
+
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
 KERNELRELEASE = $(call read-file, include/config/kernel.release)
 KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
-- 
2.34.1

