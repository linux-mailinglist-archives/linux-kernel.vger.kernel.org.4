Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A8B69DAF0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjBUHIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjBUHIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:08:45 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A914A274
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:08:42 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id y44so3419127ljq.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7e5rBUciBt3LW8lbyzEtnyxGuZZCI/WaI2X5+BKKS4A=;
        b=l8l7bRMadcg9l2ArSXzLPwzQ0O4OM4j/Fv+fr4aTyU0d5+ctRQolIhg9PWy9BbSWjk
         Po8GIZv7b2F7dkbfPNWiAK8kjsn8sGMvCXZ4KcImsld3IUovoVQGeUFC7FTcR7trw0kf
         MwNZLr1tXMCYRO6u+zuuHNosS5TQHAv9dBcwRLctAkH5HzeUyc2s7yR58K0bGxFAg7J3
         Vuj+c7qxUUeWWDEAR+6KvqdBRwTz+8CYNpa3Pnfukc3e9q1tm7IJkMs0uUapPBxQ7tt9
         uttSgk8tswFKDYi0fw4t2u7U2Fyip7v0ifT+Qe97afB0oetBc0NXfFdKmGDk2ooI77Cz
         b6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7e5rBUciBt3LW8lbyzEtnyxGuZZCI/WaI2X5+BKKS4A=;
        b=xoK67gpUt+VpMjaPbDUXRk+8lSvDrv8R/qfY7yTbASUQ79Pcj6tCl2wrxi5+duLI2b
         iAHNNSWBTTa7bXtBZjP5bk8jVhoiiYo9Owvhc/VMfLb5P3OaG+K5lzA+UThU52CxdOuw
         sPaZ2mW0CvWZHL213KZKWMDz/X4B+P9Wyh1cDhfVuAt4zORi7TXT3duNkvLGILBA126D
         3TTt+1drcJt2xrENqEhzh9fIuiTo5dbpvrDP3FVTCBSvSGeHxdf4c0DxEmhRWyLDP1Dq
         u1wzNxRVrheaEX62NkhFtyaOJSOl0BAzRWZbp57WZMTVdwsfph5e7MUm2bu0maE+ugbL
         /LOQ==
X-Gm-Message-State: AO0yUKVMAa35NL6eT3cua0iBobzy+Ux8ygsW7w60iucZ6U4RfgmVxPtm
        jts8avz49NeGysQDQ/DMtB8jbkDwHLgI+sbQa8A=
X-Google-Smtp-Source: AK7set9H9GSv++N7XsxvuS8OmaXXG8SjL8OwuyLnyiWcLajWwzqiPonDZ2+GwrJtlQn/aspD3kAMhg==
X-Received: by 2002:a2e:595:0:b0:294:6cde:b9f3 with SMTP id 143-20020a2e0595000000b002946cdeb9f3mr1868769ljf.37.1676963320543;
        Mon, 20 Feb 2023 23:08:40 -0800 (PST)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id f17-20020a05651c03d100b002946f95b359sm715299ljp.105.2023.02.20.23.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 23:08:39 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     sj@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH 1/2] selftests: damon: add config file
Date:   Tue, 21 Feb 2023 08:08:36 +0100
Message-Id: <20230221070837.1502935-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.39.1
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

Building and running the subsuite 'damon' of kselftest, shows the
following issues:
 selftests: damon: debugfs_attrs.sh
  /sys/kernel/debug/damon not found

By creating a config file enabling DAMON fragments in the
selftests/damon/ directory the tests pass.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/damon/config | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 tools/testing/selftests/damon/config

diff --git a/tools/testing/selftests/damon/config b/tools/testing/selftests/damon/config
new file mode 100644
index 000000000000..a6b636e438b9
--- /dev/null
+++ b/tools/testing/selftests/damon/config
@@ -0,0 +1,8 @@
+CONFIG_DEBUG_SYSFS=y
+CONFIG_DAMON=y
+CONFIG_DAMON_SYSFS=y
+CONFIG_DAMON_DBGFS=y
+CONFIG_DAMON_PADDR=y
+CONFIG_DAMON_VADDR=y
+CONFIG_DAMON_RECLAIM=y
+CONFIG_DAMON_LRU_SORT=y
-- 
2.39.1

