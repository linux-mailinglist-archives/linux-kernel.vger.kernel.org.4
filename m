Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC14F649EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiLLMcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiLLMcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:32:35 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD35CF025
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:32:32 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o12so11864516pjo.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgZqsgFPlB2r29EuVp4P4X4aSqIJdTCkcI1OXU5kHKI=;
        b=xUD0yI4I0FjcHE50SeF+tpxonSL5ArNXKxRfZbPv3pU7F3jNRAIRRnHG2aWxHO5GN2
         DP3p2LqWhtBDfCAtA6btcLs3HA1EIzKUwlBoSobuy5pI7Zf+9vFl6OnP/Gg+NlbVJzX0
         fQ6LsfWMKSuuvu/Ks16CN7IrNTIzM8IoUXWzvMo6rACSk2Nq9z1lz+75hrv6Ol5smabp
         lmsw3i4UBv7JDSrQR7B7pqa1Xh9GK5BlynkAVuh+7s7E2W1PLqC7acaGAGqIC7n6OIJx
         9BpY80BulF5JUAksEHIqSc/1CR6XEFwJGv/stumQxpUXaqRUAMungMOMn4dt4SzSOANU
         MUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgZqsgFPlB2r29EuVp4P4X4aSqIJdTCkcI1OXU5kHKI=;
        b=jB9oD9RVR/5jHwtjBYVIQATPvLhdcc4GtFrdkbJT1I443OY+1ScmbLKm1mHzIc+BrJ
         Fa05fDJkp/KWv59NG6oP3+41RTbfaC+ibCpXiTx914NdG02/N9beIjf9F3RyQwfcN2E9
         1HpfeZVinRTr9r1eWdbKxYxkeNcGZ9V2VhTnfZOWKWasRnHFjAXcUxXuAaIjvVlYTOIB
         rce04EM7kYrRjtHW2BNBzFK9Mi8DJdBbAd9T4ggG0MSTuxKVsruKCBX4Al7ZZn6VZgoT
         Qev4QZZH3T6rVFnR2E8hQguZ0jTRFP+FPEA0cHd4HytmAFDLxkhjdchqQ4aNXFoml6iN
         C6MA==
X-Gm-Message-State: ANoB5pkEbUTc0K9FHC9FbysuMoMFtzODuU8oJ6GExJU8tlCXIXHh6nQQ
        qlHPxWwAAUw8lkjN2LRAP/KLEQ==
X-Google-Smtp-Source: AA0mqf7TYG9A/OzS7GQ3QV8NulNDvdorVrfKuWe+gujRPExDTXf7Tm0QzTkQlHS54WKmUmyCibzVMQ==
X-Received: by 2002:a17:902:cf0a:b0:189:5bd:10aa with SMTP id i10-20020a170902cf0a00b0018905bd10aamr16238707plg.58.1670848352423;
        Mon, 12 Dec 2022 04:32:32 -0800 (PST)
Received: from devtp.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id jw1-20020a170903278100b001869ba04c83sm6219987plb.245.2022.12.12.04.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:32:32 -0800 (PST)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        wuqiang <wuqiang.matt@bytedance.com>
Subject: [PATCH v7 0/5] lib,kprobes: kretprobe scalability improvement
Date:   Mon, 12 Dec 2022 20:31:48 +0800
Message-Id: <20221212123153.190888-1-wuqiang.matt@bytedance.com>
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

Changes from v6 (https://lore.kernel.org/lkml/20221108071443.258794-1-wuqiang.matt@bytedance.com/):
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
 include/linux/kprobes.h  |   9 +-
 include/linux/objpool.h  | 109 ++++++
 include/linux/rethook.h  |  14 +-
 kernel/kprobes.c         | 101 +++---
 kernel/trace/fprobe.c    |  37 +--
 kernel/trace/rethook.c   |  99 +++---
 lib/Kconfig.debug        |  11 +
 lib/Makefile             |   4 +-
 lib/objpool.c            | 320 ++++++++++++++++++
 lib/test_objpool.c       | 696 +++++++++++++++++++++++++++++++++++++++
 12 files changed, 1264 insertions(+), 272 deletions(-)
 delete mode 100644 include/linux/freelist.h
 create mode 100644 include/linux/objpool.h
 create mode 100644 lib/objpool.c
 create mode 100644 lib/test_objpool.c

-- 
2.34.1

