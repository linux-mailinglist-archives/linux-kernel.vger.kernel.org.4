Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EDB70570D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjEPTZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjEPTZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:25:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CC57AB8;
        Tue, 16 May 2023 12:25:43 -0700 (PDT)
Date:   Tue, 16 May 2023 19:25:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684265141;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5oc/4U3LxxwXeuua8k3JKf4lQsuXnu0v2GB/nxPvrxQ=;
        b=jrCnx+4OnOu6Wo7yd0zVoHojAQarFBr68+unZtHgM3yVAnr+rNU+R5/lpQbq+5aE6eawVC
        AEdwA0qol+H3jj2GzaEEjoStSONGquqD/5yEISXfwF8EHY2SSce7nTC+zHTzNbLdoq6zOA
        QVIy0n7G1YAGiv3Sa2ctLXtSX2IQsy402BHGkvUeYw8bhIAdweQoedsnufDn7WIWHPhI3J
        Q56V0c4j+rFbHEBh9CsrrBC5Jk2T5GzZMz1yBz9BAmWx7TlxqS9SHv0LKB03r8SUoPtRpS
        beFQx8sj6yVw3A40aRneB+jl+wwV4ooi2du+nRZpOr30jkV5LEll+rfOiaj4cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684265141;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5oc/4U3LxxwXeuua8k3JKf4lQsuXnu0v2GB/nxPvrxQ=;
        b=R9LF7eEz0yLjneDEU213z5m8mo1jQ821QyVAzbxo/+uCXJxz9qA9cUEh88lbjz9uLZz7CT
        FqPnxRRqg2JTrxBA==
From:   "tip-bot2 for Osama Muhammad" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] ras/debugfs: Fix error checking for debugfs_create_dir()
Cc:     Osama Muhammad <osmtendev@gmail.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230516182927.9171-1-osmtendev@gmail.com>
References: <20230516182927.9171-1-osmtendev@gmail.com>
MIME-Version: 1.0
Message-ID: <168426514015.404.17879655413957369852.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     2a1d18a5dc5056825b8e9527d188130da6256efc
Gitweb:        https://git.kernel.org/tip/2a1d18a5dc5056825b8e9527d188130da6256efc
Author:        Osama Muhammad <osmtendev@gmail.com>
AuthorDate:    Tue, 16 May 2023 23:29:27 +05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 16 May 2023 21:12:23 +02:00

ras/debugfs: Fix error checking for debugfs_create_dir()

Check the return value of debugfs_create_dir() properly.

  [ bp: Rewrite commit message. ]

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230516182927.9171-1-osmtendev@gmail.com
---
 drivers/ras/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index f0a6391..ffb973c 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -46,7 +46,7 @@ int __init ras_add_daemon_trace(void)
 
 	fentry = debugfs_create_file("daemon_active", S_IRUSR, ras_debugfs_dir,
 				     NULL, &trace_fops);
-	if (!fentry)
+	if (IS_ERR(fentry))
 		return -ENODEV;
 
 	return 0;
