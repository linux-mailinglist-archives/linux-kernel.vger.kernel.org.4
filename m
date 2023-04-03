Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF3C6D442D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjDCMPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjDCMPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:15:39 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AE11025F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 05:15:38 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w13so10157417oik.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 05:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680524137; x=1683116137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TS4dMW3hhVrS92UnjrQfADuzhNuNJZ4W/UKQPMy/KVU=;
        b=IExzSnPyPAJHwnxo3Oylte7PPjAayTEknYvoCwnajbhtx5YetGon+QIEGI94KzY2Vm
         vPtyY6g3jIZ+BUd2HJAVHj4FE/5KCipA8PN5P0+UYdb5xfAmYfyS//AMn7M/UaQy5VK7
         FeCALgtrQoxEe2WVkRsox3W1r/mFLPfG+4JXmPz0LNphCfhlCVe2dxd5r0Lpd0O1gKz5
         Cmvq/k7Y904bcF1BbxxlImvP7yDxlUsW4Ylr/J0JcpaDIh5pFTgLzIB5+MEL1u6DtsZe
         t+CjxqlNyH+ZFt78KMPr1kDqwxUDN1UKTf0iiZYMMl2FoHqNa6aR/RG8GwBYe4TlS6tg
         fTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680524137; x=1683116137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TS4dMW3hhVrS92UnjrQfADuzhNuNJZ4W/UKQPMy/KVU=;
        b=udKkIowOcZlQbwbdGxb39mud2JcfUN3pIAnGj+Moaa40vQaBIs3z+DsqCgYF8z8hf/
         1Fc+r7G8clBGS9zUuewfIBi0UzEWD99Ptq2Qplb1qjN2CosQ+tQqEbk8fDwyYyzA5uSI
         vUtJdlhYs0dZfgOVOizzp+Dh6XuioEVIfq7bK4htALhA3x2WEfl/dvzNzg8KcYcWoAFv
         rPLSLZdhkcxswSkxDFlUY8RkZD8y6t3yZOkEwBtwIl6ccScgHZ5BL0joys5HCk67eC/5
         Ufa75/KUqGICMcYrYjZ/HrRXMWFETd+XVDvMKaHFfR+7qrxHQA8aXJCrg4oLzkdYZdhU
         o5UQ==
X-Gm-Message-State: AAQBX9dE4MqEP5n63a70Piu+yQD44wlEMLYlQOhZ/gAyfinx8wqJnQdh
        pw2CWzW7UZhGwbCA/JMakWD9AA==
X-Google-Smtp-Source: AKy350a93rTa/oVPFxJKYmjl+NPqKh1OJsbT5rNPcxqR7/VE6ouSaH3Z+beN96oY3IaG85BTVTpTjA==
X-Received: by 2002:a05:6808:4245:b0:38b:197b:902 with SMTP id dp5-20020a056808424500b0038b197b0902mr2262654oib.21.1680524137523;
        Mon, 03 Apr 2023 05:15:37 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id a1-20020a05680804c100b00384fa407a06sm3763695oie.8.2023.04.03.05.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 05:15:37 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v5 0/1] RISC-V KVM ONE_REG interface for SBI
Date:   Mon,  3 Apr 2023 17:45:26 +0530
Message-Id: <20230403121527.2286489-1-apatel@ventanamicro.com>
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

These patches can also be found in the riscv_kvm_sbi_imp_v5 branch at:
https://github.com/avpatel/linux.git

Changes since v4:
 - Rebased on Linux-6.3-rc5
 - Removed redundant semi-colons after switch cases

Changes since v3:
 - Added missing switch case for KVM_REG_RISCV_SBI_EXT in
   kvm_riscv_vcpu_get_reg().
 - Return a bit mask of disabled extensions for
   GET(KVM_REG_RISCV_SBI_MULTI_DIS).

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
 arch/riscv/kvm/vcpu.c                 |   4 +
 arch/riscv/kvm/vcpu_sbi.c             | 247 ++++++++++++++++++++++++--
 arch/riscv/kvm/vcpu_sbi_base.c        |   2 +-
 5 files changed, 274 insertions(+), 19 deletions(-)

-- 
2.34.1

