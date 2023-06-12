Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18F872D0EC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjFLUrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbjFLUq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:46:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339642136
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 488AF62BE7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B055C433A4;
        Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602716;
        bh=jzpYLjEQ1FslRejmeBHfDXFdJyRjrM8plGg590LqYRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9vW3AFRclszObUvNLAm+ePi9P+liWKoXayNX7uV/LvNTgdPic7sz0zzwoKP3V9I9
         tBJE2YMEPnZoXJ2VrFlmmxhqYHX1ZQ7BtLnmAyOxDDquFieMvXFhmkTRaZdtCH1P/2
         fNnd5K2xvnS9tN3y17DR893eJ5t1ZnaHvWfh4/8tA9ielv3sAwgvEj6L8VMIVU4dKp
         Vl72HWnUiz5nyD8gH+Zm4idD5T7jmDhEtsj1yvvtVu2JiqQeELU4qvn1s4ptWEz+gE
         dMsd9dstt9OT8p3CrM5L3C3CAZQMEMJmCHe7fHcDgqrfZLiPGsHHlfLYoidMtD2HMC
         e8N4f5Sj7g6JQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BAB9ACE3A42; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 08/53] tools/nolibc: Fix build of stdio.h due to header ordering
Date:   Mon, 12 Jun 2023 13:44:29 -0700
Message-Id: <20230612204514.292087-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

When we added fd based file streams we created references to STx_FILENO in
stdio.h but these constants are declared in unistd.h which is the last file
included by the top level nolibc.h meaning those constants are not defined
when we try to build stdio.h. This causes programs using nolibc.h to fail
to build.

Reorder the headers to avoid this issue.

Fixes: d449546c957f ("tools/nolibc: implement fd-based FILE streams")
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 04739a6293c4..05a228a6ee78 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -99,11 +99,11 @@
 #include "sys.h"
 #include "ctype.h"
 #include "signal.h"
+#include "unistd.h"
 #include "stdio.h"
 #include "stdlib.h"
 #include "string.h"
 #include "time.h"
-#include "unistd.h"
 #include "stackprotector.h"
 
 /* Used by programs to avoid std includes */
-- 
2.40.1

