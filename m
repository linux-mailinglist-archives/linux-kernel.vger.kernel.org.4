Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36C47157E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjE3IEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjE3IEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:04:36 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F91EA1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:04:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f60e730bf2so42898185e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685433874; x=1688025874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RjdcHakCzRp2uDPOf1QJOq47vmihq6bx2AuDxoEXfOE=;
        b=FDmwQIBU+rDZiJvbW1YTb6Nvtv32CT3waSZraGR5m0N/Ms1Hp4lSo9Cjsgx0SEuSex
         G7kgDEEDswd6pBtrVkoYvLUf48IXqIoDPi6HcJa672ZxeKgNQe3jKbnlg7nS5ZbJAErG
         BcpjlO6WedDL2jJ7QGURxWfRh+kEtQi4jrqUn62BBZtLnjtNq86oWP7St++e9x2zSpgO
         GSMJmPalS5q7PHUPPtpjq9yxF1mDEMvYcyMsFNK33+vhn6r/xi5uMhiLsm0BvNGhHWpa
         fAnVIfUp5JI106rZE2MESeh4Iw+o2yHf4TdOtfMeGL7HqA0daZj7wo5o/gPK8jDUKuMK
         +DNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685433874; x=1688025874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjdcHakCzRp2uDPOf1QJOq47vmihq6bx2AuDxoEXfOE=;
        b=FkRLxFwhW7lwX6VGc7w3L3DSpzzv/1mKxEwJQid2gSbUgndv5g8ntwfYm9HH+GdbqD
         dLYqZ9fUse1EY8wxHwZ42n19lO5C5WNiGBA+Vnmyw2TdMwwU1vzwWQJYFvjKLZ5IuLUl
         EfQ3Zyur+lXFpLS9ZXJYf2qu0TAMmDIzxUn4lRajfO/tyWRYLa3uKEwyATYtUFd8vum3
         61gYjb0XqnxuX0w23BcJJH92vYsQuz2V6WC6ZO6RFPjq7vydZ6m9HDW89RpqV1/MIFWr
         xQqPVM4BnjDLsRzhKxB66L8VDYtRDC8n52KKscfVjlPRytYoKBHX2TH/hphJfj4R/mEL
         ZoNg==
X-Gm-Message-State: AC+VfDxyEMDy+MLH1SksUE1XXpQmkByQU/vLO0uHGjOP5+QqZaZEk7uw
        Y7mvlKiIrYSsuQzvicQwJkBvgJH3dgoCLq7a4tE=
X-Google-Smtp-Source: ACHHUZ4EXH26JifnRLV35t73W7c9aZ6OsRaB13FCf0u1UgCoCH3BzpbjGhbi2O2/JVao2KQatBmCug==
X-Received: by 2002:a7b:ce96:0:b0:3f4:2174:b28a with SMTP id q22-20020a7bce96000000b003f42174b28amr1280948wmj.15.1685433873743;
        Tue, 30 May 2023 01:04:33 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id f12-20020a7bcd0c000000b003f601a31ca2sm16762193wmj.33.2023.05.30.01.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:04:33 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [RFC PATCH 0/1] fdt: Mark "/reserved-memory" nodes as nosave if !reusable
Date:   Tue, 30 May 2023 10:04:24 +0200
Message-Id: <20230530080425.18612-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the RISC-V kernel, the firmware does not mark the region it uses as
"no-map" so that the kernel can avoid having holes in the linear mapping
and then use larger pages.

But with the recent support of hibernation on RISC-V, we noticed that
the hibernation process was trying to access those firmware regions
which are protected from *all* accesses (using PMP). So the hibernation
process fails.

We still don't have any "specification" regarding the naming of those
firmware regions, so we can't currently target those specific regions
(they are described as subnodes of "/reserved-memory").

I think we should actually mark all those "/reserved-memory" regions as
"nosave" since they should not be used by the kernel (see the
documentation pointed in the patch), hence the RFC since I may be
missing something here (legacy, other usage...etc).

Please let me know what you think!

Alexandre Ghiti (1):
  fdt: Mark "/reserved-memory" nodes as nosave if !reusable

 arch/riscv/kernel/setup.c |  2 +
 drivers/of/fdt.c          | 77 +++++++++++++++++++++++++++++++++++++++
 include/linux/of_fdt.h    |  1 +
 3 files changed, 80 insertions(+)

-- 
2.39.2

