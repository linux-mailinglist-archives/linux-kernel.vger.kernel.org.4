Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082BD6B51FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjCJUdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCJUdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:33:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B67F75C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:33:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB95861D4A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 20:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3524C433EF;
        Fri, 10 Mar 2023 20:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678480308;
        bh=8mhnBVXTkrddv783HXQ9jm0z3rkg9svYl+Y90WxbKYU=;
        h=From:To:Cc:Subject:Date:From;
        b=M6gqPMlvKL/l8tSRPTEfwWbnMZOHwZVYY2VEM/xRb7VMc/qJ9uAHg19dgzBYwmKal
         a1DZV6eEciPG7Mor5Hiv6SG6t2xs8kDwCVz8T5aJn6Gb1gRbc3akodX/OuauGJGzD4
         kcGnDwO3EWWiRbQo/gcB6hgfeONzkAynMfHG/RTVzTsbb3XOZD6ZsolHlvFeVQuHmi
         yzMacmJkAay914vilUV3q9H3C1Tb80Cs8qjkwoaiV2dLplj41wLLg3GQOuaNq4pzPr
         3Hmsll4f+Ul+RYuVb8wKrjbcQONbOOKShVTVpNkh0UprVz8w+RC1iV//l/88pHNPv0
         WMDGDBBQkEx6w==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [RFC][PATCH 0/5] Improve static call NULL handling
Date:   Fri, 10 Mar 2023 12:31:12 -0800
Message-Id: <cover.1678474914.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static calling a NULL pointer is a NOP, unless you're one of those poor
souls running on an arch (or backported x86 monstrosity) with
CONFIG_HAVE_STATIC_CALL=n, then it's a panic.

The "fix" for this undefined behavior is to tell the user to just use
static_call_cond() instead, if they want consistent NOP behavior.  But
forgetting to do that is likely to cause subtle bugs.  It actually
already did (during RHEL development).

There are two ways to make it consistent:

  a) Make static_call(NULL) a NOP for all configs; or

  b) Make static_call(NULL) a panic for all configs.

Do (a) because it's consistent with the existing HAVE_STATIC_CALL
behavior.  Also it seems simpler to implement and use, and based on
looking at the existing use cases, it's common to want the "do nothing
and return 0" behavior by default.

Then take it a step further and get rid of the distinction between
STATIC_CALL_NULL and STATIC_CALL_RET0.

The end result is less confusing semantics and simpler code all around.


EPILOGUE
--------

If any users wanted panic-on-NULL by default instead of NOP-on-NULL,
that could be added on top of this.  They could just initialize the
static call with a __static_call_bug() helper.

  void __static_call_bug(void)
  {
  	BUG();
  }
  ..
  DEFINE_STATIC_CALL(foo, (func_type)__static_call_bug);

We could take that even further:

  DEFINE_STATIC_CALL_NOP(foo, func_type);
  DEFINE_STATIC_CALL_BUG(bar, func_type);
  ...
  #define STATIC_CALL_NOP (func_type)__static_call_nop
  #define STATIC_CALL_BUG (func_type)__static_call_bug
  ...
  static_call_update(foo, STATIC_CALL_NOP); // do nothing and return 0
  static_call_update(foo, STATIC_CALL_BUG); // panic
  static_call_update(foo, NULL);	    // ???

The default behavior for NULL could be a key-specific policy, stored as
a flag in the static_call_key struct.

The key-specific policy would be easier to deal with than the
call-site-specific policy we have today with static_call_cond().



Josh Poimboeuf (5):
  static_call: Make NULL static calls consistent
  static_call: Make NULL static calls return 0
  static_call: Remove static_call_cond() and its usages
  static_call: Remove DEFINE_STATIC_CALL_RET0() and its uses
  x86/kvm: Simplify static call handling

 arch/powerpc/include/asm/static_call.h    |   1 -
 arch/powerpc/kernel/irq.c                 |   2 +-
 arch/x86/events/amd/core.c                |   2 +-
 arch/x86/events/core.c                    |  26 ++---
 arch/x86/include/asm/kvm-x86-ops.h        |  86 +++++++-------
 arch/x86/include/asm/kvm-x86-pmu-ops.h    |  17 +--
 arch/x86/include/asm/kvm_host.h           |   6 +-
 arch/x86/include/asm/static_call.h        |   8 --
 arch/x86/kvm/irq.c                        |   2 +-
 arch/x86/kvm/lapic.c                      |  22 ++--
 arch/x86/kvm/pmu.c                        |  11 +-
 arch/x86/kvm/x86.c                        |  36 +++---
 include/linux/static_call.h               | 131 +++++-----------------
 kernel/events/core.c                      |   8 +-
 kernel/sched/core.c                       |  10 +-
 security/keys/trusted-keys/trusted_core.c |   2 +-
 16 files changed, 126 insertions(+), 244 deletions(-)

-- 
2.39.2

