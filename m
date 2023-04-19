Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9256E782C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjDSLKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjDSLKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:10:33 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF0714445
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a6c5acf6ccso14879135ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902608; x=1684494608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GRxxiBJfzhl8k1dZrpJTtiP6uidg6HV6EIWgJAXAlz8=;
        b=MksivG8vLqH9NrPVCxorQZMwtY+GeU2+xvR1PtsmQeUMxlgwwmbE5e0rsY2JeTY4tQ
         TwwxlqjtDlMGmOhgci40Z4h8ZJhh0An7vXI5009qh+CiEBy2ZWZi8LNjz96pru5K4/0X
         vJQ966l18ApD5B1gWE4zmuB1eOHZafloPoBI0cMhVddYG9T6+IpkXr9qSX8O44X1Fsw6
         /KavKvHMlx8FfMVxVzP5a+4ujzElw2AwhtUOjRiUDtVwzaFfs7GUGMMoYoIKUxQT65fi
         oY/3FcoHNiijkBhYyq/yVa4LOtRXm7RLf/rHBhZnu1pdBCVWc1DHFwV0xZ0bYKy0E2PK
         WrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902608; x=1684494608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRxxiBJfzhl8k1dZrpJTtiP6uidg6HV6EIWgJAXAlz8=;
        b=Y6Eg0bgqi8+ZVlaOxjCTIrmbFFP+SOysOPwYoGQAu01V2HK1qswIcCziMRYDlFoLbj
         Okxpba5bkNS9A/95hqllELoRrX57KnXAfvOB4nLL3srve5AFKLBVr7hKG/Lx1oc/0JPP
         5W0i+2CutKlUmr52uwJ2nRerHQ5Ypp1fwyOvYkoIytexCOaXEOl4NeStWG7dTSu06WF0
         36AueQ4sBsseAvYeqBe8c6h8Wu7/tsO6fVXyrrETDCDroXtt6RrFTillxbmdIkmqUMh6
         10FcikAqwY8eBlbbuEQTJTnczfGuyB54IlMpYKP/tDAgt7vXIjQl4yeMQ/K8jStQEuId
         fKpg==
X-Gm-Message-State: AAQBX9czT3kl1xUSDLN3BkDhi0qZZgs2eZhNmXNNQA1AvXvmcW7Z6pma
        K4Gr0oSIzmuK2lhy/eUfhlV5Yg==
X-Google-Smtp-Source: AKy350YpEs6NK/OwOrdHaX0DN/LCnT9TLRuXI07U+RycILFUDvwXOwVuO4VYNZZckuX0ExSLD4PE6Q==
X-Received: by 2002:a17:902:c613:b0:1a2:8c7e:f310 with SMTP id r19-20020a170902c61300b001a28c7ef310mr4465258plr.35.1681902607686;
        Wed, 19 Apr 2023 04:10:07 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:06 -0700 (PDT)
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
Subject: [RFC PATCH 00/21] RISC-V: QoS: add CBQRI resctrl interface
Date:   Wed, 19 Apr 2023 04:10:50 -0700
Message-Id: <20230419111111.477118-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This RFC series adds a resctrl interface for resource controllers that
implement the RISC-V Capacity and Bandwidth QoS Register Interface
(CBQRI) specification [1].

These patches are also available as a branch [2]. Please note that they
are based on a 6.3-rc1 branch by James Morse [3] for reasons that will
be explained below.

There is a complimentary RFC patch series for Qemu [4] that implements
CBQRI, and there is a qemu branch with those patches too [5].

RISC-V QoS
----------
QoS (Quality of Service) in this context is concerned with shared
resources on an SoC such as cache capacity and memory bandwidth.

The Ssqosid extension (supervisor-mode QoS ID) defines the sqoscfg CSR
which consists of a resource control identifier (RCID) and a monitoring
counter identifier (MCID). This allows a software workload, such as a
process or a set of processes, to be associated with each request made
by a hart to shared resources like cache.

CBQRI defines operations to configure resource usage limits, in the form
of capacity or bandwidth, for an RCID. CBQRI also defines operations to
configure counters to track resource utilization per MCID. Furthermore,
the Access Type (AT) field allows resources to be differentiated between
data and code.

x86 comparison
--------------
Intel RDT and AMD QoS features have already been present in some x86
processors for several years. The existing QoS identifiers on x86 map
well to the RISC-V Ssqoid extension:

  CLOSID (Class of Service ID) on x86 is RCID on RISC-V
    RMID (Resource Monitoring ID) on x86 is MCID on RISC-V

In addition, CDP (code data prioritization) on x86 is similar to the
AT (access type) field in CBQRI which defines code and data types.


resctrl beyond x86
------------------
The resctrl virtual filesystem [6] is an established userspace ABI for
QoS features on x86. However, the resctrl code is tightly coupled to
arch/x6, and it is not currently possible to use it with another
architecture in mainline.

