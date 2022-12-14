Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D616564CC29
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbiLNO1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238625AbiLNO1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:27:03 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9642035F;
        Wed, 14 Dec 2022 06:27:03 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEEAKXG006834;
        Wed, 14 Dec 2022 09:26:44 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3mf6rn2tpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 09:26:44 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2BEEQhTW004490
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Dec 2022 09:26:43 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 14 Dec 2022 09:26:42 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 14 Dec 2022 09:26:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 14 Dec 2022 09:26:41 -0500
Received: from IST-LT-40003.ad.analog.com (IST-LT-40003.ad.analog.com [10.25.36.26])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2BEEQLNB022112;
        Wed, 14 Dec 2022 09:26:24 -0500
From:   Sinan Divarci <Sinan.Divarci@analog.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sinan Divarci <Sinan.Divarci@analog.com>
Subject: [PATCH v2 0/3] hwmon: Add max31732 quad remote temperature sensor driver
Date:   Wed, 14 Dec 2022 17:22:03 +0300
Message-ID: <20221214142206.13288-1-Sinan.Divarci@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Z_gpXM6Dh7CTwCWZfRFSunwiyub8hfzu
X-Proofpoint-ORIG-GUID: Z_gpXM6Dh7CTwCWZfRFSunwiyub8hfzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_06,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxlogscore=974 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140114
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes in v2:
  - remove Reviewed-by tag

Sinan Divarci (3):
  drivers: hwmon: Add max31732 quad remote temperature sensor driver
  docs: hwmon: add max31732 documentation
  dt-bindings: hwmon: Add bindings for max31732

 .../bindings/hwmon/adi,max31732.yaml          |  83 +++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/max31732.rst              |  62 ++
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/max31732.c                      | 620 ++++++++++++++++++
 6 files changed, 778 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31732.yaml
 create mode 100644 Documentation/hwmon/max31732.rst
 create mode 100644 drivers/hwmon/max31732.c


base-commit: e2ca6ba6ba0152361aa4fcbf6067db71b2c7a770
-- 
2.25.1

