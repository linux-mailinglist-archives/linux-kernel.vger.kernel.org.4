Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201485F16F3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiJAAKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiJAAKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:10:24 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4084952FEE;
        Fri, 30 Sep 2022 17:10:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id C9BBD20E0A3E;
        Fri, 30 Sep 2022 17:10:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9BBD20E0A3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1664583020;
        bh=KmHFrlXNHeCF3debDEXNV63hl+C/BG/6FHkknNv0UoU=;
        h=From:To:Cc:Subject:Date:From;
        b=CnJYvuNbeqywxJrif0GjXEx3mTpI+qeNu3k9LHT2zdNVZakBXa5TrljsaZ5/0Z0WG
         0i/XV7q05VLa6xPR2Pai7yFp5dsiygAaKhOYZUxK3AgMH6xuw4/TTodG2uMavFvr6+
         E1ueGI7PmptQxVKa8PcSMhVHbxiuW6cgzdcrXohw=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, brauner@kernel.org,
        stefanb@linux.ibm.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] tracing/user_events: Initial support for grouping
Date:   Fri, 30 Sep 2022 17:10:15 -0700
Message-Id: <20221001001016.2832-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to enable namespaces, or any sort of isolation, within
user_events the register lock and pages need to be broken up into
groups. Each event and file now has a group pointer which stores
the actual pages to map, lookup data and synchronization objects.

There's been some previous discussion about this both in the
tracefs meetings as well as on the mailing lists:
Link: https://lore.kernel.org/all/20220312010140.1880-1-beaub@linux.microsoft.com/
Link: https://lore.kernel.org/all/20220425184631.2068-1-beaub@linux.microsoft.com/

This was also brought up in the most recent plumbers conference,
with some feedback to follow the IMA namespace model. This only enables
a single group that maps to init_user_ns, as IMA namespace has done.

Link: https://youtu.be/zai3gvpuEHc?t=4403
Link: https://lore.kernel.org/linux-kernel/20220915193221.1728029-15-stefanb@linux.ibm.com/#t

While it's not clear what all needs to be within a tracing namespace,
we have to start somewhere. The patch leaves out how new namespaces
are created and further configured by an operator. However, it
offers a structure and the minimum scaffolding to enable isolation
while we discuss this in further detail and build upon this in steps.

Beau Belgrave (1):
  tracing/user_events: Move pages/locks into groups to prepare for
    namespaces

 kernel/trace/trace_events_user.c | 346 ++++++++++++++++++++++++-------
 1 file changed, 274 insertions(+), 72 deletions(-)


base-commit: c23cbf0d23145ffd0f99520a5c1d65abba628936
-- 
2.25.1

