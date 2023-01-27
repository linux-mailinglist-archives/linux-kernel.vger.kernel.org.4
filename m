Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D9867EB0C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbjA0Qk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjA0Qkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:40:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528317CC98;
        Fri, 27 Jan 2023 08:40:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A96CB82013;
        Fri, 27 Jan 2023 16:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C12C433EF;
        Fri, 27 Jan 2023 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674837648;
        bh=gL29Zrz0/D+2aRM80IoOkzpVQZltIiXkr3UTM6jkxQI=;
        h=From:To:Cc:Subject:Date:From;
        b=FEAY7lRPlS71P4vd1mnOb99+zfCXZaNiJYGX4C2auV8u6+E/Fr/+xnTia4it9Lg/A
         TKsdC0BkfD8EveWUIgnGydssTz39HY/6ecVefBUWWopPuSN1IYZ9Zt/GNhb+RCInDF
         J1nViTa+lFvrk29dS6qrYa9O6m+V9Bmtgrk7u34UfAWvNMizFXZkZyXOCHrkzlMou2
         +7QkQ9lUnQkg4aQKEAEpzlOUHOPjexk/clFb6WhiwIFtfQ5dX+on8ey9bg4rjE/G6w
         bq5Qrj4hsjAPdMn4lsiac0f94e1c62dTuL0XUjSLFW1Yw7ptqEtyKwpDu46SFACjvf
         ig2SpHcdkRvMg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] setlocalversion: remove unneeded check and set -e
Date:   Sat, 28 Jan 2023 01:40:41 +0900
Message-Id: <20230127164041.548225-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Kbuild creates include/config/auto.conf before running this script,
so include/config/auto.conf always exists unless the user directly
runs this script.

Remove the redundant check. Instead, set -e.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/setlocalversion | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 7c7cbefa5aa4..3df25b045e81 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -10,6 +10,8 @@
 #
 #
 
+set -e
+
 usage() {
 	echo "Usage: $0 [srctree]" >&2
 	exit 1
@@ -103,11 +105,6 @@ collect_files()
 	echo "$res"
 }
 
-if ! test -e include/config/auto.conf; then
-	echo "Error: kernelrelease not valid - run 'make prepare' to update it" >&2
-	exit 1
-fi
-
 if [ -z "${KERNELVERSION}" ]; then
 	echo "KERNELVERSION is not set" >&2
 	exit 1
-- 
2.34.1

