Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2AC74120B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjF1NPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjF1NPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:15:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E612E1705
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:15:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-313f59cd193so3095269f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687958101; x=1690550101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiOwfD1HiScotDrS0+RvYK350JHm5UF5oC2oX5fkmHM=;
        b=BDTo0rbe+6rcs0uhompPuUaW/LK5jt5dsFb4IAViNeq3lX26AlV2LVxIfMOUAdPYHd
         ra73W2Cz4ub2oGGS6jzM5kh+oZAW2WNCMH7yiWCZTTm/IOHKByKDGKcDK6ajqHBaSqnp
         CcNWFIAl8mL89yI0Fqi60WZD952bP8C7vIB+M5tRgQ6s2+HPnuIa1jGxCo/gMWPqtBG7
         0tMT0T/zWX6SNFN11UN8eq/lXB/ZOkvFWxpJEBiaXjV84HpcWhRydve2tc5P0IMEGn9+
         KuO6ZcuTp6HX/GLG2h4zRlduXPVdYODbifB+SJr9yu7mGte8T7RWz1R6z6+HVILRP79M
         bJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687958101; x=1690550101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiOwfD1HiScotDrS0+RvYK350JHm5UF5oC2oX5fkmHM=;
        b=UWhAlq56pbhUcLPYo/CeCVVaOcghDJUy6xkpC/gq7NKdLD7zF1oqIAnmSw//2bkXL0
         szuM2A8J7xEEWREQDFxdOgONyIpQ9VKmRahgQ7Z60UlqRky+KFIBnn3mjXnkx+R28Q/I
         Earu4/gslD9fznxeca3UiuFut1JN/3dqQ2S1r8x6Dpz34DP8CCY2hf1oULxhA8HyidT/
         llsKZqm42BK9SLSLU+49jM8dvyTjh60s4dkc5ubtKdF+IGjfWasfpO9CSltAifDrDUKr
         nlETZaEPd4FZ3/Do7Ri7AL4v95S+Ty6UceDIYnWjh0VsbxKIthT4CNVzn+3Nzz9IlmZP
         pd2w==
X-Gm-Message-State: ABy/qLa/Z+M2RlTTGovt7rv8sM24rJFtep7mZtVsOfTwPP99JjFE0cnE
        5PNM/UVOQHT2SrPy0KEIURCPGw==
X-Google-Smtp-Source: APBJJlG+CGn8+DU+v1W/iZTw6jKOuGJ01cLEwQruaWipRxUi9lTpmmW5gVywc1eo3n4enWMSolF2QQ==
X-Received: by 2002:adf:f3c4:0:b0:314:1096:ed2f with SMTP id g4-20020adff3c4000000b003141096ed2fmr746609wrp.35.1687958100853;
        Wed, 28 Jun 2023 06:15:00 -0700 (PDT)
Received: from vermeer.tail79c99.ts.net ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id a11-20020a056000050b00b003110dc7f408sm13456946wrf.41.2023.06.28.06.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:15:00 -0700 (PDT)
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     "Hongren (Zenithal) Zheng" <i@zenithal.me>, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Evan Green <evan@rivosinc.com>,
        Jiatai He <jiatai2021@iscas.ac.cn>
