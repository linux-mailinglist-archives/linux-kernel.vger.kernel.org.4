Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6698960457A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiJSMiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiJSMiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:38:00 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC791C2F27
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:18:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f140so17055450pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TnLW0RVC/l/l6ZpSJGiQ9RS55Sh7Bww2u/zF6eZ2bY=;
        b=VmIxWBCxoy1QBqErke7QvouhcYXidpSrec5Syh14pJIJHPU4IBaHxcbo5EwewVpxfL
         +UHb3B6tURYxJ+OMRzyrlcY+MIaMEqksi7YojEEuFTcgkBk003zRHkht+tWuAJp4V6ZY
         QCSIAyp30+aUccx4FNMCqs+VHPBROZrN7lIbY+1aPL4xUDoMqH9mIfMhPgJU4MnEXfnZ
         L0HgoJGg4fg6k9uq8klAOIWdCgvuyJc6V7vpS0Ks0TbusDQpzC21nr3ul8W93mlkXKVk
         br0cf1zSv6un/eSvSABH4wPAVlQRXdptBqGmfovPgMB3oj6Eug03qiKrnUlOk/Tl54Jl
         VVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TnLW0RVC/l/l6ZpSJGiQ9RS55Sh7Bww2u/zF6eZ2bY=;
        b=0sugAB0PheqqAh5eBci0MPM3wSqze1dsmmQhT35zsUdM/tnnvodjNrRFVGdi23qbK1
         pS5ElBAlqec+A+Rc7UHWQv7gVukPi0BtJ3pqZRqcWAq6TwbyaQAdskpdHmaYlENcnwE/
         ofCcsz7Crmt7ACsz9WISxTn5BOycXDXjpC3Qgz8jKTc1RJ9z+YRgYYuUbjCuShlI4drd
         LK/RoBt02pJ1JFD0amLNyRuTLuiNPmx0LtlyYudcv+BxJqRhlbdQNO6KEBqXB2NRnC0r
         LP//HD4PJmH5cXOf7RgW9yi3b1OZgQx9z01U2dQdm2Bq8Pm1xQgTNwuIzi+hLbhpePgE
         vxYw==
X-Gm-Message-State: ACrzQf2La3G5q1vkUePiEOZCcLeJapELBJNZYuGkd3XDItb+y07yKeNm
        lE+XRAY/bAHgoXn90rv+M8lxEA==
X-Google-Smtp-Source: AMsMyM4wiTY98cvros59bvbWZy1Au2cyR34sxy+r9pEvM1Gd9ScZS4SNsiJ/t0LAvGT2I169S3b7hQ==
X-Received: by 2002:a05:6a00:114c:b0:528:2c7a:6302 with SMTP id b12-20020a056a00114c00b005282c7a6302mr8415575pfm.37.1666181821492;
        Wed, 19 Oct 2022 05:17:01 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.82.102])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b0017e93c158d7sm10529824pla.214.2022.10.19.05.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 05:17:00 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 4/4] RISC-V: Enable PMEM drivers
Date:   Wed, 19 Oct 2022 17:46:22 +0530
Message-Id: <20221019121622.179024-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019121622.179024-1-apatel@ventanamicro.com>
References: <20221019121622.179024-1-apatel@ventanamicro.com>
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

