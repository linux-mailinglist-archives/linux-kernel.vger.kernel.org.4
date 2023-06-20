Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19822736E64
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjFTOLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjFTOKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B63210CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687270208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xcoOW1ZR6wswnF4rij7hWtB4wmZnp/XX0PDU4BubJAY=;
        b=emhmzWljLnThEP4yHnnEEU/510tkDVayAcR80xSsPRU43ylG52/v9lDgrZeFWXGeK5Vsz/
        JDYz2t215cvbaZ/eZfviqDhXPppAT5Ish4dKNfQ9hsWfvixV5NtQMrk5xJ35zdHRcVjW2V
        wu+GnMF3fjvKlBvrYM3a8K+XrnwydLI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-pSQ_-q6DO1WXmzsWOAOpSg-1; Tue, 20 Jun 2023 10:09:04 -0400
X-MC-Unique: pSQ_-q6DO1WXmzsWOAOpSg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1A5388D56E;
        Tue, 20 Jun 2023 14:06:31 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE24D425357;
        Tue, 20 Jun 2023 14:06:30 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org, Robin Jarry <rjarry@redhat.com>,
        Joe Mario <jmario@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/5] x86/speculation: Disable IBRS when idle
Date:   Tue, 20 Jun 2023 10:06:20 -0400
Message-Id: <20230620140625.1001886-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
are existing users out there who have set "intel_idle.max_cstate=1" or
even "intel_idle.max_cstate=0" to decrease latency. Those users won't be
able to benefit from this commit. This patch series extends this commit
by providing a new "intel_idle.no_ibrs" module option to force disable
IBRS even when "intel_idle.max_cstate=1" at the expense of increased IRQ
response latency. It also includes commit to allow the disabling of IBRS
with "intel_idle.max_cstate=0" as well as when a CPU becomes offline.

The first patch adds a new x86/spec_ctrl_msrs debugfs file which display
the current cached values of the SPEC_CTRL MSRs of all the CPUs. This
allows us to verify that IBRS bit is correctly turned off in idle CPUs
for various cstate values.

Waiman Long (5):
  x86/speculation: Provide a debugfs file to dump SPEC_CTRL MSRs
  x86/idle: Disable IBRS when cpu is offline
  intel_idle: Sync up the SPEC_CTRL MSR value to x86_spec_ctrl_current
  intel_idle: Add no_ibrs module parameter to force disable IBRS
  x86/idle: Disable IBRS entering mwait idle and enable it on wakeup

 arch/x86/include/asm/mwait.h | 17 ++++++++
 arch/x86/kernel/cpu/bugs.c   | 79 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c    | 13 ++++++
 drivers/idle/intel_idle.c    | 22 ++++++++--
 4 files changed, 127 insertions(+), 4 deletions(-)

-- 
2.31.1

