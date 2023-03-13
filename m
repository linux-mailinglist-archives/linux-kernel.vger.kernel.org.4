Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ABA6B80CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCMSdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjCMSc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB8685B16
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:31:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E96FF61476
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06098C433D2;
        Mon, 13 Mar 2023 18:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732246;
        bh=4FnKiW2cwIGqgbis9fEoSgZQpWRB2eH3pM8Glh9uSeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Js8ii+wcLI23DREQ97XvJIEvycR9129hf21Ot9bddRs0n00Fqt5IFldEmugvApgz
         W0yJlgQhNrgPn9SPkyfG6TqhS2b2omjjZtcWEG6T8ugFdaTfTplQ2YjTPnkfmU/ibF
         qTTnp1gwJ+Xar6dNqQbFzdj276dzV1pJGtes4HFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 27/36] driver core: bus: constify bus_get()
Date:   Mon, 13 Mar 2023 19:29:09 +0100
Message-Id: <20230313182918.1312597-27-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; i=gregkh@linuxfoundation.org; h=from:subject; bh=4FnKiW2cwIGqgbis9fEoSgZQpWRB2eH3pM8Glh9uSeA=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82dWBsWxppo9ylV86me/g9f7oWLbxy3ZVwZ2uce1n+ nc9uvylI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACayVJRhvkNMwa/iQ+pLLe3r DOd+kGlKOzyximGeqVnNvlr2xCd8UuWRfv+iTVI3XpECAA==
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

It's funny to think about getting a reference count of a constant
structure pointer, but this locks into place the private data
"underneath" the struct bus_type() which is important to not go away
while we are working with the bus structure for some callbacks.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 8fea26c22521..84a21084d67d 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -84,7 +84,7 @@ static struct subsys_private *bus_to_subsys(const struct bus_type *bus)
 	return sp;
 }
 
-static struct bus_type *bus_get(struct bus_type *bus)
+static const struct bus_type *bus_get(const struct bus_type *bus)
 {
 	struct subsys_private *sp = bus_to_subsys(bus);
 
@@ -233,7 +233,7 @@ static const struct kset_uevent_ops bus_uevent_ops = {
 static ssize_t unbind_store(struct device_driver *drv, const char *buf,
 			    size_t count)
 {
-	struct bus_type *bus = bus_get(drv->bus);
+	const struct bus_type *bus = bus_get(drv->bus);
 	struct device *dev;
 	int err = -ENODEV;
 
@@ -256,7 +256,7 @@ static DRIVER_ATTR_IGNORE_LOCKDEP(unbind, 0200, NULL, unbind_store);
 static ssize_t bind_store(struct device_driver *drv, const char *buf,
 			  size_t count)
 {
-	struct bus_type *bus = bus_get(drv->bus);
+	const struct bus_type *bus = bus_get(drv->bus);
 	struct device *dev;
 	int err = -ENODEV;
 
-- 
2.39.2

