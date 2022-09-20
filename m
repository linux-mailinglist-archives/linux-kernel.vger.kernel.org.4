Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE965BED21
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiITSuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiITSuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:50:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6836111B;
        Tue, 20 Sep 2022 11:50:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id cc5so5946195wrb.6;
        Tue, 20 Sep 2022 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BUW4gOYp/pXvxRdjMx+H4oGpfR74YdeU/jQctJIUObE=;
        b=VgJBCzZSWWvGQX9E9GzjZGOpU4hKxrxrtei/ntzf7fQTpq1XhSpjFZnjmkFwj/gWRb
         sVF0T2vYzVBl2RX+vevLdV0lwQDUqo7ZZpZfRAKX5KCfOGs9cDPue5o+bLLFyuEWAykM
         kaK0X8Wd7Mg8vwjRLWKLEl4QeqG9MPNz97/Pw4NTpSIwY3APQRGIAnpFU2aYVBt58R5L
         o8L+tvojSBRYYbJoTDSXI4iU6KmaUOAp23Zc7ARzris6AKSgO6m2n1rfevcGttjt6Fbe
         o/4TTERQ55AZXFoEwD/RKA4apdIAxGK+4CMsHm6wrkTO3P4pMAMJcHviZ+mXja/i9CbA
         TWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BUW4gOYp/pXvxRdjMx+H4oGpfR74YdeU/jQctJIUObE=;
        b=jrQ20S39DnsqUsAhoPOOkJZvtaNlpeEk+YlkQZSnd6dkWveE3bw8IMuZafWUBPbKO4
         SDDZgj9osx2TLDa2vHZlDN9+U6nG8yDs4bc9mR7JwHrInWuA1US2sZWswY7TD2P2Fcsg
         X4Ftnyx4vCjxzHM97PvHPdicT1OYudxlVt1/Y4FyCHzDXNp3DUdu3nZCMCf2J09j9hi2
         QeHUUaFKvlE/HcDB23UqnNMMy1UmN4ac2J046bmWZy3XzOFuHiDcHWfiQ0zS8FC9vlui
         kUdqHkG86fCeEET+vfwfYefS3saH0ugduc/wYVW0JKjXkilfNQ980KpsomJ47GpqAGqW
         +Vxg==
X-Gm-Message-State: ACrzQf1hq4nBcCb7me8mHDp52T4/V/pWdYHKn2lL5ukQJzu7ZS0FrNrI
        AsUbAGqUDJUkh+iEJpzCYPI=
X-Google-Smtp-Source: AMsMyM53j1tfWe4rRV/yOYx41751jvFLwqQWHbJd13UU1u7cdlpuhMqQE623NK+uLtEX3oHpV2SpBw==
X-Received: by 2002:a05:6000:1a87:b0:22a:56da:9a2b with SMTP id f7-20020a0560001a8700b0022a56da9a2bmr15342036wry.433.1663699813775;
        Tue, 20 Sep 2022 11:50:13 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e9a4:d6c9:505d:20d0])
        by smtp.gmail.com with ESMTPSA id cc4-20020a5d5c04000000b00228de351fc0sm582722wrb.38.2022.09.20.11.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 11:50:13 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 05/10] riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
Date:   Tue, 20 Sep 2022 19:48:59 +0100
Message-Id: <20220920184904.90495-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add ARCH_RENESAS config option to allow selecting the Renesas RISC-V SoCs.
We currently have the newly added RZ/Five (R9A07G043) RISC-V based SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3 -> v4
* Dropped SOC_RENESAS_RZFIVE config option
* Dropped explicitly selecting SOC_BUS/GPIOLIB/PINCTRL configs
  under ARCH_RENESAS
* Updated commit message
* Dropped RB tag
* Used riscv instead of RISC-V in subject line

v2 -> v3
* Included RB tag from Geert

v1 -> v2
* No Change
---
 arch/riscv/Kconfig.socs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 69774bb362d6..5c420ed55ef9 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -80,4 +80,9 @@ config SOC_CANAAN_K210_DTB_SOURCE
 
 endif # SOC_CANAAN
 
+config ARCH_RENESAS
+	bool "Renesas RISC-V SoCs"
+	help
+	  This enables support for the RISC-V based Renesas SoCs.
+
 endmenu # "SoC selection"
-- 
2.25.1

