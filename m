Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27616666C07
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239678AbjALIDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239507AbjALICO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:02:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCB511146;
        Thu, 12 Jan 2023 00:01:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0C7F61F22;
        Thu, 12 Jan 2023 08:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCACEC433D2;
        Thu, 12 Jan 2023 08:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673510516;
        bh=d2bIAUOlHt7YYiWvk6LzbCqDofUm8lVXEtPYTafVHtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7bRuzCUVRrHbn+457VVpVSGV8kg2AAgYLhxg0lZ1wjRFbYOXcnwh70JZnwl50PP9
         QuDtytVkiWHDrK8BwiBQqKcOJEpCvBDIu5dfpQxa9AAywFpJSEwEkhRTu35K8D2u0n
         eA1AQx9d6p5PcOHzCU49AC0W4CTsttcfnxQRU+nUdjsxt/+WL5RRsdQ0WJmGP+iafR
         PR3RmYfe4jwzWu9WhDBk/VYBxkuFv+aiUashOOJzNamxYs/PE91Wp/vuktpKPPRUdv
         Kh2BRCZ25ZNJOppFvrTfllePGsOJXe60IRelR1jPnWt51mkdd5vckHpjjOXxMacGYX
         wfSbQ4NdQVpTQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     Kees Cook <keescook@chromium.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 11/11] tty: vt: cache row count in con_scroll()
Date:   Thu, 12 Jan 2023 09:01:36 +0100
Message-Id: <20230112080136.4929-11-jirislaby@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112080136.4929-1-jirislaby@kernel.org>
References: <20230112080136.4929-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's used on few places, so make the code easier to follow by caching
the subtraction result.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 165c81211bdc..671304b31f9f 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -561,10 +561,11 @@ static void con_scroll(struct vc_data *vc, unsigned int top,
 		       unsigned int bottom, enum con_scroll dir,
 		       unsigned int nr)
 {
+	unsigned int rows = bottom - top;
 	u16 *clear, *dst, *src;
 
 	if (top + nr >= bottom)
-		nr = bottom - top - 1;
+		nr = rows - 1;
 	if (bottom > vc->vc_rows || top >= bottom || nr < 1)
 		return;
 
@@ -577,10 +578,10 @@ static void con_scroll(struct vc_data *vc, unsigned int top,
 	dst = (u16 *)(vc->vc_origin + vc->vc_size_row * (top + nr));
 
 	if (dir == SM_UP) {
-		clear = src + (bottom - top - nr) * vc->vc_cols;
+		clear = src + (rows - nr) * vc->vc_cols;
 		swap(src, dst);
 	}
-	scr_memmovew(dst, src, (bottom - top - nr) * vc->vc_size_row);
+	scr_memmovew(dst, src, (rows - nr) * vc->vc_size_row);
 	scr_memsetw(clear, vc->vc_video_erase_char, vc->vc_size_row * nr);
 }
 
-- 
2.39.0

