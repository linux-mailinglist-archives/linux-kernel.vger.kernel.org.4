Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652A96B065A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjCHLw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjCHLw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:52:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C761A273D;
        Wed,  8 Mar 2023 03:52:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4620861655;
        Wed,  8 Mar 2023 11:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373A2C433D2;
        Wed,  8 Mar 2023 11:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678276372;
        bh=BeJj33VWZheoqQzbtxVsohI47cZzA4a7E3ypOo6W0Pw=;
        h=From:To:Cc:Subject:Date:From;
        b=XHzIAH0oH+BppJXxAfqSReRiAUOg/CHKUXvRi+KNdxIHQzmRpBfINd+ZSnMobb+Os
         FLwt/8kP12IPYoGs5Uv/e5Y8A0S0Hyvv7bNecOM4WCX8TTDlQFXUQ0409t9XWCaWF8
         PxFpmOC76ROd/g72JyQSBmmpFgjgCDXiSI0l3/z/XwB8NfEMUxSWpnQd6HYns+36wI
         jMATkTumWGHnxB7KE242Y0/ohhokp/02fNol0HJFLRq7k5Kykk38ETmN6FpHL4cGAM
         MKP8MRQneSkOvccf+Xh1If7hY8dEP7OSlNeN0wWs5gW6ExXflhbAcn07eQiE0imbiz
         hnh95dFxLqWlA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/8] scripts/kallsyms: remove redundant code for omitting U and N
Date:   Wed,  8 Mar 2023 20:52:36 +0900
Message-Id: <20230308115243.82592-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol types 'U' and 'N' are already filtered out by the following
line in scripts/mksysmap:

    -e ' [aNUw] '

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kallsyms.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index ea1e3d3aaa6b..8148e880f78e 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -178,10 +178,7 @@ static bool is_ignored_symbol(const char *name, char type)
 			return true;
 	}
 
-	if (type == 'U' || type == 'u')
-		return true;
-	/* exclude debugging symbols */
-	if (type == 'N' || type == 'n')
+	if (type == 'u' || type == 'n')
 		return true;
 
 	if (toupper(type) == 'A') {
-- 
2.34.1

