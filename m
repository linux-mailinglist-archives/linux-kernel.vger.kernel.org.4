Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35EB60E1AE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiJZNMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiJZNMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:12:34 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE17AFB72A;
        Wed, 26 Oct 2022 06:12:33 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QAews5025621;
        Wed, 26 Oct 2022 09:11:56 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kcac8vfbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 09:11:56 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 29QDBthk021374
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Oct 2022 09:11:55 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 26 Oct
 2022 09:11:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 26 Oct 2022 09:11:54 -0400
Received: from IST-LT-39247.ad.analog.com (IST-LT-39247.ad.analog.com [10.25.16.24])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 29QDBY6l014246;
        Wed, 26 Oct 2022 09:11:37 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/2] drivers: rtc: add max313xx series rtc driver
Date:   Wed, 26 Oct 2022 16:11:22 +0300
Message-ID: <20221026131124.289-1-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: VTRmnLnWg0e49etj_AovKISeG9rWA790
X-Proofpoint-GUID: VTRmnLnWg0e49etj_AovKISeG9rWA790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=575 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260074
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


changelog:
since v2:
  - dtbinding: update title and description
  - dtbinding: remove last example
  - drop watchdog support
  - support reading 12Hr format instead of forcing 24hr at probe time
  - use "tm_year % 100" instead of range check
  - refactor max313xx_init for readability


Ibrahim Tilki (2):
  drivers: rtc: add max313xx series rtc driver
  dt-bindings: rtc: add bindings for max313xx RTCs

 .../devicetree/bindings/rtc/adi,max313xx.yaml |  151 +++
 drivers/rtc/Kconfig                           |   11 +
 drivers/rtc/Makefile                          |    1 +
 drivers/rtc/rtc-max313xx.c                    | 1069 +++++++++++++++++
 4 files changed, 1232 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
 create mode 100644 drivers/rtc/rtc-max313xx.c

-- 
2.25.1

