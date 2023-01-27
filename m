Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D8267E1F7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjA0KlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjA0Kkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:40:41 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BB31F907
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:40:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bk16so4546584wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8G3RE+j+dO/dQrvTZDNE7AoRlUJelk3u0v90aEJQXY=;
        b=UdjOVq3P2mbBurpQdtJKye1U57rcIDFK7XwqD+hYVZhXesiUMf+AT0L7WbrC8If9p6
         AO9W+wxlSRxPPbUYBizbe7vEwg5jEENu9XvDLSS4P0frN/p0MXMIcLGEOZm9dT4tWz/U
         5DUaa2jdMjZmCwlfc2amRXUquiH+myAkL6rjX6eILZD1Y8VpF4HsWZc2AzUVurY/rMQG
         wYpUUMyvqRp9xYSTAnWvKqgMwcrmLqxKxvF35mZBCEdTC4Rdc8iGcH3xOd+uMwtiUp/q
         lhGLbSWWO/pEtH+J0i9m3Y+IYQ6oV9x1qT7Ae5QGQyMRU2GPWUUXJMTsQyQiXL1S2NWR
         qBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8G3RE+j+dO/dQrvTZDNE7AoRlUJelk3u0v90aEJQXY=;
        b=aLNWB+fvWUWzhIoqWRyT7iIZKyPR3atykUwJwO1ew7bgTCY4Jl3wAmvwr1WjLDSH4S
         1odWTs7cF/J3TwjsAeuD4rB6/CeDuN6r6XZEH2ES/pBng0pl/sZ1DZUvSTFqax54u+O/
         zMah+DtJUSKJ5jIGbrCmTxTHj6AnVhWSTorF/KLoFfgz1+xoYh7a342zGin7EPQrNTei
         L5nNm1JKtOcb0rNKS4WWwkuqpexttkdpT8B8yjJIJO+Ls1kONy0iybTZ+W1f2RDkGiOx
         5YFcy3OmRlPb80y3tkbjyyqT8MfIY73GtyWBj1+MUKYkunr4ICV/OGsYbg2PxgJS8Fv/
         BAGQ==
X-Gm-Message-State: AO0yUKVlNw0LkHZhcgQXfB9XL6HfLdTkfzkExR6ot9m6wrEkmAB9Cmmw
        QKFvRbNhKipewGEy1Cxzs4I6YY3lkKP9lxEU
X-Google-Smtp-Source: AK7set9uxMkIajlaN8z4Te9EETm0aXqDqUtlHpQBrX2xJc3WrExYC3rY6Jg9atEszh31/n7vSdZtnw==
X-Received: by 2002:adf:d23c:0:b0:2bf:cfbc:2f15 with SMTP id k28-20020adfd23c000000b002bfcfbc2f15mr2674461wrh.30.1674816032805;
        Fri, 27 Jan 2023 02:40:32 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003dc34edacf8sm1619787wmc.31.2023.01.27.02.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:40:32 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/10] nvmem: core: fix cell removal on error
Date:   Fri, 27 Jan 2023 10:40:13 +0000
Message-Id: <20230127104015.23839-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127104015.23839-1-srinivas.kandagatla@linaro.org>
References: <20230127104015.23839-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

nvmem_add_cells() could return an error after some cells are already
added to the provider. In this case, the added cells are not removed.
Remove any registered cells if nvmem_add_cells() fails.

Cc: stable@vger.kernel.org
Fixes: fa72d847d68d7 ("nvmem: check the return value of nvmem_add_cells()")
Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index cbe5df99db82..563116405b3d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -847,7 +847,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (config->cells) {
 		rval = nvmem_add_cells(nvmem, config->cells, config->ncells);
 		if (rval)
-			goto err_teardown_compat;
+			goto err_remove_cells;
 	}
 
 	rval = nvmem_add_cells_from_table(nvmem);
@@ -870,7 +870,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 err_remove_cells:
 	nvmem_device_remove_all_cells(nvmem);
-err_teardown_compat:
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
 err_put_device:
-- 
2.25.1

