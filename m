Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951846DC147
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 22:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDIUFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 16:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIUFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 16:05:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E275335B6;
        Sun,  9 Apr 2023 13:05:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l26-20020a05600c1d1a00b003edd24054e0so3357835wms.4;
        Sun, 09 Apr 2023 13:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681070719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngtqh6lY40sQa87FOJ7Q2UWB/nz6Pl08B/HLHoV4Hq0=;
        b=Xgf0dDYycuvGmqNiN2WXKEJtkoCH1kC7TyOUemxXG/tjLD+H5Y2RsKUuLQuobjFb18
         UqG2mGJb2xLrGlCxYFBRPQjOFDGR1ro46SD3osB1sT9dmfCBTgC6/FBJc2gBfMrvLqQX
         tB1HB93NwC/N17g3lUGSz0jZW3Qy5h8+nmlB1QmmaKVd1oF/iIus4aUMOpeuuxko6pmL
         Ul9sCDbAXTae8je+LQr9CnJk14+yeGfQlVLdpXbToSGJgQrVhvv7oibH37vbP9TG0cEL
         YvZscBXqppQFrYHjzJWdcgiAYrAFl4FG1TfSSYB6460xvwUgb4wG8OfXgSXFCLyZgNs9
         S6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681070719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ngtqh6lY40sQa87FOJ7Q2UWB/nz6Pl08B/HLHoV4Hq0=;
        b=U92wfzx7ukUnzWI4uc18WOJt/SCHNnomDC3jhIGiGm/HNtkBUyrqoyvL1XyRWy2JF6
         cpRhaqV/6SvQ/Nl8nEpovx7+vf7oIL4cQ/Xfej/Mkw34pBHAwJMAN9NtGR8GrYvuNBFw
         viE03l+dklWdyx7NaKSKf7EkZ2NEhorIbyM8VFB1EUnBJAI/5SCoExt0WwDTy4RoQNk2
         NLtf84+2VzwgUAwFfO+N5KYFnaQCoMes3YtHJlN3qB2l1LfTmSnsiRoFK+ipH4qbFr3C
         FgtES9hCpWjYqFYHrEVMetJAomVr4k8TIIyRKMXPfrOJFh5HEk5vdK38Ir6mUW+LYZBy
         feGw==
X-Gm-Message-State: AAQBX9cZq0/zkSqjvpaqQAg/gPvTZ1TDYZxbSDMwNRNYPm0q2UiE2nak
        ajJzyAKgafRCc+ap7WjAlzQ=
X-Google-Smtp-Source: AKy350aOz9m2VO8vtaf6WmEDkfzKOZGRq9rYc5QamRJ7rCyeFNgRJMSwNWs11M97CF5BWn2A0mFDRg==
X-Received: by 2002:a05:600c:2048:b0:3ef:8b0:dbb1 with SMTP id p8-20020a05600c204800b003ef08b0dbb1mr3473794wmg.7.1681070718740;
        Sun, 09 Apr 2023 13:05:18 -0700 (PDT)
Received: from arch.localdomain ([2a0c:5a82:e704:7800:4aa3:3ca0:c843:43e3])
        by smtp.googlemail.com with ESMTPSA id b5-20020adfee85000000b002c557f82e27sm9846711wro.99.2023.04.09.13.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 13:05:18 -0700 (PDT)
From:   Angel Alberto Carretero <angelalbertoc.r@gmail.com>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Angel Alberto Carretero <angelalbertoc.r@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: imx: fix macro style error
Date:   Sun,  9 Apr 2023 22:01:36 +0200
Message-Id: <20230409200135.1033677-1-angelalbertoc.r@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap macro in parenthesis to fix checkpatch error.

Tested it by compiling the driver successfully.

Signed-off-by: Angel Alberto Carretero <angelalbertoc.r@gmail.com>
---
 drivers/staging/media/imx/imx-media-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
index 411e907b68eb..eb44c09071de 100644
--- a/drivers/staging/media/imx/imx-media-utils.c
+++ b/drivers/staging/media/imx/imx-media-utils.c
@@ -7,7 +7,7 @@
 #include <linux/module.h>
 #include "imx-media.h"
 
-#define IMX_BUS_FMTS(fmt...) (const u32[]) {fmt, 0}
+#define IMX_BUS_FMTS(fmt...) ((const u32[]) {fmt, 0})
 
 /*
  * List of supported pixel formats for the subdevs.
-- 
2.40.0

