Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC816AFF7F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCHHL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCHHL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:11:27 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DD3276B9;
        Tue,  7 Mar 2023 23:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=g7Uil
        lpbLCZ74a43HZQuNAEWDSBKIS8fFulvxLObbpw=; b=U5r5QkqCuh3PLO4YAeXMD
        ug2NgASJocDaQ/htJcM699o6ztCNQSAWWFQfelhxGaJBZkHMjeyMV/RxTUOXvNtj
        FdJS+y+DRRwQkjiHYa0qHOEEWDR4OkqNOVWCEAK4T3Xr3jdi1BWSNjdNllMLF5SE
        rixkvRrIpo5QMQVscH8NL8=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wBXdloKNQhkHS8bCg--.35990S2;
        Wed, 08 Mar 2023 15:11:07 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     stanimir.k.varbanov@gmail.com
Cc:     quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] media: venus: fix use after free bug in venus_remove due to race condition
Date:   Wed,  8 Mar 2023 15:11:05 +0800
Message-Id: <20230308071105.2130297-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXdloKNQhkHS8bCg--.35990S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury5ZFWkXrWxWw43WFy5XFb_yoWDCrX_Wa
        4Ygan7ur48Ar1kKr4YkF1rZFy2vrW7Zrn5C3Waqa13u34UJryDArsrCrWxXw1UCw1jyFy7
        WFWDJ347W3sxCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKBT5JUUUUU==
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzg4sU2I0XkTHXQAAsp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in venus_probe, core->work is bound with venus_sys_error_handler, which is
used to handle error. The code use core->sys_err_done to make sync work.
The core->work is started in venus_event_notify.

If we call venus_remove, there might be a unfished work. The core->lock may
be destroyed in venus_remove and used in venus_sys_error_handler.

Fix it by canceling the work first in venus_remove.

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/media/platform/qcom/venus/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 990a1519f968..54ace8bf45e7 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -423,6 +423,7 @@ static int venus_remove(struct platform_device *pdev)
 	struct device *dev = core->dev;
 	int ret;
 
+	cancel_delayed_work(&core->work);
 	ret = pm_runtime_get_sync(dev);
 	WARN_ON(ret < 0);
 
-- 
2.25.1

