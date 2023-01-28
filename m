Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A5467F723
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjA1Kcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjA1Kck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:32:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF77DE078
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:32:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4989960AC1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 10:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34030C433EF;
        Sat, 28 Jan 2023 10:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674901958;
        bh=SPTnuBIxR8VBSA4mE6Tax7hR/OLeSZHZkemoMogaXMU=;
        h=From:To:Cc:Subject:Date:From;
        b=aNsUWymYfllNo4dTvBfz7zwI6diVZn62CPF1s4hnCpMI6Q1/M7k8TV3m6R1KD96i3
         8fD0Y578c87gj5xE8nz7fS2MEqjelKjpZajqFlpGtGyLVgmyoP7H9YmaelN4m90EZm
         rpiCybGsT60lHxxEYVPvPAR/qZ+G+egCSRcdMGaypXhRZIUk7PbP/Z0AWYoa/qfcWY
         mRE/9nE9EirYJZsgtX+tMRsMfgLyLqNI0RsDnMLHTF6dekjbwIAjWEeYBzhrqlOhOz
         5EiR3MD4DSK7jY5c64AY05asUBfde+Znr6EzsE823WKRVrTds2cXvVuypcdZsOfp2H
         BphJdaD2jVsrg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to handle F2FS_IOC_START_ATOMIC_REPLACE in f2fs_compat_ioctl()
Date:   Sat, 28 Jan 2023 18:32:26 +0800
Message-Id: <20230128103226.1318362-1-chao@kernel.org>
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

Otherwise, 32-bits binary call ioctl(F2FS_IOC_START_ATOMIC_REPLACE) will
fail in 64-bits kernel.

Fixes: 41e8f85a75fc ("f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6f6181b9b01e..39e3e5c85e57 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4845,6 +4845,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC32_MOVE_RANGE:
 		return f2fs_compat_ioc_move_range(file, arg);
 	case F2FS_IOC_START_ATOMIC_WRITE:
+	case F2FS_IOC_START_ATOMIC_REPLACE:
 	case F2FS_IOC_COMMIT_ATOMIC_WRITE:
 	case F2FS_IOC_START_VOLATILE_WRITE:
 	case F2FS_IOC_RELEASE_VOLATILE_WRITE:
-- 
2.25.1

