Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C443D62BD98
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbiKPMWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiKPMVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:21:04 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB7DDDF3A;
        Wed, 16 Nov 2022 04:18:40 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.31:38868.356041977
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 259981001DC;
        Wed, 16 Nov 2022 20:18:38 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-787c977d48-v8sdr with ESMTP id 480ed0d3e1eb4dac8d5ec0ae97e24f34 for rostedt@goodmis.org;
        Wed, 16 Nov 2022 20:18:39 CST
X-Transaction-ID: 480ed0d3e1eb4dac8d5ec0ae97e24f34
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Song Chen <chensong_2000@189.cn>
Subject: [PATCH 0/4] move functions in trace_probe_tmpl.h to trace_probe.c
Date:   Wed, 16 Nov 2022 20:24:52 +0800
Message-Id: <1668601492-4242-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below fucntions are defined and implemented in kprobe/eprobe/uprobe
respectively:

1. store_trace_args
2. print_probe_args
3. __get_data_size
4. process_fetch_insn
5. process_fetch_insn_bottom
6. fetch_store_*
7. probe_mem_*

...

They are either identical or similar, which means there is some space to
optimize code organization.

This patchset would like to move them into trace_probe.c as new APIs to
serve those probes and the differences will be merged at the same time.

It improves readability and avoid involving errors while adding a new
feature.

Song Chen (4):
  kernel/trace: Introduce new APIs to process probe arguments
  kernel/trace/kprobe: Use new APIs to process kprobe arguments
  kernel/trace/eprobe: Use new APIs to process eprobe arguments
  kernel/trace/uprobe: Use new APIs to process uprobe arguments

 kernel/trace/trace_eprobe.c       | 194 +------------------
 kernel/trace/trace_kprobe.c       | 125 +-----------
 kernel/trace/trace_probe.c        | 310 ++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h        |  11 ++
 kernel/trace/trace_probe_common.h |  69 +++++++
 kernel/trace/trace_probe_user.h   | 108 +++++++++++
 kernel/trace/trace_uprobe.c       | 177 +----------------
 7 files changed, 518 insertions(+), 476 deletions(-)
 create mode 100644 kernel/trace/trace_probe_common.h
 create mode 100644 kernel/trace/trace_probe_user.h

-- 
2.25.1

