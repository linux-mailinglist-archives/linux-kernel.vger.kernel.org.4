Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CAB70659A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjEQKvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEQKvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:51:50 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C8D40D5
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:51:49 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ac966d3706so496549a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1684320708; x=1686912708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W4I98XV0IFrv57OJbenqpT7CSPupqW0VvAVAytajn+E=;
        b=MnXwJ4jlP/FxQK46VKChHKbe5osYVecKrDXfcEWJMBw31u3l+N+mngaWfgB3dSsiD7
         phrMOBQjy1hsE4gPFUMTrfbr6vfQ+ZPuzklXSc64v1qEiedouMK6G7ZlRL+zjBqLNf9W
         o3WmY2nlRHmoOtTb0VwAFquEZKVzyEUZT1cDxUtu2OSV8vDSot9JucS0YWJxZR+8rPJp
         2Qer5IoHHI0BnOzkHaX7SOIYmsu55Esp51gLJScmnaucmEaYeLdMRiCYgrm1ip974UL2
         OO3TZQ8NHmkvUXnBeHL2oGwtcIJl3qtQ83SYmhGqRkCMZXMIbK95r24nk9aTMIae5oRf
         fy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684320708; x=1686912708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4I98XV0IFrv57OJbenqpT7CSPupqW0VvAVAytajn+E=;
        b=gT0MrwxKSxNTlKjESb4jdqr0MCZBOKHdsXA08q/J9bkb4gbw1h9K0/jfw0fR8G0bbl
         CFbFkieA5gO9SvaR4O8YRhcQtg00vNOOqDUaeSphgN+VPI4ahf+yVwuWV30CfMDb6jm/
         9Ubx7easshy65wCwyh5oK9hg3fIgq6/uHkQlyEo9L4U4gGI+o5RMVj2ADxyF8hZj/3Yh
         VWu05pWHJtgF8akXMQdYXjTftPU5QIJRQHj9Hag3cSg6gW6MURD/hj9s2X9Zv2RMTrR+
         xQMyH56tE8bSPbcisQMzi9TVK54lbMF52X2dg1fklRo8KS4SJSvzG4c2TZB1QbMP3xZw
         8nhg==
X-Gm-Message-State: AC+VfDyCN+GlHFqICQamT7pLzqqT7Acj9DVl2rJ3x8FT93hfcQEtgGK3
        aAzK9Cg35QfjyHt/clPGoqOZSA==
X-Google-Smtp-Source: ACHHUZ4euu8r9FiWVjCzf0OJMrz1fFmqTpnJBq5ZV+ulaHRPe7SJHyf6p4luiN3EhsbNsOA4ekwWjw==
X-Received: by 2002:a9d:7acb:0:b0:6ab:604:1eed with SMTP id m11-20020a9d7acb000000b006ab06041eedmr14252339otn.22.1684320708366;
        Wed, 17 May 2023 03:51:48 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id w1-20020a9d77c1000000b006ade3815527sm2279896otl.22.2023.05.17.03.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 03:51:48 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 00/10] RISC-V KVM in-kernel AIA irqchip
Date:   Wed, 17 May 2023 16:21:25 +0530
Message-Id: <20230517105135.1871868-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds in-kernel AIA irqchip which only trap-n-emulate IMSIC and
APLIC MSI-mode for Guest. The APLIC MSI-mode trap-n-emulate is optional so
KVM user space can emulate APLIC entirely in user space.

The use of IMSIC HW guest files to accelerate IMSIC virtualization will be
done as separate series since this depends on AIA irqchip drivers to be
upstreamed. This series has no dependency on the AIA irqchip drivers.

There is also a KVM AIA irq-bypass (or device MSI virtualization) series
under development which depends on this series and upcoming IOMMU driver
series.

These patches (or this series) can also be found in the
riscv_kvm_aia_irqchip_v1 branch at: https://github.com/avpatel/linux.git

Anup Patel (10):
  RISC-V: KVM: Implement guest external interrupt line management
  RISC-V: KVM: Add IMSIC related defines
  RISC-V: KVM: Add APLIC related defines
  RISC-V: KVM: Set kvm_riscv_aia_nr_hgei to zero
  RISC-V: KVM: Skeletal in-kernel AIA irqchip support
  RISC-V: KVM: Implement device interface for AIA irqchip
  RISC-V: KVM: Add in-kernel emulation of AIA APLIC
  RISC-V: KVM: Expose APLIC registers as attributes of AIA irqchip
  RISC-V: KVM: Add in-kernel virtualization of AIA IMSIC
  RISC-V: KVM: Expose IMSIC registers as attributes of AIA irqchip

 arch/riscv/include/asm/kvm_aia.h       |  107 ++-
 arch/riscv/include/asm/kvm_aia_aplic.h |   58 ++
 arch/riscv/include/asm/kvm_aia_imsic.h |   38 +
 arch/riscv/include/asm/kvm_host.h      |    4 +
 arch/riscv/include/uapi/asm/kvm.h      |   54 ++
 arch/riscv/kvm/Kconfig                 |    4 +
 arch/riscv/kvm/Makefile                |    3 +
 arch/riscv/kvm/aia.c                   |  274 +++++-
 arch/riscv/kvm/aia_aplic.c             |  617 ++++++++++++++
 arch/riscv/kvm/aia_device.c            |  672 +++++++++++++++
 arch/riscv/kvm/aia_imsic.c             | 1083 ++++++++++++++++++++++++
 arch/riscv/kvm/main.c                  |    3 +-
 arch/riscv/kvm/vcpu.c                  |    2 +
 arch/riscv/kvm/vm.c                    |  115 +++
 include/uapi/linux/kvm.h               |    2 +
 15 files changed, 3003 insertions(+), 33 deletions(-)
 create mode 100644 arch/riscv/include/asm/kvm_aia_aplic.h
 create mode 100644 arch/riscv/include/asm/kvm_aia_imsic.h
 create mode 100644 arch/riscv/kvm/aia_aplic.c
 create mode 100644 arch/riscv/kvm/aia_device.c
 create mode 100644 arch/riscv/kvm/aia_imsic.c

-- 
2.34.1
