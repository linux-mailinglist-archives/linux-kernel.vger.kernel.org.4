Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85885F1E3E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 19:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJARLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 13:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiJARLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 13:11:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883B65A3E1
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 10:11:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k3-20020a05600c1c8300b003b4fa1a85f8so3704700wms.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 10:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KyEHZH41+VDH9bxxt3p+dgtz1T9wbtc1HGrXs5RGSsY=;
        b=DoDARNqoL7+Q63BrbqhTfjnWZYx3qIWl8quEhAIddkb33lWwgDOGMHzs83j78geKio
         hEJahX3TB2WJwUxSD5zjFc3JmSRKhKb3v0j29HDahGu6HEreLmWvg53+X4uElH0AvU3f
         Q8wIOMB9XTGyeB8kZ6zfvpgNsXZnfl8yFfglHExHttiduFxgf68vZAJzhbgrjG6r/+D8
         PNsTUc09JCPJTMahqYyzShcWYOpyo+2QLDGg2TMuIzcMuIXHcB0x05h/4X/7IfjE7dTn
         MsbgDe1TR79H+/MZ21Qs1SJqomC5RfwaiS3j+wjinPqUYOCiUZ6UThWIRMol2bAZROcn
         dMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KyEHZH41+VDH9bxxt3p+dgtz1T9wbtc1HGrXs5RGSsY=;
        b=GK3pChs0K5pIP0cvoV+W4BsfVaedkO7eYYemW6lL2VKHflqvfRxU2tnjc49sgKBnB2
         hpt0F8PSvv/GmhMoxp4CkpnSCKKve/933HvwA7H7nhef9gtHQxjLJHmAbo+D5rBSwOsy
         fNqIEoUjZpX3Jm8XSR4afQn2VbQXG6IYuJaTjyTNalRBpnFkpApH04hqEz9T0eTWpKSW
         XJHh1c+CrIH+0b5bBnUBkRZuT+Fe/ii67naGQZFBNE/sTC7m4o7Ct9WYJ2tuhkb9odey
         9NtVebMKmF3dK/mXjrAfTkVaV8Fw295phz/Av/8KWEyMS9uHbd3igO7YZ/oaPDdkOHtS
         +Cmg==
X-Gm-Message-State: ACrzQf1lInXlDLPcILp3WCEvXf4BCmRzRfhxk+cWq56bMAfyy1liqmLw
        3MY41R8xJc6lVMn0Qss3t9SxzQ==
X-Google-Smtp-Source: AMsMyM5tt70mEqXeE2WtfEki09ee7rn3yDJD/EYzSGYsbMj0yZQymyg/P+IRhjzNe57uaeBW7ovJ5g==
X-Received: by 2002:a05:600c:3511:b0:3b4:bb85:f1e3 with SMTP id h17-20020a05600c351100b003b4bb85f1e3mr2254005wmq.0.1664644264502;
        Sat, 01 Oct 2022 10:11:04 -0700 (PDT)
Received: from radium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id h40-20020a05600c49a800b003b49ab8ff53sm5817641wmp.8.2022.10.01.10.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 10:11:04 -0700 (PDT)
From:   Fabien Parent <fabien.parent@linaro.org>
To:     ilia.lin@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fabien Parent <fabien.parent@linaro.org>
Subject: [PATCH 3/3] cpufreq: qcom: fix writes in read-only memory region
Date:   Sat,  1 Oct 2022 19:10:27 +0200
Message-Id: <20221001171027.2101923-3-fabien.parent@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221001171027.2101923-1-fabien.parent@linaro.org>
References: <20221001171027.2101923-1-fabien.parent@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes a kernel oops because of a write in some read-only memory:

	[    9.068287] Unable to handle kernel write to read-only memory at virtual address ffff800009240ad8
	..snip..
	[    9.138790] Internal error: Oops: 9600004f [#1] PREEMPT SMP
	..snip..
	[    9.269161] Call trace:
	[    9.276271]  __memcpy+0x5c/0x230
	[    9.278531]  snprintf+0x58/0x80
	[    9.282002]  qcom_cpufreq_msm8939_name_version+0xb4/0x190
	[    9.284869]  qcom_cpufreq_probe+0xc8/0x39c
	..snip..

The following line defines a pointer that point to a char buffer stored
in read-only memory:

	char *pvs_name = PVS_NAME;

This pointer is meant to hold a template "speedXX-pvsXX-vXX" where the
XX values get overridden by the qcom_cpufreq_krait_name_version function. Since
the template is actually stored in read-only memory, when the function
executes the following call we get an oops:

	snprintf(*pvs_name, sizeof(PVS_NAME), "speed%d-pvs%d-v%d",
		 speed, pvs, pvs_ver);

To fix this issue, we instead store the template name onto the stack by
using the following syntax:

	char pvs_name_buffer[] = PVS_NAME;

Because the `pvs_name` needs to be able to be assigned to NULL, the
template buffer is stored in the pvs_name_template and not under the
pvs_name variable.

Signed-off-by: Fabien Parent <fabien.parent@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 64ce077a4848..3e097262f612 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -269,7 +269,8 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
 	struct device *cpu_dev;
-	char *pvs_name = PVS_NAME_TEMPLATE;
+	char pvs_name_buffer[] = PVS_NAME_TEMPLATE;
+	char *pvs_name = pvs_name_buffer;
 	unsigned cpu;
 	const struct of_device_id *match;
 	int ret;
-- 
2.37.2