James Morse has been working to separate resctrl out into an independent
virtual filesystem that can be used by any arch that implements a
resctrl interface. The most recent patch series is v3 of "x86/resctrl:
monitored closid+rmid together, separate arch/fs locking" [7].

The motivation behind this work from James Morse is to support the Arm
Memory System Resource Partitioning and Monitoring (MPAM) extension [8].
James maintains a "snapshot" branch for each mainline release [9] that
has a cohesive implementation of MPAM support. It includes the ability
to enable the resctrl filesystem for non-x86 architectures. Therefore,
the RISC-V support for resctrl in this RFC patch series relies on the
fs/resctrl code in the snapshot branch.

However, the current mpam snapshot branch on kernel.org is for 6.2. That
is too old to base this RFC on because RISC-V extension handling has
changed a lot since then. As result, this RFC patches series is based on
this 6.3 mpam snapshot branch [3] by James, but it won't be pushed to
kernel.org until 6.3 is officially released.

Limitations of resctrl
----------------------
Both MPAM and CBQRI are generic enough to offer a lot of flexibility for
hardware implementations. This is in contrast to the fixed functionality
of Intel RDT and AMD QoS features.

For example, Intel RDT only considers L2 and L3 cache resources. The
memory bandwidth resource (MBA) is assumed to be sitting at the L3 cache
level. In addition, CDP only supports caches so the usage of the CBQRI
Access Types (AT field) has to be limited to CBQRI capacity controllers.

This RFC patch series follows that same philosophy as the MPAM support
by James Morse [10]. Support only the functionality that is already
possible with the existing resctrl interface. There is much more
functionality that both MPAM and CBQRI offer, but that will be deferred
until after the decoupling of resctrl from x86 is merged.

One aspect of CBQRI that simplifies the RISC-V resctrl interface is that
any cpu (technically a hart, or hardware thread, in RISC-V terminology)
can access the memory-mapped registers of any CBQRI controller in the
system. This means that unlike with RDT and MPAM, it does not matter
which cpu runs the resctrl code.        

Example SoC
-----------
This series also includes example drivers for a hypothetical SoC with a
cache controller that implements CBQRI capacity operations and a memory
controller that implements CBQRI bandwidth operations. The drivers are
intended to work with the Qemu branch [5] which instantiates:

  - L2 cache controllers
    - Resource type: Capacity
    - Number of capacity blocks (NCBLKS): 12
    	- In the context of a set-associative cache, the number of
	  capacity blocks can be thought of as the number of ways
    - Number of access types: 2 (code and data)
    - Usage monitoring not supported
    - Capacity allocation operations: CONFIG_LIMIT, READ_LIMIT

  - Last-level cache (LLC) controller
    - Resource type: Capacity
    - Number of capacity blocks (NCBLKS): 16
    - Number of access types: 2 (code and data)
    - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
    - Event IDs supported: None, Occupancy
    - Capacity allocation ops: CONFIG_LIMIT, READ_LIMIT, FLUSH_RCID

  - Memory controllers
    - Resource type: Bandwidth
    - Number of bandwidth blocks (NBWBLKS): 1024
       - Bandwidth blocks do not have a unit but instead represent a
         portion of the total bandwidth resource. For NWBLKS of 1024,
	 each block represents about 0.1% of the bandwidth resource.
    - Maximum reserved bandwidth blocks (MRBWB): 819 (80% of NBWBLKS)
    - Number of access types: 1 (no code/data differentiation)
    - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
    - Event IDs supported: None, Total read/write byte count, Total
                           read byte count, Total write byte count
    - Bandwidth allocation operations: CONFIG_LIMIT, READ_LIMIT

The memory map for this example SoC:

  Base addr  Size
  0x4820000  4KB  Cluster 0 L2 cache controller
  0x4821000  4KB  Cluster 1 L2 cache controller
  0x4828000  4KB  Memory controller 0
  0x4829000  4KB  Memory controller 1
  0X482a000  4KB  Memory controller 2
  0X482b000  4KB  Shared LLC cache controller

This configuration is only meant to provide a "concrete" example, and it
represents just one of many possible ways that hardware can implement
the CBQRI spec.

Status of CBQRI
---------------
The CBQRI spec is still in a draft state and is undergoing review [11].
It is possible there will be changes to the Ssqosid extension and the
CBQRI spec. For example, the sqoscfg CSR address is not yet finalized.

The goal of this RFC patch series, along with the complimentary Qemu
patch series, is to satisfy the software proof of concept requirement
for CBQRI to become frozen.

[1] https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.pdf
[2] https://gitlab.baylibre.com/baylibre/linux/-/tree/riscv-cbqri-rfc
[3] https://gitlab.arm.com/linux-arm/linux-jm/-/tree/mpam/snaphot/20230406
[4] https://lore.kernel.org/qemu-devel/20230416232050.4094820-1-dfustini@baylibre.com/
[5] https://gitlab.baylibre.com/baylibre/qemu/-/tree/riscv-cbqri-rfc
[6] https://docs.kernel.org/x86/resctrl.html
[7] https://lore.kernel.org/lkml/20230320172620.18254-1-james.morse@arm.com/
[8] https://developer.arm.com/documentation/107768/0100/Arm-Memory-System-Resource-Partitioning-and-Monitoring--MPAM--Extension
[9] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/v6.2
[10] https://gitlab.arm.com/linux-arm/linux-jm/-/blob/mpam/snaphot/20230406/KNOWN_ISSUES
[11] https://lists.riscv.org/g/tech-cbqri/message/38

