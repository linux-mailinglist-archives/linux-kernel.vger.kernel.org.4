Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1169C6278B2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbiKNJIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbiKNJHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:07:31 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1801EC77
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:06:16 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q186so10756130oia.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TnLW0RVC/l/l6ZpSJGiQ9RS55Sh7Bww2u/zF6eZ2bY=;
        b=NcRntpJUBXD8X/NLF4ZQYon44J4DDA4fW4p44wwVOyzCLSddzAsRYxd3Hs04Jq4WQp
         taS2Xb/+DHAySaLWYUuHLHTMZEohNNtNBl6ZgSsaZuFtPW6xCnTO25d6jYdddhnfFJMi
         eLLnCj2xC5gI9RAISo+4T9uM+IJ7pMADNDkCKQe8vb6nMu+Ts+WP3ic1NyYKdGeTTccI
         6zENqCEG8GuhoWacXYSrr4kZ93M395NaZmPUfDc6i843EH8DHNv6XTXdj90EVLQZFAm6
         SQpeVr/VyZIGm6y7U2T3aib7FEg6h66EAt1gEg0xmiGgwg+vC45hKiPPxISmll6HcuY2
         LQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TnLW0RVC/l/l6ZpSJGiQ9RS55Sh7Bww2u/zF6eZ2bY=;
        b=oLfEYwDb2vXywOyvLHhUnxrELatC3XaYJwdqtdREnPPr3bAuIWJGoimQixyhVTll2H
         ebVWoFVorDGd3Kjo4NlRPv0EYAbs2bw5O07OZbtdUb6ccnrcwHyN04rCEMNQur5N4dJy
         ab0UCrUqSn5drdMPxDm4fEB/vomDTFp63GON8GrmC/OY3xAWuUooeATUlz2eJN/vjEvH
         DZsbKncXKPPkLWviVKnVJZ3bYGu7FwaxUjWllKIWW4QMQuM/UOokS051XBvsdib3zGuP
         km+MhmQH9uQohKLpsoaHkms5Wf3L3LGq2P2ZU0dn/Q6i87UjWmYbplkHVmQG7+EcaFMt
         OQ0A==
X-Gm-Message-State: ANoB5pnmaanWb8RPPrT3WB/nNhr+3mz8+55qSpObfTL2kIL0M+j0yDNg
        9qZXPXYgy6d5mdh4wq84onFZHw==
X-Google-Smtp-Source: AA0mqf73xXWXRmFpczTe5uuG5ukc7zfCe8gT0PITVl8J6K3RsuhawTE/L38MdQ+HsZ+RzsqFx4U1Bg==
X-Received: by 2002:a05:6808:130c:b0:34d:d3a5:b2d with SMTP id y12-20020a056808130c00b0034dd3a50b2dmr5235455oiv.224.1668416775584;
        Mon, 14 Nov 2022 01:06:15 -0800 (PST)
Received: from anup-ubuntu64-vm.. ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n2-20020aca2402000000b00354948e04e4sm3432939oic.2.2022.11.14.01.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 01:06:15 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v6 3/3] RISC-V: Enable PMEM drivers
Date:   Mon, 14 Nov 2022 14:35:36 +0530
Message-Id: <20221114090536.1662624-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090536.1662624-1-apatel@ventanamicro.com>
References: <20221114090536.1662624-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have PMEM arch support available in RISC-V kernel so let us
enable relevant drivers in defconfig.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 05fd5fcf24f9..462da9f7410d 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -159,6 +159,7 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_RPMSG_CHAR=y
 CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_VIRTIO=y
+CONFIG_LIBNVDIMM=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-- 
2.34.1

