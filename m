Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C848D6D6A70
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbjDDRXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbjDDRXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB8B55AB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t10so133434102edd.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDzlzqq+yvKoEoeTAB2VQWwWQLTQznBO+pgzOwe70fc=;
        b=B/CB770D9L/cAHGEwv3PmEI5TyI61G9IQece3sPOe13q9W1pX8wojtfvWJlJgz0REz
         4edHxrvh2vbHKQy9ShGk7Ruo1V/wW1hcZbW/Oy5Raf4ZWZs1MaE/44WEILx2rmcuHPhg
         XD7yo5gPAarcq97z6Ode0kYlFkQzeAMKYX4/a+DnyhxkX/wjE61MlqahWU8qKPuiPCvf
         rjB9ObD7K6rFw+XKbSm+m0jM8edukYblFvZrEA3uDpvxQ5yu84rgHG4EcLbA7/ASd7d6
         CGHcXAIJKm+3D5YB7Le6/kzSVuYIBy1YILWuUSTMVcp2JkuY4JC0Ng78OF2CRv3y4+oB
         qlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDzlzqq+yvKoEoeTAB2VQWwWQLTQznBO+pgzOwe70fc=;
        b=cnJDgGOcvs918ptatMajvWhL3OLEet0WSzDaoZvgTuPf1AOzPECTt5KX5rNhcgpcGI
         kb1V3QVgMXPi+zcg20eOcRFedMEJf2AzTVE3ehL5u4aMgoWaZi32Q43/9knjdlopSXoN
         88MfKQao4aT1QKjAb8hNwBNayUs6FPPi6iNfqu/V+LO0B1czBH3RjY9OhAnzoYu3dEF8
         /UiY26B8zUmM1GzOhmzVXeVFsO3vvoqkqiXfZir7kVWXrfAE+cByFt9xQJx6/4XBh65/
         gPIXWiVvD82tLubwy0MLuEws+W4KgNFWkx2jJrl/mJnNR10UH38wYEyjKL+fNqQUjjDX
         kgfg==
X-Gm-Message-State: AAQBX9f7ITyGYU/TUfNRVLmv69V0nrb5p/PZ/uOsm6vTA/yShnnNzN2d
        SNEb2sa8B2HceqeGqPS8dCcppe9D/5OlKu6VoHg=
X-Google-Smtp-Source: AKy350b9WhU4QktBSymlXajGmk+RPNQtB2EPRRsqZZ8Dphrb0j7lNFWBCjqo7sxAiwWISWv4Ihw0iw==
X-Received: by 2002:a17:906:ae9a:b0:932:40f4:5c49 with SMTP id md26-20020a170906ae9a00b0093240f45c49mr318576ejb.67.1680628963071;
        Tue, 04 Apr 2023 10:22:43 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:42 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 15/40] nvmem: core: request layout modules loading
Date:   Tue,  4 Apr 2023 18:21:23 +0100
Message-Id: <20230404172148.82422-16-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

When a storage device like an eeprom or an mtd device probes, it
registers an nvmem device if the nvmem subsystem has been enabled (bool
symbol). During nvmem registration, if the device is using layouts to
expose dynamic nvmem cells, the core will first try to get a reference
over the layout driver callbacks. In practice there is not relationship
that can be described between the storage driver and the nvmem
layout. So there is no way we can enforce both drivers will be built-in
or both will be modules. If the storage device driver is built-in but
the layout is built as a module, instead of badly failing with an
endless probe deferral loop, lets just make a modprobe call in case the
driver was made available in an initramfs with
of_device_node_request_module(), and offer a fully functional system to
the user.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 51fd792b8d70..49b4bbaf59e8 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -17,6 +17,7 @@
 #include <linux/nvmem-provider.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 
 struct nvmem_device {
@@ -761,6 +762,13 @@ static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
 	if (!layout_np)
 		return NULL;
 
+	/*
+	 * In case the nvmem device was built-in while the layout was built as a
+	 * module, we shall manually request the layout driver loading otherwise
+	 * we'll never have any match.
+	 */
+	of_request_module(layout_np);
+
 	spin_lock(&nvmem_layout_lock);
 
 	list_for_each_entry(l, &nvmem_layouts, node) {
-- 
2.25.1

