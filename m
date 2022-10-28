Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D91E6112C4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiJ1Nak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiJ1Na2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:30:28 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FC5481C6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666963811; bh=yl2gtCFcrA+y8ipJCReQCBstnVYp6kw9Oo6TOGLDu48=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=naGIr9mbGwyhwpjYrv2t87fqffgj1mwZ+5/C4r80b/7MimJ/diBBIj6EkUnpiJmEJ
         SqFheASo9qXA6Udz4amUxh6XyhqOT0H4SoiBLAbW+ORLUkVGTuQqpHpcnLaVc1hHx8
         6huRGOoIvDEfZVfgB1N24jlGlvzir8u96F1Kjaf0=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.206]
        Fri, 28 Oct 2022 15:30:11 +0200 (CEST)
X-EA-Auth: DIZOiORP0IjVZ8/XwaxKMK586tsbAVcXFYeycjJhdSHO7JpUY2oJpHSxW2jTyOzoxV7UlsyKto2JDACDDTO8hWRBMP/V0mK3
Date:   Fri, 28 Oct 2022 19:00:05 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: Use ARRAY_SIZE() to get argument count
Message-ID: <Y1vZXUi0Bjiub8HZ@ubunlion>
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

The ARRAY_SIZE(foo) macro should be preferred over sizeof operator
based computation such as sizeof(foo)/sizeof(foo[0]) for finding
number of elements in an array. Issue identified using coccicheck.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/fbtft/fbtft.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 2c2b5f1c1df3..5506a473be91 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -231,7 +231,7 @@ struct fbtft_par {
 	bool polarity;
 };

-#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
+#define NUMARGS(...)  ARRAY_SIZE(((int[]){ __VA_ARGS__ }))

 #define write_reg(par, ...)                                            \
 	((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
--
2.34.1



