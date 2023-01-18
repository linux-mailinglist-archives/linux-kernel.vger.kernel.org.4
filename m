Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3F76712F7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 06:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjARFFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 00:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjARFFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 00:05:04 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9534FAE5;
        Tue, 17 Jan 2023 21:05:03 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1674018301;
        bh=/0jOebbYX70I0nvSrPoQPRoP/uFq1ZW6GdE24q/IDq8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bNLzlNx8uNm8Yd0FXwMngRVuWCvS/8meW+rE5seGgza4A13DKDdhDe8Zb+cpzKqSv
         3YJ8avVAhmAllBIA8pgaayq/vzoofNPj7YPZI5Uoil37GJ9gJzhNMVWCHwjn7Iuu1U
         3ZuaD7lwYuZZN46GBcMNFaxGisLFVUnmYbK4U598=
Date:   Wed, 18 Jan 2023 05:04:52 +0000
Subject: [PATCH v3 2/2] kheaders: use standard naming for the temporary directory
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20230117-kernel-kheaders-gitignore-v3-2-d67d649dd990@weissschuh.net>
References: <20230117-kernel-kheaders-gitignore-v3-0-d67d649dd990@weissschuh.net>
In-Reply-To: <20230117-kernel-kheaders-gitignore-v3-0-d67d649dd990@weissschuh.net>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nicolas Schier <n.schier@avm.de>,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674018294; l=867;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/0jOebbYX70I0nvSrPoQPRoP/uFq1ZW6GdE24q/IDq8=;
 b=hLTHnP/QFDYSiXJOKQmUdG0Mbjj/ra+G2+J20sAYm5olerC/qY8/exy6zeUsUQ4NsI+W2XbFNV+J
 qe+IRQZIBKfKKdrzeYoPkYT6i/GznA5yIorE3X9MrbiLrw3pnGY+
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kheaders archive generation is interrupted then this directory
may be left on disk and not ignored by git.
By using the standard naming schema for temporary files and directories
the default .gitignore and "make clean" rules will apply.

Suggested-by: Nicolas Schier <nicolas@fjasle.eu>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/gen_kheaders.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 473036b43c83..b477b763f262 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -7,7 +7,7 @@ set -e
 sfile="$(readlink -f "$0")"
 outdir="$(pwd)"
 tarfile=$1
-cpio_dir=$outdir/$tarfile.tmp
+cpio_dir=$outdir/${tarfile%/*}/.tmp_cpio_dir
 
 dir_list="
 include/

-- 
2.39.1
