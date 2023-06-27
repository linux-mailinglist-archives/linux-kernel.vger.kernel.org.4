Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE40C73FC52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjF0NBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjF0NBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:01:36 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B500E1;
        Tue, 27 Jun 2023 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687870890; bh=LCFUho+x/i+9Jjg3s4a/kFQNBnAevgmTIXokYnqx08A=;
        h=From:To:Cc:Subject:Date:From;
        b=FGuCdZzgneemCBuX3vcnoudOfAQ2lUs1Kk8uaY3IccA/1ikmcBcxiFiPe3Fb+NoTo
         bKaz7iCkg/iSqaR+ha7qDlHQyf/HCSghBRZL9QAqj9lVGFViWnzRE162cVBz0uTSMW
         puxo8Vhb0RExNoCodLyHcxDCHzIu9O4NRpyRiXeU=
Received: from ld50.lan (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id E9BCD6011B;
        Tue, 27 Jun 2023 21:01:28 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>,
        Nathan Chancellor <nathan@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
Subject: [PATCH 0/2] Fix cross-compilation issues with Clang
Date:   Tue, 27 Jun 2023 21:01:20 +0800
Message-Id: <20230627130122.1491765-1-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

Hi,

Just some quick fixes to the recently accepted Clang patches, thanks to
Nathan's followup testing. (I test-compiled natively so didn't notice
that cross-compilation was broken, and by chance the LLVM snapshot I
used didn't contain the breaking commit either.)

With an additional LLVM patch https://reviews.llvm.org/D153865 the Clang
builds should now get fixed.

WANG Xuerui (2):
  LoongArch: vDSO: Use CLANG_FLAGS instead of filtering out '--target='
  LoongArch: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation

 arch/loongarch/Makefile      | 2 +-
 arch/loongarch/vdso/Makefile | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

-- 
2.40.0

