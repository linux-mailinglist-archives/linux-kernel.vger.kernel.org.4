Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087B16BBAFF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjCORfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjCORfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:35:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F90231C5;
        Wed, 15 Mar 2023 10:35:35 -0700 (PDT)
From:   Bastian Germann <bage@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678901733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kBXlFLmMWrr2xckgQ+JZNuthzUvbmm8IYa3geFG9NN4=;
        b=KT3TA9N89PsGq+rcL8eZwrSeWekI6fdcV+zDHjiFRishPnQAspGuoGu3HSSofFF3itW2N1
        CHTUP/w+oYscjBH7py2x6wYDdG2ZfO3CsYaweL6y/xJSG0U8RCqLVM+Hyckb8GOVypypcL
        qq5ohMqXKt/aAD38Jh3P5sTw9DAkBlXx+k0Nepy458HlLU+gC7OHzI6EUmr2ocG29gqugp
        vLGSQXEtjT8Moa6adZiDC9fAvap2qykY8phzESXd+kvKEMRnTlBN265gxy6LI6Jz31sc7H
        pBQ5+hy97N/J0/kWUGKJ/rPCf30nA0VNAFLUJkCuH3yYI2VGxdIt7gBPo7rV2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678901733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kBXlFLmMWrr2xckgQ+JZNuthzUvbmm8IYa3geFG9NN4=;
        b=daqBTicc8W3Xqem43zH80qH7Ch8CnKqr2dy+ZW71Ldo34C5MgFCTtVIkdmJYozeQ3Yk2rs
        dx7Sc5R66ESzUiDw==
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] kbuild: deb-pkg: Build parallely with current dpkg-buildpackage
Date:   Wed, 15 Mar 2023 18:35:23 +0100
Message-Id: <20230315173524.63179-1-bage@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of DEB_BUILD_OPTIONS' parallel option because that is the only
parallel build option that is set by default in current dpkg-buildpackage
versions.

v2:
 * Clarify that this is for current dpkg-buildpackage versions
 * Evaluate DEB_BUILD_OPTIONS in debian/rules.
v3:
 * Use the Policy snippet which sets MAKEFLAGS and uses patsubst over subst
 * Mention the dpkg commit that changed the -j behaviour.

Bastian Germann (1):
  kbuild: deb-pkg: Build parallely with current dpkg-buildpackage

 scripts/package/mkdebian | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.39.2

