Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B06D619EBE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiKDR04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiKDR0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:26:30 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09883E8;
        Fri,  4 Nov 2022 10:26:11 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A4Etdp2032153;
        Fri, 4 Nov 2022 13:26:08 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kmpqjdveg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 13:26:07 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2A4HQ64O060737
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Nov 2022 13:26:06 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 4 Nov 2022
 13:26:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 4 Nov 2022 13:26:05 -0400
Received: from debian.ad.analog.com ([10.48.65.130])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2A4HPnaG015296;
        Fri, 4 Nov 2022 13:25:52 -0400
From:   Ciprian Regus <ciprian.regus@analog.com>
To:     <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ciprian Regus <ciprian.regus@analog.com>
Subject: [PATCH v2 0/2] Add support for the AD5754 DAC
Date:   Fri, 4 Nov 2022 19:23:41 +0200
Message-ID: <20221104172343.617690-1-ciprian.regus@analog.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: m-vuqWvXLUnb4VWKx6-rQQ6isU2wWdyp
X-Proofpoint-ORIG-GUID: m-vuqWvXLUnb4VWKx6-rQQ6isU2wWdyp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040109
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

 .../bindings/iio/dac/adi,ad5754.yaml          | 182 +++++
 MAINTAINERS                                   |   8 +
 drivers/iio/dac/Kconfig                       |  12 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/ad5754.c                      | 647 ++++++++++++++++++
 5 files changed, 850 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml
 create mode 100644 drivers/iio/dac/ad5754.c

-- 
2.30.2

