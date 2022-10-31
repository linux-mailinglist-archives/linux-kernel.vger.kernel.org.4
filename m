Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7B36134BB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiJaLnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiJaLnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:43:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D25BE0F2;
        Mon, 31 Oct 2022 04:43:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D18B6B815DB;
        Mon, 31 Oct 2022 11:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74A0C433C1;
        Mon, 31 Oct 2022 11:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667216607;
        bh=LGnwjiqFus4lC7lWjIH4WNJZsVUsagb01qZRNxcct+E=;
        h=From:To:Cc:Subject:Date:From;
        b=Y0BQvMvmkMXx/sjgMO28MKqSkIRr50j9BqrFXyfrHt+/Li8RopYmwEjlIoxehYT2/
         jGMrkNe/FnbgW/B/kKFUTfjiLd+jRchTceGI+A8xTZMlEoGEpeC/JLIjtAol8tmAGH
         DvzWNqM+JbXlY3+Xvgxt0oa/oXDYkV/2pqug4/ngShlMkqUe/GgZFqLNcUGVzwK5R8
         +BlFqOWfHiozTNvhfc/TiJoD2KHC8Kfx7V5OITlEucFC0kJtyj6gLxmH+/LxIn8WC9
         Qp1fhMO8P9A9Cpoj644e4tAS9IdOYtX/E+ZAKA1Leypzq0qlfwq2vbQm6DKJ0AKh2R
         +9i9VW81BBqEw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     andreas.noever@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Martin Liska <mliska@suse.cz>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH] thunderbolt (gcc13): synchronize tb_port_is_clx_enabled()'s 2nd param
Date:   Mon, 31 Oct 2022 12:43:23 +0100
Message-Id: <20221031114323.10356-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tb_port_is_clx_enabled() generates a valid warning with gcc-13:
  drivers/thunderbolt/switch.c:1286:6: error: conflicting types for 'tb_port_is_clx_enabled' due to enum/integer mismatch; have 'bool(struct tb_port *, unsigned int)' ...
  drivers/thunderbolt/tb.h:1050:6: note: previous declaration of 'tb_port_is_clx_enabled' with type 'bool(struct tb_port *, enum tb_clx)' ...

I.e. the type of the 2nd parameter of tb_port_is_clx_enabled() in the
declaration is unsigned int, while the definition spells enum tb_clx.
Synchronize them to the latter. And do the same for
tb_port_clx_supported() where the enum is propagated.

Cc: Martin Liska <mliska@suse.cz>
Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/thunderbolt/switch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 363d712aa364..3693395253bb 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1205,7 +1205,7 @@ static int tb_port_pm_secondary_disable(struct tb_port *port)
 }
 
 /* Called for USB4 or Titan Ridge routers only */
-static bool tb_port_clx_supported(struct tb_port *port, unsigned int clx_mask)
+static bool tb_port_clx_supported(struct tb_port *port, enum tb_clx clx_mask)
 {
 	u32 val, mask = 0;
 	bool ret;
@@ -1283,7 +1283,7 @@ static int tb_port_clx_enable(struct tb_port *port, enum tb_clx clx)
  *
  * Returns true if any of the given CL states is enabled for @port.
  */
-bool tb_port_is_clx_enabled(struct tb_port *port, unsigned int clx_mask)
+bool tb_port_is_clx_enabled(struct tb_port *port, enum tb_clx clx_mask)
 {
 	u32 val, mask = 0;
 	int ret;
-- 
2.38.1

