Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980B266BFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjAPNWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjAPNWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:22:04 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408851556E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:22:03 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bf43so42694897lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Swk5jur/LJSLYDdR06/yq1lTWOWMtwrPemJuvlpFTyc=;
        b=R9n/1F+1Mujr/flg0UOHoTB2j9mreP9lx9d23ApBhQbRRsx7qUMQWmpaxj8baKI5LU
         fgR7s3i3sgDQJnVyI2l1xYpJS0KGgqf0UffPwVx38JgOIqcg+rIHGkchxtjTw8P7kQ6E
         29oz6zeKfGgD2qt7At14f87S+/84ZqkgKGJUWBAzWXkM1rIuRLSSH5yuCsgdzzHAlwUu
         OKUK/V39h0OEMwkyQ6cbA9OXX4pdRIxjpoyGSZlCMdE9PBh+u9qGJBPQF5jqHmyy1Bo+
         tW6XlHgKop0l/lVJ4/tCfVnJiLirN3n78ZZrA8a+eGQZ9yrR7JkC3LWr6Aa68NC5Lg7b
         1DXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Swk5jur/LJSLYDdR06/yq1lTWOWMtwrPemJuvlpFTyc=;
        b=E+yesZ2sB4aQmC5m8wGsQqbiXr3E3CwLuj7mFric8mbD5TJq/A4M6MVZIRMLzVQLX9
         kJjky3GGKhJgk1UkF+huaXdevaNWqSpdMKii8y7wIbrCqZ1u4O1/ueg3Jut0bL07USef
         TJtyvJ5Wm3yb6xBAd1pcTUBCokkz+JMoHiSh/3Xma9qaPkl32Li9XZ1qEmM1v/ChbPZT
         HbSnMAu5diy2yUoDandrc2wfsWia/C7LtkpkqxoRV+B/qSebFmaosVfrqhuK3LwxDyhK
         liFoZoPkVOpIteaZ0BK4sHagAziuZccheTlad4r+ve7FKnMRiVPiHS7hq5TApfCad2nD
         Ll2w==
X-Gm-Message-State: AFqh2krzXVBQ4CskkNzLEuTjUGRfYIF/aSKSpCS3cxJwtN33V9ZeIZAG
        s0WdD/Rf+w4LihykDv7SNa0pJFrssHfbEpft
X-Google-Smtp-Source: AMrXdXszSUd/FJlVyli8K5bPrdpUNeOiT9v9t8V09lXx33j5o1opkJlWym/M4tprQCJNw/8XofcIZQ==
X-Received: by 2002:a05:6512:2348:b0:4b5:1e6c:785c with SMTP id p8-20020a056512234800b004b51e6c785cmr31553528lfu.34.1673875321640;
        Mon, 16 Jan 2023 05:22:01 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id p9-20020a05651212c900b004cc58b91177sm5016653lfg.239.2023.01.16.05.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 05:22:01 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/9] interconnect: qcom: rpm: Always set QoS params on QNoC
Date:   Mon, 16 Jan 2023 14:21:45 +0100
Message-Id: <20230116132152.405535-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116132152.405535-1-konrad.dybcio@linaro.org>
References: <20230116132152.405535-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On newer SoCs, QoS parameters and RPM bandwidth requests are wholly
separate. Setting one should only depend on the description of the
interconnect node and not whether the other is present. If we don't
vote through RPM, QoS parameters should be set regardless, as we're
requesting additional bandwidth by setting the interconnect clock
rates.

With NoC (the old-SoC bus type), this is not the case and they are
mutually exclusive (so, the current upstream logic is correct).

For BIMC however, newer SoCs expect QoS params to be always set
(like QNoC) whereas older ones (like MSM8998) hang up completely when
doing so, hence this will be addressed in the next commit.

The Fixes tag references the commit in which this logic was added, it
has since been shuffled around to a different file, but it's the one
where it originates from.

Fixes: f80a1d414328 ("interconnect: qcom: Add SDM660 interconnect provider driver")
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 385a67c20956..b1337f90c975 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -239,15 +239,27 @@ static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64 sum_bw)
 static int __qcom_icc_set(struct icc_node *n, struct qcom_icc_node *qn,
 			  u64 sum_bw)
 {
+	struct qcom_icc_provider *qp = to_qcom_provider(n->provider);
+	bool vote_ap, vote_rpm;
 	int ret;
 
-	if (!qn->qos.ap_owned) {
-		/* send bandwidth request message to the RPM processor */
+	if (qp->type == QCOM_ICC_QNOC) {
+		vote_ap = true;
+		vote_rpm = true;
+	} else {
+		vote_ap = qn->qos.ap_owned;
+		vote_rpm = !vote_ap;
+	}
+
+	if (vote_rpm) {
+		/* Send bandwidth request message to the RPM processor */
 		ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
 		if (ret)
 			return ret;
-	} else if (qn->qos.qos_mode != -1) {
-		/* set bandwidth directly from the AP */
+	}
+
+	if (vote_ap && qn->qos.qos_mode != NOC_QOS_MODE_INVALID) {
+		/* Set QoS params from the AP */
 		ret = qcom_icc_qos_set(n, sum_bw);
 		if (ret)
 			return ret;
-- 
2.39.0

