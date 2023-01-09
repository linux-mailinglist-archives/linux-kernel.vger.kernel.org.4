Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C611662772
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbjAINmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbjAINlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:41:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B95111C;
        Mon,  9 Jan 2023 05:40:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76EC6B80DE2;
        Mon,  9 Jan 2023 13:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1778C433F0;
        Mon,  9 Jan 2023 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673271646;
        bh=9EuVXjz2UbAmjPovKyC95UPc5WfADTmiN/ZzTiBVjz4=;
        h=From:To:Cc:Subject:Date:From;
        b=hVVP+FSOg1gJIOT65Dz4kcG/y72uM36JlWYMDZv14sAB5m/u/5rln+pnt2av4ATxG
         +NlEjDVzOQLcKd3iadCtF0OA1TwktZnEUjYfavepl4KVxc3JKRdRAdFON3sfy3pwrK
         HFnnCsQM5kyw7KjLNa4QZLMbOhdVvdtjq9KxD+xBO3jHeDbCAk0A4nC4few+hRDDdK
         jIMcW4bpU41C8oH5SmC0CvaKXeKttQyoPAmMhYrny3DJ8oqDVDT2H7q06ywCTWRlDq
         rGqtKflb0UKiKUASsUqDuZLAPcFNCN4weg43fHZGZoHspi17Jhw7nG/gswgBbfWtYi
         j0O+4BvDIVAcA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: replace $(dot-target).tmp in filechk with $(tmp-target)
Date:   Mon,  9 Jan 2023 22:40:40 +0900
Message-Id: <20230109134040.3191458-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

$(tmp-target) is a better fit for local use like this.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Kbuild.include | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 4648ab8f11d4..7778cc97a4e0 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -99,11 +99,11 @@ define filechk
 	$(check-FORCE)
 	$(Q)set -e;						\
 	mkdir -p $(dir $@);					\
-	trap "rm -f $(dot-target).tmp" EXIT;			\
-	{ $(filechk_$(1)); } > $(dot-target).tmp;		\
-	if [ ! -r $@ ] || ! cmp -s $@ $(dot-target).tmp; then	\
+	trap "rm -f $(tmp-target)" EXIT;			\
+	{ $(filechk_$(1)); } > $(tmp-target);			\
+	if [ ! -r $@ ] || ! cmp -s $@ $(tmp-target); then	\
 		$(kecho) '  UPD     $@';			\
-		mv -f $(dot-target).tmp $@;			\
+		mv -f $(tmp-target) $@;				\
 	fi
 endef
 
-- 
2.34.1

