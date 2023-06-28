Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F7E740853
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjF1C1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjF1C1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB09930F2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 19:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687919167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1Mwd2RHHbNwY1uNDBHOZHgn4cZFBmD9G4gGlkOLHa0o=;
        b=Zl2dHQKik1VhzgVwshfRqERuSazZLDB5RbjMZFMVMznn4DCfN8QhcYAAYPsJSzyBw9HKyu
        UtjVQJQrggI2ZJWtUwzlEYHvA8DpXdVa7sVhI/mouICngdHXiu3iprzYAI/yUg1RX7DpMQ
        26v1YKKxrPJ8CNYlvpb4ahWgSR8zyC0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-4Rmmy0hCPcOfWehKADoQLw-1; Tue, 27 Jun 2023 22:26:04 -0400
X-MC-Unique: 4Rmmy0hCPcOfWehKADoQLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 339551044589;
        Wed, 28 Jun 2023 02:26:03 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19334207B2C3;
        Wed, 28 Jun 2023 02:26:02 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/4] x86/speculation: Disable IBRS when idle
Date:   Tue, 27 Jun 2023 22:25:50 -0400
Message-Id: <20230628022554.1638318-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v4:
  - Add a new __update_spec_ctrl() helper in patch 1.
  - Rebased to the latest linux kernel.

 v3:
  - Drop patches 1 ("x86/speculation: Provide a debugfs file to dump
    SPEC_CTRL MSRs") and 5 ("x86/idle: Disable IBRS entering mwait idle
    and enable it on wakeup") for now.
  - Drop the MSR restoration code in ("x86/idle: Disable IBRS when cpu
    is offline") as native_play_dead() does not return.
  - For patch ("intel_idle: Add ibrs_off module parameter to force
    disable IBRS"), change the name from "no_ibrs" to "ibrs_off" and
    document the new parameter in intel_idle.rst.

For Intel processors that need to turn on IBRS to protect against
Spectre v2 and Retbleed, the IBRS bit in the SPEC_CTRL MSR affects
the performance of the whole core even if only one thread is turning
it on when running in the kernel. For user space heavy applications,
the performance impact of occasionally turning IBRS on during syscalls
shouldn't be significant. Unfortunately, that is not the case when the
sibling thread is idling in the kernel. In that case, the performance
impact can be significant.

When DPDK is running on an isolated CPU thread processing network packets
in user space while its sibling thread is idle. The performance of the
busy DPDK thread with IBRS on and off in the sibling idle thread are:

                                IBRS on         IBRS off
                                -------         --------
  packets/second:                  7.8M           10.4M
  avg tsc cycles/packet:         282.26          209.86

This is a 25% performance degradation. The test system is a Intel Xeon
4114 CPU @ 2.20GHz.

Commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")
disables IBRS when the CPU enters long idle (C6 or below). However, there
are existing users out there who have set "intel_idle.max_cstate=1"
to decrease latency. Those users won't be able to benefit from this
commit. This patch series extends this commit by providing a new
"intel_idle.ibrs_off" module parameter to force disable IBRS even when
"intel_idle.max_cstate=1" at the expense of increased IRQ response
latency. It also includes a commit to allow the disabling of IBRS when
a CPU becomes offline.


Waiman Long (4):
  x86/speculation: Add __update_spec_ctrl() helper
  x86/idle: Disable IBRS when cpu is offline
  intel_idle: Use __update_spec_ctrl() in intel_idle_ibrs()
  intel_idle: Add ibrs_off module parameter to force disable IBRS

 Documentation/admin-guide/pm/intel_idle.rst | 17 ++++++++++++++++-
 arch/x86/include/asm/nospec-branch.h        | 11 ++++++++++-
 arch/x86/kernel/smpboot.c                   |  8 ++++++++
 drivers/idle/intel_idle.c                   | 18 ++++++++++++++----
 4 files changed, 48 insertions(+), 6 deletions(-)

-- 
2.31.1

