Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8158069839F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjBOSnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBOSnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:43:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C423E091
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:42:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85A76B82371
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E63C4339E;
        Wed, 15 Feb 2023 18:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676486488;
        bh=fc+5seqhTO5BvvY3isnCsCZbytpHZYKbkp6X0pw+tz0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=KwKxexKOjWpIM62ogFQODLQ1bQsNzLet37om+7MP+97xaJyIyy2vgnIwKvqGHgSum
         AK1HlTcMi+AvC332r/QIwE+/49lsjRtJJSV4BIXQMrnonWfh+22HtMsqqs7j8kwYyW
         w1EKs81R8h99F0BIHuSoZfDAmS6VE5JSMLdZ+IFrjA4FhQ/WlqFpzGOvDUzu4ZTqOq
         FYLfMowZLmq29qGViyPSz7myGFzjL33q7gGLhZfuv3GDwHSYvo80FQH+P2N8ItH8t1
         EkSsDc48uZakeV8iEsThXGc2ro9ZjG3icqKXOi2XHl4Nf9kwmXsGAq9DohtR+CUXdi
         ndi0MW4G87mvA==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Wed, 15 Feb 2023 11:41:17 -0700
Subject: [PATCH 3/3] powerpc: Allow CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2 with
 ld.lld 15+
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230118-ppc64-elfv2-llvm-v1-3-b9e2ec9da11d@kernel.org>
References: <20230118-ppc64-elfv2-llvm-v1-0-b9e2ec9da11d@kernel.org>
In-Reply-To: <20230118-ppc64-elfv2-llvm-v1-0-b9e2ec9da11d@kernel.org>
To:     mpe@ellerman.id.au
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        erhard_f@mailbox.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=nathan@kernel.org;
 h=from:subject:message-id; bh=fc+5seqhTO5BvvY3isnCsCZbytpHZYKbkp6X0pw+tz0=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDMlv1UPn3nmjdiU36FOT54YGk9jbwdOfzrpwQ4Lldo2jh
 aTmydrijlIWBjEOBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjAR3mCG/xFvgraEdZq6CVXX
 CPptLaiNF2zQ335f/duS/6bbGRO9lRgZHkb0V30yMWtbK9nNreCq1Vi8e/3F+z8LMgqXK/R7Bzh
 zAwA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5017b4594672 ("powerpc/64: Option to build big-endian with ELFv2
ABI") restricted the ELFv2 ABI configuration such that it can only be
selected when linking with ld.bfd, due to lack of testing with LLVM.

ld.lld can link ELFv2 kernels without any issues; in fact, it is the
only ABI that ld.lld supports, as ELFv1 is not supported in ld.lld.

As this has not seen a ton of real world testing yet, be conservative
and only allow this option to be selected with the latest stable release
of LLVM (15.x) and newer.

While in the area, remove 'default n', as it is unnecessary to specify
it explicitly since all boolean/tristate configuration symbols default
to n.

Tested-by: "Erhard F." <erhard_f@mailbox.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b8c4ac56bddc..f9f13029c98a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -603,8 +603,7 @@ config PPC64_BIG_ENDIAN_ELF_ABI_V2
 	bool "Build big-endian kernel using ELF ABI V2 (EXPERIMENTAL)"
 	depends on PPC64 && CPU_BIG_ENDIAN
 	depends on CC_HAS_ELFV2
-	depends on LD_IS_BFD && LD_VERSION >= 22400
-	default n
+	depends on LD_VERSION >= 22400 || LLD_VERSION >= 150000
 	help
 	  This builds the kernel image using the "Power Architecture 64-Bit ELF
 	  V2 ABI Specification", which has a reduced stack overhead and faster

-- 
2.39.2

