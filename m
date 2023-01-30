Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38526803A9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbjA3CBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbjA3CB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:01:28 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DCB1CAC3;
        Sun, 29 Jan 2023 18:01:24 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675044081;
        bh=vszqxSH91EE5mncd+gKKGfi1eFcrVSvkglPY0MNqyPk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bUTofwUYm3FX/jUiFs0II2wPYPsNOGq44L4Q3ak/pRCTqeyQcSsl6QbBUPNkVmjl9
         Gi34ESVbNaWK2kz6L3QexWJbq+8hS5Hjnqji810JvDmIIwqQMpT/1mqqySWSavPHL1
         Kd4oqWX//k6h+dxUSMSs0OtZq6REM6eQ7HDwFciA=
Date:   Mon, 30 Jan 2023 02:01:18 +0000
Subject: [PATCH 1/3] dyndbg: constify opt_array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221223-dyndbg-filename-v1-1-cbf8543009a1@weissschuh.net>
References: <20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net>
In-Reply-To: <20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net>
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675044079; l=714;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vszqxSH91EE5mncd+gKKGfi1eFcrVSvkglPY0MNqyPk=;
 b=IBMq3PGz9Qksnzc5M4ZrloHLssDarvdTSs+Er71Nx5cjPoKIDzd+VWnJbz8+qoIleLhqGqLS91JR
 gapDI4CtAp0ynPvnaZCGFYUCCN3YkESUXGM07vnJxvR5H0T1Gih4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is never modified, so mark it const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 009f2ead09c1..6915e088bed6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -88,7 +88,7 @@ static inline const char *trim_prefix(const char *path)
 	return path + skip;
 }
 
-static struct { unsigned flag:8; char opt_char; } opt_array[] = {
+static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_PRINT, 'p' },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },

-- 
2.39.1

