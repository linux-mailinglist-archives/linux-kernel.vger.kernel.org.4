Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F31F69FFEF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 01:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjBWARC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 19:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBWARA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:17:00 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC24738660;
        Wed, 22 Feb 2023 16:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Rxuqb3bdScNwrTUfRo927M0lNZEoKULP5VXPvdExi3k=; b=PYjYWtHBaxJZ81QvooVB++SUsT
        FYb/Vbe/zomCeKbrAG7O/bA0K6mM0FtPW53JgkG/4w6p+pK3B4RploFDqoJ/KxJ4lcv5Qt9IsfSte
        f7koC2nnvJ7ysHMrxFrM2JL+e0TmwusKDexbBEaxZ5R0fyGz/BgBFNB4m6STI28/2ZJKh/ljl3n+9
        mAtHRrvKHfSLpce18GD7F4ld4ViPbwKm/ohF7Gj0K8D3hpEyeUYEJVCvgYbE3TH9B+cZnc5W/CwRg
        yLFut1GXViw4tvlh11VoIS5G4M8WhmARqRcpObqXIypIW38MBTBJpDl1cFiUS6bAx7DzfGNN7UJ87
        lNvkrGpw==;
Received: from 189-68-200-53.dsl.telesp.net.br ([189.68.200.53] helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pUzHw-00BSBz-8n; Thu, 23 Feb 2023 01:16:44 +0100
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     kernel-dev@igalia.com, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH] kbuild: modinst: Enable multithread xz compression
Date:   Wed, 22 Feb 2023 21:16:07 -0300
Message-Id: <20230223001607.95523-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it's done for zstd compression, enable multithread compression for
xz to speed up module installation.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---

On my setup xz is a bottleneck during module installation. Here are the
numbers to install it in a local directory, before and after this patch:

$ time make INSTALL_MOD_PATH=/home/tonyk/codes/.kernel_deploy/ modules_install -j16
Executed in  100.08 secs

$ time make INSTALL_MOD_PATH=/home/tonyk/codes/.kernel_deploy/ modules_install -j16
Executed in   28.60 secs
---
 scripts/Makefile.modinst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 4815a8e32227..28dcc523d2ee 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -99,7 +99,7 @@ endif
 quiet_cmd_gzip = GZIP    $@
       cmd_gzip = $(KGZIP) -n -f $<
 quiet_cmd_xz = XZ      $@
-      cmd_xz = $(XZ) --lzma2=dict=2MiB -f $<
+      cmd_xz = $(XZ) --lzma2=dict=2MiB -f -T0 $<
 quiet_cmd_zstd = ZSTD    $@
       cmd_zstd = $(ZSTD) -T0 --rm -f -q $<
 
-- 
2.39.2

