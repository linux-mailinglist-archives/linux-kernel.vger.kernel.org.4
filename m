Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FE5662DE3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjAISAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbjAIR7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:59:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E2EFAFC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:58:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69D66B80EA0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 17:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25B8C433D2;
        Mon,  9 Jan 2023 17:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673287098;
        bh=fTpy5hsb7eADUxYGyZTZwZ6GgKuNxMeOcfiV0WexreY=;
        h=From:To:Cc:Subject:Date:From;
        b=VYZ/ll1KBRTjfUxZjwNkCvETv07bodyskDA6vvKpmxpCTx+LBJclB3vZg14a5QrWR
         CzDbUoMvXMfpoCrH0ETplVKqoOGP/eRXQwXpYHIHYymrYc/kfICor8pMJ8+9JBTzdb
         qvptbNMf/tpE2BM3BqTduZ+IlMid6EJTSCoQLilQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/6] driver core: make bus_get_device_klist() static
Date:   Mon,  9 Jan 2023 18:58:05 +0100
Message-Id: <20230109175810.2965448-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=gregkh@linuxfoundation.org; h=from:subject; bh=fTpy5hsb7eADUxYGyZTZwZ6GgKuNxMeOcfiV0WexreY=; b=owGbwMvMwCRo6H6F97bub03G02pJDMl7QteJlDTLzE07Iz31bujz/WvnTdE6fEhX7k+PR1u650F/ szkaHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRpZ8Y5le29R5zesd67T3/7r4jtR 8C11yeo8mwYELjq7da3xQ2Pjq01NjhA8fV1ywS1wA=
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

No one calls this function outside of drivers/base/bus.c so make it
static so it does not need to be exported anymore.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c         | 3 +--
 include/linux/device/bus.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index e1bf741063e0..4e6fdb65a157 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -927,11 +927,10 @@ struct kset *bus_get_kset(struct bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(bus_get_kset);
 
-struct klist *bus_get_device_klist(struct bus_type *bus)
+static struct klist *bus_get_device_klist(struct bus_type *bus)
 {
 	return &bus->p->klist_devices;
 }
-EXPORT_SYMBOL_GPL(bus_get_device_klist);
 
 /*
  * Yes, this forcibly breaks the klist abstraction temporarily.  It
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index f2cf7c4ddd20..0699b3970344 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -287,6 +287,5 @@ extern int bus_unregister_notifier(struct bus_type *bus,
 #define BUS_NOTIFY_DRIVER_NOT_BOUND	0x00000008 /* driver fails to be bound */
 
 extern struct kset *bus_get_kset(struct bus_type *bus);
-extern struct klist *bus_get_device_klist(struct bus_type *bus);
 
 #endif
-- 
2.39.0

