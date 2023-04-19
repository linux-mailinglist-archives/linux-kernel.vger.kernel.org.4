Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3566E7842
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjDSLML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjDSLLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:11:22 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26D113FBF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a682eee3baso19075985ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902638; x=1684494638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4LpILR7uuc84V0nBeCkFyyltCgxgJA346GsW698exo=;
        b=t7Dv+2N+QyIlF3rBqJ4Yw+dboRf/N5xEHL2v5J6yE8SzdkFIHKT+ft3xzMqnOvvWtG
         c73fE87KpwIAcE94sAtSve8nl4GaovkVh6Fn6Jc1trDM09dLWJtNDjrtNeeuNW43fLDq
         4m51S9CKnzl0sMFYrEj7vzX2NwMCb50ZlvH26tOiItQ+Tcn2IJHg07eABhYBUNS/y0nj
         CJmXX3IjPKbMDGd+Wzd00nqNjBqs5zER84mmVHtQtveHb2wbk2U7Bs6lorj4N4OtdvXE
         izAooKlxyqE6K+IQdYgVU6POxvNISn+BRm1HTHKsOPAbta521PPxg8Ucog3XZMuI/yrr
         cOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902638; x=1684494638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4LpILR7uuc84V0nBeCkFyyltCgxgJA346GsW698exo=;
        b=PilCoUAfUR/h1pmrF9O0JLLGFJRR3Z7SVV9B4adpDxJOnsnm7qeFSzVacEsBWd+lEq
         dvW5bWxa24zfav35vAWg4j4FpbiHbGow4gojZskyZYZmKClD0gYG8MQPlJ3zW4jCjQL4
         TPf2gEl/IRn4llU3yns8aP/vvDreHUeUtt2vhhqFG9E/22x4mGMtFYlAgFTJfFapW8El
         hbIoKHJJciL2ECSQIXKsmfbWiYRTjqN+16LBSsQPHuGzTtPz5mCIt8vvQU1vw1eH4yag
         5oEJIhm+x6nX4L0m377YuAHn1AiM6KSj4IhkNbbHBUu/fLPUuid/tAQ5nFa1HF21PqlX
         zrGg==
X-Gm-Message-State: AAQBX9fOGqKtznrBfyLx92fDS8acBLHWlfQVXARghTgIfVyoNvNcecNF
        vb0jW5XFJoLwB9+IVwFi2Vt0uw==
X-Google-Smtp-Source: AKy350blBgJTgWuZgwD/ElBAI6xPXER2rPw+XTMHx0qcnAQYuIXvYmMpwQt5BTkTII5ML0gDgkFSGQ==
X-Received: by 2002:a17:902:f70f:b0:1a1:aa68:7e61 with SMTP id h15-20020a170902f70f00b001a1aa687e61mr5676956plo.33.1681902638229;
        Wed, 19 Apr 2023 04:10:38 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:37 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ved Shanbhogue <ved@rivosinc.com>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Peter Newman <peternewman@google.com>, x86@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [RFC PATCH 20/21] DO_NOT_MERGE riscv: dts: qemu: add cbqri-capable controllers
Date:   Wed, 19 Apr 2023 04:11:10 -0700
Message-Id: <20230419111111.477118-21-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419111111.477118-1-dfustini@baylibre.com>
References: <20230419111111.477118-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes to for CBQRI-capable cache and memory controllers.

This is necessary as the qemu branch riscv-cbqri-rfc (based on
v8.0.0-rc4) does not yet support generating a dtb with the nodes and
properties needed for CBQRI controllers.

Thus, an external dtb (qemu-virt-cbqri.dtb) built by Linux is used when
invoking qemu-system-riscv64:

  qemu-system-riscv64 \
    -M virt \
    -nographic \
    -smp 8 \
    -bios output/images/fw_jump.elf \
    -kernel ${LINUX}/arch/riscv/boot/Image \
    -dtb ${LINUX}/arch/riscv/boot/dts/qemu/qemu-virt-cbqri.dtb \
    -append "root=/dev/vda ro" \
    -drive file=output/images/rootfs.ext2,format=raw,id=hd0 \
    -device virtio-blk-device,drive=hd0 \

Link: https://gitlab.baylibre.com/baylibre/qemu/-/tree/riscv-cbqri-rfc
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/qemu/qemu-virt-cbqri.dts | 59 ++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/riscv/boot/dts/qemu/qemu-virt-cbqri.dts b/arch/riscv/boot/dts/qemu/qemu-virt-cbqri.dts
index 400ed48a06af..2c4ddc4271cc 100644
--- a/arch/riscv/boot/dts/qemu/qemu-virt-cbqri.dts
+++ b/arch/riscv/boot/dts/qemu/qemu-virt-cbqri.dts
@@ -367,5 +367,64 @@ clint@2000000 {
 			reg = <0x00 0x2000000 0x00 0x10000>;
 			compatible = "sifive,clint0\0riscv,clint0";
 		};
+
+		cluster0_l2: controller@4820000 {
+			compatible = "foobar,cache-controller";
+			reg = <0x0 0x4820000 0x0 0x1000>; /* 4KB at 0x04820000 */
+			cache-unified;
+			cache-line-size = <64>;
+			cache-level = <2>;
+			cache-sets = <1000>;
+			cache-size = <768000>; /* 750 KiB */
+			next-level-cache = <&shared_llc>;
+			riscv,cbqri-rcid = <64>;
+			riscv,cbqri-mcid = <256>;
+		};
+
+		cluster1_l2: controller@4821000 {
+			compatible = "foobar,cache-controller";
+			reg = <0x0 0x4821000 0x0 0x1000>; /* 4KB at 0x04821000 */
+			cache-unified;
+			cache-line-size = <64>;
+			cache-level = <2>;
+			cache-sets = <1000>;
+			cache-size = <768000>; /* 750 KiB */
+			next-level-cache = <&shared_llc>;
+			riscv,cbqri-rcid = <64>;
+			riscv,cbqri-mcid = <256>;
+		};
+
+		shared_llc: controller@482b000 {
+			compatible = "foobar,cache-controller";
+			reg = <0x0 0x482b000 0x0 0x1000>; /* 4KB at 0x0482B000 */
+			cache-unified;
+			cache-line-size = <64>;
+			cache-level = <3>;
+			cache-sets = <4096>;
+			cache-size = <3145728>; /* 3 MiB */
+			riscv,cbqri-rcid = <64>;
+			riscv,cbqri-mcid = <256>;
+		};
+
+		mem0: controller@4828000 {
+			compatible = "foobar,memory-controller";
+			reg = <0x0 0x4828000 0x0 0x1000>; /* 4KB at 0x04828000 */
+			riscv,cbqri-rcid = <64>;
+			riscv,cbqri-mcid = <256>;
+		};
+
+		mem1: controller@4829000 {
+			compatible = "foobar,memory-controller";
+			reg = <0x0 0x4829000 0x0 0x1000>; /* 4KB at 0x04829000 */
+			riscv,cbqri-rcid = <64>;
+			riscv,cbqri-mcid = <256>;
+		};
+
+		mem2: controller@482a000 {
+			compatible = "foobar,memory-controller";
+			reg = <0x0 0x482a000 0x0 0x1000>; /* 4KB at 0x0482A000 */
+			riscv,cbqri-rcid = <64>;
+			riscv,cbqri-mcid = <256>;
+		};
 	};
 };
-- 
2.34.1

