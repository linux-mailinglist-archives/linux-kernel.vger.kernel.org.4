Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA17F6C72BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjCWWFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCWWFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:05:34 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEA4113C3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:05:33 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230323220530euoutp0231692821bda758f69d0ed88f92ea7c85~PK5rwcc8g0050700507euoutp02k
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:05:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230323220530euoutp0231692821bda758f69d0ed88f92ea7c85~PK5rwcc8g0050700507euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679609130;
        bh=5Lbl5bKgLKPGiIQxLj5SL1DAD29KRyFFElVJqXhN01o=;
        h=From:To:Cc:Subject:Date:References:From;
        b=d5wc0sr+W25PkNPpmFNdZnyVh3Nr9Itmh3kQbP9ts58JQSDrM2jXgmCi4Fv+Q3dg9
         Jx5RilDnbLTW8TfIm39YN0hDHKVwVsbmVJT0KdViipldIYa3MU/l+cHnylGNbLprra
         UllymMbizNnuCtX/mJQpdBJ83iJ4GSS3haGZ8PJM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230323220530eucas1p2844a72b527bddc25652d795d16ae1fc4~PK5rhdLH40921709217eucas1p2I;
        Thu, 23 Mar 2023 22:05:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D6.E4.10014.A2DCC146; Thu, 23
        Mar 2023 22:05:30 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230323220529eucas1p12e5e1bbe2a31fe775cd9e6244f9282ce~PK5rNWmq63056830568eucas1p1d;
        Thu, 23 Mar 2023 22:05:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230323220529eusmtrp21b32b8b32c1e6452ca04811db18af17b~PK5rMmz931308013080eusmtrp2G;
        Thu, 23 Mar 2023 22:05:29 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000271e-3a-641ccd2a1600
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 48.CD.09583.92DCC146; Thu, 23
        Mar 2023 22:05:29 +0000 (GMT)
