Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328B26F77A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjEDVBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjEDVBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:01:18 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F058B13851
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683230731;
        bh=YaLjMlY2AXAxdGceepfOSLT5QLDQ8cu212pZLfriISQ=;
        h=From:To:Cc:Subject:Date:From;
        b=D/0V0zXYaNb9nrKChDCVLoBh2h5eCF6chN0tYXXfZxU/j76WxLbKEw+sHbWBiX3cQ
         QE5nbsdxOZrxXk5FHL9Qh6CNqIFuLe6ckJypK+99xmz/ioWPfVktmwU5lnffNH32vi
         WBRyryqGBoDd+WmWbsqZAr/KbNTbo1apjyStXlR3deLlwfPQ/wkUfEpJ1dQz64g+sh
         /sBJM9fBoYbG4mS/VgCbkZqA61QJU/e8y4yzloy2voh1Y/J3c1FRJQ0RhPEAe0lMRt
         wbe2vHoBxM7RcuL6DcK3cc8KgOIub2E05T+MdxPGSg5f2gCiOIdxecmAhP8KK4rSiA
         HmBRySTG7BHGA==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QC4Yl4YNTz122b;
        Thu,  4 May 2023 16:05:31 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 00/13] Fix parentheses around macro parameter use in headers
Date:   Thu,  4 May 2023 16:05:14 -0400
Message-Id: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to look at various list and list user headers in the kernel tree
to figure out what the proper parentheses pattern should be around macro
parameter use for new code, and it turns out that the current code base
lacks consistency.

This is not an exhaustive change of all public kernel headers, but at
least it is a start, updating those which are implementing or using
kernel lists.

The basic rules followed here are:

- Use parentheses around arguments which are rvalues, except when those
  are expressions between commas "," used as arguments to functions or
  other macros, or surrounded by brackets "[]".
- Do not use parentheses around arguments which are lvalues.

For consistency, when a macro argument is used both as an lvalue and as
an rvalue within the macro, use the parentheses rules applying to each
of the context: with parentheses for rvalue, without parentheses for
lvalue.

Mathieu Desnoyers (13):
  rcu: rcupdate.h: Fix parentheses around macro parameter use
  rculist.h: Fix parentheses around macro pointer parameter use
  rculist_nulls.h: Add parentheses around macro pointer parameter use
  rculist_bl.h: Fix parentheses around macro pointer parameter use
  list.h: Fix parentheses around macro pointer parameter use
  list_nulls.h: Fix parentheses around macro pointer parameter use
  list_bl.h: Fix parentheses around macro pointer parameter use
  llist.h: Fix parentheses around macro pointer parameter use
  klist.h: Fix parentheses around macro parameter use
  resource_ext.h: Remove useless parentheses around macro parameters
  netdevice.h: Fix parentheses around macro parameter use
  blk-mq.h: Fix parentheses around macro parameter use
  bio.h: Fix parentheses around macro parameter use

 include/linux/bio.h           | 22 +++++++-------
 include/linux/blk-mq.h        | 38 ++++++++++++------------
 include/linux/klist.h         |  8 +++---
 include/linux/list.h          | 54 +++++++++++++++++------------------
 include/linux/list_bl.h       | 12 ++++----
 include/linux/list_nulls.h    |  8 +++---
 include/linux/llist.h         | 14 ++++-----
 include/linux/netdevice.h     | 12 ++++----
 include/linux/rculist.h       | 28 +++++++++---------
 include/linux/rculist_bl.h    |  6 ++--
 include/linux/rculist_nulls.h |  4 +--
 include/linux/rcupdate.h      | 46 ++++++++++++++---------------
 include/linux/resource_ext.h  |  6 ++--
 13 files changed, 129 insertions(+), 129 deletions(-)

-- 
2.25.1

