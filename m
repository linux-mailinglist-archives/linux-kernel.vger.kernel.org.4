Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B07708B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjERWDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjERWDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:03:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC4DE57;
        Thu, 18 May 2023 15:03:14 -0700 (PDT)
Date:   Thu, 18 May 2023 22:03:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684447393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/NxiA/51FQFhSaENZM2Jcf7PcLcE5vMfY023kQopFJI=;
        b=rraneGP2o0qleA13RIsZGAbbHcGtTlypELUpEOB6ykxHaRD1OhLdiTh1Ksvo1QAdoY9bwO
        bXMI3c0Met1E3LtjnJD3f4sD2z1i5RWKanjfK8zFaC3Fu5ySMJzXgLQJug5Pr1U5fLpN2n
        zzgRfAzKRx8lwTvk4MJchL7+qFyS2oiIA5ohfp6wxxT+mUH6Xm3jC/uQyjX2aECdSseBrZ
        mz2e0uf1N+krTe522HLnH8/TZAi++vmMthT1pkzsAax5wXLrsEf4jQzwVMhke6kvbYSH01
        qmkx055UtZp0EH6rpy0qvmolaHDlyYR3EeG3VnClcd0iZ93SeiWeMz38yt4Hag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684447393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/NxiA/51FQFhSaENZM2Jcf7PcLcE5vMfY023kQopFJI=;
        b=IKV8FJs2nSXd2BwRqsVIv2m5FctEvzBTtwikgdPm+tIoPgZ4U2tHMHPYr6J/MWeA9r/LOl
        yaS1hFCeYj+SOEDg==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/vdso: Include vdso/processor.h
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168444739265.404.17829219403406293838.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     3e0bd4dd35406a130de02c1660e32f6c40121d35
Gitweb:        https://git.kernel.org/tip/3e0bd4dd35406a130de02c1660e32f6c40121d35
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 21:35:45 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 18 May 2023 11:56:18 -07:00

x86/vdso: Include vdso/processor.h

__vdso_getcpu is declared in a header but this is not included
before the definition, causing a W=1 warning:

arch/x86/entry/vdso/vgetcpu.c:13:1: error: no previous prototype for '__vdso_getcpu' [-Werror=missing-prototypes]
arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1: error: no previous prototype for '__vdso_getcpu' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://lore.kernel.org/all/20230516193549.544673-17-arnd%40kernel.org
---
 arch/x86/entry/vdso/vgetcpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
index 0a9007c..e464030 100644
--- a/arch/x86/entry/vdso/vgetcpu.c
+++ b/arch/x86/entry/vdso/vgetcpu.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/getcpu.h>
 #include <asm/segment.h>
+#include <vdso/processor.h>
 
 notrace long
 __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
