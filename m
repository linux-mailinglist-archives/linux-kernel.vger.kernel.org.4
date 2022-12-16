Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7769964F102
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 19:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiLPSdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 13:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLPSdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 13:33:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612866F483
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 10:33:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D7B9B8136A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 18:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AC3C433D2;
        Fri, 16 Dec 2022 18:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671215599;
        bh=GV3Lx/FAuUN/GrklkXc8+fnRlqJXI694w1uGuUC8AdM=;
        h=From:To:Cc:Subject:Date:From;
        b=VWwUHJ9fDnOyh+0tEMAWKotD+9B+DxbeZ6zx+/M4BZ6A0ku1mK5nB059ZmDh6pAP/
         va/1l4ISU8czktlsKQasbI+PvWYZYJ8/istuBA5YsMasLHerOyJ/Uwkuh4fiTDzEpO
         tJrSZsV/uGcbHRLTlkuDPJ2GTb/cm5XE+w8UfvjZnHfj2A0JhM5XxhQn1WzU0cWkG+
         LCcNJ+/2MPUwC2s6YFugbBJF8C8yoqAzDnZQD55B8DsL9raC20fJp6D4mWYbMPjNor
         mn5xlACC0tc2M8QAXGDJKzixoUm4fNSedmK6Z6J/ALcwbxl6hvCWtfCmbbTR/JFkf2
         0E2X61lweUhSQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     dverkamp@chromium.org, jeffxu@google.com, keescook@chromium.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH mm-unstable] kernel/pid_sysctl.h: Add missing definitions for specific config
Date:   Fri, 16 Dec 2022 18:33:14 +0000
Message-Id: <20221216183314.169707-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bdb6231e88a3 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC") on
mm-unstable when CONFIG_SYSCTL or CONFIG_MEMFD_CRETE not defined, as
below, because initialize_memfd_noexec_scope() and
register_pid_ns_sysctl_table_vm(), which defined by the commit, is not
defined for the config case.

    ERROR:root:/kernel/pid_namespace.c: In function ‘create_pid_namespace’:
    /kernel/pid_namespace.c:114:2: error: implicit declaration of function ‘initialize_memfd_noexec_scope’; did you mean ‘set_memfd_noexec_scope’? [-Werror=implicit-function-declaration]
      114 |  initialize_memfd_noexec_scope(ns);
          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          |  set_memfd_noexec_scope
    /kernel/pid_namespace.c: In function ‘pid_namespaces_init’:
    /kernel/pid_namespace.c:462:2: error: implicit declaration of function ‘register_pid_ns_sysctl_table_vm’; did you mean ‘register_pid_ns_ctl_table_vm’? [-Werror=implicit-function-declaration]
      462 |  register_pid_ns_sysctl_table_vm();
          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          |  register_pid_ns_ctl_table_vm
    cc1: some warnings being treated as errors
    make[3]: *** [/scripts/Makefile.build:250: kernel/pid_namespace.o] Error 1

Fix the commit by defining the functions for the configuration.

Fixes: bdb6231e88a3 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC") on mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 kernel/pid_sysctl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
index 90a93161a122..770c060a0d33 100644
--- a/kernel/pid_sysctl.h
+++ b/kernel/pid_sysctl.h
@@ -52,8 +52,10 @@ static inline void register_pid_ns_sysctl_table_vm(void)
 	register_sysctl_paths(vm_path, pid_ns_ctl_table_vm);
 }
 #else
+static inline void initialize_memfd_noexec_scope(struct pid_namespace *ns) {}
 static inline void set_memfd_noexec_scope(struct pid_namespace *ns) {}
 static inline void register_pid_ns_ctl_table_vm(void) {}
+static inline void register_pid_ns_sysctl_table_vm(void) {}
 #endif
 
 #endif /* LINUX_PID_SYSCTL_H */
-- 
2.25.1

