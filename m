Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080AB6C6DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjCWQfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjCWQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:35:32 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1ED2B2A3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:34:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n19so3754077wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679589238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T02CoPQSjHJPYyXwCzD6p0CGnIKFhz0kSb8bJB6ht4Y=;
        b=EUVRSjxbLKVq8hDCxjrO+6jyd+BmL2kHZodwrBzrSopYstJqfGNjdbsvfTB3pLT1mh
         0s/EBYsmGU7UR8u/QAmRPbRZ/TyjvS1nigC+yHT23S1G4PW83MoLc3GPDkiiozO4jAqD
         xQHlG/ubsdOA92CkNvn8QVIpVgwWZJuLsif2ynfXI8532m2W7/tuMJaf/kEm+uysZTcL
         5BMB36hsZQ+Eoiy08zwZgkKsoPwVqUdWs2mNmdVesyjBqx9xdUThaS87VTdwdtkZtXF9
         z2GVeNjd8QlQufpj7rP0/zEqZ1v01nCy0GxdRayI5Gr8Txk8tMrh41ci/YHrrW0XNB5/
         ccOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679589238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T02CoPQSjHJPYyXwCzD6p0CGnIKFhz0kSb8bJB6ht4Y=;
        b=YaujTERGsm4BaRMYSBl9BHqFVKU9j0hN+Z9DRFI+LYKFhNT9VDEhNKb77bW1rFvFqB
         kP0EkaAQxd3tFysrPw550M+AUddBohglC1JkfVn/Ye9Zc7YYCd7zdSVjVwwY3CUhLY/8
         QuccHcYipbOdgB9bPdsIobCw13PCTiigEyPH269Twe6HZyLPfIujxXtAHuaRNgcL7Ok/
         R1oIPzhGTUg043Eval1v5rRCnTd4/d7nRKXIXMaTrRXSam78/IK/RI8b15poQcXsV9aN
         SrGvZcMYuRe9F8RV14MzSv5tGUL79W4OmdS4hDkNqi0qSRLvzisK0mjeObg8zEufQxgI
         WZuQ==
X-Gm-Message-State: AO0yUKUM3ujxkGcIHlg5ecJfV3A7NCNalFQ/swvRw7Mj/ugy2SnmLHTM
        qb6kFwvT8noq0XMiqEBmrRgD3Q==
X-Google-Smtp-Source: AK7set8Aj3DqH142gpbpe2Stg7uZNFfdNostTY7WbhAwUM7bAKFCiIArytMk9L+BB1rZ2e67txdRnQ==
X-Received: by 2002:a7b:cd0d:0:b0:3ed:df74:bac7 with SMTP id f13-20020a7bcd0d000000b003eddf74bac7mr171034wmj.21.1679589237974;
        Thu, 23 Mar 2023 09:33:57 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c1c0900b003ee6aa4e6a9sm2550735wms.5.2023.03.23.09.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 09:33:57 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes 0/2] Fixes for dtb mapping
Date:   Thu, 23 Mar 2023 17:33:45 +0100
Message-Id: <20230323163347.182895-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to map the dtb differently between early_pg_dir and
swapper_pg_dir which caused issues when we referenced addresses from
the early mapping with swapper_pg_dir (reserved_mem): move the dtb mapping
to the fixmap region in patch 1, which allows to simplify dtb handling in
patch 2.

base-commit-tag: v6.3-rc3

Alexandre Ghiti (2):
  riscv: Move early dtb mapping into the fixmap region
  riscv: Do not set initial_boot_params to the linear address of the dtb

 Documentation/riscv/vm-layout.rst |  6 +--
 arch/riscv/include/asm/fixmap.h   |  8 +++
 arch/riscv/include/asm/pgtable.h  |  8 ++-
 arch/riscv/kernel/setup.c         |  6 +--
 arch/riscv/mm/init.c              | 82 ++++++++++++++-----------------
 5 files changed, 54 insertions(+), 56 deletions(-)

-- 
2.37.2

