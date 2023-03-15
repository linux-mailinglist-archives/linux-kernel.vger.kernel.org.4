Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8835B6BBE18
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjCOUpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjCOUpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:45:33 -0400
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9245FA7D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:45:32 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 6072C5F94F;
        Wed, 15 Mar 2023 21:45:29 +0100 (CET)
Date:   Wed, 15 Mar 2023 21:45:29 +0100 (CET)
From:   Christian Kujau <lists@nerdbynature.de>
To:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Subject: rust: Minor formatting fix on available Rust version.
Message-ID: <2d8ace62-c087-884b-3d4a-d29291697d9c@nerdbynature.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Fedora (and possibly other distributions too) rustc is versioned as:
    
$ rustc --version
rustc 1.67.1 (d5a82bbd2 2023-02-07) (Fedora 1.67.1-1.fc37)
    
This makes "make rustavailable" report the version twice:
    
*** Rust compiler 'rustc' is too new. This may or may not work.
***   Your version:     1.67.1
1.67.1
***   Expected version: 1.62.0
    
Fix that by only reporting the first version number.
    
Signed-off-by: Christian Kujau <lists@nerdbynature.de>
---
diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index aebbf1913970..6b5d25e36538 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -46,8 +46,8 @@ fi
 # Non-stable and distributions' versions may have a version suffix, e.g. `-dev`.
 rust_compiler_version=$( \
 	LC_ALL=C "$RUSTC" --version 2>/dev/null \
-		| head -n 1 \
 		| grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
+		| head -n 1
 )
 rust_compiler_min_version=$($min_tool_version rustc)
 rust_compiler_cversion=$(get_canonical_version $rust_compiler_version)

-- 
BOFH excuse #398:

Data for intranet got routed through the extranet and landed on the internet.
