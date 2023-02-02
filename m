Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4206882A2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjBBPf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjBBPe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:34:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226E86B025;
        Thu,  2 Feb 2023 07:34:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B21961BE9;
        Thu,  2 Feb 2023 15:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FD4C433D2;
        Thu,  2 Feb 2023 15:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675351985;
        bh=tIvo5TZOENRUN+V2jHoBHcC8wyCCjHYFP1TOGz+IonM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4kL0i/ts2k15V0PqGI8yGeLgBGbiehaI86XRV8RMD3TVMYGJeqfiEpzYiQKPwJTT
         9L9bR2Q+jx6vkMACOvXNAOtn4qSX3AiZGSGEQBUE22UwP9PQZ41WP+ZrNXNXoJKMte
         jdK9bm2C/bVGaG3jE4qubQ8/DQ70aXX/usDcOG30=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] USB: fotg210: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 16:32:27 +0100
Message-Id: <20230202153235.2412790-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
References: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; i=gregkh@linuxfoundation.org; h=from:subject; bh=tIvo5TZOENRUN+V2jHoBHcC8wyCCjHYFP1TOGz+IonM=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3r080+3Znw90Om2KuU0scFpfxPNzk//v+1w//XsTsY/Dw 1ly4tCOWhUGQiUFWTJHlyzaeo/srDil6GdqehpnDygQyhIGLUwAm8i6EYZ5OjefHFZHahfUC1ff+mC QvEGHv/cqwYF5lq9OPT3/tU0UnLsqcfuM3V8EhUQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic
at once.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/fotg210/fotg210-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index 51ac93a2eb98..1c5eb8f8c19c 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -862,7 +862,7 @@ static inline void remove_debug_files(struct fotg210_hcd *fotg210)
 {
 	struct usb_bus *bus = &fotg210_to_hcd(fotg210)->self;
 
-	debugfs_remove(debugfs_lookup(bus->bus_name, fotg210_debug_root));
+	debugfs_lookup_and_remove(bus->bus_name, fotg210_debug_root);
 }
 
 /* handshake - spin reading hc until handshake completes or fails
-- 
2.39.1

