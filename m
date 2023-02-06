Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB7468BE9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjBFNpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjBFNpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:45:00 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A798E1F4B7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h16so10377223wrz.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPRxk+XR4q6rcvb7Uhvae10cdYLboc87AwhU8wC3gnk=;
        b=ik4Hpyc3d7+1n8poSyS1lqyWPbx6SKuKX/QefYGcqIEMERtyVSAJ34C4EjWEvwXZr/
         iU/fgY8ufybzSGXSZmm77gomeSyVRG9RMKRJ8DS4TmJvKRNx2MtFjZSr1+22fjpUBZMn
         xC1nLxCXX862XsfQwkPGaEEM5uxcUXp1bb06WJqiMqZxPmCz75JT+xfX9gfSo7/B6aHa
         a4mv0aEBx53YYsQqGJ8Aw8rP6P5e0CuOCtHvFAW8Yajhx3cqwG4SfxNGl2YJt5ptGjRg
         GZ9snu0avF/Y5MliyLo079Z0gWnnVPt4bg8R6YcQEImDt0iuA9IXrxNLQx3V5Vbej228
         fcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPRxk+XR4q6rcvb7Uhvae10cdYLboc87AwhU8wC3gnk=;
        b=AgprSlti88ModC0+n2cWAQgMi/SmvkWAsdKjY2bYzkmVvOu0gu/tCOPacIBIMfoGfU
         /f9FRtpaVjGvwPz96LgggV9ldGCdBu+w4e9n733I7J4D45DfeZHFP1WhlHV7OkrxMxC2
         wnc8qTPCaz2HdbEoTC6AfEADCfZfzzb5udNqzG5NgKuzPVmlHFA62wGHQYWM+ivUVI/n
         6esRoUNWA/wkoTCbTueGi712jv8+h5SAy/jjIbZjtz53k1Ba3AbN1GyDKHU0Z2ifjJRj
         xnIUyWiQnbLkAzMySEloOdsmYtUMFyITXZ0zEPUb5loH8kDf8wqft/mU3Q//yrK6X0j0
         5Zsw==
X-Gm-Message-State: AO0yUKWUVgNuuG8OAwT+l2ooKUEMCbPYGNHTzallQsrqZ3NxJdLqom0N
        OUGnc7f5HSt4O851VaRPvD9MtQ==
X-Google-Smtp-Source: AK7set8NOXbV45AQNStf+I2RM8WMStxkgrt0xuD6+yidVm21bxZ5HAZF55ujEyi7taymRuJjKdaaxg==
X-Received: by 2002:a05:6000:1c15:b0:2bf:b27f:c9b3 with SMTP id ba21-20020a0560001c1500b002bfb27fc9b3mr19253418wrb.32.1675691071218;
        Mon, 06 Feb 2023 05:44:31 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:30 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v2 19/22] nvmem: rave-sp-eeprm: fix kernel-doc bad line warning
Date:   Mon,  6 Feb 2023 13:43:53 +0000
Message-Id: <20230206134356.839737-20-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
References: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
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

From: Randy Dunlap <rdunlap@infradead.org>

Convert an empty line to " *" to avoid a kernel-doc warning:

drivers/nvmem/rave-sp-eeprom.c:48: warning: bad line:

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/rave-sp-eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/rave-sp-eeprom.c b/drivers/nvmem/rave-sp-eeprom.c
index 66699d44f73d..c456011b75e8 100644
--- a/drivers/nvmem/rave-sp-eeprom.c
+++ b/drivers/nvmem/rave-sp-eeprom.c
@@ -45,7 +45,7 @@ enum rave_sp_eeprom_header_size {
  * @type:	Access type (see enum rave_sp_eeprom_access_type)
  * @success:	Success flag (Success = 1, Failure = 0)
  * @data:	Read data
-
+ *
  * Note this structure corresponds to RSP_*_EEPROM payload from RAVE
  * SP ICD
  */
-- 
2.25.1

