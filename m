Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7149A68ED92
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjBHLO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjBHLOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:14:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51926252A4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:14:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E188F6162F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F118CC433EF;
        Wed,  8 Feb 2023 11:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854859;
        bh=PZzGpl+8CjvP6M9qzHvZdlUXDvUpv1J5wQBWhMe4CgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=caOzQcyWJosdreqxaNtSA06wmmTsdMF77U1XH7pEEiTLGKSlMp4btkoYWP6Miw/xO
         Xgb9S9H+mw/+5aTQ2Dpb5beTtgP1YqU5AuvdhGJWL4gSNiwaZMZ3FBw3Bkb7ALJrE6
         gM4zRGM4hyPRMQ1ZjhBs7DINoDd0HnQVsvzHsyUA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 20/21] driver core: bus: constify some internal functions
Date:   Wed,  8 Feb 2023 12:13:29 +0100
Message-Id: <20230208111330.439504-21-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255; i=gregkh@linuxfoundation.org; h=from:subject; bh=PZzGpl+8CjvP6M9qzHvZdlUXDvUpv1J5wQBWhMe4CgI=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm2+yXvoj8fPTsbNlkyYm3l/H1rSI17c8cpdZrHgll7+/ 73mdjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIG1mG+bGyfVm3Nux9sjHmVaPfu9 zPX93snjEsWPbs94Zr7oKTewKWKd+s35uR+/iWOwA=
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

The functions add_probe_files() and remove_probe_files() should be
taking a const * to bus_type, not just a *, so fix that up.  These
functions should really be removed entirely and an attribute group used
instead, but for now, make this change so that other const work can
continue.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 815638bf63db..a7aada8817ce 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -603,7 +603,7 @@ static void remove_bind_files(struct device_driver *drv)
 static BUS_ATTR_WO(drivers_probe);
 static BUS_ATTR_RW(drivers_autoprobe);
 
-static int add_probe_files(struct bus_type *bus)
+static int add_probe_files(const struct bus_type *bus)
 {
 	int retval;
 
@@ -618,7 +618,7 @@ static int add_probe_files(struct bus_type *bus)
 	return retval;
 }
 
-static void remove_probe_files(struct bus_type *bus)
+static void remove_probe_files(const struct bus_type *bus)
 {
 	bus_remove_file(bus, &bus_attr_drivers_autoprobe);
 	bus_remove_file(bus, &bus_attr_drivers_probe);
-- 
2.39.1

