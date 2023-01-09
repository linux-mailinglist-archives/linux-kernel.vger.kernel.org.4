Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504FA662DEA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbjAISBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbjAIR74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:59:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB2C1C137
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:58:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0616CB80EA0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 17:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFB8C433EF;
        Mon,  9 Jan 2023 17:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673287105;
        bh=mQLTJRqT/W3QXshJIyUjLyzN/YJlmLDA7t9kmh+7naY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=imb+ICaZPnGfj7UG+jh4REcOfaGz5taQM8/Nz0NqNrQ9uAz9hk1wvwnq+j2JfAACY
         FbcuBNtojNDDUw9CrVWbnTnw9mpa4rz2J7hpM3giEH3ksXTo4rEtrHHzSYfHLZpqyj
         OoUGxEKf7Ix8FrCGpNvTjlnpzntIuE2c7IIyRD/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 4/6] driver core: make subsys_dev_iter_next() static
Date:   Mon,  9 Jan 2023 18:58:08 +0100
Message-Id: <20230109175810.2965448-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109175810.2965448-1-gregkh@linuxfoundation.org>
References: <20230109175810.2965448-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654; i=gregkh@linuxfoundation.org; h=from:subject; bh=mQLTJRqT/W3QXshJIyUjLyzN/YJlmLDA7t9kmh+7naY=; b=owGbwMvMwCRo6H6F97bub03G02pJDMl7QjfypEvIC3hyr+xmXyneuUjftF84RX53BFfqTutaTqWW p5s6YlkYBJkYZMUUWb5s4zm6v+KQopeh7WmYOaxMIEMYuDgFYCKyZgxzZXyn/FVRtH4oFvP+eFJoiU avVj8bw4Jzwmu61gWalb8IrRYUDdxa/samZxcA
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

The function subsys_dev_iter_next() is only used in drivers/base/bus.c
so make it static to that file and remove the global export.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c         | 3 +--
 include/linux/device/bus.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index a375305a11dd..4be73f58d0ad 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -976,7 +976,7 @@ static void subsys_dev_iter_init(struct subsys_dev_iter *iter, struct bus_type *
  * free to do whatever it wants to do with the device including
  * calling back into subsys code.
  */
-struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter)
+static struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter)
 {
 	struct klist_node *knode;
 	struct device *dev;
@@ -990,7 +990,6 @@ struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter)
 			return dev;
 	}
 }
-EXPORT_SYMBOL_GPL(subsys_dev_iter_next);
 
 /**
  * subsys_dev_iter_exit - finish iteration
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index a1da2f8647af..5a7590bc7913 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -154,7 +154,6 @@ struct subsys_dev_iter {
 	struct klist_iter		ki;
 	const struct device_type	*type;
 };
-struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter);
 void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
 
 int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
-- 
2.39.0

