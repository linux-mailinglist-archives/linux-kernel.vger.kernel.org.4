Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB54B72B744
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbjFLFZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjFLFZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:25:04 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDDEB5;
        Sun, 11 Jun 2023 22:25:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VkrnYF2_1686547495;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VkrnYF2_1686547495)
          by smtp.aliyun-inc.com;
          Mon, 12 Jun 2023 13:24:57 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     alexander.shishkin@linux.intel.com, peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 0/2] Fix high-order allocations for AUX space
Date:   Mon, 12 Jun 2023 13:24:50 +0800
Message-Id: <20230612052452.53425-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf-record with large AUX area, it reveals WARNINGs with __alloc_pages.
Fix with correct MAX_ORDER limit to request higher order allocations so that
larger contiguous areas is allocated. 

Shuai Xue (2):
  perf/core: Bail out early if the request AUX area is out of bound
  perf/ring_buffer: Fix high-order allocations for AUX space with
    correct MAX_ORDER limit

 kernel/events/core.c                     | 10 ++++++++++
 kernel/events/ring_buffer.c              |  4 ++--
 tools/perf/Documentation/perf-record.txt |  3 ++-
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
1.8.3.1

