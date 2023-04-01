Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18076D32BD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 19:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjDARKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 13:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjDARKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 13:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947861BF4C
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 10:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1180560ED0
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 17:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D953C433D2;
        Sat,  1 Apr 2023 17:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680369017;
        bh=1YPYK7sayQjP+I10RuHiG39Itwo4QUIikFgJs5dJUOI=;
        h=From:To:Cc:Subject:Date:From;
        b=2PrJAg/iKyFWKxBi20P4UR09aSuBfQt9ME2YJM5ftl1/VlhNs/B1uxdPKPemfClG5
         XPBwm2ZMzjlRUxJuPWzkcTK8H6slmLEVrLc3jZ805+0oyQNMeWy8idjzWPWXTgwW+w
         0lU1BuCgUEj2rsSd2Fubef4LpZoBgPpQmJ7tNfxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: remove incorrect comment for device_create*
Date:   Sat,  1 Apr 2023 19:10:11 +0200
Message-Id: <2023040108-rust-railway-d20d@gregkh>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1486; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=1YPYK7sayQjP+I10RuHiG39Itwo4QUIikFgJs5dJUOI=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkaqQVMp4X7EhaIeW+9m3HWL9Los/HJokOvzirFOictc krMiFvYEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABM5G8Cw4KbVlCnJTA0vfaYY Pex0EPoqvcHPlWGeCTfD0nONO/1vTl6WaDTVKqlw//+PAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

