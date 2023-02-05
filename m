Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA77868ADD5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 02:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjBEBPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 20:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjBEBP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 20:15:28 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E056F25BB0
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 17:15:27 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so12204086pjq.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 17:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bL1w5YmH06Uag3nFKBzVH+Q8AGlHge+37YxFY5KSNeQ=;
        b=2KeB1jxYPaCLPXLkMP5mt6zfi1XGL9R1LKG36JlfXA9sVgGLJ3oSGg7U0iBnoTF9SN
         W9ugtfrjJObjFzbd2okc8e504/jTXoldkYd+zyNbyuOfEpFwLC9O2IaNDduH0KbYS7rQ
         8ehshYLN9x+NL7+tVh8D47adAOcUPpcGcQiLmliBx7L9YFoav6/hGfEVZ2Ty7fMU0pNA
         u4dEzkas+DxaeMrHMCNZpVMGOdk2k7Q3Pnp4ehpOlS5HkZAUx3EWXDImbAXdh63UXiOw
         PTBJfy/MDkagjRDhImgyXX7SeeCkQtXwoPMOGSa4g7dD2yJtl1wFmRw682Zh1ze4scsl
         keaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bL1w5YmH06Uag3nFKBzVH+Q8AGlHge+37YxFY5KSNeQ=;
        b=WEDu8kJkiUAao3TTVNWV/hFerXEykUh8KVJR0MgQ0lQhfrKzw8bQaXYfnkRs14YPxs
         adzQPlTDTjDuQ/s+DKvs6y3e6VV/HiSmqVVUwuAZXZSmsDETkYFNpvb98GZdGAyDKp4n
         0Hq6U3N/3GcG56Xxy6I5TZAq/1IbXPp4k3NaWJvmJxG629WUsSlTTHE/UTonFAT0WddJ
         eapyYTZ9xzBD1LvuNi/5fwgiO+c0z+8E6tMOXReEVjnQNjp5WExDCQr1IXhI+hL+sYDr
         ykCiyYot6iekpCHdzy+jWM8qZSevyHd1n5yX0bfu0ZxwyBJl8KReTVPe6k5q+mfPW+yO
         MazQ==
X-Gm-Message-State: AO0yUKWGcpvz7PTIlONnj54MdPE0snK23W7f5vLQF+ZQjnpP34o3ErG/
        O6few2hmm8m8Ku+L0YQkFS1OpUT51VvQO/4f
X-Google-Smtp-Source: AK7set8tuY6it1dMb43/djmw1KLyJfznVzK0z5PWcllP0Qw81NpzHFtxnsPU+VM3CZRIHzx0rnWs/g==
X-Received: by 2002:a17:90b:1a8e:b0:230:2b29:aa66 with SMTP id ng14-20020a17090b1a8e00b002302b29aa66mr16102301pjb.36.1675559727248;
        Sat, 04 Feb 2023 17:15:27 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090a020700b0023080c4c3bcsm2721917pjc.31.2023.02.04.17.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 17:15:26 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v5 05/14] RISC-V: KVM: Return correct code for hsm stop function
Date:   Sat,  4 Feb 2023 17:15:06 -0800
Message-Id: <20230205011515.1284674-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230205011515.1284674-1-atishp@rivosinc.com>
References: <20230205011515.1284674-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the SBI specification, the stop function can only
return error code SBI_ERR_FAILED. However, currently it returns
-EINVAL which will be mapped SBI_ERR_INVALID_PARAM.

Return an linux error code that maps to SBI_ERR_FAILED i.e doesn't map
to any other SBI error code. While EACCES is not the best error code
to describe the situation, it is close enough and will be replaced
with SBI error codes directly anyways.

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_sbi_hsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.c
index 2e915ca..619ac0f 100644
--- a/arch/riscv/kvm/vcpu_sbi_hsm.c
+++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
@@ -42,7 +42,7 @@ static int kvm_sbi_hsm_vcpu_start(struct kvm_vcpu *vcpu)
 static int kvm_sbi_hsm_vcpu_stop(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.power_off)
-		return -EINVAL;
+		return -EACCES;
 
 	kvm_riscv_vcpu_power_off(vcpu);
 
-- 
2.25.1

