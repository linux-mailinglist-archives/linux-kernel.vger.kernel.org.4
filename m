Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A3F6B9610
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjCNN0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCNNZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:25:50 -0400
X-Greylist: delayed 646 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Mar 2023 06:23:12 PDT
Received: from lemon.tzafrir.org.il (lemon.tzafrir.org.il [IPv6:2001:4b98:dc0:47:216:3eff:fe23:1813])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 165D29FBC4;
        Tue, 14 Mar 2023 06:23:11 -0700 (PDT)
Received: from malaclypse.mth.mellanox.com (sweetmorn [10.2.0.26])
        by lemon.tzafrir.org.il (Postfix) with ESMTPS id 4E52045BF;
        Tue, 14 Mar 2023 14:04:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cohens.org.il;
        s=default; t=1678799052;
        bh=R8uxPVvrHH9VeFPwxgyu8SGWFM89LkDGbYn2J/4lXSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neDC/C4f3xX/Efi8ym9HLwTAC8dz8Z8IWKSSBLOAQt1V3wNhLFVfSS7gC3fsiJ+17
         rD/aUJVrzXFrSufFB9os/n/e7Wx6DwqrlhV+1BAlUz66x6uE0dFEvxV/3nTxPjYtBY
         /7PABxKPCJxrZ2ulnVmbbmuEG42qb3PaGUeitimrBc6qbqHjabDBMOKpko8XJpKlJu
         vmrep3wWQalKf5ILb5U4/lE/rBczy8ztoD0edY39mWshGCfebyu7PfGBgi6Trk4f7f
         ooWzpcLRqW6u17OK9ZhTFcNJRxDQlH4J0CYaC8BIsNgFMPD+EXYqSd2HMS5FRSGo0j
         tWF/XlVyzXCZQ==
Received: by malaclypse.mth.mellanox.com (Postfix, from userid 1000)
        id F0403847D4DA; Tue, 14 Mar 2023 15:04:14 +0200 (IST)
From:   nvidia@cohens.org.il
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Tzafrir Cohen <nvidia@cohens.org.il>
Subject: [PATCH] Makefile: Make kernelrelease target work with M=
Date:   Tue, 14 Mar 2023 15:02:48 +0200
Message-Id: <20230314130248.954196-2-nvidia@cohens.org.il>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314130248.954196-1-nvidia@cohens.org.il>
References: <20230314130248.954196-1-nvidia@cohens.org.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzafrir Cohen <nvidia@cohens.org.il>

Fixes: commit 1cb86b6c3136 ("kbuild: save overridden KERNELRELEASE in include/config/kernel.release")

That commit required the use of filechk_kernel.release for the
kernelrelease Makefile target. It is currently only being set when
KBUILD_EXTMOD is not set. Make sure it is set in that case as well.

Signed-off-by: Tzafrir Cohen <nvidia@cohens.org.il>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 3e7f96f12f08..e0859c608147 100644
--- a/Makefile
+++ b/Makefile
@@ -1880,6 +1880,8 @@ endif
 
 else # KBUILD_EXTMOD
 
+filechk_kernel.release = echo $(KERNELRELEASE)
+
 ###
 # External module support.
 # When building external modules the kernel used as basis is considered
-- 
2.39.2

