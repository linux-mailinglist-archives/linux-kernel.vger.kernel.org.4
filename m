Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E186D3669
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjDBJLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDBJLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:11:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B1C641
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 02:11:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDA7C60917
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 09:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB11FC433EF;
        Sun,  2 Apr 2023 09:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680426690;
        bh=1YPYK7sayQjP+I10RuHiG39Itwo4QUIikFgJs5dJUOI=;
        h=From:To:Cc:Subject:Date:From;
        b=dXmn9KPR+SF/Hv52lz4rgiD1pLhkmp9/xXJ2Hfqc/E5lgJ7i92ClRK9/phRLgzIAk
         wUTlNfF3Lbv67OAylQ13C+35QWyeLG+5MmrSmiNXkyN48DuLynfWOljOjuQsuKrMKu
         I/uYY2wXkdYeR9DgR3Amy8a+Um4KV++wnzE54H/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: remove incorrect comment for device_create*
Date:   Sun,  2 Apr 2023 11:11:18 +0200
Message-Id: <2023040218-scouts-unplowed-24d2@gregkh>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1486; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=1YPYK7sayQjP+I10RuHiG39Itwo4QUIikFgJs5dJUOI=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmabts27PU4rHbVV1Ip0/avgL+RD3P8nK9BbqnrU1YKb nrQ9Uy4I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACYivYNhwfLrDVtzZmtdtrPs yP4oxc7y5eb6Fwzzs/fp5Vz20lpf2Rqy01ZAY0Z19Il2AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_create() and device_create_with_groups() function comments
incorrectly state that they only work with a struct class that was
created using class_create(), but that is not true now and I am not sure
if it ever was.  So just remove the comment as it's not needed now.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3ee5d206e7eb..7a42d1b6b721 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4330,9 +4330,6 @@ device_create_groups_vargs(const struct class *class, struct device *parent,
  * pointer.
  *
  * Returns &struct device pointer on success, or ERR_PTR() on error.
- *
- * Note: the struct class passed to this function must have previously
- * been created with a call to class_create().
  */
 struct device *device_create(const struct class *class, struct device *parent,
 			     dev_t devt, void *drvdata, const char *fmt, ...)
@@ -4371,9 +4368,6 @@ EXPORT_SYMBOL_GPL(device_create);
  * pointer.
  *
  * Returns &struct device pointer on success, or ERR_PTR() on error.
- *
- * Note: the struct class passed to this function must have previously
- * been created with a call to class_create().
  */
 struct device *device_create_with_groups(const struct class *class,
 					 struct device *parent, dev_t devt,
-- 
2.40.0

