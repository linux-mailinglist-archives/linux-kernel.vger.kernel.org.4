Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA306AE1C9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjCGOJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCGOIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:08:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1BD85B10
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F06626145A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF1BC4339E;
        Tue,  7 Mar 2023 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198046;
        bh=QDcwBf9EH2tJ8eEyC1Nj4A3MrnVEC+rPwfe1iysJZno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3P88CgXVT+Ugyk0GX6xkiiygfzJAeGNw293YRfGLC057gYzoTHRmK6hjtQSwj4YC
         Yh37QCaD5DvY0bZCIqX+wZOYIIu0iJnSRermRuZvfn0qgFzZ9jr6MPERqUO4eUpg1k
         Rpzewkl2SxFKHHrgwew2jxR3UKrbcfI3A4T6iyR2skp+LtvQ2ZtVdPllTpylOgGb9z
         tROQ+mp1S3i8iC5N0aVSCOT1E74eHKITY7L2K5cQ6/QaHaxPDBqDGK463ghHVtRIaf
         RQ/e+ZBzvvLANTf2L7eE1CnPvrvp0BXV/SgxE2rsN520wJ0Xk8G7zNYCGIap2cIF2X
         SWYiIda8F6NuQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 20/60] arm64: idreg-override: avoid strlen() to check for empty strings
Date:   Tue,  7 Mar 2023 15:04:42 +0100
Message-Id: <20230307140522.2311461-21-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; i=ardb@kernel.org; h=from:subject; bh=QDcwBf9EH2tJ8eEyC1Nj4A3MrnVEC+rPwfe1iysJZno=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdxWAN6+mCPXEZupER8qbJd7ZNU/Be93y60EaL59uSn 53iNTHoKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABMpO8zI8HPWzi0xmf8dy3b6 +ztr3XNmn57R2daXdcHiysRopbDPRgz/ywJybG0DPkQGeW8xOqQwaePOdVVetV9qQ1KYOL7bG4o xAQA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlen() is a costly way to decide whether a string is empty, as in that
case, the first character will be NUL so we can check for that directly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/idreg-override.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 23bbbc37ac24ba09..476dc3f0e9d90e22 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -221,7 +221,7 @@ static void __init match_options(const char *cmdline)
 
 		override = prel64_to_pointer(&reg->override_prel);
 
-		for (f = 0; strlen(reg->fields[f].name); f++) {
+		for (f = 0; reg->fields[f].name[0] != '\0'; f++) {
 			u64 shift = reg->fields[f].shift;
 			u64 width = reg->fields[f].width ?: 4;
 			u64 mask = GENMASK_ULL(shift + width - 1, shift);
-- 
2.39.2

