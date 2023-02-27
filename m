Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82F66A4A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjB0S73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjB0S7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:59:20 -0500
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6C7BB82;
        Mon, 27 Feb 2023 10:59:17 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 64744C800A8;
        Mon, 27 Feb 2023 19:59:13 +0100 (CET)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass (1024-bit key)
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from; s=default; t=1677524353; x=1679338754; bh=Pz
        ld/BlHUR7+fjbmBgsLZE4//wkSxlN6HZrHrIeMuQE=; b=mH3wScEQubc736Fe9I
        85kivaadaRIuokUS8QUw7NZxA5OAZOXAfxqLpEMvyyQ5Gd947i8tQgVW2lKUSB3I
        PXJgQ8cR4sa/WYRVt8zuZoir04WHXJJ7TpsZAQh+AheWP2IGn/rY7q1eca5Ju5GT
        EkmX59xEzcDCXWhvtvi73JKe0=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id pwyRWd4o_6N1; Mon, 27 Feb 2023 19:59:13 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id C2201C800A2;
        Mon, 27 Feb 2023 19:59:12 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, wse@tuxedocomputers.com,
        swboyd@chromium.org, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, mkorpershoek@baylibre.com,
        chenhuacai@kernel.org, wsa+renesas@sang-engineering.com,
        tiwai@suse.de, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Input: atkbd - Make it possible to apply atkbd.reset via kernel quirk
Date:   Mon, 27 Feb 2023 19:59:06 +0100
Message-Id: <20230227185907.569154-2-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230227185907.569154-1-wse@tuxedocomputers.com>
References: <20230227185907.569154-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atkbd.reset was only a command line parameter. Some devices might have a
known bug that can be worked around by just permanently applying this
quirk.

This patch adds the ability to do this on the kernel level for known buggy
devices.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 drivers/input/keyboard/atkbd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 246958795f60..ef65c46c4efe 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1731,6 +1731,12 @@ static int __init atkbd_deactivate_fixup(const struct dmi_system_id *id)
 	return 1;
 }
 
+static int __init atkbd_reset_fixup(const struct dmi_system_id *id)
+{
+	atkbd_reset = true;
+	return 1;
+}
+
 /*
  * NOTE: do not add any more "force release" quirks to this table.  The
  * task of adjusting list of keys that should be "released" automatically
-- 
2.34.1

