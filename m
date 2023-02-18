Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3143E69B7DF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 04:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBRDV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 22:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRDV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 22:21:27 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C3C241F1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 19:21:25 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676690483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MQ8E3wieQMRLTMS9kx80LuFa1UjY4riWLnMnBzHBE/0=;
        b=SIYgzqNxL87bQsN/n0LLTGALWY+qPp/bkcxxiI9dROcF4pm9dBLvjA6e6vbJGpDi90oaut
        Iyj75XKHRN6rHj2t4LR6+uvFaHK9wwYDDbCQ8Fnd6REnUkakDvenLOLFHl3dA4Ef0YuXsh
        CnEUOoksQBbYel2NPvPIHolG//1DwJw=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>, mingo@redhat.com,
        stern@rowland.harvard.edu
Subject: [PATCH 0/2] lockdep lock comparison function
Date:   Fri, 17 Feb 2023 22:21:15 -0500
Message-Id: <20230218032117.2372071-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the lock comparison function I've been talking
about, and converts one of bcache's locks to use it.

b->write_lock has different locking rules; I'm not sure there's an easy
way to get rid of lockdep_set_novalidate_class for it - but the code has
changed and my memory is foggy. 

I'd like it if we could convert existing uses of *_lock_nested() to this
approach, since it's more rigorous and IMO, much clearer. That'll
require looking at specific use cases, though - the inode lock in
fs/inode.c is the only one I looked at and it's got a lot of nutty stuff
going on.

Kent Overstreet (2):
  lockdep: lock_set_lock_cmp_fn()
  bcache: Convert to lock_cmp_fn

 drivers/md/bcache/btree.c     | 15 ++++++++++-
 drivers/md/bcache/btree.h     |  4 +--
 include/linux/lockdep.h       |  8 ++++++
 include/linux/lockdep_types.h |  6 +++++
 kernel/locking/lockdep.c      | 51 ++++++++++++++++++++++++++++++++++-
 5 files changed, 80 insertions(+), 4 deletions(-)

-- 
2.39.2

