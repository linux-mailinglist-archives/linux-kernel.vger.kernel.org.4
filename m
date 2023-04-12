Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74096DFCFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjDLRvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjDLRvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:51:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C75359E2;
        Wed, 12 Apr 2023 10:51:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id he13so12068355wmb.2;
        Wed, 12 Apr 2023 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681321896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjAgg+1rXP/ibl8SV/Shge5MrmdpY6vrV27SsO06MJQ=;
        b=NRi333288ZygCOmiAdCNJosEPjp914KSfy4zw6TQ3mpCB2NW2Oc7MLkDl8u+fxJ2F+
         lBgeTJ6H3PlMjRFGgQ7EWGxUGtJ5zd+9Q8jcFRgo2oly7eOp0UDea1KLH8wwJtrHufMT
         yOEw/VYQlWjWE5Hvjux8cq/wMUKuWlP47MVE6XZ68LzlAL0k2wvWT5a0p4NO7shZ12S3
         eWFWqYwWrF/t6EV46O22tHBrWYUXROl6BmhjQbyE0xrbHQHahqyjrhCgqD9sNntTcD5F
         6Eum7Qg/RBPgxE59ARg7HrC3/2XVqKILrev6CHuHrWMkk5O9oU3OQr1qsXbGe3cIV8ep
         FYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681321896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjAgg+1rXP/ibl8SV/Shge5MrmdpY6vrV27SsO06MJQ=;
        b=ghu8N0eee7uSgBSIOwT6GiFk5eTNrT79nTkroGi6N573zPRVrrlpy3zj31/aOaVbNR
         AjqdoOHhWP+yWiY+/AMMDlo6vajAyGEyHJ3+077uxamOIst8X1WftdNN/lNSs4Q4TdeM
         zjnK0Z3Nzmnc9WlcC29LS8eE/WVYhx6J0A1rBAVbpKJKAAmNHCd5HTdVe8de6iY8mdIx
         LVuJpjpDjlUvz4nyr0mii/ehx0Qi8LrDcO0kqfDsrxQjfZ0GOMMnHGvmuGQ2WYex1HpY
         kRY6n4zwKZ6v4DptiNInYxK79JMTemfkJw/YAlgI2J7EMTzKGbiANJZ7b0Gy4wfpTGj/
         UiCA==
X-Gm-Message-State: AAQBX9efBQj/c4uuc3byM+QikzgYEdS7VP71xcceIQ/uLrM9iwLff4uS
        Yad+7zgfwPjvzqdMRVlIKh8=
X-Google-Smtp-Source: AKy350aAdus6rK7PINuCvPZWM6juWt+b37hP4pj28oYO6b0OU/bUNn3+Jc4vYAMOYLhaHLJsJGvrBw==
X-Received: by 2002:a05:600c:378a:b0:3ee:b3bf:5f7c with SMTP id o10-20020a05600c378a00b003eeb3bf5f7cmr12625430wmr.23.1681321895701;
        Wed, 12 Apr 2023 10:51:35 -0700 (PDT)
Received: from arch.localdomain ([2a0c:5a82:e704:7800:4aa3:3ca0:c843:43e3])
        by smtp.googlemail.com with ESMTPSA id v13-20020a05600c214d00b003edf2dc7ca3sm3056020wml.34.2023.04.12.10.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 10:51:35 -0700 (PDT)
From:   Angel Alberto Carretero <angelalbertoc.r@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
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
Subject: [PATCH v2] media: imx: utils: Enclose IMX_BUS_FMTS macro in parenthesis
Date:   Wed, 12 Apr 2023 19:51:01 +0200
Message-Id: <20230412175101.8746-1-angelalbertoc.r@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <ZDSgWU5GXPFdJ99o@aschofie-mobl2>
References: <ZDSgWU5GXPFdJ99o@aschofie-mobl2>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conform to kernel coding style by wrapping macro in parenthesis. Issue
found by checkpatch.

Signed-off-by: Angel Alberto Carretero <angelalbertoc.r@gmail.com>
---
v2: changed commit message and description thanks to Alison suggestion
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

