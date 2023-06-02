Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A68720813
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbjFBRCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbjFBRCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:02:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515501A4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:02:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb0cb2e67c5so3028684276.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685725370; x=1688317370;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yIiKOLGKczROWKwulUVtZ2M9/BiqL1vWmyT9WxaSM60=;
        b=pgEp6VvqA7aBhrJuKZzQ4zBVM03oPZHiD+4ylV7AFMyKOKMZY+kiaxDz5l0Ypk+iO2
         MUF7c2eCaBHPpjtDiRh4GgjpTtJsKr/1ezP7uIgCNumlJZWWgEbgxSkLBGDTITBINiP0
         h/+lY9p5RUWI1mm3RgI0TT6fMDQdeLaT406FqAvUvjluat/s5sl9h9AAkK/1H2Hx1sPb
         TIkOmqDFjvVeSWe6Fnaup3uBKk9/wxZeRRXAEAdCIgNMknlLeaSgWKp6DPYDAKTDliwK
         r7EIWTuWCPHj9hwA5oafkO5VzVh8JjN1pTIPxJYZHGvkqCYUIOhocoXxB+jqaTvCi1vw
         DqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685725370; x=1688317370;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yIiKOLGKczROWKwulUVtZ2M9/BiqL1vWmyT9WxaSM60=;
        b=dAXdyvLNFO+AgEHfMVRMyKmx7F1C2IbIjMZwp0Kw8AFEKRFEoi0zr2L/3sN0M8ij5o
         pSJPaQP0in9iXxVEo8olTf9MZF8W7r2a8y9VfOmkYhsO793kmrJEpQmsArGBkWoEKvhc
         rSCRMlkXFwEPzhce5etsCSHgb+M+ljjqCd/iiQOgs55MU9NnUYvtmcMATQvPZo7JleVQ
         TkEmNb+PNy229rbszZodqXvo/yJZJRv++wtOVYdQiAvy4TPoLO2fQUx1hRO9A+5/uJQ9
         nwHtHJN1CMoZZlKru2P2fPSiPuxKpS3+6wHFvSnWp3g61I2l+qF9QdQ8WOk3DB8JtZUz
         chAQ==
X-Gm-Message-State: AC+VfDyAe0OWhNqvVd2HY+gSOwxDjj81rf+beOdRqWcYXQeQW/lLuG76
        q/9MLrEhzlYrJEXIlNAlq9IBL+CMVbBvKKtTPQ==
X-Google-Smtp-Source: ACHHUZ6Vu7NrmZDIrdvPM8A+x+HDDvlXsWN3Wbj3yjrPjyPq4Je9swBQszqmoLNylUJ2YOeY/0U1p8/9fWz27M9x5g==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6902:114b:b0:bad:89:29d5 with SMTP
 id p11-20020a056902114b00b00bad008929d5mr1364181ybu.2.1685725370603; Fri, 02
 Jun 2023 10:02:50 -0700 (PDT)
Date:   Fri,  2 Jun 2023 17:01:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602170147.1541355-1-coltonlewis@google.com>
Subject: [PATCH 0/3] Relax break-before-make use with FEAT_BBM
From:   Colton Lewis <coltonlewis@google.com>
To:     kvm@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently KVM follows the lengthy break-before-make process every time
the page size changes, which requires KVM to do a broadcast TLB
invalidation and data serialization for every affected page table
entry. This is expensive.

FEAT_BBM Level 2 support precludes the need to follow the whole
process when page size is the only thing that changed. This series
detects said support and avoids the unnecessary expensive operations,
speeding up the execution of the stage2 page table walkers.

Considerable time and effort has been spent trying to measure the
performance benefit, mainly using dirty_log_perf_test with huge pages,
but nothing was seen that stood out from ordinary variation between
runs. This is puzzling, but getting the series reviewed anyway may
spark some ideas.

This is based on kvmarm-6.4 + Ricardo's eager page splitting series
[1] to cover the eager splitting case as well. Similar changes were
originally part of that series but it was suggested FEAT_BBM should be
its own series.

[1] https://lore.kernel.org/kvmarm/20230426172330.1439644-1-ricarkol@google.com/

Colton Lewis (2):
  KVM: arm64: Clear possible conflict aborts
  KVM: arm64: Skip break phase when we have FEAT_BBM level 2

Ricardo Koller (1):
  arm64: Add a capability for FEAT_BBM level 2

 arch/arm64/include/asm/esr.h   |  1 +
 arch/arm64/kernel/cpufeature.c | 11 +++++++
 arch/arm64/kvm/hyp/pgtable.c   | 58 ++++++++++++++++++++++++++++++----
 arch/arm64/kvm/mmu.c           |  6 ++++
 arch/arm64/tools/cpucaps       |  1 +
 5 files changed, 70 insertions(+), 7 deletions(-)

--
2.41.0.rc0.172.g3f132b7071-goog
