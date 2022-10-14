Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736875FF472
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiJNUSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiJNUSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7397F1BFB89;
        Fri, 14 Oct 2022 13:18:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 660E461BEA;
        Fri, 14 Oct 2022 20:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819D4C433D6;
        Fri, 14 Oct 2022 20:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665778697;
        bh=er/JSvL2jSFCE1JJ71zJTUuSPL0SOIkeIx7Z8OFyvsw=;
        h=From:To:Cc:Subject:Date:From;
        b=UahQdusAca2FmKC8jMbNiUQ4LFzQ6FX2FlBE/05CTtDYuSRFNj3WjyIHwFVSSbqB0
         L1MqxieNmbtcjI9xiJmOOquMl8Gvjmk9/MlwbL6CgbHC7ZzYUA879hex7r9/GQoCyl
         SFepZlQNjIpUD20seuFGlmgoPL1rRyLc8LAX0OZKgrlQZnW2/0B3bsFKgeVxaHYJIE
         j/hpvJOU3IY6Rgn76DWtJeNJcF12ekpfj0WA+ddXXrR6olr0ILyrKmsybnSvNfBAIU
         t5Ot92C44rC4UI5TbYV4tr/EMOACwJW3KwVdqLCg+epNfi9AqzbQPrqRF//0YiQ/RP
         bDgimq6io/q8w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: fix single directory build
Date:   Sat, 15 Oct 2022 05:18:11 +0900
Message-Id: <20221014201811.1118103-1-masahiroy@kernel.org>
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

Commit f110e5a250e3 ("kbuild: refactor single builds of *.ko") was wrong.

KBUILD_MODULES _is_ needed for single builds.

Otherwise, "make foo/bar/baz/" does not build module objects at all.

Fixes: f110e5a250e3 ("kbuild: refactor single builds of *.ko")
Reported-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 85a63a1d29b3..48a005fc69ca 100644
--- a/Makefile
+++ b/Makefile
@@ -1978,6 +1978,8 @@ endif
 
 single-goals := $(addprefix $(build-dir)/, $(single-no-ko))
 
+KBUILD_MODULES := 1
+
 endif
 
 # Preset locale variables to speed up the build process. Limit locale
-- 
2.34.1

