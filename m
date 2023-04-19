Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B566E7845
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjDSLMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjDSLLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:11:22 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D94813FBE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b5c48ea09so2658986b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902637; x=1684494637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7Svk0AxAB3qoYix/qOEG4Vz2rPPucsqQxdMzpYchZI=;
        b=XmTXt7ZqxWddAV0JDjC4c6Eovx0mOpcDKBV+L7pg9kHRvcw0NrF6W5p8otcbboa+62
         0Yk50tsyKQO7E16Y/ShbQGi0tV2oXZlaNnHeVE6My6EBSsLfSGdR1+H6hWc/4acwEQ7I
         sWiwrUzhpp1UOdQZv3Ffz/odeJ0xUcVsv6OZr4R81gtBHSsPz8N3GNMSFdOKlQ1aHAs8
         /spzVKy5R+TMO/mlwy+UzyNZCIWi2iWBDIZpNtT4Ax7/9NE7gFAnx/7iTw594j+hUdmv
         76inOtM+g2caKo9rqPK7MQtjifRFGMhyGybonQmyu8ffgr+glE+3PiwJvmG3YUL2vKP6
         mFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902637; x=1684494637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7Svk0AxAB3qoYix/qOEG4Vz2rPPucsqQxdMzpYchZI=;
        b=Gr/LWDzMwrXAjSBUxbsEjQOM+ofwXJykELlF1L53RtBM2DcZM8K3LXpuUIjbkf/ToR
         PaDGVCnj9e4raCSGHKVYYqXpPt50UJevyMg1Uuha/KLLH+GEoKQ5l6DHDHjvJhR7Nr6q
         iANPQh+Tk5s+eZpYGG/59B8sX2VeZU5ykriap3JCHNQl1MXeGgCihlcA/xSIh/UDLs2w
         l+uNpNDwEwuxeSFcClANRixp/0JsFIxOiXC0yAFK8isUHl9u3KgfkHXC5YS+DlSftO86
         z2IhiwGnuVfYJ50bz+AuxKvcQXqMZygk7pieKCoS49GpeGWz9Jb2ohchnnGGcLJGKhoB
         Rchg==
X-Gm-Message-State: AAQBX9c07xgKk4N4bv8s4/lodpDzbL/iMg2fObclfNmivyg+CNX9SZwF
        AJy+/nZTCEVTrBtOiGLnrWxEPg==
X-Google-Smtp-Source: AKy350Y+nSBqUtz+XvYHUUrNKxlm15TSYw6mypxGarQ1iC83U3uspOXzd41NldV5dyN0PmskVrA9XA==
X-Received: by 2002:a17:903:294c:b0:1a6:ebc1:c54d with SMTP id li12-20020a170903294c00b001a6ebc1c54dmr4710186plb.30.1681902636996;
        Wed, 19 Apr 2023 04:10:36 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:36 -0700 (PDT)
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
Subject: [RFC PATCH 19/21] DO_NOT_MERGE riscv: dts: qemu: add dump from riscv-cbqri-rfc
Date:   Wed, 19 Apr 2023 04:11:09 -0700
Message-Id: <20230419111111.477118-20-dfustini@baylibre.com>
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

Dumped dtb from qemu branch riscv-cbqri-rfc which is on top of qemu
master (tag: v8.0.0-rc4) with qemu/VERSION of 7.2.94 invoked with:

  qemu-system-riscv64 \
      -M virt \
      -nographic \
      -smp 8 \
      -bios output/images/fw_jump.elf \
      -kernel $HOME/kernel/cbqri-linux/arch/riscv/boot/Image \
      -append "root=/dev/vda ro" \
      -drive file=output/images/rootfs.ext2,format=raw,id=hd0 \
      -device virtio-blk-device,drive=hd0 \
      -machine dumpdtb=qemu.dtb

