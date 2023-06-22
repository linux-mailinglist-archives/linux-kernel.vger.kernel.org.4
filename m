Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2EB7393EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjFVAiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjFVAiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF10D199F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687394208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JClsVInx+SfJQwVlXcLVSsPnUQ6NqCBnYMZfU8zrapQ=;
        b=H5217mcVJ6cf2JO2feUfRdB67a+Y8vg1UkV3L/lTikVCK0tK6dhWZUpHaiDF7G4nGF8xiy
        tX+bXKBP0aRau5/boQn0hRvsQy45ttkcXFGUT3Ka+qCf01QtaK2zi81VMvYmn/ET/fi4Cc
        EgB6ETMa8JPGYpO+ITmIUIgMYe/Aagc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-h3nYqPbcM1-QS6yb3y4lTg-1; Wed, 21 Jun 2023 20:36:43 -0400
X-MC-Unique: h3nYqPbcM1-QS6yb3y4lTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECB4E8C5868;
        Thu, 22 Jun 2023 00:36:41 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 033EE112132C;
        Thu, 22 Jun 2023 00:36:23 +0000 (UTC)
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
Subject: [PATCH v3 0/3] x86/speculation: Disable IBRS when idle
Date:   Wed, 21 Jun 2023 20:36:00 -0400
Message-Id: <20230622003603.1188364-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

Waiman Long (3):
  x86/idle: Disable IBRS when cpu is offline
  intel_idle: Sync up the SPEC_CTRL MSR value to x86_spec_ctrl_current
  intel_idle: Add ibrs_off module parameter to force disable IBRS

 Documentation/admin-guide/pm/intel_idle.rst | 17 +++++++++++++++-
 arch/x86/kernel/smpboot.c                   | 10 ++++++++++
 drivers/idle/intel_idle.c                   | 22 +++++++++++++++++----
 3 files changed, 44 insertions(+), 5 deletions(-)

-- 
2.31.1

