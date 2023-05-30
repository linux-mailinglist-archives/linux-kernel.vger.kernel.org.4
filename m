Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1861371720E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjE3XxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjE3XxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:53:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BF86AA;
        Tue, 30 May 2023 16:53:12 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 931B920FC46B;
        Tue, 30 May 2023 16:53:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 931B920FC46B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1685490791;
        bh=Z9owk60mLsQ9CmOnrrn5zp1mIr1kGtuAxKwMw6iuEA8=;
        h=From:To:Cc:Subject:Date:From;
        b=bmV7NDmUKut9lVN6Gvy8cX/SOgoVrBGj33TsV9lFkCIZuKLAmFtwIhhaIuGxP/E6T
         80lX/RosXgdoXKkJfrikQ1vp6iGSAqt5s/Tmtot07RlOwgTJPi4vxOm6YvSnCh3Rzn
         ZkzBpfeARZOkmtoZoBBmTMPVRdM9R/tnion8VfjU=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, dcook@linux.microsoft.com
Subject: [PATCH 0/5] tracing/user_events: Add auto-del flag for events
Date:   Tue, 30 May 2023 16:52:59 -0700
Message-Id: <20230530235304.2726-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the discussions for user_events aligning to be used with eBPF
it became clear [1] we needed a way to delete events without having to rely
upon the delete IOCTL. Steven suggested that we simply have an owner
for the event, however, the event can be held by more than just the
first register FD, such as perf/ftrace or additional registers. In order
to handle all those cases, we must only delete after all references are
gone from both user and kernel space.

This series adds a new register flag, USER_EVENT_REG_AUTO_DEL, which
causes the event to delete itself upon the last put reference. We cannot
fully drop the delete IOCTL, since we still want to enable events to be
registered early via dynamic_events and persist. If the auto delete flag
was used during dynamic_events, the event would delete immediately.

We have a few key events that we enable immediately after boot and are
monitored in our environments. Today this is done via dynamic events,
however, it could also be done directly via the ABI by not passing the
auto delete flag.

NOTE: I'll need to merge this work once we take these [2] [3] patches
into for-next. I'm happy to do so once they land there.

1: https://lore.kernel.org/linux-trace-kernel/20230518093600.3f119d68@rorschach.local.home/
2: https://lore.kernel.org/linux-trace-kernel/20230529032100.286534-1-sunliming@kylinos.cn/
3: https://lore.kernel.org/linux-trace-kernel/20230519230741.669-1-beaub@linux.microsoft.com/

Beau Belgrave (5):
  tracing/user_events: Store register flags on events
  tracing/user_events: Track refcount consistently via put/get
  tracing/user_events: Add flag to auto-delete events
  tracing/user_events: Add self-test for auto-del flag
  tracing/user_events: Add auto-del flag documentation

 Documentation/trace/user_events.rst           |  21 +-
 include/uapi/linux/user_events.h              |  10 +-
 kernel/trace/trace_events_user.c              | 183 ++++++++++++++----
 .../testing/selftests/user_events/abi_test.c  | 115 ++++++++++-
 4 files changed, 278 insertions(+), 51 deletions(-)


base-commit: 3862f86c1529fa0016de6344eb974877b4cd3838
-- 
2.25.1

