Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE2467AB6C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjAYIMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbjAYIMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:12:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94884CE47
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:12:18 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so2040062wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iyJXSqP7CQm+h+5+1oMeWkfZOWd0y631bmCZOmSTMyk=;
        b=U1tQ4sQMqpKkkDDWwHt7ZgPqHAKCJeMt1uKYltAzs2h6l9hw4T2xJNSe/xeFcet/e/
         csG39fgFwY2TqfLyRb0HhdaCBinxbA73mLJpGvXw7UxOEsGNL6BuAaxzQjpHu7Gn5Z/3
         cejorsMJW4ya9Mw2LYIBstGIRb9WrgIDWPEVAUTRGF1f486ttdA8eZRbiMoTApJHnPVg
         9oK8RQ9J+d9frUa7biTHAnpYLUiWPwPsgq6LTh3va7CIrem+UYgCZCNqce/ijtTrZ6EI
         XVXuV7P5E9cwGL6bUpcXIrSZy8OZD1hRiYkNlQUXA5twnIxQT/I35wQ90oXDflWqp+lz
         41YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyJXSqP7CQm+h+5+1oMeWkfZOWd0y631bmCZOmSTMyk=;
        b=gSWuSOevzxD3V2Qrgjb8OrgRkAntUnzsPAnDt+f9OLfxTW81NjdJomaaf90Cs6kqI5
         +OJ2cBzOrUvVAYb0WNeCLaP0DNi9PsYZGZl0xVVmnpeH5sf18Tn+FPdYQyLdv+sr6/Zl
         afy9uirjtYyIeiLZ9Zp2ar1ZHG+ZhDJ8s75CDD+wmQGZYy1fvkmohIYWQCn6tOlNCnls
         EW7o322/U3IxyrPMG3ra4PX2ynnE+Hyl/PLEZr38Ecxwv1TZfwFNgnwBiky26j8OrifA
         PHjTZ8HOekuNIZ7eB2+Ehk/WVRK+5R5JfuOXlqxsMd4FC0jWInMAUSmwpciCiIaYSRUV
         QrpA==
X-Gm-Message-State: AFqh2kouLCL4HxfO/GRveWPpn1uVnq1ousvSTH51O3NHkscb5jl9Uuvc
        TAQiGNHoamE60IvGSW/UhdvY7Q==
X-Google-Smtp-Source: AMrXdXvo/5JiqclykmzIB1NdGAzJlDGhKgsGjykOeNA58K9JyuQOPNNN63ZjRphCQmq7Rvir8ugUsA==
X-Received: by 2002:a05:600c:1c9d:b0:3da:db4:6105 with SMTP id k29-20020a05600c1c9d00b003da0db46105mr30909204wms.37.1674634337244;
        Wed, 25 Jan 2023 00:12:17 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003db012d49b7sm6028511wmo.2.2023.01.25.00.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 00:12:16 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 0/2] riscv: Use PUD/P4D/PGD pages for the linear mapping
Date:   Wed, 25 Jan 2023 09:12:12 +0100
Message-Id: <20230125081214.1576313-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset intends to improve tlb utilization by using hugepages for
the linear mapping.

v5:
- Fix nommu builds by getting rid of riscv_pfn_base in patch 1, thanks
  Conor
- Add RB from Andre

v4:
- Rebase on top of v6.2-rc3, as noted by Conor
- Add Acked-by Rob

v3:
- Change the comment about initrd_start VA conversion so that it fits
  ARM64 and RISCV64 (and others in the future if needed), as suggested
  by Rob

v2:
- Add a comment on why RISCV64 does not need to set initrd_start/end that
  early in the boot process, as asked by Rob

Alexandre Ghiti (2):
  riscv: Get rid of riscv_pfn_base variable
  riscv: Use PUD/P4D/PGD pages for the linear mapping

 arch/riscv/include/asm/page.h | 19 +++++++++++++++++--
 arch/riscv/mm/init.c          | 28 ++++++++++++++++++----------
 arch/riscv/mm/physaddr.c      | 16 ++++++++++++++++
 drivers/of/fdt.c              | 11 ++++++-----
 4 files changed, 57 insertions(+), 17 deletions(-)

-- 
2.37.2

