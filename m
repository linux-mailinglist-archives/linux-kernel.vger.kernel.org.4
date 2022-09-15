Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC865BA0C1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiIOSSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiIOSRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:17:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F8B9F76F;
        Thu, 15 Sep 2022 11:17:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n10so1523776wrw.12;
        Thu, 15 Sep 2022 11:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xzoqzDtndDkISsSwTujowyDPoGXKL8jqH4hdlXLXrA0=;
        b=g5ulsbtE6DartTUDwK1K53pxs737iOAFvah1Hi8jK5pmVKn8KAVEf6OvssWURbZdFo
         dOSWToLwlaQwdJ18U4d1RedSFWSgxN+7k0AN5OqBda/cevb25gOLuTuI4LLibl9keWto
         N4Q825SAEdoOvDk6rXAoR/pJs7twaguzQCwGvopOeL3C4STOtA0O7SZgrNRYy1wyTxRZ
         9jvDY4BZL8Srqk7Y+0B8Gc61zSI9T8yYmC2DmzFDp33WvqFBWINF5x4NaI7ujWuZuoTk
         DlNo+uDiS/xJUShEyQUfQ0UwDltURs02MR4sa1gaqN6zbcRSatsrYEFTxBqxt7dBSZ4p
         ay3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xzoqzDtndDkISsSwTujowyDPoGXKL8jqH4hdlXLXrA0=;
        b=GKPuEmJ7jarW93RFlCuEp4Zld5Gey5ggZ7KxLAa6TIbtdhOiW/nlpBAkpPR3KXeuwa
         ikgLrjHTwdm6dWMqC28pkOpbKUkN6gTA5yMnTUK6wZeXtyK0TdKTGSYighwWwb4N6pgX
         p8dOWf3ku1j306Hw1X7GYI0LsigOSSEfad9+DjpUj4ffoJV0Y9Mz1QTtgXCtB2bsSppe
         M8LNRWJQFDCFe+GAyyZ/fHhNyMWhPFwHjabDCf6Uu/RGnRrTNUf0d9od5kPg5hVlW/l+
         FZPitbH0WhUZo8p0KWT7j7ixUux38BeANgcE09UWKBOV7Oe4S799XDfcK3DRLyb7FeSN
         75uw==
X-Gm-Message-State: ACrzQf3wvL0zA8XdiWNBUpuxUSnKOyPQzB2qJlbEuPV9eM6u6PUTuySL
        072nAEl3CP8mKQO0SaIbGToOyezcXG8YJQ==
X-Google-Smtp-Source: AMsMyM7tjqwmJxX5D4dBi01RrRk+6JKiqTi1egw5XeegPGl6fRnFXsEXlXXpxAL3CklC75qxxfrBMg==
X-Received: by 2002:a05:6000:384:b0:22a:5d05:c562 with SMTP id u4-20020a056000038400b0022a5d05c562mr579729wrf.701.1663265861500;
        Thu, 15 Sep 2022 11:17:41 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d411:a48b:4035:3d98])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b47e8a5d22sm4243151wmq.23.2022.09.15.11.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 11:17:40 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 10/10] RISC-V: configs: defconfig: Enable Renesas RZ/Five SoC
Date:   Thu, 15 Sep 2022 19:15:58 +0100
Message-Id: <20220915181558.354737-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Enable Renesas RZ/Five SoC config in defconfig. It allows the default
upstream kernel to boot on RZ/Five SMARC EVK board.

Alongside enable SERIAL_SH_SCI config so that the serial driver used by
RZ/Five SoC is built-in.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3
* Included RB tags
* Updated commit description

v1->v2
* New patch
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 05fd5fcf24f9..3dd9aa4d707d 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -26,6 +26,7 @@ CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
 CONFIG_PROFILING=y
 CONFIG_SOC_MICROCHIP_POLARFIRE=y
+CONFIG_SOC_RENESAS_RZFIVE=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_STARFIVE=y
 CONFIG_SOC_VIRT=y
@@ -123,6 +124,7 @@ CONFIG_INPUT_MOUSEDEV=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_SH_SCI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
-- 
2.25.1

