Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11217745B20
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGCLbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGCLbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:31:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C4FC6;
        Mon,  3 Jul 2023 04:31:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5381560EDF;
        Mon,  3 Jul 2023 11:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441B6C433C7;
        Mon,  3 Jul 2023 11:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688383907;
        bh=TsjDdvjS8/OWRhhJmkiLl/ZF0tTAzN9y6MLUtNVZ9rw=;
        h=From:To:Cc:Subject:Date:From;
        b=fkTJ4qZ5AL/d49j52i/ZpcisAhtjImBdHPPpTYz00V5ReU6DYoLN7zJUHLFgWUGD4
         NQuY1GO7aMu1wuzM4wQRO9oCNMgf1mDNFgSwaqWcmMhs8l20PZB/FrdzA7E4OIUfbi
         843ao+uUzuBxXTaUKS4ZYFMVS8HdhWJYxDOAMdw7oTm4It88405Y2YFUScoNFMQqmf
         SpK0NWi8ys7dmk+nUZIZmTLpS7C/A1AMc14RaPmdZmqx3ERhFcfy4v/Rkn4b1BN01I
         TsJFhqiYAfxh1C9uzFl1BA6+R+caJTK0921z7X+B/8xCQbSFBttK6DrnOBMd1hJItx
         j18fkK/DH2KOg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ovl: mark ovl_redirect_mode() as static again
Date:   Mon,  3 Jul 2023 13:31:33 +0200
Message-Id: <20230703113142.424670-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

This function was moved to another file and is no longer marked
static there, causing a W=1 warning:

fs/overlayfs/params.c:92:13: error: no previous prototype for 'ovl_redirect_mode' [-Werror=missing-prototypes]

This was probably lost by accident during the refactoring, as there is
still no caller in another file, so add back the annotation.

Fixes: 06bcaa2dafb7e ("ovl: move all parameter handling into params.{c,h}")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/overlayfs/params.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index b8c2f6056a9a8..a63160dbb0f95 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -89,7 +89,7 @@ const struct constant_table ovl_parameter_redirect_dir[] = {
 	{}
 };
 
-const char *ovl_redirect_mode(struct ovl_config *config)
+static const char *ovl_redirect_mode(struct ovl_config *config)
 {
 	return ovl_parameter_redirect_dir[config->redirect_mode].name;
 }
-- 
2.39.2

