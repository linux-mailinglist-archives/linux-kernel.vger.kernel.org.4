Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6E568817C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjBBPQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjBBPQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:16:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2083518C5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:16:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BEE3B82159
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43C7C433EF;
        Thu,  2 Feb 2023 15:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675350997;
        bh=375h/0YdPQoA8OAiFk1H0myln1hPUol5vUQ4uYQaStI=;
        h=From:To:Cc:Subject:Date:From;
        b=cAmbjzs1sC4rbzy4R2pEMCwQC1CbJ6NBVhhihQJaNKQ4C/nBZGbGdcHFt67Fe5L0S
         M0nxBT6iGdIOxqh+3mAWxFSN2Rqh7lmZxnqCCbfe8nz/GBC0Ju7DtM4zVg36R/8KgJ
         6JParMOmHU8BA89wXuaGItUyx94zxcp8hYYju0pI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH] kernel/fail_function: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 16:16:33 +0100
Message-Id: <20230202151633.2310897-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109; i=gregkh@linuxfoundation.org; h=from:subject; bh=375h/0YdPQoA8OAiFk1H0myln1hPUol5vUQ4uYQaStI=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3L180YFDdsqLGVELKL65IOGPS/geLf23m/sf2R+6RG9PF /YUHO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiRUoMC26YcL3uPFP74zSDbbcv/4 X6u5PuZTIsOP1t5VIZc9YjrYcWVp5VEFq+TWoGJwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic
at once.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/fail_function.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index a7ccd2930c5f..d971a0189319 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -163,10 +163,7 @@ static void fei_debugfs_add_attr(struct fei_attr *attr)
 
 static void fei_debugfs_remove_attr(struct fei_attr *attr)
 {
-	struct dentry *dir;
-
-	dir = debugfs_lookup(attr->kp.symbol_name, fei_debugfs_dir);
-	debugfs_remove_recursive(dir);
+	debugfs_lookup_and_remove(attr->kp.symbol_name, fei_debugfs_dir);
 }
 
 static int fei_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
-- 
2.39.1

