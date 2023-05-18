Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF6E707DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjERKZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjERKZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:25:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE96C1BCA
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:25:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49CF7612D3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F10C4339B;
        Thu, 18 May 2023 10:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684405538;
        bh=horsSNtaATRHh7WRspe0LOv/cMkQnBJ+gC4dIJ6oeec=;
        h=From:To:Cc:Subject:Date:From;
        b=UiNQg/eYb4x6iZ1LdMXXHsaZn1Hr98TWOyCGSu9FBy5Ds0nuEkQfNm6ik1cJeiNNe
         l7maUw/oEBkmnXL/pYk+c20+krnLrWuFhLUccIpf+cZQi9NknqACLbF48gcTSEi8XA
         ZFm/9h7p54dfnkUFW9AhVQjJaglr3UEuukO/C8D/thR1BCU/nNnnnHyalO77axp1Kh
         qBpQQi2sjzYaTylk1l+nfsn9LgtSUFTFXwfzDmbaQSwMSHRU4c6Ik+3drjWr/GXaYb
         /jOpcxP5WoZEXEEBnSfXNPTWHgI4fZU60kh9/NOMZQyCCE8OQhc0k2+F/7NjCcVptu
         U/l9sIALbzAwg==
From:   Will Deacon <will@kernel.org>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Krzesimir Nowak <krzesimir@kinvolk.io>,
        Andrey Ignatov <rdna@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH v2] bpf: Fix mask generation for 32-bit narrow loads of 64-bit fields
Date:   Thu, 18 May 2023 11:25:28 +0100
Message-Id: <20230518102528.1341-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A narrow load from a 64-bit context field results in a 64-bit load
followed potentially by a 64-bit right-shift and then a bitwise AND
operation to extract the relevant data.

In the case of a 32-bit access, an immediate mask of 0xffffffff is used
to construct a 64-bit BPP_AND operation which then sign-extends the mask
value and effectively acts as a glorified no-op. For example:

0:	61 10 00 00 00 00 00 00	r0 = *(u32 *)(r1 + 0)

results in the following code generation for a 64-bit field:

	ldr	x7, [x7]	// 64-bit load
	mov	x10, #0xffffffffffffffff
	and	x7, x7, x10

Fix the mask generation so that narrow loads always perform a 32-bit AND
operation:

	ldr	x7, [x7]	// 64-bit load
	mov	w10, #0xffffffff
	and	w7, w7, w10

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Krzesimir Nowak <krzesimir@kinvolk.io>
Cc: Andrey Ignatov <rdna@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
Fixes: 31fd85816dbe ("bpf: permits narrower load from bpf program context fields")
Signed-off-by: Will Deacon <will@kernel.org>
---

v2: Improve commit message and add Acked-by.

 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fbcf5a4e2fcd..5871aa78d01a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17033,7 +17033,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 					insn_buf[cnt++] = BPF_ALU64_IMM(BPF_RSH,
 									insn->dst_reg,
 									shift);
-				insn_buf[cnt++] = BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
+				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
 								(1ULL << size * 8) - 1);
 			}
 		}
-- 
2.40.1.698.g37aff9b760-goog

