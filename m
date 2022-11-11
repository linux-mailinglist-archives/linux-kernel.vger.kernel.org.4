Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4F76259E4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbiKKLyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiKKLyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:54:31 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C1F61B8E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:54:29 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a5so7275620edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCVwunyaKvAdCSc7+ksCaN6h6L9GquZf6jiNJ/6LP7k=;
        b=woOl93F0RydXcCB1h83FNgDeJ8OncI/BW8vFGImGW4/6S/7GFi5LhEUaT5zxeJT8NX
         Pa2uIS8JPQ1UuRDTw1gsr8yNk+B1k8+8vcYuV+J416+/4ZN72i34mJf+rpaYP+XO88Ro
         yOeD1ENrl/hubOCmzmGU/9aRde4Ni5DClG8NTDfkKCbdaSQkVRNzGKdtej8NjJyoXHmi
         pkwCRFNfj2EHnSw7idU9KS0wiOJpIT+9pOtqQqkxmvafW4QNn0c0W9vKp3SBlyw4fju2
         oFG5A/nPDCWoPlX7uD10pgGlb3tRHXfT7y4rJSv1NXebBPpD64Ikh4581/Q5CwH6hyYc
         OzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCVwunyaKvAdCSc7+ksCaN6h6L9GquZf6jiNJ/6LP7k=;
        b=ciNzS3R6yqcLTCCcRgjF4YzYJ9ctPl8WyimEi2Rd2PQci2B2Nc9alFnM+PInNSzoUY
         suNXlwd2pNKctFeYIB5fTVOoypYkDfgep0Z8//I0YjnFvBLSr3v8RjrfG0hgw04AtoIQ
         jWNhE/qUCZVOJcwuwb3wI2FEu+OokxsAP8bghkAnXHyL6Nfabr4w8nAPPn/7Kh+JvQQ+
         IfTm5O2Lio9MWA04mY2IPdq+WSWeM4clS/ZdFB8fxmyzgCH1NfZcsc+b/tGhw3QsgIy+
         y0YYFmLI4kSnzfsNEw5FxvihFa+z4FpMvw4znUmXS+K64a4s+hydSiBpbKNqdM788gil
         F6kg==
X-Gm-Message-State: ANoB5pkrN3ulxjz321CcJhDT/Ir6kVL7hNwXfy78WBBAqr9GAlV/p2UT
        TAfUUUxpFKJcVOxZHgQXmHIA7A==
X-Google-Smtp-Source: AA0mqf4M0ZcLgiTBE35+G/kyXf6GRpwJfYWwoAgBSfNcF+YK0DVIDxpQJeEH19gBVpmnPV62PR8jMQ==
X-Received: by 2002:aa7:d5d4:0:b0:458:e00e:5a85 with SMTP id d20-20020aa7d5d4000000b00458e00e5a85mr1164414eds.171.1668167668306;
        Fri, 11 Nov 2022 03:54:28 -0800 (PST)
Received: from otso.arnhem.chello.nl (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id kz6-20020a17090777c600b007adb86a1e1csm770859ejc.186.2022.11.11.03.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 03:54:27 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] remoteproc: qcom_q6v5_pas: detach power domains on remove
Date:   Fri, 11 Nov 2022 12:54:14 +0100
Message-Id: <20221111115414.153961-2-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111115414.153961-1-luca.weiss@fairphone.com>
References: <20221111115414.153961-1-luca.weiss@fairphone.com>
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

We need to detach from the power domains also on remove, not just on
probe fail so a subsequent probe works as expected.

Otherwise the following error appears on re-probe:

[   29.452005] sysfs: cannot create duplicate filename '/devices/genpd:0:3000000.remoteproc'
[   29.477121] CPU: 1 PID: 483 Comm: sh Tainted: G        W          6.1.0-rc4-00075-g71a113770bda #78
[   29.510319] Hardware name: Fairphone 4 (DT)
[   29.538335] Call trace:
[   29.564470]  dump_backtrace.part.0+0xe0/0xf0
[   29.592602]  show_stack+0x18/0x30
[   29.619616]  dump_stack_lvl+0x64/0x80
[   29.646834]  dump_stack+0x18/0x34
[   29.673541]  sysfs_warn_dup+0x60/0x7c
[   29.700592]  sysfs_create_dir_ns+0xec/0x110
[   29.728057]  kobject_add_internal+0xb8/0x374
[   29.755530]  kobject_add+0x9c/0x104
[   29.782072]  device_add+0xbc/0x8a0
[   29.808445]  device_register+0x20/0x30
[   29.835175]  genpd_dev_pm_attach_by_id+0xa4/0x190
[   29.862851]  genpd_dev_pm_attach_by_name+0x3c/0xb0
[   29.890472]  dev_pm_domain_attach_by_name+0x20/0x30
[   29.918212]  adsp_probe+0x278/0x580
[   29.944384]  platform_probe+0x68/0xc0
[   29.970603]  really_probe+0xbc/0x2dc
[   29.996662]  __driver_probe_device+0x78/0xe0
[   30.023491]  device_driver_attach+0x48/0xac
[   30.050215]  bind_store+0xb8/0x114
[   30.075957]  drv_attr_store+0x24/0x3c
[   30.101874]  sysfs_kf_write+0x44/0x54
[   30.127751]  kernfs_fop_write_iter+0x120/0x1f0
[   30.154448]  vfs_write+0x1ac/0x380
[   30.179937]  ksys_write+0x70/0x104
[   30.205274]  __arm64_sys_write+0x1c/0x2c
[   30.231060]  invoke_syscall+0x48/0x114
[   30.256594]  el0_svc_common.constprop.0+0x44/0xec
[   30.283183]  do_el0_svc+0x2c/0xd0
[   30.308320]  el0_svc+0x2c/0x84
[   30.333059]  el0t_64_sync_handler+0xf4/0x120
[   30.359001]  el0t_64_sync+0x18c/0x190
[   30.384385] kobject_add_internal failed for genpd:0:3000000.remoteproc with -EEXIST, don't try to register things with the same name in the same directory.
[   30.406029] remoteproc remoteproc0: releasing 3000000.remoteproc
[   30.416064] qcom_q6v5_pas: probe of 3000000.remoteproc failed with error -17

Fixes: 17ee2fb4e856 ("remoteproc: qcom: pas: Vote for active/proxy power domains")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index d830bf13c32c..747155c85085 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -573,6 +573,7 @@ static int adsp_remove(struct platform_device *pdev)
 	qcom_remove_sysmon_subdev(adsp->sysmon);
 	qcom_remove_smd_subdev(adsp->rproc, &adsp->smd_subdev);
 	qcom_remove_ssr_subdev(adsp->rproc, &adsp->ssr_subdev);
+	adsp_pds_detach(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
 	rproc_free(adsp->rproc);
 	device_init_wakeup(adsp->dev, false);
 
-- 
2.38.1

