Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657526ECA73
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjDXKh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjDXKhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:37:11 -0400
Received: from master.debian.org (master.debian.org [IPv6:2001:41b8:202:deb:216:36ff:fe40:4001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE24540F8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 03:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=DH8eQInnr7U31EI29uizxjqLJRiL/+5W4FDZDgI7Tyc=; b=Ik
        8eS6DIpBxoR6LwRIIUIgv5EvwREoi9Df3JWTF4+ZVlo6WhFvWdc5+uC6pY77RjyOTIu8WoNYWsXQs
        LuE6vQfZBfmHwrNqkwYq//6a8pQheQ8kM5/Z9ptXq9fxnWxKd8qN32fGm4/1r3zxLOqegR2B2kZjp
        8YPJXOircRgxFnGaBpfrNVZRNPiNFA1/HNIcXx7L2fxwjLuUowDJ+bZmtl0eAlc62O968nIx+aP4a
        Ud1+RGFvGVkan5cwpmVkmq0qLn38gP7cCJDx/0RYpNWhq53RtaMjfpspIJHZ+/MGmuME8qtElrDUo
        h9tSPYTA/GiiAhgYAwfEKN9//jUWV7dA==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
        (envelope-from <ukleinek@master.debian.org>)
        id 1pqtJV-008Nwb-Eu; Mon, 24 Apr 2023 10:20:53 +0000
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Diederik de Haas <didi.debian@cknow.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools lib api: Use -D_FORTIFY_SOURCE=2 for non-debug builds
Date:   Mon, 24 Apr 2023 12:20:49 +0200
Message-Id: <20230424102049.58338-1-ukleinek@debian.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=844; i=ukleinek@debian.org; h=from:subject; bh=METKeq58NIa3te2pF/G6Rup2tETn8NZhlwCBHAmIgQ4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhhS3CIYHaU4qffm378jftjL5oManHP6UMXKhVsmxqanWb ttmOVd2MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCRx+vZ/8ckRKeuONktZ9wm zelx6/rX4y0uC3ztqpUzTqpGPjgc6P/jZq12a/hk3fOffytujq+WrloYlGFwJMxkyorJenYsXEm GCp2L4wyrMnr6rtS/612wNW+zeJyZ3ncNlbt8z+vjNu+PPvzjtWTzzfR3udOfvi+6LfUmY96e7T wMzsJXvSQfX43eoVS3zNvL4nbLd0/Rx1/TUlfejzVXsCt0rdvoHjXp9t9JofamH5ViCxrDsnYlf 5YI8/lnN6N51wUmthUxYW/PXjQ/OlGleFFJ355YnfnVv9QWP723fUFa4oSvi3//TF1s7y2zTnru BzOJBzF8tX4Z7rvWf+5saPhre3TyM3vDjSL84uxzrXp8AQ==
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 58b79186c343 ("tools lib api: Fix make DEBUG=1 build") intended
to drop -D_FORTIFY_SOURCE=2 for debug builds. It did that, but also
degraded -D_FORTIFY_SOURCE=2 to -D_FORTIFY_SOURCE (which implicitly
defines the symbol to 1), probably by mistake. Add the =2 back.

Fixes: 58b79186c343 ("tools lib api: Fix make DEBUG=1 build")
Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
 tools/lib/api/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 044860ac1ed1..e165357e1512 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -39,7 +39,7 @@ endif
 endif
 
 ifeq ($(DEBUG),0)
-  CFLAGS += -D_FORTIFY_SOURCE
+  CFLAGS += -D_FORTIFY_SOURCE=2
 endif
 
 # Treat warnings as errors unless directed not to
-- 
2.39.2

