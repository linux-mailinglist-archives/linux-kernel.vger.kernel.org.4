Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8266D2080
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCaMj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjCaMis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:38:48 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DEF1D2F9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:37:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id le6so21073174plb.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680266229; x=1682858229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9WubBxQcFlbrCivsI8ygmIt3wyTH8vV0otzELm2BxuY=;
        b=S8SEwMexthg418jcoc/l0ZCHyde7NLs7axCIcKNjXn6/pDmhwVH7MN1pRPCb78KzNa
         FDVWax2ZvK8RuMsbxJ9XKNWUkQDiXGIfqxohzOe3qHDrdZwZTqMl+J89OFKRme09kbun
         5ZSa23mTHJibfrCSRY2z0luvXS3fkAqg0B4rjFpGnOUGPnQBReNCO4bYrpRSW0GYmJPK
         en1NRd3WTFXOB0T0egm20HwRfpWcMnspTvUc0tcufRTjHCDCQ/hFGn2QKMIXn0/a9082
         HclH91MlF0fbpypjtJh9lqtcA6+52YstOjrNZ+KXLwD1896ipDTHN6Ixdn3a+V1Ym1ku
         q0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680266229; x=1682858229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9WubBxQcFlbrCivsI8ygmIt3wyTH8vV0otzELm2BxuY=;
        b=YBOJNkIoWQfVk5XmPfVuyoeGBxzgLHE3wV8fEJ6IzNGN6nIfQS9Hd3UT0OJLkTk70B
         c3DN9hazPhBz293VfEEq7r12bcbQp9YHxDUL9vwwMIfkOK1POM21C0UcW0PfKqRoor0v
         5XzOW+vSRsZOtnl63Fp20NY7VMF7enZFmqmwl065z0XhJ4mISU1v5RX7bxgvgQz89nYX
         8vGsyv16dEYSDGYx0PKvuOn4MvHBeKLsa5SG9W6OzNPt9KGX5EyvWy7W1BlQtE/V9/m+
         jWNcGLU2Tl7NwcmkyrgyFq4YX7/rOuDT2A/xapNvEP+LZF2Bu8go+8mInWmnew41yw/N
         Z1CQ==
X-Gm-Message-State: AO0yUKUqjFUzwfK3m5zS4qJ9WhGJo0p5CSYdVC40vqseh1VmT1Zr5BJy
        8F1Q0Z15EijKGEIjBlEeT5ZpKw==
X-Google-Smtp-Source: AK7set8oJnl1XWMelKBd0trRwj/ADq3c2QeaJ5pMHFOAmAusZzI9flMITHfHrm2lvXn9Zm+3OMJV6g==
X-Received: by 2002:a05:6a20:4c2a:b0:d4:f108:d8d0 with SMTP id fm42-20020a056a204c2a00b000d4f108d8d0mr22359696pzb.36.1680266228643;
        Fri, 31 Mar 2023 05:37:08 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78802000000b005a8a5be96b2sm876470pfo.104.2023.03.31.05.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 05:37:08 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 0/1] RISC-V KVM ONE_REG interface for SBI
Date:   Fri, 31 Mar 2023 18:06:54 +0530
Message-Id: <20230331123655.1991260-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series first does few cleanups/fixes (PATCH1 to PATCH5) and adds
ONE-REG interface for customizing the SBI interface visible to the
Guest/VM.

The testing of this series has been done with KVMTOOL changes in
riscv_sbi_imp_v1 branch at:
https://github.com/avpatel/kvmtool.git

These patches can also be found in the riscv_kvm_sbi_imp_v3 branch at:
https://github.com/avpatel/linux.git

Changes since v2:
 - Improve ONE_REG interface to allow enabling/disabling multiple SBI
   extensions in one ioctl().

Changes since v1:
 - Dropped patches 1 to 8 since these are already merged.
 - Rebased on Linux-6.3-rc4

Anup Patel (1):
  RISC-V: KVM: Add ONE_REG interface to enable/disable SBI extensions

 arch/riscv/include/asm/kvm_vcpu_sbi.h |   8 +-
 arch/riscv/include/uapi/asm/kvm.h     |  32 ++++
 arch/riscv/kvm/vcpu.c                 |   2 +
 arch/riscv/kvm/vcpu_sbi.c             | 245 ++++++++++++++++++++++++--
 arch/riscv/kvm/vcpu_sbi_base.c        |   2 +-
 5 files changed, 270 insertions(+), 19 deletions(-)

-- 
2.34.1

