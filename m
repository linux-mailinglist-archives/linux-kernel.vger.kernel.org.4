Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072C164FDA8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 06:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiLRFEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 00:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiLRFEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 00:04:06 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8151CE19
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 21:03:40 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v23so889512pju.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 21:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=inXEajzLzHrYa1MiEvHFJL5aAucCwzDSfIbGNe8cXzI=;
        b=VLfCqZFmlOW7xCOi34/MigZHTURtFYXxqVaVzshTbyjHAxpChZSc18esacXFpc3OvR
         wMfmU+B1IBMPsflH0izQL+vnyW7hJectNmU8FrSgV84jHL8980OJma3CVbw/h6H+kvf1
         nw3hkEgdyG4wLBwNcYh1uRjQwHvFUVL65ITt9NVVjZb+/oCTF3H24OyPbF1QNwWenRuj
         G5uWok2LTXKv9PWcv8AZ4Ca77qN3b7tX4iWg6eWYBy44V8JGxNsv3VbaXP5OxIR1ReE0
         J2dac8MOIFI/XRpFioybwfeAU3PYtvwg8TePok2FiLcq3slh+C4h6YNN9kuk49LUeCLq
         6nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=inXEajzLzHrYa1MiEvHFJL5aAucCwzDSfIbGNe8cXzI=;
        b=072HdspjYuii0NX/jWt6fBvRGtkmz/ctR3THrH40BFdpfx8kVgJ7k8G5276KASEZQr
         mr0uhB4AscDCCsqoLAGI2nd5yH2ROolgYg73VSJdW0piYOMERgvpJq52mOGfq+QqkIfD
         QH/xs3ezBGch2XjXz1OGX62PxxizqHlLL3N0arQrBdmdMIh7sg2Tj7MObKnsNB8XVero
         f5AyiqdZwpy1YLCrUzkKoFd1SRryJfqcRaSB+xUFm3iPn7Wa4RREFlwn/twccPZ3ub7o
         T3d7jtZyA3PnJ+dYaeTTcJc0MN7j2e0NJxPH/dOrLeb8kOtzhxICjR6JrdkKTr4/i4xO
         EV5Q==
X-Gm-Message-State: ANoB5pnuYhJ+RpL5c0uOelsTH5uk9FVl8/mXRec5Uu6V/H7ekDJCVphc
        HqE4uI97aVAFW26jJIkQ4KkFmg==
X-Google-Smtp-Source: AA0mqf6iMy3zgo0GIZwi1aMmVzDPetDDsFNfUSm/jc4NSYrTQuJMqqhv2et/JXEc4wLYwh8qZyg6yQ==
X-Received: by 2002:a17:902:d4c3:b0:189:c322:df3a with SMTP id o3-20020a170902d4c300b00189c322df3amr53080097plg.43.1671339820146;
        Sat, 17 Dec 2022 21:03:40 -0800 (PST)
Received: from devtp.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id v20-20020a170902ca9400b001708c4ebbaesm4339348pld.309.2022.12.17.21.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 21:03:39 -0800 (PST)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        wuqiang <wuqiang.matt@bytedance.com>
Subject: [PATCH v8 0/5] lib,kprobes: kretprobe scalability improvement
Date:   Sun, 18 Dec 2022 13:03:05 +0800
Message-Id: <20221218050310.1338630-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces a scalable and lockless ring-array based
object pool and replaces the original freelist (a LIFO queue based on
singly linked list) to improve scalability of kretprobed routines.

v8:
  1) objpool: refcount added for objpool lifecycle management

v7:
  1) objpool: implementation simplified as Masami advised
  2) rethook_alloc: error codes returning supported (ERR_PTR)
  3) MAINTAINERS: support added for objpool files
  4) synced to latest 6.1 with x86_64/x86/aarch64 verified

wuqiang (5):
  lib: objpool added: ring-array based lockless MPMC queue
  lib: objpool test module added
  kprobes: kretprobe scalability improvement with objpool
  kprobes: freelist.h removed
  MAINTAINERS: objpool added

 MAINTAINERS              |   7 +
 include/linux/freelist.h | 129 --------
 include/linux/kprobes.h  |  11 +-
 include/linux/objpool.h  | 116 +++++++
 include/linux/rethook.h  |  16 +-
 kernel/kprobes.c         |  93 +++---
 kernel/trace/fprobe.c    |  37 +--
 kernel/trace/rethook.c   |  91 +++---
 lib/Kconfig.debug        |  11 +
 lib/Makefile             |   4 +-
 lib/objpool.c            | 372 +++++++++++++++++++++
 lib/test_objpool.c       | 682 +++++++++++++++++++++++++++++++++++++++
 12 files changed, 1292 insertions(+), 277 deletions(-)
 delete mode 100644 include/linux/freelist.h
 create mode 100644 include/linux/objpool.h
 create mode 100644 lib/objpool.c
 create mode 100644 lib/test_objpool.c

-- 
2.34.1

