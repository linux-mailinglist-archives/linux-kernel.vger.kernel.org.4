Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DFA5EBED4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiI0Jky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiI0Jkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:40:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C9DB2CF2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E5AE6177A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14DFC433D6;
        Tue, 27 Sep 2022 09:40:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NRMFOfA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664271645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DmIhsZ1nWlEiVKrpPaAq/S0hIEh7ED/SIKN3PPJlQcA=;
        b=NRMFOfA7Bzd8KjdKexDz6gyQfjNZvBMtocLX+FGI9m+SCIlINmX1kt/bL8HzXKG0ut0ft2
        PdUmtFhpwt8SXvpzYtzEmoly/feCRAVVO1ivfN6zQy4K+CGTo4L07o05ZVDShGo6wfl0+y
        5XgbmhqskJioufiXtuL9VQWvNSY/jCg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6ce961e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 27 Sep 2022 09:40:45 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] sethostname: dump new hostname into RNG
Date:   Tue, 27 Sep 2022 11:40:39 +0200
Message-Id: <20220927094039.1563219-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some small machines with little entropy, a quasi-unique hostname is
sometimes a relevant factor. I've seen, for example, 8 character
alpha-numeric serial numbers. In addition, the time at which the hostname
is set is usually a decent measurement of how long early boot took. So,
call add_device_randomness() on new hostnames, which feeds its arguments
to the RNG in addition to a fresh cycle counter.

Low cost hooks like this never hurt and can only ever help, and since
this costs basically nothing for an operation that is never a fast path,
this is an overall easy win.

Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 kernel/sys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index b911fa6d81ab..7b7f973ea585 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1366,6 +1366,7 @@ SYSCALL_DEFINE2(sethostname, char __user *, name, int, len)
 	if (!copy_from_user(tmp, name, len)) {
 		struct new_utsname *u;
 
+		add_device_randomness(tmp, len);
 		down_write(&uts_sem);
 		u = utsname();
 		memcpy(u->nodename, tmp, len);
-- 
2.37.3

