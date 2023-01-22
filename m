Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECDA676D85
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjAVOO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjAVOOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:14:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045851A95C;
        Sun, 22 Jan 2023 06:14:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DBB0B80AE1;
        Sun, 22 Jan 2023 14:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B363C433A0;
        Sun, 22 Jan 2023 14:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674396880;
        bh=ndQFjq+/ARkN/T9TsVQmpqH/FBFem7P2bRf0kXnGi0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gfpg+zWBgdzmkdnkHK9/GrSCoWM3Hj9M9JV2l5W7qy8P8ImFYoKFGZuJlj5KnUOY1
         /hkbB+HVpmjvhYrRj7/MlNLGcbn/UFt871v/FsOs2COBs9nrITy03kdlx59oS2bZeL
         BVMhNEPLfLRwALVZYlxxpSHo1trUHNj/E9we8SKFznL6BxuWB2r9m6ybhUaIkh4Mm6
         VhkbSNQsaZAJsFEw6x0/U3XGx62UqqJM9Ip4s6Z5aWdjfxjwp1OyiXCHzUYGLzE05f
         Y1J4M7d6eCdExpo6dYqh5tKsrGhpw98scizwcvXrWLyk0uLJLNlUCRUBNnTTcrrDVp
         82EFSMtcZD4yQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6/7] setlocalversion: print ${KERNELRELEASE} if set
Date:   Sun, 22 Jan 2023 23:14:26 +0900
Message-Id: <20230122141428.115372-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230122141428.115372-1-masahiroy@kernel.org>
References: <20230122141428.115372-1-masahiroy@kernel.org>
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

When KERNELRELEASE is overridden, include/config/kernel.release still
stores the string would be returned by the script if KERNELRELEASE had
not been overridden. This is not strange.

include/config/kernel.release should store KERNELRELEASE that was used
for building the kernel.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/setlocalversion | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 7c7cbefa5aa4..eff8cc831571 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -103,6 +103,11 @@ collect_files()
 	echo "$res"
 }
 
+if [ -n "${KERNELRELEASE}" ]; then
+	echo "${KERNELRELEASE}"
+	exit 0
+fi
+
 if ! test -e include/config/auto.conf; then
 	echo "Error: kernelrelease not valid - run 'make prepare' to update it" >&2
 	exit 1
-- 
2.34.1

