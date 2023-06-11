Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD3472B226
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjFKODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFKODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:03:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807C0E7A
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f7ebb2b82cso35883685e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492224; x=1689084224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfD9z3doIWc1jROuRPtnKsZDZxUKF4oVXT2gOudcnaU=;
        b=V5D/kHDmtRkrv3f8gHnkc2ywcBJ2XuOZ77qgIUQgOLJ0XfCgP3yDapAJGO5lKXQHeJ
         Nu7xeapGi87T+JNdZI8Yq8qBYEn8pA25+e8hRsAaema0LTnV2FbAm6dxxodLGiUCjOXU
         PobDuLUQCHok3/UzKV5XYRQZD7QuUIyM4In4unnIpEK5EesI1EMap9lOr8mDcUqLBv03
         lzXCBWoCntQzo48p01W/Gz2o62W9T+4xYb7lbkXyi1+ex9u7Qk+PmYzOtL180axI/3xC
         Jk/4WewopenduU/nYr2vIAUoXYNB3opw0rlsVxswxj0wLj4gzeoXffRjkIAFsS1T+wrN
         2Ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492224; x=1689084224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfD9z3doIWc1jROuRPtnKsZDZxUKF4oVXT2gOudcnaU=;
        b=cP2ItEq91vOsm6JKHc7QHnRGI2LKXIv5dlQYTva21YXQqWPYjPa2HIFY9eS85h62WU
         FeXq/ieEnO5iJFFydPdWTlhpGBexYz+QuelvutHZVcTMD2eLa47Wd60NRj4EBt8gWT76
         nip/xPXiyyzCfIOqhhMA96in+DFuY1aI2EpO5VdMZPNNwZ6X39i7fHx1Hiq02WsiEGTG
         Q5nm5YhRq/AadPwK4znZAZWIN9Yy4E8yHPTfduX5LjGwdtkVQjh8Gc8CrhTDxDi8Mr72
         3BndX+yH4lrvbAnURzSHqffiH7OG3WDZvFm01QGSzGiqlabcxOhL9leDvbY0t9WWnYvk
         +y1A==
X-Gm-Message-State: AC+VfDzHrtdagwkSckDcFdwYcWQ/bgG/qJq+pJYWQbFsX8Y4kQguTuJ0
        0IqMSZySR1i30Apz6DyX35maKk2hCZ33wnAS5AY=
X-Google-Smtp-Source: ACHHUZ4bHTgvB6/YK87qBuRHO9ri6Ns+OXjZfUF/vpd7HPS8xq4FmeyARUN89Ix8RQ+WpVRtjYb2aw==
X-Received: by 2002:a1c:7909:0:b0:3f8:a15:b516 with SMTP id l9-20020a1c7909000000b003f80a15b516mr4582237wme.7.1686492223790;
        Sun, 11 Jun 2023 07:03:43 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:03:42 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/26] nvmem: imx-ocotp: set varaiable imx_ocotp_layout storage-class-specifier to static
Date:   Sun, 11 Jun 2023 15:03:05 +0100
Message-Id: <20230611140330.154222-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

smatch reports
drivers/nvmem/imx-ocotp.c:599:21: warning: symbol
  'imx_ocotp_layout' was not declared. Should it be static?

This variable is only used in one file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index ac0edb6398f1..fcea9c04be96 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -596,7 +596,7 @@ static void imx_ocotp_fixup_cell_info(struct nvmem_device *nvmem,
 	cell->read_post_process = imx_ocotp_cell_pp;
 }
 
-struct nvmem_layout imx_ocotp_layout = {
+static struct nvmem_layout imx_ocotp_layout = {
 	.fixup_cell_info = imx_ocotp_fixup_cell_info,
 };
 
-- 
2.25.1