Subject: [PATCH v2 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Date:   Wed, 28 Jun 2023 15:14:33 +0200
Message-ID: <20230628131442.3022772-2-sameo@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628131442.3022772-1-sameo@rivosinc.com>
References: <20230628131442.3022772-1-sameo@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Hongren (Zenithal) Zheng" <i@zenithal.me>

Parse Zb/Zk related string from DT and output them to cpuinfo.

It is worth noting that the Scalar Crypto extension defines "zk" as a
shorthand for the Zkn, Zkr and Zkt extensions. Since the Zkn one also
implies the Zbkb, Zbkc and Zbkx extensions, simply passing the valid
"zk" extension name through a DT will enable all of the  Zbkb, Zbkc,
Zbkx, Zkn, Zkr and Zkt extensions.

Also, since there currently is no mechanism to merge all enabled
extensions, the generated cpuinfo output could be relatively large.
For example, setting the "riscv,isa" DT property to "rv64imafdc_zk_zks"
will generate the following cpuinfo output:
"rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed_zksh_zkt".

Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
---
 arch/riscv/include/asm/hwcap.h | 11 +++++++++++
 arch/riscv/kernel/cpu.c        | 11 +++++++++++
 arch/riscv/kernel/cpufeature.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index f041bfa7f6a0..b80ca6e77088 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -53,6 +53,17 @@
 #define RISCV_ISA_EXT_ZICSR		40
 #define RISCV_ISA_EXT_ZIFENCEI		41
 #define RISCV_ISA_EXT_ZIHPM		42
+#define RISCV_ISA_EXT_ZBC		43
+#define RISCV_ISA_EXT_ZBKB		44
+#define RISCV_ISA_EXT_ZBKC		45
+#define RISCV_ISA_EXT_ZBKX		46
+#define RISCV_ISA_EXT_ZKND		47
+#define RISCV_ISA_EXT_ZKNE		48
+#define RISCV_ISA_EXT_ZKNH		49
+#define RISCV_ISA_EXT_ZKR		50
+#define RISCV_ISA_EXT_ZKSED		51
+#define RISCV_ISA_EXT_ZKSH		52
+#define RISCV_ISA_EXT_ZKT		53
 
 #define RISCV_ISA_EXT_MAX		64
 #define RISCV_ISA_EXT_NAME_LEN_MAX	32
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index a2fc952318e9..10524322a4c0 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -215,7 +215,18 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
+	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
+	__RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
+	__RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
+	__RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
 	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
+	__RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
+	__RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
+	__RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
+	__RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
+	__RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
+	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
+	__RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index bdcf460ea53d..9a872a2007a5 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -309,10 +309,40 @@ void __init riscv_fill_hwcap(void)
 				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
 				SET_ISA_EXT_MAP("zba", RISCV_ISA_EXT_ZBA);
 				SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB);
+				SET_ISA_EXT_MAP("zbc", RISCV_ISA_EXT_ZBC);
+				SET_ISA_EXT_MAP("zbkb", RISCV_ISA_EXT_ZBKB);
+				SET_ISA_EXT_MAP("zbkc", RISCV_ISA_EXT_ZBKC);
+				SET_ISA_EXT_MAP("zbkx", RISCV_ISA_EXT_ZBKX);
 				SET_ISA_EXT_MAP("zbs", RISCV_ISA_EXT_ZBS);
 				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
 				SET_ISA_EXT_MAP("zicboz", RISCV_ISA_EXT_ZICBOZ);
 				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
+				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKB);
+				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKC);
+				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKX);
+				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKND);
+				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKNE);
+				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKNH);
+				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKR);
+				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKT);
+				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKB);
+				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKC);
+				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKX);
+				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKND);
+				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKNE);
+				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKNH);
+				SET_ISA_EXT_MAP("zknd", RISCV_ISA_EXT_ZKND);
+				SET_ISA_EXT_MAP("zkne", RISCV_ISA_EXT_ZKNE);
+				SET_ISA_EXT_MAP("zknh", RISCV_ISA_EXT_ZKNH);
+				SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKB);
+				SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKC);
+				SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKX);
+				SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZKSED);
+				SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZKSH);
+				SET_ISA_EXT_MAP("zksed", RISCV_ISA_EXT_ZKSED);
+				SET_ISA_EXT_MAP("zksh", RISCV_ISA_EXT_ZKSH);
+				SET_ISA_EXT_MAP("zkr", RISCV_ISA_EXT_ZKR);
+				SET_ISA_EXT_MAP("zkt", RISCV_ISA_EXT_ZKT);
 			}
 #undef SET_ISA_EXT_MAP
 		}
-- 
2.41.0

