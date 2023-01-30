Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E802681D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjA3WDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjA3WDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:03:50 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D616430B19;
        Mon, 30 Jan 2023 14:03:35 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UKmOXF029358;
        Mon, 30 Jan 2023 22:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=A27Es/cKNMb2PQmhdgO4UIsXSiJyWHxfKgzxZPKXfbs=;
 b=Zegn6obreHGK7BIGk1+x2Gvcn8QDZw5ZKLVglwwxxOpdZ40VgTXsHAX96BF4ohgbFt+Q
 oEqf5IS67tChw+DjeLktzNtEGkizRlXCcKkrhLfR7v+168Yt2wAZyVGHr4cXou1C4Nwj
 dPmMILmcN7jBFgS9w3dkHvEnfPqJhwBwqdTDr2CiEdHmgcmlVlrOn1Z3fldbjN+JXZrm
 ivALOWhKg3pQ12PImJ9Y5J4XWXP7ys9TAmipPQmS4e8YPfiS1onpvg1L4WRUBFmQ7aEr
 ckdc0j6iiTo9W2I94IvABcBGzRnQFIfeg8rC5K64WbXDPJwjz3ZdCQMFGHIp48rU9h+6 sg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3neh1fuqas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 22:03:19 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 2426513194;
        Mon, 30 Jan 2023 22:03:17 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 1A55E806B79;
        Mon, 30 Jan 2023 22:03:15 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     soc@kernel.org, arnd@arndb.de, verdun@hpe.com,
        nick.hawkins@hpe.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/1] ARM: Correct HPE GXP Register ranges
Date:   Mon, 30 Jan 2023 16:00:55 -0600
Message-Id: <20230130220056.14349-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: shxItuureKm-ryzy9TuckhtngJ71ZjBp
X-Proofpoint-ORIG-GUID: shxItuureKm-ryzy9TuckhtngJ71ZjBp
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 spamscore=0 mlxlogscore=890 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300202
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP SoC has a large range of registers. This patch will expand the
registers available to SoC by modifying its device tree file. Initially
this change was planned to be part of a larger set but feedback
indicated it should be submitted separately. In the device tree file
there is a large gap in the ranges of registers available because they
are reserved.

Nick Hawkins (1):
  ARM: dts: hpe: Correct GXP register ranges

 arch/arm/boot/dts/hpe-gxp.dtsi | 41 +++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 21 deletions(-)

-- 
2.17.1

