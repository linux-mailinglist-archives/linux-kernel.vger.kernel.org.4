Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785946DF06C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjDLJaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjDLJaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:30:07 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933666A40
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:29:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id o1so13883140lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681291749; x=1683883749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rcb/qkDEsQAl3olw9yoUk92A6JDi4rIg7+uNlXHrrCs=;
        b=Alwr349E2yAIHR5wfg8SEgSZr/CCUPuG2GWmqALnr6hK6vdoizML4AWTfimx5up2SW
         cE8J8yP2FMiI6DphLH5GAuGP9jFQhyHr9B9gpzG3o/XOmdzNTJsNKzZ5rhtiPrnMoNN6
         tUkso/4ZDUl4jc01UGsKK7npR707zP10BciQhEVCmXgwtI00WG/ModH5mWWI2Qd3ge23
         eZl6c9m0Ll4esPo6mtIne1N0Vq8tCTxps5632eE7aeNA4kvMdRQaqD56z2m+mnJ5V+Se
         BkbwY8oyLEn7hwSO6+DUHUqZYLNHPwaXJBiwSQp7AkruLSQZxZi+nSJh82LvrlrrozpN
         kReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681291749; x=1683883749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcb/qkDEsQAl3olw9yoUk92A6JDi4rIg7+uNlXHrrCs=;
        b=hCYUfMZR8sLg+kvZf1v0BPoatoHT+zad8PUr4e9+WqyMkt81wlNavH8DLxCccHAkA7
         2y8VwAPLjY927hS7J3B4bX6WCm6omOjTmpHh4fXpBCBZ+FivOLDkrv/YaYS8sHjzC/RS
         ODSTSDS3wGNzY7lqR3jYr2g1uyKC06EaYA3auQHUDUmOPUGbm4Kex3J8jhBkJm0o+Jyz
         knJb85OIFPUQSNGpanv3fbtZSjWzkXnBH3AD9GEzsfHHd599BrO0MXMxw5HNLZXzaRN+
         M2cXKAYHeVPve/8HmtTs/wEh61VsC74V1nG5NWh/bIuBkS7e3ooLlhJPjrsRF5R1/wnq
         4pLA==
X-Gm-Message-State: AAQBX9eriba8PYKrIGY265p/TzwA1RhyE3ZqcDuRh1lv2hLwCmTAbNCC
        NA8O7XyBBUbEmIsGROBIc/7EYA==
X-Google-Smtp-Source: AKy350ZowSyMYKkqTf7keNy16KvCpT3A3P84fOVnNItqH3nenGNIhyEzgSn0fOn/v5tDeetQ9TjNjA==
X-Received: by 2002:a19:ad0c:0:b0:4e8:4489:6f06 with SMTP id t12-20020a19ad0c000000b004e844896f06mr3826521lfc.58.1681291749100;
        Wed, 12 Apr 2023 02:29:09 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id i12-20020ac2522c000000b004db3e330dcesm2959121lfl.178.2023.04.12.02.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 02:29:08 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     sj@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCHv2] selftests: damon: add config file
Date:   Wed, 12 Apr 2023 11:28:54 +0200
Message-Id: <20230412092854.3306197-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building and running the subsuite 'damon' of kselftest, shows the
following issues:
 selftests: damon: debugfs_attrs.sh
  /sys/kernel/debug/damon not found

By creating a config file enabling DAMON fragments in the
selftests/damon/ directory the tests pass.

Fixes: b348eb7abd09 ("mm/damon: add user space selftests")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/damon/config | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 tools/testing/selftests/damon/config

diff --git a/tools/testing/selftests/damon/config b/tools/testing/selftests/damon/config
new file mode 100644
index 000000000000..0daf38974eb0
--- /dev/null
+++ b/tools/testing/selftests/damon/config
@@ -0,0 +1,7 @@
+CONFIG_DAMON=y
+CONFIG_DAMON_SYSFS=y
+CONFIG_DAMON_DBGFS=y
+CONFIG_DAMON_PADDR=y
+CONFIG_DAMON_VADDR=y
+CONFIG_DAMON_RECLAIM=y
+CONFIG_DAMON_LRU_SORT=y
-- 
2.39.2

