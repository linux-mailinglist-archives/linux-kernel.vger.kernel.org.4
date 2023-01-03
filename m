Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA0B65C515
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbjACRbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237814AbjACRbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:31:11 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DD4D4B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:31:10 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bt23so29943745lfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 09:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9TS4SJ+83/pLOhWHZLdZeC8hyETp6X/nWYIPMtmOR4=;
        b=IkOm6cg4jYOgHWBc6tW60dORhiFerv+60CiD0QP/aXBp99xSxeTJHP0DPza2wff06c
         XDPftLeO6i+f7+0gyK8yjpHzFjfciBPgG9498Xek8cgUWHvmkU0OuaDCFGUPNdVsh1M7
         quk++8SC5kADnH8sBQsWNwc5kDAX796QHWHRr8mg230oSJDQSraYuZutC+63wPPkdi/c
         V1a7dQ7L431jGAN8ch4PWDTB3gM39H3Fz9E9pTfMmk2f88u2KoTf0NBE7ZKykHMv6ZDh
         2FGehtczs1D8bUjJnuO2fAQK6lGE5TGxnBRZiuU17k3DMZWqBR/l+Qet7xxZ5Qdai+wP
         ctMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9TS4SJ+83/pLOhWHZLdZeC8hyETp6X/nWYIPMtmOR4=;
        b=kkdwndXgeivAmLFww8o1EbmexZU3Ey8Da9VdC8XJR15fbh4RhAjgZwwUrFJhkU0iMZ
         6W2MyRx2/yVmj1SWEs4Mp8bTuec6Uz62Ds2JlBRFliBd20gTaYNBbcW51HEuv2BKedyM
         XeKi7Z7xleeySg40Sh54Diy7Y2rPg9QQ0XMKwtsJUetiaRwmdGJzS1bJ3x6k3ol0j9hA
         fsUVoCp9hXg65xkwe2rjWvSO0sr+GKgfF2JpKQx67k7P8h/lK7MYDx1EikqW4YgQobJV
         jpJBHS/wWMUXZ022C3ymOs8mDiMsOWmhjdYgPkAZ2B9TAK36qxq0jwEL2juZ3Ruh+rzy
         PhBg==
X-Gm-Message-State: AFqh2kplFpSSt4P2u78AanLI7loXAsqO9i6TNuoHccfvedckbSVegzk3
        +HtMZT+BmH1VhePHtIr/clZKGQ==
X-Google-Smtp-Source: AMrXdXt367wMkHjBacvL6ur8ofzFOfUBAbSzaFqGrtSVWxM8KYV780i42p9akKybBdRKF8fTQyA0zw==
X-Received: by 2002:ac2:498f:0:b0:4a4:86ff:9562 with SMTP id f15-20020ac2498f000000b004a486ff9562mr13562225lfl.38.1672767068622;
        Tue, 03 Jan 2023 09:31:08 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id o9-20020ac25e29000000b004b4b5da5f80sm4916818lfg.219.2023.01.03.09.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:31:08 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>
Subject: [PATCH 2/4] interconnect: qcom: rpm: Set QoS parameters regardless of RPM bw setting
Date:   Tue,  3 Jan 2023 18:30:57 +0100
Message-Id: <20230103173059.265856-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103173059.265856-1-konrad.dybcio@linaro.org>
References: <20230103173059.265856-1-konrad.dybcio@linaro.org>
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

QoS parameters and RPM bandwidth requests are wholly separate. Setting one
should only depend on the description of the interconnect node and not
whether the other is present. If we vote through RPM, QoS parameters
should be set so that the bus controller can make better decisions.
If we don't vote through RPM, QoS parameters should be set regardless,
as we're requesting additional bandwidth by setting the interconnect
clock rates.

The Fixes tag references the commit in which this logic was added, it
has since been shuffled around to a different file, but it's the one
where it originates from.

Fixes: f80a1d414328 ("interconnect: qcom: Add SDM660 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 06e0fee547ab..a190a0a839c8 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -252,8 +252,10 @@ static int __qcom_icc_set(struct icc_node *n, struct qcom_icc_node *qn,
 		ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
 		if (ret)
 			return ret;
-	} else if (qn->qos.qos_mode != -1) {
-		/* set bandwidth directly from the AP */
+	}
+
+	if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID) {
+		/* Set QoS params from the AP */
 		ret = qcom_icc_qos_set(n, sum_bw);
 		if (ret)
 			return ret;
-- 
2.39.0

