Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E126465CC3D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 04:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjADD6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 22:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjADD57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 22:57:59 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DE415725
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 19:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672804662; bh=g68WjsKLgm0BGTYxv3eXQb4GtGzcoRHUdOjEJjW3wxY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=mhmZWRg7q9RRn1gaJqCAY8aA9wv7j52nQH+wxTIS3sijktduushce/wrRS2V2pS8d
         fDt+TJ2PCt4MRbhjE3a5XsNSTWUPxkvi7xJ/v9vhUF+pCZHEklAiE/+uKf/TNTBaZg
         Gw5kxjUfHUQdURs8gEz0XTDKWko6/iP1MWGyfnZs=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed,  4 Jan 2023 04:57:42 +0100 (CET)
X-EA-Auth: X/DPdo8+pBhmvVri8YvZq0puHGhoKFIrcwsvZGLQWmFtOckUnZf5FYyOYxYO9PtuPY2gUj2VwJjiahd9mMMg+B4hq+B0mD0m
Date:   Wed, 4 Jan 2023 09:27:37 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] staging: greybus: Replace zero-length array by
 DECLARE_FLEX_ARRAY() helper
Message-ID: <Y7T5MYfANf2xVsEx@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code currently uses C90 standard extension based zero length array
struct which is now deprecated and the new C99 standard extension of
flexible array declarations are to be used instead. Also, the macro
DECLARE_FLEX_ARRAY() allows to use single flexible array member in a
structure. Refer to these links [1], [2] for details.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://lkml.kernel.org/r/YxKY6O2hmdwNh8r8@work

Issue identified using Coccinelle flexible_array.cocci semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/greybus/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/usb.c b/drivers/staging/greybus/usb.c
index 8e9d9d59a357..b7badf87a3f0 100644
--- a/drivers/staging/greybus/usb.c
+++ b/drivers/staging/greybus/usb.c
@@ -27,7 +27,7 @@ struct gb_usb_hub_control_request {
 };

 struct gb_usb_hub_control_response {
-	u8 buf[0];
+	DECLARE_FLEX_ARRAY(u8, buf);
 };

 struct gb_usb_device {
--
2.34.1



