Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB18F5F1E39
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 19:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJARLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 13:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJARLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 13:11:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F145D5A2DE
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 10:11:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso6747574wmk.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=gTWeyuBeEhL5q970/uX9nPUe0s0gUyxTu1xA+Ah5iEY=;
        b=g2uBr9Pp7Fg69xveOwl6IoppzylYHg7FU3wX/3x9b9enW8WtrSH8jJG8KUxOIZ1vC3
         pj/fRv4vdZv69Gzw5ElJkxGBhmkDMEGX97R27fYIqz0DYuVgBT7NLJjoj1t3kDdM9LQw
         5GZe4hk13JZqO44HGPsxhUE30grWO/3HWoZeHfbPwZATTYGWQc8PmL0ciwYHWPosNrEL
         CEzi7nH3NNFl8ssq+axjQ9f9UDfSjEEjQW+EvCATYo9ydeA0ny4wdXvLwHaexjzFRW+n
         qN8qM0Ah65Zts8b+0dDlan/kcZpdZO10UdON80GiQV9vWCOtk6pxwVWsYwE+Sy/dFbsv
         49xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=gTWeyuBeEhL5q970/uX9nPUe0s0gUyxTu1xA+Ah5iEY=;
        b=q7XYKZlQvZz5aDxhKhxM7Gw+utmitKf9OrySMfhCADg5EFLqLUqFGxx5L1chQ/OByV
         ELK8lGxZ/2zay0MpxKGPPV7zS7zSiA5BI+vhpd1fL2EvJdy2SQ2/6j+zoIYVk5ih0Ctg
         qSg8HMc5SpR0+LeGJl7Qr0e9R1IpCTOvSxZ0cyvdh6k6MUnK5XFWtgzIsRGDX5m9V7wk
         YNA1GdSzAtL5UaS+2Tw+ZqrAyIUal3YC4oF96WQXWIae74YR+q99r5401IxTCKhGC9yw
         8jHmZ7friERY2onXTA8o0B3DJed/qjSKos6OI+W9FJGGgMH+UwwWqJfTjvlxTYb+qvDQ
         qTvQ==
X-Gm-Message-State: ACrzQf1IjAVcXkN/AIqgrApTV1qWP5j3C4BksGKAzcTiN9fy5H79au/V
        HFyhBNBa8o8NRmAlwAmW/lWbBA==
X-Google-Smtp-Source: AMsMyM6PVEI2wRzKAZUo9Jw5t15nBqPVD0/JQK7uj8wZtBbsWSr8KGTkcVdVWHn6vc0IlIiARd7R7Q==
X-Received: by 2002:a7b:ce97:0:b0:3b3:4136:59fe with SMTP id q23-20020a7bce97000000b003b3413659femr2236430wmj.24.1664644261573;
        Sat, 01 Oct 2022 10:11:01 -0700 (PDT)
Received: from radium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id h40-20020a05600c49a800b003b49ab8ff53sm5817641wmp.8.2022.10.01.10.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 10:11:00 -0700 (PDT)
From:   Fabien Parent <fabien.parent@linaro.org>
To:     ilia.lin@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fabien Parent <fabien.parent@linaro.org>
Subject: [PATCH 1/3] cpufreq: qcom: fix memory leak in error path
Date:   Sat,  1 Oct 2022 19:10:25 +0200
Message-Id: <20221001171027.2101923-1-fabien.parent@linaro.org>
X-Mailer: git-send-email 2.37.2
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

If for some reason the speedbin length is incorrect, then there is a
memory leak in the error path because we never free the speedbin buffer.
This commit fixes the error path to always free the speedbin buffer.

Signed-off-by: Fabien Parent <fabien.parent@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 863548f59c3e..3bd38acde4b9 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -213,6 +213,7 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 	int speed = 0, pvs = 0, pvs_ver = 0;
 	u8 *speedbin;
 	size_t len;
+	int ret = 0;
 
 	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
 
@@ -230,7 +231,8 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 		break;
 	default:
 		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto len_error;
 	}
 
 	snprintf(*pvs_name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
@@ -238,8 +240,9 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 
 	drv->versions = (1 << speed);
 
+len_error:
 	kfree(speedbin);
-	return 0;
+	return ret;
 }
 
 static const struct qcom_cpufreq_match_data match_data_kryo = {
-- 
2.37.2

