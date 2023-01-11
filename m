Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1158665A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjAKLbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjAKLat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:30:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2855642B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:30:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A15061C04
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CCCC433D2;
        Wed, 11 Jan 2023 11:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673436647;
        bh=ZnUP4QqsUatI7olQqiZo7hbNKpfZIuTcCuvWGE33rjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TO0yaEmzH4zeTp1YVDBAZyhxfsCcf2e2bTgnQ2QV+u/2xqz7G2GsiLC0zvxTMgCnj
         IItOnihIk3K2u0+zhfapYRZ192mVzi1p3jgzOx3bKIcHQKUfH5FV/hN8Z2FwnPP5dD
         QEZCSMjx6w1shRPJAJ00pFAlg3hA00k/n1/O34z4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>
Subject: [PATCH v2 13/16] mcb: move to_mcb_device() to use container_of_const()
Date:   Wed, 11 Jan 2023 12:30:15 +0100
Message-Id: <20230111113018.459199-14-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111113018.459199-1-gregkh@linuxfoundation.org>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=gregkh@linuxfoundation.org; h=from:subject; bh=ZnUP4QqsUatI7olQqiZo7hbNKpfZIuTcCuvWGE33rjk=; b=owGbwMvMwCRo6H6F97bub03G02pJDMn75p4sm7DWzLCxvybA7MaZl/+0eOY4N9upnFp0Y9X/ClUG zZ6dHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRH3EMC852v7mysyylnIf928IGpV sSEes3tTAs2Knc+9R/0xXJiMRH4XeZTNXvSupuAAA=
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

The driver core is changing to pass some pointers as const, so move
to_mcb_device() to use container_of_const() to handle this change.

to_mcb_device() now properly keeps the const-ness of the pointer passed
into it, while as before it could be lost.

Cc: Johannes Thumshirn <morbidrsa@gmail.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mcb.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/mcb.h b/include/linux/mcb.h
index f6efb16f9d1b..1e5893138afe 100644
--- a/include/linux/mcb.h
+++ b/include/linux/mcb.h
@@ -76,10 +76,7 @@ struct mcb_device {
 	struct device *dma_dev;
 };
 
-static inline struct mcb_device *to_mcb_device(struct device *dev)
-{
-	return container_of(dev, struct mcb_device, dev);
-}
+#define to_mcb_device(__dev)	container_of_const(__dev, struct mcb_device, dev)
 
 /**
  * struct mcb_driver - MEN Chameleon Bus device driver
-- 
2.39.0

