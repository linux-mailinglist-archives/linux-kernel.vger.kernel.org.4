Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15000729909
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjFIMHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjFIMHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:07:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A7A3C0E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:06:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B4B965546
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02017C4339B;
        Fri,  9 Jun 2023 12:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686312401;
        bh=v6bBhjvR3wb5+zDe6fFJL1e6WRgLNxjq+2oxyd8st6Y=;
        h=From:To:Cc:Subject:Date:From;
        b=IaDDEPyDGRKU6NlO05JDn9LoTa7zqe31QHE4N8cTjytfZ25KdBh/JCOYo8W+8JUTu
         XelJjbZ7Ga6yJNqnlvkdggngIhSm9Co77MKLYBNNFwpO/DHqv9hkauc3yaCMLxIlr5
         jnr+RXKU9nb2TX95kNMpk74Rq80n3ZKrZMfyYRa63hKFq0oGOJc9o3d5DG+trcxBzr
         wV2ugJk8lKARDu7M0r1DKF4j6dQTJgc5IIuWHkcO9KARo+n70IyJ6uyNZnv3Qk9khR
         XmRirtNoSFKEHL+sMhWkW/6JhW0zgJDGQ1w9vWib7rLSAl0KFIA5DZtcSVMJYvDTas
         f+ESmY7ADgARw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Oded Gabbay <ogabbay@kernel.org>, Tomer Tayar <ttayar@habana.ai>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ofir Bitton <obitton@habana.ai>,
        Ohad Sharabi <osharabi@habana.ai>,
        Dafna Hirschfeld <dhirschfeld@habana.ai>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] accel/habanalabs: add more debugfs stub helpers
Date:   Fri,  9 Jun 2023 14:06:32 +0200
Message-Id: <20230609120636.3969045-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Two functions got added with normal prototypes for debugfs, but not
alternative when building without it:

drivers/accel/habanalabs/common/device.c: In function 'hl_device_init':
drivers/accel/habanalabs/common/device.c:2177:14: error: implicit declaration of function 'hl_debugfs_device_init'; did you mean 'hl_debugfs_init'? [-Werror=implicit-function-declaration]
drivers/accel/habanalabs/common/device.c:2305:9: error: implicit declaration of function 'hl_debugfs_device_fini'; did you mean 'hl_debugfs_remove_file'? [-Werror=implicit-function-declaration]

Add stubs for these as well.

Fixes: 553311fc7b76e ("accel/habanalabs: expose debugfs files later")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/accel/habanalabs/common/habanalabs.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index d92ba2e30e310..2f027d5a82064 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -3980,6 +3980,15 @@ static inline void hl_debugfs_fini(void)
 {
 }
 
+static inline int hl_debugfs_device_init(struct hl_device *hdev)
+{
+	return 0;
+}
+
+static inline void hl_debugfs_device_fini(struct hl_device *hdev)
+{
+}
+
 static inline void hl_debugfs_add_device(struct hl_device *hdev)
 {
 }
-- 
2.39.2

