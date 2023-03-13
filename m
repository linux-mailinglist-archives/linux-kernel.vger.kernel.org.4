Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF376B7EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjCMRM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjCMRMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:12:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7465D882;
        Mon, 13 Mar 2023 10:11:42 -0700 (PDT)
From:   Bastian Germann <bage@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678727442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jUCOnKp7oaWPPRPgXpLOeSnxJCyGEKRXbG3cbi0JPkU=;
        b=IctN3nQ1IvEVYfwRKl25pVtz838W6KQJP6HXKuVbCIv/nd2LotGk5yKtL2vAlxztqhP9AQ
        ZCEgMroYlDlGYnDfrhWW985KMvkNjwkUYQ75jJeIKgZAmxrgb5EILoNU7KY3HIDku6SK9r
        4MEs0P6HtT7/cieVZg6RIPDx9iFFiFw3WZ6VPyIDZ2pEy/4qTYXShRU6nK16Vmw6DI/WNL
        XYgdF4qSQSUzBBq0u/+HHUOABXNoYPBxwvhev4uw64DYqH6Pqlx9HPzkAnxx1LgCkawh66
        jJGFcci6CG2bWJP2PJx+W5r9/L6PlrIFNKeUsQNyXfj8gub29mWf3ZcOtkRdFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678727442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jUCOnKp7oaWPPRPgXpLOeSnxJCyGEKRXbG3cbi0JPkU=;
        b=uz0P2/5iLLgVih0yVq0uZs0veZLMruBbfK7w/FcRd+hr39HkZPVX2RJScsLC3CIJ9NVtgr
        XWw2ERDrms1svEAA==
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] kbuild: deb-pkg: Allow parallel build
Date:   Mon, 13 Mar 2023 18:10:36 +0100
Message-Id: <20230313171036.268407-2-bage@linutronix.de>
In-Reply-To: <20230313171036.268407-1-bage@linutronix.de>
References: <20230313171036.268407-1-bage@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the only way to build the deb-pkg generated package parallely
is adding -jN to the MAKEFLAGS environment variable. The package ignores
the usual parallel build option that is described in Debian Policy §4.9.1.

Derive make's -j parameter from the DEB_BUILD_OPTIONS environment variable
that ends up being set by Debian's build tools.

Link: https://www.debian.org/doc/debian-policy/ch-source.html
Signed-off-by: Bastian Germann <bage@linutronix.de>
---
 scripts/package/deb-build-option | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/package/deb-build-option b/scripts/package/deb-build-option
index b079b0d121d4..dd170e2b3018 100755
--- a/scripts/package/deb-build-option
+++ b/scripts/package/deb-build-option
@@ -7,6 +7,12 @@ if [ -z "${CROSS_COMPILE}${cross_compiling}" -a "${DEB_HOST_ARCH}" != "${DEB_BUI
 	echo CROSS_COMPILE=${DEB_HOST_GNU_TYPE}-
 fi
 
+for build_opt in $DEB_BUILD_OPTIONS; do
+	if [ "${build_opt#parallel=}" != "$build_opt" ]; then
+		echo -j${build_opt#parallel=}
+	fi
+done
+
 version=$(dpkg-parsechangelog -S Version)
 version_upstream="${version%-*}"
 debian_revision="${version#${version_upstream}}"
-- 
2.39.2

