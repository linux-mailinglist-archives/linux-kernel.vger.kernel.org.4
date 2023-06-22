Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6024F73A659
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjFVQpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjFVQpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:45:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668F21FCC;
        Thu, 22 Jun 2023 09:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F00F0618B0;
        Thu, 22 Jun 2023 16:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C70C433C0;
        Thu, 22 Jun 2023 16:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687452338;
        bh=mPXln+DmOt1KklaFQd3MJkA1//mD28lDoq4prtu8Qoo=;
        h=Date:From:To:Cc:Subject:From;
        b=RVvLNYYIvAmGiq4BaiJ+/c8othvgt+IMGlJMhdFQy9LZVYJ2Xh3k64zYSQloMZJxq
         rQUpRTSch8lojQ25h/Zkqy36qoY2/cYl0Fe5skuKVC8TNUW4Bzdhv3qgCosnUssb4L
         AmrPOEMU57ueZ/pSZr8IBXKKv+rYNEx55PnTrKLtV+eihP/7kntUs/EF9RzRL5/Mv3
         Srf/2XvnQa8LObzVYlGc1ZQYan5qonEfQc7KNytrYp5PiFRZy0Z6LMmI1PbguFJpXm
         HpaTe9Kwwuo757fSU8ESd7Xlu+L93xv+Bh1KEmOc/7eCSt3RgcemqSqPGx0ppW+/J5
         expgtpPfn9WuQ==
Date:   Thu, 22 Jun 2023 10:46:33 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] fbdev: sh7760fb: Fix -Wimplicit-fallthrough warnings
Message-ID: <ZJR66f3UY0UFZJ01@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following fallthrough warnings seen after building sh
architecture with sh7763rdp_defconfig configuration:

drivers/video/fbdev/sh7760fb.c: In function 'sh7760fb_get_color_info':
drivers/video/fbdev/sh7760fb.c:138:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
  138 |                 lgray = 1;
      |                 ~~~~~~^~~
drivers/video/fbdev/sh7760fb.c:139:9: note: here
  139 |         case LDDFR_4BPP:
      |         ^~~~
drivers/video/fbdev/sh7760fb.c:143:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
  143 |                 lgray = 1;
      |                 ~~~~~~^~~
drivers/video/fbdev/sh7760fb.c:144:9: note: here
  144 |         case LDDFR_8BPP:
      |         ^~~~

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/video/fbdev/sh7760fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/sh7760fb.c b/drivers/video/fbdev/sh7760fb.c
index 768011bdb430..98c5227098a8 100644
--- a/drivers/video/fbdev/sh7760fb.c
+++ b/drivers/video/fbdev/sh7760fb.c
@@ -136,11 +136,13 @@ static int sh7760fb_get_color_info(struct device *dev,
 		break;
 	case LDDFR_4BPP_MONO:
 		lgray = 1;
+		fallthrough;
 	case LDDFR_4BPP:
 		lbpp = 4;
 		break;
 	case LDDFR_6BPP_MONO:
 		lgray = 1;
+		fallthrough;
 	case LDDFR_8BPP:
 		lbpp = 8;
 		break;
-- 
2.34.1

