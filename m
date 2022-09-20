Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B345BED2A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiITSvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiITSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:50:21 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FED5FF48;
        Tue, 20 Sep 2022 11:50:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id cc5so5946806wrb.6;
        Tue, 20 Sep 2022 11:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EEV/bZNm0RhZpoNYETeZ7CWJmucOPEtVXdZB85ADqWM=;
        b=bnft1V8oxBH9jXg4qda8t6dZSmf3Iwfcf+cHXLuM06OoIfCrqXbnj2j2ZxXuYaMCN0
         HqQ1l32q3nOwCIB4iqZxGpQk/6w2MikdnoAjXvVTbFxCF/OvWyLJYNQ9fjWRWFbgrHjI
         xVvx5aIKwLAn2jVdc9QltHkTcpmM42+czBY79snokGd1jOFXHSoskFNA4++EA7tu4XVA
         3pQV06QRScJRRbclUxb2TbWcacmLfKD7VdnYB4gb/3Eio3JspcJykB1Hd5uZyihrMerq
         sSAjx8DbO6s6IibB39aL8NqWkCl5Q4UXMspkh0CnnbVr6s4iDJH1ZCeTDod7i4mM5O18
         m8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EEV/bZNm0RhZpoNYETeZ7CWJmucOPEtVXdZB85ADqWM=;
        b=Lj2Scf1oRMhVB4nHVH8p9nH8rz6LU+IWVkmJBxpIK3DJwYkwHuNbEnCNTiPYWu/yj3
         Q7DlZvSHlhbu2zsb5IvCi7sPJt7OQlJVK3YLqKEyEATtdt3SlVwWxRaQ31r7+pv2nUxm
         Vn9d4C48dkwmMl9RinJfU0vvV5BbRcdcXd6mQOrADfwzV4KJkAtTmQaMol5NtUauTNMh
         TR2IbB2TJ/0PsnalikApzv/sI2V0c3zqt9GAl7sAFXUMmtItZv+U3r6cnr5+Lly3CxuL
         /EbaxKNmigwW+Bt5x3EInJ0m4P8jlNz0iU5leRk2c1zgCm8zF/DNXjSV23l7sCqZCD1V
         kSSg==
X-Gm-Message-State: ACrzQf0oHTiO0mQATHGWhr1Z2hgqWnpXrMZwyi+pVHwxowaXO6Sc/O5q
        kKFzIeJ/AlKrnOBF+hT620k=
X-Google-Smtp-Source: AMsMyM65TgOSIr0ZfIgpLuog36rH44C9YuoCn+Yv9Tji2ryknGj6fK849OJKw3aT9oqGug0pAtWW/g==
X-Received: by 2002:adf:f8ca:0:b0:226:e456:1896 with SMTP id f10-20020adff8ca000000b00226e4561896mr15181753wrq.177.1663699819115;
        Tue, 20 Sep 2022 11:50:19 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e9a4:d6c9:505d:20d0])
        by smtp.gmail.com with ESMTPSA id cc4-20020a5d5c04000000b00228de351fc0sm582722wrb.38.2022.09.20.11.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 11:50:18 -0700 (PDT)
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
Subject: [PATCH v4 10/10] riscv: configs: defconfig: Enable Renesas RZ/Five SoC
Date:   Tue, 20 Sep 2022 19:49:04 +0100
Message-Id: <20220920184904.90495-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Enable Renesas RZ/Five SoC config in defconfig. It allows the default
upstream kernel to boot on RZ/Five SMARC EVK board.

Alongside enable SERIAL_SH_SCI config so that the serial driver used by
RZ/Five SoC is built-in.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3 -> v4
* Explicitly enabled ARCH_R9A07G043 config (note I have restored the RB
  tags with this change)
* Used riscv instead of RISC-V in subject line

v2 -> v3
* Included RB tags
* Updated commit description

v1 -> v2
* New patch
---
 arch/riscv/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 05fd5fcf24f9..97fba7884d7a 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -29,6 +29,8 @@ CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_STARFIVE=y
 CONFIG_SOC_VIRT=y
+CONFIG_ARCH_RENESAS=y
+CONFIG_ARCH_R9A07G043=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PM=y
@@ -123,6 +125,7 @@ CONFIG_INPUT_MOUSEDEV=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_SH_SCI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
-- 
2.25.1

