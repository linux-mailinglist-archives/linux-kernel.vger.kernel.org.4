Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B07743159
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjF2Xu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjF2Xu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:50:56 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96AA930DF;
        Thu, 29 Jun 2023 16:50:55 -0700 (PDT)
Received: from CPC-beaub-VBQ1L.localdomain (unknown [4.155.48.123])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9185C208396A;
        Thu, 29 Jun 2023 16:50:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9185C208396A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1688082654;
        bh=lgUdu2qp156h5P5sIiuRE2nkVehC4a1jKFyR45EG0Ec=;
        h=From:To:Cc:Subject:Date:From;
        b=CV8h5hcJQpMcjs7dt45hr2utnsklSL8xlDt3bCxw5+dvGSlnU60MsS8jUO3Wbgo/o
         ILIU7MKrg8YBttpVFD+2m5I1A3PkqTBIryGBPDZZgikzzoxZ8vUvbEpAaWXhxUKDtw
         9t4qpNk8P0W6LGKkOZ/5LfTj3M241DR5XQyq6Zcc=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracing/user_events: Fix struct arg size match check
Date:   Thu, 29 Jun 2023 23:50:47 +0000
Message-Id: <20230629235049.581-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
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

The edge case of struct fields having an extra size argument got missed
when checking if events have the same name and arguments. This lead to
events not being able to register if a matching event name was already
created with a struct argument.

This series simply fixes this and adds a self test to ensure we do not
miss it again.

Beau Belgrave (2):
  tracing/user_events: Fix struct arg size match check
  selftests/user_events: Test struct size match cases

 kernel/trace/trace_events_user.c               |  3 +++
 tools/testing/selftests/user_events/dyn_test.c | 12 ++++++++++++
 2 files changed, 15 insertions(+)


base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
-- 
2.34.1

