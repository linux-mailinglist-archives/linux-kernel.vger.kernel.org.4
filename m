Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541B0643C14
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 05:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiLFEH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 23:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiLFEHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 23:07:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23206154;
        Mon,  5 Dec 2022 20:07:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27639B8168D;
        Tue,  6 Dec 2022 04:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E515C433D6;
        Tue,  6 Dec 2022 04:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670299660;
        bh=ePwjPaI2Z6T7+0xFbhATrAqsXtn51i/sOFs2gwoBkh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/+oCTGSagCfjGAIgH9+UYCJW1OKq8vlJaL5kbq/ZnnKXgkfwk9/zQTLXJyZdRKxk
         eEQmGiUT3lQumFi0ji8UYtKXTQfqjJToSGxnXy6MNC3gHbX3s740fBSbV70tk87Rm4
         3O2vK2HGubIzFLj2LwlASkA//z32xHyhQPf3EpepSpkRjZ+7BiM+4mph/qRsThkVhx
         lnI3ag0+KWG4IolR8lgxBRxV0YjWvnEM0TOMWnmB7+vcCYkhGx9H10xrlVAX1Egig6
         nXwkV4kfU1vkWNcLDjzT37GIYGqsM/LkqJnb/rQMzuqEVqJXSnJsJ8LoezJjDe6SRg
         6lfBRAZZ5IQ3Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 2/2] kbuild: add -Wundef to KBUILD_CPPFLAGS for W=1 builds
Date:   Tue,  6 Dec 2022 13:07:31 +0900
Message-Id: <20221206040731.442499-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206040731.442499-1-masahiroy@kernel.org>
References: <20221206040731.442499-1-masahiroy@kernel.org>
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

The use of an undefined macro in an #if directive is warned, but only
in *.c files. No warning from other files such as *.S, *.lds.S.

Since -Wundef is a preprocessor-related warning, it should be added to
KBUILD_CPPFLAGS instead of KBUILD_CFLAGS.

My previous attempt [1] uncovered several warnings, and could not finish
fixing them all.

This commit adds -Wundef to KBUILD_CPPFLAGS for W=1 builds in order to
block new breakages. (The kbuild test robot tests with W=1)

We can fix the warnings one by one. After we fix all of them, we can
make this default in the top Makefile, and remove -Wundef from
KBUILD_CFLAGS.

[1]: https://lore.kernel.org/all/20221012180118.331005-2-masahiroy@kernel.org/

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.extrawarn | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 6bbba36c5969..40cd13eca82e 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -38,6 +38,7 @@ KBUILD_CFLAGS += -Wno-sign-compare
 KBUILD_CFLAGS += -Wno-type-limits
 KBUILD_CFLAGS += -Wno-shift-negative-value
 
+KBUILD_CPPFLAGS += -Wundef
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN1
 
 else
-- 
2.34.1