Link: https://gitlab.baylibre.com/baylibre/qemu/-/tree/riscv-cbqri-rfc
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
Note: this is necessary as Qemu branch riscv-cbqri-rfc does not yet
support generating a dtb with the nodes and properties needed for CBQRI
controllers. Thus, those lines must be added in the next patch and an
external dtb (qemu-virt-cbqri.dtb) built by Linux is used when
invoking qemu-system-riscv64

 arch/riscv/boot/dts/qemu/qemu-virt-cbqri.dts | 371 +++++++++++++++++++
 1 file changed, 371 insertions(+)
 create mode 100644 arch/riscv/boot/dts/qemu/qemu-virt-cbqri.dts

diff --git a/arch/riscv/boot/dts/qemu/qemu-virt-cbqri.dts b/arch/riscv/boot/dts/qemu/qemu-virt-cbqri.dts
new file mode 100644
index 000000000000..400ed48a06af
--- /dev/null
+++ b/arch/riscv/boot/dts/qemu/qemu-virt-cbqri.dts
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/dts-v1/;
+
+/ {
+	#address-cells = <0x02>;
+	#size-cells = <0x02>;
+	compatible = "riscv-virtio";
+	model = "riscv-virtio,qemu";
+
+	fw-cfg@10100000 {
+		dma-coherent;
+		reg = <0x00 0x10100000 0x00 0x18>;
+		compatible = "qemu,fw-cfg-mmio";
+	};
+
+	flash@20000000 {
+		bank-width = <0x04>;
+		reg = <0x00 0x20000000 0x00 0x2000000 0x00 0x22000000 0x00 0x2000000>;
+		compatible = "cfi-flash";
+	};
+
+	chosen {
+		bootargs = "root=/dev/vda ro ftrace=function_graph ftrace_filter=\"*resctrl*,*qos*\"";
+		rng-seed = <0xb87c09c5 0xc8f0c713 0x9c217b2a 0xa6f44e14 0xb6e99df6 0x205d482b 0x6d4c34f4 0x6466fc08>;
+		stdout-path = "/soc/serial@10000000";
+	};
+
+	poweroff {
+		value = <0x5555>;
+		offset = <0x00>;
+		regmap = <0x12>;
+		compatible = "syscon-poweroff";
+	};
+
+	reboot {
+		value = <0x7777>;
+		offset = <0x00>;
+		regmap = <0x12>;
+		compatible = "syscon-reboot";
+	};
+
+	platform-bus@4000000 {
+		interrupt-parent = <0x11>;
+		ranges = <0x00 0x00 0x4000000 0x2000000>;
+		#address-cells = <0x01>;
+		#size-cells = <0x01>;
+		compatible = "qemu,platform\0simple-bus";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x00 0x80000000 0x00 0x8000000>;
+	};
+
+	cpus {
+		#address-cells = <0x01>;
+		#size-cells = <0x00>;
+		timebase-frequency = <0x989680>;
+
+		cpu@0 {
+			phandle = <0x0f>;
+			device_type = "cpu";
+			reg = <0x00>;
+			status = "okay";
+			compatible = "riscv";
+			riscv,cboz-block-size = <0x40>;
+			riscv,cbom-block-size = <0x40>;
+			riscv,isa = "rv64imafdch_zicbom_zicboz_zicsr_zifencei_zihintpause_zawrs_zba_zbb_zbc_zbs_ssqosid_sstc_svadu";
+			mmu-type = "riscv,sv57";
+
+			interrupt-controller {
+				#interrupt-cells = <0x01>;
+				interrupt-controller;
+				compatible = "riscv,cpu-intc";
+				phandle = <0x10>;
+			};
+		};
+
+		cpu@1 {
+			phandle = <0x0d>;
+			device_type = "cpu";
+			reg = <0x01>;
+			status = "okay";
+			compatible = "riscv";
+			riscv,cboz-block-size = <0x40>;
+			riscv,cbom-block-size = <0x40>;
+			riscv,isa = "rv64imafdch_zicbom_zicboz_zicsr_zifencei_zihintpause_zawrs_zba_zbb_zbc_zbs_ssqosid_sstc_svadu";
+			mmu-type = "riscv,sv57";
+
+			interrupt-controller {
+				#interrupt-cells = <0x01>;
+				interrupt-controller;
+				compatible = "riscv,cpu-intc";
+				phandle = <0x0e>;
+			};
+		};
+
+		cpu@2 {
+			phandle = <0x0b>;
+			device_type = "cpu";
+			reg = <0x02>;
+			status = "okay";
+			compatible = "riscv";
+			riscv,cboz-block-size = <0x40>;
+			riscv,cbom-block-size = <0x40>;
+			riscv,isa = "rv64imafdch_zicbom_zicboz_zicsr_zifencei_zihintpause_zawrs_zba_zbb_zbc_zbs_ssqosid_sstc_svadu";
+			mmu-type = "riscv,sv57";
+
+			interrupt-controller {
+				#interrupt-cells = <0x01>;
+				interrupt-controller;
+				compatible = "riscv,cpu-intc";
+				phandle = <0x0c>;
+			};
+		};
+
+		cpu@3 {
+			phandle = <0x09>;
+			device_type = "cpu";
+			reg = <0x03>;
+			status = "okay";
+			compatible = "riscv";
+			riscv,cboz-block-size = <0x40>;
+			riscv,cbom-block-size = <0x40>;
+			riscv,isa = "rv64imafdch_zicbom_zicboz_zicsr_zifencei_zihintpause_zawrs_zba_zbb_zbc_zbs_ssqosid_sstc_svadu";
+			mmu-type = "riscv,sv57";
+
+			interrupt-controller {
+				#interrupt-cells = <0x01>;
+				interrupt-controller;
+				compatible = "riscv,cpu-intc";
+				phandle = <0x0a>;
+			};
+		};
+
+		cpu@4 {
+			phandle = <0x07>;
+			device_type = "cpu";
+			reg = <0x04>;
+			status = "okay";
+			compatible = "riscv";
+			riscv,cboz-block-size = <0x40>;
+			riscv,cbom-block-size = <0x40>;
+			riscv,isa = "rv64imafdch_zicbom_zicboz_zicsr_zifencei_zihintpause_zawrs_zba_zbb_zbc_zbs_ssqosid_sstc_svadu";
+			mmu-type = "riscv,sv57";
+
+			interrupt-controller {
+				#interrupt-cells = <0x01>;
+				interrupt-controller;
+				compatible = "riscv,cpu-intc";
+				phandle = <0x08>;
+			};
+		};
+
+		cpu@5 {
+			phandle = <0x05>;
+			device_type = "cpu";
+			reg = <0x05>;
+			status = "okay";
+			compatible = "riscv";
+			riscv,cboz-block-size = <0x40>;
+			riscv,cbom-block-size = <0x40>;
+			riscv,isa = "rv64imafdch_zicbom_zicboz_zicsr_zifencei_zihintpause_zawrs_zba_zbb_zbc_zbs_ssqosid_sstc_svadu";
+			mmu-type = "riscv,sv57";
+
+			interrupt-controller {
+				#interrupt-cells = <0x01>;
+				interrupt-controller;
+				compatible = "riscv,cpu-intc";
+				phandle = <0x06>;
+			};
+		};
+
+		cpu@6 {
+			phandle = <0x03>;
+			device_type = "cpu";
+			reg = <0x06>;
+			status = "okay";
+			compatible = "riscv";
+			riscv,cboz-block-size = <0x40>;
+			riscv,cbom-block-size = <0x40>;
+			riscv,isa = "rv64imafdch_zicbom_zicboz_zicsr_zifencei_zihintpause_zawrs_zba_zbb_zbc_zbs_ssqosid_sstc_svadu";
+			mmu-type = "riscv,sv57";
+
+			interrupt-controller {
+				#interrupt-cells = <0x01>;
+				interrupt-controller;
+				compatible = "riscv,cpu-intc";
+				phandle = <0x04>;
+			};
+		};
+
+		cpu@7 {
+			phandle = <0x01>;
+			device_type = "cpu";
+			reg = <0x07>;
+			status = "okay";
+			compatible = "riscv";
+			riscv,cboz-block-size = <0x40>;
+			riscv,cbom-block-size = <0x40>;
+			riscv,isa = "rv64imafdch_zicbom_zicboz_zicsr_zifencei_zihintpause_zawrs_zba_zbb_zbc_zbs_ssqosid_sstc_svadu";
+			mmu-type = "riscv,sv57";
+
+			interrupt-controller {
+				#interrupt-cells = <0x01>;
+				interrupt-controller;
+				compatible = "riscv,cpu-intc";
+				phandle = <0x02>;
+			};
+		};
+
+		cpu-map {
+
+			cluster0 {
+
+				core0 {
+					cpu = <0x0f>;
+				};
+
+				core1 {
+					cpu = <0x0d>;
+				};
+
+				core2 {
+					cpu = <0x0b>;
+				};
+
+				core3 {
+					cpu = <0x09>;
+				};
+
+				core4 {
+					cpu = <0x07>;
+				};
+
+				core5 {
+					cpu = <0x05>;
+				};
+
+				core6 {
+					cpu = <0x03>;
+				};
+
+				core7 {
+					cpu = <0x01>;
+				};
+			};
+		};
+	};
+
+	soc {
+		#address-cells = <0x02>;
+		#size-cells = <0x02>;
+		compatible = "simple-bus";
+		ranges;
+
+		pmu {
+			riscv,event-to-mhpmcounters = <0x01 0x01 0x7fff9 0x02 0x02 0x7fffc 0x10019 0x10019 0x7fff8 0x1001b 0x1001b 0x7fff8 0x10021 0x10021 0x7fff8 0x00 0x00 0x00 0x00 0x00>;
+			compatible = "riscv,pmu";
+		};
+
+		rtc@101000 {
+			interrupts = <0x0b>;
+			interrupt-parent = <0x11>;
+			reg = <0x00 0x101000 0x00 0x1000>;
+			compatible = "google,goldfish-rtc";
+		};
+
+		serial@10000000 {
+			interrupts = <0x0a>;
+			interrupt-parent = <0x11>;
+			clock-frequency = "\08@";
+			reg = <0x00 0x10000000 0x00 0x100>;
+			compatible = "ns16550a";
+		};
+
+		test@100000 {
+			phandle = <0x12>;
+			reg = <0x00 0x100000 0x00 0x1000>;
+			compatible = "sifive,test1\0sifive,test0\0syscon";
+		};
+
+		pci@30000000 {
+			interrupt-map-mask = <0x1800 0x00 0x00 0x07>;
+			interrupt-map = <0x00 0x00 0x00 0x01 0x11 0x20 0x00 0x00 0x00 0x02 0x11 0x21 0x00 0x00 0x00 0x03 0x11 0x22 0x00 0x00 0x00 0x04 0x11 0x23 0x800 0x00 0x00 0x01 0x11 0x21 0x800 0x00 0x00 0x02 0x11 0x22 0x800 0x00 0x00 0x03 0x11 0x23 0x800 0x00 0x00 0x04 0x11 0x20 0x1000 0x00 0x00 0x01 0x11 0x22 0x1000 0x00 0x00 0x02 0x11 0x23 0x1000 0x00 0x00 0x03 0x11 0x20 0x1000 0x00 0x00 0x04 0x11 0x21 0x1800 0x00 0x00 0x01 0x11 0x23 0x1800 0x00 0x00 0x02 0x11 0x20 0x1800 0x00 0x00 0x03 0x11 0x21 0x1800 0x00 0x00 0x04 0x11 0x22>;
+			ranges = <0x1000000 0x00 0x00 0x00 0x3000000 0x00 0x10000 0x2000000 0x00 0x40000000 0x00 0x40000000 0x00 0x40000000 0x3000000 0x04 0x00 0x04 0x00 0x04 0x00>;
+			reg = <0x00 0x30000000 0x00 0x10000000>;
+			dma-coherent;
+			bus-range = <0x00 0xff>;
+			linux,pci-domain = <0x00>;
+			device_type = "pci";
+			compatible = "pci-host-ecam-generic";
+			#size-cells = <0x02>;
+			#interrupt-cells = <0x01>;
+			#address-cells = <0x03>;
+		};
+
+		virtio_mmio@10008000 {
+			interrupts = <0x08>;
+			interrupt-parent = <0x11>;
+			reg = <0x00 0x10008000 0x00 0x1000>;
+			compatible = "virtio,mmio";
+		};
+
+		virtio_mmio@10007000 {
+			interrupts = <0x07>;
+			interrupt-parent = <0x11>;
+			reg = <0x00 0x10007000 0x00 0x1000>;
+			compatible = "virtio,mmio";
+		};
+
+		virtio_mmio@10006000 {
+			interrupts = <0x06>;
+			interrupt-parent = <0x11>;
+			reg = <0x00 0x10006000 0x00 0x1000>;
+			compatible = "virtio,mmio";
+		};
+
+		virtio_mmio@10005000 {
+			interrupts = <0x05>;
+			interrupt-parent = <0x11>;
+			reg = <0x00 0x10005000 0x00 0x1000>;
+			compatible = "virtio,mmio";
+		};
+
+		virtio_mmio@10004000 {
+			interrupts = <0x04>;
+			interrupt-parent = <0x11>;
+			reg = <0x00 0x10004000 0x00 0x1000>;
+			compatible = "virtio,mmio";
+		};
+
+		virtio_mmio@10003000 {
+			interrupts = <0x03>;
+			interrupt-parent = <0x11>;
+			reg = <0x00 0x10003000 0x00 0x1000>;
+			compatible = "virtio,mmio";
+		};
+
+		virtio_mmio@10002000 {
+			interrupts = <0x02>;
+			interrupt-parent = <0x11>;
+			reg = <0x00 0x10002000 0x00 0x1000>;
+			compatible = "virtio,mmio";
+		};
+
+		virtio_mmio@10001000 {
+			interrupts = <0x01>;
+			interrupt-parent = <0x11>;
+			reg = <0x00 0x10001000 0x00 0x1000>;
+			compatible = "virtio,mmio";
+		};
+
+		plic@c000000 {
+			phandle = <0x11>;
+			riscv,ndev = <0x5f>;
+			reg = <0x00 0xc000000 0x00 0x600000>;
+			interrupts-extended = <0x10 0x0b 0x10 0x09 0x0e 0x0b 0x0e 0x09 0x0c 0x0b 0x0c 0x09 0x0a 0x0b 0x0a 0x09 0x08 0x0b 0x08 0x09 0x06 0x0b 0x06 0x09 0x04 0x0b 0x04 0x09 0x02 0x0b 0x02 0x09>;
+			interrupt-controller;
+			compatible = "sifive,plic-1.0.0\0riscv,plic0";
+			#address-cells = <0x00>;
+			#interrupt-cells = <0x01>;
+		};
+
+		clint@2000000 {
+			interrupts-extended = <0x10 0x03 0x10 0x07 0x0e 0x03 0x0e 0x07 0x0c 0x03 0x0c 0x07 0x0a 0x03 0x0a 0x07 0x08 0x03 0x08 0x07 0x06 0x03 0x06 0x07 0x04 0x03 0x04 0x07 0x02 0x03 0x02 0x07>;
+			reg = <0x00 0x2000000 0x00 0x10000>;
+			compatible = "sifive,clint0\0riscv,clint0";
+		};
+	};
+};
-- 
2.34.1

