Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75AC72D11C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbjFLUvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbjFLUs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:48:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4622610DC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E217E62F22
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63406C4339E;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=Ztog5VulF0m7oJUFFCX3inDjV0jHrtLC2NTdl6UI15w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GViwPJckT5wfjzpiiSHs4J+q62lMGTpuSLIgPFUTk7YT6Ps9gLKM0a583L7rwRY0V
         yRwERywFicxoSU0Mayl0N8XpcDEOCQZm9vE3W7mXaXTahaxKQZtuEgMPH13DFEIIzS
         R7a23FMC5YK5NCyKn5rqjsMS+iyO7CV77pnxteu2Xkwa+pKPr53C3PgojrGQnuxlwn
         QNxFm/asS5HzAH56mDqZ5fKVTTigEQyWEuGeE6y3+9cF1sR3fypWYrsKgb0iVFrHaL
         PkNe0ncwdXZ+C2OJvTElBGw0VLLIVnb4pIbOBE41AfnHJbCeW1hdv50dfMHL6tIz4b
         6lt24zdyo5EzQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 22678CE3A91; Mon, 12 Jun 2023 13:45:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Zhangjin Wu <falcon@tinylab.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 48/53] tools/nolibc: open: fix up compile warning for arm
Date:   Mon, 12 Jun 2023 13:45:09 -0700
Message-Id: <20230612204514.292087-48-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Zhangjin Wu <falcon@tinylab.org>

    In function ‘open’:
    nolibc/sysroot/arm/include/sys.h:919:23: warning: ‘mode_t’ {aka ‘short unsigned int’} is promoted to ‘int’ when passed through ‘...’
      919 |   mode = va_arg(args, mode_t);
          |                       ^
    nolibc/sysroot/arm/include/sys.h:919:23: note: (so you should pass ‘int’ not ‘mode_t’ {aka ‘short unsigned int’} to ‘va_arg’)
    nolibc/sysroot/arm/include/sys.h:919:23: note: if this code is reached, the program will abort

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/sys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 0160605444e7..856249a11890 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -862,7 +862,7 @@ int open(const char *path, int flags, ...)
 		va_list args;
 
 		va_start(args, flags);
-		mode = va_arg(args, mode_t);
+		mode = va_arg(args, int);
 		va_end(args);
 	}
 
-- 
2.40.1

