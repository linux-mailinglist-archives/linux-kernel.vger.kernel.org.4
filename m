Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB1645F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiLGQnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiLGQnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:43:51 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30CA5CD12
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 08:43:50 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id c1-20020a2e9d81000000b00279805978a3so5315805ljj.14
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 08:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r5PgP+WJc71MoSmOYpj5ZrReovCQD8z66dlPR1F1GrM=;
        b=h9q0oCHCkezL9bDcUnUZehUq9NrDktR3pPdxA0ghKptzKRHhcO2Mv6ffgYXhhMeTDw
         3FlcN+joto2hVxpALrei69fw2jCyeGk5p7m5lmzIDnjhePyRGuuBtmYNubWlxdMVK49Y
         IVV5EE3mzt94gpt82itT0ZFT8QItcd08SK86g0AGo6ngMZwCoKR6cdvgfvos3oRPHPxm
         tF6/LRGg+seULJgO40IOq/plN5pjqSzzUO34tFei2DWC3m+kZsKDqiSCp8eZagMMhxgj
         +ItjPwSETCeT6fe4tmoRZbgdO5ItNgQhm7kWj+A0E/xc4YFlX43nKiMBX+Bho0D+5gMP
         8A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5PgP+WJc71MoSmOYpj5ZrReovCQD8z66dlPR1F1GrM=;
        b=O8hJjhNX9sHkJDLCCvHZ55FpLLOAWORH60gbZrwu0WbFRjSk82Tpymp84lBlFRiYZM
         4/LtVyhwb5t3bFpGNlatJoWCjW90RWUun5ACMGu2/4CTgb1X+nQNRctDccYM6No3E4Ew
         yO/jfpChuJxqJSSDiApUGuzB5KESfUKucq3Ir5ysBInA+Ivq950XqQjF2WNvdBXGyg9b
         TRcAzmPle22YHX+sO2pK2aMKiJDhuHaCeoJiRacGSFy80mFUWipbZ+F9lfoOaBVSfDTM
         RKP7pN/DXEjCITRL1ieKtsbxSyURZZp8O6gYoQN1dKzu10x2UnGvOVlgDfD9jrqRJQH2
         kzxQ==
X-Gm-Message-State: ANoB5pm4F4zAgujx5ZPPKS67GGsUzPhWqN8tdfH1huoB2owf1/0c5G8u
        iPc008Dxpxt1a4rOHxBUxz5YbrcdinwBLk5z
X-Google-Smtp-Source: AA0mqf5YcwjHlHtRqgfuPiOeL0r+c+V4UkIP7YmZTgX6L+0JEuChdLtOGmf84VQTuN/80Q8EuPv3BvX29fAGZV0Z
X-Received: from mclapinski.waw.corp.google.com ([2a00:79e0:9b:0:3d6d:f78e:bc73:df])
 (user=mclapinski job=sendgmr) by 2002:ac2:518f:0:b0:4b4:9227:3565 with SMTP
 id u15-20020ac2518f000000b004b492273565mr34808968lfi.290.1670431429015; Wed,
 07 Dec 2022 08:43:49 -0800 (PST)
Date:   Wed,  7 Dec 2022 17:43:36 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207164338.1535591-1-mclapinski@google.com>
Subject: [PATCH 0/2] sched/membarrier, selftests: Introduce MEMBARRIER_CMD_GET_REGISTRATIONS
From:   Michal Clapinski <mclapinski@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrei Vagin <avagin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change provides a method to query previously issued registrations.
It's needed for CRIU (checkpoint/restore in userspace). Before this
change we had to issue private membarrier commands during checkpoint -
if they succeeded, they must have been registered. Unfortunately global
membarrier succeeds even on unregistered processes, so there was no way to
tell if MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED had been issued or not.

CRIU is run after the process has been frozen with ptrace, so we don't
have to worry too much about the result of running this command in parallel
with registration commands.

Michal Clapinski (2):
  sched/membarrier: Introduce MEMBARRIER_CMD_GET_REGISTRATIONS
  selftests/membarrier: Test MEMBARRIER_CMD_GET_REGISTRATIONS

 include/uapi/linux/membarrier.h               |  4 ++
 kernel/sched/membarrier.c                     | 39 ++++++++++++++++++-
 .../membarrier/membarrier_test_impl.h         | 33 ++++++++++++++++
 .../membarrier/membarrier_test_multi_thread.c |  2 +-
 .../membarrier_test_single_thread.c           |  6 ++-
 5 files changed, 81 insertions(+), 3 deletions(-)

-- 
2.39.0.rc0.267.gcb52ba06e7-goog

