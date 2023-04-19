Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ED06E83E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjDSVlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDSVlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:41:49 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E30221736;
        Wed, 19 Apr 2023 14:41:48 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 34BFB21C204E;
        Wed, 19 Apr 2023 14:41:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 34BFB21C204E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681940508;
        bh=sgTNp5eSBPHwEMtDp0lZS2PRQR1YHnD6Cy4riRcqsQk=;
        h=From:To:Cc:Subject:Date:From;
        b=cb+7k6itM4fiMWaLmgo4Zo0Hly8Ap/5mT/nDt7SLnLDnCUMgqe/PZKgMly3poSdgH
         0MDDKOMZtnR0HFAmAGH1Oa7khXXoHBzeArfUlQMj/e6gx6yA8nTjpZ5JmfutxxuwcP
         vXuo9E1CSnnv/T8GbPgihZNCGUE8O8tSNb4LfojA=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracing: Fix print_fields() and use best filter
Date:   Wed, 19 Apr 2023 14:41:38 -0700
Message-Id: <20230419214140.4158-1-beaub@linux.microsoft.com>
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

When using user_events along with the new print_fields() functionality
a few issues were discovered. When printing out fields, the __rel_loc
field types were printing out the wrong array values. Also, user_events
wasn't setting the best filter type, so __rel_loc data was marked as
FILTER_OTHER vs FILTER_RDYN_STRING when chars were used. This resulted
in strings being printed out as array of bytes vs a string.

After applying this series user_events will output strings correctly
for __rel_loc via /sys/kernel/tracing/trace outputs. All events that
utilize print_fields() will print the correct array/string for
__data_loc and __rel_loc data, when it's enabled.

Beau Belgrave (2):
  tracing/user_events: Set event filter_type from type
  tracing: Fix print_fields() for __dyn_loc/__rel_loc

 kernel/trace/trace_events_user.c |  3 +++
 kernel/trace/trace_output.c      | 10 ++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)


base-commit: 88fe1ec75fcb296579e05eaf3807da3ee83137e4
-- 
2.25.1

