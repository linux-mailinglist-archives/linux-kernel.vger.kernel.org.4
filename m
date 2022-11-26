Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C91F63988A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 23:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKZW4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 17:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiKZW4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 17:56:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93130140E2;
        Sat, 26 Nov 2022 14:56:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 500FFB80A36;
        Sat, 26 Nov 2022 22:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1ADDC433D7;
        Sat, 26 Nov 2022 22:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669503400;
        bh=1TveETKu7sAKWh+ej+xoHr1gzM/i4XbkZ6CR9I8Eia4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KkDBMd5kPkQdz5ZARbkK/WCiOsJ9+y5NCndrZ6R4AF+8PBvzMpmGGfyj5KOWacYmt
         sMAhzUN/71rXyWIanUbGX1AwycvLBN9o3zsIcaFbxdTHADU09z6cWP2XjVH3RX/uS0
         UFAZcwqybSsiGjXcABxLM4j65dVmNqKDfw1Jhfw6xD5rvYTU0kSyslTOxvKwu/Hcuu
         2UEM5dWiHiR3p4xBtUh2tl/NTYMNBavwZYfnrPvLkpSjQyPOYKzo2kTMKMZ8w45rl2
         p0tVF47wPnq+K78P3dlgMelmha4kbO+zjC99iuGDVXI2C/1na9d+Xc6xFDPS72UXZW
         vOqofj2v/SgBA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 5/5] kbuild: check Make version
Date:   Sun, 27 Nov 2022 07:56:24 +0900
Message-Id: <20221126225624.751661-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221126225624.751661-1-masahiroy@kernel.org>
References: <20221126225624.751661-1-masahiroy@kernel.org>
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
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
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

