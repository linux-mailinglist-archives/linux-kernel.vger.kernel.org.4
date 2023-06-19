Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DF87356EE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjFSMch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjFSMcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:32:35 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DED91
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:32:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f8775126d3so27817e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687177952; x=1689769952;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kQXXt7p+guLFHPeMdd87LrI9K2HMO9Lr8NPYCPaiaU=;
        b=aUrEmIOqBaZuBpXpLhfXNUlXBrksflmXT1QYahTBgtXnKKN3h2wgQfAEtJ2B/2f1up
         nxsws/gt5wzQ4SlhfAxOSS5bPL3xEWHUruRzq7RO5qcBTgOUH3xWoTP3FwZEMXGtxNgZ
         ciAdYnJwF0L+odYzmRK4hvjDg095odpNHJQoW9sE/Z296NpLCaksgVZjlqGSyLwl8Yaf
         eJp6SLJ1i/7z99XpYkyaGMlsqG/TzOCCGit8f5zy5S76XSMSSt7b0vuET+AOYv/Hoowg
         7/X+4qE5gMohu/byY1ITg0stnrgnjj0meB6gvkWX4jzP3xki1DqEmK3DPmZAVkC6oaBD
         93iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687177952; x=1689769952;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kQXXt7p+guLFHPeMdd87LrI9K2HMO9Lr8NPYCPaiaU=;
        b=ah7tT28kFl3VixVx1rhYqgaZ5EMDZCOb/MPEmxlB+9uC4ZtmvMo8i1y1BVYBRo7TQB
         2HiQlilfwsc/7aXFhyMlaGMSxlT3mP8w4hbmhwtRij/tzRq+zqtYC8r4hIIifCJewZSv
         PFiFfzvEEFBKy7V5yNZnIDKeZRID77c0vjEvNzkK2mzSPXR3RzNagiHPw8ShjT7UUyvd
         zjVjet8YVo/TuFXlqFrGOEtg+lZ+RxHNiHsWceWBuSmGALLg+IvG0QLhJmyOntTpHsTW
         sSTFCa4L5HOQnrL4slt/NIogYBz5acsoEVZszRwAdeZxGWF3jWtgNB2qe6IbuKP9jxNI
         VxGQ==
X-Gm-Message-State: AC+VfDx6k62e86EtBD83iytV9+jutdJ1OtqJ5pis/uDE4aHC8qDSlMOy
        ip3bSMuYtC9C9BNDMPQVWxJc/w==
X-Google-Smtp-Source: ACHHUZ52egGatzVJmcc8tV1/fH13uuqeyMtxMUK+2ORfAoCImdlFMJInTDDxmEGpv640/Hxi7LXvWA==
X-Received: by 2002:ac2:504f:0:b0:4f5:1ac9:ab1b with SMTP id a15-20020ac2504f000000b004f51ac9ab1bmr6076236lfm.23.1687177952284;
        Mon, 19 Jun 2023 05:32:32 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id y27-20020ac2447b000000b004f4c3feb9fbsm4240238lfl.61.2023.06.19.05.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 05:32:31 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 14:32:26 +0200
Subject: [PATCH] soc: qcom: rpmpd: Add sync_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230619-topic-rpmpd_syncstate-v1-1-54f986cf9444@linaro.org>
X-B4-Tracking: v=1; b=H4sIANlKkGQC/x2N0QrCMAwAf2Xk2cBadW7+yhDpuswFZlaaKsrYv
 xt8vIPjNlDKTArXaoNMb1ZexcAdKohzkAchj8bga3+sG9dhWRNHzOmZxrt+JWoJhXBq/KU9dyf
 nWwfWDkEJhxwkzlbLa1lMpkwTf/6z/rbvP9iqYpl8AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687177951; l=2369;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4R5E7B3l629um2WTAAe7o796GIVLmPC9TwVvJNOq4pA=;
 b=u6dNKI9qG7a4/XqA4lcu+SuPwfg6a4CxyLNj4pIXhVfr4Gq0owPzf0Fe164la24Pkuhn8y0Lu
 KF4iXn4AzonBZzBv9kGV6v3A7p7S8XBw13ca1GF6MVLoeg2ZLAOvCfq
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sync_state implementation, very similar to the one already present
in the RPMhPD driver.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 99b017fd76b7..fa58c04214ee 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -58,6 +58,7 @@ struct rpmpd {
 	struct qcom_smd_rpm *rpm;
 	unsigned int max_state;
 	__le32 key;
+	bool state_synced;
 };
 
 struct rpmpd_desc {
@@ -823,7 +824,11 @@ static int rpmpd_aggregate_corner(struct rpmpd *pd)
 	unsigned int this_active_corner = 0, this_sleep_corner = 0;
 	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
 
-	to_active_sleep(pd, pd->corner, &this_active_corner, &this_sleep_corner);
+	/* Clamp to the highest corner/level if sync_state isn't done yet */
+	if (!pd->state_synced)
+		this_active_corner = this_sleep_corner = pd->max_state - 1;
+	else
+		to_active_sleep(pd, pd->corner, &this_active_corner, &this_sleep_corner);
 
 	if (peer && peer->enabled)
 		to_active_sleep(peer, peer->corner, &peer_active_corner,
@@ -973,11 +978,38 @@ static int rpmpd_probe(struct platform_device *pdev)
 	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
 }
 
+static void rpmpd_sync_state(struct device *dev)
+{
+	const struct rpmpd_desc *desc = of_device_get_match_data(dev);
+	struct rpmpd **rpmpds = desc->rpmpds;
+	struct rpmpd *pd;
+	unsigned int i;
+	int ret;
+
+	mutex_lock(&rpmpd_lock);
+	for (i = 0; i < desc->num_pds; i++) {
+		pd = rpmpds[i];
+		if (!pd)
+			continue;
+
+		pd->state_synced = true;
+
+		if (!pd->enabled)
+			pd->corner = 0;
+
+		ret = rpmpd_aggregate_corner(pd);
+		if (ret)
+			dev_err(dev, "failed to sync %s: %d\n", pd->pd.name, ret);
+	}
+	mutex_unlock(&rpmpd_lock);
+}
+
 static struct platform_driver rpmpd_driver = {
 	.driver = {
 		.name = "qcom-rpmpd",
 		.of_match_table = rpmpd_match_table,
 		.suppress_bind_attrs = true,
+		.sync_state = rpmpd_sync_state,
 	},
 	.probe = rpmpd_probe,
 };

---
base-commit: 47045630bc409ce6606d97b790895210dd1d517d
change-id: 20230619-topic-rpmpd_syncstate-f62785941281

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

