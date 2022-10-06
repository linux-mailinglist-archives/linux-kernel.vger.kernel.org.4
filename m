Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D015F617C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiJFHOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiJFHOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:14:11 -0400
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Oct 2022 00:14:08 PDT
Received: from forward104j.mail.yandex.net (forward104j.mail.yandex.net [5.45.198.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBB750717
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:14:07 -0700 (PDT)
Received: from iva6-2d18925256a6.qloud-c.yandex.net (iva6-2d18925256a6.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:7594:0:640:2d18:9252])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id A67862F9A67A;
        Thu,  6 Oct 2022 10:03:00 +0300 (MSK)
Received: by iva6-2d18925256a6.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id yYZDPb1P4X-2vi0vajV;
        Thu, 06 Oct 2022 10:02:59 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1665039779;
        bh=5RTtbpB9MqKeuFtwCR+bpAvBlgufCwcN1kH3vcMsM+o=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=Ifrc/9hW4yrF4ki1RLIQujMFhYr0zxD7vN1d29GeqSFVmpauj+mKQsaWpLAAm6pWB
         cij52U+cowo8cWFmWfkEl8+FwywXqJM5smUFfbFIQ8nAOcbiuDpBpS/SumP8MGFY0i
         9kFhx2S/AzngcEJwgx4CguPKkYY99ipKxUgxWCOU=
Authentication-Results: iva6-2d18925256a6.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>, linux@yadro.com,
        Nikita Shubin <n.shubin@yadro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: fix multi-letter extension compare
Date:   Thu,  6 Oct 2022 10:02:56 +0300
Message-Id: <20221006070257.11632-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <n.shubin@yadro.com>

Increment ext pointer to match letters after 'z' character, so it points
to actual extension name.

Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
Hello Atish,

Sorry to blame you, but i double checked this and i don't see a way 
how extensions from device tree could be successfully matched with 
encoded ones without incrementing the ext pointer or prepending 
the encoded extensions with 'z' letter.

I have no idea how this could slip through review - am i missing something ?
---
 arch/riscv/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3b5583db9d80..031546052dc0 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -199,6 +199,7 @@ void __init riscv_fill_hwcap(void)
 				this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
 				set_bit(*ext - 'a', this_isa);
 			} else {
+				ext++;
 				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
 				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
 				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
-- 
2.35.1

