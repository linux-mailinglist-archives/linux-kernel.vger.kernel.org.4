Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E8264926F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 06:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLKFR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 00:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiLKFR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 00:17:26 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE9613E3F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 21:17:25 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 124so6452808pfy.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 21:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0kPiXJlVEAGiE46bEmtCKOJ4JxdjDvz4UZE+PugYkgI=;
        b=zD/O2nzY7tL6eshwIf3CeY/YAQIm1xVj5/Js/pKlVUvQWsGxQvosSXAL5bONw8IRja
         NA3S79/dHcWpJuvuy9trw6RuKm57YDQCUNFpPvtYLZhGO3nfFMIvpKzeGx8mjTPJk5gq
         hw+7ezvQrKhSUi9CIBPtmx5dqGx8b4Zr7z+xZLP2OUafjrWtcGD8PRS4P8yU7dKvr6Jv
         UbbqVz0qPUqc4J5QhHhE7EjNOtQ744qnzQYQZf3qc8NljImI96wFoAZ++URfZ7JtOOme
         i8w/sViehDGjCh8JEOb2IPC1RIyIsa1SCr8haVzrurKIBxrloDk0D0MMtViqlg2ivnDO
         D2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kPiXJlVEAGiE46bEmtCKOJ4JxdjDvz4UZE+PugYkgI=;
        b=Ol/qCAjqKegDOWQyT/Fy+X18798N8pABx/alJnLloBgempch2pUP98XJF1MK0XPFey
         Eqvk5fve7OYcJ7tUiCKzwkDjnuJ7Lu+8U+55HOZ1PIu2aCOufmrVzf2pZJS3bSLa2K0p
         8z+c0U1KED6yvQnsMf3gvpB1WUl5ZXikmuVvKMLSFWj5R5YaK3HZQjKBCkfwZFfweW7l
         yii72aJ56RI41w3RAPZpjqZg1QqZV6QImRDpSk51rdFv+/DkmMnEvmFh1KH+A28L27ej
         /vpvS3i6nTNCFJePQnd7onX9tTkfMD5HqfPu6PMpE6SJr9UqocsxSsAXLGOxR1ZeRylV
         tb6g==
X-Gm-Message-State: ANoB5pneW/7gxk0orNuxdGUlFq5lswLGxWx/V2jwrBukmPwnUhJ/wEvb
        DlL9cqlXrd0lt5EwMJ7clJxwvA==
X-Google-Smtp-Source: AA0mqf6ROckMAbfbisK6rGjhVdzEf/yVRLrsZe5jClX/LxHWmHcqbWN4KyQJGM1sOsD4rukXuxv6tA==
X-Received: by 2002:aa7:904e:0:b0:56b:a2f8:1d0f with SMTP id n14-20020aa7904e000000b0056ba2f81d0fmr9918822pfo.0.1670735845341;
        Sat, 10 Dec 2022 21:17:25 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id f125-20020a623883000000b00575d90636dcsm3463684pfa.6.2022.12.10.21.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 21:17:25 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/3] KVM: arm64: Normalize cache configuration
Date:   Sun, 11 Dec 2022 14:16:57 +0900
Message-Id: <20221211051700.275761-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this change, the cache configuration of the physical CPU was
exposed to vcpus. This is problematic because the cache configuration a
vcpu sees varies when it migrates between vcpus with different cache
configurations.

Fabricate cache configuration from arm64_ftr_reg_ctrel0.sys_val, which
holds the CTR_EL0 value the userspace sees regardless of which physical
CPU it resides on.

HCR_TID2 is now always set as it is troublesome to detect the difference
of cache configurations among physical CPUs.

CSSELR_EL1 is now held in the memory instead of the corresponding
phyisccal register as the fabricated cache configuration may have a
cache level which does not exist in the physical CPU, and setting the
physical CSSELR_EL1 for the level results in an UNKNOWN behavior.

CLIDR_EL1 and CCSIDR_EL1 are now writable from the userspace so that
the VMM can restore the values saved with the old kernel.

Akihiko Odaki (3):
  arm64/sysreg: Add CCSIDR2_EL1
  arm64/cache: Move CLIDR macro definitions
  KVM: arm64: Normalize cache configuration

 arch/arm64/include/asm/cache.h             |   6 +
 arch/arm64/include/asm/kvm_arm.h           |   3 +-
 arch/arm64/include/asm/kvm_emulate.h       |   4 -
 arch/arm64/include/asm/kvm_host.h          |   6 +-
 arch/arm64/kernel/cacheinfo.c              |   5 -
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h |   2 -
 arch/arm64/kvm/reset.c                     |   1 +
 arch/arm64/kvm/sys_regs.c                  | 232 ++++++++++++---------
 arch/arm64/tools/sysreg                    |   5 +
 9 files changed, 153 insertions(+), 111 deletions(-)

-- 
2.38.1

