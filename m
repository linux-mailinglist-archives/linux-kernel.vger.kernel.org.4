Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404FA630DA6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 10:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiKSJCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 04:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiKSJCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 04:02:32 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEE79DBA5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 01:02:31 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NDndf0h6HzFqQ9;
        Sat, 19 Nov 2022 16:59:18 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 17:02:29 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <jgross@suse.com>, <boris.ostrovsky@oracle.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <jeremy@goop.org>
CC:     <x86@kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] x86/xen: Fix memory leak issue
Date:   Sat, 19 Nov 2022 16:59:21 +0800
Message-ID: <20221119085923.114889-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new string allocated by kasprintf() is leaked on error path

Xiu Jianfeng (2):
  x86/xen: Fix memory leak in xen_smp_intr_init{_pv}()
  x86/xen: Fix memory leak in xen_init_lock_cpu()

 arch/x86/xen/smp.c      | 16 ++++++++++++----
 arch/x86/xen/smp_pv.c   |  8 ++++++--
 arch/x86/xen/spinlock.c |  3 ++-
 3 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.17.1