Drew Fustini (21):
  RISC-V: Detect the Ssqosid extension
  RISC-V: Add support for sqoscfg CSR
  RISC-V: QoS: define properties of CBQRI controllers
  RISC-V: QoS: define CBQRI capacity and bandwidth capabilities
  RISC-V: QoS: define prototypes for resctrl interface
  RISC-V: QoS: define CBQRI resctrl resources and domains
  RISC-V: QoS: add resctrl interface for CBQRI controllers
  RISC-V: QoS: expose implementation to resctrl
  RISC-V: QoS: add late_initcall to setup resctrl interface
  RISC-V: QoS: make CONFIG_RISCV_ISA_SSQOSID select resctrl
  RISC-V: QoS: add to build when CONFIG_RISCV_ISA_SSQOSID set
  dt-bindings: riscv: add riscv,cbqri bindings
  DO_NOT_MERGE dt-bindings: add foobar vendor-prefix
  DO_NOT_MERGE dt-bindings: soc: add Foobar SoC cache controller
  DO_NOT_MERGE dt-bindings: soc: add Foobar SoC memory controller
  DO_NOT_MERGE soc: add Foobar SoC cache controller driver
  DO_NOT_MERGE soc: add Foobar SoC memory controller driver
  DO_NOT_MERGE soc: build Foobar SoC drivers
  DO_NOT_MERGE riscv: dts: qemu: add dump from riscv-cbqri-rfc
  DO_NOT_MERGE riscv: dts: qemu: add cbqri-capable controllers
  DO_NOT_MERGE riscv: dts: build qemu virt device tree

 .../bindings/riscv/riscv,cbqri.yaml           |   28 +
 .../soc/foobar/foobar,cache-controller.yaml   |   51 +
 .../soc/foobar/foobar,memory-controller.yaml  |   49 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 arch/riscv/Kconfig                            |   22 +
 arch/riscv/boot/dts/Makefile                  |    1 +
 arch/riscv/boot/dts/qemu/Makefile             |    3 +
 arch/riscv/boot/dts/qemu/qemu-virt-cbqri.dts  |  430 ++++++
 arch/riscv/include/asm/csr.h                  |    8 +
 arch/riscv/include/asm/hwcap.h                |    2 +
 arch/riscv/include/asm/processor.h            |    3 +
 arch/riscv/include/asm/qos.h                  |   40 +
 arch/riscv/include/asm/resctrl.h              |    2 +
 arch/riscv/include/asm/switch_to.h            |    2 +
 arch/riscv/kernel/Makefile                    |    2 +
 arch/riscv/kernel/cpu.c                       |    1 +
 arch/riscv/kernel/cpufeature.c                |    1 +
 arch/riscv/kernel/qos/Makefile                |    2 +
 arch/riscv/kernel/qos/internal.h              |  157 +++
 arch/riscv/kernel/qos/qos.c                   |   31 +
 arch/riscv/kernel/qos/qos_resctrl.c           | 1231 +++++++++++++++++
 drivers/soc/Kconfig                           |    1 +
 drivers/soc/Makefile                          |    1 +
 drivers/soc/foobar/Kconfig                    |   21 +
 drivers/soc/foobar/Makefile                   |    4 +
 drivers/soc/foobar/foobar_cbqri_cache.c       |  110 ++
 drivers/soc/foobar/foobar_cbqri_memory.c      |   83 ++
 include/linux/riscv_qos.h                     |   92 ++
 28 files changed, 2380 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/foobar/foobar,cache-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/foobar/foobar,memory-controller.yaml
 create mode 100644 arch/riscv/boot/dts/qemu/Makefile
 create mode 100644 arch/riscv/boot/dts/qemu/qemu-virt-cbqri.dts
 create mode 100644 arch/riscv/include/asm/qos.h
 create mode 100644 arch/riscv/include/asm/resctrl.h
 create mode 100644 arch/riscv/kernel/qos/Makefile
 create mode 100644 arch/riscv/kernel/qos/internal.h
 create mode 100644 arch/riscv/kernel/qos/qos.c
 create mode 100644 arch/riscv/kernel/qos/qos_resctrl.c
 create mode 100644 drivers/soc/foobar/Kconfig
 create mode 100644 drivers/soc/foobar/Makefile
 create mode 100644 drivers/soc/foobar/foobar_cbqri_cache.c
 create mode 100644 drivers/soc/foobar/foobar_cbqri_memory.c
 create mode 100644 include/linux/riscv_qos.h

-- 
2.34.1

