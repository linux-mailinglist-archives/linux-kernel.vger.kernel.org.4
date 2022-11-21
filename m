Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC892631D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiKUJre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiKUJrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:47:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33093976E6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:47:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD7F260F97
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61B8C433D6;
        Mon, 21 Nov 2022 09:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669024030;
        bh=30OSs2VXvnYKk84voU7aoJfLuphQsYAap/NSihdjk6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L3y5fI3HnODyL+wLsSIb1i7+MEnGVHlZsmhr4OiTey5mwe991Zn2n6KsDGJpNhogK
         ccA172BTVUlOwweBc3fXn0xkd+aAaGVKT1FVLzApScVizIl/oDByDUiTuCd15BDLLV
         4rnYELby7QxByD+UfjHIOkOOMJ7lM3EMCifnW0zw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 4/5] kobject: kset_uevent_ops: make name() callback take a const *
Date:   Mon, 21 Nov 2022 10:46:48 +0100
Message-Id: <20221121094649.1556002-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121094649.1556002-1-gregkh@linuxfoundation.org>
References: <20221121094649.1556002-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521; i=gregkh@linuxfoundation.org; h=from:subject; bh=30OSs2VXvnYKk84voU7aoJfLuphQsYAap/NSihdjk6E=; b=owGbwMvMwCRo6H6F97bub03G02pJDMnVnpyXPxi/MRZvuzabt/V++LtVr9ZMt9tssfz+pA9rtxTZ aGdO7IhlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJXPRjmJ/LO7uTIyTy7IJ9HIuu7j dgKRF5V8awoMnUbPsVsU/9i1oDz6fdWG+SO3mBOQA=
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

The name() callback in struct kset_uevent_ops does not modify the
kobject passed into it, so make the pointer const to enforce this
restriction.  When doing so, fix up the single existing name() callback
to have the correct signature to preserve the build.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c     | 4 ++--
 include/linux/kobject.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 005a2b092f3e..a3e14143ec0c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2376,9 +2376,9 @@ static int dev_uevent_filter(const struct kobject *kobj)
 	return 0;
 }
 
-static const char *dev_uevent_name(struct kobject *kobj)
+static const char *dev_uevent_name(const struct kobject *kobj)
 {
-	struct device *dev = kobj_to_dev(kobj);
+	const struct device *dev = kobj_to_dev(kobj);
 
 	if (dev->bus)
 		return dev->bus->name;
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 640f59d4b3de..58a5b75612e3 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -136,7 +136,7 @@ struct kobj_uevent_env {
 
 struct kset_uevent_ops {
 	int (* const filter)(const struct kobject *kobj);
-	const char *(* const name)(struct kobject *kobj);
+	const char *(* const name)(const struct kobject *kobj);
 	int (* const uevent)(struct kobject *kobj, struct kobj_uevent_env *env);
 };
 
-- 
2.38.1

