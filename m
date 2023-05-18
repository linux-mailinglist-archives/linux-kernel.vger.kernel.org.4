Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688AB708455
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjEROzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjEROz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:55:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E5C134
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:55:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58C0664FE5
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D283EC433A7;
        Thu, 18 May 2023 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684421723;
        bh=7fx9cBawBfJl+YSrog0I3p8/dTOjG7DqC+tH8F5Flnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESEWGnAjo/HVn4GfEj1I8nQlHRIlDNN8ReIhSbL/olfubCAM841eighiyg7x4JbIk
         GY+ANPWfE/M3UIEcwNIbbrhorl+53hUwLiGiyZewKWWVOfxJe5MRxQcdIVO3RkwOcS
         BVM5ufgarQGaoUChgvIH7JWjqwKpxCAbP+avSC0yvhZolXaFKjjJwean4/gdaEe8ja
         Zt+/tQGmRKf+8ThrePKtAOwZa7rAQo+k2dcwPRX7IpspEUmkno61pQwn+hcORB9x3N
         sg0W901GN1ycSkDkC19/bTsB/NnSof95wXltR5PH+nbM9pt+WMYC7VjEYMrMKGtPmo
         +1ivgNlH8bHag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2435DCE176A; Thu, 18 May 2023 07:55:23 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Mark Brown <broonie@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 08/15] tools/nolibc: Fix build of stdio.h due to header ordering
Date:   Thu, 18 May 2023 07:55:14 -0700
Message-Id: <20230518145521.3806117-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
References: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

