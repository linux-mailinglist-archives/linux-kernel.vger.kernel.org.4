Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C3670A32E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjESXI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjESXIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:08:25 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A4F210D;
        Fri, 19 May 2023 16:08:24 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id D94F520FB609;
        Fri, 19 May 2023 16:08:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D94F520FB609
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1684537704;
        bh=YH2G13bl35OJzy0HLtezwie5ahZIQ6Oyhln0vPhVRMw=;
        h=From:To:Cc:Subject:Date:From;
        b=mMlldXyDx146kS0ujbBDy91nXrwkKG7oiFnnrYgllip80ECOveLoh6WECwgYrkFxk
         CpQRZqPLpv51MpF6i+DoQwvSlfFIf8R6RtLvCGmKmsn51LsSwaT5A+5D4fIpCNcWhv
         vU/rwsiFp3uac+QqAkualOHxO9R4BTWfEB6kO/K4=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, ast@kernel.org
Subject: [PATCH v3 0/4] tracing/user_events: Use non-RCU context for enabler writes
Date:   Fri, 19 May 2023 16:07:37 -0700
Message-Id: <20230519230741.669-1-beaub@linux.microsoft.com>
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

Currently when events are enabled/disabled a top level mm enumeration is
done in a non-RCU context, however, the enablers are still in a
RCU-context. Each enabler is updated via user_event_enabler_write() which
uses pin_user_pages_remote(). This function can reschedule and should not
be used from a RCU-context, which this series addresses.

There was also feedback given that some of the code was confusing and
needed further comments and field renames, especially for links. I think
having this feedback will help others contribute to this code easier, so
I am grouping this into a single series to address this together.

NOTE: Series is based on the for-next branch of the following tree:
git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git

Change history

V3:
Use Linus's patches to more completely solve this issue.

Added comments and renamed fields as suggested by Linus to ensure easier
reasoning over the code for everyone.

V2:
Remove break statement that prevents more than 1 enabler in MM for same
event (rare, but possible).

Beau Belgrave (2):
  tracing/user_events: Rename link fields for clarity
  tracing/user_events: Document user_event_mm one-shot list usage

Linus Torvalds (2):
  tracing/user_events: Split up mm alloc and attach
  tracing/user_events: Remove RCU lock while pinning pages

 include/linux/user_events.h      |  3 +-
 kernel/trace/trace_events_user.c | 97 +++++++++++++++++++++-----------
 2 files changed, 67 insertions(+), 33 deletions(-)


base-commit: 3862f86c1529fa0016de6344eb974877b4cd3838
-- 
2.25.1

