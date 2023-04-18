Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FACC6E6648
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjDRNrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjDRNr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:47:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150AB125A7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:47:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90485634FE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A865C433D2;
        Tue, 18 Apr 2023 13:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681825643;
        bh=z6bziQOWX6ta9DQwSmPL8i4kjhV1G33KL8lW3/ZwuFI=;
        h=From:To:Cc:Subject:Date:From;
        b=Q6a4v5FL00efHxA4dSrTnY11Mr7uWQQ3zWozDGeBV/BMl0k/4g44m2DLZw4yLXZMF
         mBg7NOG36iinQwKs4FCgsvuvfwM/EwvI69DfxRJPrObEXitg+67yAmqb6n7MoRgehf
         E3k6KI5SqUhK+xaI88prLAG6jrVNj4qmqxE3cwhM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH] zram: fix up permission for the hot_add sysfs file
Date:   Tue, 18 Apr 2023 15:47:15 +0200
Message-Id: <2023041810-angelic-conical-52d8@gregkh>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Lines:  35
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=z6bziQOWX6ta9DQwSmPL8i4kjhV1G33KL8lW3/ZwuFI=; b=owGbwMvMwCRo6H6F97bub03G02pJDCl28+O8H6QZ/89wj/mgnlT27tnVL3zJXOxeNfdmGb6bu EiVrWN3RywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEzkqy/D/Irtk97nnzTa8MjI yijjfFjNJOab8xnmB8ea+jevmFpyd2eezbN958M1dzFKAwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 75a2d4226b53 ("driver core: class: mark the struct class for
sysfs callbacks as constant") changed the attribute to use
CLASS_ATTR_RO() which changed the permission from 0400 to 0444.  But
this atribute is "special" in that reading it modifies the system state,
so it MUST be set to 0400 so that only root processes can muck around
with it.

Fix this all up, AND document this so that I don't change it again in
3-4 years when I stumble across it and wonder why it's an open-coded
_ATTR() macro.

Reported-by: Denis Efremov <efremov@linux.com>
Fixes: 75a2d4226b53 ("driver core: class: mark the struct class for sysfs callbacks as constant")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/zram/zram_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 3feadfb96114..d8217529be6f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2438,7 +2438,9 @@ static ssize_t hot_add_show(const struct class *class,
 		return ret;
 	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
 }
-static CLASS_ATTR_RO(hot_add);
+/* This attribute must be set to 0400, so CLASS_ATTR_RO() can not be used */
+static struct class_attribute class_attr_hot_add =
+	__ATTR(hot_add, 0400, hot_add_show, NULL);
 
 static ssize_t hot_remove_store(const struct class *class,
 			const struct class_attribute *attr,
-- 
2.40.0

