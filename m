Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B6E62FB97
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242514AbiKRR0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241975AbiKRR0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:26:24 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383FD91510;
        Fri, 18 Nov 2022 09:26:23 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIGLMd2026693;
        Fri, 18 Nov 2022 12:26:20 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kx0p7md4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 12:26:20 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2AIHQJQj018606
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Nov 2022 12:26:19 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 18 Nov 2022 12:26:18 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 18 Nov 2022 12:26:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 18 Nov 2022 12:26:15 -0500
Received: from debian.ad.analog.com ([10.48.65.130])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2AIHPsw2021732;
        Fri, 18 Nov 2022 12:26:00 -0500
From:   Ciprian Regus <ciprian.regus@analog.com>
To:     <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ciprian Regus <ciprian.regus@analog.com>
Subject: [PATCH v3 0/2] Add support for the AD5754 DAC
Date:   Fri, 18 Nov 2022 19:24:05 +0200
Message-ID: <20221118172407.765423-1-ciprian.regus@analog.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: wtFPpxKCSyMHSn21OKNK7nBKCcmNEYBx
X-Proofpoint-GUID: wtFPpxKCSyMHSn21OKNK7nBKCcmNEYBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_04,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180102
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches implement support for the AD5754 DAC (both dual
and quad channel variants).

The AD5724/AD5734/AD5754 are quad, 12-/14-/16-bit, serial
input, voltage output DACs. The devices operate from single-
supply voltages from +4.5 V up to +16.5 V or dual-supply
voltages from ±4.5 V up to ±16.5 V. The input coding is
user-selectable twos complement or offset binary for a bipolar
output (depending on the state of Pin BIN/2sComp), and straight
binary for a unipolar output.

Ciprian Regus (2):
  dt-bindings: iio: dac: add adi,ad5754.yaml
  drivers: iio: dac: Add AD5754 DAC driver

 .../bindings/iio/dac/adi,ad5754.yaml          | 181 +++++
 MAINTAINERS                                   |   8 +
 drivers/iio/dac/Kconfig                       |  12 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/ad5754.c                      | 672 ++++++++++++++++++
 5 files changed, 874 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml
 create mode 100644 drivers/iio/dac/ad5754.c

-- 
2.30.2

