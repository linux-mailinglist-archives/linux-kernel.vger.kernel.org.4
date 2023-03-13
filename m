Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3876B80B3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjCMScU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjCMSbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:31:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6567584F40
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D25DB811E9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45B6C43445;
        Mon, 13 Mar 2023 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732233;
        bh=nZpR9Ls6zoTSW4yfmOuFttWaTg8gO18NtXJ/5900W0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2d6OlmXwiE7eG1cSclXl4V9sMyC2/B88Wz9jwa8Sho6TMwReKrdsR2AkXn81RGt77
         UJzonx9EenISs2acjdJTbRYX0wf1JqBMcTNCycnvQx3Dy33OHa2ycGlJvvkOwP5GMq
         LpUhug8VRvcvp/fnejZXDRuyoXNIMGWY5kosfJnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 35/36] driver core: device.h: make struct bus_type a const *
Date:   Mon, 13 Mar 2023 19:29:17 +0100
Message-Id: <20230313182918.1312597-35-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=gregkh@linuxfoundation.org; h=from:subject; bh=nZpR9Ls6zoTSW4yfmOuFttWaTg8gO18NtXJ/5900W0A=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82bUXCiYGxZzQmXc3/spR+z8XHs/LvCiXHbJpqcUJ2 Qt/v1Q+6IhlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJhMsxzJX0WH748PWzHw1m N/Zn2/V3HD0Qa8iw4ESyzduZngI+xzZvzlH5u1m47+q+KQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all users who accessed the bus_type structure in struct device
are properly using it as a const *, mark it as such so that no one can
modify it going forward anymore.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 0f128520f6e5..9a8573409685 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -564,7 +564,7 @@ struct device {
 	const char		*init_name; /* initial name of the device */
 	const struct device_type *type;
 
-	struct bus_type	*bus;		/* type of bus device is on */
+	const struct bus_type	*bus;	/* type of bus device is on */
 	struct device_driver *driver;	/* which driver has allocated this
 					   device */
 	void		*platform_data;	/* Platform specific data, device
-- 
2.39.2

