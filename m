Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7A7638BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiKYNzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiKYNzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:55:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51686D2EA;
        Fri, 25 Nov 2022 05:55:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 085DDB82AC8;
        Fri, 25 Nov 2022 13:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9510C433C1;
        Fri, 25 Nov 2022 13:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669384506;
        bh=VXa83RlqoumhQA/Jh/3yZg/Ss1tzTts+aOw3XPdmkvw=;
        h=From:To:Cc:Subject:Date:From;
        b=OySoHP9+T5BWpbzme6cidsdtNlwxdV0ZzkGEs3PTy3uW/7QR4zmAmmglrwbKJ8Qru
         F4ekcBCIRgMDn6KxOFffjKWI5LsLThCnoSxL2EFMFcnfsh+8/3pPuujlnnWNLcyPHm
         mfx9mD3tuYlBPxUbBfnI+EVsdCBCRutN7edJTJH77AgG1unH7RS6FPi6Sw6yEhyhmi
         sgtfnIKhc8ICDOcMIveqeubhiMMWP5JCfnXKAp2ciJXcONJj14yXw6miFNmU11KA8q
         ScsoQHNuuhjzkMFc8JSrvXlnCiznGRNSah30xY1N1fEWE/vTgXv3x+OD2xQ9m9HSIq
         OV20ONg/l7twQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: [PATCH 0/3] rcu-tasks: Fix race against exiting pid_ns
Date:   Fri, 25 Nov 2022 14:54:57 +0100
Message-Id: <20221125135500.1653800-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pengfei Xu has reported a deadlock involving calls to unshare(),
perf_event_open() and clone3() calls. It requires CAP_SYS_ADMIN
to reproduce (at least I don't see a way for a non privilege process to
reproduce).

See this thread for details: https://lore.kernel.org/all/Y3sOgrOmMQqPMItu@xpf.sh.intel.com/
And this document for the collaborative analysis with Boqun, Paul and Neeraj:
https://docs.google.com/document/d/1hJxgiZ5TMZ4YJkdJPLAkRvq7sYQ-A7svgA8no6i-v8k

The two first patches are small improvements. The fix is in the last patch.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/dev

HEAD: 45ef5a0a4be4e0db9eadcc86e8f346d34c62e744

Thanks,
	Frederic
---

Frederic Weisbecker (3):
      rcu-tasks: Improve comments explaining tasks_rcu_exit_srcu purpose
      rcu-tasks: Remove preemption disablement around srcu_read_[un]lock() calls
      rcu-tasks: Fix synchronize_rcu_tasks() VS zap_pid_ns_processes()


 include/linux/rcupdate.h |  2 ++
 kernel/pid_namespace.c   | 17 +++++++++++++++
 kernel/rcu/tasks.h       | 55 ++++++++++++++++++++++++++++++++++++------------
 3 files changed, 60 insertions(+), 14 deletions(-)
