Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3906AD196
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCFWck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCFWcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:32:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A845B65450;
        Mon,  6 Mar 2023 14:32:35 -0800 (PST)
From:   Bastian Germann <bage@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678141953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DyQXSp5VcsanePt7oajW4QUYwJc1l20YmNRKclLiQkg=;
        b=hJHIuNf+O8z4XRjyatP+wAr9Xts9CwZVsiG6It+q7lLHMgimoPDURYFE1l/qJqEflc8JEh
        oHCMJtRm4uVZ/GVkfLPFkypgmT36+3yksGdvzSoypafDV8aGTk/3CYDjvxWNXv4lFxG3vV
        EBIoleOKlrN1MHXvudZEKXDmqOBC0KYY3h+RUKRn+x/dojs1Gx55xsl206AIOX9sh6tZmk
        p6WAPR77bvMDRUEmKEW1tE0+ZLhHdc0rrMbiRPYijpwBdO8O6ibB13aSkEnzBi5BIRqwL+
        9s4NNnZXXAUbGPCclDRb8GWJO6jd3ZYnNNBAO5Xxnc35sJQRkdKS/3rIo3MHPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678141953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DyQXSp5VcsanePt7oajW4QUYwJc1l20YmNRKclLiQkg=;
        b=GEDsy1wyLHGkjA7DVdcfBgUm8+X2uZt6CJ+9WORkoGmu2So2CuguBCjs5iXve07QtLSAPA
        V0kWsElzJpPJwGBA==
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     Bastian Germann <bage@linutronix.de>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] builddeb: introduce profile excluding the dbg pkg
Date:   Mon,  6 Mar 2023 23:32:08 +0100
Message-Id: <20230306223208.6277-2-bage@linutronix.de>
In-Reply-To: <20230306223208.6277-1-bage@linutronix.de>
References: <20230306223208.6277-1-bage@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling CONFIG_DEBUG_INFO implies building the binary linux-image-*-dbg.
As this increases package build time significantly, one might want to
exclude it from being built.

Add build profile pkg.$sourcename.nokerneldbg for that package
so it can be excluded via e.g.
`make DPKG_FLAGS="-P=pkg.linux-upstream.nokerneldbg" deb-pkg`

The name is the same that is used in Debian's linux package since version
5.17~rc4-1~exp1.

Link: https://wiki.debian.org/BuildProfileSpec
Link: https://salsa.debian.org/kernel-team/linux/-/commit/140798ec2789
Signed-off-by: Bastian Germann <bage@linutronix.de>
---
 scripts/package/mkdebian | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index f74380036bb5..8a7969926e53 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -227,6 +227,7 @@ if is_enabled CONFIG_DEBUG_INFO; then
 cat <<EOF >> debian/control
 
 Package: linux-image-$version-dbg
+Build-Profiles: <!pkg.$sourcename.nokerneldbg>
 Section: debug
 Architecture: $debarch
 Description: Linux kernel debugging symbols for $version
-- 
2.39.2

