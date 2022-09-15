Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DF15BA191
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 21:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiIOTly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 15:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiIOTlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 15:41:24 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB439F75B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 12:38:17 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id r20so13725011qtn.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zpt9GCRbl8GSu+mNKxtCSxN/ut26bIT0MJANl4282eY=;
        b=3dVH8/YoiU0dPRG8tjjiauIameUd3EPLECdbMuaVAgYEeXgQqnkOWsfagAVQj4AyhE
         rYDwsvzV8Anf9tgVloy2RgFUI8qZHyJxKyKeESW9yc9Ud+AzAuvo4N8MnGjaops3ajsK
         lkR9nQ1iz+2cWO6g49vHE0hJjzduH94Gni1CbaKzWXGPhGn+PyeLPw5KecGYJZGqvfmR
         HlnUCYFrrY7x0NIpiHg6H4mXck0En0bXbhNMDnkT/2pSkphAQ8ChMha+nK2l92MIW0E/
         agPr54IRRiHhKHgWkiB6uJ0fGrgrFuYVWngrJTCctsLAkCNXUsh4t+4Xm0QY6i+cO3/e
         WcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zpt9GCRbl8GSu+mNKxtCSxN/ut26bIT0MJANl4282eY=;
        b=QOgJoUTMMdcL8fcCb4rZqcHnf/J+IppNDdEQN6rpsNqh5IzIZh/Yku9+gTmRKj2Rae
         KTGGF2jLWF6cQJao4wJ1jVhQn3Yv/y0Gyhj7uvv/gNG2fgl9BS4WwIGi8AUKINvzXAHt
         oieswT9TdPBSdSplolOm4sWwrcJAeF3QEAd8LH3zXRLzbrHdvjdNLxx1E6niTeNrbEvc
         ABFo6C6eSF4vKlN8b/GzjqbEAOUPfm+uUIyME2ASrmLUun6XTCi3ydF8B4ANXr40/UcW
         0BQq/RBdy7JFGJbFX/lhNGPniY1rmQwWQaQpT64ttubF2CZ87dPfyjYNNm31g8FwGb6+
         JXcA==
X-Gm-Message-State: ACrzQf3lrOYLInjyqo40HzXDKRJGwUBQxMRrhmAvQRXnPvpdVTdnrFL7
        svXy0vWUPT/BOqNdGu6C1aFr/g==
X-Google-Smtp-Source: AMsMyM4c71Uqf0BRj1ggV8j8fTpOR+nYbBIzPF9iB2m0Ng7RmJeprdOZ115YIqybBqbxLXqHItL9uQ==
X-Received: by 2002:a05:622a:296:b0:35c:c846:d714 with SMTP id z22-20020a05622a029600b0035cc846d714mr1430238qtw.58.1663270636969;
        Thu, 15 Sep 2022 12:37:16 -0700 (PDT)
Received: from abrestic-xps.ba.rivosinc.com (pool-71-105-112-35.nycmny.fios.verizon.net. [71.105.112.35])
        by smtp.gmail.com with ESMTPSA id r1-20020ae9d601000000b006b872b606b1sm4596459qkk.128.2022.09.15.12.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 12:37:16 -0700 (PDT)
From:   Andrew Bresticker <abrestic@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        dram <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        Conor.Dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@rivosinc.com>,
        stable@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4 2/2] riscv: Allow PROT_WRITE-only mmap()
Date:   Thu, 15 Sep 2022 15:37:02 -0400
Message-Id: <20220915193702.2201018-3-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915193702.2201018-1-abrestic@rivosinc.com>
References: <20220915193702.2201018-1-abrestic@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is
invalid") made mmap() return EINVAL if PROT_WRITE was set wihtout
PROT_READ with the justification that a write-only PTE is considered a
reserved PTE permission bit pattern in the privileged spec. This check
is unnecessary since we let VM_WRITE imply VM_READ on RISC-V, and it is
inconsistent with other architectures that don't support write-only PTEs,
creating a potential software portability issue. Just remove the check
altogether and let PROT_WRITE imply PROT_READ as is the case on other
architectures.

Note that this also allows PROT_WRITE|PROT_EXEC mappings which were
disallowed prior to the aforementioned commit; PROT_READ is implied in
such mappings as well.

Fixes: 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is invalid")
Cc: <stable@vger.kernel.org> # v4.19+
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
---
v1 -> v2: Update access_error() to account for write-implies-read
v2 -> v3: Separate into two commits
---
 arch/riscv/kernel/sys_riscv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 571556bb9261..5d3f2fbeb33c 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -18,9 +18,6 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
 		return -EINVAL;
 
-	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
-		return -EINVAL;
-
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
 			       offset >> (PAGE_SHIFT - page_shift_offset));
 }
-- 
2.25.1

