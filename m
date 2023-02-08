Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA91968ED8E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjBHLOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjBHLNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:13:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39B125BB8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:13:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98C97B81D46
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C73C433EF;
        Wed,  8 Feb 2023 11:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854819;
        bh=sdzTtC9zNARFDh/vm8BmQmgIG2LMt8G7elj3RADg63I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2/Zb3IkE1n5T63L4PSp9E+yQGx91uT0/EuqDAB+BqjvqWunfHa5lH5EhWIhm7tY7
         v1tMhJkWc+7qP/mzEEZQTNz1yv8mxZQYSqwSZ/3XJmewMDGBRTjKlwvryR0VthJRlw
         J0Y7jvMsOI2yXSWPjlr2spyXA7ZElKXPV8IrXhac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 01/21] driver core: add local subsys_get and subsys_put functions
Date:   Wed,  8 Feb 2023 12:13:10 +0100
Message-Id: <20230208111330.439504-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087; i=gregkh@linuxfoundation.org; h=from:subject; bh=sdzTtC9zNARFDh/vm8BmQmgIG2LMt8G7elj3RADg63I=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm6/W90/+8qVyl26taqRiwt/2qNvma7ZKO2+SM22Z/OXv 2/n+HbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRc1cZZrOc/+Oh8f2s5/WO0HqdKy x7fNPWfGNYcEnsrmLfBm7LeSvmJTbP+Hk082kQHwA=
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

We need to control the reference count of the subsys private structure
instead of directly manipulating the kset reference count of it, so wrap
that logic up in a subsys_get() and subsys_put() function to make it more
obvious as to what is happening.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0e806f641079..9e06c18c7a64 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -57,6 +57,19 @@ struct subsys_private {
 };
 #define to_subsys_private(obj) container_of_const(obj, struct subsys_private, subsys.kobj)
 
+static inline struct subsys_private *subsys_get(struct subsys_private *sp)
+{
+	if (sp)
+		kset_get(&sp->subsys);
+	return sp;
+}
+
+static inline void subsys_put(struct subsys_private *sp)
+{
+	if (sp)
+		kset_put(&sp->subsys);
+}
+
 struct driver_private {
 	struct kobject kobj;
 	struct klist klist_devices;
-- 
2.39.1

