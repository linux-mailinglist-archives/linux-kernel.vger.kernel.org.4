Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AA56CBBA8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjC1J7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjC1J6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:58:53 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ABF55B4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:58:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y2so7569763pfw.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679997508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6MISSvCouqA9cx2hoXCbIEOFQ/tw2bO4d83GG2zGgvE=;
        b=H20nkFH8jnbFmpaVjh1mbdMO4PnytobUbAcaDCPto/03C4ZSTbY+dBC4tmYFmST1km
         zykxLgDoF1caGudo0a3QxXnlL+P+qXERqMeAiIKI+Hq9XX3I88mHJELZJPOcK/5oDtur
         9rhlcQgPkOYYH+Rpz1WfPb5STPlj70eNgl8t2oDspeGD5ir09PKjJN/a+Hm9wQFdH5T+
         YVSIPggQ4i1QJVlMX5D0t0a0dsnITytGDOauSV2E7FA+zkfCMr1QwTCU340iyfMcatKG
         EPZhtVAXiRY7SE/c6jr0IBlKdhly/WHs5rCG9a1ei8QvlvntAnPkhRKZu1E/c1/65Pb5
         MkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679997508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MISSvCouqA9cx2hoXCbIEOFQ/tw2bO4d83GG2zGgvE=;
        b=y8zYf/vEcwX3ULo03HamnQ8Irm8Q1g1qIGlcvIEttt9mPOhHLC6OVNOo8vdlrUf+cd
         lg+teLRVB875YMzHIfk3o42fsgQDD7JpNynNAmB208wrOVpoVjIfYltbhkErGlmEwR85
         K/oTufBwJMb6+h0C0IFUPnPiCib+w/MmwZomwr93WWhzeNECwBgMcp5FbXnY7ddbH5vn
         MpYsoT1HbR5LTnM48kfs/UEdtpk638w3IzMfh6ibpz0k3TZUYGBjuCaN/bgWiif5jXhr
         b5iWDDMIXyI4spxQR/FYYe5noKBym+QX67dYZERAEZMKmDwx9Vjtkfg1GNWYnxnNgJP5
         0z2g==
X-Gm-Message-State: AAQBX9fHEyovtv3ZkbcQsa0yU89NCwJ3ibJsA4nn6uXnPryHRZ5aAeL/
        mpC65eJIABbAYDcKfG4hfxq4jw==
X-Google-Smtp-Source: AK7set+cnJoJUdFAfbXEnGQHJUiqklLiq6LlORGWCRd1drU83/ieImpxAZqlIvMwNPK2C285YgpNgA==
X-Received: by 2002:aa7:9629:0:b0:628:1274:4d60 with SMTP id r9-20020aa79629000000b0062812744d60mr15936639pfg.21.1679997507878;
        Tue, 28 Mar 2023 02:58:27 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id m26-20020aa78a1a000000b005a8a5be96b2sm17207556pfa.104.2023.03.28.02.58.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Mar 2023 02:58:27 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, jannh@google.com, sjpark@amazon.de,
        muchun.song@linux.dev
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/6] Simplify kfence code
Date:   Tue, 28 Mar 2023 17:58:01 +0800
Message-Id: <20230328095807.7014-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
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

This series aims to simplify kfence code, please review each patch separately.

Thanks.

Muchun Song (6):
  mm: kfence: simplify kfence pool initialization
  mm: kfence: check kfence pool size at building time
  mm: kfence: make kfence_protect_page() void
  mm: kfence: remove useless check for CONFIG_KFENCE_NUM_OBJECTS
  mm: kfence: change kfence pool page layout
  mm: kfence: replace ALIGN_DOWN(x, PAGE_SIZE) with PAGE_ALIGN_DOWN(x)

 arch/arm/include/asm/kfence.h     |   4 +-
 arch/arm64/include/asm/kfence.h   |   4 +-
 arch/parisc/include/asm/kfence.h  |   7 +-
 arch/powerpc/include/asm/kfence.h |   8 +-
 arch/riscv/include/asm/kfence.h   |   4 +-
 arch/s390/include/asm/kfence.h    |   3 +-
 arch/x86/include/asm/kfence.h     |   9 +-
 include/linux/kfence.h            |   8 +-
 mm/kfence/core.c                  | 229 +++++++++++++-------------------------
 mm/kfence/kfence.h                |   2 +-
 mm/kfence/kfence_test.c           |  14 ---
 11 files changed, 89 insertions(+), 203 deletions(-)

-- 
2.11.0

