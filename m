Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9665EFF1F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiI2VKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiI2VKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:10:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7CE8C021;
        Thu, 29 Sep 2022 14:09:55 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TKVhOP001222;
        Thu, 29 Sep 2022 21:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=yNZUu2LJdmI9H29m47wzKtJehjZJo5SxjaJa8plhun8=;
 b=OeUNmv0WYhlvdXJCrRKGPB1UyO0Xx3L7HtDtrq0htC3KM2MMNNM0xryluh3ggzEU0TT2
 j+qWTykU3Hq15w1RGvNNTF0kgN+qBV6XTZRc+QhVNKLthQzEHubECqKYxVfp2mZO70r6
 xgPi6odup1ItAOgAHkUTIzpUWAGQxr8ZDwO6dll4u0Fr2/hB8WKr/+o/lZpAppAP19Oh
 UyCzd067uE2EWpYYbm9UfAe+ux5ybVZmbL9f9zZuU4kH6lE9q87lqnh6+SQTZL1VDamL
 Dzfkyaqtw3vpTgcbme1g8gzdWQEDiPD1Nxm679md7Y2Up0TMAPNrhbu4HLpqAw8EA1DY 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwjfshb8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 21:09:41 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28TL1Rad003053;
        Thu, 29 Sep 2022 21:09:41 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwjfshb89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 21:09:41 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28TL6w5m014054;
        Thu, 29 Sep 2022 21:09:40 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 3jsshawkqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 21:09:40 +0000
Received: from smtpav01.dal12v.mail.ibm.com ([9.208.128.133])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28TL9dbv6423050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 21:09:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C5EE5805D;
        Thu, 29 Sep 2022 21:09:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE0F858059;
        Thu, 29 Sep 2022 21:09:37 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.146.111])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 29 Sep 2022 21:09:37 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, joel@jms.id.au,
        dan.carpenter@oracle.com, eajames@linux.ibm.com,
        potin.lai.pt@gmail.com
Subject: [PATCH v7 0/4] leds: pca955x: Add HW blink support
Date:   Thu, 29 Sep 2022 16:09:33 -0500
Message-Id: <20220929210937.253048-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wD9ejJZnCDh7P-vI6dDAHYA5Z7pxSauW
X-Proofpoint-ORIG-GUID: bVP1IJIhsEGgJRc9Tq9wp4vQnixRBBG9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_11,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=789 clxscore=1011 impostorscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for blinking using the PCA955x chip, falling
back to software blinking if another LED on the chip is already blinking
at a different rate, or if the requested rate isn't representable with
the PCA955x.
Also included are some minor clean up and optimization changes that make
the HW blinking a bit easier.

Changes since v6:
 - Fix erroneous return value check of smbus block read

Changes since v5:
 - Use auto-incrementing control register to read all the led selectors
   at once during initialization

Changes since v4:
 - Set duty cycle to fifty percent for blinked LEDs in order to maintain
   the specified blink rate.

Changes since v3:
 - Initialize return value in the blink function
   Thanks Dan Carpenter and kernel test robot

Changes since v2:
 - Split the cleanup patch
 - Prettier dev_err calls
 - Include units for blink period and use defined unit translations
   rather than just a number.
 - Use positive conditionals.

Changes since v1:
 - Rework the blink function to fallback to software blinking if the
   period is out of range of the chip's capabilities or if another LED
   on the chip is already blinking at a different rate.
 - Add the cleanup patch

Eddie James (4):
  leds: pca955x: Refactor with helper functions and renaming
  leds: pca955x: Use pointers to driver data rather than I2C client
  leds: pca955x: Optimize probe led selection
  leds: pca955x: Add HW blink support

 drivers/leds/leds-pca955x.c | 350 ++++++++++++++++++++++++------------
 1 file changed, 239 insertions(+), 111 deletions(-)

-- 
2.31.1

