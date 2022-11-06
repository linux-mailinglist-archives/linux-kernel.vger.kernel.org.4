Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EA761E05F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 06:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiKFFfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 01:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiKFFf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 01:35:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9E262E1
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 22:35:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k5so7829405pjo.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 22:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoUZh4lJUYrbwudjwdWbM7Cwr0IVA3bWnluUyVYLrBY=;
        b=CZfQz2CmGeqn+3G+XO9nhVZykM8puBDwRCTbEbwO1T3oJG9CUz3EAgZnivZdIagWOu
         wfL0OnvXE+CldbKw9tP6lAObZ6x5GBMoUxKKYskLIYkyuKVkxe/NUKM54hb/txgcA4K8
         dqHfQ/x6fxAexo9dSHBQP0vHEfv0Rw7+enOfnvKCMLvAN5lUfU4/A9f/fIoOLdw105rv
         D6OTLMSEZZHAWWKP+TSmZL8rAAAFjCPqShme8N/F9dxYvAc2oeRzf3sxp4++UPVNNmS+
         BvrKo3HEakiSFe5a9hmES5hknaUufT8Zp4AEutFYL5xUZeGJrM8Az3cTJqnmOXxz616m
         Bh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoUZh4lJUYrbwudjwdWbM7Cwr0IVA3bWnluUyVYLrBY=;
        b=QBL0ltkcqDZIHMi+MrigHwfARUJ2GoSlZEER9EBq3ivSd79cq+qAdDJgKnpCT6N2ui
         C7Uq+vXZrqfUNq4mJhbQtIuXnxbDCPzVR6Di5xh/ldBcBEQRFSSEbfRCqEeVBQyPyUXc
         /mywmQlNgrIRxaDaHgN53WxhvrKsMr8afQ1vfpRckXOavX5/JlNdnpdrCbTjhSV0QkjT
         p6nfmD8KilzZ3VO5RuN3YGYY6Mw89vy+e4uwx76pz8/8m1DvknZrQ5SrzlCaKmB0tybE
         0XHZ6ZOyDNJwpCJ/X/aVBCv8O5ELEer2rHhCiQqyjOSY2FoCnSWNryMt4gFXfHfQYGcS
         7gtg==
X-Gm-Message-State: ANoB5plQZ521o0Y81w9SmuUouqdEFOJrsmEJCeTshw+DGKsfMLX/81wu
        imn7HER0iPBDnRPBtNl8aXsSNw==
X-Google-Smtp-Source: AA0mqf5fZv394AoZUuVqcgf6tPCN3Oucnp+lvMz/w4gT18G/Oiiz4YTO2j9h2FpmwFGrz9gD0KhCYQ==
X-Received: by 2002:a17:902:7044:b0:188:6d97:7aaa with SMTP id h4-20020a170902704400b001886d977aaamr8408005plt.11.1667712925904;
        Sat, 05 Nov 2022 22:35:25 -0700 (PDT)
Received: from devtp.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id q27-20020aa7961b000000b0056bee236e9csm2127121pfg.142.2022.11.05.22.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 22:35:25 -0700 (PDT)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
Subject: [PATCH v5 0/4] lib,kprobes: kretprobe scalability improvement
Date:   Sun,  6 Nov 2022 13:34:37 +0800
Message-Id: <20221106053441.103199-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102023012.6362-1-wuqiang.matt@bytedance.com>
References: <20221102023012.6362-1-wuqiang.matt@bytedance.com>
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
singly linked list) to improve the scalability of kretprobed routines.

Changes from v4:
  1) compiling failure with [-Werror=designated-init]
  2) compiling failure for sparc: prefetch() not defined
  3) comments & codes of objpool routines refined

v4 and more:
  https://lore.kernel.org/all/20221102023012.6362-1-wuqiang.matt@bytedance.com

---
 include/linux/freelist.h |  129 ------------
 include/linux/kprobes.h  |    9 +-
 include/linux/objpool.h  |  153 ++++++++++++++
 include/linux/rethook.h  |   15 +-
 kernel/kprobes.c         |   95 ++++-----
 kernel/trace/fprobe.c    |   17 +-
 kernel/trace/rethook.c   |   80 +++----
 lib/Kconfig.debug        |   11 +
 lib/Makefile             |    4 +-
 lib/objpool.c            |  487 +++++++++++++++++++++++++++++++++++++++++++
 lib/test_objpool.c       | 1052 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 1802 insertions(+), 250 deletions(-)
 create mode 100644 include/linux/objpool.h
 create mode 100644 lib/objpool.c
 create mode 100644 lib/test_objpool.c
 delete mode 100644 include/linux/freelist.h