Received: from AMDC2765.eu.corp.samsungelectronics.net (unknown
        [106.120.51.73]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230323220529eusmtip1f4f067690a3006c03da172c780237ffa~PK5qtHyT41538215382eusmtip1V;
        Thu, 23 Mar 2023 22:05:29 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS
Date:   Thu, 23 Mar 2023 23:05:18 +0100
Message-Id: <20230323220518.3247530-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7paZ2VSDC7sYrM49/g3i8W2DhuL
        qQ+fsFmcXXaQzaJj8nYWi29XOpgsJu4/y25xedccNou1R+6yO3B6zG64yOKxc9Zddo9NqzrZ
        PO5c28Pm0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBnbD11lK+jjqDi7Pb6BsZW9i5GTQ0LA
        RGLD1MMsXYxcHEICKxglFkxbyA7hfGGU2HhmCiuE85lR4m/bKkaYljNLb7NBJJYzSnz/8I4J
        wmllkvg4fxYLSBWbgKFE19suNhBbRIBFYuX372BLmAWuMUn0bdrCDJIQFnCSmLXiMyuIzSKg
        KnHtxBmwq3gF7CWePOhmhlgnL7H/4FlmiLigxMmZT8AWMAPFm7fOZgYZKiGwlkNi+qutLBAN
        LhLL5k5lgrCFJV4d3wL1qozE/53zmSAa2oFe/X0fypnAKNHw/BbUd9YSd879ArqbA2iFpsT6
        XfoQYUeJ7ksnmEDCEgJ8EjfeCkIcwScxadt0Zogwr0RHmxBEtZrErOPr4NYevHAJ6hcPiWXn
        J4BNERKIlZjXojOBUWEWks9mIflsFsIJCxiZVzGKp5YW56anFhvnpZbrFSfmFpfmpesl5+du
        YgQmotP/jn/dwbji1Ue9Q4xMHIyHGCU4mJVEeN2YJVKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ
        82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1MPXPlGtU3Zox+fUD9Xov/7MHn/V++LVoppj5Tu90
        013r1/pbndJWk78b6Kb8JfGmoIzaXJ9pXiu+aFVud1iUKqT1c0nck2NrKnmydLmq3dr36D7f
        29LxbT5nf8LXznnHJsyWebJ0R7lS4MEVgf51BsLzV6Wb55yK3n9U77UoU4qG08VJT7eeihAV
        yt3/MDrVfPWyTg3Dq/Xxc7dffjjjQUzWuj+RbPvTytatPbY3vCliV0f/Xbboj+lSjyV+fPrz
        w1OpxeBBXtSuqdufMlVnRnnMPLxzsgzjyUj3eqMp+//3HMp3yha2T77++tb6qvSQfdducimc
        airfpxGd1Lnubp6G8BnObT/lHnu9C99820uJpTgj0VCLuag4EQAgF5ReswMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsVy+t/xu7qaZ2VSDBZtM7Y49/g3i8W2DhuL
        qQ+fsFmcXXaQzaJj8nYWi29XOpgsJu4/y25xedccNou1R+6yO3B6zG64yOKxc9Zddo9NqzrZ
        PO5c28Pm0bdlFaPH501yAWxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehnbD11lK+jjqDi7Pb6BsZW9i5GTQ0LAROLM0ttsXYxcHEICSxklJl65
        BpWQkTg5rYEVwhaW+HOtC6qomUli2danYEVsAoYSXW9BEpwcIgIsEiu/f2cBKWIWuMckMW/e
        T0aQhLCAk8SsFZ/BJrEIqEpcO3EGrJlXwF7iyYNuZogN8hL7D55lhogLSpyc+YQFxGYGijdv
        nc08gZFvFpLULCSpBYxMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQIjYNuxn1t2MK589VHv
        ECMTB+MhRgkOZiURXjdmiRQh3pTEyqrUovz4otKc1OJDjKZA901klhJNzgfGYF5JvKGZgamh
        iZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA1OvzsmlFY/bg1s0H5zxMa+MvtRw
        wFw3qOLPiYO+zj5/5t7ffsXGQWRKxvMox6kiIvbHnHo//FjBzvyklJnbe9qRt3HmISdC7LP+
        7inWeeqlXlJ7bKPBjNcHbjGJf7RyWMqzYH7/naPXdX6+2zaLITBghWQuM1uw60U/nQo/Cc0s
        Hf7F/5ys550NZ5hz6smBdYdvXjs+I/7DPjWZU6afTiW/sb+f0W8i2vE7LKHtwy7Tc2GB/O+z
        DhYdLv6sKtJZdfkJi+l7jS6t3Cd6HtqO35LfxicG/2+KNRTWC2VcvsKsjfusa7W3rTBXzPLW
        q0xW184w2K0+WJDHlblktVDv2oSbuxbE3/9uo7JzjuHGU0osxRmJhlrMRcWJALO8wC0JAwAA
X-CMS-MailID: 20230323220529eucas1p12e5e1bbe2a31fe775cd9e6244f9282ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230323220529eucas1p12e5e1bbe2a31fe775cd9e6244f9282ce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230323220529eucas1p12e5e1bbe2a31fe775cd9e6244f9282ce
References: <CGME20230323220529eucas1p12e5e1bbe2a31fe775cd9e6244f9282ce@eucas1p1.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore synchronous probing for 'qcom,pm8150-rpmh-regulators' because
otherwise the UFSHC device is not properly initialized on QRB5165-RB5
board.

Fixes: ed6962cc3e05 ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 4.14 and 4.19")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/regulator/qcom-rpmh-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 4826d60e5d95..903032b2875f 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1462,7 +1462,7 @@ MODULE_DEVICE_TABLE(of, rpmh_regulator_match_table);
 static struct platform_driver rpmh_regulator_driver = {
 	.driver = {
 		.name = "qcom-rpmh-regulator",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 		.of_match_table	= of_match_ptr(rpmh_regulator_match_table),
 	},
 	.probe = rpmh_regulator_probe,
-- 
2.34.1

