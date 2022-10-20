Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5709605931
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiJTH70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiJTH7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:59:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FD718027C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:59:12 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f193so18559306pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TnLW0RVC/l/l6ZpSJGiQ9RS55Sh7Bww2u/zF6eZ2bY=;
        b=eL/0WYugw3H/1sxFC9WdKuigQo+DLOOuD80Q50Flm9AQs84m3h9nhYf0lLQYFWRd39
         DXs4iq9U35DNMud1OLd+16okiAB2eoq7QcO9OSbRglrpg20DSO8trF8j8xmLmCcLLGPC
         cN3DT63GsaCqDSugUopR1AvikeqYg8gC613t1k9CY7q9hO9lJ8lvKYl8Ek4e6lDvJMlw
         vPg3fbNz3pUhmLaNqjOoHF5hZZCC/VZeRstJaWGQUmsQd8PNC4hcrRrPGFxTNz1xt4pK
         Bw1uR/NrBdi2x1QlXQ8AkRO/ok1dsPlcpY1fOB2o0/DwqFlo7APjo4OD+L3+tAq4gC1g
         HMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TnLW0RVC/l/l6ZpSJGiQ9RS55Sh7Bww2u/zF6eZ2bY=;
        b=WhwFTrE8ftZYt4ogBf4NIcY4ehAP3y9KdJxxEXVVXWbIx6WPeuQNgkTNn1HpXmIuvX
         +FYu3WIrh/jAvt0smaAu0IOsVHd7UzCp7iTMCklmt5fh+MkDS68U9J8/uqxKMnxMuIOE
         dhRN+jdQUjM03fIAkvLy52oyKCieJtMGaYlBFU623pRdxz6oiJyIgRvl2iMIXComa6zF
         diVmFy3YlMXi6TNbjzXdt1bYkC3hDF8f7+UcHlGKjFehfUkusoHEtmROfnU2YlFwo8mm
         cdzFQk2I6qdgW8u6TuFACiCZpmdWL+u7cN0d0Jw7TnFc404QIiUkfpia4r3ylFrpia/G
         MK9w==
X-Gm-Message-State: ACrzQf1v1+BMm12DyjTxNbW6WhsNKjLUOmBTBu2SIiCZkTY6e88MGRm1
        ESIV8yM9hvvjQXDCVkSZBYXHiQ==
X-Google-Smtp-Source: AMsMyM5695BW3bf/MyxpS9FPVNImhqrzxiREVKiQzjuNPGrSayyB3orzN/hf7wn69DCszXPk5MNb7w==
X-Received: by 2002:a63:ef18:0:b0:439:befc:d89c with SMTP id u24-20020a63ef18000000b00439befcd89cmr10373730pgh.504.1666252752020;
        Thu, 20 Oct 2022 00:59:12 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.80.23])
        by smtp.gmail.com with ESMTPSA id h30-20020aa79f5e000000b0052dfe83e19csm13206438pfr.16.2022.10.20.00.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 00:59:11 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v5 4/4] RISC-V: Enable PMEM drivers
Date:   Thu, 20 Oct 2022 13:28:46 +0530
Message-Id: <20221020075846.305576-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221020075846.305576-1-apatel@ventanamicro.com>
References: <20221020075846.305576-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

