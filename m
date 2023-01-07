Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E004B660CD0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 08:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjAGHsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 02:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjAGHsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 02:48:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B5684BD2;
        Fri,  6 Jan 2023 23:48:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F6F5601D2;
        Sat,  7 Jan 2023 07:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527D0C433F1;
        Sat,  7 Jan 2023 07:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673077679;
        bh=hqHvkpN/5QY5kQ1YmgQ/2OzEEuyZYjiS1pSN/GVMGhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YVRk40e/oAnznXDkuXepm//q4JFO2oAB1e9wklbaybrFCFVYoboqTxmYvTCRa7zbb
         TCRqd/GAyZ5Du2XPDaUTlF60qex5IGiaH/LCXw5SQvQ1VJv766W8rQHBldWZgisgBS
         2vGIDCLsk5z1d/w2CW2ZgFM9+n/DqrYL62x0dW5u2t8uBlFngSW7NVhUSYW+hA326/
         2ina9ctKNdaW1W/+lWNxTGDqLvLwNaQaDY1gB1KMJKqaZR/4A/ypMa+P4l4Tcya+lv
         OhxAR/Pq6k6ZdY4wnPMi1aH46R24/wVOo4jmnZYCkJwgFV08YpKFF7PbKVmftyfiYb
         IY0SJQlQ16lIQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH 2/3] tomoyo: avoid unneeded creation of builtin-policy.h
Date:   Sat,  7 Jan 2023 16:47:42 +0900
Message-Id: <20230107074743.3352242-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230107074743.3352242-1-masahiroy@kernel.org>
References: <20230107074743.3352242-1-masahiroy@kernel.org>
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

When CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING=y,
builtin-policy.h is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 security/tomoyo/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/tomoyo/Makefile b/security/tomoyo/Makefile
index 221eaadffb09..1b18a02ccd2e 100644
--- a/security/tomoyo/Makefile
+++ b/security/tomoyo/Makefile
@@ -13,4 +13,6 @@ quiet_cmd_policy  = POLICY  $@
 $(obj)/builtin-policy.h: $(wildcard $(obj)/policy/*.conf $(srctree)/$(src)/policy/*.conf.default) FORCE
 	$(call if_changed,policy)
 
+ifndef CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING
 $(obj)/common.o: $(obj)/builtin-policy.h
+endif
-- 
2.34.1

