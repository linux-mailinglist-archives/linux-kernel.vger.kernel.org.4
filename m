Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE52747962
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 23:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGDVDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 17:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGDVDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:03:33 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1717110D7;
        Tue,  4 Jul 2023 14:03:31 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1688504608;
        bh=5uR0LdnKjKs0n4uZv6fjdMfj3y5tRy2LwcBBWPqIGm8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=cEWNAPOzRnEmGGm56FkorByHHnQ1fXlfXHSpwPgAGLWFVMKtdXyvHQaYappRDGLNK
         lLeBpAhGE61YK1DA5CmEU5BKjPlvwKJDnvsq5wiMqZ3tb0YJ6pzZzsTI3hKy4MlFlu
         BcH6/INRbYLcG0ziGw0ih3j4qep2BiDt8CfDDp2I=
Date:   Tue, 04 Jul 2023 23:03:17 +0200
Subject: [PATCH 1/2] platform/x86: thinkpad_acpi: take mutex for
 hotkey_mask_{set,get}
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230704-thinkpad_acpi-lockdep-v1-1-60129548a738@weissschuh.net>
References: <20230704-thinkpad_acpi-lockdep-v1-0-60129548a738@weissschuh.net>
In-Reply-To: <20230704-thinkpad_acpi-lockdep-v1-0-60129548a738@weissschuh.net>
To:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688504608; l=1340;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=5uR0LdnKjKs0n4uZv6fjdMfj3y5tRy2LwcBBWPqIGm8=;
 b=JuLe2U8TccNMJjW0vtcgW8wNPauuFWJBOT+UdbRBgSvpf4mkRCCrd5Pr0nQLZ4UWV3l21oOOj
 v+O+fIlQN0BB3IPpJhsHTjDGx3/aTXviz1RJSWmdmCNeVqIQTMEVPRP
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hotkey_mask_set() and hotkey_mask_get() expect hotkey_mutex to be held.
While it should not matter during initialization a following patch will
enable lockdep for hotkey_mutex which would produce warnings here.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/thinkpad_acpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 187018ffb068..b796e65c99e0 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3478,7 +3478,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	if (tp_features.hotkey_mask) {
 		/* hotkey_source_mask *must* be zero for
 		 * the first hotkey_mask_get to return hotkey_orig_mask */
+		mutex_lock(&hotkey_mutex);
 		res = hotkey_mask_get();
+		mutex_unlock(&hotkey_mutex);
 		if (res)
 			return res;
 
@@ -3577,9 +3579,11 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		hotkey_exit();
 		return res;
 	}
+	mutex_lock(&hotkey_mutex);
 	res = hotkey_mask_set(((hotkey_all_mask & ~hotkey_reserved_mask)
 			       | hotkey_driver_mask)
 			      & ~hotkey_source_mask);
+	mutex_unlock(&hotkey_mutex);
 	if (res < 0 && res != -ENXIO) {
 		hotkey_exit();
 		return res;

-- 
2.41.0

