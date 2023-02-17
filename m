Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D05469A957
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBQKrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjBQKqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:46:53 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4FA63BD5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:46:44 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id d24so1069399lfs.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VjEb3OZ7hQoHWr/0ps/r2NXNgbfLNbJhZAnYy2alS4=;
        b=RP+xeW3syi9Km7CTq3L7nhVDks4S2DbTOI2lP+4X/jcRT5IFLi2jktnqCNAIOQ7EHx
         HYRc2H2SuUpzsvBU7aDbxWp4bjbev60BD0CtZ528nGp3ackWXEP2ZEwDAluwzrenCAhH
         arPeKPdK/YPMKc5PBZM4WJy7YZcLK2QT4JRDATpgclW75I6aUOf9W8Kgen71hZWby0nn
         HFGMDZ8wwuVaBcNUI1Jo1wFvb2lfdj/fKuidkNgcQ8qG2ZPBXP3B/OQc4HS5SD4nxYGX
         wQkkJUhgz4mTMW8y3LBY8dAh81qMgFeTqM0sQxldMArDR0c8ToesYyDiAvCMP9lCXUlG
         OPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VjEb3OZ7hQoHWr/0ps/r2NXNgbfLNbJhZAnYy2alS4=;
        b=NO5JYZpU+Nlb80y+IijSIb+OUPDb83vzYeSJwPa/fQNMeNr4urtNbP5bKJuN2DOZ8I
         wv6F1od9vFY9CWY+jiC6gjeeL2squ9ae7NJROXEbf9VOJVCgT8zw1qbdze8fkiN20KUZ
         sgosGQTP8tQvIaJVKbToblTOUYe7FW157YiOLSlWnIM5aakSysPiHYKrvi5qF+a/3o81
         rPCnkRYyuVzvit2Pqb+UG0ivZIVWWLdU+rJmZINrHKrDEW6h/9Mn5DbPEE1lSUQHTcbT
         XcsBm6SZNsDnUZ31DvnOCtHVrFbWO+KKESM4x4Z7pIlIlmHMpwi82OXtm6gI4gMsKTKc
         Y+7g==
X-Gm-Message-State: AO0yUKXv4NqPyIlDmYNZfngWE96NSvfEbRClFgnl61QySkzsAQlDHj3l
        d0kWUul1/6Sst8r6RVIoGZk8Jw==
X-Google-Smtp-Source: AK7set9hDY73DJqGTveEBX+RQrfn/+Jk2FSuul8+0z1IyNWCWKhD1iARv2I6So/d49Z0RznVb4kDKQ==
X-Received: by 2002:a05:6512:3742:b0:4ce:e95c:f300 with SMTP id a2-20020a056512374200b004cee95cf300mr2744757lfs.39.1676630803110;
        Fri, 17 Feb 2023 02:46:43 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id c13-20020a05651221ad00b004b53eb60e3csm645940lft.256.2023.02.17.02.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:46:42 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 17 Feb 2023 11:46:29 +0100
Subject: [PATCH v5 08/10] interconnect: qcom: msm8996: Specify no bus clock
 scaling on A0NoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-icc-fixes-v5-v5-8-c9a550f9fdb9@linaro.org>
References: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
In-Reply-To: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676630791; l=801;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=AREFOc1ndk8aH4dJx3DJJ2TVqe152RcGq0qoFxsutKs=;
 b=/IKip3wMWAQwdne5uZDTbmC7fQgRWhQBpwBO/KzB4CSDX45GGMGMJZbfAHAKAqfeJXGf9ZvRtBCN
 lAJZ9hKkAnMZxi+p4mhi3toFFuCUOqrbJIzHfIT9EILmY+yQ7kUu
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A0NoC only does bus scaling through RPM votes and does not have any
ICC clocks. Describe this.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/msm8996.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 1a5e0ad36cc4..45eb8675fb11 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -1817,6 +1817,7 @@ static const struct qcom_icc_desc msm8996_a0noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = a0noc_nodes,
 	.num_nodes = ARRAY_SIZE(a0noc_nodes),
+	.num_bus_clocks = -1, /* No bus clock scaling */
 	.intf_clocks = a0noc_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(a0noc_intf_clocks),
 	.has_bus_pd = true,

-- 
2.39.1

