Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A46209E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiKHHPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiKHHPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:15:37 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8349F303E6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 23:15:36 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id io19so13384604plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 23:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTRxaMELJJiuG2mPZ2ieFv6AwJIDZENJ2zyMY1a2RCA=;
        b=DAqqRrIPvl2h3rjaq+BsjU2miMrfNF0HkO2W7kRATjVY0/rlKhd64kdWeD2C+AfssX
         v14O/2Qzk0tUlSiSP8nNpDdYshHTjXrFK0Qwh5fSQVrIRcCCzbS93fq8sVS72R55hn6K
         hKnv8ERnM9Yd6EA73377j5iS4TI8+5RQYkV5SfJ+0a5KGpakO0SH6bDDsJCHTj2bux3m
         YJuO1RBsDYv/AVIugwLVq5Ufzq2XBxfe07XSjyRbCnMdQBiaAU7I4NpkoOhWn2SYf/8D
         FmFO0S3kS6tPsmktZSyuc/vQSZEpTa0gEM+mB+9NZZ5pL4MfeQGvi3eZha1dlcDuWi7y
         0O/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTRxaMELJJiuG2mPZ2ieFv6AwJIDZENJ2zyMY1a2RCA=;
        b=Yk+jLUQCp6MtWqKGkGxHagongrF+GWj9SZG5vnQ1enZhsYet1LPart9sDWTo7I2FRX
         xjfg/Yh9tSAD/ZT6Qlt1PSmG4FmJh21+eH63DkmvVao6bz/uX10fSz6sem/p5O7TocDu
         amsv9KBRRYNQbsPrHFdn0FiKpucwXqSWoThhMvLJT+ok37ytNbaMkbtRnc9B68VvCR0S
         jsoZO52EeZVxmkxNqv2dI8SDndCTQtRxGWONfbXCB6Op8P6fxidzaMxHCGqns2iwX8Ar
         Sp8ePU6wxO7t+t4pv+NWFIsiu99uAPo+wVDrhThzFs/Vz3dtn2CFRQIGHIQMPaDRSRZR
         abmg==
X-Gm-Message-State: ACrzQf0ue8vp/LnjVOGCPNie6tn3uVen5mvukVqzm5vMT3tqfet02Uim
        lCMkVBpWuLYtTb82BM9QuX3ZJA==
X-Google-Smtp-Source: AMsMyM53252F7pCjV0mrh1M0YZ1MBHlJDikDvXCMQQb2LIDrLEzJkdOqouozuJG7gWbDRRd70HP7ag==
X-Received: by 2002:a17:90a:164f:b0:213:bda6:2873 with SMTP id x15-20020a17090a164f00b00213bda62873mr50673063pje.215.1667891736059;
        Mon, 07 Nov 2022 23:15:36 -0800 (PST)
Received: from devtp.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902f68c00b0017f592a7eccsm6123918plg.298.2022.11.07.23.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 23:15:35 -0800 (PST)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        wuqiang <wuqiang.matt@bytedance.com>
Subject: [PATCH v6 0/4] lib,kprobes: kretprobe scalability improvement
Date:   Tue,  8 Nov 2022 15:14:39 +0800
Message-Id: <20221108071443.258794-1-wuqiang.matt@bytedance.com>
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

Changes from v5 (https://lore.kernel.org/lkml/20221106053441.103199-1-wuqiang.matt@bytedance.com/):
  1) PATCH 2/4: test_objpool: build warnings with [-Wmissing-prototypes]
  2) PATCH 3/4: fprobe.c: conflicts resolved for linux-6.1-rc4 merging

wuqiang (4):
  lib: objpool added: ring-array based lockless MPMC queue
  lib: objpool test module added
  kprobes: kretprobe scalability improvement with objpool
  kprobes: freelist.h removed

 include/linux/freelist.h |  129 -----
 include/linux/kprobes.h  |    9 +-
 include/linux/objpool.h  |  153 ++++++
 include/linux/rethook.h  |   15 +-
 kernel/kprobes.c         |   95 ++--
 kernel/trace/fprobe.c    |   17 +-
 kernel/trace/rethook.c   |   80 +--
 lib/Kconfig.debug        |   11 +
 lib/Makefile             |    4 +-
 lib/objpool.c            |  487 ++++++++++++++++++
 lib/test_objpool.c       | 1052 ++++++++++++++++++++++++++++++++++++++
 11 files changed, 1801 insertions(+), 251 deletions(-)
 delete mode 100644 include/linux/freelist.h
 create mode 100644 include/linux/objpool.h
 create mode 100644 lib/objpool.c
 create mode 100644 lib/test_objpool.c

-- 
2.34.1

