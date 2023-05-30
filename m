Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8693716CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjE3TAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjE3TAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:00:08 -0400
Received: from mail-b.sr.ht (mail-b.sr.ht [173.195.146.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD4C102
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:00:02 -0700 (PDT)
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
        by mail-b.sr.ht (Postfix) with ESMTPSA id 3822211EE8C;
        Tue, 30 May 2023 18:50:50 +0000 (UTC)
From:   ~akihirosuda <akihirosuda@git.sr.ht>
Date:   Tue, 30 May 2023 18:50:50 +0000
Subject: [PATCH linux 0/3] [PATCH] userns: add sysctl "kernel.userns_group_range"
MIME-Version: 1.0
Message-ID: <168547265011.24337.4306067683997517082-0@git.sr.ht>
X-Mailer: git.sr.ht
Reply-to: ~akihirosuda <suda.kyoto@gmail.com>
To:     linux-kernel@vger.kernel.org, containers@lists.linux.dev,
        serge@hallyn.com, brauner@kernel.org, paul@paul-moore.com,
        ebiederm@xmission.com
Cc:     suda.kyoto@gmail.com, akihiro.suda.cz@hco.ntt.co.jp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_REPLYTO,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sysctl limits groups who can create a new userns without
CAP_SYS_ADMIN in the current userns, so as to mitigate potential kernel
vulnerabilities around userns.

The sysctl value format is same as "net.ipv4.ping_group_range".

To disable creating new unprivileged userns, set the sysctl value to "1
0" in the initial userns.

To allow everyone to create new userns, set the sysctl value to "0
4294967294". This is the default value.

This sysctl replaces "kernel.unprivileged_userns_clone" that is found in
Ubuntu [1] and Debian GNU/Linux.

Link: https://git.launchpad.net/~ubuntu-
kernel/ubuntu/+source/linux/+git/jammy/commit?id=3422764 [1]

Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>

Akihiro Suda (3):
  net/ipv4: split group_range logic to kernel/group_range.c
  group_range: allow GID from 2147483648 to 4294967294
  userns: add sysctl "kernel.userns_group_range"

 include/linux/group_range.h    |  18 +++++
 include/linux/user_namespace.h |   5 ++
 include/net/netns/ipv4.h       |   9 +--
 include/net/ping.h             |   6 --
 kernel/Makefile                |   2 +-
 kernel/fork.c                  |  24 +++++++
 kernel/group_range.c           | 123 +++++++++++++++++++++++++++++++++
 kernel/sysctl.c                |  30 ++++++++
 kernel/user.c                  |   9 +++
 net/ipv4/ping.c                |  39 +----------
 net/ipv4/sysctl_net_ipv4.c     |  56 ++-------------
 11 files changed, 219 insertions(+), 102 deletions(-)
 create mode 100644 include/linux/group_range.h
 create mode 100644 kernel/group_range.c

-- 
2.38.4
