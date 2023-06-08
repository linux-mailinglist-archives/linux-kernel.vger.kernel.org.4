Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A22727864
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjFHHLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjFHHLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:11:20 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E794137;
        Thu,  8 Jun 2023 00:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686208273; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eBCb6uIPvhCwp7IvX1cC2QbipNEm7rAW6z+DvCUVeVphOt8yPEvY6hX5HmQwrALvne
    FwNVdUJUKduQbOxYMYsWq2JMfEUi5S9TtVKqgkeWCsEISy8ScS+wEkSMaElqBkRlH1lY
    NqF1UExPjfDo6HvG/utnxGbKSKCdpiO3wDDqZ7hpacCgATa2R7p/Nu17dcgagvk1uN3z
    jG3R+RhCaUdO4XTDSNOSHAyDF+ZGUQyFplGh1mqDJPoLKaDEQTmDVLfWPpsP5Lt0t25T
    f7uBUWCz/wzy8Ya6aDSaIu41/PrdQCffZH0cE2E8sROM/md2RSxS3D43Mm2+78ubE7jZ
    a3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208273;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=l/8mcRN+TlGYtBCi00HTVZhrkyxZgFaeeP1BtcLCr2U=;
    b=phH3AWtJ2yGumbEmd0U593q8AEeTR644uoRx/kFLLHg6lwXLyccwdiCkRyIPzlWyON
    WuHjbB32Es9z0BaEOGFNbMB7SSi03xG/WUj0HxfCo2T6q0O2knyWfgZl04/R1I3N/RAu
    AXh6prQty3bJaF1A3Y+hjV8UUQmE/D/A9b0wAchBS5yxONsjhBZU7kuIbDJnRyMrWxz8
    ugRJrofVa0CIPVPdNRGD0hnA+d6tzMn3i9UoBhPsOHaj2Xz2oiD/up6v9SKNKYcjWXps
    bMgY43g5+meidmqg2RY2hVkbvM0vaBY6wHpSzauVoyM3/rK0oGZCgWdYKjXIKGY3+tZY
    PKaw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208273;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=l/8mcRN+TlGYtBCi00HTVZhrkyxZgFaeeP1BtcLCr2U=;
    b=bMrOq4xLkJx+oSfulwUCsG3+7+Lv/LOREI91TbvqT/6NHt0knavDlQ5UU6b2IUl/3z
    Is3/pXx8y5cKIn26i4zqm+AjIZJlk8Wwf1XTAJGk1vqF1OR2CxMPk5bsnWoxPq30nG7Z
    5BM2mX2Twfs6lcximlEtFG9i9KLIzLc82MH/eGx1ilbIjkoPbrA7rE1znsicy1OaW1FG
    AhWFPq/x/7hTcKwb5MI5Lp4bb8FWMxJoahQg8fFS1OFaDcuRSud9BzrvuY06p/Uolhua
    27dP15qOKajfWmGDksr/oageWtdDX7T/+wXqxTaGXhkUhCrRuR2x8Bi/klf2lL/YbKuE
    I1sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686208273;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=l/8mcRN+TlGYtBCi00HTVZhrkyxZgFaeeP1BtcLCr2U=;
    b=s+BJ/B/yjlV5tA8tl4etHV9WY7g3nIkMSmlrJBbPNxJj0Dqq1NhzrLm9aEh3W2fokQ
    qikH2sO4WE4fBBDOwEAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z587BDKI0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 8 Jun 2023 09:11:13 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 08 Jun 2023 09:10:27 +0200
Subject: [PATCH v2 07/12] rpmsg: qcom_smd: Use qcom_smem_is_available()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v2-7-56a4a00c8260@gerhold.net>
References: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than looking up a dummy item from SMEM, use the new
qcom_smem_is_available() function to make the code more clear
(and reduce the overhead slightly).

Add the same check to qcom_smd_register_edge() as well to ensure that
it only succeeds if SMEM is already available - if a driver calls the
function and SMEM is not available yet then the initial state will be
read incorrectly and the RPMSG devices might never become available.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/rpmsg/qcom_smd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 7b9c298aa491..43f601c84b4f 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1479,6 +1479,9 @@ struct qcom_smd_edge *qcom_smd_register_edge(struct device *parent,
 	struct qcom_smd_edge *edge;
 	int ret;
 
+	if (!qcom_smem_is_available())
+		return ERR_PTR(-EPROBE_DEFER);
+
 	edge = kzalloc(sizeof(*edge), GFP_KERNEL);
 	if (!edge)
 		return ERR_PTR(-ENOMEM);
@@ -1553,12 +1556,9 @@ EXPORT_SYMBOL(qcom_smd_unregister_edge);
 static int qcom_smd_probe(struct platform_device *pdev)
 {
 	struct device_node *node;
-	void *p;
 
-	/* Wait for smem */
-	p = qcom_smem_get(QCOM_SMEM_HOST_ANY, smem_items[0].alloc_tbl_id, NULL);
-	if (PTR_ERR(p) == -EPROBE_DEFER)
-		return PTR_ERR(p);
+	if (!qcom_smem_is_available())
+		return -EPROBE_DEFER;
 
 	for_each_available_child_of_node(pdev->dev.of_node, node)
 		qcom_smd_register_edge(&pdev->dev, node);

-- 
2.40.1

