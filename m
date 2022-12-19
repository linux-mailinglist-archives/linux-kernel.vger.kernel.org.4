Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9AD6513F1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiLSUaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiLSUaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:30:03 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFE38FF7;
        Mon, 19 Dec 2022 12:29:58 -0800 (PST)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJJPhOe022590;
        Mon, 19 Dec 2022 20:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=7d4LKvikd+ooKmrpAPYCKdHONad1gNp5BFbWsNbwE4w=;
 b=JkV/WlHlSjkEjXWncwoWVz916sMmC++ftw1wJ3Y/+cb+Phbk5cRaK5dlzQnMRvJ3fgrh
 NIMFBY/I/ZbH4nPOzDzc1dM5tMlqpqLU++gAEna9FKuQllLzKNvZdZMuAZEV7GpHuX4m
 jXTD29qfZZ5FhENa+3Zsx9ldXPPOHb1/U6hvOzj3d4awlMAGAUen8iBXw/EfowStoHcQ
 jwawBRz/A8vDm7JnLjXZ7wxtqL7ySpOvdi+UhqS35CmAy54lbwm6O6q7KI+o2wIrqRzb
 gPUjivC7uzBUvmi3aEAofxjvu4o9YKqq+ki9l1bmzp01fvbtAZ0UOTI2p1YHFA303ADn ow== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3mjx3mrdjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 20:29:41 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 054B4807EE5;
        Mon, 19 Dec 2022 20:29:40 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id C9A018064A5;
        Mon, 19 Dec 2022 20:29:38 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org
Cc:     linux-crypto@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 0/3] crypto/rcu: suppress unnecessary CPU stall warnings
Date:   Mon, 19 Dec 2022 14:29:07 -0600
Message-Id: <20221219202910.3063036-1-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AQ5oZzLMWPlrpINPtYIkWDWUZAuTzMDb
X-Proofpoint-ORIG-GUID: AQ5oZzLMWPlrpINPtYIkWDWUZAuTzMDb
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=641
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suppress RCU CPU stall warnings during tcrypt speed tests.

Robert Elliott (3):
  rcu: genericize RCU stall suppression functions
  rcu: print first CPU on expedited stall line
  crypto: tcrypt - suppress RCU stall warnings during speed tests

 .../RCU/Design/Requirements/Requirements.rst  |   6 +-
 Documentation/RCU/stallwarn.rst               |  19 ++-
 arch/parisc/kernel/process.c                  |   2 +-
 crypto/tcrypt.c                               | 113 +++++++++++++++---
 drivers/tty/sysrq.c                           |   4 +-
 include/linux/rcupdate.h                      |   8 +-
 kernel/rcu/rcu.h                              |  11 +-
 kernel/rcu/tree_exp.h                         |  22 ++--
 kernel/rcu/tree_stall.h                       |  18 +--
 kernel/rcu/update.c                           |  11 +-
 10 files changed, 160 insertions(+), 54 deletions(-)

-- 
2.38.1

