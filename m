Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31922629669
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbiKOKxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbiKOKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:52:28 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D0227158;
        Tue, 15 Nov 2022 02:51:49 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id z14so23409926wrn.7;
        Tue, 15 Nov 2022 02:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMziarFdlN574Jm70LJY3GIW1tVMw3fEoLjKN4Ko0Oc=;
        b=iWfyr4RRlzz7gtM2f3lxzyJ0A2fkcZqWxfJTIgcHWcKD2Pt3dJzEAmXmAqPet31f/e
         N+XvhPvm4tIErNw5FpkQHrdZ7lIchD1uLmZ2hO7qBitjU8xS1aaQZ5PD4xmsvwmgvrkX
         yclgrNPkhQzC3fWUl4G40vtNyydWTzBFQkKfkO51qvBq/ko5JE58t2uZ984GuzgM56gz
         7elKAuvq3aXxZan0INxWrEHKNCA4Gq+L/wMysSkEmpWPiAuVWpPg4QYPdfmmJK1MEEJX
         k89sLyB+8jZjewJX8vqqmZ0FI+QHNcpJyXslh/u/I9aWpMVALNdUAB15BHVUxaiqCrTQ
         BY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMziarFdlN574Jm70LJY3GIW1tVMw3fEoLjKN4Ko0Oc=;
        b=E0GNEJL9BqmitiZ5IvzHX2bzZfZuYqrD8XHc7vSdDoroKW5WqEoAfTMgab/dPIrcu6
         Nsfli4D83rupATpABU1G3I/ZEoj37AA94RE+yoVvaAokiqwdR5UvDGZDx4698RL3Ex9o
         HuAdbHfAmJeTH1qI0o00HpuZGeBtcezJ+gGMhjbxMCDBBVg9nDt8t6zhvaaXXSN8Tspc
         048Gh3ORbxUHIvADt+6yNhtenrnveVlYiMTxtKlBB7xzJCgoF49wIzpzuhd/eqFI+I18
         fjxySUhaOXxiD9AolaMLO2TUZqicjVdGOLF0ErJ6V3DI288kjmQowa7QbBoIZWBQoXQh
         4vvw==
X-Gm-Message-State: ANoB5pm/juZnqoATHuwpitM8tEB2AActqjLiWt806MR8Tydchok8vTwX
        mjpmXj/wI7yZKSoNYgdebLE=
X-Google-Smtp-Source: AA0mqf5h6L8q2mgB1tbE2qf/spcjGpsvY9nzROH2iRGJbdCcquCPox+0ghQbVmMbcVrwNgeabhV7/w==
X-Received: by 2002:adf:f008:0:b0:241:9cb9:d473 with SMTP id j8-20020adff008000000b002419cb9d473mr1141026wro.59.1668509508120;
        Tue, 15 Nov 2022 02:51:48 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:d94a:6345:c378:e255])
        by smtp.gmail.com with ESMTPSA id az9-20020adfe189000000b002367ad808a9sm12210528wrb.30.2022.11.15.02.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:51:47 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/3] riscv: Kconfig: Enable cpufreq kconfig menu
Date:   Tue, 15 Nov 2022 10:51:33 +0000
Message-Id: <20221115105135.1180490-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Enable cpufreq kconfig menu for RISC-V.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa78595a6089..ce905454a3bf 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -691,6 +691,8 @@ menu "CPU Power Management"
 
 source "drivers/cpuidle/Kconfig"
 
+source "drivers/cpufreq/Kconfig"
+
 endmenu # "CPU Power Management"
 
 source "arch/riscv/kvm/Kconfig"
-- 
2.25.1

