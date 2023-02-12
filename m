Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8188B693A0B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 21:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBLUzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 15:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBLUzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 15:55:10 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71A4F75E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:55:09 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id i5so2619692qvp.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQdHW+PhZq9WcInZ2+SoRq4atvNxsCBkR2bKm9EuIOs=;
        b=GkttBvPlAObOivWdQ0mXQJnKbbGtSDX0YG4FGKozO5eqFdmh2+9C3DSiMsnK6F5Xma
         /sa+Usls+PdZKAGCKeHzxJUlUh641FtZ7jrtlshH3zNja8o4XZ35goIqz9nJ9JrfczET
         Sp2MzSAOi5Mx6KSt//w+0/74AbweY6E+c9Taqz50P52EQihVyktFL1MXjMFP/rNIrc4R
         nzqVh+NAo/xMF0zWYjH++GsLAVPBM1ER3CUCgcmRV3DjeIq2erLqdlbhfF9jpK/jbmlX
         0g2tp0S0Eexk0yqkBqaKx1s3/qEqGch0MMvQycUlGZcl4r5wnJMFTnSaag2Gx+39JGek
         t7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQdHW+PhZq9WcInZ2+SoRq4atvNxsCBkR2bKm9EuIOs=;
        b=lLV/jb4TtnwM6Vfi1qcCiUCE6Fo08gnQAfhjJz+28PuYW3KnyWARVr9cY+/FHy6DX/
         r39llzHPmeOsUgqbTbhYtS+dBPWeCABQ0fYuxaZLMuoKy8hoPvb7U3MPU6nM7ZfPclUz
         XTWH9jsurBaZRzpWDweRDHEpK2Ub4xmRRkDvWv7avG4ASq5wGeDkqDAWfMFLvoeRygn2
         lxCqMV7g/BN7dVlVNJ5goz/wxXaxHKNuMsNdK3T47rbTkfYIV/z/hqGf7Cv2cpNNOAAI
         tEA1lnN7Jd2v+6U7XpsRskBizLTEqIOpeyO9jfUn5u+/9nY3TYw10laNaDBTTQThPuDK
         4/Aw==
X-Gm-Message-State: AO0yUKVl8YLIMSwme4bdLO117+61mlo97lAKvTn+EzkRJFYYNtont+/5
        P3raVn5WzuExj80kQ7SWAYk=
X-Google-Smtp-Source: AK7set/7PO+QFexTHSQTgL0s0TsPzpuVBx6+y8AuSbEd+yCd227mmBNu++ZlMRl7YxkXXkgXnheaiQ==
X-Received: by 2002:a05:6214:e61:b0:56b:ec1f:db0d with SMTP id jz1-20020a0562140e6100b0056bec1fdb0dmr33894218qvb.34.1676235308881;
        Sun, 12 Feb 2023 12:55:08 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id o62-20020a374141000000b0072ad54e36b2sm8289233qka.93.2023.02.12.12.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 12:55:08 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Yimin Gu <ustcymgu@gmail.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/3] clk: k210: remove an implicit 64-bit division
Date:   Sun, 12 Feb 2023 15:55:04 -0500
Message-Id: <20230212205506.1992714-2-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230212205506.1992714-1-Mr.Bossman075@gmail.com>
References: <20230212205506.1992714-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The K210 clock driver depends on SOC_CANAAN, which is only selectable
when !MMU on RISC-V. !MMU is not possible on 32-bit yet, but patches
have been sent for its enabling. The kernel test robot reported this
implicit 64-bit division there.

Replace the implicit division with an explicit one.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-riscv/202301201538.zNlqgE4L-lkp@intel.com/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 drivers/clk/clk-k210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-k210.c b/drivers/clk/clk-k210.c
index 67a7cb3503c3..4eed667eddaf 100644
--- a/drivers/clk/clk-k210.c
+++ b/drivers/clk/clk-k210.c
@@ -495,7 +495,7 @@ static unsigned long k210_pll_get_rate(struct clk_hw *hw,
 	f = FIELD_GET(K210_PLL_CLKF, reg) + 1;
 	od = FIELD_GET(K210_PLL_CLKOD, reg) + 1;
 
-	return (u64)parent_rate * f / (r * od);
+	return div_u64((u64)parent_rate * f, r * od);
 }
 
 static const struct clk_ops k210_pll_ops = {
-- 
2.39.0

