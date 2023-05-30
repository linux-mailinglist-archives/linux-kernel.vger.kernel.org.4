Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C741715CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjE3LQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjE3LQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:16:13 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 May 2023 04:16:11 PDT
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B26E93;
        Tue, 30 May 2023 04:16:11 -0700 (PDT)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPA id 3ED242FC007A;
        Tue, 30 May 2023 13:06:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1685444768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qQ9YK8rddIfrIirWxuUgQ4NKirFKYbJIMRVIeH2jRsA=;
        b=lf56dfXz1o11BBhbohoWBxPVAf+QFfHGyGZh8fKEtJBq5rYS0u46WqOXoMSwD5/L/tgMWU
        /b6BkJhBYTb28DPjCS//Y1pazohJWLGftD5rinb7/Qsn8nkKNBwE/nVEjbNypDaC22naU2
        cT1JKKyvXf21EQ98oc4NB71zNSactJM=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Werner Sembach <wse@tuxedocomputers.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] input: Add new keyboard backlight control keys to match modern notebooks
Date:   Tue, 30 May 2023 13:05:49 +0200
Message-Id: <20230530110550.18289-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old three KEY_KBDILLUM* keycodes don't reflect the current situation
modern notebooks anymore. Especially the ones with RGB keyboards.

e.g.
- Clevo NL50NU has a toggle, an up, a down and a color-cycle key
- TongFang PH4ARX1 doesn't have a toggle key, but one that cycles through
  off, half-brightness, and full-brightness.

Also, on some devices these keys are already implemented in firmware. It
would still be nice if there is a way to let userspace know when one of
these keys is pressed to display the OSD, but don't advice it to actually
do anything. This is the intended purpose of the KEY_KBDILLUMCHANGE define.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 include/uapi/linux/input-event-codes.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 022a520e31fc2..05287bf9a77f7 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -803,6 +803,10 @@
 #define BTN_TRIGGER_HAPPY39		0x2e6
 #define BTN_TRIGGER_HAPPY40		0x2e7
 
+#define KEY_KBDILLUMCYCLE		0x2e8
+#define KEY_KBDILLUMCOLORCYCLE		0x2e9
+#define KEY_KBDILLUMCHANGE		0x2ea
+
 /* We avoid low common keys in module aliases so they don't get huge. */
 #define KEY_MIN_INTERESTING	KEY_MUTE
 #define KEY_MAX			0x2ff
-- 
2.34.1

